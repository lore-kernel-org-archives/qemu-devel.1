Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD2CC43463
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0FF2087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 20:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=panacorp.onmicrosoft.com header.i=@panacorp.onmicrosoft.com header.b="ucJgdHTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0FF2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=panasonic.aero
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ10C-0002Yp-T0
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 16:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=35291cd0ec=david.aghaian@panasonic.aero>)
 id 1kJ0Rx-0000i2-TY; Thu, 17 Sep 2020 16:24:13 -0400
Received: from mail13.panasonic.aero ([199.21.163.153]:53202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=35291cd0ec=david.aghaian@panasonic.aero>)
 id 1kJ0Rv-00013u-Se; Thu, 17 Sep 2020 16:24:13 -0400
Received: from pps.filterd (ppagent-sna03.mascorp.com [127.0.0.1])
 by ppagent-sna03.mascorp.com (8.16.0.42/8.16.0.42) with SMTP id 08HKKZRg026079;
 Thu, 17 Sep 2020 13:24:07 -0700
Received: from mail-sna00a.mascorp.com ([10.139.50.244])
 by ppagent-sna03.mascorp.com with ESMTP id 33k5rfhw18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2020 13:24:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by mail.panasonic.aero (10.139.50.26) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Thu, 17 Sep 2020 13:24:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Px2hFT3/9+B6wb7+NNxLTy7bGbggn141+FT4bmZuwoIgQE4rd58+7yDZ5k4kf2oehKp7wzVqizCipU0bDNijSJR7utpLFxQFewItPyfU156BPWa+P4BD+XXwiRlRCYw42aHa1mxtfFdBDLTwdXEl9sltBa3IMlJX/eOyvUqapHGe4GnkbtH+aBdX8S804FU2ptBL2p1l7e44MrJSnnzKTdnw5GWLp+0iQwP17eNRFfpcTgZdAqFcb/6TS0G6Xb/ZdaJ0B8kEOeXfgfskm5sf8Y3drwVGelJHavPcH9qw5Obk6I+pftHzU3rTRODS7xWZ9NPR9D1kQ6CHuqfpHylkWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JebERAzjc3+XXTQ6KFpraIvIfunZKYH0EFcfROmDNSs=;
 b=SLd/peWcBOdlW6CX74Hk95PnqXeJ/vur9+K/rV/rlVmg6xIO24PZ1im1SyU5n1wHgQ26UHy6i5Yp9vSgYH/di36dphHhxTkPcyOusmfmlZ1VG1SHnIxPJ1ZlGeJGhpIfIWWhEUmwYnzGpj/82L7krAvb3scuyTXMBs3Vc8HaXwdqHTeCCLro7zKikSPTm9JfzOO6RVjsix93TzC341KUEUtd1L14ZLPK3+Gda2aJkc8pClnm1BBzKwmWw85nTjpnYQjoOpTgZCOP4qHQ/QSebh64LqMDzefUU+QBtJT2wcn5hBVBu8s6oA8DdOaZQhOS8XwyN6HwcN5QNgWd7A2KiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=panasonic.aero; dmarc=pass action=none
 header.from=panasonic.aero; dkim=pass header.d=panasonic.aero; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=panacorp.onmicrosoft.com; s=selector1-panacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JebERAzjc3+XXTQ6KFpraIvIfunZKYH0EFcfROmDNSs=;
 b=ucJgdHTcujAhL2S/UwC4t2n5Sbwzm+7D2IRnUpKwQ7wa/02fyEfIb96rBb80dvPwBVtR36+hE9OKUmIFTlYf05aG+3SCHRYwzllkVL4ZonKJ4XKb89ATGVLMeZNuCK4KRwrIaj+VeIMg/qDYTnJmwJJd+IUn9t6G5apPFkafcP8=
Received: from BY5PR10MB4193.namprd10.prod.outlook.com (2603:10b6:a03:202::22)
 by BYAPR10MB2472.namprd10.prod.outlook.com (2603:10b6:a02:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Thu, 17 Sep
 2020 20:24:03 +0000
Received: from BY5PR10MB4193.namprd10.prod.outlook.com
 ([fe80::3c4e:c2d9:f8ed:d7e9]) by BY5PR10MB4193.namprd10.prod.outlook.com
 ([fe80::3c4e:c2d9:f8ed:d7e9%5]) with mapi id 15.20.3391.015; Thu, 17 Sep 2020
 20:24:03 +0000
From: David Aghaian <David.Aghaian@panasonic.aero>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [Qemu-arm] Assigning sd-card to specific SD-bus with Sabrelite
 Machine
Thread-Topic: [Qemu-arm] Assigning sd-card to specific SD-bus with Sabrelite
 Machine
Thread-Index: AQHWjR9QvoXsXm/RpUOqOKQnA64yXKltPk2A//+TE4A=
Date: Thu, 17 Sep 2020 20:24:03 +0000
Message-ID: <5C0C8776-3BDE-4E8D-9A4A-32B4EB6B46EE@panasonic.aero>
References: <3FA3CCC0-72A3-42EB-A12B-7FA0A30E106F@panasonic.aero>
 <CAFEAcA_PFGc2Ka-egqYqzMq0Nu_aRiNUPif0yntg4L56UTi7MQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_PFGc2Ka-egqYqzMq0Nu_aRiNUPif0yntg4L56UTi7MQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=panasonic.aero;
x-originating-ip: [47.157.246.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c0203dc-7283-44f9-4089-08d85b479eb2
x-ms-traffictypediagnostic: BYAPR10MB2472:
x-microsoft-antispam-prvs: <BYAPR10MB247206285768E20F1075E60C923E0@BYAPR10MB2472.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZwKzSYY4kfTs5Yn67TEdbJZvT2XGspZCFMdH/jVBtx1iW6+9Y+P5E4tdOk9B7G5A3vGYJtkPjS+sS+u+OApaNFjHwSbgktQlR8KnfA3VD5ljzy5W7mRQIhjlolp1nN72mfio323qtUfCWWwXRKgHkI64FLBeqA7O7578UwZ7evdFUXblnFhs7bSTVMQgjx0kJR1KIMRcxvEwOyUEuuEl75jmfEkvTL+b/YBUpcNKgcmRZCDOGHWxBdfzvp3NpX2Db7dOu3dt0i2VLoQ7s81+2xciBUtsmTDj+HUQGFHNYPHFrMNdZaFvQv1Umf/beLcIn/jsD8fvXFnfPr6FFVTIVJE3C/R5Gre13mkGD3Q4/RMCTJE/kZu06jpk4FHczWiy
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR10MB4193.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(136003)(39850400004)(366004)(83380400001)(33656002)(71200400001)(66574015)(6916009)(132210200001)(4326008)(5660300002)(36756003)(86362001)(478600001)(2616005)(26005)(186003)(6512007)(2906002)(6506007)(316002)(66946007)(76116006)(8676002)(54906003)(66446008)(64756008)(66556008)(66476007)(6486002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: dkHZiC+yub6PwG1RA2ingyU0nIzS8W+0FcyV0u21h/gKPN4RHMomML3aQEy6Hc9yhXJ3Bxb5B3RxEWM6WgwVnYaGSgJafjPEibR+M5IRqq9cwlOAwitWLEIjVlFbt3AMWNI7ppQpx7KVpOFnZlIJf5/zkAn9+PIMvLa3ytgbX1FBrkYpu+nQpKGRc2yC3THIHLmEkN36fHWPKbE4sAuSZuYPG2CQgUkAKm9fx3qbah87MEDaDQOcAg8Sys8isBw7qZkczr759X30WRWq5++7CH56EN2gHJdzNbHIKyRkWqRfNWOJ1igMI55iTTBECNkCOkrci7okRGxwkCW/njCZkuuYnaBlV5iNQWi2A4Q083z5U3NQ/nB315xuaqUk3EMiXwmg/QIdWvJfMyQPI33gyP6B3kIWjkJF2dKZBI0o2s0O6WTcj4KAcQ4VBtk00IdXAcmOM28sKCUn3fuIornm7wh5dKnHeFWwZzQEN8b1evm5a/K5sfaV930pxDasXgMS9fM+OxytjoPFkD5XIujLYR73fYRQckOAtXU5CIKHhUMutCyaUKITssCPtwAsQ0tr2xQvrAklQgzSZ1qx/IBhMwYLMAkhLZ51T69sdPiejkssLHfY2khfO6QIBLI1GeSN1cF296iTD7uUYlTuSa/wqw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE39C64EF90DAD4B8ED31E499DF4BDF5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4193.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0203dc-7283-44f9-4089-08d85b479eb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 20:24:03.4440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 10bbb247-08df-4ad3-a55e-47be7693b1d1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUYeuzszBluUVeLVr3FNHnVtMOpKH0en5+Bwkt6pU8cI7zBzOozflZhV4K087v22lVCQVP1afD5A4KzRbOpHqxzjDbNgxyUA4/id62vqfQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2472
X-OriginatorOrg: panasonic.aero
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-17_17:2020-09-16,
 2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009170149
Received-SPF: pass client-ip=199.21.163.153;
 envelope-from=prvs=35291cd0ec=david.aghaian@panasonic.aero;
 helo=mail13.panasonic.aero
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 16:24:10
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 17 Sep 2020 16:57:34 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jean-Christophe DUBOIS <jcd@tribudubois.net>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RURJVDogUmVzZW5kaW5nIGFzIHJlcGx5LWFsbA0KDQpIZXkgUGV0ZXIsDQoNCg0KQXBwcmVjaWF0
ZSB0aGUgcHJvbXB0IHJlc3BvbnNlLiBJcyB0aGVyZSBhIHBhcnRpY3VsYXIgcmVhc29uIHdoeSB5
b3Ugd2VyZSBwcm9wb3NpbmcgdGhhdCB0aGUgbW9kaWZpY2F0aW9uIGJlIG1hZGUgdG8gdGhlIGZz
bC1pbXgqIGZpbGVzIGFzIG9wcG9zZWQgdG8gdGhlICJzYWJyZWxpdGUuYyIgZmlsZT8gSSB3YXMg
bG9va2luZyB2ZXJ5IGJyaWVmbHkgYXQgdGhlIGZpbGVzIHlvdSBtZW50aW9uZWQgYW5kIEkgYmVs
aWV2ZSB0aGUgbGluZSB0aGF0IHdvdWxkIGhhdmUgdG8gYmUgYWRkZWQgKGJhc2luZyBpdCBvZmYg
dGhlIHJlZmVyZW5jZSBzb3VyY2UgeW91IHByb3ZpZGVkKSB3b3VsZCBiZToNCg0KDQpJbnNpZGU6
IGZzbC1pbXgyNS5jDQoNCi8qIEFsaWFzIGNvbnRyb2xsZXIgU0QgYnVzIHRvIHRoZSBTb0MgaXRz
ZWxmICovDQpidXNfbmFtZSA9IGdfc3RyZHVwX3ByaW50Zigic2QtYnVzJWQiLCBpKTsNCm9iamVj
dF9wcm9wZXJ0eV9hZGRfYWxpYXMoT0JKRUNUKCZzLT5lc2RoY1tpXSksIGJ1c19uYW1lLCBzZGhj
aSwgInNkLWJ1cyIpOw0KZ19mcmVlKGJ1c19uYW1lKTsNCg0KdG8gYmUgYWRkZWQganVzdCB1bmRl
ciBsaW5lIDI1MSAoZHVyaW5nIGluaXRpYWxpemF0aW9uIG9mIHRoZSBTREhDIGRldmljZXMpLiBJ
IGRvIG5vdCBzZWUgdGhlIHNhbWUgaW5pdGlhbGl6YXRpb24gb2YgU0RIQyBkZXZpY2VzIGZvciB0
aG9zZSBvbmUgb2YgdGhlIGZzbCBmaWxlcyB5b3UgbWVudGlvbmVkIChmc2wtaW14MzEpLg0KDQpC
ZXN0LA0KRGF2aWQNCg0K77u/T24gOS8xNy8yMCwgMTI6NTQgUE0sICJQZXRlciBNYXlkZWxsIiA8
cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPiB3cm90ZToNCg0KICAgIEVYVEVSTkFMIEVNQUlMOiBU
aGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBhIHNlbmRlciBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIFVzZSBjYXV0aW9uIHdoZW4gcmVzcG9uZGluZyB0byByZXF1ZXN0cywgY2xpY2tpbmcg
bGlua3MsIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuDQoNCiAgICAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogICAg
T24gVGh1LCAxNyBTZXAgMjAyMCBhdCAxOToyMSwgRGF2aWQgQWdoYWlhbg0KICAgIDxEYXZpZC5B
Z2hhaWFuQHBhbmFzb25pYy5hZXJvPiB3cm90ZToNCiAgICA+IEhhdmluZyBhIHJlYWwgZGlmZmlj
dWx0IHRpbWUgZGV0ZXJtaW5pbmcgd2hldGhlciBvciBub3QgSSBjYW4gdXNlIHFlbXUgKGFybSkg
d2l0aCB0aGUgU2FicmVsaXRlIG1hY2hpbmUgdHlwZSB0byBiZSBhYmxlIHRvIGFzc2lnbiBhbiBz
ZC1jYXJkIHRvIG9uZSBvZiB0aGUgNCBhdmFpbGFibGUgc2QtYnVzIHNsb3RzLiBDdXJyZW50bHks
IG5vIG1hdHRlciB3aGF0IGNvbWJpbmF0aW9uIG9mIGFyZ3VtZW50cyBJIHByb3ZpZGUsIGl0IHdp
bGwgYWx3YXlzIGZhbGwgb24gdGhlIGZpcnN0IGJ1cyAoc2VlIHNjcmVlbnNob3QpLg0KDQogICAg
PiBJcyB0aGVyZSBhbnkgd2F5IHdpdGggUUVNVSB0byBhdHRhY2ggdGhlIGNhcmQgc3BlY2lmaWNh
bGx5IHRvIHRoZSBsYXN0IHNkLWJ1cyBzbG90PyBJdCBzaG91bGQgYmUgbm90ZWQgSSB3YXMgYWJs
ZSB0byBhY2hpZXZlIHRoZSBleHBlY3RlZCBiZWhhdmlvciBhZnRlciBwYXRjaGluZyBRRU1VIGl0
c2VsZiB3aXRoIHRoZSBmb2xsb3dpbmcgY2hhbmdlIGJ1dCBJ4oCZZCBwcmVmZXIgdG8gbm90IGhh
dmUgdG8gbW9kaWZ5IHRoZSB0b29sIGl0c2VsZi4NCg0KICAgIFRoaXMgb3VnaHQgdG8gd29yaywg
YnV0IEkgdGhpbmsgdGhlcmUgaXMgYSBidWcgaW4gdGhlIFFFTVUgbW9kZWwNCiAgICBvZiB0aGlz
IGJvYXJkIHdoaWNoIG1lYW5zIGl0IGRvZXMgbm90Lg0KDQogICAgPiBkaWZmIHFlbXUtNS4xLjAu
b3JpZy9ody9zZC9zZGhjaS5jIHFlbXUtNS4xLjAvaHcvc2Qvc2RoY2kuYw0KICAgID4gMTMxMWEx
MzEyLDEzMTQNCiAgICA+ID4gICAgIHN0YXRpYyBpbnQgaW5kZXg9MDsNCiAgICA+ID4gICAgIGNo
YXIgbmFtZVs2NF07DQogICAgPiA+ICAgICBzcHJpbnRmKG5hbWUsICJzZC1idXMuJWQiLCBpbmRl
eCsrKTsNCiAgICA+IDEzMTNjMTMxNg0KICAgID4gPCAgICAgICAgICAgICAgICAgICAgICAgICBU
WVBFX1NESENJX0JVUywgREVWSUNFKHMpLCAic2QtYnVzIik7DQogICAgPiAtLS0NCiAgICA+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9TREhDSV9CVVMsIERFVklDRShzKSwgbmFtZSk7
DQoNCiAgICBUaGFua3MgZm9yIHRoZSBzdWdnZXN0ZWQgcGF0Y2ggLS0gdGhpcyB3YXMgYSBiaWcg
Y2x1ZSBhYm91dA0KICAgIHdoYXQgdGhlIHByb2JsZW0gd2FzLg0KDQogICAgc2RoY2kuYyBpc24n
dCByZWFsbHkgdGhlIGJlc3QgcGxhY2UgZm9yIHRoaXMgdG8gYmUgZG9uZSAtLSB0aGlzIGlzDQog
ICAgdGhlIG1vZGVsIG9mIHRoZSBkZXZpY2UgaXRzZWxmLCBhbmQgdGhlIG5hbWUgb2YgdGhlIGJ1
cyBhcyBwYXJ0DQogICAgb2YgdGhlIGRldmljZSBzaG91bGQgYmUgJ3NkLWJ1cycuIFRoZSByaWdo
dCBwbGFjZSB0byBmaXggdGhlDQogICAgYnVnLCBJIHRoaW5rLCBpcyBpbiB0aGUgaHcvYXJtL2Zz
bC1pbXgqLmMgZmlsZXMsIHdoaWNoIGFyZSB0aGUNCiAgICBpbXBsZW1lbnRhdGlvbiBvZiB0aGUg
U29DIG9iamVjdC4gVGhlcmUgd2Ugc2hvdWxkIGJlIGNyZWF0aW5nDQogICAgYWxpYXNlcyBvbiB0
aGUgU29DIGZvciB0aGUgdmFyaW91cyBTRCBidXNlcyAodGhlcmUncyBhbiBleGFtcGxlDQogICAg
b2YgdGhpcyBpbiBody9hcm0veGxueC16eW5xbXAuYyksIGFuZCB0aGUgYWxpYXNlcyBjYW4gYWxs
IGhhdmUNCiAgICBkaWZmZXJlbnQgbmFtZXMgc28gdGhleSdyZSB1c2FibGUgZnJvbSB0aGUgY29t
bWFuZCBsaW5lLg0KDQogICAgdGhhbmtzDQogICAgLS0gUE1NDQoNCg==


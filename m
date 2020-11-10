Return-Path: <SRS0=ixoB=EQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3521C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2020 00:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EAA7206CB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2020 00:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jON0FDMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAA7206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcHRf-0006Vd-Sb
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 19:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kcHQN-0005wJ-0b; Mon, 09 Nov 2020 19:22:15 -0500
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com
 ([40.107.244.87]:62115 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kcHQK-0001d0-6N; Mon, 09 Nov 2020 19:22:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmyA+lNYFDadxPVmPI+WMekJrCHiKRVMFE/ED9ICY4N+df7ZIafG4tatDZC9qnE+Jiki+gpZ3cSCFgs2o1JdEGbIe3YMHoG9pAL3OvMUYKdyN/+prCIyGfl6J01Fjnu99YW43Tl1OkUYItoV6T+W8MGpqM0VeM/EUCK+GBxD5fXUK111GMeqQGRnrryGgmtJk9Bdi9f7IZZUsBCDu2iqQyoUChdwPt/7gdJBxgZfiJAq0Px+E5kVrccYcbHwsOFgdCFonZNII4B5DTSm09rRGOmBfh+lA7L4Ech26VSutMWFnJ6DRZSFoPu4r7Ncn+9cpZgExOi4JoVBYxxFT3tVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa+iayo10sHPHP8hnlSO67IcwouVBuzOSZDT1zXhF2Q=;
 b=hE9zjEOR1/SPr8w/tQ255soGAZvzTtuowRDc3xwXxRZ/MvbD9fbd0nq9OZi7VMLSLDBllkSu2ePxX40A2clgoy85nFPtdZxknYCNrsQUW9LxLbernloz4s+JGAmgeZ/DBNW3jLnaGZDLKWOkjQAo8xbBh5p6n3sz76jcoHB0sK89xU0fJTaOxS2rES/jA2cY5CVfhZP07Hupm7Zp4k9DJSCdcUepdSXVLcmeQ+6KCBqpEKHm+yBt6ccqPEJLImtEhTaJuTUthA67aOU1QCif9GjxNPxq+RGMCbktZ9u33MAm+SVCI+dtKYQqD+7VPCDggknw7pyY3xxVsPH1s5D0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa+iayo10sHPHP8hnlSO67IcwouVBuzOSZDT1zXhF2Q=;
 b=jON0FDMgsVzgrD7QrNYYrPiEe3wbe2/uROWG9FoA8ajI48LycpL7T4vcPkkmlV1doLbhcqTrq1OGcUaF5TRUtnKyoUtYwK57sP7xwBw+9WmvPvuVLKUiFOg+Ef1m5uz/5CRyqs2fJtJVPVJ6HivjyfmjOLsK7hoE2CnqeDZnbWc=
Received: from BY5PR02MB6033.namprd02.prod.outlook.com (2603:10b6:a03:1ff::10)
 by BY5PR02MB6675.namprd02.prod.outlook.com (2603:10b6:a03:203::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 00:22:06 +0000
Received: from BY5PR02MB6033.namprd02.prod.outlook.com
 ([fe80::f5f3:83c4:cc49:d415]) by BY5PR02MB6033.namprd02.prod.outlook.com
 ([fe80::f5f3:83c4:cc49:d415%6]) with mapi id 15.20.3541.022; Tue, 10 Nov 2020
 00:22:06 +0000
From: Joe Komlodi <komlodi@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 1/3] hw/block/m25p80: Fix Numonyx NVCFG DIO and QIO bit
 polarity
Thread-Topic: [PATCH v3 1/3] hw/block/m25p80: Fix Numonyx NVCFG DIO and QIO
 bit polarity
Thread-Index: AQHWs90oDQkYXPhdcEam1mW+Sp8T3qm/32GAgACkAzA=
Date: Tue, 10 Nov 2020 00:22:06 +0000
Message-ID: <BY5PR02MB6033B6C7B38BF98ED8F65584D0E90@BY5PR02MB6033.namprd02.prod.outlook.com>
References: <1604626378-152352-1-git-send-email-komlodi@xilinx.com>
 <1604626378-152352-2-git-send-email-komlodi@xilinx.com>
 <6adfcb31-8f91-5e28-e8a7-a0e1c55e154c@redhat.com>
In-Reply-To: <6adfcb31-8f91-5e28-e8a7-a0e1c55e154c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [76.217.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1272459e-e4c2-4415-6027-08d8850ea7fe
x-ms-traffictypediagnostic: BY5PR02MB6675:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR02MB667506DC1C1751AA564137D8D0E90@BY5PR02MB6675.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:439;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HXaLc9vE+nPsCxt3NmFSof9j5mcxPh5P2n2d/hhAv2PDqp/p4xeevV/YWBIKSJeAmIl90isOHYVWHrpK2BOd7j0n83/QIY/1/ahnbu5jJt8xrbvxPgaJDkkmBgfpt1zWEPmYSPrhO7cmQPFfgWKHw5S33OCFbIJfbUwSOifsjtwnrdvQLApbPRItMTzxSLlpt4mW5nVhKtpK91JIbYeUNK4qfVDeXHzqYQ+gBCuJ7psTrLh9bS/zz4aZFiCVvtMTopyNm33fT52osc4ppAEvXoMs6cLdznY6LZdgOCfqYQCxFhDpPYeOr7GouI4/I3ZQ8ymZNJBRaHTdXauSOnHg0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6033.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(6506007)(64756008)(9686003)(186003)(55016002)(107886003)(71200400001)(26005)(478600001)(53546011)(86362001)(316002)(2906002)(5660300002)(8936002)(7696005)(4326008)(110136005)(52536014)(8676002)(54906003)(66476007)(66446008)(33656002)(76116006)(66946007)(83380400001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: UKUp1L7dEJ8mTTaYuJkslOljGA/7nigTtzOIwNyliMGlGaGWwpu/JPBn+mi3SsmbqDkDSn/0pSjjpWStQSJ9WOKH8TidzWH/XxhBizH2FJFZowAK0oAbhZnQ9KYd2+1+4d9N3tGF4vdsAQQN6Zxr42mzmQkq4tAw64o+4JeJeW8mxQ758sk+LOyWd5WkRcl4luDpTg1Pv/X+6LRaYPj7u1TVsKv4//Yrt7n3+bqk8EA5czaS5BNZ3dQ+fzFoZB84aU1VqsyA3O771NNxH+3YXMbuJ5qoKyz2zek6zA1bQ6A6aIGxx1tXuy7bRGjU1Ipoqt+uEsjhGbOwvJNsAnXG70vcsNGyYNAW5kNA2j/G72s4jMabg9lpB56Cz2xcRjOKgPEObZnFZegLd8sJwoh821Kiu/35R122ktg5dlAF5UkUXzIOOjf1ugwZpPYcgjAd0D1DTF4YXBlxfDRCqO1WjfuRC1IgUb9uUfxyLNdYvIje6AOUsou++1/y9K/6rLwtJXCcV1jNCArxsu0+iDCUE83LBJ9LB/DpuJ9ANuiGBbb3x45NvS6PHMLbN/sfXplWUZ25J3h+iThwMl+7jGtjEme4p+mb4gDMKb4ANp2H/BpkD0gElwRMhdotO13U5hTPiSBFoTtQ6fzKgBozNsVzztgoZmpe+05wukxRCvvfCUzrJHT3AxgTlK5yuBqfNpZTQrugwS37tWBJCEUOyYdzzCswUbahNAYhVPu7di3XSJDxkoL4ujVtvYtMdkIzatEd7RF3CkW9mte0sKXs3bc2szXakcZimbYIcWr3qzdGMJv+eGBBBgR5lEIaWBltacBEUoDBFQgeo7h8NaRqJJTgztyWA81ENRCliN9vHSlJApWL/Z9oTgjLags0PgLUgtEDAGJhRZ6WZpdXGBY0mo3ARA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6033.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1272459e-e4c2-4415-6027-08d8850ea7fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 00:22:06.6687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1X7GjO6lPnco9m6G4QRazLUrhVIO2/jx2Bw12i1TgXKaL5vjbefa+DBJKYkT3U9sYY3h/IEdbDBiwx8wO+9YXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6675
Received-SPF: pass client-ip=40.107.244.87; envelope-from=komlodi@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 19:22:08
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Edgar Iglesias <edgari@xilinx.com>,
 "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGhpbGlwcGUsDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQaGlsaXBw
ZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+IA0KU2VudDogTW9uZGF5LCBOb3Zl
bWJlciA5LCAyMDIwIDY6MjEgQU0NClRvOiBKb2UgS29tbG9kaSA8a29tbG9kaUB4aWxpbnguY29t
PjsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBDw6lkcmljIExlIEdvYXRlciA8Y2xnQGthb2Qub3Jn
PjsgRWRnYXIgSWdsZXNpYXMgPGVkZ2FyaUB4aWxpbnguY29tPg0KQ2M6IEZyYW5jaXNjbyBFZHVh
cmRvIElnbGVzaWFzIDxmaWdsZXNpYUB4aWxpbnguY29tPjsgYWxpc3RhaXJAYWxpc3RhaXIyMy5t
ZTsgcGhpbGlwcGUubWF0aGlldS5kYXVkZUBnbWFpbC5jb207IHFlbXUtYmxvY2tAbm9uZ251Lm9y
ZzsgbXJlaXR6QHJlZGhhdC5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8zXSBody9ibG9j
ay9tMjVwODA6IEZpeCBOdW1vbnl4IE5WQ0ZHIERJTyBhbmQgUUlPIGJpdCBwb2xhcml0eQ0KDQpP
biAxMS82LzIwIDI6MzIgQU0sIEpvZSBLb21sb2RpIHdyb3RlOg0KPiBRSU8gYW5kIERJTyBtb2Rl
cyBzaG91bGQgYmUgZW5hYmxlZCB3aGVuIHRoZSBiaXRzIGluIE5WQ0ZHIGFyZSBzZXQgdG8gMC4N
Cj4gVGhpcyBtYXRjaGVzIHRoZSBiZWhhdmlvciBvZiB0aGUgb3RoZXIgYml0cyBpbiB0aGUgTlZD
RkcgcmVnaXN0ZXIuDQoNCklzIHRoaXMgbWF0ZXJpYWwgZm9yIHRoZSA1LjIgcmVsZWFzZT8NCg0K
W0pvZV0gSWYgcG9zc2libGUsIHllYWguICBPdGhlcndpc2UgaWYgaXQncyB0b28gbGF0ZSBmb3Ig
NS4yIEkgaGF2ZSBubyBwcm9ibGVtcyBwdXNoaW5nIGl0IHRvIGEgbGF0ZXIgcmVsZWFzZS4NClRo
YW5rcyENCkpvZQ0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKb2UgS29tbG9kaSA8a29tbG9kaUB4
aWxpbnguY29tPg0KPiAtLS0NCj4gIGh3L2Jsb2NrL20yNXA4MC5jIHwgNCArKy0tDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2h3L2Jsb2NrL20yNXA4MC5jIGIvaHcvYmxvY2svbTI1cDgwLmMgaW5kZXggDQo+IDQ4
MzkyNWYuLjQyNTVhNmEgMTAwNjQ0DQo+IC0tLSBhL2h3L2Jsb2NrL20yNXA4MC5jDQo+ICsrKyBi
L2h3L2Jsb2NrL20yNXA4MC5jDQo+IEBAIC03ODMsMTAgKzc4MywxMCBAQCBzdGF0aWMgdm9pZCBy
ZXNldF9tZW1vcnkoRmxhc2ggKnMpDQo+ICAgICAgICAgIHMtPmVuaF92b2xhdGlsZV9jZmcgfD0g
RVZDRkdfT1VUX0RSSVZFUl9TVFJFTkdUSF9ERUY7DQo+ICAgICAgICAgIHMtPmVuaF92b2xhdGls
ZV9jZmcgfD0gRVZDRkdfVlBQX0FDQ0VMRVJBVE9SOw0KPiAgICAgICAgICBzLT5lbmhfdm9sYXRp
bGVfY2ZnIHw9IEVWQ0ZHX1JFU0VUX0hPTERfRU5BQkxFRDsNCj4gLSAgICAgICAgaWYgKHMtPm5v
bnZvbGF0aWxlX2NmZyAmIE5WQ0ZHX0RVQUxfSU9fTUFTSykgew0KPiArICAgICAgICBpZiAoIShz
LT5ub252b2xhdGlsZV9jZmcgJiBOVkNGR19EVUFMX0lPX01BU0spKSB7DQo+ICAgICAgICAgICAg
ICBzLT5lbmhfdm9sYXRpbGVfY2ZnIHw9IEVWQ0ZHX0RVQUxfSU9fRU5BQkxFRDsNCj4gICAgICAg
ICAgfQ0KPiAtICAgICAgICBpZiAocy0+bm9udm9sYXRpbGVfY2ZnICYgTlZDRkdfUVVBRF9JT19N
QVNLKSB7DQo+ICsgICAgICAgIGlmICghKHMtPm5vbnZvbGF0aWxlX2NmZyAmIE5WQ0ZHX1FVQURf
SU9fTUFTSykpIHsNCj4gICAgICAgICAgICAgIHMtPmVuaF92b2xhdGlsZV9jZmcgfD0gRVZDRkdf
UVVBRF9JT19FTkFCTEVEOw0KPiAgICAgICAgICB9DQo+ICAgICAgICAgIGlmICghKHMtPm5vbnZv
bGF0aWxlX2NmZyAmIE5WQ0ZHXzRCWVRFX0FERFJfTUFTSykpIHsNCj4gDQoNCg==


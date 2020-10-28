Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEBBC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 23:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63ED206FB
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 23:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="j1wDdz8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63ED206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXugj-0001rJ-H8
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 19:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kXuf7-0001FX-Bn; Wed, 28 Oct 2020 19:15:25 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com
 ([40.107.92.47]:14049 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komlodi@xilinx.com>)
 id 1kXuf3-00071e-QU; Wed, 28 Oct 2020 19:15:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g92DmLtwbHWxdZjdjq3uxLTTYjWx/bL6tJ/JYfoEmJHO0wcjV6zJWFfB7+1cEzVQcJv6bwJ9c73NwZR7DQ9qK0okggqiwINjJqGUXDa2r9MlINAvtv+arbEuwKd/zbB0ujUeFnAtlkpfGihlpogceQydRYks3vDUAuBYRxvkVO/GZuaSCMmW2BnEhMajTH05EKKogzSa0lq9DcyXUOQ/yhT2BnFIVOCWPtugTw3oawiIeu4BQKAHoTkF/0dq7+fikHObTbrbid2NgMwb6t0hrkcl4CClFTEs+2pXUEO7ONy/JnKQXdjCODuv51vBMBU3XOb71VWNoQXYcCNcYq+bFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y1HjbCLNv8NvbF9A3Qlg3opSqYiLp6ZFzL1I524V4M=;
 b=b+IC0ZOv9BS5xcmzYO8g4rYdUBNA3p02+jBvEPax1XHRSALD7ybRtXzJ+YUNjUXXn44Wp5SwYIwayCSITaZ6VyVz63fAc65D7WS6/kz9mW56IIM+k0qrL7AUOnfEsP9dMGYDmILbaHfHhvk+1Eotg64BewtkgdmpWB82D/QNqNcvuOU7hkls8VH1FUGWDQEnZco6tq4ipzlsnwS6UNluRYDwpoG5jIn8o6TLmmyrhYs4XQvuWtk1FZiBN+OjktjzB/lwxDScJLIMMEo/WusY+KtXI0x9OZRGJGZ8avazmkLk6tVc6dlvB3Jetter73Eg3eeIaj8zFXDqpH2WElIsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y1HjbCLNv8NvbF9A3Qlg3opSqYiLp6ZFzL1I524V4M=;
 b=j1wDdz8E1lTh7LNOvhEVHEuE42QrGDls8I4Mi2vnBpEjF5NvmNZLQMbzi77aTIY4tnqnxxOo5MBmMU8PtLNJ30CgbjZrsBOelLic4VbUpqcQrqfOXryEr+Ni3DfwwzxDHDzb6PQ6P60Oh3C3vHBkq11Yj6L9a7+G5OJ6fDm9DBg=
Received: from BY5PR02MB6033.namprd02.prod.outlook.com (2603:10b6:a03:1ff::10)
 by SJ0PR02MB7214.namprd02.prod.outlook.com (2603:10b6:a03:299::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 23:15:18 +0000
Received: from BY5PR02MB6033.namprd02.prod.outlook.com
 ([fe80::f5f3:83c4:cc49:d415]) by BY5PR02MB6033.namprd02.prod.outlook.com
 ([fe80::f5f3:83c4:cc49:d415%6]) with mapi id 15.20.3499.022; Wed, 28 Oct 2020
 23:15:18 +0000
From: Joe Komlodi <komlodi@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 1/1] hw/block/m25p80: Fix Numonyx fast read dummy cycle
 count
Thread-Topic: [PATCH v2 1/1] hw/block/m25p80: Fix Numonyx fast read dummy
 cycle count
Thread-Index: AQHWrLsZuzfUeLeZRUSSilHAl7RPZqmsv4KAgADYlFA=
Date: Wed, 28 Oct 2020 23:15:18 +0000
Message-ID: <BY5PR02MB603372466CB0B05638D270FFD0170@BY5PR02MB6033.namprd02.prod.outlook.com>
References: <1603842220-215321-1-git-send-email-komlodi@xilinx.com>
 <1603842220-215321-2-git-send-email-komlodi@xilinx.com>
 <453e55d5-3433-0865-a902-8851ca563e48@amsat.org>
In-Reply-To: <453e55d5-3433-0865-a902-8851ca563e48@amsat.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82f5dd4c-93eb-4f14-b19c-08d87b9755f7
x-ms-traffictypediagnostic: SJ0PR02MB7214:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR02MB7214BCB1684F3A30356105FBD0170@SJ0PR02MB7214.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CePEWeKiJJZO2KxaePVAXg0fEp/S23y481z2k1KzWvJyy+avqM2V7A+jI2xhE9+pOScc0FDnczsvGS1wqH7ONyySn/t+b+mGu2jNTGYfApZOiLNswFWRmymfShzmvlhYB0rlDtq0EzStpTQ6JzGw0YysjqBO2OA9KFvBJnJzBpXyrhEFswkB9KTJ+VHezBiPKwZE2jgJev1gdI/Rq6LqPP8/KNlK6rZx8keycs8vLNKFlr0OElkgONXmBumBXhGGGtqpmhlqTtAoN43y3Y8QfpDrji0q0IZNInmnADU1TCTAvGisTLyFVzklVVkzsSHDGZsuaHzuULtajEsPywxmSBUi2fc+SSPnFrs4wGxTZrabt1G9a2uTdW5xw4rJHW3foXnPCFO5X5yBvLNnUPoNXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6033.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(2906002)(6506007)(7696005)(4326008)(26005)(186003)(64756008)(66556008)(966005)(76116006)(66946007)(66446008)(66476007)(83380400001)(71200400001)(53546011)(33656002)(86362001)(9686003)(8676002)(55016002)(110136005)(52536014)(316002)(5660300002)(8936002)(478600001)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: eVNLegJsbtj15+WK/kjgWPLDUsrf4nJs28eNdsqcfrz+HXB4BNsWlofImEyX4OwszxLIwj8QVDUR2myh8Zv7K1d+fjTBahbyGvLlSBJuCFhKXztHykvcHfRKc/65bUeypt8EPugvgJ53BhJmaPjWwoqrPGGrZplyL/tG2TSnhkqsbw8P0fXqsbr0Ff3BJm32UoFkX7c6bCl6mM7i2BzlgrFOzHMagGWKd14byyHRHIAaFvFpH34vUiv2ylbCcrqku7y7LKSHHig20VSLHAEGYrm9Y5ji9ZI6zwybfI4NTIDMFzxxxxjrnMqRLcyW33Dv7IATC6BS/o1V4aw+MSpXAnLjYedkujNpo2XlyUTLABeA8syZEB8nR8SH56ieJHcH+fKW+N7gcID0Z9TBX70qUEWspwAQUmmWy/W+CFexCqmxBCyTBCXwRF1olqIo7Efl9Ncv6fT885KHaUMEXfcoc492oeVI0j5aTrycbGDD5S+Cz4mW7mVqtTOtj9eVd7FkyikHhBzRSA/LOmO0QDCgFW7JQ64BnJWv9tc17Be/sOd83eFtQoUo7VbdrvKrROuKkJWacbQTxSIDDVYn26tWISV++N8fKxj++iCs41xqHhyG1WgnDlee+5M9jPAKWsSSg+3jANJapm7zM5P8vHwH7Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6033.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f5dd4c-93eb-4f14-b19c-08d87b9755f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 23:15:18.4110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBk7Gm6kO5gj8e8yJdmJr6Ko53Fn4GIhaa/IzvIeyImudftIXxLfvhPxtWq7kRqtIE3YHgzsebFXaOJFr7T7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7214
Received-SPF: pass client-ip=40.107.92.47; envelope-from=komlodi@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 19:15:19
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
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "alistair@alistair23.me" <alistair@alistair23.me>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGhpbGlwcGUsDQoNCkNvbW1lbnRzIG1hcmtlZCBpbmxpbmUgd2l0aCBbSm9lXQ0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBo
aWxpcHBlLm1hdGhpZXUuZGF1ZGVAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kNClNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyOCwgMjAyMCAyOjI3IEFNDQpU
bzogSm9lIEtvbWxvZGkgPGtvbWxvZGlAeGlsaW54LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9y
Zw0KQ2M6IEZyYW5jaXNjbyBFZHVhcmRvIElnbGVzaWFzIDxmaWdsZXNpYUB4aWxpbnguY29tPjsg
a3dvbGZAcmVkaGF0LmNvbTsgYWxpc3RhaXJAYWxpc3RhaXIyMy5tZTsgcWVtdS1ibG9ja0Bub25n
bnUub3JnOyBtcmVpdHpAcmVkaGF0LmNvbQ0KU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzFdIGh3
L2Jsb2NrL20yNXA4MDogRml4IE51bW9ueXggZmFzdCByZWFkIGR1bW15IGN5Y2xlIGNvdW50DQoN
CkhpIEpvZSwNCg0KT24gMTAvMjgvMjAgMTI6NDMgQU0sIEpvZSBLb21sb2RpIHdyb3RlOg0KPiBO
dW1vbnl4IGNoaXBzIGRldGVybWluZSB0aGUgbnVtYmVyIG9mIGN5Y2xlcyB0byB3YWl0IGJhc2Vk
IG9uIGJpdHMgNzo0IA0KPiBpbiB0aGUgdm9sYXRpbGUgY29uZmlndXJhdGlvbiByZWdpc3Rlci4N
Cj4gDQo+IEhvd2V2ZXIsIGlmIHRoZXNlIGJpdHMgYXJlIDB4MCBvciAweEYsIHRoZSBudW1iZXIg
b2YgZHVtbXkgY3ljbGVzIHRvIA0KPiB3YWl0IGlzDQo+IDEwIG9uIGEgUUlPUiBvciBRSU9SNCBj
b21tYW5kLCBvciA4IG9uIGFueSBvdGhlciBjdXJyZW50bHkgc3VwcG9ydGVkIA0KPiBmYXN0IHJl
YWQgY29tbWFuZC4gWzFdDQo+IA0KPiBbMV0gDQo+IGh0dHBzOi8vd3d3Lm1pY3Jvbi5jb20vLS9t
ZWRpYS9jbGllbnQvZ2xvYmFsL2RvY3VtZW50cy9wcm9kdWN0cy9kYXRhLXMNCj4gaGVldC8gbm9y
LWZsYXNoL3NlcmlhbC1ub3IvbXQyNXEvZGllLXJldi1iL210MjVxX3Fsa3RfdV8wMmdfY2JiXzAu
cGRmDQo+ID9yZXY9OWIxNjdmYmYyYjM2NDVlZmJhNjM4NTk0OWE3MmU0NTMNCg0KUGxlYXNlIHVz
ZSBzaW5nbGUgbGluZSBmb3IgVVJMIChldmVuIGxvbmdlciB0aGFuIDgwIGNoYXJhY3RlcnMpOg0K
aHR0cHM6Ly93d3cubWljcm9uLmNvbS8tL21lZGlhL2NsaWVudC9nbG9iYWwvZG9jdW1lbnRzL3By
b2R1Y3RzL2RhdGEtc2hlZXQvbm9yLWZsYXNoL3NlcmlhbC1ub3IvbXQyNXEvZGllLXJldi1iL210
MjVxX3Fsa3RfdV8wMmdfY2JiXzAucGRmDQoNCk9yIHVzZQ0KDQpEYXRhc2hlZXQ6ICJNVDI1UVUw
MkdDQkIgUmV2LiBIIDA1LzE5IEVOIg0KDQpbSm9lXSBBaCwgc29ycnkgYWJvdXQgdGhhdCwgSSds
bCBwdXQgaXQgYWxsIG9uIG9uZSBsaW5lIGluIHYzLg0KDQo+IFBhZ2UgMzQsIHBhZ2UgMzkgbm90
ZSA1DQoNClRoZSBub3RlIDUgaXMgbm90IHJlc3RyaWN0ZWQgdG8gUUlPUi9RSU9SNCBjb21tYW5k
cywgc28geW91ciBwYXRjaCBzZWVtcyBpbmNvbXBsZXRlLg0KDQpbSm9lXSBSaWdodC4gUmlnaHQg
bm93IGl0J3Mgb25seSBjaGVja2luZyBRSU9SL1FJT1I0IGJlY2F1c2Ugd2UgZG9uJ3QgaGF2ZSBh
IHdheSB0byBwdXQgTnVtb255eCBjaGlwcyBpbiBRSU8gbW9kZSAocy0+cXVhZF9lbmFibGUgPT0g
dHJ1ZSksIGFuZCB3ZSBkb24ndCBtb2RlbCBERFIgY29tbWFuZHMuDQpCZWNhdXNlIG9mIHRob3Nl
IHJlc3RyaWN0aW9ucywgYWxsIHRoZSByZWFkIGNvbW1hbmRzIG5lZWQgOCBjeWNsZXMsIGV4Y2Vw
dCBmb3IgUUlPUi9RSU9SNC4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9lIEtvbWxvZGkgPGtv
bWxvZGlAeGlsaW54LmNvbT4NCj4gLS0tDQo+ICBody9ibG9jay9tMjVwODAuYyB8IDI2ICsrKysr
KysrKysrKysrKysrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9ibG9jay9tMjVwODAuYyBi
L2h3L2Jsb2NrL20yNXA4MC5jIGluZGV4IA0KPiA0ODM5MjVmLi4zMDJlZDlkIDEwMDY0NA0KPiAt
LS0gYS9ody9ibG9jay9tMjVwODAuYw0KPiArKysgYi9ody9ibG9jay9tMjVwODAuYw0KPiBAQCAt
ODIwLDYgKzgyMCwyNiBAQCBzdGF0aWMgdm9pZCByZXNldF9tZW1vcnkoRmxhc2ggKnMpDQo+ICAg
ICAgdHJhY2VfbTI1cDgwX3Jlc2V0X2RvbmUocyk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB1aW50
OF90IG51bW9ueXhfZXh0cmFjdF9jZmdfbnVtX2R1bW1pZXMoRmxhc2ggKnMpIHsNCj4gKyAgICB1
aW50OF90IGN5Y2xlX2NvdW50Ow0KPiArICAgIHVpbnQ4X3QgbnVtX2R1bW1pZXM7DQo+ICsgICAg
YXNzZXJ0KGdldF9tYW4ocykgPT0gTUFOX05VTU9OWVgpOw0KPiArDQo+ICsgICAgY3ljbGVfY291
bnQgPSBleHRyYWN0MzIocy0+dm9sYXRpbGVfY2ZnLCA0LCA0KTsNCg0KQ291bGQgYmUgZWFzaWVy
IHRvIHJldmlldyBhczoNCg0KICAgICAgIG51bV9kdW1taWVzID0gZXh0cmFjdDMyKHMtPnZvbGF0
aWxlX2NmZywgNCwgNCk7DQoNCiAgICAgICBzd2l0Y2ggKHMtPmNtZF9pbl9wcm9ncmVzcykgew0K
ICAgICAgIC8qIG5vdGUgNSBjb21tZW50IC4uLiAqLw0KICAgICAgIGNhc2UgRkFTVF9SRUFEOg0K
ICAgICAgIGNhc2UgLi4uDQogICAgICAgICAgIC8qIGZpZWxkIGVyYXNlZCBvciByZXNldCBpbiBO
VlJBTSAqLw0KICAgICAgICAgICBpZiAoY3ljbGVfY291bnQgPT0gMHgwIHx8IGN5Y2xlX2NvdW50
ID09IDB4Zikgew0KICAgICAgICAgICAgICAgc3dpdGNoIChzLT5jbWRfaW5fcHJvZ3Jlc3MpIHsN
CiAgICAgICAgICAgICAgIGNhc2UgRkFTVF9SRUFEOg0KICAgICAgICAgICAgICAgY2FzZSAuLi46
DQogICAgICAgICAgICAgICAgICAgbnVtX2R1bW1pZXMgPSAxMDsNCiAgICAgICAgICAgICAgICAg
ICBicmVhazsNCiAgICAgICAgICAgICAgIGNhc2UgLi4uOg0KICAgICAgICAgICAgICAgY2FzZSAu
Li46DQogICAgICAgICAgICAgICAgICAgLyogYXNzZXJ0KHMtPnF1YWRfZW5hYmxlKTsgKi8NCiAg
ICAgICAgICAgICAgICAgICBudW1fZHVtbWllcyA9IDg7DQogICAgICAgICAgICAgICAgICAgYnJl
YWs7DQogICAgICAgICAgICAgICBkZWZhdWx0Og0KICAgICAgICAgICAgICAgICAgIHFlbXVfbG9n
X21hc2soR1VFU1RfRVJST1IsIC4uLik7DQogICAgICAgICAgICAgICAgICAgYnJlYWs7DQogICAg
ICAgICAgICAgICB9DQogICAgICAgICAgIH0NCiAgICAgICAgICAgYnJlYWs7DQogICAgICAgZGVm
YXVsdDoNCiAgICAgICAgICAgYnJlYWs7DQogICAgICAgfQ0KDQogICAgICAgcmV0dXJuIG51bV9k
dW1taWVzOw0KDQo+ICsgICAgaWYgKGN5Y2xlX2NvdW50ID09IDB4MCB8fCBjeWNsZV9jb3VudCA9
PSAweDBGKSB7DQo+ICsgICAgICAgIGlmIChzLT5jbWRfaW5fcHJvZ3Jlc3MgPT0gUUlPUiB8fCBz
LT5jbWRfaW5fcHJvZ3Jlc3MgPT0gUUlPUjQpIHsNCj4gKyAgICAgICAgICAgIG51bV9kdW1taWVz
ID0gMTA7DQo+ICsgICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICBudW1fZHVtbWllcyA9
IDg7DQoNCk5vdGUsIHRoaXMgaXMgb25seSB0cnVlIGlmIHMtPnF1YWRfZW5hYmxlLg0KDQpNYXli
ZSBjbGV2ZXIgdG8gdXNlIHRoZSBkdW1iZXN0IGFwcHJvYWNoIGFuZCBjb3B5IHRoZSB0YWJsZS4u
Lg0KDQpzdGF0aWMgdWludDhfdCBudW1vbnl4X2V4dHJhY3RfY2ZnX251bV9kdW1taWVzKEZsYXNo
ICpzKSB7DQogICAgc3RhdGljIGNvbnN0IHVuc2lnbmVkIGR1bW15X2Nsb2NrX2N5Y2xlc1sweDEw
MF1bM10gPSB7DQogICAgICBbRkFTVF9SRUFEXSA9IHs4LCA4LCAxMH0sDQogICAgICAuLi4NCiAg
ICB9Ow0KICAgIHVpbnQ4X3QgbnVtX2R1bW1pZXMgPSBleHRyYWN0MzIocy0+dm9sYXRpbGVfY2Zn
LCA0LCA0KTsNCg0KICAgIGlmIChjeWNsZV9jb3VudCA9PSAweDAgfHwgY3ljbGVfY291bnQgPT0g
MHhmKSB7DQogICAgICAgIG51bV9kdW1taWVzID0gZHVtbXlfY2xvY2tfY3ljbGVzW3MtPmNtZF9p
bl9wcm9ncmVzc11bbW9kZV07DQogICAgfQ0KDQogICAgcmV0dXJuIG51bV9kdW1taWVzOw0KfQ0K
DQpbSm9lXSBJIHRoaW5rIGVpdGhlciB0aGlzIG9yIHRoZSBzd2l0Y2ggc3RhdGVtZW50IHdvdWxk
IHdvcmsgZmluZSwgaXQganVzdCBkZXBlbmRzIGlmIHdlIHdhbnQgdG8gYWRkIGEgd2F5IHRvIHNl
dCBzLT5xdWFkX2VuYWJsZSBhbmQgcy0+ZHVhbF9lbmFibGUgKGRvZXNuJ3QgZXhpc3QgaW4gdGhl
IG1vZGVsKSBmb3IgTnVtb255eCBjaGlwcy4NClRvIGJlIHRoZSBtb3N0IGFjY3VyYXRlLCBpdCBw
cm9iYWJseSB3b3VsZCBiZSBiZXN0IHRvIGFkZCBhIHdheSB0byBlbmFibGUvZGlzYWJsZSBRSU8g
YW5kIERJTyBtb2RlIGZvciBOdW1vbnl4IGNoaXBzLCB0aGVuIGNoYW5nZSB0aGUgY3ljbGVzIG5l
ZWRlZCBhY2NvcmRpbmdseS4NCg0KTGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuDQpUaGFua3Mh
DQpKb2UNCg0KPiArICAgICAgICB9DQo+ICsgICAgfSBlbHNlIHsNCj4gKyAgICAgICAgbnVtX2R1
bW1pZXMgPSBjeWNsZV9jb3VudDsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICByZXR1cm4gbnVtX2R1
bW1pZXM7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB2b2lkIGRlY29kZV9mYXN0X3JlYWRfY21kKEZs
YXNoICpzKSAgew0KPiAgICAgIHMtPm5lZWRlZF9ieXRlcyA9IGdldF9hZGRyX2xlbmd0aChzKTsg
QEAgLTgyOSw3ICs4NDksNyBAQCBzdGF0aWMgDQo+IHZvaWQgZGVjb2RlX2Zhc3RfcmVhZF9jbWQo
Rmxhc2ggKnMpDQo+ICAgICAgICAgIHMtPm5lZWRlZF9ieXRlcyArPSA4Ow0KPiAgICAgICAgICBi
cmVhazsNCj4gICAgICBjYXNlIE1BTl9OVU1PTllYOg0KPiAtICAgICAgICBzLT5uZWVkZWRfYnl0
ZXMgKz0gZXh0cmFjdDMyKHMtPnZvbGF0aWxlX2NmZywgNCwgNCk7DQo+ICsgICAgICAgIHMtPm5l
ZWRlZF9ieXRlcyArPSBudW1vbnl4X2V4dHJhY3RfY2ZnX251bV9kdW1taWVzKHMpOw0KPiAgICAg
ICAgICBicmVhazsNCj4gICAgICBjYXNlIE1BTl9NQUNST05JWDoNCj4gICAgICAgICAgaWYgKGV4
dHJhY3QzMihzLT52b2xhdGlsZV9jZmcsIDYsIDIpID09IDEpIHsgQEAgLTg2OCw3ICs4ODgsNyAN
Cj4gQEAgc3RhdGljIHZvaWQgZGVjb2RlX2Rpb19yZWFkX2NtZChGbGFzaCAqcykNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICk7DQo+ICAgICAgICAgIGJyZWFrOw0KPiAg
ICAgIGNhc2UgTUFOX05VTU9OWVg6DQo+IC0gICAgICAgIHMtPm5lZWRlZF9ieXRlcyArPSBleHRy
YWN0MzIocy0+dm9sYXRpbGVfY2ZnLCA0LCA0KTsNCj4gKyAgICAgICAgcy0+bmVlZGVkX2J5dGVz
ICs9IG51bW9ueXhfZXh0cmFjdF9jZmdfbnVtX2R1bW1pZXMocyk7DQo+ICAgICAgICAgIGJyZWFr
Ow0KPiAgICAgIGNhc2UgTUFOX01BQ1JPTklYOg0KPiAgICAgICAgICBzd2l0Y2ggKGV4dHJhY3Qz
MihzLT52b2xhdGlsZV9jZmcsIDYsIDIpKSB7IEBAIC05MDgsNyArOTI4LDcgDQo+IEBAIHN0YXRp
YyB2b2lkIGRlY29kZV9xaW9fcmVhZF9jbWQoRmxhc2ggKnMpDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICApOw0KPiAgICAgICAgICBicmVhazsNCj4gICAgICBjYXNlIE1B
Tl9OVU1PTllYOg0KPiAtICAgICAgICBzLT5uZWVkZWRfYnl0ZXMgKz0gZXh0cmFjdDMyKHMtPnZv
bGF0aWxlX2NmZywgNCwgNCk7DQo+ICsgICAgICAgIHMtPm5lZWRlZF9ieXRlcyArPSBudW1vbnl4
X2V4dHJhY3RfY2ZnX251bV9kdW1taWVzKHMpOw0KPiAgICAgICAgICBicmVhazsNCj4gICAgICBj
YXNlIE1BTl9NQUNST05JWDoNCj4gICAgICAgICAgc3dpdGNoIChleHRyYWN0MzIocy0+dm9sYXRp
bGVfY2ZnLCA2LCAyKSkgew0KPiANCg0K


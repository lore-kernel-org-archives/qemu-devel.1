Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE577C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A61217F5
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 12:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="uFhIZf78"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A61217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=openvz.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2aiC-00051R-Pc
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 08:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <den@virtuozzo.com>) id 1i2agu-0003zE-4P
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <den@virtuozzo.com>) id 1i2agt-0002gV-1o
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 08:35:16 -0400
Received: from mail-eopbgr20129.outbound.protection.outlook.com
 ([40.107.2.129]:56033 helo=EUR02-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <den@virtuozzo.com>)
 id 1i2agk-0002Tq-CE; Tue, 27 Aug 2019 08:35:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cM+P0GJzicHZSDsCGl2NBd0Yg8+jDIdIFLCR446HNhJ9OeHszys0Vzl5Z2OF+UAnmPkjJvYBzuTGeiXOky2YdNmy0cgmCo+4UQWvTVZoWWNjEH44usSuWTrk+3n7NpbPEI2C9tZ5x6mzqKVEMaxGuOjN17othabbdi674bwmZIvnRk5LdL0ps/OCIIKKY/veX/99sOWD6wgSVbpTH2o2BFLvC/RPalGe2gMwfkbOMgxr/JiE2UMfFw5FNmqVH3HKfrOH5wbF1zzVlZz3pBIqihKCcJqLiKg+mEhduNvPfIq2nCqyEj1BjpVfDN1x11HAFjGQWKCO/LC2lfWGsOHxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/7SQNFjKmgg+ptRP0zRwnYwDVcm5bDtSU6pu6rC8yM=;
 b=D0oV5QsOqmTqU9ehxMRUxeWy7LB+h1a0HE5qZYQ6wUsPi1bjxtI7+p5uJ2TbZDzvUUfSvgZM8nrUaiBh0gAV5bTBv8bbUMrjLpi6fJvjnjYtR7zKQQo0GHtvMm45ahPVvubI3WPXVDkPDgMTvjTJLbjzhNJ5r1+VXXcAs8T6VPWJZvraGZI92H3LUE45Za6aVNWqu7Zc9gBLwBwOoUx+gEDM4lx8JBTLaSBgYBqDvPpvb9uT9kVIoHHJw5b4Rt7kYJRWgAYSAktiR1rjPtUhQSoYEBFBIAtUJOU3cK8NGZ7oYhloeLGmOawDKUbHLggqpJ0Q2IROR+CHCFBPnLGGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none header.from=openvz.org;
 dkim=pass header.d=openvz.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/7SQNFjKmgg+ptRP0zRwnYwDVcm5bDtSU6pu6rC8yM=;
 b=uFhIZf78BNHG30xaCxpDvMHeyOr/A/j02vOEON+MO1koGPOqa3+iuzVivC7tZNH+rceb6RpJ4waN5DG5UeWZBAdp4YEyqwlFlnQdAvDhYOkof9M97MFtlaF/TmMYSef9Mn7U5QsnvELGOvYa0xlluWY3f74+zH3rJ3Ct7bGNHbg=
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com (20.179.40.149) by
 DBBPR08MB4662.eurprd08.prod.outlook.com (10.255.78.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 12:35:02 +0000
Received: from DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::d4a6:baa1:ac47:8e7f]) by DBBPR08MB4250.eurprd08.prod.outlook.com
 ([fe80::d4a6:baa1:ac47:8e7f%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 12:35:01 +0000
From: "Denis V. Lunev" <den@openvz.org>
To: Eric Blake <eblake@redhat.com>, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH] block: workaround for unaligned byte range in fallocate()
Thread-Index: AQHVWRfHbgobFtW18UeToR/zIaI8rKcHqa4AgAdL0IA=
Date: Tue, 27 Aug 2019 12:35:01 +0000
Message-ID: <fb57981d-46f6-69f4-7dd8-350f1501e5ff@openvz.org>
References: <1566498661-53008-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <218c5855-a8dc-df50-23cb-ebd1a1cd259c@redhat.com>
In-Reply-To: <218c5855-a8dc-df50-23cb-ebd1a1cd259c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0261.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::13) To DBBPR08MB4250.eurprd08.prod.outlook.com
 (2603:10a6:10:c2::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=den@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 074710a0-bde3-40c2-2386-08d72aeafaa6
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DBBPR08MB4662; 
x-ms-traffictypediagnostic: DBBPR08MB4662:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR08MB46623F4B009AB0EEC8629CD4B6A00@DBBPR08MB4662.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(979002)(346002)(396003)(376002)(366004)(39840400004)(136003)(189003)(199004)(478600001)(25786009)(2501003)(66066001)(31696002)(31686004)(7736002)(2616005)(305945005)(476003)(486006)(8676002)(66446008)(64756008)(66476007)(81166006)(81156014)(66946007)(66556008)(316002)(14454004)(110136005)(54906003)(71200400001)(8936002)(6486002)(99286004)(2201001)(107886003)(6512007)(53546011)(36756003)(386003)(76176011)(2906002)(71190400001)(6246003)(186003)(42882007)(102836004)(26005)(11346002)(446003)(53936002)(14444005)(5660300002)(52116002)(256004)(6116002)(4326008)(6506007)(229853002)(3846002)(6436002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DBBPR08MB4662;
 H:DBBPR08MB4250.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3P3QuVx2VuI6UZcrdN9wVJj+p1QVuVA564g94l/qdFcay2tvLrw0wHyt05XYkk+mzlnv0hO0NOxnmT9rH+kFQmNDVxF8HHAZnoyb4gPCv3ISfgayvgAPw98/XXcLS/WiGoSvctyw+NFR/JoUR4nlHWOiZTdRy+SoEo1lhN6Z6CguD7682N7G/JVIa//af48DElL+pFQCX6u3NtAaMRqYEEMXI5Oxl5Yyd1Yy3tQAG3sHmpMFhdwXiaW39oWLb6cOeKevjlQCzMRNUMsVvjXlBtD1Wz5UMgqIRl6u6O1dtw9TarRzW3+jfxR8eVig2VMfIOiG7dqqEjBMpu/OuJ/7l1dpfNgTqmvdPziNIECd+Jrbms0VND2F+BT3kOTPFEoor520cQYRrdHK/TXm2MFTqFz/icpAS5s1ALY4q1K8+Ec=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7F0A9755D632F4C82D883BB473450A9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openvz.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 074710a0-bde3-40c2-2386-08d72aeafaa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 12:35:01.5318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxIb8JdJc2nusrtEPMqqdKu1nLY9rF5f9/XFCv1aHlSsLPcI7Rjf/WexSKPU44pJQEroG5GK7gUaZPMYeBO2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4662
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.2.129
Subject: Re: [Qemu-devel] [PATCH] block: workaround for unaligned byte range
 in fallocate()
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gOC8yMi8xOSAxMTowOSBQTSwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gOC8yMi8xOSAxOjMx
IFBNLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+IFJldmVydCB0aGUgY29tbWl0IDExOGY5
OTQ0MmQgJ2Jsb2NrL2lvLmM6IGZpeCBmb3IgdGhlIGFsbG9jYXRpb24gZmFpbHVyZScNCj4+IGFu
ZCBtYWtlIGJldHRlciBlcnJvciBoYW5kbGluZyBmb3IgdGhlIGZpbGUgc3lzdGVtcyB0aGF0IGRv
IG5vdCBzdXBwb3J0DQo+IHMvbWFrZS91c2UvDQo+DQo+PiBmYWxsb2NhdGUoKSBmb3IgdGhlIHVu
YWxpZ25lZCBieXRlIHJhbmdlLiBBbGxvdyBmYWxsaW5nIGJhY2sgdG8gcHdyaXRlDQo+IHMvdGhl
L2FuLw0KPg0KPj4gaW4gY2FzZSBmYWxsb2NhdGUoKSByZXR1cm5zIEVJTlZBTC4NCj4+DQo+PiBT
dWdnZXN0ZWQtYnk6IEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+DQo+PiBTdWdnZXN0ZWQt
Ynk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQW5k
cmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1b3p6by5jb20+DQo+PiAtLS0N
Cj4+IERpc2N1c3NlZCBpbiBlbWFpbCB0aHJlYWQgd2l0aCB0aGUgbWVzc2FnZSBJRA0KPj4gPDE1
NTQ0NzQyNDQtNTUzNjYxLTEtZ2l0LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVv
enpvLmNvbT4NCj4+DQo+PiAgYmxvY2svZmlsZS1wb3NpeC5jIHwgNyArKysrKysrDQo+PiAgYmxv
Y2svaW8uYyAgICAgICAgIHwgMiArLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2ZpbGUtcG9zaXgu
YyBiL2Jsb2NrL2ZpbGUtcG9zaXguYw0KPj4gaW5kZXggZmJlYjAwNi4uMmMyNTRmZiAxMDA2NDQN
Cj4+IC0tLSBhL2Jsb2NrL2ZpbGUtcG9zaXguYw0KPj4gKysrIGIvYmxvY2svZmlsZS1wb3NpeC5j
DQo+PiBAQCAtMTU4OCw2ICsxNTg4LDEzIEBAIHN0YXRpYyBpbnQgaGFuZGxlX2Fpb2NiX3dyaXRl
X3plcm9lcyh2b2lkICpvcGFxdWUpDQo+PiAgICAgIGlmIChzLT5oYXNfd3JpdGVfemVyb2VzKSB7
DQo+PiAgICAgICAgICBpbnQgcmV0ID0gZG9fZmFsbG9jYXRlKHMtPmZkLCBGQUxMT0NfRkxfWkVS
T19SQU5HRSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWlvY2ItPmFpb19v
ZmZzZXQsIGFpb2NiLT5haW9fbmJ5dGVzKTsNCj4+ICsgICAgICAgIGlmIChyZXQgPT0gLUVJTlZB
TCkgew0KPj4gKyAgICAgICAgICAgIC8qDQo+PiArICAgICAgICAgICAgICogQWxsb3cgZmFsbGlu
ZyBiYWNrIHRvIHB3cml0ZSBmb3IgZmlsZSBzeXN0ZW1zIHRoYXQNCj4+ICsgICAgICAgICAgICAg
KiBkbyBub3Qgc3VwcG9ydCBmYWxsb2NhdGUoKSBmb3IgdW5hbGlnbmVkIGJ5dGUgcmFuZ2UuDQo+
IHMvZm9yL2ZvciBhbi8NCj4NCj4+ICsgICAgICAgICAgICAgKi8NCj4+ICsgICAgICAgICAgICBy
ZXR1cm4gLUVOT1RTVVA7DQo+PiArICAgICAgICB9DQo+PiAgICAgICAgICBpZiAocmV0ID09IDAg
fHwgcmV0ICE9IC1FTk9UU1VQKSB7DQo+PiAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICAg
ICAgICAgIH0NCj4+IGRpZmYgLS1naXQgYS9ibG9jay9pby5jIGIvYmxvY2svaW8uYw0KPj4gaW5k
ZXggNTZiYmYxOS4uNThmMDhjZCAxMDA2NDQNCj4+IC0tLSBhL2Jsb2NrL2lvLmMNCj4+ICsrKyBi
L2Jsb2NrL2lvLmMNCj4+IEBAIC0xNTU4LDcgKzE1NTgsNyBAQCBzdGF0aWMgaW50IGNvcm91dGlu
ZV9mbiBiZHJ2X2NvX2RvX3B3cml0ZV96ZXJvZXMoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQo+PiAg
ICAgICAgICAgICAgYXNzZXJ0KCFicy0+c3VwcG9ydGVkX3plcm9fZmxhZ3MpOw0KPj4gICAgICAg
ICAgfQ0KPj4gIA0KPj4gLSAgICAgICAgaWYgKHJldCA8IDAgJiYgIShmbGFncyAmIEJEUlZfUkVR
X05PX0ZBTExCQUNLKSkgew0KPj4gKyAgICAgICAgaWYgKHJldCA9PSAtRU5PVFNVUCAmJiAhKGZs
YWdzICYgQkRSVl9SRVFfTk9fRkFMTEJBQ0spKSB7DQo+PiAgICAgICAgICAgICAgLyogRmFsbCBi
YWNrIHRvIGJvdW5jZSBidWZmZXIgaWYgd3JpdGUgemVyb2VzIGlzIHVuc3VwcG9ydGVkICovDQo+
PiAgICAgICAgICAgICAgQmRydlJlcXVlc3RGbGFncyB3cml0ZV9mbGFncyA9IGZsYWdzICYgfkJE
UlZfUkVRX1pFUk9fV1JJVEU7DQo+PiAgDQo+Pg0KPiBSZXZpZXdlZC1ieTogRXJpYyBCbGFrZSA8
ZWJsYWtlQHJlZGhhdC5jb20+DQo+DQpSZXZpZXdlZC1ieTogRGVuaXMgVi4gTHVuZXYgPGRlbkBv
cGVudnoub3JnPg0K


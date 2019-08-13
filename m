Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2BBC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41EE20679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 09:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PSQ7RF1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41EE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxTDl-0006V3-3j
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 05:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxTB7-00027F-CY
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxTB6-00068n-0n
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 05:33:17 -0400
Received: from mail-eopbgr70113.outbound.protection.outlook.com
 ([40.107.7.113]:43680 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxTB5-000689-H0; Tue, 13 Aug 2019 05:33:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cg7960PXrllOIMhs/DH5XTX1jt+cxX1C6Ss6WTXdqNUBpBNayG7PnlE3hBsGLGWhRD3fp95lTn9pqeBQkR72lNR33YxazOTjQ0MFw2CCMxycAMivUButtKV9oBgafZjgbsLNVWESLRPiC01lXffXND1ufc27h9wcQ2DtTjJDAstopVSp1RF7Q79j6EH6bQo0K/wUqnOEOMWUysDO/1twaeYSRKdUWwlSXerc+yhTjoudBTg1Syx9fP8PQJurquSB/qh1c4xVHGi3q9rX9wz3mBwQnHdlD5+vSmMMpEP1rMaXc9B/Pancs5Fyf7hnzq1PJjNj5oa4+v8wZoQwodERgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs8kIEy9XQdwW3w5yGRqy7H82BjCuNHUd5BaucUUxv0=;
 b=gDo7rTlK0pjrnv8qQ303govp8e73iku+zVNmi/BcF0RhSzpSe49VbTF6UI/zcYtxTXwtGxySUzmxAM9gcVyO3QCmoEOWX95B29D9CvglVh5i3/FkcrnmkJmQMnXS1vaRMekFGJp4jRcTKzddksOG13fRR+HKzUQB+Ykblqqbi4qrk3SMdUPi0pP0F4aVMImpcXeledLge1NX6+VrYkyKXkrtHBa+e5DhffI/HDrlAA4l6ji4gjOK/ClkLI8EPYkk92W9niAnsWjXPr7z84kisxT0BGVSOqXVnuKzNjhApL4LNAH8UKKDFESyitvzDDI6wnuZ/fcwsTQ95pOGSX5onA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs8kIEy9XQdwW3w5yGRqy7H82BjCuNHUd5BaucUUxv0=;
 b=PSQ7RF1B5QaxAvGeddkgvx0iKmpbhYyy915Lx6p0KjBF+0prBBGWZrlW9l9BQC2IGC7NuS+f703a11BYVd1YyDJH0w7IFchq58scrCCqUzOYTWKAkXdw9t6kt3tq8/6nO0QeS1q4vUViDSDWkFF9JaD48LvnhlXRN5Dts+8tY3s=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4026.eurprd08.prod.outlook.com (20.179.10.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.23; Tue, 13 Aug 2019 09:33:11 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 09:33:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 0/2] deal with BDRV_BLOCK_RAW
Thread-Index: AQHVUTlscGMEUismPEagfLbq4nW+tab36tGAgAABHQCAANb8gIAABheAgAAIyIA=
Date: Tue, 13 Aug 2019 09:33:11 +0000
Message-ID: <43fb7754-6f94-00f6-6172-70cbb53e787c@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <35b23140-25d5-627e-7a86-4b50fbc5be52@redhat.com>
 <e53a0399-f051-52bd-49e8-4ac4dbf2596f@redhat.com>
 <3d5fcc5b-cdb0-f028-1ea2-af85850db20e@virtuozzo.com>
 <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
In-Reply-To: <15cf7372-826a-0684-d6ad-90deea36959e@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0047.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::15) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813123309454
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 163f9c58-225b-4fd7-5ec5-08d71fd141f2
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:DB8PR08MB4026; 
x-ms-traffictypediagnostic: DB8PR08MB4026:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB40264266E929A011693740A7C1D20@DB8PR08MB4026.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(39850400004)(346002)(396003)(376002)(52314003)(189003)(199004)(53754006)(102836004)(81156014)(8676002)(53546011)(52116002)(76176011)(11346002)(2616005)(446003)(476003)(386003)(6506007)(26005)(186003)(6436002)(6116002)(36756003)(3846002)(99286004)(229853002)(6486002)(2906002)(316002)(2501003)(81166006)(6306002)(54906003)(110136005)(6512007)(8936002)(4326008)(31696002)(25786009)(86362001)(107886003)(6246003)(66066001)(5660300002)(31686004)(53936002)(486006)(64756008)(66446008)(7736002)(305945005)(66556008)(66476007)(66946007)(14444005)(256004)(14454004)(71190400001)(71200400001)(966005)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4026;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HRvGKaqM//uzF3ELPtw0SYrGf1zXhg6EGpg9VdGT4YCVEdviyniyNkLtP09/Nc0m5xh/K4mwBTnrxO8RyhfVmVp8Onhf77ivbCjKV3GRzXRcRGOtCEZDStiiMIaA8WXgV5IlWNWJAzRdZVcvLaQrtlWch8y0utQIOHOam/CWUFneQGdE8W46NxaQ5+4CamtMNU/yXqILDD/OFTujKFTgC/gSnk1s7MiIwd6/TQr6CnUYIqX5/hT/vwY+WHfr2yNUnmyBuSRMgv/NVqt0CIx6Qb1PGtCAaMOfH8ZiQ9I9mC4LpRDj9O/b9IKKpHxv8sIMyzNLRsGLGaMVkbbSPeaQnMQVRXl57N/Ley6GsWYJXhh4u9iqZEV3JKIWe1fUlTsOWLeBlQUQ8Lt0xFDBKzxeLUv7T5zDiBVqniDqf81MMDk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EED2B1F9413BDB42815066E270F9B61E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163f9c58-225b-4fd7-5ec5-08d71fd141f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 09:33:11.2974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qG+9VGNXtMB3ItAUITgmbaqQ856kRkgIVOqdaybZ83bUOZ2ILBSJe0NA0eV9R2WftdTlhnuVq0Gsq0zgOe+PbfKs3pA6STXZvRC9cR1owd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4026
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.113
Subject: Re: [Qemu-devel] [PATCH 0/2] deal with BDRV_BLOCK_RAW
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAxMjowMSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTMuMDguMjAxOSAxMTozOSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+
IDEyLjA4LjIwMTkgMjI6NTAsIE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAxMi4wOC4xOSAyMTo0
NiwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+PiBPbiAxMi4wOC4xOSAyMDoxMSwgVmxhZGltaXIgU2Vt
ZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+IEhpIGFsbCENCj4+Pj4+DQo+Pj4+PiBJJ20g
bm90IHN1cmUsIGlzIGl0IGEgYnVnIG9yIGEgZmVhdHVyZSwgYnV0IHVzaW5nIHFjb3cyIHVuZGVy
IHJhdyBpcw0KPj4+Pj4gYnJva2VuLiBJdCBzaG91bGQgYmUgZWl0aGVyIGZpeGVkIGxpa2UgSSBw
cm9wb3NlIChieSBNYXgncyBzdWdnZXN0aW9uKQ0KPj4+Pj4gb3Igc29tZWhvdyBmb3JiaWRkZW4g
KGp1c3QgZm9yYmlkIGJhY2tpbmctZmlsZSBzdXBwb3J0aW5nIG5vZGUgdG8gYmUNCj4+Pj4+IGZp
bGUgY2hpbGQgb2YgcmF3LWZvcm1hdCBub2RlKS4NCj4+Pj4NCj4+Pj4gSSBhZ3JlZSwgSSB0aGlu
ayBvbmx5IGZpbHRlcnMgc2hvdWxkIHJldHVybiBCRFJWX0JMT0NLX1JBVy4NCj4+Pj4NCj4+Pj4g
KEFuZCBub3QgZXZlbiB0aGVtLCB0aGV5IHNob3VsZCBqdXN0IGJlIGhhbmRsZWQgdHJhbnNwYXJl
bnRseSBieQ0KPj4+PiBiZHJ2X2NvX2Jsb2NrX3N0YXR1cygpLsKgIEJ1dCB0aGF04oCZcyBzb21l
dGhpbmcgZm9yIGxhdGVyLikNCj4+Pj4NCj4+Pj4+IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNr
aXkgKDIpOg0KPj4+Pj4gwqDCoCBibG9jay9yYXctZm9ybWF0OiBzd2l0Y2ggdG8gQkRSVl9CTE9D
S19EQVRBIHdpdGggQkRSVl9CTE9DS19SRUNVUlNFDQo+Pj4+PiDCoMKgIGlvdGVzdHM6IHRlc3Qg
bWlycm9yaW5nIHFjb3cyIHVuZGVyIHJhdyBmb3JtYXQNCj4+Pj4+DQo+Pj4+PiDCoCBibG9jay9y
YXctZm9ybWF0LmPCoMKgwqDCoMKgwqDCoMKgIHzCoCAyICstDQo+Pj4+PiDCoCB0ZXN0cy9xZW11
LWlvdGVzdHMvMjYzwqDCoMKgwqAgfCA0NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4+Pj4gwqAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI2My5vdXQgfCAxMiArKysrKysr
KysrDQo+Pj4+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXDCoMKgIHzCoCAxICsNCj4+Pj4+
IMKgIDQgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+
Pj4gwqAgY3JlYXRlIG1vZGUgMTAwNzU1IHRlc3RzL3FlbXUtaW90ZXN0cy8yNjMNCj4+Pj4+IMKg
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMvMjYzLm91dA0KPj4+Pg0KPj4+
PiBUaGFua3MsIGFwcGxpZWQgdG8gbXkgYmxvY2stbmV4dCBicmFuY2g6DQo+Pj4+DQo+Pj4+IGh0
dHBzOi8vZ2l0LnhhbmNsaWMubW9lL1hhbkNsaWMvcWVtdS9jb21taXRzL2JyYW5jaC9ibG9jay1u
ZXh0DQo+Pj4NCj4+PiBPb3BzLCBtYXliZSBub3QuwqAgMjIxIG5lZWRzIHRvIGJlIGFkanVzdGVk
Lg0KPj4+DQo+Pg0KPj4NCj4+IEhtbSB5ZXMsIEkgZm9yZ2V0IHRvIHJ1biB0ZXN0cy4uIEFyZWFz
IHdoaWNoIHdlcmUgemVybyBiZWNvbWVzIGRhdGF8emVybywgaXQNCj4+IGRvbid0IGxvb2sgZ29v
ZC4NCj4+DQo+PiBTbywgaXQncyBub3QgcXVpdGUgcmlnaHQgdG8gcmVwb3J0IERBVEEgfCBSRUNV
UlNFLCB3ZSBhY3R1YWxseSBzaG91bGQgcmVwb3J0DQo+PiBEQVRBX09SX1pFUk8gfCBSRUNVUlNF
LCB3aGljaCBpcyBhY3R1YWxseSBBTExPQ0FURUQgfCBSRUNVUlNFLCBhcyBvdGhlcndpc2UNCj4+
IERBVEEgd2lsbCBiZSBzZXQgaW4gZmluYWwgcmVzdWx0IChnZW5lcmljIGxheWVyIG11c3Qgbm90
IGRyb3AgaXQsIG9idmlvdXNseSkuDQo+Pg0KPj4gQUxMT0NBVEVEIG5ldmVyIHJldHVybmVkIGJ5
IGRyaXZlcnMgYnV0IHNlZW1zIGl0IHNob3VsZCBiZS4gSSdsbCB0aGluayBhIGJpdCBhbmQNCj4+
IHJlc2VuZCBzb21ldGhpbmcgbmV3Lg0KPj4NCj4+DQo+IA0KPiANCj4gSG1tbS4uIFNvLCB3ZSBo
YXZlIHJhdyBub2RlLCBhbmQgYXNzdW1lIGJhY2tpbmcgY2hhaW4gdW5kZXIgaXQuIHdobyBzaG91
bGQgbG9vcCB0aHJvdWdoIGl0LA0KPiBnZW5lcmljIGNvZGUgb3IgcmF3IGRyaXZlcj8NCj4gDQo+
IE5vdyBpdCBhbGwgbG9va3MgbGlrZSBnZW5lcmljIGNvZGUgaXMgcmVzcG9uc2libGUgZm9yIGxv
b3BpbmcgdGhyb3VnaCBmaWx0ZXJlZCBjaGFpbiAoYmFja2luZyBmaWxlcw0KPiBhbmQgZmlsdGVy
cykgYW5kIGRyaXZlciBpcyByZXNwb25zaWJsZSBmb3IgYWxsIGl0J3MgY2hpbGRyZW4gZXhjZXB0
IGZvciBmaWx0ZXJlZCBjaGlsZC4NCj4gDQo+IE9yLCBkcml2ZXIgbWF5IHJldHVybiBzb21ldGhp
bmcgdGhhdCBzYXlzIHRvIGdlbmVyaWMgY2hpbGQgdG8gaGFuZGxlIHRoZSB3aG9sZSBiYWNraW5n
IGNoYWluIG9mIHJldHVybmVkDQo+IGZpbGUgYXQgb25jZSwgYXMgaXQncyBhbm90aGVyIGJhY2tp
bmcgY2hhaW4uIEFuZCBzZWVtcyBldmVuIFJFQ1VSU0UgZG9uJ3Qgd29yayBjb3JyZWN0bHkgYXMg
aXQgZG9lc24ndCBoYW5kbGUNCj4gdGhlIGJhY2tpbmcgY2hhaW4gaW4gdGhpcyByZWN1cnNpb24u
IFdoeSBpdCB3b3JrcyBiZXR0ZXIgdGhhbiBSQVcgLSBqdXN0IGJlY2F1c2Ugd2UgcmV0dXJuIGl0
IHRvZ2V0aGVyDQo+IHdpdGggREFUQSBmbGFncyBhbmQgdGhpcyBEQVRBIGZsYWcgaXMga2VwdCBh
bnl3YXksIGluZGVwZW5kZW50bHkgb2YgZmluZGluZyB6ZXJvcyBvciBub3QuDQo+IA0KPiANCg0K
DQpIbW0sIHNvLCBpcyBpdCBjb3JyZWN0IHRoYXQgd2UgcmV0dXJuIERBVEEgfCBSRUNVUlNFLCBp
ZiB3ZSBhcmUgbm90IHJlYWxseSBzdXJlIHRoYXQgaXQgaXMgZGF0YT8NCg0KSWYgd2Ugc2VlIGF0
DQoNCiAgKiBCRFJWX0JMT0NLX0RBVEE6IGFsbG9jYXRpb24gZm9yIGRhdGEgYXQgb2Zmc2V0IGlz
IHRpZWQgdG8gdGhpcyBsYXllcg0KDQpzZWVtcyBsaWtlIHdlIHNob3VsZCByZXBvcnQgREFUQSBv
bmx5IGlmIHRoZXJlIGlzIGFsbG9jYXRpb24uLg0KDQogICogREFUQSBaRVJPIE9GRlNFVF9WQUxJ
RA0KICAqICB0ICAgIHQgICAgICAgIHQgICAgICAgc2VjdG9ycyByZWFkIGFzIHplcm8sIHJldHVy
bmVkIGZpbGUgaXMgemVybyBhdCBvZmZzZXQNCiAgKiAgdCAgICBmICAgICAgICB0ICAgICAgIHNl
Y3RvcnMgcmVhZCBhcyB2YWxpZCBmcm9tIGZpbGUgYXQgb2Zmc2V0DQogICogIGYgICAgdCAgICAg
ICAgdCAgICAgICBzZWN0b3JzIHByZWFsbG9jYXRlZCwgcmVhZCBhcyB6ZXJvLCByZXR1cm5lZCBm
aWxlIG5vdA0KDQpzbywgWkVSTyBhbG9uZSBkb2Vzbid0IGd1YXJhbnRlZSB0aGF0IHdlIG1heSBz
YWZlbHkgcmVhZD8NCg0KU28sIGZvciBxY293MiBtZXRhZGF0YS1wcmVhbGxvY2F0ZWQgaW1hZ2Vz
LCB3aGF0IGFib3V0IHplcm8taW5pdD8gV2UgcmVwb3J0IERBVEEsIGFuZCBwcm9iYWJseSBnZXQg
WkVSTyBmcm9tDQpmaWxlIGFuZCBoYXZlIGZpbmFsbHkgREFZQSB8IFpFUk8gd2hpY2ggZ3VhcmFu
dGVlcyB0aGF0IHJlYWQgd2lsbCByZXR1cm4gemVyb3MsIGJ1dCBpcyBpdCB0cnVlPw0KDQpGaW5h
bGx5LCB3aGF0ICJEQVRBIiBtZWFuPyBUaGF0IHNwYWNlIGlzIGFsbG9jYXRlZCBhbmQgb2NjdXBp
ZXMgZGlzayBzcGFjZT8gT3IgaXQgb25seSAgbWVhbnMgb25seSBBTExPQ0FURUQgaS5lLg0KInJl
YWQgZnJvbSB0aGlzIGxheWVyLCBub3QgZnJvbSBiYWNraW5nIiBvdGhlcndpc2UsIGFuZCBhZGRz
IGFkZGl0aW9uYWwgbWVhbmluZyB0byBaRVJPIHdoZW4gdXNlZCB0b2dldGhlciwgdGhhdA0KcmVh
ZCB3aWxsIHJldHVybiB6ZXJvcyBmb3Igc3VyZT8NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFk
aW1pcg0K


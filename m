Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5997EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1894620674
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 09:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Rmg52uED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1894620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXj4v-00013U-87
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 04:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXj2p-0008El-BG
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXj2n-0002bt-Pa
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 04:46:34 -0500
Received: from mail-eopbgr130108.outbound.protection.outlook.com
 ([40.107.13.108]:53638 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXj2n-0002aq-IF; Thu, 21 Nov 2019 04:46:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPwRoF+ZZwer18GXNtNs9FTft7T7V5fMpit7gBc8zGtRsaNFQJfhg86+8aNLwi4g36uXTN+h1GGh9v537An28l9hyaq++WAvVsEt4ASb9xaGaGHCmvcGJditd/JiFz89SxmonsJ0Z7Fen/nAEK9afzx6QwSZP1Y+YwCcAj84/UPMSSGUkmBBOJkc5i6xYuemOFi/UEeNc4UXmureFrbUWAttG8BI4jVCqjptUOsxs4cGyn4x3u7RmkOv5gUGVd3dH2LGB8SxZXfqAWxQzC0QeONdwT8QrY8Y9/OdJNbY3h2XYriF1rt/c/zEOk4ri5h6oG9By7dO7dY6QCo5mUKzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0BVqgMPH2xdMGbt4LWll49rcXUrjrZ7dxYVfd/9PXE=;
 b=HgQ+5nC9aDnoPxlY1WmuOFEKhn3EpcqoUOcS0AjNrFKMNgSu1aO09CA5mVidUqQZOJ9pB78iE7804eX7GRvoqIgVWod1RtT0+VJv4fmDFVUsH5atuvRvA7f0jdh4VWWmDpEIHvx4ouxs+OZKIY5SN5YweutV+O/8Y7+QocJFCM9r8OXHsiwd3ruu/lKL2J+V3pfaBEdUuLYcPU9fSEvA0k5vudAW81J+XrZlW/JGA7JMJRB6EdmdEKrsSOTI3bFKDf5JBupQCmM2UPwUnTqei6QdhUQnaB2ogWtIAUK7xM90ZSUU2eSAJtiUXJMSaKsHuVIf9KDWmSwxJKCe4c4lYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0BVqgMPH2xdMGbt4LWll49rcXUrjrZ7dxYVfd/9PXE=;
 b=Rmg52uEDt+00N4gmEmDtA94xrVK8b8WsBvq3QFPqbVVvu2XzMUwJapw8aEwQ0jw11CCDYUcLoZNER7IkEwvkK7EH+DWNA9VTVIEaOeNM+IvAKc3jZYI+Z28FKYIvu8J6z5SXQ68kUB9eagHczZZk7xbjhEMvin+P/a9I4zqy2X8=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4707.eurprd08.prod.outlook.com (10.255.96.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 21 Nov 2019 09:46:30 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 09:46:30 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v2 2/6] block: truncate: Don't make backing file data
 visible
Thread-Topic: [PATCH v2 2/6] block: truncate: Don't make backing file data
 visible
Thread-Index: AQHVn9KsDoqj+3qcT0WZv4nmJYFMzqeVVGuAgAANBwA=
Date: Thu, 21 Nov 2019 09:46:30 +0000
Message-ID: <31d4fe80-315a-de24-983a-31e6c4e2bd19@virtuozzo.com>
References: <20191120184501.28159-1-kwolf@redhat.com>
 <20191120184501.28159-3-kwolf@redhat.com>
 <c53f6f2d-2451-2fb3-cbf0-2a1a686cccf5@redhat.com>
In-Reply-To: <c53f6f2d-2451-2fb3-cbf0-2a1a686cccf5@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::42) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191121124628708
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6b27cad-633c-46ab-01b3-08d76e67af79
x-ms-traffictypediagnostic: AM6PR08MB4707:
x-microsoft-antispam-prvs: <AM6PR08MB47076BCAF4F908874B6F24F0C14E0@AM6PR08MB4707.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39830400003)(346002)(136003)(396003)(376002)(199004)(189003)(256004)(99286004)(54906003)(110136005)(31686004)(8676002)(316002)(8936002)(6116002)(81166006)(81156014)(3846002)(71200400001)(71190400001)(4326008)(2906002)(6436002)(6486002)(229853002)(6246003)(66066001)(6512007)(2616005)(14454004)(36756003)(5660300002)(53546011)(31696002)(6506007)(386003)(26005)(86362001)(186003)(102836004)(11346002)(446003)(64756008)(66476007)(66446008)(25786009)(66556008)(305945005)(66946007)(478600001)(7736002)(52116002)(76176011)(2501003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4707;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DNvtcO0yKDnbRszTei3HGTSj8OFdWgTvfo0txAhFzSJfhLxBwnS+k+QacEGWB2uP+/CUlyCrpd6h44B1sIN6JcGl9Vfvqj9FiExCHlcCJ0/3Kyu7/AHf3chXZZebXzGHDxhXDGVu0totyH0uwRwUEPotzcPiqMWTnLPZFLmaw+c37D/sBo9ZOLcIWr7Dt48LkL87RWh2JfzTTjmAYvGfG0HfplcBU+Z558cAV49I4x1Ga0AckBI6mI1Azm2g+Scz94UiOmy0/63cYEMhhHMXXBi7lFdSTgcNsadSwWJgHO9ymmDM+nixQn8xHBi03KelnS37O+0hcuPJoDUyiJ4jSZOm/ANYuGoLeGYkGo7r8KFxFerdOw5TDggcOKzlQCUdtGipSmZkQyMAPUz9oHoa/uWtOpjql1gIlczUVYzgG6xFkHViWmKvFdO7kb43ZLQB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <88F7A806B7BAC34CA1DB57D615A95948@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b27cad-633c-46ab-01b3-08d76e67af79
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 09:46:30.3033 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /v5eGi/8ClkJTJWuKSnR0U3Js384trompTNgPAskhkYXeBibPUbV7lPQjX8sFR48yKNVMonuigdpzahXg/RbTGwt9KkYeMgeO5qbf31kpQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4707
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.108
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjEuMTEuMjAxOSAxMTo1OSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyMC4xMS4xOSAxOTo0NCwg
S2V2aW4gV29sZiB3cm90ZToNCj4+IFdoZW4gZXh0ZW5kaW5nIHRoZSBzaXplIG9mIGFuIGltYWdl
IHRoYXQgaGFzIGEgYmFja2luZyBmaWxlIGxhcmdlciB0aGFuDQo+PiBpdHMgb2xkIHNpemUsIG1h
a2Ugc3VyZSB0aGF0IHRoZSBiYWNraW5nIGZpbGUgZGF0YSBkb2Vzbid0IGJlY29tZQ0KPj4gdmlz
aWJsZSBpbiB0aGUgZ3Vlc3QsIGJ1dCB0aGUgYWRkZWQgYXJlYSBpcyBwcm9wZXJseSB6ZXJvZWQg
b3V0Lg0KPj4NCj4+IENvbnNpZGVyIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW8gd2hlcmUgdGhlIG92
ZXJsYXkgaXMgc2hvcnRlciB0aGFuIGl0cw0KPj4gYmFja2luZyBmaWxlOg0KPj4NCj4+ICAgICAg
YmFzZS5xY293MjogICAgIEFBQUFBQUFBDQo+PiAgICAgIG92ZXJsYXkucWNvdzI6ICBCQkJCDQo+
Pg0KPj4gV2hlbiByZXNpemluZyAoZXh0ZW5kaW5nKSBvdmVybGF5LnFjb3cyLCB0aGUgbmV3IGJs
b2NrcyBzaG91bGQgbm90IHN0YXkNCj4+IHVuYWxsb2NhdGVkIGFuZCBtYWtlIHRoZSBhZGRpdGlv
bmFsIEFzIGZyb20gYmFzZS5xY293MiB2aXNpYmxlIGxpa2UNCj4+IGJlZm9yZSB0aGlzIHBhdGNo
LCBidXQgemVyb3Mgc2hvdWxkIGJlIHJlYWQuDQo+Pg0KPj4gQSBzaW1pbGFyIGNhc2UgaGFwcGVu
cyB3aXRoIHRoZSB2YXJpb3VzIHZhcmlhbnRzIG9mIGEgY29tbWl0IGpvYiB3aGVuIGFuDQo+PiBp
bnRlcm1lZGlhdGUgZmlsZSBpcyBzaG9ydCAoLSBmb3IgdW5hbGxvY2F0ZWQpOg0KPj4NCj4+ICAg
ICAgYmFzZS5xY293MjogICAgIEEtQS1BQUFBDQo+PiAgICAgIG1pZC5xY293MjogICAgICBCQi1C
DQo+PiAgICAgIHRvcC5xY293MjogICAgICBDLS1DLS1DLQ0KPj4NCj4+IEFmdGVyIGNvbW1pdCB0
b3AucWNvdzIgdG8gbWlkLnFjb3cyLCB0aGUgZm9sbG93aW5nIGhhcHBlbnM6DQo+Pg0KPj4gICAg
ICBtaWQucWNvdzI6ICAgICAgQ0ItQzAwQzAgKGNvcnJlY3QgcmVzdWx0KQ0KPj4gICAgICBtaWQu
cWNvdzI6ICAgICAgQ0ItQy0tQy0gKGJlZm9yZSB0aGlzIGZpeCkNCj4+DQo+PiBXaXRob3V0IHRo
ZSBmaXgsIGJsb2NrcyB0aGF0IHByZXZpb3VzbHkgcmVhZCBhcyB6ZXJvcyBvbiB0b3AucWNvdzIN
Cj4+IHN1ZGRlbmx5IHR1cm4gaW50byBBLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEtldmluIFdv
bGYgPGt3b2xmQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICAgYmxvY2svaW8uYyB8IDMyICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNl
cnRpb25zKCspDQo+IA0KPiBaZXJvaW5nIHRoZSBpbnRlcnNlY3Rpb24gbWF5IHRha2Ugc29tZSB0
aW1lLiAgU28gaXMgaXQgcmlnaHQgZm9yIFFNUOKAmXMNCj4gYmxvY2tfcmVzaXplIHRvIGRvIHRo
aXMsIHNlZWluZyBpdCBpcyBhIHN5bmNocm9ub3VzIG9wZXJhdGlvbj8NCj4gDQo+IEFzIGZhciBh
cyBJIGNhbiB0ZWxsLCBqb2JzIGFjdHVhbGx5IGhhdmUgdGhlIHNhbWUgcHJvYmxlbS4gIEkgZG9u
4oCZdA0KPiB0aGluayBtaXJyb3Igb3IgY29tbWl0IGhhdmUgYSBwYXVzZSBwb2ludCBiZWZvcmUg
dHJ1bmNhdGluZywgc28gdGhleQ0KPiBzdGlsbCBibG9jayB0aGUgbW9uaXRvciB0aGVyZSwgZG9u
4oCZdCB0aGV5Pw0KPiANCj4gTWF4DQo+IA0KDQpGb3IgbWlycm9yIHRoZXJlIGlzIGFsdGVybmF0
aXZlIHdheTogd2UgbWF5IHNvbWVob3cgY2hlYXQgd2l0aCBibG9jay1zdGF0dXMNCnRvIGNvbnNp
ZGVyIHNwYWNlIGFmdGVyIEVPRiBhcyBhbGxvY2F0ZWQgb24gdXBwZXIgbGV2ZWwsIHRoZW4gbWly
cm9yIHdpbGwNClpFUk8gaXQgYnkgaXRzZWxmLi4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFk
aW1pcg0K


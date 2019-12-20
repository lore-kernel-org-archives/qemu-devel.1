Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6822C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:38:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7126A2467F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 11:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="wNOGcyMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7126A2467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiGbr-0002fm-Kf
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 06:38:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiGav-00023r-67
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:37:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iiGat-000397-9W
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 06:37:21 -0500
Received: from mail-eopbgr130100.outbound.protection.outlook.com
 ([40.107.13.100]:30532 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iiGam-0002eK-Ei; Fri, 20 Dec 2019 06:37:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIRbPgIKLkv9DnV1PbscwN4qlyBXKJzLtC0CVnhA9MRKZ8qBnjbl/nTRLRjgSdmqF4ONbAPKMPCx0liLKFskzybllK/FxNOKlNzzMaWwm1T+CA8UqvrDXf4fwbFZdsZ3yx7bxOirNDO0zc7rat3i0t0MW6WO5Z1+klbmjMUoUsZnUI3+9pdQeCWGpRkTj6/5mhRIXr5/Zq6zBMmNBM0DghnU2YR76FOXRwdh2nXGgWwjQ0NT7RJThCLQobo167ud0f/wQk4R++p8uKlbD2uGuRMniNb/xjoD+U+SVPYYH0CGmg6LpwVxIiPGPXkijAHHkm0vtJ06xuZrqYSu56VZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZNYtCaETYbAloQyHJajAnRw69bd+nsI4GGweu4+eBw=;
 b=cWgi7tZ2wDHrWBpEBtXYXPsoK/f9PMJx2e45TqnHDeBSDtMRfUIpmgFetgzqPvqMXkpbvlCvOBAdaMGsFlsYOK/G+/Hv3pSQnq6rJV7fHusXQJrvHrnJUHk+uAi6Rn0mYeICmnn8BjgaeG8oloB5NNJAXF0CtZo5xikemaohRef2mtdonft3tl5tzfN02P+S19SPN8FIJxcnxlhkMvngxaizgz4R07m+xeXDbf9AC9P8nZczXDO6rDgnjU7hhm38b99OyOE+qzkXDERZHjWSY6fni7LSVQsZv1N+4tB3uVoc79ZlEWtQLcEyfKvM2vQnDE2DKT/DQwygVsEqkFfu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZNYtCaETYbAloQyHJajAnRw69bd+nsI4GGweu4+eBw=;
 b=wNOGcyMweUcCI+McRUUDchDCDP3OVBt31Ge5nuoPZIKZ+BzIZ2uEtlSNdlTPVYZfgVEVw8JYvVC3Uutj6q79kAU+KZKeqso3OB4ycTW47kG+v9kP/uCE6h7+Z9VArF2VYMGybs3D62a4NOxxBjDhSBBDsNFP/X13xX8HMGeCrQs=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB5080.eurprd08.prod.outlook.com (10.255.120.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Fri, 20 Dec 2019 11:37:07 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2559.016; Fri, 20 Dec 2019
 11:37:06 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PATCH] block: nbd: Fix dirty bitmap context name
Thread-Topic: [PATCH] block: nbd: Fix dirty bitmap context name
Thread-Index: AQHVtmzMtpyWQS3Bp0OaQNZadGqOP6fBd04AgAAGUoCAAA9GgIAABQYAgAAKm4CAASlOgIAABMOAgAACxwCAAAmKAIAAD9UA
Date: Fri, 20 Dec 2019 11:37:06 +0000
Message-ID: <d759e797-848e-6bcb-0563-31639d0cc47b@virtuozzo.com>
References: <20191219125151.21482-1-nsoffer@redhat.com>
 <443c32b3-0e0c-ef9e-4d5b-9404b16eaa02@virtuozzo.com>
 <20191219140433.GK5230@linux.fritz.box>
 <CAMRbyyvqa1_3U=2Q7HmCrRcEq+yJjxUP7MM-GM5hUdrZw=yBOw@mail.gmail.com>
 <ddf58827-72e8-f853-e6bc-05d19100c62d@virtuozzo.com>
 <CAMRbyysHGjsWaCWXW2+iNSwU03DhavRF6sJ9-POUx3Mky6LK7Q@mail.gmail.com>
 <42c73579-fdaa-5590-39f9-ca9cacfeaa5e@virtuozzo.com>
 <20191220095617.GK4914@andariel.pipo.sk>
 <a372b586-17a4-9984-68d2-a1131fc219f2@virtuozzo.com>
 <20191220104022.GL4914@andariel.pipo.sk>
In-Reply-To: <20191220104022.GL4914@andariel.pipo.sk>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::12) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191220143702471
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b766e19-2edd-49ff-3303-08d78540f102
x-ms-traffictypediagnostic: AM6PR08MB5080:
x-microsoft-antispam-prvs: <AM6PR08MB50809753AC2A82084AF1E72DC12D0@AM6PR08MB5080.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 025796F161
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(396003)(39840400004)(136003)(366004)(346002)(199004)(189003)(71200400001)(966005)(54906003)(36756003)(6486002)(5660300002)(2616005)(186003)(6916009)(478600001)(26005)(66946007)(31686004)(6512007)(53546011)(6506007)(8936002)(4326008)(86362001)(316002)(2906002)(31696002)(52116002)(64756008)(66446008)(81166006)(81156014)(66556008)(8676002)(66476007)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB5080;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kC0fyN/RP4y6uB/odL4rmx47InmM7Esvo7h/RyjJRKxDu4zS+fLM+Fz7aKFpEUaCxTXMc32LZO9WPMwxoh1bdKLgr+HIr2DLt5VN7NoN+UELU3wtrHWCUuNcOCd1ZE/fOZLw2wDFkzXhht4/K9rpVW3dLX/t+F7IU+91kxO6UzcwcHVc+GHGKLcvjT8zCQHCNrz6xghrVAacThzdguZAOpSOgC7vJRgAkGck42KyP4agXP56x4fT2isuHe8uHQkEOEJD5nqaUw4w4L0cTbf3GS5euhtCMx/s1R4FgS641Dyvt/lS0LYPj8KaFEziVC+6+6WANGnFc7BmDFW9aH/idnHYyFLg47cSL8heXxx7BMt99TUqXlonpQhdLPMwMMo9VkXFxU5dT3Q67jiNoTWsQuAh0z2OQBXMPnCQKEBm5DZuuWTCBrmtrCiu6UT8BUJjsaCBhL97gLuhzWBwpNBECu5CyfvYqlZY1vmlJOiJ6GtRJAfsNaZiULpHwpa2xWucKtykbu4vI1//OpW0uhAA9w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0D0078968D3A8418944E0D42C789A2F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b766e19-2edd-49ff-3303-08d78540f102
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 11:37:06.6137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytpHmdxKjYHZbwSgeH6w4pCuoQtBMdVshmwQWeHtPsbv5NWefP2lSLSfxHUhr0edbzBCO+PEYM7BxbP68N5VtB1rZ4+Dc9Pt/dKI8nLBfXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5080
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.100
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nirsof@gmail.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMTIuMjAxOSAxMzo0MCwgUGV0ZXIgS3JlbXBhIHdyb3RlOg0KPiBPbiBGcmksIERlYyAyMCwg
MjAxOSBhdCAxMDowNjoxNyArMDAwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90
ZToNCj4+IDIwLjEyLjIwMTkgMTI6NTYsIFBldGVyIEtyZW1wYSB3cm90ZToNCj4+PiBPbiBGcmks
IERlYyAyMCwgMjAxOSBhdCAwOTozOToxNyArMDAwMCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSB3cm90ZToNCj4+Pj4gMTkuMTIuMjAxOSAxODo1NSwgTmlyIFNvZmZlciB3cm90ZToNCj4+
Pj4+IE9uIFRodSwgRGVjIDE5LCAyMDE5IGF0IDU6MTcgUE0gVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeQ0KPj4+Pj4gPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4gd3JvdGU6DQo+Pj4+Pj4N
Cj4+Pj4+PiAxOS4xMi4yMDE5IDE3OjU5LCBOaXIgU29mZmVyIHdyb3RlOg0KPj4+Pj4+PiBPbiBU
aHUsIERlYyAxOSwgMjAxOSBhdCA0OjA0IFBNIEtldmluIFdvbGYgPGt3b2xmQHJlZGhhdC5jb20+
IHdyb3RlOg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEFtIDE5LjEyLjIwMTkgdW0gMTQ6NDEgaGF0IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgZ2VzY2hyaWViZW46DQo+Pj4+Pj4+Pj4gQWhoLCBJ
IHNlZSwgaXQncyBkb2N1bWVudGVkIGFzDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiArIyBAYml0bWFw
OiBBbHNvIGV4cG9ydCB0aGUgZGlydHkgYml0bWFwIHJlYWNoYWJsZSBmcm9tIEBkZXZpY2UsIHNv
IHRoZQ0KPj4+Pj4+Pj4+ICsjICAgICAgICAgIE5CRCBjbGllbnQgY2FuIHVzZSBOQkRfT1BUX1NF
VF9NRVRBX0NPTlRFWFQgd2l0aA0KPj4+Pj4+Pj4+ICsjICAgICAgICAgICJxZW11OmRpcnR5LWJp
dG1hcDpOQU1FIiB0byBpbnNwZWN0IHRoZSBiaXRtYXAuIChzaW5jZSA0LjApDQo+Pj4+Pj4+Pj4N
Cj4+Pj4+Pj4+PiBhbmQgaXQgaXMgbG9naWNhbCB0byBhc3N1bWUgdGhhdCBleHBvcnQgbmFtZSAo
d2hpY2ggaXMgQG5hbWUgYXJndW1lbnQpIGlzDQo+Pj4+Pj4+Pj4gbWVudGlvbmVkLiBCdXQgd2Ug
bmV2ZXIgbWVudGlvbmVkIGl0LiBUaGlzIGlzIGp1c3QgZG9jdW1lbnRlZCBhZnRlcg0KPj4+Pj4+
Pj4+IHJlbW92ZWQgZXhwZXJpbWVuYXRsIGNvbW1hbmQgeC1uYmQtc2VydmVyLWFkZC1iaXRtYXAs
DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBsb29rIGF0DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBjb21t
aXQgN2RjNTcwYjM4MDZlNWIwYTRjOTIxOTA2MTU1NmVkNWE0YTBkZTgwYw0KPj4+Pj4+Pj4+IEF1
dGhvcjogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQo+Pj4+Pj4+Pj4gRGF0ZTogICBG
cmkgSmFuIDExIDEzOjQ3OjE4IDIwMTkgLTA2MDANCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+ICAgICAg
ICAgIG5iZDogUmVtb3ZlIHgtbmJkLXNlcnZlci1hZGQtYml0bWFwDQo+Pj4+Pj4+Pj4NCj4+Pj4+
Pj4+PiAuLi4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IC0jIEBiaXRtYXAtZXhwb3J0LW5hbWU6IEhv
dyB0aGUgYml0bWFwIHdpbGwgYmUgc2VlbiBieSBuYmQgY2xpZW50cw0KPj4+Pj4+Pj4+IC0jICAg
ICAgICAgICAgICAgICAgICAgIChkZWZhdWx0IEBiaXRtYXApDQo+Pj4+Pj4+Pj4gLSMNCj4+Pj4+
Pj4+PiAtIyBOb3RlOiB0aGUgY2xpZW50IG11c3QgdXNlIE5CRF9PUFRfU0VUX01FVEFfQ09OVEVY
VCB3aXRoIGEgcXVlcnkgb2YNCj4+Pj4+Pj4+PiAtIyAicWVtdTpkaXJ0eS1iaXRtYXA6TkFNRSIg
KHdoZXJlIE5BTUUgbWF0Y2hlcyBAYml0bWFwLWV4cG9ydC1uYW1lKSB0byBhY2Nlc3MNCj4+Pj4+
Pj4+PiAtIyB0aGUgZXhwb3NlZCBiaXRtYXAuDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+
Pj4+IFNvLCB0aGlzICJOQU1FIiBpcyBzYXZlZCBhbmQgbm93IGxvb2tzIGluY29ycmVjdC4gV2hh
dCBzaG91bGQgYmUgZml4ZWQsIGlzIFFhcGkNCj4+Pj4+Pj4+PiBkb2N1bWVudGF0aW9uLg0KPj4+
Pj4+Pj4NCj4+Pj4+Pj4+IEhtLCBJIGRvbid0IGtub3cgdGhlc2UgaW50ZXJmYWNlcyB2ZXJ5IHdl
bGwsIGJ1dCBmcm9tIHlvdSBleHBsYW5hdGlvbiBpdA0KPj4+Pj4+Pj4gbG9va3MgdG8gbWUgYXMg
aWYgaGF2aW5nIGEgYml0bWFwIG5hbWUgbWFkZSBzZW5zZSB3aXRoDQo+Pj4+Pj4+PiB4LW5iZC1z
ZXJ2ZXItYWRkLWJpdG1hcCBiZWNhdXNlIGl0IGNvdWxkIGJlIGNhbGxlZCBtb3JlIHRoYW4gb25j
ZSBmb3INCj4+Pj4+Pj4+IGV4cG9ydGluZyBtdWx0aXBsZSBiaXRtYXBzLg0KPj4+Pj4+Pj4NCj4+
Pj4+Pj4+IEJ1dCBub3csIHdlIGhhdmUgb25seSBuYmQtc2VydmVyLWFkZCwgd2hpY2ggdGFrZXMg
YSBzaW5nbGUgYml0bWFwIG5hbWUuDQo+Pj4+Pj4+PiBBcyB3ZSBkb24ndCBoYXZlIHRvIGRpc3Rp
bmd1aXNoIG11bHRpcGxlIGJpdG1hcHMgYW55IG1vcmUsIHdvdWxkbid0IGl0DQo+Pj4+Pj4+PiBt
YWtlIG1vcmUgc2Vuc2UgdG8gdXNlICJxZW11OmRpcnR5LWJpdG1hcCIgd2l0aG91dCBhbnkgb3Ro
ZXINCj4+Pj4+Pj4+IGluZm9ybWF0aW9uPyBCb3RoIGV4cG9ydCBuYW1lIGFuZCBiaXRtYXAgbmFt
ZSBhcmUgYWxyZWFkeSBpZGVudGlmaWVkIGJ5DQo+Pj4+Pj4+PiB0aGUgY29ubmVjdGlvbi4NCj4+
Pj4+Pj4NCj4+Pj4+Pj4gV2UgY2FuIHVzZSBlbXB0eSBzdHJpbmcgKGxpa2UgdGhlIGRlZmF1bHQg
ZXhwb3J0IG5hbWUpLCBzbyB0aGUgYml0bWFwDQo+Pj4+Pj4+IHdvdWxkIGJlIGV4cG9zZWQgYXM6
DQo+Pj4+Pj4+DQo+Pj4+Pj4+ICAgICAgICAgInFlbXU6ZGlydHktYml0bWFwOiINCj4+Pj4+Pj4N
Cj4+Pj4+Pj4gVGhpcyB3b3VsZCBzb2x2ZSB0aGUgaXNzdWUgZm9yIHVzZXJzLCBhbmQga2VlcCB0
aGUgQVBJIGV4dGVuc2libGUuDQo+Pj4+Pj4NCj4+Pj4+PiBBcyBJIGFscmVhZHkgc2FpZCwgd2Ug
Y2FuIG5vdC4gSWYgd2UgcmVhbGx5IHdvbnQgc3VjaCB0aGluZywgdXNlIGFub3RoZXIgbmFtZSwN
Cj4+Pj4+PiBsaWtxIHFlbXU6ZGVmYXVsdC1kaXJ0eS1iaXRtYXAuLg0KPj4+Pj4+DQo+Pj4+Pj4g
T3IgY2FsbCBiaXRtYXAgZXhwb3J0ICJkZWZhdWx0IiwgdG8gcHJvZHVjZQ0KPj4+Pj4+ICAgICAg
InFlbXU6ZGlydHktYml0bWFwczpkZWZhdWx0Ig0KPj4+Pj4+DQo+Pj4+Pj4gQnV0IGRvbid0IGNo
YW5nZSBkZWZhdWx0IGJlaGF2aW9yIG9mIG5iZC1zZXJ2ZXItYWRkDQo+Pj4+Pj4NCj4+Pj4+Pj4N
Cj4+Pj4+Pj4+IEJ1dCBpZiB3ZSBoYXZlIHRvIGhhdmUgc29tZXRoaW5nIHRoZXJlLCB1c2luZyB0
aGUgYml0bWFwIG5hbWUgKHdoaWNoIG1heQ0KPj4+Pj4+Pj4gb3IgbWF5IG5vdCBiZSB0aGUgc2Ft
ZSBhcyB1c2VkIGluIHRoZSBpbWFnZSBmaWxlKSBtYWtlcyBhIGxpdHRsZSBtb3JlDQo+Pj4+Pj4+
PiBzZW5zZSBiZWNhdXNlIGl0IG1ha2VzIHRoZSBpbnRlcmZhY2UgZXh0ZW5zaWJsZSBmb3IgdGhl
IGNhc2UgdGhhdCB3ZQ0KPj4+Pj4+Pj4gZXZlciB3YW50IHRvIHJlLWludHJvZHVjZSBhbiBuYmQt
c2VydmVyLWFkZC1iaXRtYXAuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEJ1dCB1c2luZyB0aGUgYml0bWFw
IG5hbWUgbWVhbnMgdXNlciBvZiB0aGUgTkJEIHNlcnZlciBuZWVkIHRvIGtub3cgdGhpcyBuYW1l
Lg0KPj4+Pj4+DQo+Pj4+Pj4gV2h5IG5vdD8gV2hhdCBpcyB5b3VyIGNhc2UgZXhhY3RseT8gVXNl
ciBrbm93cywgd2hhdCBraW5kIG9mIGJpdG1hcCB5b3UgYXJlDQo+Pj4+Pj4gZXhwb3J0aW5nLCBz
byB1c2VyIGlzIGluIHNvbWUgcmVsYXRpb24gd2l0aCBleHBvcnRpbmcgcHJvY2VzcyBhbnl3YXku
IFdoeQ0KPj4+Pj4+IHNob3VsZG4ndCBpdCBrbm93IHRoZSBuYW1lPw0KPj4+Pj4NCj4+Pj4+IEJl
Y2F1c2UgdGhlIHVzZXIgY29uZmlndXJpbmcgcWVtdSAobGlidmlydCkgaXMgbm90IHRoZSBzYW1l
IHVzZXINCj4+Pj4+IGFjY2Vzc2luZyBxZW11IE5CRA0KPj4+Pj4gc2VydmVyIChvdmlydCwgb3Ig
c29tZSBiYWNrdXAgYXBwbGljYXRpb24pLg0KPj4+Pj4NCj4+Pj4+PiBUaGlzIG5hbWUgbWF5IGJl
IGRlZmluZWQgaW4geW91IGV4cG9ydGluZyBwcm90b2NvbC4uIFdoYXQgYXJlIHlvdSBleHBvcnRp
bmc/DQo+Pj4+Pg0KPj4+Pj4gV2UgZXhwb3J0IEhUVFAgQVBJLCBhbGxvd2luZyBnZXR0aW5nIGRp
cnR5IGV4dGVudHMgYW5kIHJlYWRpbmcgZGF0YToNCj4+Pj4+IGh0dHBzOi8vd3d3Lm92aXJ0Lm9y
Zy9kZXZlbG9wL3JlbGVhc2UtbWFuYWdlbWVudC9mZWF0dXJlcy9zdG9yYWdlL2luY3JlbWVudGFs
LWJhY2t1cC5odG1sI21hcC1yZXF1ZXN0DQo+Pj4+PiAodGhpcyBkb2N1bWVudCBpcyBvdXRkYXRl
ZCwgYnV0IGl0IGdpdmVzIHRoZSBnZW5lcmFsIGlkZWEpDQo+Pj4+Pg0KPj4+Pj4gT3IgcHJvdmlk
ZSB0aGUgTkJEIFVSTCBkaXJlY3RseSB0byB1c2VyIChmdXR1cmUpLg0KPj4+Pj4NCj4+Pj4+PiBO
b3RlIGFsc28sIHRoYXQgY2xpZW50IG1heSB1c2UgTkJEX09QVF9MSVNUX01FVEFfQ09OVEVYVCB3
aXRoIHF1ZXJ5DQo+Pj4+Pj4gInFlbXU6ZGlydHktYml0bWFwOiIsIHRvIGdldCBsaXN0IG9mIGFs
bCBleHBvcnRlZCBiaXRtYXBzLg0KPj4+Pj4NCj4+Pj4+IFRoaXMgaXMgYW5vdGhlciBvcHRpb24s
IEkgZGlkIG5vdCB0cnkgdG8gdXNlIHRoaXMgeWV0LiBXZSBjYW4gdXNlIHRoZSBzaW5nbGUNCj4+
Pj4+IGV4cG9ydGVkIGJpdG1hcCBhbmQgZmFpbCBpZiB3ZSBnZXQgbW9yZSB0aGFuIG9uZS4gVGhp
cyBpcyBwcm9iYWJseSBiZXR0ZXINCj4+Pj4+IHRoYW4gY2hhbmdpbmcgdGhlIGVudGlyZSBzdGFj
ayB0byBzdXBwb3J0IGJpdG1hcCBuYW1lLg0KPj4+Pj4NCj4+Pj4+Pj4gT25lIG9wdGlvbiBpcyB0
aGF0IGxpYnZpcnQgd291bGQgcHVibGlzaCB0aGUgbmFtZSBvZiB0aGUgYml0bWFwIGluIHRoZQ0K
Pj4+Pj4+PiB4bWwgZGVzY3JpYmluZw0KPj4+Pj4+PiB0aGUgYmFja3VwLCBhbmQgb1ZpcnQgd2ls
bCBoYXZlIHRvIHByb3BhZ2F0ZSB0aGlzIG5hbWUgdG8gdGhlIGFjdHVhbA0KPj4+Pj4+PiBwcm9n
cmFtIGFjY2Vzc2luZw0KPj4+Pj4+PiB0aGUgTkJEIHNlcnZlciwgd2hpY2ggbWF5IGJlIGEgdXNl
ciBwcm9ncmFtIGluIHRoZSBjYXNlIHdoZW4gd2UgZXhwb3NlIHRoZSBOQkQNCj4+Pj4+Pj4gVVJM
IHRvIHVzZXJzIChwbGFubmVkIGZvciBmdXR1cmUgdmVyc2lvbikuDQo+Pj4+Pj4+DQo+Pj4+Pj4+
IEFub3RoZXIgb3B0aW9uIGlzIHRoYXQgdGhlIHVzZXIgd2lsbCBjb250cm9sIHRoaXMgbmFtZSwg
YW5kIGxpYnZpcnQNCj4+Pj4+Pj4gd2lsbCB1c2UgdGhlIG5hbWUgc3BlY2lmaWVkDQo+Pj4+Pj4+
IGJ5IHRoZSB1c2VyLiBUaGlzIG1lYW5zIG9WaXJ0IHdpbGwgaGF2ZSB0byBwcm92aWRlIEFQSSB0
byBzZXQgdGhpcw0KPj4+Pj4+PiBuYW1lIGFuZCBwYXNzIGl0IHRvIGxpYnZpcnQuDQo+Pj4+Pj4+
DQo+Pj4+Pj4+IEJvdGggY2FzZXMgcmVxdWlyZSBsb3Qgb2YgZWZmb3J0IHdoaWNoIGRvZXMgbm90
IGhlbHAgYW55b25lIGluIHRoZQ0KPj4+Pj4+PiB0YXNrIG9mIGdldHRpbmcgZGlydHkNCj4+Pj4+
Pj4gZXh0ZW50cyBmcm9tIGFuIGltYWdlIC0gd2hpY2ggaXMgb3VyIGN1cnJlbnQgZ29hbC4gV2Ug
bmVlZCB0byBoYXZlDQo+Pj4+Pj4+IGdvb2QgZGVmYXVsdHMgdGhhdA0KPj4+Pj4+PiBzYXZlIHVu
bmVlZGVkIGVmZm9ydCBpbiB0aGUgZW50aXJlIHN0YWNrLg0KPj4+Pj4+DQo+Pj4+Pj4gU28sIHlv
dSBpbXBsZW1lbnRpbmcgc29tZSBwcm90b2NvbCwgYW5kIG5lZWQgdG8gZXhwb3J0IG9ubHkgb25l
IGJpdG1hcCBmb3INCj4+Pj4+PiB5b3VyIHNwZWNpZmllZCBzY2VuYXJpby4gV2h5IG5vdCBqdXN0
IGdpdmUgYSBjb25zdGFudCBuYW1lPyBMaWtlIG92aXJ0LWJpdG1hcCwNCj4+Pj4+PiBvciBzb21l
dGhpbmcgbGlrZSB0aGlzPw0KPj4+Pj4NCj4+Pj4+IEJ1dCB3ZSBkb24ndCB1c2UgcWVtdSBkaXJl
Y3RseS4gV2UgdXNlIGxpYnZpcnQsIGFuZCBsaWJ2aXJ0IGRvZXMgbm90IGV4cG9zZQ0KPj4+Pj4g
dGhlIG5hbWUgb2YgdGhlIGJpdG1hcCwgb3IgbGV0IHVzZSBjb250cm9sIHRoaXMgbmFtZS4NCj4+
Pj4+DQo+Pj4+PiBUaGlzIGlzIGEgc2ltcGxpZmllZCBmbG93Og0KPj4+Pj4gMS4gbGlidmlydCBz
dGFydHMgYSBiYWNrdXAsIGNyZWF0aW5nIHRoZSAiYmFja3VwLWV4cG9ydG5hbWUiIGJpdG1hcA0K
Pj4+Pg0KPj4+PiBCdXQgZG8geW91IG1hbmFnZSBleHBvcnRuYW1lLCBvciBub3Q/DQo+Pj4NCj4+
PiBUaGV5IGNhbid0IG1hbmFnZSB0aGUgZXhwb3J0IG5hbWUgZWl0aGVyLCBidXQgYXBwYXJlbnRs
eSB0aGUgZGVmYXVsdA0KPj4+IHRoYXQgbGlidmlydCB1c2VzIHN1aXRzIHRoZW0uDQo+Pj4NCj4+
PiBJIGNhbiBhZGQgcG9zc2liaWxpdHkgdG8gbmFtZSB0aGUgYWN0dWFsIGJhY2t1cCBvdXRwdXQg
Yml0bWFwDQo+Pj4gYXJiaXRyYXJpbHkuIE9idmlvdXNseSB0aGUgdXNlciB0aGVuIGhhcyB0byBw
YXNzIGEgc2Vuc2libGUgbmFtZSBvZiBhDQo+Pj4gbm9uIGV4aXN0YW50IGJpdG1hcCB0byBwcm9j
ZWVkLg0KPj4+DQo+Pj4gTWFraW5nIGJvdGggY29uZmlndXJhYmxlIGF0IHRoZSBzYW1lIHRpbWUg
bWF5IGJlIHdvcnRoIGRvaW5nIGFzIGl0IHdpbGwNCj4+PiBiZSBiYXNpY2FsbHkgdGhlIHNhbWUg
Y29kZS4NCj4+Pg0KPj4NCj4+IEludHVpdGl2ZWx5LCBJIHRoaW5rIGl0J3MgYmV0dGVyIGxlYXZl
IGJpdG1hcCBuYW1lIGFzIGlzOiBsaWJ2aXJ0IG1hbmFnZXMNCj4+IGJpdG1hcHMsIHNvIGxldCBp
dCBtYW5hZ2UgdGhlaXIgbmFtZXMgYXMgaXQgd2FudHMuIEFuZCBJIGRvbid0IHRoaW5rIHRoYXQN
Cj4+IE5pciB3YW50IHRvIGNhcmUgYWJvdXQgZXhpc3RpbmcgYml0bWFwcy4NCj4gDQo+IEFjdHVh
bGx5IGZvciBhbiBpbmNyZW1lbnRhbCBiYWNrdXAgd2UgYXJlIGNyZWF0aW5nIGEgbmV3IGJpdG1h
cCB3aGljaCBpcw0KPiB1c2VkIGZvciBtZXJnaW5nIGFsbCB0aGUgYXBwcm9wcmlhdGUgYml0bWFw
cyBmb3IgdGhlIGV4cGVjdGVkIGJhY2t1cA0KPiByYW5nZS4gVGhpcyBpcyBkb25lIGFsc28gd2hl
biBvbmx5IG9uZSBiaXRtYXAgd291bGQgYmUgc2VsZWN0ZWQgdGhpcyB3YXkNCj4gYXMgdGhlcmUn
cyBubyBwb2ludCBpbiBvcHRpbWl6aW5nIHRoaXMgYWxnb3JpdGhtLg0KPiANCj4gVGhpcyBtZWFu
cyB3ZSBjYW4gbmFtZSB0aGUgbmV3IGJpdG1hcCBhcmJpdHJhcmlseSAoaWYgaXQgZG9lc24ndCBj
bGFzaA0KPiB3aXRoIGV4aXN0aW5nIGJpdG1hcCkgYW5kIHNpbmNlIHRoYXQgbmFtZSB3aWxsIGJl
IGFsc28gZXhwb3J0ZWQgaXQncyB0aGUNCj4gc2FtZSB0aGV5IHJlcXVlc3QuDQo+IA0KDQpIbSwg
Y2xlYXIuIFRoZW4gaXQgc2hvdWxkIHdvcmsgdG9vLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZs
YWRpbWlyDQo=


Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2CFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1A021835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 17:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Sl10wK/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1A021835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itan6-0000Ae-12
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 12:24:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itaj3-0003s0-1D
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1itaiz-0008Ji-4s
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 12:20:32 -0500
Received: from mail-eopbgr40111.outbound.protection.outlook.com
 ([40.107.4.111]:40958 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1itaim-0008BJ-Fe; Mon, 20 Jan 2020 12:20:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaD5i0yoLLq9bmW3AML/bPyRz2p/w17NSNu/ngYfhW5J2uctLumhht7BNfZC+ZNli6IVxizEtaEqP028vaYHVjBr8gm+0PSkGpBS8kX019TC6ZgfkHBbNpfoVqFKbo0FmfGviKZVPqqX1iwuBlemw9gnyWxGKVC2FsxNorDXjZlmtqH/NG/cEXsjysqpkE+YL+sHA0EqK2XmdVl5LxpezwTj40Ga+Ogn9pW5xHFqA7bVfsTHmL9pvVMBYSlMBeqlB/LKbBKijnyyQDPwKt3Vf4tz/tQc9oF9EKB7834h9Af3ZvlDfBoenIgbwus24efhGxVaCupqbAU5b/N8w6mSVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDYYAnrz1z4k/0qPyGsv1FRPmYRuVU1vyVCW+13sI4A=;
 b=Av49bovVsmujb5RaJbK6bLol/fkivYfzH3dVly9Fy3Kytr7batemXcjM4/JhADRQOAxdLEt+032VxEgpPjgfS3wuE3xrK6cS2emryr4Wv6rxroAw24uiI1KtQvcPWtS6pJLLZbibFxnF3ew12VCL2fsimVfSYGnpGfrqbJXSVzXN1gZ1axjB+cBnnUQf5fFE3y2f3nTHWpMNpTOIfqzIDbHQCRR0qeRSSFbPGxZbrgoaI+u8CYKubz1xyK/mEviyBPm+P9xRMmH2qMzNLqCPhiFoe9mDwM+42QbyRtdccjhZy7HW6SZzoua5yGcjipmfl6+pdclxVmL91ZrUsbxxMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDYYAnrz1z4k/0qPyGsv1FRPmYRuVU1vyVCW+13sI4A=;
 b=Sl10wK/TRjNu7NJPKBFaQNNZljgjHvtoblfnPBQKBzE0pjusAMB70dKqD30JjopX2hyb29jQU8yo/8mFz7YR6/2Rq9DZ1wQSGJYGJwE3RipAfklcgWAuOMP2AluItKJw3vHG0vOBjPWSBD1C+zVy4qZkwCGEJTKRVQtJBQZrr70=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4552.eurprd08.prod.outlook.com (20.179.18.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Mon, 20 Jan 2020 17:20:13 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2644.026; Mon, 20 Jan 2020
 17:20:13 +0000
Received: from [172.16.24.200] (185.231.240.5) by
 ZR0P278CA0024.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Mon, 20 Jan 2020 17:20:13 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
Thread-Topic: [PATCH 2/2] iotests: add test for backup-top failure on
 permission activation
Thread-Index: AQHVzIVUyOIzH3fEwkGWDPORhit+OafzzmgAgAAESIA=
Date: Mon, 20 Jan 2020 17:20:13 +0000
Message-ID: <ea9219cd-8cc1-8cc0-d568-a51013ba74a4@virtuozzo.com>
References: <20200116155452.30972-1-vsementsov@virtuozzo.com>
 <20200116155452.30972-3-vsementsov@virtuozzo.com>
 <eedd42b6-bf4e-f6de-13a4-412d389fdb09@redhat.com>
In-Reply-To: <eedd42b6-bf4e-f6de-13a4-412d389fdb09@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ZR0P278CA0024.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::11) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20200120202009176
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f602866a-4388-4e12-b121-08d79dcd02a3
x-ms-traffictypediagnostic: AM6PR08MB4552:
x-microsoft-antispam-prvs: <AM6PR08MB455217C2C969FE593DF079B9C1320@AM6PR08MB4552.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(366004)(376002)(39840400004)(136003)(189003)(199004)(81156014)(81166006)(8676002)(66476007)(66556008)(66946007)(71200400001)(8936002)(2906002)(64756008)(66446008)(53546011)(31696002)(5660300002)(86362001)(16526019)(31686004)(36756003)(6486002)(54906003)(110136005)(186003)(52116002)(2616005)(956004)(478600001)(16576012)(4326008)(966005)(26005)(316002)(2004002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4552;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 78l/tIa8ccf/HfQNvW0aed76DiFIOh6wC/NfBjb1QW8FXEgpd4INDpd4JHN/8VGQbjD83XrkuH0iKfwKoNbnw9Ryw4f+13inDOSK7Iwz8jKEnyQ57SkesKWj4JWr578jvaEhT7ZAelZVtQPaYGgCC3wsQ9Z4t0u4b3/3nN/SNs3XjLFw6n9tMQk7MO1NaL0IoovIflL41UbldiXUPMAlErhLD54TLENBCj7lYrPrM93NKUIBfDmdTmgzDwvyUytIdeQsp+XapaiEmdhua857vC3q4hVV+oNyA3+RNxWoKG95VqMX1DPmht4/Gsu8iILjtbO1uEvvjvwTlWOrvULNP6Ip8iOMoGUBxxfZmKIFCcDW39H00qFXxcePSqn74QeCMOPZJz+oDvQMuXXDu6RGMbZ1TO+DLWWFskIVBqDuCH7cg2ARy6gu0/mBzUJvZFADLNs2CQNhJY4g9efU9MKmgc4kOh8CAA0E4us0OKN12mefBoVS2HMLlWjHC0eyl0E35Rw/HUXysD4ICo1slta439WgemSoPbKGGPhHKzQht6yyoalav3nBZ2+nqEe0gFF+
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3228F8011C3444AA172E00A7A7657AE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f602866a-4388-4e12-b121-08d79dcd02a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 17:20:13.5982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhpusLY4impg+VGqkMvGJ2MQtywtiRF1jWcBeTvVwp3B2TkzVLtDMnUsjq1NZWlJvFiHJznWVCjALke0copLq1ZZMduqKhteunV30PTW7RA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4552
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.111
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
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjAuMDEuMjAyMCAyMDowNCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNi4wMS4yMCAxNjo1NCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFRoaXMgdGVzdCBjaGVja3Mg
dGhhdCBidWcgaXMgcmVhbGx5IGZpeGVkIGJ5IHByZXZpb3VzIGNvbW1pdC4NCj4+DQo+PiBDYzog
cWVtdS1zdGFibGVAbm9uZ251Lm9yZyAjIHY0LjIuMA0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0t
DQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yODMgICAgIHwgNzUgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzI4My5vdXQgfCAg
OCArKysrDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy9ncm91cCAgIHwgIDEgKw0KPj4gICAzIGZp
bGVzIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRl
c3RzL3FlbXUtaW90ZXN0cy8yODMNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3FlbXUt
aW90ZXN0cy8yODMub3V0DQo+IA0KPiBUaGUgdGVzdCBsb29rcyBnb29kIHRvIG1lLCBJIGp1c3Qg
aGF2ZSBhIGNvbW1lbnQgbml0IGFuZCBhIG5vdGUgb24gdGhlDQo+IGZhY3QgdGhhdCB0aGlzIHNo
b3VsZCBwcm9iYWJseSBiZSBxdWV1ZWQgb25seSBhZnRlciBUaG9tYXPigJlzIOKAnEVuYWJsZQ0K
PiBtb3JlIGlvdGVzdHMgZHVyaW5nICJtYWtlIGNoZWNrLWJsb2NrIuKAnSBzZXJpZXMuDQo+IA0K
Pj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yODMgYi90ZXN0cy9xZW11LWlvdGVz
dHMvMjgzDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMC4uZjBm
MjE2ZDEwOQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI4
Mw0KPj4gQEAgLTAsMCArMSw3NSBAQA0KPj4gKyMhL3Vzci9iaW4vZW52IHB5dGhvbg0KPj4gKyMN
Cj4+ICsjIFRlc3QgZm9yIGJhY2t1cC10b3AgZmlsdGVyIHBlcm1pc3Npb24gYWN0aXZhdGlvbiBm
YWlsdXJlDQo+PiArIw0KPj4gKyMgQ29weXJpZ2h0IChjKSAyMDE5IFZpcnR1b3p6byBJbnRlcm5h
dGlvbmFsIEdtYkguDQo+PiArIw0KPj4gKyMgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7
IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkNCj4+ICsjIGl0IHVuZGVyIHRo
ZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5
DQo+PiArIyB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9m
IHRoZSBMaWNlbnNlLCBvcg0KPj4gKyMgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lv
bi4NCj4+ICsjDQo+PiArIyBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCj4+ICsjIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsg
d2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mDQo+PiArIyBNRVJDSEFOVEFCSUxJ
VFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhlDQo+PiArIyBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLg0KPj4gKyMNCj4+ICsj
IFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1Ymxp
YyBMaWNlbnNlDQo+PiArIyBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbS4gIElmIG5vdCwgc2VlIDxo
dHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvPi4NCj4+ICsjDQo+PiArDQo+PiAraW1wb3J0IGlv
dGVzdHMNCj4+ICsNCj4+ICsjIFRoZSB0ZXN0IGlzIHVucmVsYXRlZCB0byBmb3JtYXRzLCByZXN0
cmljdCBpdCB0byBxY293MiB0byBhdm9pZCBleHRyYSBydW5zDQo+PiAraW90ZXN0cy52ZXJpZnlf
aW1hZ2VfZm9ybWF0KHN1cHBvcnRlZF9mbXRzPVsncWNvdzInXSkNCj4+ICsNCj4+ICtzaXplID0g
MTAyNCAqIDEwMjQNCj4+ICsNCj4+ICsiIiINCj4+ICtPbiBhY3RpdmF0aW9uLCBiYWNrdXAtdG9w
IGlzIGdvaW5nIHRvIHVuc2hhcmUgd3JpdGUgcGVybWlzc2lvbiBvbiBpdHMNCj4+ICtzb3VyY2Ug
Y2hpbGQuIEl0IHdpbGwgYmUgaW1wb3NzaWJsZSBmb3IgdGhlIGZvbGxvd2luZyBjb25maWd1cmF0
aW9uOg0KPiANCj4g4oCcVGhlIGZvbGxvd2luZyBjb25maWd1cmF0aW9uIHdpbGwgYmVjb21lIGlt
cG9zc2libGXigJ0/DQoNCkhtbSwgbm8sIHRoZSBjb25maWd1cmF0aW9uIGlzIHBvc3NpYmxlLiBC
dXQgIml0IiwgaS5lLiAidW5zaGFyZSB3cml0ZSBwZXJtaXNzaW9uIiwNCmlzIGltcG9zc2libGUg
d2l0aCBzdWNoIGNvbmZpZ3VyYXRpb24uLg0KDQo+IA0KPiBJIHRoaW5rIHRoZXJlIHNob3VsZCBi
ZSBzb21lIG5vdGUgdGhhdCB0aGlzIGlzIGV4YWN0bHkgd2hhdCB3ZSB3YW50IHRvDQo+IHRlc3Qs
IGkuZS4gd2hhdCBoYXBwZW5zIHdoZW4gdGhpcyBpbXBvc3NpYmxlIGNvbmZpZ3VyYXRpb24gaXMg
YXR0ZW1wdGVkDQo+IGJ5IHN0YXJ0aW5nIGEgYmFja3VwLiAgKEFuZCBtYXliZSB3aHkgdGhpcyBp
c27igJl0IGFsbG93ZWQ7IG5hbWVseSBiZWNhdXNlDQo+IHdlIGNvdWxkbuKAmXQgZG8gQ0JXIGZv
ciBzdWNoIHdyaXRlIGFjY2Vzc2VzLikNCj4gDQo+PiArDQo+PiArICAgIOKUjOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUkCAgdGFyZ2V0ICDilIzilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilJANCj4+ICsgICAg4pSCIHRhcmdldCDilIIg4peA4pSA4pSA4pSA4pSA4pSA
4pSA4pSAIOKUgiBiYWNrdXBfdG9wICDilIINCj4+ICsgICAg4pSU4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSYICAgICAgICAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUmA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICDilIINCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAg4pSCIGJhY2tpbmcNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAg4pa8DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg4pSM4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAg4pSCICAgc291cmNlICAgIOKUgg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIOKUlOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICDilIINCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg4pSC
IGZpbGUNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg4pa8DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSQICB3cml0ZSBwZXJtICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAg4pSCICAgIGJhc2UgICAgIOKUgiDil4DilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIAg4pSCIG90aGVyIOKUgg0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmCAgICAg
ICAgICAgICAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmA0KPiANCj4gQ29vbCBVbmljb2Rl
IGFydC4gOi0pDQoNCkkgZm91bmQgdGhlIGdyZWF0IHRvb2w6IGh0dHBzOi8vZG90LXRvLWFzY2lp
LmdnZXJnYW5vdi5jb20vDQoNCj4gDQo+PiArDQo+PiArV3JpdGUgdW5zaGFyaW5nIHdpbGwgYmUg
cHJvcGFnYXRlZCB0byB0aGUgInNvdXJjZS0+YmFzZSJsaW5rIGFuZCB3aWxsDQo+PiArY29uZmxp
Y3Qgd2l0aCBvdGhlciBub2RlIHdyaXRlIHBlcm1pc3Npb24uDQo+PiArDQo+PiArKE5vdGUsIHRo
YXQgd2UgY2FuJ3QganVzdCBjb25zaWRlciBzb3VyY2UgdG8gYmUgZGlyZWN0IGNoaWxkIG9mIG90
aGVyLA0KPj4gK2FzIGluIHRoaXMgY2FzZSB0aGlzIGxpbmsgd2lsbCBiZSBicm9rZW4sIHdoZW4g
YmFja3VwX3RvcCBpcyBhcHBlbmRlZCkNCj4+ICsiIiINCj4+ICsNCj4+ICt2bSA9IGlvdGVzdHMu
Vk0oKQ0KPj4gK3ZtLmxhdW5jaCgpDQo+PiArDQo+PiArdm0ucW1wX2xvZygnYmxvY2tkZXYtYWRk
JywgKip7J25vZGUtbmFtZSc6ICd0YXJnZXQnLCAnZHJpdmVyJzogJ251bGwtY28nfSkNCj4+ICsN
Cj4+ICt2bS5xbXBfbG9nKCdibG9ja2Rldi1hZGQnLCAqKnsNCj4+ICsgICAgJ25vZGUtbmFtZSc6
ICdzb3VyY2UnLA0KPj4gKyAgICAnZHJpdmVyJzogJ2Jsa2RlYnVnJywNCj4+ICsgICAgJ2ltYWdl
Jzogeydub2RlLW5hbWUnOiAnYmFzZScsICdkcml2ZXInOiAnbnVsbC1jbycsICdzaXplJzogc2l6
ZX0NCj4+ICt9KQ0KPj4gKw0KPj4gK3ZtLnFtcF9sb2coJ2Jsb2NrZGV2LWFkZCcsICoqew0KPj4g
KyAgICAnbm9kZS1uYW1lJzogJ290aGVyJywNCj4+ICsgICAgJ2RyaXZlcic6ICdibGtkZWJ1Zycs
DQo+PiArICAgICdpbWFnZSc6ICdiYXNlJywNCj4+ICsgICAgJ3Rha2UtY2hpbGQtcGVybXMnOiBb
J3dyaXRlJ10NCj4+ICt9KQ0KPj4gKw0KPj4gK3ZtLnFtcF9sb2coJ2Jsb2NrZGV2LWJhY2t1cCcs
IHN5bmM9J2Z1bGwnLCBkZXZpY2U9J3NvdXJjZScsIHRhcmdldD0ndGFyZ2V0JykNCj4+ICsNCj4+
ICt2bS5zaHV0ZG93bigpDQo+IA0KPiBbLi4uXQ0KPiANCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9x
ZW11LWlvdGVzdHMvZ3JvdXAgYi90ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXANCj4+IGluZGV4IGNi
MmI3ODllNDQuLmQ4MjdlOGM4MjEgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0cy9xZW11LWlvdGVzdHMv
Z3JvdXANCj4+ICsrKyBiL3Rlc3RzL3FlbXUtaW90ZXN0cy9ncm91cA0KPj4gQEAgLTI4OCwzICsy
ODgsNCBAQA0KPj4gICAyNzcgcncgcXVpY2sNCj4+ICAgMjc5IHJ3IGJhY2tpbmcgcXVpY2sNCj4+
ICAgMjgwIHJ3IG1pZ3JhdGlvbiBxdWljaw0KPj4gKzI4MyBhdXRvIHF1aWNrDQo+IA0KPiBIbS4g
IFRoaXMgd291bGQgYmUgdGhlIGZpcnN0IFB5dGhvbiB0ZXN0IGluIGF1dG8uDQoNCk1pc3NlZCB0
aGF0LiBJdCdzIE9LIHRvIGRlZmluZSBpdCBqdXN0ICJxdWljayIgYW5kIHVwZGF0ZSBsYXRlci4N
Cg0KPiAgVGhvbWFz4oCZcyBzZXJpZXMgaGFzDQo+IGF0IGxlYXN0IG9uZSBwYXRjaCB0aGF0IHNl
ZW1zIHVzZWZ1bCB0byBjb21lIGJlZm9yZSB3ZSBkbyB0aGlzLCBuYW1lbHkNCj4g4oCcU2tpcCBQ
eXRob24tYmFzZWQgdGVzdHMgaWYgUUVNVSBkb2VzIG5vdCBzdXBwb3J0IHZpcnRpby1ibGvigJ0u
ICBTbyBJDQo+IHN1cHBvc2UgaGlzIHNlcmllcyBzaG91bGQgY29tZSBiZWZvcmUgdGhpcywgdGhl
bi4NCj4gDQo+IE1heA0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


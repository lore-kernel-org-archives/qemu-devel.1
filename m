Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E43CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23B321897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nB3W0WVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23B321897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLNgI-0000ar-F6
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 04:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLNdo-0007Sf-AS
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iLNdm-0007Yb-4T
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:29:43 -0400
Received: from mail-eopbgr60110.outbound.protection.outlook.com
 ([40.107.6.110]:8930 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iLNdl-0007X1-9p; Fri, 18 Oct 2019 04:29:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRaAzjyG/MdC/zVXfazoWuQAh6jpNP+Mmx2bE53D7352SDh/i3LJnU7YjsKgLSeez05/0Jzo3jwfOh9KeMdfnMqbIndST+tJaLBcFxUsx7j7bAIW7PkBr+zcrPiic/Rx7mOLTjz7D31jzbK+VxknYGbA8XxtMplGNtzqUPhsUY1CLIFOP82PdqezA1eI9MpjNp56WdCXXWMUIEGF9feEVHPINA2UPiExJL+b9zeNvtahENRNPq58d/CiC+uUHqZUl1SUFJYWdg4roEX8QZNK9mYf5O107evN3dybI9GuKxNZidp52PfiAZsa/VpIAO/Fgto9EM92VGgXeSMrFf/aYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfpKCIOScgofb0KQ2mhRhSwelupsnUtoobbXHIU/zt4=;
 b=WLGnXtEFH/2PAsR8atwK93ilTlP22n3SFHwLD7BiX9MLmH8b/vuK2+juGbsGRcVjR7ViKRYG7Y6NGHHdDwjSEPhhrcVbwp1eiaOwePP/YHo+4R1g+oDqie/7tBIrPcvszcac6/6v1SR7AnLlNo4ht5+cwJ3mLNiLTkoaffEaOa39+5RTkIFL20TnV4XW1bgrbgHKAD0uPf2Xgx+auoW32UBHSkekCh8Fzz+84MUidYV93EfU/YY8bs6vSKs+EdewtiGY5eOw3D7gkvxjxsjvhpo2oDWAys7RRTWcOfYgrAEEsH+KlP0BIdiI+HbhJReXqpPXHBBPb+77LXF65PDhGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfpKCIOScgofb0KQ2mhRhSwelupsnUtoobbXHIU/zt4=;
 b=nB3W0WVhwaeMaGAuwWX4GcnbAyWGS7T6GH9b4iLIGJKL2fNuJ0BqV7Zs24Gx02QYQH93GRkT6Tgp79v3V9nqpF8N+C4FYVaQB9q8fmMT3n9Hb/FMep1xzm7PhjXUyn7Vd45KLL7GWQv7mUUauB1Q2TcEoIYdDshHFkHOD6qR0Dg=
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com (20.179.35.83) by
 AM0PR08MB3764.eurprd08.prod.outlook.com (20.178.22.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.17; Fri, 18 Oct 2019 08:29:37 +0000
Received: from AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c]) by AM0PR08MB4435.eurprd08.prod.outlook.com
 ([fe80::4461:dd32:b358:110c%7]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 08:29:37 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Eric Blake <eblake@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v7 1/2] docs: improve qcow2 spec about extending image
 header
Thread-Topic: [PATCH v7 1/2] docs: improve qcow2 spec about extending image
 header
Thread-Index: AQHVfSj4NZxneckXjESRnSlwVfPCUadPn1aAgADVRwCAD61pgA==
Date: Fri, 18 Oct 2019 08:29:37 +0000
Message-ID: <2d60f7aa-7f3a-18f2-434f-0ab176924be2@virtuozzo.com>
References: <20191007160451.27334-1-vsementsov@virtuozzo.com>
 <20191007160451.27334-2-vsementsov@virtuozzo.com>
 <7afa803e-3efd-1186-2b37-7056d9a983f0@redhat.com>
 <90102485-ccbb-018c-c90d-b85a7b2f0392@virtuozzo.com>
In-Reply-To: <90102485-ccbb-018c-c90d-b85a7b2f0392@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0243.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::19) To AM0PR08MB4435.eurprd08.prod.outlook.com
 (2603:10a6:208:144::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191018112935463
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18f0e0e8-f435-433b-79f9-08d753a5500c
x-ms-traffictypediagnostic: AM0PR08MB3764:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB37644D4668682804D0EF928EC16C0@AM0PR08MB3764.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(346002)(39850400004)(366004)(376002)(136003)(199004)(189003)(81166006)(64756008)(4326008)(5660300002)(54906003)(305945005)(6486002)(6436002)(110136005)(316002)(7736002)(66476007)(26005)(8676002)(76176011)(486006)(81156014)(66446008)(476003)(66556008)(11346002)(446003)(186003)(36756003)(66946007)(256004)(52116002)(102836004)(386003)(2616005)(99286004)(53546011)(6506007)(478600001)(6116002)(2501003)(3846002)(31686004)(6512007)(71200400001)(14454004)(8936002)(25786009)(31696002)(86362001)(71190400001)(107886003)(229853002)(66066001)(2906002)(6246003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3764;
 H:AM0PR08MB4435.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fPhD6l41K7jnO/arbaPWHCCQ9AHOKeg93IPojMpvpBFprhObPdB9rdJKuqMmNxPzob2RN/yT+8RhUuIdyuXYzwRlMH04v+MPmfBiSLeJDpofY1VFqK1Iqvg1s97ZV6rrdNwFCE5QeFl+isMXYsMH7HjE2qH4yCMDVpgmX3Id7KGCrZ0FQ8STPRzownBAiqpZYd/5GXl052Mwe32VlFSMsGFqyWsNONr+K7C70NzoP41eLdGDASmAnY2Ql9WVeGEZP3YJpId5pyNYTzu8LBVDLFtpwiCJxso3SPFiIye8mcn92m1R4P8d7JeQqjQ4cot5gMVF68yYFy24mU5UJobRtqfBJSll9xtPkSKdklVRZDzwKZb3n4fa7jsVaWzLmW2L344DsnYjTdDU47nLusL3NSzKIQiUIDcjiXDF2jX1B74=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33047D9FC67EE04399D13DD5C9B98303@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f0e0e8-f435-433b-79f9-08d753a5500c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 08:29:37.5947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xl6X/E72lLjIJwg7hX/dTfiM+kQhVXWq8OxaXGDe+8H9Q1SmWgJHHfwscqBLDf+VQ8MlZWVR2TEgGPZBmAJDSExuWDJDQmRSqKPpOmIg+Zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3764
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.110
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDguMTAuMjAxOSAxMjowNSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MDcuMTAuMjAxOSAyMzoyMSwgRXJpYyBCbGFrZSB3cm90ZToNCj4+IE9uIDEwLzcvMTkgMTE6MDQg
QU0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gTWFrZSBpdCBtb3Jl
IG9idmlvdXMgaG93IHRvIGFkZCBuZXcgZmllbGRzIHRvIHRoZSB2ZXJzaW9uIDMgaGVhZGVyIGFu
ZA0KPj4+IGhvdyB0byBpbnRlcnByZXQgdGhlbS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+
PiAtLS0NCj4+PiDCoCBkb2NzL2ludGVyb3AvcWNvdzIudHh0IHwgMjYgKysrKysrKysrKysrKysr
KysrKysrKystLS0NCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kb2NzL2ludGVyb3AvcWNvdzIudHh0
IGIvZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0KPj4+IGluZGV4IGFmNTcxMWU1MzMuLjNmMjg1NTU5
M2YgMTAwNjQ0DQo+Pj4gLS0tIGEvZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0KPj4+ICsrKyBiL2Rv
Y3MvaW50ZXJvcC9xY293Mi50eHQNCj4+PiBAQCAtNzksOSArNzksOSBAQCBUaGUgZmlyc3QgY2x1
c3RlciBvZiBhIHFjb3cyIGltYWdlIGNvbnRhaW5zIHRoZSBmaWxlIGhlYWRlcjoNCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgT2Zmc2V0IGludG8gdGhlIGlt
YWdlIGZpbGUgYXQgd2hpY2ggdGhlIHNuYXBzaG90IHRhYmxlDQo+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXJ0cy4gTXVzdCBiZSBhbGlnbmVkIHRvIGEg
Y2x1c3RlciBib3VuZGFyeS4NCj4+PiAtSWYgdGhlIHZlcnNpb24gaXMgMyBvciBoaWdoZXIsIHRo
ZSBoZWFkZXIgaGFzIHRoZSBmb2xsb3dpbmcgYWRkaXRpb25hbCBmaWVsZHMuDQo+Pj4gLUZvciB2
ZXJzaW9uIDIsIHRoZSB2YWx1ZXMgYXJlIGFzc3VtZWQgdG8gYmUgemVybywgdW5sZXNzIHNwZWNp
ZmllZCBvdGhlcndpc2UNCj4+PiAtaW4gdGhlIGRlc2NyaXB0aW9uIG9mIGEgZmllbGQuDQo+Pj4g
K0ZvciB2ZXJzaW9uIDIsIGhlYWRlciBpcyBhbHdheXMgNzIgYnl0ZXMgbGVuZ3RoIGFuZCBmaW5p
c2hlcyBoZXJlLg0KPj4+ICtGb3IgdmVyc2lvbiAzIG9yIGhpZ2hlciB0aGUgaGVhZGVyIGxlbmd0
aCBpcyBhdCBsZWFzdCAxMDQgYnl0ZXMgYW5kIGhhcyBhdA0KPj4+ICtsZWFzdCBuZXh0IGZpdmUg
ZmllbGRzLCB1cCB0byB0aGUgQGhlYWRlcl9sZW5ndGggZmllbGQuDQo+Pg0KPj4gVGhpcyBodW5r
IHNlZW1zIG9rYXkuDQo+Pg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIDcyIC3CoCA3OTrCoCBp
bmNvbXBhdGlibGVfZmVhdHVyZXMNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgQml0bWFzayBvZiBpbmNvbXBhdGlibGUgZmVhdHVyZXMuIEFuIGltcGxlbWVu
dGF0aW9uIG11c3QNCj4+PiBAQCAtMTY1LDYgKzE2NSwyNiBAQCBpbiB0aGUgZGVzY3JpcHRpb24g
b2YgYSBmaWVsZC4NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgTGVuZ3RoIG9mIHRoZSBoZWFkZXIgc3RydWN0dXJlIGluIGJ5dGVzLiBGb3IgdmVyc2lvbiAy
DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGltYWdlcywg
dGhlIGxlbmd0aCBpcyBhbHdheXMgYXNzdW1lZCB0byBiZSA3MiBieXRlcy4NCj4+PiArQWRkaXRp
b25hbCBmaWVsZHMgKHZlcnNpb24gMyBhbmQgaGlnaGVyKQ0KPj4+ICsNCj4+PiArVGhlIGZvbGxv
d2luZyBmaWVsZHMgb2YgdGhlIGhlYWRlciBhcmUgb3B0aW9uYWw6IGlmIHNvZnR3YXJlIGRvbid0
IGtub3cgaG93IHRvDQo+Pj4gK2ludGVycHJldCB0aGUgZmllbGQsIGl0IG1heSBzYWZlbHkgaWdu
b3JlIGl0LiBTdGlsbCB0aGUgZmllbGQgbXVzdCBiZSBrZXB0IGFzIGlzDQo+Pj4gK3doZW4gcmV3
cml0aW5nIHRoZSBpbWFnZS4NCj4+DQo+PiBpZiBzb2Z0d2FyZSBkb2Vzbid0IGtub3cgaG93IHRv
IGludGVycHJldCB0aGUgZmllbGQsIGl0IG1heSBiZSBzYWZlbHkgaWdub3JlZCwgb3RoZXIgdGhh
biBwcmVzZXJ2aW5nIHRoZSBmaWVsZCB1bmNoYW5nZWQgd2hlbiByZXdyaXRpbmcgdGhlIGltYWdl
IGhlYWRlci4NCj4+DQo+PiBNaXNzaW5nOg0KPj4NCj4+IElmIGhlYWRlcl9sZW5ndGggZXhjbHVk
ZXMgYW4gb3B0aW9uYWwgZmllbGQsIHRoZSB2YWx1ZSBvZiAwIHNob3VsZCBiZSB1c2VkIGZvciB0
aGF0IGZpZWxkLg0KPiANCj4gVGhpcyBpcyB3aGF0IEkgZGlzbGlrZSBpbiBvbGQgd29yZGluZy4g
V2h5IGRvIHdlIG5lZWQgdGhpcyBkZWZhdWx0LXplcm8gdGhpbmdbKl0/IFdoYXQgaXMgdGhlIGRl
ZmF1bHQ/DQo+IA0KPiBEZWZhdWx0IGlzIGFic2VuY2Ugb2YgdGhlIGZlYXR1cmUsIHdlIGRvbid0
IGhhdmUgdGhlc2UgZnV0dXJlIGZlYXR1cmVzIG5vdyBhbmQgZG9uJ3QgY2FyZSBvZiB0aGVtLg0K
PiBXaGF0IGlzIHRoaXMgZGVmYXVsdCAwIGZvciB1cyBub3c/IE5vdGhpbmcuDQo+IA0KPiBDb25z
aWRlciBzb21lIGZ1dHVyZSB2ZXJzaW9uOiBpZiBpdCBzZWVzIHRoYXQgaGVhZGVyX2xlbmd0aCBl
eGNsdWRlcyBzb21lIGZpZWxkcywgaXQgdW5kZXJzdGFuZHMsDQo+IHRoYXQgdGhlcmUgaXMgbm8g
c3VjaCBmZWF0dXJlIGhlcmUuIFRoYXQncyBhbGwuIFdvcmsgd2l0aG91dCBpdC4gVGhlIGZlYXR1
cmUgaXRzZWxmIHNob3VsZCBkZWNsYXJlDQo+IGJlaGF2aW9yIHdpdGhvdXQgdGhpcyBmZWF0dXJl
LCB3aGljaCBzaG91bGQgY29ycmVzcG9uZCB0byBiZWhhdmlvciBiZWZvcmUgdGhpcyBmZWF0dXJl
IGludHJvZHVjdGlvbi4uDQo+IA0KPiBTbyBhdCBsZWFzdCwgSSBkb24ndCBsaWtlICJ0aGUgdmFs
dWUgb2YgMCBzaG91bGQgYmUgdXNlZCBmb3IgdGhhdCBmaWVsZCIsIGFzIGluc3RhbmNlcyBvZiBR
ZW11IHdoaWNoDQo+IGRvbid0IGtub3cgYWJvdXQgdGhlIGZlYXR1cmUgd2lsbCBpZ25vcmUgdGhp
cyByZXF1aXJlbWVudCwgYXMgdGhleSBkb24ndCBuZWVkIGFueSB2YWx1ZSBvZiB0aGF0DQo+IGZp
ZWxkIGF0IGFsbC4NCj4gDQo+IFdoYXQgeW91IGFjdHVhbGx5IG1lYW4sIElNSE8sIGlzOiBmb3Ig
YWxsIG9wdGlvbmFsIGZpZWxkIDAgdmFsdWUgbXVzdCBiZSBlcXVhbCB0byBhYnNlbmNlIG9mIHRo
ZSBmZWF0dXJlLA0KPiBsaWtlIHdoZW4gaGVhZGVyX2xlbmd0aCBleGNsdWRlcyB0aGlzIGZpZWxk
LiBJIGRvbid0IHNlZSwgZG8gd2UgcmVhbGx5IG5lZWQgdGhpcyByZXF1aXJlbWVudCwgYnV0DQo+
IHNlZW1zIGl0IHdhcyBtZW50aW9uZWQgYmVmb3JlIHRoaXMgcGF0Y2ggYW5kIHdlJ2QgYmV0dGVy
IGtlZXAgaXQuLiBJIGp1c3QgZG9uJ3QgbGlrZSBjb25jZXB0IG9mDQo+ICJkZWZhdWx0IiB2YWx1
ZSBrZWVwaW5nIGluIG1pbmQgdmFsaWQgUWVtdSBpbnN0YW5jZXMgd2hpY2ggZG9uJ3Qga25vdyBh
Ym91dCBmaWVsZCBhdCBhbGwuDQo+IA0KPj4NCj4+PiBAaGVhZGVyX2xlbmd0aCBtdXN0IGJlIGJv
dW5kIHRvIHRoZSBlbmQgb2Ygb25lIG9mDQo+Pj4gK3RoZXNlIGZpZWxkcyAob3IgdG8gQGhlYWRl
cl9sZW5ndGggZmllbGQgZW5kIGl0c2VsZiwgdG8gYmUgMTA0IGJ5dGVzKS4NCj4+DQo+PiBXZSBk
b24ndCB1c2UgdGhlIEBoZWFkZXJfbGVuZ3RoIG1hcmt1cCBhbnl3aGVyZSBlbHNlIGluIHRoaXMg
ZmlsZSwgc3RhcnRpbmcgdG8gZG8gc28gaGVyZSBpcyBvZGQuDQo+Pg0KPj4gSSB3b3VsZCBzdWdn
ZXN0IGEgc3Ryb25nZXIgcmVxdWlyZW1lbnQ6DQo+Pg0KPj4gaGVhZGVyX2xlbmd0aCBtdXN0IGJl
IGEgbXVsdGlwbGUgb2YgNCwgYW5kIG11c3Qgbm90IGxhbmQgaW4gdGhlIG1pZGRsZSBvZiBhbnkg
b3B0aW9uYWwgOC1ieXRlIGZpZWxkLg0KPj4NCj4+IE9yIG1heWJlIGV2ZW4gYWRkIG91ciBjb21w
cmVzc2lvbiB0eXBlIGV4dGVuc2lvbiB3aXRoIDQgYnl0ZXMgb2YgcGFkZGluZywgc28gdGhhdCB3
ZSBjb3VsZCBnbyBldmVuIHN0cm9uZ2VyOg0KPj4NCj4+IGhlYWRlcl9sZW5ndGggbXVzdCBiZSBh
IG11bHRpcGxlIG9mIDguDQo+IA0KPiBIbW0sIGlmIHdlIGltcGx5IHRoYXQgc29mdHdhcmUgd2ls
bCBoYXZlIHRvIGFkZCBzb21lIHBhZGRpbmcsIHRoYW4gcmVxdWlyZW1lbnQgYWJvdmUgYWJvdXQg
emVybyA9PT0gZmVhdHVyZS1hYnNlbmNlDQo+IGJlY29tZXMgbmVjZXNzYXJ5LiBbKl0NCj4gDQo+
IFN0aWxsIEkgaGF2ZSB0d28gcXVlc3Rpb25zOg0KPiAxLiBEbyB3ZSByZWFsbHkgbmVlZCBhbGwg
ZmllbGRzIHRvIGJlIDQgb3IgOCBieXRlcz8gV2h5IG5vdCB1c2UgMSBieXRlIGZvciBjb21wcmVz
c2lvbj8NCj4gMi4gV2hhdCBpcyB0aGUgYmVuZWZpdCBvZiBwYWRkaW5nLCB3aGljaCB5b3UgcHJv
cG9zZT8NCg0KSG1tLCBub3cgSSB0aGluaywgdGhhdCB3ZSBzaG91bGQgYWxpZ24gaGVhZGVyIHRv
IG11bHRpcGx5IG9mIDgsIGFzIGhlYWRlciBleHRlbnNpb25zIGFyZSBhbHJlYWR5IGhhdmUNCiIi
Ig0KRGlyZWN0bHkgYWZ0ZXIgdGhlIGltYWdlIGhlYWRlciwgb3B0aW9uYWwgc2VjdGlvbnMgY2Fs
bGVkIGhlYWRlciBleHRlbnNpb25zIGNhbg0KYmUgc3RvcmVkLiBFYWNoIGV4dGVuc2lvbiBoYXMg
YSBzdHJ1Y3R1cmUgbGlrZSB0aGUgZm9sbG93aW5nOg0KDQpbLi4uXQ0KDQogICAgICAgICAgIG4g
LSAgbTogICBQYWRkaW5nIHRvIHJvdW5kIHVwIHRoZSBoZWFkZXIgZXh0ZW5zaW9uIHNpemUgdG8g
dGhlIG5leHQNCiAgICAgICAgICAgICAgICAgICAgIG11bHRpcGxlIG9mIDguDQoiIiINCg0KU28s
IGl0IGxvb2tzIGluY29uc2lzdGVudCwgaWYgd2UgcGFkIGFsbCBoZWFkZXIgZXh0ZW5zaW9ucyB0
byAgOCBieXRlcyBleGNlcHQgZm9yIHRoZSBzdGFydCBvZiB0aGUgZmlyc3QgZXh0ZW5zaW9uLg0K
DQpJJ2xsIHJlc2VuZCB3aXRoIHBhZGRpbmcgc29vbi4NCg0KPiANCj4+DQo+Pj4gK1RoaXMgZGVm
aW5pdGlvbiBpbXBsaWVzIHRoZSBmb2xsb3dpbmc6DQo+Pj4gKzEuIFNvZnR3YXJlIG1heSBzdXBw
b3J0IHNvbWUgb2YgdGhlc2Ugb3B0aW9uYWwgZmllbGRzIGFuZCBpZ25vcmUgdGhlIG90aGVycywN
Cj4+PiArwqDCoCB3aGljaCBtZWFucyB0aGF0IGZlYXR1cmVzIG1heSBiZSBiYWNrcG9ydGVkIHRv
IGRvd25zdHJlYW0gUWVtdSBpbmRlcGVuZGVudGx5Lg0KPj4NCj4+IEkgZG9uJ3QgdGhpbmsgdGhp
cyBiZWxvbmdzIGluIHRoZSBzcGVjLg0KPiANCj4gTWUgdG9vLiBCdXQgYXQgbGVhc3QgSSBub3Rl
ZCB3aGF0IEkgdHJ5IHRvIGFjaGlldmUsIHNvIGNvbnNpZGVyIGl0IGEgYml0IGxpa2UgUkZDLiBB
bmQgb2YgY291cnNlIEkgaG9wZWQgZm9yIHlvdXIgcmV3b3JkaW5ncyApDQo+IA0KPj4gwqAgSWRl
YWxseSwgd2UgYWRkIGZpZWxkcyBzbyBpbmZyZXF1ZW50bHkgdGhhdCBiYWNrcG9ydGluZyBkb2Vz
bid0IGhhdmUgdG8gd29ycnkgYWJvdXQgYmFja3BvcnRpbmcgZmllbGQgMiB3aGlsZSBza2lwcGlu
ZyBmaWVsZCAxLg0KPiANCj4gV2hvIGtub3dzLi4gRXZlbiBoYXZpbmcgb25seSB0d28gZmllbGRz
IEEgYW5kIEIsIHdoZW4gd2UgbmVlZCBCIHdoaWNoIGFjdHVhbGx5IG5lZWRzIDEwIHBhdGNoZXMg
dG8gYmFja3BvcnQgYW5kIEEgbmVlZHMgMTAwIHdvdWxkIGJlDQo+IGEgcHJvYmxlbSwgaWYgd2Ug
Y2FuJ3QgYmFja3BvcnQgQiBpbiBzZXBhcmF0ZS4NCj4gDQo+IEkgcmVtZW1iZXIgc2ltaWxhciB0
aGluZyBhYm91dCBOQkQ6IEkgbmVlZGVkIEJMT0NLX1NUQVRVUywgYnV0IGJlY2F1c2Ugb2Ygc3Bl
Y2lmaWNhdGlvbiBJIGhhZCB0byBpbXBsZW1lbnQNCj4gc3RydWN0dXJlZCByZWFkIGZpcnN0LCB3
aGljaCB3YXNuJ3QgaW50ZXJlc3RpbmcgdG8gbWUgYXQgdGhhdCBtb21lbnQuDQo+IA0KPj4NCj4+
PiArMi4gU29mdHdhcmUgbWF5IGNoZWNrIEBoZWFkZXJfbGVuZ3RoLCBpZiBpdCBrbm93cyBvcHRp
b25hbCBmaWVsZHMgc3BlY2lmaWNhdGlvbg0KPj4+ICvCoMKgIGVub3VnaCAoa25vd3MgYWJvdXQg
dGhlIGZpZWxkIHdoaWNoIGV4Y2VlZHMgQGhlYWRlcl9sZW5ndGgpLg0KPj4NCj4+IEFnYWluLCBJ
IGRvbid0IHRoaW5rIHRoaXMgYWRkcyBhbnl0aGluZy7CoCBTaW5jZSB3ZSBhbHJlYWR5IGRvY3Vt
ZW50ZWQgZmllbGRzIGFyZSBvcHRpb25hbCwgYW5kIHRoYXQgaWYgaGVhZGVyX2xlbmd0aCBpcyB0
b28gc2hvcnQsIHRoZSBtaXNzaW5nIGZpZWxkIGlzIHRyZWF0ZWQgYXMgMCwgc29mdHdhcmUgdGhh
dCBrbm93cyBhYm91dCBhIGxvbmdlciBoZWFkZXJfbGVuZ3RoIHdpbGwgYWxyZWFkeSBoYW5kbGUg
aXQgY29ycmVjdGx5Lg0KPiANCj4gSSB0aGluaywgSSdsbCBtb3ZlIHRoZXNlIHBvaW50cyB0byBj
b21taXQgbWVzc2FnZSwgdG8ga2VlcCB0aGVtIHNvbWVob3cuDQo+IA0KPj4NCj4+PiArMy4gSWYg
QGhlYWRlcl9sZW5ndGggaXMgaGlnaGVyIHRoYW4gdGhlIGhpZ2hlc3QgZmllbGQgZW5kIHRoYXQg
c29mdHdhcmUga25vd3MsDQo+Pj4gK8KgwqAgaXQgc2hvdWxkIGFzc3VtZSB0aGF0IGFkZGl0aW9u
YWwgZmllbGRzIGFyZSBjb3JyZWN0LCBAaGVhZGVyX2xlbmd0aCBpcw0KPj4+ICvCoMKgIGNvcnJl
Y3QgYW5kIGtlZXAgQGhlYWRlcl9sZW5ndGggYW5kIGFkZGl0aW9uYWwgdW5rbm93biBmaWVsZHMg
YXMgaXMgb24NCj4+PiArwqDCoCByZXdyaXRpbmcgdGhlIGltYWdlLg0KPj4+ICszLiBJZiB3ZSB3
YW50IHRvIGFkZCBpbmNvbXBhdGlibGUgZmllbGQgKG9yIGEgZmllbGQsIGZvciB3aGljaCBzb21l
IGl0cyB2YWx1ZXMNCj4+PiArwqDCoCB3b3VsZCBiZSBpbmNvbXBhdGlibGUpLCBpdCBtdXN0IGJl
IGFjY29tcGFuaWVkIGJ5IGluY29tcGF0aWJsZSBmZWF0dXJlIGJpdC4NCj4+PiArDQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgIDwgLi4uIE5vIGFkZGl0aW9uYWwgZmllbGRzIGluIHRoZSBoZWFkZXIgY3Vy
cmVudGx5IC4uLiA+DQo+Pj4gKw0KPj4NCj4+IEknbSBzdGlsbCBub3Qgc2VlaW5nIHRoZSB2YWx1
ZSBpbiBhZGRpbmcgYW55IG9mIHRoaXMgcGFyYWdyYXBoIHRvIHRoZSBzcGVjLsKgIE1heWJlIGlu
IHRoZSBjb21taXQgbWVzc2FnZSB0aGF0IGFjY29tcGFuaWVzIHRoZSBzcGVjIGNoYW5nZSwgYnV0
IHRoZSBzcGVjIGlzIGNsZWFyIGVub3VnaCBpZiBpdCBkb2N1bWVudHMgaG93IG9wdGlvbmFsIGhl
YWRlciBmaWVsZHMgYXJlIHRvIGJlIG1hbmFnZWQgKHRyZWF0IGFzIDAgaWYgbWlzc2luZywgcHJl
c2VydmUgb24gd3JpdGUgaWYgdW5rbm93biwgYW5kIHdpdGggYSBtYW5kYXRlZCBhbGlnbm1lbnQg
dG8gYXZvaWQgaGF2aW5nIHRvIHdvcnJ5IGFib3V0IG90aGVyIGlzc3VlcykuDQo+Pg0KPj4+IMKg
IERpcmVjdGx5IGFmdGVyIHRoZSBpbWFnZSBoZWFkZXIsIG9wdGlvbmFsIHNlY3Rpb25zIGNhbGxl
ZCBoZWFkZXIgZXh0ZW5zaW9ucyBjYW4NCj4+PiDCoCBiZSBzdG9yZWQuIEVhY2ggZXh0ZW5zaW9u
IGhhcyBhIHN0cnVjdHVyZSBsaWtlIHRoZSBmb2xsb3dpbmc6DQo+Pj4NCj4+DQo+IA0KPiANCg0K
DQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=


Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCFCC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 06:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31D920843
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 06:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C3rAj/UW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31D920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxmlu-0003jm-PD
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 02:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxmkl-0002xr-JE
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 02:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxmkj-0003G9-9c
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 02:27:23 -0400
Received: from mail-eopbgr50113.outbound.protection.outlook.com
 ([40.107.5.113]:20385 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxmkd-0002yI-4B; Wed, 14 Aug 2019 02:27:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYkZKmEJjVhkWhJYzigToHbONVN633wYvruj+qXRTumZRcSkBIyHUgxp9hsDyx52RN30o5BdTDThZlece4Rdporf+DcBKH6Pqqd1R7iOeQj7gL5wX3COX3Av5DErUlVg0aS2InO2T7ilS+pFp8ratEYKM8QG9ObRNmgd+Zw2Ica5o2krlTHCkl636XwwmocjJ6LuaQrNHyikHgghkS4qpbRwNtokPD6kE7okMyPhrjrdrkqwvtDuMCtdjD+Y9PKgz/yY7TQwzmdD5IlWRy8r9jpkJuVy4c2/9zJYFVeVU+uVttdmWHkutZXP3dZXBUXNgN3/g0fbTtmL9yuVuP35vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BJQOYSRvPqXvmcRwBd9WsuqYAigAPp3P7ZFbKYJX0c=;
 b=ds5gS7y9383p3F+etuyc6zvp0aGTDyHpt5ztrWOrw0unDswaUmYlr5RvaOG1ce/hB0izDkdT2J2rH5ZQPgd9+l3SCJyWzS5mncMqHOlt7YXb6NXnK/k+n6EwxB1791m0oUelpIINOPdv54QmcqOckOk+6681FB875DnziVIDJ3krw3JNhhy0Hael56NdVZ0ep/wE6UX/2Tzsrxs2CM962dg7Ccj1GUKD4S/LhNV6KkWTddnH4t8QBYzBTXDvn6lYRLWQqPRl01paiqRHnKs5xliepbXW1u6kw67H5kKVCvdi6Pxp5E9TBlYl3PYr+MbUzlHSNNVh+OyvPjWY7n8OrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BJQOYSRvPqXvmcRwBd9WsuqYAigAPp3P7ZFbKYJX0c=;
 b=C3rAj/UW+5zNFOrVelRkBvT/Z5MX1/f1w1fZHQRvMsrjm53kwXL0neYtTQ0fdyqn5YBazQ3TZ7HHRUVeir5fV0xom4EZIUhso3sOt+qf0tur2ixAALCjkkWoI0Jw737In7vie44pIoTmJqsgbeD4c6Z1dLUiKMjyX1p6Rd7CAwM=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5308.eurprd08.prod.outlook.com (10.255.185.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Wed, 14 Aug 2019 06:27:11 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 06:27:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH 1/2] block/raw-format: switch to BDRV_BLOCK_DATA with
 BDRV_BLOCK_RECURSE
Thread-Index: AQHVUTlsaPHpCWSa5ku4nJrwFG1t86b4600AgAA9SACAABAVAIAAA6iAgAADzYCAAAbwgIAA6QaA
Date: Wed, 14 Aug 2019 06:27:10 +0000
Message-ID: <d38fddbe-ad4f-4de3-8bd8-b5c2f1dbe9a7@email.android.com>
In-Reply-To: <eabd92da-f213-56cd-033b-43676211db3f@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::22)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-android-message-id: <d38fddbe-ad4f-4de3-8bd8-b5c2f1dbe9a7@email.android.com>
x-originating-ip: [185.79.101.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30b94ffc-4454-45da-c8ce-08d720807038
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5308; 
x-ms-traffictypediagnostic: DB8PR08MB5308:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB53088454DC87AB3D65747C48C1AD0@DB8PR08MB5308.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(366004)(136003)(376002)(39850400004)(396003)(199004)(189003)(229853002)(8936002)(54906003)(14444005)(86362001)(53936002)(5660300002)(14454004)(316002)(11346002)(6512007)(7736002)(3846002)(476003)(9686003)(31696002)(26005)(107886003)(54896002)(6246003)(66066001)(2906002)(256004)(6916009)(81156014)(6506007)(71200400001)(186003)(102836004)(71190400001)(66446008)(66946007)(31686004)(66476007)(64756008)(6436002)(478600001)(8676002)(53546011)(99286004)(81166006)(66556008)(386003)(81686011)(6486002)(4326008)(52116002)(6116002)(25786009)(486006)(305945005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5308;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t3wz0mzGtQJvzehwr4gOlW4aq+CMmiImBSlUUxza+MbJ6CiHdQa8SWxYctKLOP06vYUysbylwpY78Bo0eWcZ3ZfDCAclhI3kX4yOcAouLJUqrhsPdJ3YATd9cauCbWHDxtZuQQyTNcPjrTZ5dXYGPMVB5puOjVAUyldOmgXLCDlBk6qleSvpd0ekCbWgx3niKztV9mr8YFU2wmWj/62INS4CLmrpISLn58U8fkpyoisOQJszfDI8ldh2n4cZkBh2tm7EZZlpV4yE8ZwOT72gXoQ+XDcCPWzykyf6FK9p/IJ9JPMNqSv2NG6xE7T/VtuSKsLzJXkku/EXjajYhmfjqWOUZ9mFHOFCkIgsYbbA5rXdjKqzorrepZQzLv3OW85BI6Z/0SwOaAYJE1v99iWPg97A6wEeLEsr+7PJF4VxVnU=
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b94ffc-4454-45da-c8ce-08d720807038
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 06:27:11.0289 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e0duQdxiwAQnjyQEoMxJkalzg2Aa0XHICxzev8ybOUAT+skRLkCRHMahybVI4plskTFJ3MLKBvHr5lfrxsQZuM5ew5ub+MedfvjlXqquofU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5308
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.5.113
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 1/2] block/raw-format: switch to
 BDRV_BLOCK_DATA with BDRV_BLOCK_RECURSE
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
Cc: Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCjEzINCw0LLQsy4gMjAxOSDQsy4gMTk6MzIg0L/QvtC70YzQt9C+0LLQsNGC0LXQu9GMIFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4g0L3Q
sNC/0LjRgdCw0Ls6DQoNCjEzLjA4LjIwMTkgMTk6MDgsIEtldmluIFdvbGYgd3JvdGU6DQo+IEFt
IDEzLjA4LjIwMTkgdW0gMTc6NTQgaGF0IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgZ2Vz
Y2hyaWViZW46DQo+PiAxMy4wOC4yMDE5IDE4OjQxLCBLZXZpbiBXb2xmIHdyb3RlOg0KPj4+IEFt
IDEzLjA4LjIwMTkgdW0gMTY6NDMgaGF0IE1heCBSZWl0eiBnZXNjaHJpZWJlbjoNCj4+Pj4gT24g
MTMuMDguMTkgMTM6MDQsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4+PiBBbSAxMi4wOC4yMDE5IHVt
IDIwOjExIGhhdCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IGdlc2NocmllYmVuOg0KPj4+
Pj4+IEJEUlZfQkxPQ0tfUkFXIG1ha2VzIGdlbmVyaWMgYmRydl9jb19ibG9ja19zdGF0dXMgdG8g
ZmFsbHRocm91Z2ggdG8NCj4+Pj4+PiByZXR1cm5lZCBmaWxlLiBCdXQgaXMgaXQgY29ycmVjdCBi
ZWhhdmlvciBhdCBhbGw/IElmIHJldHVybmVkIGZpbGUNCj4+Pj4+PiBpdHNlbGYgaGFzIGEgYmFj
a2luZyBmaWxlLCB3ZSBtYXkgcmVwb3J0IGFzIHRvdGFsbHkgdW5hbGxvY2F0ZWQgYW5kDQo+Pj4+
Pj4gYXJlYSB3aGljaCBhY3R1YWxseSBoYXMgZGF0YSBpbiBib3R0b20gYmFja2luZyBmaWxlLg0K
Pj4+Pj4+DQo+Pj4+Pj4gU28sIG1pcnJvcmluZyBvZiBxY293MiB1bmRlciByYXctZm9ybWF0IGlz
IGJyb2tlbi4gV2hpY2ggaXMgaWxsdXN0cmF0ZWQNCj4+Pj4+PiBieSBmb2xsb3dpbmcgY29tbWl0
IHdpdGggYSB0ZXN0LiBMZXQncyBtYWtlIHJhdy1mb3JtYXQgYmVoYXZlIG1vcmUNCj4+Pj4+PiBj
b3JyZWN0bHkgcmV0dXJuaW5nIEJEUlZfQkxPQ0tfREFUQS4NCj4+Pj4+Pg0KPj4+Pj4+IFN1Z2dl
c3RlZC1ieTogTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT4NCj4+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6by5j
b20+DQo+Pj4+Pg0KPj4+Pj4gQWZ0ZXIgc29tZSByZWFkaW5nLCBJIHRoaW5rIEkgY2FtZSB0byB0
aGUgY29uY2x1c2lvbiB0aGF0IFJBVyBpcyB0aGUNCj4+Pj4+IGNvcnJlY3QgdGhpbmcgdG8gZG8u
IFRoZXJlIGlzIGluZGVlZCBhIHByb2JsZW0sIGJ1dCB0aGlzIHBhdGNoIGlzIHRyeWluZw0KPj4+
Pj4gdG8gZml4IGl0IGluIHRoZSB3cm9uZyBwbGFjZS4NCj4+Pj4+DQo+Pj4+PiBJbiB0aGUgY2Fz
ZSB3aGVyZSB0aGUgYmFja2luZyBmaWxlIGNvbnRhaW5zIHNvbWUgZGF0YSwgYW5kIHdlIGhhdmUg
YQ0KPj4+Pj4gJ3Jhdycgbm9kZSBhYm92ZSB0aGUgcWNvdzIgb3ZlcmxheSBub2RlLCB0aGUgY29u
dGVudCBvZiB0aGUgcmVzcGVjdGl2ZQ0KPj4+Pj4gYmxvY2sgaXMgbm90IGRlZmluZWQgYnkgdGhl
IHF1ZXJpZWQgYmFja2luZyBmaWxlIGxheWVyLCBzbyBpdCBpcw0KPj4+Pj4gY29tcGxldGVseSBj
b3JyZWN0IHRoYXQgYmRydl9pc19hbGxvY2F0ZWQoKSByZXR1cm5zIGZhbHNlLGxpa2UgaXQgd291
bGQNCj4+Pj4+IGlmIHlvdSBxdWVyaWVkIHRoZSBxY293MiBsYXllciBkaXJlY3RseS4NCj4+Pj4N
Cj4+Pj4gSSBkaXNhZ3JlZS4gIFRoZSBxdWVyaWVkIGJhY2tpbmcgZmlsZSBsYXllciBpcyB0aGUg
cmF3IG5vZGUuICBBcyBJIHNhaWQsDQo+Pj4+IGluIG15IG9waW5pb24gcmF3IG5vZGVzIGFyZSBu
b3QgZmlsdGVyIG5vZGVzLCBuZWl0aGVyIGluIGJlaGF2aW9yICh0aGV5DQo+Pj4+IGhhdmUgYW4g
b2Zmc2V0IG9wdGlvbiksIG5vciBpbiBob3cgdGhleSBhcmUgZ2VuZXJhbGx5IHVzZWQgKGFzIGEg
Zm9ybWF0KS4NCj4+Pj4NCj4+Pj4gVGhlIHJhdyBmb3JtYXQgZG9lcyBub3Qgc3VwcG9ydCBiYWNr
aW5nIGZpbGVzLiAgVGhlcmVmb3JlLCBldmVyeXRoaW5nIG9uDQo+Pj4+IGEgcmF3IG5vZGUgaXMg
YWxsb2NhdGVkLg0KPj4+Pg0KPj4+PiAoVGhhdCBpcywgbGlrZSwgbXkgb3Bpbmlvbi4pDQo+Pj4+
DQo+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSWYgaXQg
cmV0dXJuZWQgdHJ1ZSwgd2Ugd291bGQNCj4+Pj4+IGNvcHkgZXZlcnl0aGluZywgd2hpY2ggaXNu
J3QgcmlnaHQgZWl0aGVyICh0aGUgdGVzdCBjYXNlcyBzaG91bGQgbWF5IGFkZA0KPj4+Pj4gdGhl
IHFlbXUtaW1nIG1hcCBvdXRwdXQgb2YgdGhlIHRhcmdldCBzbyB0aGlzIGJlY29tZXMgdmlzaWJs
ZSkuDQo+Pj4+DQo+Pj4+IEl0IGlzIHJpZ2h0Lg0KPj4+DQo+Pj4gU28gd2UgZG9uJ3QgZXZlbiBh
Z3JlZSB3aGF0IG1pcnJvcmluZyB0aGUgcmF3IG5vZGUgc2hvdWxkIGV2ZW4gbWVhbi4NCj4+Pg0K
Pj4+IEkgY2FuIHRoZSBzZWUgeW91ciBwb2ludCB3aGVuIHlvdSBzYXkgdGhhdCB0aGUgcmF3IG5v
ZGUgaGFzIG5vIGJhY2tpbmcNCj4+PiBmaWxlLCBzbyBldmVyeXRoaW5nIHNob3VsZCBiZSBjb3Bp
ZWQuIEJ1dCBJIGNhbiBhbHNvIHNlZSB0aGUgcG9pbnQgdGhhdA0KPj4+IHRoZSByYXcgbm9kZSBj
YW4gcmVhbGx5IGp1c3QgYmUgdXNlZCBhcyBhIGZpbHRlciB0aGF0IGxpbWl0cyB0aGUgZGF0YQ0K
Pj4+IGV4cG9zZWQgZnJvbSB0aGUgcWNvdzIgbGF5ZXIsIGFuZCB5b3Ugd2FudCB0byBrZWVwIHRo
ZSBjb3B5IGEgQ09XDQo+Pj4gb3ZlcmxheSBvdmVyIHRoZSBzYW1lIGJhY2tpbmcgZmlsZS4NCj4+
Pg0KPj4+IEJvdGggYXJlIHZhbGlkIHVzZSBjYXNlcyBpbiBwcmluY2lwbGUgYW5kIHRoZXJlIGlz
IG5vIHNpbmdsZSByaWdodCBvcg0KPj4+IHdyb25nLg0KPj4+DQo+Pj4gV2UgZG9uJ3QgY3VycmVu
dGx5IHN1cHBvcnQgdGhlIGxhdHRlciB1c2UgY2FzZSBiZWNhdXNlIHdlIGhhdmUgb25seQ0KPj4+
IHN5bmM9ZnVsbCBvciBzeW5jPXRvcCwgYnV0IGlmIHlvdSBjb3VsZCBzcGVjaWZ5IGEgYmFzZSBu
b2RlIGluc3RlYWQsIHdlDQo+Pj4gY291bGQgcHJvYmFibHkgc3Vwb3J0IHRoZSBjYXNlIHdpdGhv
dXQgYWxsIG9mIHRoZSBzcGVjaWFsLWNhc2luZyBmaWx0ZXINCj4+PiBub2RlcyBhbmQgYmFja2lu
ZyBmaWxlIGNoaWxkcy4NCj4+Pg0KPj4+IFlvdSB3b3VsZCBjYWxsIGJkcnZfY29fYmxvY2tfc3Rh
dHVzX2Fib3ZlKCkgd2l0aCB0aGUgcmlnaHQgYmFzZSBub2RlIGFuZA0KPj4+IGl0IHdvdWxkIGp1
c3QgcmVjdXJzZSB3aGVyZWV2ZXIgdGhlIGRhdGEgaXMgc3RvcmVkLCBiZSBpdCBicy0+YmFja2lu
ZywNCj4+PiBicy0+ZmlsZSBvciBldmVuIGRyaXZlci1zcGVjaWZpYyBjaGlsZHJlbi4gVGhpcyB3
b3VsZCBhbGxvdyB5b3UgdG8gZmluZA0KPj4+IG91dCB3aGV0aGVyIHNvbWUgYmxvY2sgaW4gdGhl
IHRvcCBub2RlIGNhbWUgZnJvbSB0aGUgYmFzZSBub2RlIHRoYXQNCj4+PiB3ZSdyZSBnb2luZyB0
byBrZWVwLiBJZiB5ZXMsIHNraXAgaXQ7IGlmIG5vLCBjb3B5IGl0Lg0KPj4+DQo+Pj4gVGhpcyB3
YXkgd2Ugd291bGRuJ3QgaGF2ZSB0byBkZWNpZGUgd2hldGhlciByYXcgaXMgYSBmaWx0ZXIgb3Ig
bm90LA0KPj4+IGJlY2F1c2UgaXQgd291bGRuJ3QgbWFrZSBhIGRpZmZlcmVuY2UuIFRoZSBiZWhh
dmlvdXIgd291bGQgb25seSBkZXBlbmQNCj4+PiBvbiB0aGUgYmFzZSBub2RlIGdpdmVuIGJ5IHRo
ZSB1c2VyLiBJZiB5b3Ugc3BlY2lmaWVkIHRoZSB0b3AtbGV2ZWwgcWNvdzINCj4+PiBmaWxlIGFz
IHRoZSBiYXNlLCB5b3UgZ2V0IHlvdXIgZnVsbCBjb3B5Ow0KPj4NCj4+IGFobSwgZnVsbC1jb3B5
ID0gYmFzZSBpcyBOVUxMLi4NCj4NCj4gT29wcywgeWVzLCBvZiBjb3Vyc2UuIFVzaW5nIHRoZSB0
b3AtbGV2ZWwgbm9kZSB3b3VsZCBjcmVhdGUgYW4gZW1wdHkNCj4gImNvcHkiLg0KPg0KPj4+IGlm
IHlvdSBzcGVjaWZpZWQgdGhlIGJhY2tpbmcNCj4+PiBxY293MiwgeW91IGdldCB0aGUgcGFydGlh
bCBjb3B5IHdoZXJlIHRoZSB0YXJnZXQgc3RpbGwgdXNlcyB0aGUgc2FtZQ0KPj4+IGJhY2tpbmcg
ZmlsZS4NCj4+Pg0KPj4+IChIbS4uLiBJdCB3b3VsZCBvbmx5IGFjdHVhbGx5IHdvcmsgaWYgdGhl
IG9mZnNldHMgc3RheSB0aGUgc2FtZSBpbiB0aGUNCj4+PiBjaGFpbiwgd2hpY2ggaXMgdHJ1ZSBm
b3IgYmFja2luZyBmaWxlIGNoaWxkcmVuLCBidXQgbm90IG5lY2Vzc2FyaWx5IGZvcg0KPj4+IG90
aGVyIGNoaWxkcmVuLg0KPj4NCj4+IERvbid0IGZvbGxvdywgd2hhdCB5b3UgbWVhbiBieSBvZmZz
ZXRzIHN0YXkgdGhlIHNhbWUgYW5kIHdoYXQgaXMgd3JvbmcNCj4+IHdpdGggaXQ/DQo+DQo+IFNh
eSB3ZSBoYXZlIHRoaXMgZ3JhcGg6DQo+DQo+IHJhdyxvZmZzZXQ9NjU1MzYNCj4gICAgICB8DQo+
ICAgICAgdg0KPiAgICBxY293Mi0tLS0tKw0KPiAgICAgIHwgICAgICAgfA0KPiAgICAgIHYgICAg
ICAgdg0KPiAgICBmaWxlICAgICBiYXNlDQo+DQo+IE5vdyB5b3UgY2FuJ3QganVzdCBtaXJyb3Ig
dGhlIHJhdyBub2RlIGludG8gYSB0YXJnZXQucWNvdzIgdGhhdCBzaGFyZXMNCj4gYmFzZSBhcyB0
aGUgYmFja2luZyBmaWxlLCBiZWNhdXNlIHRoZSBvZmZzZXRzIHdpbGwgYmUgd3JvbmcuIEluIG9y
ZGVyIHRvDQo+IHVzZSBzdWNoIGEgY29weSBjb3JyZWN0bHksIHlvdSdkIGhhdmUgdG8gdXNlIGEg
cmF3IG5vZGUgYWdhaW4gaW4gdGhlDQo+IGJhY2tpbmcgY2hhaW46DQo+DQo+IHRhcmdldC5xY293
Mi0tLS0rDQo+ICAgICAgfCAgICAgICAgICAgfA0KPiAgICAgIHYgICAgICAgICAgIHYNCj4gICAg
ZmlsZSAgICAgIHJhdyxvZmZzZXQ9NjU1MzYNCj4gICAgICAgICAgICAgICAgICB8DQo+ICAgICAg
ICAgICAgICAgICAgdg0KPiAgICAgICAgICAgICAgICBiYXNlDQo+DQo+IFNvIHRoZSBjYXNlIHdo
ZXJlIG9mZnNldHMgZGlmZmVyIGJldHdlZW4gdGhlIHRvcCBhbmQgdGhlIGJhc2Ugbm9kZSBpc24n
dA0KPiB0cml2aWFsLg0KDQpVbmRlcnN0YW5kLCBidXQgZm9yIG1lIGl0IGRvbid0IGxvb2sgbGlr
ZSB0aGUgdGhpbmcgdGhhdCBiZWhhdmVzIGluIHVuZXhwZWN0ZWQNCmZvciB1c2VyIHdheSwgb24g
dGhlIGNvbnRyYXJ5LCBpdCBzZWVtcyBvYnZpb3VzIHRoYXQgaXQgd2lsbCBub3Qgd29yaywgYXMg
dXNlcg0KdW5kZXJzdGFuZCB3aGF0IGlzIGJhY2tpbmcgZmlsZSAob2Zmc2V0cyBhcmUgYmFja2Vk
IGJ5IGNvcnJlc3BvbmRpbmcgb2Zmc2V0cykNCg0KPg0KPiAoSWYgdGhpcyBjYXNlIGlzbid0IGNv
bXBsaWNhdGVkIGVub3VnaCB5ZXQsIGltYWdpbmUgcGFzc2luZyBmaWxlIGFzIHRoZQ0KPiBiYXNl
IG5vZGUgaW5zdGVhZC4uLiBJdCBqdXN0IGNhbid0IHdvcmsuKQ0KPg0KDQpZZXMsIGlmIHdlIGNo
b3NlIHRoZSB3YXkgeW91IHByb3Bvc2VkIHdlIGhhdmUgYSBwb3NzaWJpbGl0eSB0byB1c2UgYW55
IG5vZGUgYXMgYSBiYXNlLA0KYnV0IGFnYWluIHRoaXMgZG9lcyBzb21ldGhpbmcgY29tcGxldGVs
eSBkaWZmZXJlbnQgZnJvbSB1c3VhbCAidG9wIiBvciAiYmFzZWQiIG1vZGUuLg0KU28gaXQncyBq
dXN0IGEgbmV3IHBvc3NpYmlsaXR5LCBtYXkgYmUgdXNlbGVzcywgaXQgZG9uJ3QgYnJlYWsgdXAg
dGhlIGNvbmNlcHQuDQoNCg0KSSBsaWtlIHRoZSBpZGVhIG9mIGdlbmVyaWMgYmxvY2tfc3RhdHVz
X2Fib3ZlIHRoYXQgeW91IHByb3Bvc2UsIGJ1dCBzdGlsbCB0aGVyZSBzaG91bGQNCmEgZGVjaXNp
b24gb2Ygd2hhdCBleGFjdGx5IERBVEEsIFpFUk8gYW5kIEFMTE9DQVRFRCBtZWFucy4gT2ssIGFz
c3VtZSB3ZSBkb24ndCBuZWVkIEFMTE9DQVRFRC4uDQpUaGVuIHdlIGRvbid0IG5lZWQgREFUQSB0
b28/DQoNCkFuZCBob3cgYmxvY2tfc3RhdHVzX2Fib3ZlIHdvdWxkIHdvcms/IElmIG5vZGUgZG9u
J3QgcmVwb3J0IFpFUk8gYW5kIGRvbid0IHJlcG9ydCBEQVRBIGJ1dCByZXBvcnQNCipmaWxlIHBv
aW50ZXIgPT0gYmFzZSwgd2Ugc2hvdWxkIHN0b3AsIGFuZCBkb24ndCBnbyB0byAqZmlsZSwgaXQg
c2VlbXMgb2J2aW91cy4uDQoNCkJ1dCB3aGF0IGlmIG5vZGUgcmVwb3J0cyBaRVJPIHRvZ2V0aGVy
IHdpdGggKmZpbGUgcG9pbnRlciA9PSBiYXNlPyBTaG91bGQgY29uc2lkZXIgdGhpcyByZWdpb24N
CmJlbG9uZ2luZyB0byBiYXNlIGFuZCBVTkFMTE9DQVRFRCBhbmQgbm90IGNvcHkgaXQsIG9yIHdl
IHNob3VsZCBjb25zaWRlciBpdCBBTExPQ0FURUQgYmVjYXVzZQ0KY3VycmVudCBub2RlIHJlcG9y
dHMgaXQgWkVSTz8gU28sIGNyaXRlcmlhIG9mICJBTExPQ0FURUQiIG9yICJ3aGVyZSBzaG91bGQg
d2Ugc3RvcCBpbiByZWN1cnNpb24iDQppcyBub3Qgb2J2aW91cy4uIERvIHlvdSBoYXZlIG9uZT8N
Cg0KQW5kIG5vdyBJIHNlZSBhIGRyYXdiYWNrIG9mIGZ1bGwgcmVjdXJzaW9uIGFzIEtldmluIHBy
b3Bvc2VzOiBpdCdzIHNsb3dlciB3aGVuIHdlIGFyZSBpbnRlcmVzdGVkIGluIGFsbG9jYXRpb24u
IFdlIGRvbid0IG5lZWQgdG8gcmVjdXJzZSB0aHJvdWdoIGZpbGUqIGJhY2tpbmcgY2hhaW4sIGlm
ICpmaWxlIGlzIG5vdCBiYWNraW5nLCBhcyB3ZSBhbHJlYWR5IGtub3cgdGhhdCBkYXRhIGlzIGFs
bG9jYXRlZC4NCg==

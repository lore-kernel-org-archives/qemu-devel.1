Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EC3C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0D0205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="AMZTpdT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0D0205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxYEK-0007qJ-Hn
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43953)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxYDe-0007Me-OU
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxYDd-0001XC-NN
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:56:14 -0400
Received: from mail-eopbgr150115.outbound.protection.outlook.com
 ([40.107.15.115]:23800 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxYDd-0001Wd-0u; Tue, 13 Aug 2019 10:56:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUdOl90xVUvOgdLf4ERJoyK5662fAkhNU14ds3AaYYyTZF3foY50SPeph0tMEmwk0ReXzHhwp7DRbbAmiTtJyqkVh3tSjMFUQu9iowj/Wr+tCpV8852j9szRYRpuqWyHRsQ5FqqV6LrS+aHSakjDuhes9DjQOeZS5LAH5xuCv5votEZxgrsevEnw0AMVOEjok8w3h0tr4lFRtlfRT/1dAVVNGq4ZTWL8J1p88fwssHpJSLRFqrb6c5xci8GSfZ7831hOvKfzpqz3Ur6dCRFMZ3h0N2SfQD8y5CDHxuYsTz2dM6szufx9xcyV3Y4S3EgL/T5tMi6e2icad2n6makDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeI3l6cteEK1zHD8hSmiV4pxFG4OInfd9n6ckvk0Tjo=;
 b=U3EeD+SYuiA6PqvXiX0e1WbPrMbQq3/vOHZc/jdwyeNrnoTg5RNgpNxeONDZxaWzvBf5UZam7xkGHmIpKE4ydRU47arz6d15qJLNTOo8+fbqA7R+s4rkNAeIqEBE7esoXjVzZ+2+jSDwuftLOWBluWMBjUkpT27uQDoCdVWHw3oN/U+lu2o8GuD8AWZaRacjhBWqg11KxLgIGiN+wiNQHMl+ivu3OcCUPVGs71yCyV2RWdU6A3Qa71hIuUksHPZemq++27IEPu2Od9lBhqek52GDJzSOtkkTU/xz/p2tOEE2idNRe+fZCqxbwTd0Noaj2S96vMHidigtcWhau0H4KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeI3l6cteEK1zHD8hSmiV4pxFG4OInfd9n6ckvk0Tjo=;
 b=AMZTpdT7Dz7yWIpg8DP1vzN3mCKrn0iwkDDCrq/Kxw0GHvSCVjWY5GGUk/hZckzmivCJA8koW2USdmEJYeHQ2Dzct7K9JBc2RCxddgdnGE8G/cW/GvPxp0xFC44h4bUcMKj4HWsO0XBB3iwIaKIM6o0gH9F5W3P4on9KjQMYBnA=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5083.eurprd08.prod.outlook.com (10.255.18.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 14:56:11 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 14:56:11 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH 1/2] block/raw-format: switch to BDRV_BLOCK_DATA with
 BDRV_BLOCK_RECURSE
Thread-Index: AQHVUTlsaPHpCWSa5ku4nJrwFG1t86b4600AgAA9SACAAANyAA==
Date: Tue, 13 Aug 2019 14:56:11 +0000
Message-ID: <6af67f42-b5ee-1ca9-6fb1-500fd993616a@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
In-Reply-To: <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0326.eurprd05.prod.outlook.com
 (2603:10a6:7:92::21) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813175608922
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a67a6b2-257e-493d-a94d-08d71ffe613b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5083; 
x-ms-traffictypediagnostic: DB8PR08MB5083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5083A0EDB7803732E51D0EEDC1D20@DB8PR08MB5083.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(39840400004)(366004)(346002)(376002)(199004)(189003)(6436002)(31686004)(66476007)(64756008)(53546011)(66946007)(81166006)(386003)(99286004)(8676002)(66446008)(66556008)(186003)(71200400001)(81156014)(6506007)(478600001)(71190400001)(486006)(305945005)(102836004)(4326008)(6486002)(76176011)(52116002)(6116002)(3846002)(7736002)(2616005)(229853002)(6512007)(316002)(14454004)(476003)(86362001)(54906003)(446003)(110136005)(8936002)(11346002)(25786009)(5660300002)(2906002)(6246003)(256004)(107886003)(36756003)(31696002)(26005)(66066001)(53936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5083;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 16zeVakB+e2jLSoSEz7ttZc2/bs7m9ycYdujUs6WyVp4ZKuTM8AQz1S0qDFRbri8Jq9zGzxZR9FGstMXbVtAH+Bw+9Pg9YVgkKHymBi+fKxvkfvePhtDlbZuvirFC/Ohr7pgQLMkNKETBJT5N8ao1x/cXiysGWxKQeSdcAmXLknG7yV6D1q70DJD3z1k5rEcLqJuYOnsiL4rqnOXtf309syQ66EqL2PH0FQXXZ0UfJ6IjA2XRgNJBAWNgI7CNugyDtTh4tTdFslmipvQrFHlPuobWT9/KyLMmoV+C39FiHZGTe5FxtYk0K1yF05hPY567xFPaLHeqIBnP5NF75Ju+4XMVCuwAZCgwiSVHhZM3Cw9si9jjfCQPXl+mdSaz6G9yuDHw5JB9FQOJHYrmHOrZD4bIJJJ0pbybfZdNJX9Umk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC1E4B6F562B7047AB0F459BF71DBFD0@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a67a6b2-257e-493d-a94d-08d71ffe613b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 14:56:11.0469 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOyH+40GHX1NaFYhzp+y095ZLaBZSDKjr198NaPKWSzCsIRXJxFd4iT+iFyOm+FOKREklVdIuHkP9LXdWWHh+1aDbhKGTnk4aRNgjnPpf2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5083
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.15.115
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTMuMDguMjAxOSAxNzo0MywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxMy4wOC4xOSAxMzowNCwg
S2V2aW4gV29sZiB3cm90ZToNCj4+IEFtIDEyLjA4LjIwMTkgdW0gMjA6MTEgaGF0IFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgZ2VzY2hyaWViZW46DQo+Pj4gQkRSVl9CTE9DS19SQVcgbWFr
ZXMgZ2VuZXJpYyBiZHJ2X2NvX2Jsb2NrX3N0YXR1cyB0byBmYWxsdGhyb3VnaCB0bw0KPj4+IHJl
dHVybmVkIGZpbGUuIEJ1dCBpcyBpdCBjb3JyZWN0IGJlaGF2aW9yIGF0IGFsbD8gSWYgcmV0dXJu
ZWQgZmlsZQ0KPj4+IGl0c2VsZiBoYXMgYSBiYWNraW5nIGZpbGUsIHdlIG1heSByZXBvcnQgYXMg
dG90YWxseSB1bmFsbG9jYXRlZCBhbmQNCj4+PiBhcmVhIHdoaWNoIGFjdHVhbGx5IGhhcyBkYXRh
IGluIGJvdHRvbSBiYWNraW5nIGZpbGUuDQo+Pj4NCj4+PiBTbywgbWlycm9yaW5nIG9mIHFjb3cy
IHVuZGVyIHJhdy1mb3JtYXQgaXMgYnJva2VuLiBXaGljaCBpcyBpbGx1c3RyYXRlZA0KPj4+IGJ5
IGZvbGxvd2luZyBjb21taXQgd2l0aCBhIHRlc3QuIExldCdzIG1ha2UgcmF3LWZvcm1hdCBiZWhh
dmUgbW9yZQ0KPj4+IGNvcnJlY3RseSByZXR1cm5pbmcgQkRSVl9CTE9DS19EQVRBLg0KPj4+DQo+
Pj4gU3VnZ2VzdGVkLWJ5OiBNYXggUmVpdHogPG1yZWl0ekByZWRoYXQuY29tPg0KPj4+IFNpZ25l
ZC1vZmYtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVv
enpvLmNvbT4NCj4+DQo+PiBBZnRlciBzb21lIHJlYWRpbmcsIEkgdGhpbmsgSSBjYW1lIHRvIHRo
ZSBjb25jbHVzaW9uIHRoYXQgUkFXIGlzIHRoZQ0KPj4gY29ycmVjdCB0aGluZyB0byBkby4gVGhl
cmUgaXMgaW5kZWVkIGEgcHJvYmxlbSwgYnV0IHRoaXMgcGF0Y2ggaXMgdHJ5aW5nDQo+PiB0byBm
aXggaXQgaW4gdGhlIHdyb25nIHBsYWNlLg0KPj4NCj4+IEluIHRoZSBjYXNlIHdoZXJlIHRoZSBi
YWNraW5nIGZpbGUgY29udGFpbnMgc29tZSBkYXRhLCBhbmQgd2UgaGF2ZSBhDQo+PiAncmF3JyBu
b2RlIGFib3ZlIHRoZSBxY293MiBvdmVybGF5IG5vZGUsIHRoZSBjb250ZW50IG9mIHRoZSByZXNw
ZWN0aXZlDQo+PiBibG9jayBpcyBub3QgZGVmaW5lZCBieSB0aGUgcXVlcmllZCBiYWNraW5nIGZp
bGUgbGF5ZXIsIHNvIGl0IGlzDQo+PiBjb21wbGV0ZWx5IGNvcnJlY3QgdGhhdCBiZHJ2X2lzX2Fs
bG9jYXRlZCgpIHJldHVybnMgZmFsc2UsbGlrZSBpdCB3b3VsZA0KPj4gaWYgeW91IHF1ZXJpZWQg
dGhlIHFjb3cyIGxheWVyIGRpcmVjdGx5Lg0KPiANCj4gSSBkaXNhZ3JlZS4gIFRoZSBxdWVyaWVk
IGJhY2tpbmcgZmlsZSBsYXllciBpcyB0aGUgcmF3IG5vZGUuICBBcyBJIHNhaWQsDQo+IGluIG15
IG9waW5pb24gcmF3IG5vZGVzIGFyZSBub3QgZmlsdGVyIG5vZGVzLCBuZWl0aGVyIGluIGJlaGF2
aW9yICh0aGV5DQo+IGhhdmUgYW4gb2Zmc2V0IG9wdGlvbiksIG5vciBpbiBob3cgdGhleSBhcmUg
Z2VuZXJhbGx5IHVzZWQgKGFzIGEgZm9ybWF0KS4NCj4gDQo+IFRoZSByYXcgZm9ybWF0IGRvZXMg
bm90IHN1cHBvcnQgYmFja2luZyBmaWxlcy4gIFRoZXJlZm9yZSwgZXZlcnl0aGluZyBvbg0KPiBh
IHJhdyBub2RlIGlzIGFsbG9jYXRlZC4NCj4gDQoNCkNvdWxkIHlvdSB0ZWxsIG1lIGF0IGxlYXN0
LCB3aGF0IG1lYW5zICJhbGxvY2F0ZWQiID8NCg0KSXQncyBhIHRlcm0gdGhhdCBkZXNjcmliaW5n
IGEgcmVnaW9uIHNvbWVob3cuLiBCdXQgaG93PyBBbGxvY2F0ZWQgd2hlcmU/DQpJbiByYXcgbm9k
ZSwgaW4gaXRzIGNoaWxkIG9yIGJvdGg/IEFtIEkgcmlnaHQgdGhhdCBpZiByZWdpb24gYWxsb2Nh
dGVkIGluDQpvbmUgb2Ygbm9uLWNvdyBjaGlsZHJlbiBpdCBpcyBhc3N1bWVkIHRvIGJlIGFsbG9j
YXRlZCBpbiBwYXJlbnQgdG9vPyBPciB3aGF0Pw0KDQpBbmQgaXQncyB1bnJlbGF0ZWQgdG8gcmVh
bCBkaXNrIGFsbG9jYXRpb24gd2hpY2ggKElNSE8pIGRpcmVjdGx5IHNob3dzIHRoYXQNCnRoaXMg
YSBiYWQgdGVybS4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K


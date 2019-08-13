Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65629C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2C020679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="NiG1VpLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2C020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxZjn-0002EZ-F1
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 12:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58453)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxZjJ-0001hS-As
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hxZjH-0005KJ-Nu
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:33:01 -0400
Received: from mail-eopbgr140105.outbound.protection.outlook.com
 ([40.107.14.105]:51332 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hxZjH-0005I0-5t; Tue, 13 Aug 2019 12:32:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gksJW/T2Bk5d0Wbclak5XBE8ct1u/048uLqQro8qWu3XpjkvsIfxfZVKpBVvDLSzmcJJE0PCz+UAx9xSfE2nMzNVK+2CXKCkIjAc5FRDfCEwxvDhh5PHUR5y8A98E8RsCwf2J5h6UGSzSYqFh7dETtoyQqea8w0EgUa4KA/mWusmNt7HhmSuPGBrcpvM2WLXhlmIiSi03IZulD2ofEbuGE+jP73MMFNEwE+c3iKaRgKo7ja4UcF0waNn8VM67c8wdanu1ZWf3f1PUcdzhJKayyNFDr0Hl+VLUwA2a01FsoB16Ah8R/AoqKIBbO+iDDEY4Ys3+deD56cZJEy/C/yv8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV6Q45sSVBY5LmE3hPKuPE4LfVZlv4nWA6GKZoHtX00=;
 b=PTyJ6rRH9ODhrxqxvm2Lcj/ZShI4CUIZeddGSR5EngPbA10hPvKjWOjAhGm4iko2tqA9XX0iJdSTkmB29vwdaMa2gSmCHG0UcJRY8RHl01EzDRGJob37rnKgsfYD63/6oCRVsWerQHIfJzntb8kij1xcR5FP2SLx2mU8FFCjh/8PSC//WJGOe3tp/VD8Ivb8VbekqcsNLUozHH4xvEgRJFQLQ4B64XXrM+sMZcSPBPqMrEyOosAdLJwFK5ZVYGJ7/1uQTWP/ruz6gHq9K00Efc/7eLFBCn1nrsvMf7HCChXrfQqvNiRDuoc6uVqZ3SrUjSInVeiawUj1tm+vOaMpEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV6Q45sSVBY5LmE3hPKuPE4LfVZlv4nWA6GKZoHtX00=;
 b=NiG1VpLBH0UgX/9oRWjm2IiDoYBjmAdhN5+SXSHsJGovcZc400lhx9WG6B1XLCLaPAv5A6RUd9TkquPFJ7CH6dT/X3UnXeH8MGS+jAJUBpIvkHW434pYaqzUnB8KgZ4pS3QE1IWSOjfeQkQEPNCDkQ8CxY4/c4pdN6YfBxdCgmU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5322.eurprd08.prod.outlook.com (10.255.185.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 16:32:56 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 16:32:56 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>
Thread-Topic: [PATCH 1/2] block/raw-format: switch to BDRV_BLOCK_DATA with
 BDRV_BLOCK_RECURSE
Thread-Index: AQHVUTlsaPHpCWSa5ku4nJrwFG1t86b4600AgAA9SACAABAVAIAAA6iAgAADzYCAAAbwgA==
Date: Tue, 13 Aug 2019 16:32:55 +0000
Message-ID: <eabd92da-f213-56cd-033b-43676211db3f@virtuozzo.com>
References: <20190812181146.26121-1-vsementsov@virtuozzo.com>
 <20190812181146.26121-2-vsementsov@virtuozzo.com>
 <20190813110428.GE4663@localhost.localdomain>
 <fef7f4d1-b40e-6c84-3952-120a641a8061@redhat.com>
 <20190813154122.GL4663@localhost.localdomain>
 <2e70844b-bf08-9160-b3ca-21b364b74d48@virtuozzo.com>
 <20190813160803.GM4663@localhost.localdomain>
In-Reply-To: <20190813160803.GM4663@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0802CA0015.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::25) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190813193253518
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 679860f3-d036-47e6-7a41-08d7200be51a
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5322; 
x-ms-traffictypediagnostic: DB8PR08MB5322:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB5322B466735C041FE3786880C1D20@DB8PR08MB5322.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(376002)(39850400004)(396003)(189003)(199004)(386003)(102836004)(25786009)(316002)(54906003)(52116002)(305945005)(76176011)(31686004)(476003)(2616005)(186003)(86362001)(446003)(486006)(7736002)(53546011)(11346002)(66066001)(99286004)(6512007)(26005)(6436002)(64756008)(66446008)(6486002)(107886003)(6246003)(5660300002)(6506007)(53936002)(66476007)(478600001)(3846002)(6116002)(256004)(66556008)(71200400001)(2906002)(4326008)(71190400001)(6916009)(14444005)(36756003)(31696002)(229853002)(14454004)(8936002)(66946007)(81166006)(81156014)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5322;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YDsyF9iMYBVHM+CZvWO+RLo+tJcDWCA1IrlkeyZRZhhwTC7H5T7+iwqlumUn336CnWE2LTMI0hG1K7RzGfdXahCvwaEZKSJCZMND0JkrEuPspxPxg5EnTN/AGH/dtF+rrLsT5YGDzC0/vFr54UicQOE4/oBqXj9I+cWs2rqLYrFn7cenp4dWiHMP2F3mbFvwminc1Hm7h+hhFyC/VmnDtvGaN5eEabElV8ImtKYrCWZoDMfLGFSoIwwpiDWeRrPZziHYKPHcjKnfXk5ULbB4ZpbgUx0kDYt36vbn5PNqRrK9fiCDFSpiVxeIC12GG+3y2t7FBsHWF1N9SeU0ojKghI3O9x715I+LQidTmq6PFr7taXWyz1AvTAyFoS+LZmbMjzwy2njyWgSIFg5iGmVEF+nAsSusHSsAoQKhpcg6dKE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E8F1DC355D121488116BA44CECD74F8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679860f3-d036-47e6-7a41-08d7200be51a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 16:32:55.8642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N6UfQvmvC9rXJOrTl8iQJu/feuO5ofSjqI5sYxsawoPaxXG05vFM11TtHU0hmb9W8v0cLjp3CzAM7tRh8huXxQXk6VCq8aCOnEkKrbylh20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5322
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.105
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

MTMuMDguMjAxOSAxOTowOCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMTMuMDguMjAxOSB1bSAx
Nzo1NCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDEz
LjA4LjIwMTkgMTg6NDEsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMTMuMDguMjAxOSB1bSAx
Njo0MyBoYXQgTWF4IFJlaXR6IGdlc2NocmllYmVuOg0KPj4+PiBPbiAxMy4wOC4xOSAxMzowNCwg
S2V2aW4gV29sZiB3cm90ZToNCj4+Pj4+IEFtIDEyLjA4LjIwMTkgdW0gMjA6MTEgaGF0IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgZ2VzY2hyaWViZW46DQo+Pj4+Pj4gQkRSVl9CTE9DS19S
QVcgbWFrZXMgZ2VuZXJpYyBiZHJ2X2NvX2Jsb2NrX3N0YXR1cyB0byBmYWxsdGhyb3VnaCB0bw0K
Pj4+Pj4+IHJldHVybmVkIGZpbGUuIEJ1dCBpcyBpdCBjb3JyZWN0IGJlaGF2aW9yIGF0IGFsbD8g
SWYgcmV0dXJuZWQgZmlsZQ0KPj4+Pj4+IGl0c2VsZiBoYXMgYSBiYWNraW5nIGZpbGUsIHdlIG1h
eSByZXBvcnQgYXMgdG90YWxseSB1bmFsbG9jYXRlZCBhbmQNCj4+Pj4+PiBhcmVhIHdoaWNoIGFj
dHVhbGx5IGhhcyBkYXRhIGluIGJvdHRvbSBiYWNraW5nIGZpbGUuDQo+Pj4+Pj4NCj4+Pj4+PiBT
bywgbWlycm9yaW5nIG9mIHFjb3cyIHVuZGVyIHJhdy1mb3JtYXQgaXMgYnJva2VuLiBXaGljaCBp
cyBpbGx1c3RyYXRlZA0KPj4+Pj4+IGJ5IGZvbGxvd2luZyBjb21taXQgd2l0aCBhIHRlc3QuIExl
dCdzIG1ha2UgcmF3LWZvcm1hdCBiZWhhdmUgbW9yZQ0KPj4+Pj4+IGNvcnJlY3RseSByZXR1cm5p
bmcgQkRSVl9CTE9DS19EQVRBLg0KPj4+Pj4+DQo+Pj4+Pj4gU3VnZ2VzdGVkLWJ5OiBNYXggUmVp
dHogPG1yZWl0ekByZWRoYXQuY29tPg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+Pj4+DQo+Pj4+
PiBBZnRlciBzb21lIHJlYWRpbmcsIEkgdGhpbmsgSSBjYW1lIHRvIHRoZSBjb25jbHVzaW9uIHRo
YXQgUkFXIGlzIHRoZQ0KPj4+Pj4gY29ycmVjdCB0aGluZyB0byBkby4gVGhlcmUgaXMgaW5kZWVk
IGEgcHJvYmxlbSwgYnV0IHRoaXMgcGF0Y2ggaXMgdHJ5aW5nDQo+Pj4+PiB0byBmaXggaXQgaW4g
dGhlIHdyb25nIHBsYWNlLg0KPj4+Pj4NCj4+Pj4+IEluIHRoZSBjYXNlIHdoZXJlIHRoZSBiYWNr
aW5nIGZpbGUgY29udGFpbnMgc29tZSBkYXRhLCBhbmQgd2UgaGF2ZSBhDQo+Pj4+PiAncmF3JyBu
b2RlIGFib3ZlIHRoZSBxY293MiBvdmVybGF5IG5vZGUsIHRoZSBjb250ZW50IG9mIHRoZSByZXNw
ZWN0aXZlDQo+Pj4+PiBibG9jayBpcyBub3QgZGVmaW5lZCBieSB0aGUgcXVlcmllZCBiYWNraW5n
IGZpbGUgbGF5ZXIsIHNvIGl0IGlzDQo+Pj4+PiBjb21wbGV0ZWx5IGNvcnJlY3QgdGhhdCBiZHJ2
X2lzX2FsbG9jYXRlZCgpIHJldHVybnMgZmFsc2UsbGlrZSBpdCB3b3VsZA0KPj4+Pj4gaWYgeW91
IHF1ZXJpZWQgdGhlIHFjb3cyIGxheWVyIGRpcmVjdGx5Lg0KPj4+Pg0KPj4+PiBJIGRpc2FncmVl
LiAgVGhlIHF1ZXJpZWQgYmFja2luZyBmaWxlIGxheWVyIGlzIHRoZSByYXcgbm9kZS4gIEFzIEkg
c2FpZCwNCj4+Pj4gaW4gbXkgb3BpbmlvbiByYXcgbm9kZXMgYXJlIG5vdCBmaWx0ZXIgbm9kZXMs
IG5laXRoZXIgaW4gYmVoYXZpb3IgKHRoZXkNCj4+Pj4gaGF2ZSBhbiBvZmZzZXQgb3B0aW9uKSwg
bm9yIGluIGhvdyB0aGV5IGFyZSBnZW5lcmFsbHkgdXNlZCAoYXMgYSBmb3JtYXQpLg0KPj4+Pg0K
Pj4+PiBUaGUgcmF3IGZvcm1hdCBkb2VzIG5vdCBzdXBwb3J0IGJhY2tpbmcgZmlsZXMuICBUaGVy
ZWZvcmUsIGV2ZXJ5dGhpbmcgb24NCj4+Pj4gYSByYXcgbm9kZSBpcyBhbGxvY2F0ZWQuDQo+Pj4+
DQo+Pj4+IChUaGF0IGlzLCBsaWtlLCBteSBvcGluaW9uLikNCj4+Pj4NCj4+Pj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJZiBpdCByZXR1cm5lZCB0cnVlLCB3
ZSB3b3VsZA0KPj4+Pj4gY29weSBldmVyeXRoaW5nLCB3aGljaCBpc24ndCByaWdodCBlaXRoZXIg
KHRoZSB0ZXN0IGNhc2VzIHNob3VsZCBtYXkgYWRkDQo+Pj4+PiB0aGUgcWVtdS1pbWcgbWFwIG91
dHB1dCBvZiB0aGUgdGFyZ2V0IHNvIHRoaXMgYmVjb21lcyB2aXNpYmxlKS4NCj4+Pj4NCj4+Pj4g
SXQgaXMgcmlnaHQuDQo+Pj4NCj4+PiBTbyB3ZSBkb24ndCBldmVuIGFncmVlIHdoYXQgbWlycm9y
aW5nIHRoZSByYXcgbm9kZSBzaG91bGQgZXZlbiBtZWFuLg0KPj4+DQo+Pj4gSSBjYW4gdGhlIHNl
ZSB5b3VyIHBvaW50IHdoZW4geW91IHNheSB0aGF0IHRoZSByYXcgbm9kZSBoYXMgbm8gYmFja2lu
Zw0KPj4+IGZpbGUsIHNvIGV2ZXJ5dGhpbmcgc2hvdWxkIGJlIGNvcGllZC4gQnV0IEkgY2FuIGFs
c28gc2VlIHRoZSBwb2ludCB0aGF0DQo+Pj4gdGhlIHJhdyBub2RlIGNhbiByZWFsbHkganVzdCBi
ZSB1c2VkIGFzIGEgZmlsdGVyIHRoYXQgbGltaXRzIHRoZSBkYXRhDQo+Pj4gZXhwb3NlZCBmcm9t
IHRoZSBxY293MiBsYXllciwgYW5kIHlvdSB3YW50IHRvIGtlZXAgdGhlIGNvcHkgYSBDT1cNCj4+
PiBvdmVybGF5IG92ZXIgdGhlIHNhbWUgYmFja2luZyBmaWxlLg0KPj4+DQo+Pj4gQm90aCBhcmUg
dmFsaWQgdXNlIGNhc2VzIGluIHByaW5jaXBsZSBhbmQgdGhlcmUgaXMgbm8gc2luZ2xlIHJpZ2h0
IG9yDQo+Pj4gd3JvbmcuDQo+Pj4NCj4+PiBXZSBkb24ndCBjdXJyZW50bHkgc3VwcG9ydCB0aGUg
bGF0dGVyIHVzZSBjYXNlIGJlY2F1c2Ugd2UgaGF2ZSBvbmx5DQo+Pj4gc3luYz1mdWxsIG9yIHN5
bmM9dG9wLCBidXQgaWYgeW91IGNvdWxkIHNwZWNpZnkgYSBiYXNlIG5vZGUgaW5zdGVhZCwgd2UN
Cj4+PiBjb3VsZCBwcm9iYWJseSBzdXBvcnQgdGhlIGNhc2Ugd2l0aG91dCBhbGwgb2YgdGhlIHNw
ZWNpYWwtY2FzaW5nIGZpbHRlcg0KPj4+IG5vZGVzIGFuZCBiYWNraW5nIGZpbGUgY2hpbGRzLg0K
Pj4+DQo+Pj4gWW91IHdvdWxkIGNhbGwgYmRydl9jb19ibG9ja19zdGF0dXNfYWJvdmUoKSB3aXRo
IHRoZSByaWdodCBiYXNlIG5vZGUgYW5kDQo+Pj4gaXQgd291bGQganVzdCByZWN1cnNlIHdoZXJl
ZXZlciB0aGUgZGF0YSBpcyBzdG9yZWQsIGJlIGl0IGJzLT5iYWNraW5nLA0KPj4+IGJzLT5maWxl
IG9yIGV2ZW4gZHJpdmVyLXNwZWNpZmljIGNoaWxkcmVuLiBUaGlzIHdvdWxkIGFsbG93IHlvdSB0
byBmaW5kDQo+Pj4gb3V0IHdoZXRoZXIgc29tZSBibG9jayBpbiB0aGUgdG9wIG5vZGUgY2FtZSBm
cm9tIHRoZSBiYXNlIG5vZGUgdGhhdA0KPj4+IHdlJ3JlIGdvaW5nIHRvIGtlZXAuIElmIHllcywg
c2tpcCBpdDsgaWYgbm8sIGNvcHkgaXQuDQo+Pj4NCj4+PiBUaGlzIHdheSB3ZSB3b3VsZG4ndCBo
YXZlIHRvIGRlY2lkZSB3aGV0aGVyIHJhdyBpcyBhIGZpbHRlciBvciBub3QsDQo+Pj4gYmVjYXVz
ZSBpdCB3b3VsZG4ndCBtYWtlIGEgZGlmZmVyZW5jZS4gVGhlIGJlaGF2aW91ciB3b3VsZCBvbmx5
IGRlcGVuZA0KPj4+IG9uIHRoZSBiYXNlIG5vZGUgZ2l2ZW4gYnkgdGhlIHVzZXIuIElmIHlvdSBz
cGVjaWZpZWQgdGhlIHRvcC1sZXZlbCBxY293Mg0KPj4+IGZpbGUgYXMgdGhlIGJhc2UsIHlvdSBn
ZXQgeW91ciBmdWxsIGNvcHk7DQo+Pg0KPj4gYWhtLCBmdWxsLWNvcHkgPSBiYXNlIGlzIE5VTEwu
Lg0KPiANCj4gT29wcywgeWVzLCBvZiBjb3Vyc2UuIFVzaW5nIHRoZSB0b3AtbGV2ZWwgbm9kZSB3
b3VsZCBjcmVhdGUgYW4gZW1wdHkNCj4gImNvcHkiLg0KPiANCj4+PiBpZiB5b3Ugc3BlY2lmaWVk
IHRoZSBiYWNraW5nDQo+Pj4gcWNvdzIsIHlvdSBnZXQgdGhlIHBhcnRpYWwgY29weSB3aGVyZSB0
aGUgdGFyZ2V0IHN0aWxsIHVzZXMgdGhlIHNhbWUNCj4+PiBiYWNraW5nIGZpbGUuDQo+Pj4NCj4+
PiAoSG0uLi4gSXQgd291bGQgb25seSBhY3R1YWxseSB3b3JrIGlmIHRoZSBvZmZzZXRzIHN0YXkg
dGhlIHNhbWUgaW4gdGhlDQo+Pj4gY2hhaW4sIHdoaWNoIGlzIHRydWUgZm9yIGJhY2tpbmcgZmls
ZSBjaGlsZHJlbiwgYnV0IG5vdCBuZWNlc3NhcmlseSBmb3INCj4+PiBvdGhlciBjaGlsZHJlbi4N
Cj4+DQo+PiBEb24ndCBmb2xsb3csIHdoYXQgeW91IG1lYW4gYnkgb2Zmc2V0cyBzdGF5IHRoZSBz
YW1lIGFuZCB3aGF0IGlzIHdyb25nDQo+PiB3aXRoIGl0Pw0KPiANCj4gU2F5IHdlIGhhdmUgdGhp
cyBncmFwaDoNCj4gDQo+IHJhdyxvZmZzZXQ9NjU1MzYNCj4gICAgICB8DQo+ICAgICAgdg0KPiAg
ICBxY293Mi0tLS0tKw0KPiAgICAgIHwgICAgICAgfA0KPiAgICAgIHYgICAgICAgdg0KPiAgICBm
aWxlICAgICBiYXNlDQo+IA0KPiBOb3cgeW91IGNhbid0IGp1c3QgbWlycm9yIHRoZSByYXcgbm9k
ZSBpbnRvIGEgdGFyZ2V0LnFjb3cyIHRoYXQgc2hhcmVzDQo+IGJhc2UgYXMgdGhlIGJhY2tpbmcg
ZmlsZSwgYmVjYXVzZSB0aGUgb2Zmc2V0cyB3aWxsIGJlIHdyb25nLiBJbiBvcmRlciB0bw0KPiB1
c2Ugc3VjaCBhIGNvcHkgY29ycmVjdGx5LCB5b3UnZCBoYXZlIHRvIHVzZSBhIHJhdyBub2RlIGFn
YWluIGluIHRoZQ0KPiBiYWNraW5nIGNoYWluOg0KPiANCj4gdGFyZ2V0LnFjb3cyLS0tLSsNCj4g
ICAgICB8ICAgICAgICAgICB8DQo+ICAgICAgdiAgICAgICAgICAgdg0KPiAgICBmaWxlICAgICAg
cmF3LG9mZnNldD02NTUzNg0KPiAgICAgICAgICAgICAgICAgIHwNCj4gICAgICAgICAgICAgICAg
ICB2DQo+ICAgICAgICAgICAgICAgIGJhc2UNCj4gDQo+IFNvIHRoZSBjYXNlIHdoZXJlIG9mZnNl
dHMgZGlmZmVyIGJldHdlZW4gdGhlIHRvcCBhbmQgdGhlIGJhc2Ugbm9kZSBpc24ndA0KPiB0cml2
aWFsLg0KDQpVbmRlcnN0YW5kLCBidXQgZm9yIG1lIGl0IGRvbid0IGxvb2sgbGlrZSB0aGUgdGhp
bmcgdGhhdCBiZWhhdmVzIGluIHVuZXhwZWN0ZWQNCmZvciB1c2VyIHdheSwgb24gdGhlIGNvbnRy
YXJ5LCBpdCBzZWVtcyBvYnZpb3VzIHRoYXQgaXQgd2lsbCBub3Qgd29yaywgYXMgdXNlcg0KdW5k
ZXJzdGFuZCB3aGF0IGlzIGJhY2tpbmcgZmlsZSAob2Zmc2V0cyBhcmUgYmFja2VkIGJ5IGNvcnJl
c3BvbmRpbmcgb2Zmc2V0cykNCg0KPiANCj4gKElmIHRoaXMgY2FzZSBpc24ndCBjb21wbGljYXRl
ZCBlbm91Z2ggeWV0LCBpbWFnaW5lIHBhc3NpbmcgZmlsZSBhcyB0aGUNCj4gYmFzZSBub2RlIGlu
c3RlYWQuLi4gSXQganVzdCBjYW4ndCB3b3JrLikNCj4gDQoNClllcywgaWYgd2UgY2hvc2UgdGhl
IHdheSB5b3UgcHJvcG9zZWQgd2UgaGF2ZSBhIHBvc3NpYmlsaXR5IHRvIHVzZSBhbnkgbm9kZSBh
cyBhIGJhc2UsDQpidXQgYWdhaW4gdGhpcyBkb2VzIHNvbWV0aGluZyBjb21wbGV0ZWx5IGRpZmZl
cmVudCBmcm9tIHVzdWFsICJ0b3AiIG9yICJiYXNlZCIgbW9kZS4uDQpTbyBpdCdzIGp1c3QgYSBu
ZXcgcG9zc2liaWxpdHksIG1heSBiZSB1c2VsZXNzLCBpdCBkb24ndCBicmVhayB1cCB0aGUgY29u
Y2VwdC4NCg0KDQpJIGxpa2UgdGhlIGlkZWEgb2YgZ2VuZXJpYyBibG9ja19zdGF0dXNfYWJvdmUg
dGhhdCB5b3UgcHJvcG9zZSwgYnV0IHN0aWxsIHRoZXJlIHNob3VsZA0KYSBkZWNpc2lvbiBvZiB3
aGF0IGV4YWN0bHkgREFUQSwgWkVSTyBhbmQgQUxMT0NBVEVEIG1lYW5zLiBPaywgYXNzdW1lIHdl
IGRvbid0IG5lZWQgQUxMT0NBVEVELi4NClRoZW4gd2UgZG9uJ3QgbmVlZCBEQVRBIHRvbz8NCg0K
QW5kIGhvdyBibG9ja19zdGF0dXNfYWJvdmUgd291bGQgd29yaz8gSWYgbm9kZSBkb24ndCByZXBv
cnQgWkVSTyBhbmQgZG9uJ3QgcmVwb3J0IERBVEEgYnV0IHJlcG9ydA0KKmZpbGUgcG9pbnRlciA9
PSBiYXNlLCB3ZSBzaG91bGQgc3RvcCwgYW5kIGRvbid0IGdvIHRvICpmaWxlLCBpdCBzZWVtcyBv
YnZpb3VzLi4NCg0KQnV0IHdoYXQgaWYgbm9kZSByZXBvcnRzIFpFUk8gdG9nZXRoZXIgd2l0aCAq
ZmlsZSBwb2ludGVyID09IGJhc2U/IFNob3VsZCBjb25zaWRlciB0aGlzIHJlZ2lvbg0KYmVsb25n
aW5nIHRvIGJhc2UgYW5kIFVOQUxMT0NBVEVEIGFuZCBub3QgY29weSBpdCwgb3Igd2Ugc2hvdWxk
IGNvbnNpZGVyIGl0IEFMTE9DQVRFRCBiZWNhdXNlDQpjdXJyZW50IG5vZGUgcmVwb3J0cyBpdCBa
RVJPPyBTbywgY3JpdGVyaWEgb2YgIkFMTE9DQVRFRCIgb3IgIndoZXJlIHNob3VsZCB3ZSBzdG9w
IGluIHJlY3Vyc2lvbiINCmlzIG5vdCBvYnZpb3VzLi4gRG8geW91IGhhdmUgb25lPw0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


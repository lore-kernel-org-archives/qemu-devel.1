Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFA5C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E492230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TYjnRhzb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E492230F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXN6Z-0006Pc-Qx
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXN5s-0005u8-TA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iXN5q-0004HP-Ur
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:20:16 -0500
Received: from mail-eopbgr130128.outbound.protection.outlook.com
 ([40.107.13.128]:58693 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iXN5q-0004CY-2x; Wed, 20 Nov 2019 05:20:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2UtwnbRRGtEH+nbtfHfqDD2kVMm0Jp7tL4M7x+55Tmj+Kb9HvApLqh68flak70h9upUx6NiH3TdJ3nyWCs9hdYtYW/rJLp0Il0HmyGBuFqg0xmB4toJ1fgHuQCD2AQXgDysT6UbuhMYFy7ggXVFgNFJuXxr3BOqdD1E4MC9XweQkpRpMuw3QqvlBk3yF8FxArGrJ2F4kp5Nqw6P8z0sihaOTTPi8n5dcUrMTrDacNyKoDBmHEW3yoWMeFH9KnUzGhnnqO/dSPZTyQHhYrSaL+kYMlyDDYmFevAh2FiJzIZlmsp+wSmFOKTqcISPS38UNoW+zpVpGN798acL5uiTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIvnD21GVhQrr906w9jxGyQq4M6oca9XhHt20dLgSUE=;
 b=J7kZF4F4O6N8lGbe1a1RdpFkVrGuEOSnMDV3xCBUXZNvha6c14M7xy21kB5pVBnGakLWv+1aDvzd9UlzOZ8bvDUq3iqpq2D1mypxPvM5HOcQzCtkVOeFIFirCVq2rSSPK3NcJ3FDYRnr60KavKr1GzE7EAAGVjdxi9f6Zp3xQb0aE8GPhG0j/VzDqGtwGjnAfvj80nfy+EG1JYIHR22AkIi7GGoX0P7egsrRoGu2pG/3AsPEUDJS0jPCF/eHlVarcIroNefi41dtE8wyWJdE0mMcMh6ZmjloTLyg2ufT8rfh7dvxNXqVKPWRttI1yNtmj3LyWBz3WmwW4O1YiUZltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIvnD21GVhQrr906w9jxGyQq4M6oca9XhHt20dLgSUE=;
 b=TYjnRhzbrQlEGY9aN+eAn0QN+NwZOcUlufhV4xvYutqk/DRgI1y3LLYnH+AzCuts84yFXvqvWTJkXDzcxfEOJTUbxGTdZFXu18z9PcySNs5LoTXIUAS85QVClhK4n1U1msq+Er4T0hiFfYLabIdr2NfpFN8foygXbOU1rLeqEGY=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4898.eurprd08.prod.outlook.com (10.255.99.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 10:20:11 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 10:20:10 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Topic: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Thread-Index: AQHVnJu0qDM7Hy9Fo0iUR1ci8onW5KeT3vMA
Date: Wed, 20 Nov 2019 10:20:10 +0000
Message-ID: <7f8574a2-8fd2-9724-a197-d67d3c69d538@virtuozzo.com>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
In-Reply-To: <20191116163410.12129-1-vsementsov@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0102CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::43) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191120132008731
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4bf53fe4-38ef-41d2-d025-08d76da33984
x-ms-traffictypediagnostic: AM6PR08MB4898:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB4898F9EE530929447C51C1C9C14F0@AM6PR08MB4898.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(366004)(346002)(376002)(53754006)(199004)(189003)(7736002)(31696002)(52116002)(2501003)(71200400001)(71190400001)(86362001)(2616005)(446003)(476003)(11346002)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(76176011)(6506007)(386003)(186003)(26005)(102836004)(486006)(31686004)(229853002)(6486002)(5640700003)(6512007)(6436002)(508600001)(14454004)(36756003)(6246003)(3846002)(107886003)(4326008)(2906002)(6116002)(99286004)(54906003)(8936002)(8676002)(81156014)(81166006)(6916009)(2351001)(256004)(14444005)(66066001)(305945005)(25786009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4898;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YOkH4smMkkrssdCAJ8/X+csgxIpqkGISPY81qxi884WVESsz/nQ/Hh7n7vYNrj5lYi1Z5X89Vlsf39Y1lMn5CH85BNFA9u/2xAfzVHa05kPUDXcq1zv0acZw7+Xf19Mrd9ptCuBJnrLEP4hjp8qiPpBeUhb4mCe08mtNhR3bKzAsRHFSO34ZevWNMlLuXXJ3gjRfbFNrVpYn51622wF3d3RJDcx6ieHALz9RYdO70R0KAHnk2NuJYAdZWZ4RvlY7VdGazHvq6pT5Qb/ac/qxffMYV1od4JMh9by6atMB/IPjTpfgfJHV3eUrftvjqUYisbqnJmQshpnu9lSf4amuW401Qim6yIT+DT6Y/Q6MWWw3vIBuzfX+oqhkSO4RmMdarlV7TqAKal/CWEro6A1sOh4Z7ptpSAaa6KADwVJsoWYBlRJVDdD0cDpaHeZz/wYp
Content-Type: text/plain; charset="utf-8"
Content-ID: <48EE95B0727F874786710E3311588546@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf53fe4-38ef-41d2-d025-08d76da33984
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 10:20:10.9585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKDYR5G4FEXLPBovZMTcGziOg+hWdkxuBsu7KKK6sIOIFdaTFKtkUom1QGsPNGrC3S7T/ZRh+YFsS5eabxaRSORCjURvOLu8viKSGElc6aw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4898
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.128
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MTYuMTEuMjAxOSAxOTozNCwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
SGkgYWxsIQ0KPiANCj4gSSB3YW50ZWQgdG8gdW5kZXJzdGFuZCwgd2hhdCBpcyB0aGUgcmVhbCBk
aWZmZXJlbmNlIGJldHdlZW4gYmRydl9ibG9ja19zdGF0dXNfYWJvdmUNCj4gYW5kIGJkcnZfaXNf
YWxsb2NhdGVkX2Fib3ZlLCBJTUhPIGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlIHNob3VsZCB3b3Jr
IHRocm91Z2gNCj4gYmRydl9ibG9ja19zdGF0dXNfYWJvdmUuLg0KPiANCj4gQW5kIEkgZm91bmQg
dGhlIHByb2JsZW06IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlIGNvbnNpZGVycyBzcGFjZSBhZnRl
ciBFT0YgYXMNCj4gVU5BTExPQ0FURUQgZm9yIGludGVybWVkaWF0ZSBub2Rlcy4uDQo+IA0KPiBV
TkFMTE9DQVRFRCBpcyBub3QgYWJvdXQgYWxsb2NhdGlvbiBhdCBmcyBsZXZlbCwgYnV0IGFib3V0
IHNob3VsZCB3ZSBnbyB0byBiYWNraW5nIG9yDQo+IG5vdC4uIEFuZCBpdCBzZWVtcyBpbmNvcnJl
Y3QgZm9yIG1lLCBhcyBpbiBjYXNlIG9mIHNob3J0IGJhY2tpbmcgZmlsZSwgd2UnbGwgcmVhZA0K
PiB6ZXJvZXMgYWZ0ZXIgRU9GLCBpbnN0ZWFkIG9mIGdvaW5nIGZ1cnRoZXIgYnkgYmFja2luZyBj
aGFpbi4NCj4gDQo+IFRoaXMgbGVhZHMgdG8gdGhlIGZvbGxvd2luZyBlZmZlY3Q6DQo+IA0KPiAu
L3FlbXUtaW1nIGNyZWF0ZSAtZiBxY293MiBiYXNlLnFjb3cyIDJNDQo+IC4vcWVtdS1pbyAtYyAi
d3JpdGUgLVAgMHgxIDAgMk0iIGJhc2UucWNvdzINCj4gDQo+IC4vcWVtdS1pbWcgY3JlYXRlIC1m
IHFjb3cyIC1iIGJhc2UucWNvdzIgbWlkLnFjb3cyIDFNDQo+IC4vcWVtdS1pbWcgY3JlYXRlIC1m
IHFjb3cyIC1iIG1pZC5xY293MiB0b3AucWNvdzIgMk0NCj4gDQo+IFJlZ2lvbiAxTS4uMk0gaXMg
c2hhZG93ZWQgYnkgc2hvcnQgbWlkZGxlIGltYWdlLCBzbyBndWVzdCBzZWVzIHplcm9lczoNCj4g
Li9xZW11LWlvIC1jICJyZWFkIC1QIDAgMU0gMU0iIHRvcC5xY293Mg0KPiByZWFkIDEwNDg1NzYv
MTA0ODU3NiBieXRlcyBhdCBvZmZzZXQgMTA0ODU3Ng0KPiAxIE1pQiwgMSBvcHM7IDAwLjAwIHNl
YyAoMjIuNzk1IEdpQi9zZWMgYW5kIDIzMzQxLjU4MDcgb3BzL3NlYykNCj4gDQo+IEJ1dCBhZnRl
ciBjb21taXQgZ3Vlc3QgdmlzaWJsZSBzdGF0ZSBpcyBjaGFuZ2VkLCB3aGljaCBzZWVtcyB3cm9u
ZyBmb3IgbWU6DQo+IC4vcWVtdS1pbWcgY29tbWl0IHRvcC5xY293MiAtYiBtaWQucWNvdzINCj4g
DQo+IC4vcWVtdS1pbyAtYyAicmVhZCAtUCAwIDFNIDFNIiBtaWQucWNvdzINCj4gUGF0dGVybiB2
ZXJpZmljYXRpb24gZmFpbGVkIGF0IG9mZnNldCAxMDQ4NTc2LCAxMDQ4NTc2IGJ5dGVzDQo+IHJl
YWQgMTA0ODU3Ni8xMDQ4NTc2IGJ5dGVzIGF0IG9mZnNldCAxMDQ4NTc2DQo+IDEgTWlCLCAxIG9w
czsgMDAuMDAgc2VjICg0Ljk4MSBHaUIvc2VjIGFuZCA1MTAwLjQ3OTQgb3BzL3NlYykNCj4gDQo+
IC4vcWVtdS1pbyAtYyAicmVhZCAtUCAxIDFNIDFNIiBtaWQucWNvdzINCj4gcmVhZCAxMDQ4NTc2
LzEwNDg1NzYgYnl0ZXMgYXQgb2Zmc2V0IDEwNDg1NzYNCj4gMSBNaUIsIDEgb3BzOyAwMC4wMCBz
ZWMgKDMuMzY1IEdpQi9zZWMgYW5kIDM0NDYuMTYwNiBvcHMvc2VjKQ0KPiANCj4gDQo+IEkgZG9u
J3Qga25vdywgaXMgaXQgYSByZWFsIGJ1ZywgYXMgSSBkb24ndCBrbm93LCBkbyB3ZSBzdXBwb3J0
IGJhY2tpbmcgZmlsZSBsYXJnZXIgdGhhbg0KPiBpdHMgcGFyZW50LiBTdGlsbCwgSSdtIG5vdCBz
dXJlIHRoYXQgdGhpcyBiZWhhdmlvciBvZiBiZHJ2X2lzX2FsbG9jYXRlZF9hYm92ZSBkb24ndCBs
ZWFkDQo+IHRvIG90aGVyIHByb2JsZW1zLg0KPiANCj4gPT09PT0NCj4gDQo+IEhtbSwgYmRydl9i
bG9ja19hbGxvY2F0ZWRfYWJvdmUgYmVoYXZlcyBzdHJhbmdlIHRvbzoNCj4gDQo+IHdpdGggd2Fu
dF96ZXJvPXRydWUsIGl0IG1heSByZXBvcnQgdW5hbGxvY2F0ZWQgemVyb2VzIGJlY2F1c2Ugb2Yg
c2hvcnQgYmFja2luZyBmaWxlcywgd2hpY2gNCj4gYXJlIGFjdHVhbGx5ICJhbGxvY2F0ZWQiIGlu
IFBPViBvZiBiYWNraW5nIGNoYWlucy4gQnV0IEkgc2VlIHRoaXMgbWF5IGluZmx1ZW5jZSBvbmx5
DQo+IHFlbXUtaW1nIGNvbXBhcmUsIGFuZCBJIGRvbid0IHNlZSBjYW4gaXQgdHJpZ2dlciBzb21l
IGJ1Zy4uDQo+IA0KPiB3aXRoIHdhbnRfemVybz1mYWxzZSwgaXQgbWF5IGRvIG5vIHByb2dyZXNz
IGJlY2F1c2Ugb2Ygc2hvcnQgYmFja2luZyBmaWxlLiBNb3Jlb3ZlciBpdCBtYXkNCj4gcmVwb3J0
IEVPRiBpbiB0aGUgbWlkZGxlISEgQnV0IHdhbnRfemVybz1mYWxzZSB1c2VkIG9ubHkgaW4gYmRy
dl9pc19hbGxvY2F0ZWQsIHdoaWNoIGNvbnNpZGVycw0KPiBvbmx5dCB0b3AgbGF5ZXIsIHNvIGl0
IHNlZW1zIE9LLg0KPiANCj4gPT09PT0NCj4gDQo+IFNvLCBJIHByb3Bvc2UgdGhlc2Ugc2VyaWVz
LCBzdGlsbCBJJ20gbm90IHN1cmUgaXMgdGhlcmUgYSByZWFsIGJ1Zy4NCj4gDQo+IFZsYWRpbWly
IFNlbWVudHNvdi1PZ2lldnNraXkgKDQpOg0KPiAgICBibG9jay9pbzogZml4IGJkcnZfY29fYmxv
Y2tfc3RhdHVzX2Fib3ZlDQo+ICAgIGJsb2NrL2lvOiBiZHJ2X2NvbW1vbl9ibG9ja19zdGF0dXNf
YWJvdmU6IHN1cHBvcnQgaW5jbHVkZV9iYXNlDQo+ICAgIGJsb2NrL2lvOiBiZHJ2X2NvbW1vbl9i
bG9ja19zdGF0dXNfYWJvdmU6IHN1cHBvcnQgYnMgPT0gYmFzZQ0KPiAgICBibG9jay9pbzogZml4
IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlDQo+IA0KPiAgIGJsb2NrL2lvLmMgICAgICAgICAgICAg
ICAgIHwgMTA0ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICB0ZXN0
cy9xZW11LWlvdGVzdHMvMTU0Lm91dCB8ICAgNCArLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNTMg
aW5zZXJ0aW9ucygrKSwgNTUgZGVsZXRpb25zKC0pDQo+IA0KDQoNCkludGVyZXN0aW5nIHRoYXQg
dGhlIHByb2JsZW0gaWxsdXN0cmF0ZWQgaGVyZSBpcyBub3QgZml4ZWQgYnkgdGhlIHNlcmllcywg
aXQncyBhY3R1YWxseQ0KcmVsYXRlcyB0byB0aGUgZmFjdCB0aGF0IG1pcnJvciBkb2VzIHRydW5j
YXRpb24gd2l0aCBQUkVBTExPQ19NT0RFX09GRiwgd2hpY2ggbGVhZHMNCnRvIHVuYWxsb2NhdGVk
IHFjb3cyIGNsdXN0ZXJzLCB3aGljaCBJIHRoaW5rIHNob3VsZCBiZSBmaXhlZCB0b28uDQoNClRv
IGlsbHVzdHJhdGUgdGhlIHByb2JsZW0gZml4ZWQgYnkgdGhlIHNlcmllcywgd2Ugc2hvdWxkIGNv
bW1pdCB0byBiYXNlOg0KDQojIC4vcWVtdS1pbWcgY29tbWl0IHRvcC5xY293MiAtYiBiYXNlLnFj
b3cyDQpJbWFnZSBjb21taXR0ZWQuDQojIC4vcWVtdS1pbyAtYyAicmVhZCAtUCAwIDFNIDFNIiBi
YXNlLnFjb3cyDQpQYXR0ZXJuIHZlcmlmaWNhdGlvbiBmYWlsZWQgYXQgb2Zmc2V0IDEwNDg1NzYs
IDEwNDg1NzYgYnl0ZXMNCnJlYWQgMTA0ODU3Ni8xMDQ4NTc2IGJ5dGVzIGF0IG9mZnNldCAxMDQ4
NTc2DQoxIE1pQiwgMSBvcHM7IDAwLjAwIHNlYyAoNS4zNjYgR2lCL3NlYyBhbmQgNTQ5NC40MTQ5
IG9wcy9zZWMpDQoNCj09PT09PT0NCg0KSG1tLCBidXQgaG93IHRvIGZpeCB0aGUgcHJvYmxlbSBh
Ym91dCB0cnVuY2F0ZT8gSSB0aGluayB0cnVuY2F0ZSBtdXN0IG5vdCBtYWtlDQp1bmRlcmx5aW5n
IGJhY2tpbmcgYXZhaWxhYmxlIGZvciByZWFkLi4gRGlzY2FyZCBvcGVyYXRpb24gZG9lc24ndCBk
byBpdC4NCg0KU28sIGFjdHVhbGx5IG9uIFBSRUFMTE9DX01PREVfT0ZGIHdlIG11c3QgYWxsb2Nh
dGVkIEwyIHRhYmxlcyBhbmQgbWFyayBuZXcgY2x1c3RlcnMNCmFzIFpFUk8/DQoNClRvIGltcHJv
dmUgaXQsIHdlIGNhbiBhZGQgInplcm8gYml0IiB0byBMMSB0YWJsZSBlbnRyeS4uDQoNCi0tIA0K
QmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


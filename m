Return-Path: <SRS0=i/12=ZI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F4CC432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 14:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2425620700
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Nov 2019 14:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CjpuPX/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2425620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVyvA-0004lG-7m
	for qemu-devel@archiver.kernel.org; Sat, 16 Nov 2019 09:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44923)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVyuE-0004CO-Ku
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 09:18:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iVyuC-000103-RQ
 for qemu-devel@nongnu.org; Sat, 16 Nov 2019 09:18:29 -0500
Received: from mail-eopbgr40110.outbound.protection.outlook.com
 ([40.107.4.110]:25574 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iVyuC-0000yi-6r; Sat, 16 Nov 2019 09:18:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kC6t8be2KKgrqHJ15LcfmlhOmEDaBhupEfX6bXb48Uhq83pko3npmxzZ9PIKeSun3e4DgAwKYS4rfDbuOmiTprVTJGySnosg8kV/Hsou6yYEtyTD/gShq0qMMU3/pC3SgyQk+dt+Icm0W2UR1HxbVAnTarkiR9Q8u51voQuitO1VcXypRUaSzbjBoqxPbQd85dK7x6S9DvJQtlmgfKo0t2dtFhXpiUP99fSpKEn3M9GH7FRH7tTjyMwyYC26HD/N4/JcNPhX9Dmal/HcG6sMKEjsM5ewVCkBxh2yr7bCIJCvG290+PSMzOLwAKupkr8UTG9J4r8Bw0SgOweIMbzNwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofGQeaA2/ShXinvFDQ54Hxr1kH9jRmLL3z4zm71ZI8Q=;
 b=NUbQ+ll/A+0jh6AhBOc5DzSa1B5pvQXUZEmvE9etvUa8Ajq4TH4e8DhE/djBGEh12r+xuZtEE4xDihsBf/Cgv2ls8RyeXayn+CeEQo82TRrS72adOC3e7yKqXW4JlHcKF+z7OrgVKprWeUikG397rX0hoWWv0l6kFLA9KOsX5PUVViSh+T105IHuMZ0hfN3n5TPBDmGgbTxdubgndgoJPpUTC0LdCoRQyOUPful8L4vdSkYCmyPmmzbIVa5WVkMwmmMcrwqCtcZSJuVyOLkrigFIDrB8/fCtgNAN3KWtBv1ypFVLLAXswyBhahr1etfDcLLzQTKG1pwNcaINU8cpxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ofGQeaA2/ShXinvFDQ54Hxr1kH9jRmLL3z4zm71ZI8Q=;
 b=CjpuPX/ao9qdHagD/dWFtSGKuPP+FbVWRdXDKZmyMwEmqNbGTpfT3J6P/jMG+oJZv1PTTqzPemn0Tf4fiIEIxAPA4IgnHmJlunnx0SYX6dAntohIdggHiOElB0u/leLtK7nFyQV8gIdi/JbHkI3ja6Fkli1hrNlVX1L56H/95kc=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3446.eurprd08.prod.outlook.com (20.177.113.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Sat, 16 Nov 2019 14:18:24 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::31bd:5bb3:377e:706f%3]) with mapi id 15.20.2451.029; Sat, 16 Nov 2019
 14:18:24 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu block <qemu-block@nongnu.org>
Subject: bdrv_is_allocated_above bug or feature
Thread-Topic: bdrv_is_allocated_above bug or feature
Thread-Index: AQHVnIi0OI91YfE7zEKMx5p/sKPw9g==
Date: Sat, 16 Nov 2019 14:18:24 +0000
Message-ID: <735cac20-6dff-db37-a0a7-92c008d947bf@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR1001CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::22) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3a4d01e-2fac-407b-e28b-08d76a9fd732
x-ms-traffictypediagnostic: AM6PR08MB3446:
x-microsoft-antispam-prvs: <AM6PR08MB34464C5C67C90E583CBB8D66C1730@AM6PR08MB3446.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 02234DBFF6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(136003)(39840400004)(346002)(396003)(376002)(53754006)(199004)(189003)(66066001)(478600001)(36756003)(6436002)(71190400001)(7736002)(6486002)(6512007)(6916009)(81166006)(81156014)(8676002)(8936002)(25786009)(4326008)(3846002)(5660300002)(31686004)(14444005)(256004)(14454004)(305945005)(2906002)(71200400001)(6116002)(26005)(486006)(64756008)(66556008)(99286004)(31696002)(66476007)(6506007)(86362001)(54906003)(66946007)(66446008)(386003)(102836004)(186003)(476003)(52116002)(316002)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3446;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6tGog1TL94eungFurp52zCck0bKb6z+3bXXN8j91aRk1xyPgFLJRZsoRlf4ToOwLCbZobTvmXsIlGY+ZrVBeVnoIgU2jmJauusoLDfUkmni+jN6NFSjp5QIXuzwD6Z9lzlR02zBOfvJKX09ybOGJqT1J2Pv0DuSy5v35HLUcVe0XBR4i7NsZJn8VtN3pkf5aN+AeNJNFJGSBR1MLlMDIGnFxxVucEDTOvoxVVAPsNln2iT8N538gnl80UBz8Ks8uaioEQ0B+e6M7FdTFbmNWXXnu7zuyPN/hAXMnRt0ytAcwD/JPFNekgKjluGKFZhTBkKK5/o3Y3t03yq/j2IPvRQyx/s1LGuxoXX1V1Z92D3hF4IvwEFYCHVqpLfIpdTiPyW6n3GHBCPxsifl1D6q2ht7tmpYUhKNuZQ8endyAsCVbsp3ASUroEmma/1sz33TY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <59086294C5DC784297536B2D741F045E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a4d01e-2fac-407b-e28b-08d76a9fd732
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2019 14:18:24.0734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JrDQktphSghwvaVnGGtQqMNICjOoXd/iEd9mk7QS842QYwi9q2xqk64ezxD+xqna6ZILvHFsFZUgPNf4i348aDszLU9xB+uYotD54Kjxb6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3446
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.110
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgYWxsIQ0KDQpJIHdhbnRlZCB0byB1bmRlcnN0YW5kLCB3aGF0IGlzIHRoZSByZWFsIGRpZmZl
cmVuY2UgYmV0d2VlbiBiZHJ2X2Jsb2NrX3N0YXR1c19hYm92ZQ0KYW5kIGJkcnZfaXNfYWxsb2Nh
dGVkX2Fib3ZlLCBJTUhPIGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlIHNob3VsZCB3b3JrIHRocm91
Z2gNCmJkcnZfYmxvY2tfc3RhdHVzX2Fib3ZlLi4NCg0KQW5kIEkgZm91bmQgdGhlIGRpZmZlcmVu
Y2U6IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlIGNvbnNpZGVycyBzcGFjZSBhZnRlciBFT0YgYXMN
ClVOQUxMT0NBVEVEIGZvciBpbnRlcm1lZGlhdGUgbm9kZXMuLg0KDQpVTkFMTE9DQVRFRCBpcyBu
b3QgYWJvdXQgYWxsb2NhdGlvbiBhdCBmcyBsZXZlbCwgYnV0IGFib3V0IHNob3VsZCB3ZSBnbyB0
byBiYWNraW5nIG9yDQpub3QuLiBBbmQgaXQgc2VlbXMgaW5jb3JyZWN0IGZvciBtZSwgYXMgaW4g
Y2FzZSBvZiBzaG9ydCBiYWNraW5nIGZpbGUsIHdlJ2xsIHJlYWQNCnplcm9lcyBhZnRlciBFT0Ys
IGluc3RlYWQgb2YgZ29pbmcgZnVydGhlciBieSBiYWNraW5nIGNoYWluLg0KDQpUaGlzIGxlYWRz
IHRvIHRoZSBmb2xsb3dpbmcgZWZmZWN0Og0KDQouL3FlbXUtaW1nIGNyZWF0ZSAtZiBxY293MiBi
YXNlLnFjb3cyIDJNDQouL3FlbXUtaW8gLWMgIndyaXRlIC1QIDB4MSAwIDJNIiBiYXNlLnFjb3cy
DQoNCi4vcWVtdS1pbWcgY3JlYXRlIC1mIHFjb3cyIC1iIGJhc2UucWNvdzIgbWlkLnFjb3cyIDFN
DQouL3FlbXUtaW1nIGNyZWF0ZSAtZiBxY293MiAtYiBtaWQucWNvdzIgdG9wLnFjb3cyIDJNDQoN
ClJlZ2lvbiAxTS4uMk0gaXMgc2hhZG93ZWQgYnkgc2hvcnQgbWlkZGxlIGltYWdlLCBzbyBndWVz
dCBzZWVzIHplcm9lczoNCi4vcWVtdS1pbyAtYyAicmVhZCAtUCAwIDFNIDFNIiB0b3AucWNvdzIN
CnJlYWQgMTA0ODU3Ni8xMDQ4NTc2IGJ5dGVzIGF0IG9mZnNldCAxMDQ4NTc2DQoxIE1pQiwgMSBv
cHM7IDAwLjAwIHNlYyAoMjIuNzk1IEdpQi9zZWMgYW5kIDIzMzQxLjU4MDcgb3BzL3NlYykNCg0K
QnV0IGFmdGVyIGNvbW1pdCBndWVzdCB2aXNpYmxlIHN0YXRlIGlzIGNoYW5nZWQsIHdoaWNoIHNl
ZW1zIHdyb25nIGZvciBtZToNCi4vcWVtdS1pbWcgY29tbWl0IHRvcC5xY293MiAtYiBtaWQucWNv
dzINCg0KLi9xZW11LWlvIC1jICJyZWFkIC1QIDAgMU0gMU0iIG1pZC5xY293Mg0KUGF0dGVybiB2
ZXJpZmljYXRpb24gZmFpbGVkIGF0IG9mZnNldCAxMDQ4NTc2LCAxMDQ4NTc2IGJ5dGVzDQpyZWFk
IDEwNDg1NzYvMTA0ODU3NiBieXRlcyBhdCBvZmZzZXQgMTA0ODU3Ng0KMSBNaUIsIDEgb3BzOyAw
MC4wMCBzZWMgKDQuOTgxIEdpQi9zZWMgYW5kIDUxMDAuNDc5NCBvcHMvc2VjKQ0KDQouL3FlbXUt
aW8gLWMgInJlYWQgLVAgMSAxTSAxTSIgbWlkLnFjb3cyDQpyZWFkIDEwNDg1NzYvMTA0ODU3NiBi
eXRlcyBhdCBvZmZzZXQgMTA0ODU3Ng0KMSBNaUIsIDEgb3BzOyAwMC4wMCBzZWMgKDMuMzY1IEdp
Qi9zZWMgYW5kIDM0NDYuMTYwNiBvcHMvc2VjKQ0KDQoNCkkgZG9uJ3Qga25vdywgaXMgaXQgYSBy
ZWFsIGJ1ZywgYXMgSSBkb24ndCBrbm93LCBkbyB3ZSBzdXBwb3J0IGJhY2tpbmcgZmlsZSBsYXJn
ZXIgdGhhbg0KaXRzIHBhcmVudC4gU3RpbGwsIEknbSBub3Qgc3VyZSB0aGF0IHRoaXMgYmVoYXZp
b3Igb2YgYmRydl9pc19hbGxvY2F0ZWRfYWJvdmUgZG9uJ3QgbGVhZA0KdG8gb3RoZXIgcHJvYmxl
bXMuDQoNCj09PT09DQoNCkhtbSwgYmRydl9ibG9ja19hbGxvY2F0ZWRfYWJvdmUgYmVoYXZlcyBz
dHJhbmdlIHRvbzoNCg0Kd2l0aCB3YW50X3plcm89dHJ1ZSwgaXQgbWF5IHJlcG9ydCB1bmFsbG9j
YXRlZCB6ZXJvZXMgYmVjYXVzZSBvZiBzaG9ydCBiYWNraW5nIGZpbGVzLCB3aGljaA0KYXJlIGFj
dHVhbGx5ICJhbGxvY2F0ZWQiIGluIFBPViBvZiBiYWNraW5nIGNoYWlucy4gQnV0IEkgc2VlIHRo
aXMgbWF5IGluZmx1ZW5jZSBvbmx5DQpxZW11LWltZyBjb21wYXJlLCBhbmQgSSBkb24ndCBzZWUg
Y2FuIGl0IHRyaWdnZXIgc29tZSBidWcuLg0KDQp3aXRoIHdhbnRfemVybz1mYWxzZSwgaXQgbWF5
IGRvIG5vIHByb2dyZXNzIGJlY2F1c2Ugb2Ygc2hvcnQgYmFja2luZyBmaWxlLiBNb3Jlb3ZlciBp
dCBtYXkNCnJlcG9ydCBFT0YgaW4gdGhlIG1pZGRsZSEhIEJ1dCB3YW50X3plcm89ZmFsc2UgdXNl
ZCBvbmx5IGluIGJkcnZfaXNfYWxsb2NhdGVkLCB3aGljaCBjb25zaWRlcnMNCm9ubHl0IHRvcCBs
YXllciwgc28gaXQgc2VlbXMgT0suDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==


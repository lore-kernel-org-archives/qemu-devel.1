Received: from eggs.gnu.org ([209.51.188.92]:40401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDW0l-0002a2-6p
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDW0e-0000ZW-6e
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:16:34 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 8 Apr 2019 15:16:22 +0000
Message-ID: <3e489e51-79c7-54ec-7018-e7424d2c6f40@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec4y1wv.fsf@maestria.local.igalia.com>
In-Reply-To: <w517ec4y1wv.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E954B542076A6A409DB6571CB1407C61@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/3] block: include base when checking
 image chain for block allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDA4LzA0LzIwMTkgMTg6MDMsIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBGcmkg
MDUgQXByIDIwMTkgMDY6NTY6MTcgUE0gQ0VTVCwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+
PiAraW50IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlKEJsb2NrRHJpdmVyU3RhdGUgKnRvcCwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqYmFzZSwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCBvZmZzZXQsIGludDY0X3QgYnl0
ZXMsIGludDY0X3QgKnBudW0pDQo+PiArew0KPj4gKyAgICByZXR1cm4gYmRydl9kb19pc19hbGxv
Y2F0ZWRfYWJvdmUodG9wLCBiYXNlLCBmYWxzZSwgb2Zmc2V0LCBieXRlcywgcG51bSk7DQo+PiAr
fQ0KPj4gKw0KPj4gK2ludCBiZHJ2X2lzX2FsbG9jYXRlZF9hYm92ZV9pbmNsdXNpdmUoQmxvY2tE
cml2ZXJTdGF0ZSAqdG9wLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgQmxvY2tEcml2ZXJTdGF0ZSAqYmFzZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludDY0X3Qgb2Zmc2V0LCBpbnQ2NF90IGJ5dGVzLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCAqcG51bSkNCj4+ICt7DQo+PiAr
ICAgIHJldHVybiBiZHJ2X2RvX2lzX2FsbG9jYXRlZF9hYm92ZSh0b3AsIGJhc2UsIHRydWUsIG9m
ZnNldCwgYnl0ZXMsIHBudW0pOw0KPj4gK30NCj4gDQo+IEluc3RlYWQgb2YgaGF2aW5nIHRoZXNl
IHR3bywgaXNuJ3QgaXQgc2ltcGxlciB0byBhZGQgYW4gJ2luY2x1ZGVfYmFzZScNCj4gcGFyYW1l
dGVyIHRvIHRoZSBvcmlnaW5hbCBmdW5jdGlvbj8NCj4gDQo+IEFub3RoZXIgYWx0ZXJuYXRpdmUg
KEkgaGF2ZW4ndCBjaGVja2VkIHRoaXMgb25lIHNvIGl0IGNvdWxkIGJlIG1vcmUNCj4gY3VtYmVy
c29tZSk6IGNoYW5nZSB0aGUgc2VtYW50aWNzIG9mIHRoZSBmdW5jdGlvbiB0byBhbHdheXMgaW5j
bHVkZSB0aGUNCj4gYmFzZSBhbmQgbW9kaWZ5IHRoZSBjYWxsZXJzLg0KPiANCj4gQmVydG8NCj4g
DQoNClRoZSBpZGVhIGJlaGluZCB0aG9zZSB0d28gZnVuY3Rpb25zIHdhcyB0byBrZWVwIHRoZSBy
ZXN0IG9mIHRoZSBjb2RlDQp1bm1vZGlmaWVkLiBDdXJyZW50bHksIHdlIGhhdmUgdGhlIGlzc3Vl
IHdpdGggdGhlIGJsb2NrLXN0cmVhbQ0KcGFyYWxsZWwgam9icy4gV2hhdCBpZiB3ZSBtYW5hZ2Ug
dGhpcyBjYXNlIGZpcnN0IGFuZCB0aGVuLCB3aGVuDQpwcm92ZWQgdG8gYmUgcm9idXN0LCB0YWtl
IGNhcmUgb2YgdGhlIHJlc3Q/DQotLSANCldpdGggdGhlIGJlc3QgcmVnYXJkcywNCkFuZHJleSBT
aGlua2V2aWNoDQo=

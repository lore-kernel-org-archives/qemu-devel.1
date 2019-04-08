Received: from eggs.gnu.org ([209.51.188.92]:39890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDVzW-0001g0-UK
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDVzU-0006de-SF
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:15:22 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 8 Apr 2019 15:14:54 +0000
Message-ID: <61c30faa-ef13-bcc8-7a98-097421b5c854@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec4y1wv.fsf@maestria.local.igalia.com>
In-Reply-To: <w517ec4y1wv.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <0479A4AD5F78FF42B1793E5B72E939D9@eurprd08.prod.outlook.com>
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
To: Alberto Garcia <berto@igalia.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, Denis Lunev <den@virtuozzo.com>

MDguMDQuMjAxOSAxODowMywgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IE9uIEZyaSAwNSBBcHIg
MjAxOSAwNjo1NjoxNyBQTSBDRVNULCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+ICtpbnQg
YmRydl9pc19hbGxvY2F0ZWRfYWJvdmUoQmxvY2tEcml2ZXJTdGF0ZSAqdG9wLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBCbG9ja0RyaXZlclN0YXRlICpiYXNlLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90IG9mZnNldCwgaW50NjRfdCBieXRlcywgaW50
NjRfdCAqcG51bSkNCj4+ICt7DQo+PiArICAgIHJldHVybiBiZHJ2X2RvX2lzX2FsbG9jYXRlZF9h
Ym92ZSh0b3AsIGJhc2UsIGZhbHNlLCBvZmZzZXQsIGJ5dGVzLCBwbnVtKTsNCj4+ICt9DQo+PiAr
DQo+PiAraW50IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3ZlX2luY2x1c2l2ZShCbG9ja0RyaXZlclN0
YXRlICp0b3AsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCbG9j
a0RyaXZlclN0YXRlICpiYXNlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50NjRfdCBvZmZzZXQsIGludDY0X3QgYnl0ZXMsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbnQ2NF90ICpwbnVtKQ0KPj4gK3sNCj4+ICsgICAgcmV0
dXJuIGJkcnZfZG9faXNfYWxsb2NhdGVkX2Fib3ZlKHRvcCwgYmFzZSwgdHJ1ZSwgb2Zmc2V0LCBi
eXRlcywgcG51bSk7DQo+PiArfQ0KPiANCj4gSW5zdGVhZCBvZiBoYXZpbmcgdGhlc2UgdHdvLCBp
c24ndCBpdCBzaW1wbGVyIHRvIGFkZCBhbiAnaW5jbHVkZV9iYXNlJw0KPiBwYXJhbWV0ZXIgdG8g
dGhlIG9yaWdpbmFsIGZ1bmN0aW9uPw0KPiANCj4gQW5vdGhlciBhbHRlcm5hdGl2ZSAoSSBoYXZl
bid0IGNoZWNrZWQgdGhpcyBvbmUgc28gaXQgY291bGQgYmUgbW9yZQ0KPiBjdW1iZXJzb21lKTog
Y2hhbmdlIHRoZSBzZW1hbnRpY3Mgb2YgdGhlIGZ1bmN0aW9uIHRvIGFsd2F5cyBpbmNsdWRlIHRo
ZQ0KPiBiYXNlIGFuZCBtb2RpZnkgdGhlIGNhbGxlcnMuDQo+IA0KDQpUaGUgaWRlYSB3YXMgZXhh
Y3RseSB0byBhdm9pZCBtb2RpZnlpbmcgYWxsIGNhbGxlcnMuLiBBbmQgaXQgc2VlbXMgZ29vZCwg
YXQgbGVhc3QgYXMgZmlyc3Qgc3RlcC4NCldlIG1heSB3YW50IHRvIG1vZGlmeSBvdGhlciBjYWxs
ZXJzIGJ1dCBpdCBpcyBvdXQgb2Ygc3RyZWFtIHNlcmllcy4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMs
DQpWbGFkaW1pcg0K

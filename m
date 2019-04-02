Received: from eggs.gnu.org ([209.51.188.92]:60869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hBFe4-00025i-6N
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hBFLM-0006zd-0D
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 05:04:33 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 2 Apr 2019 08:59:25 +0000
Message-ID: <0281e339-181e-1d31-9ff9-730fc3ccc1de@virtuozzo.com>
References: <1553866154-257311-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1553866154-257311-4-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w51sgv54qaz.fsf@maestria.local.igalia.com>
	<85b426d8-0d8a-1180-fe80-46450b83582b@virtuozzo.com>
	<w51y34t4to4.fsf@maestria.local.igalia.com>
	<1c21c139-a98d-1510-a1ec-1f9131c219bc@virtuozzo.com>
In-Reply-To: <1c21c139-a98d-1510-a1ec-1f9131c219bc@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C810F80DEA42134C988A29EA70FB4FC8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/3] block/stream: introduce a bottom node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>

MDIuMDQuMjAxOSAxMTo1MSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IA0KPiANCj4gT24g
MDEvMDQvMjAxOSAxODo0NCwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+PiBPbiBGcmkgMjkgTWFy
IDIwMTkgMDU6MTU6NDMgUE0gQ0VULCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3Rl
Og0KPj4+Pj4gQEAgLTMyMzcsNyArMzIzOCwxNCBAQCB2b2lkIHFtcF9ibG9ja19zdHJlYW0oYm9v
bCBoYXNfam9iX2lkLCBjb25zdCBjaGFyICpqb2JfaWQsIGNvbnN0IGNoYXIgKmRldmljZSwNCj4+
Pj4+ICAgICAgICAgICAgIGpvYl9mbGFncyB8PSBKT0JfTUFOVUFMX0RJU01JU1M7DQo+Pj4+PiAg
ICAgICAgIH0NCj4+Pj4+ICAgICANCj4+Pj4+IC0gICAgc3RyZWFtX3N0YXJ0KGhhc19qb2JfaWQg
PyBqb2JfaWQgOiBOVUxMLCBicywgYmFzZV9icywgYmFzZV9uYW1lLA0KPj4+Pj4gKyAgICAvKiBG
aW5kIHRoZSBib3R0b20gbm9kZSB0aGF0IGhhcyB0aGUgYmFzZSBhcyBpdHMgYmFja2luZyBpbWFn
ZSAqLw0KPj4+Pj4gKyAgICBib3R0b21fbm9kZSA9IGJzOw0KPj4+Pj4gKyAgICB3aGlsZSAoKGl0
ZXIgPSBiYWNraW5nX2JzKGJvdHRvbV9ub2RlKSkgIT0gYmFzZV9icykgew0KPj4+Pj4gKyAgICAg
ICAgYm90dG9tX25vZGUgPSBpdGVyOw0KPj4+Pj4gKyAgICB9DQo+Pj4+PiArICAgIGFzc2VydChi
b3R0b21fbm9kZSk7DQo+Pj4+PiArDQo+Pj4+PiArICAgIHN0cmVhbV9zdGFydChoYXNfam9iX2lk
ID8gam9iX2lkIDogTlVMTCwgYnMsIGJvdHRvbV9ub2RlLCBiYXNlX25hbWUsDQo+Pj4+PiAgICAg
ICAgICAgICAgICAgICAgICBqb2JfZmxhZ3MsIGhhc19zcGVlZCA/IHNwZWVkIDogMCwgb25fZXJy
b3IsICZsb2NhbF9lcnIpOw0KPj4+Pg0KPj4+PiBJc24ndCBpdCBzaW1wbGVyIHRvIHBhc3MgJ2Jh
c2UnIHRvIHN0cmVhbV9zdGFydCgpIGFuZCBmaW5kIHRoZSBib3R0b20NCj4+Pj4gbm9kZSB0aGVy
ZT8gKHdpdGggYmRydl9maW5kX292ZXJsYXkoKSkuDQo+Pj4+DQo+Pj4+IEkgdGhpbmsgYm90dG9t
IHNob3VsZCBiZSBhbiBpbnRlcm5hbCBpbXBsZW1lbnRhdGlvbiBkZXRhaWwgb2YgdGhlDQo+Pj4+
IGJsb2NrLXN0cmVhbSBkcml2ZXIsIGNhbGxlcnMgZG9uJ3QgbmVlZCB0byBrbm93IGFib3V0IGl0
LCBvciBkbyB0aGV5Pw0KPj4+Pg0KPj4+IE15IGlkZWEgaXMgdGhhdCB3ZSBzaG91bGQgZ2V0IHJp
ZCBvZiBiYXNlIGJlZm9yZSBhbnkgeWllbGQsIGFuZCBiZXR0ZXINCj4+PiBkbyBpdCBhcyBzb29u
IGFzIHBvc3NpYmxlLg0KPj4NCj4+IEJ1dCB5b3UgY2FuIGRvIGl0IGF0IHRoZSBiZWdpbm5pbmcg
b2Ygc3RyZWFtX3N0YXJ0KCkgd2l0aG91dCBleHBvc2luZw0KPj4gJ2JvdHRvbScgdG8gdGhlIGNh
bGxlcnMgd2hpY2gsIGFnYWluLCBpcyBhbiBpbXBsZW1lbnRhdGlvbiBkZXRhaWwuDQo+Pg0KPj4g
QmVydG8NCj4+DQo+IA0KPiBXZSBoYXZlIGdvdCBhIGxhdGVudCB0cm91YmxlIHdpdGggdGhlIGJh
c2UgaW52b2x2ZWQgaW50byB0aGUgcHJvY2Vzcy4NCj4gRm9yIGluc3RhbmNlLCBpZiB3ZSBlbmNv
dW50ZXIgYSBmaWx0ZXIgd2hpbGUgc2VhcmNoaW5nIGZvciB0aGUgYmFzZSwNCj4gd2Ugd2lsbCB3
YW50IHRvIG1hbmFnZSBpdCBzb21laG93LiBJZiB0aGUgYmFzZSBpcyBpZGVudGlmaWVkIGJ5IHRo
ZQ0KPiBub2RlIG5hbWUgcmF0aGVyIHRoYW4gYnkgZmlsZSBuYW1lLCBpdCB3b3VsZCBiZSBlYXNp
ZXIuIFNvLCB3ZSB3b3VsZA0KPiBhc3NpZ24gdGhlIG5vZGUgbmFtZSB0byB0aGUgYmFzZSBlYXJs
aWVzdCBhcyBwb3NzaWJsZS4gQW5vdGhlciBhcHByb2FjaA0KPiBzdWdnZXN0ZWQgYnkgVmxhZGlt
aXIgc3VwcG9zZWQgdG8gZWxpbWluYXRlIHRoZSBiYXNlIGZyb20gdGhlIGludGVyZmFjZS4NCj4g
SXQgaXMgYSBzZW5zaXRpdmUgY2hhbmdlIGFuZCB3ZSBhbGwgbmVlZCB0byBjb21lIHRvIGFuIGFn
cmVlbWVudC4NCj4gDQoNCg0KT24gdGhlIG90aGVyIGhhbmQgd2UgZnJlZXplIGJhY2tpbmcgY2hh
aW4gaW4gc3RyZWFtX3N0YXJ0IGFueXdheS4gU28sIHdlJ2QgbGlrZQ0KdG8gYmUgc3VyZSBhbnl3
YXksIHRoYXQgdGhlcmUgYXJlIG5vIHlpZWxkcyBiZWZvcmUgc3RyZWFtX3N0YXJ0KCkgY2FsbC4N
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

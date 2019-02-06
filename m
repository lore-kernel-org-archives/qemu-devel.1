Received: from eggs.gnu.org ([209.51.188.92]:48616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grRu8-0003Ti-1M
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grRu1-0006ka-B1
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 13:26:32 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Feb 2019 18:26:22 +0000
Message-ID: <6cf6c085-3a28-0a7c-75b2-79f181e3ca6e@virtuozzo.com>
References: <20190206165342.219192-1-vsementsov@virtuozzo.com>
	<20190206165342.219192-3-vsementsov@virtuozzo.com>
	<abf6dafa-da7d-4bf5-5a21-225c2809a038@redhat.com>
	<aced9235-a3d7-e201-ce13-ff2094ac974f@virtuozzo.com>
	<608f7ff7-7b3c-939a-7bdb-852f63f4828e@redhat.com>
In-Reply-To: <608f7ff7-7b3c-939a-7bdb-852f63f4828e@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B5476E903C69C49B3E0FB0DE7DB9BF6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/2] block/io: use qemu_iovec_init_buf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>

MDYuMDIuMjAxOSAyMToxNCwgRXJpYyBCbGFrZSB3cm90ZToNCj4gT24gMi82LzE5IDEyOjA5IFBN
LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gMDYuMDIuMjAxOSAyMDoz
MiwgRXJpYyBCbGFrZSB3cm90ZToNCj4+PiBPbiAyLzYvMTkgMTA6NTMgQU0sIFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+IFVzZSBuZXcgcWVtdV9pb3ZlY19pbml0X2J1
ZigpIGluc3RlYWQgb2YNCj4+Pj4gcWVtdV9pb3ZlY19pbml0X2V4dGVybmFsKCAuLi4gLCAxKSwg
d2hpY2ggc2ltcGxpZmllcyB0aGUgY29kZS4NCj4+Pg0KPj4+IERpZCB5b3UganVzdCBkbyBhIG1h
bnVhbCBzZWFyY2ggZm9yIGNhbmRpZGF0ZSBjYWxsZXJzPw0KPj4+DQo+Pj4gQXMgeW91IHNhaWQg
aW4gdGhlIGNvdmVyIGxldHRlciwgdGhlcmUgYXJlIG90aGVyIGZpbGVzIHRoYXQgY2FuIGJlbmVm
aXQNCj4+PiBhcyB3ZWxsOyBhcmUgeW91IHBsYW5uaW5nIG9uIG1ha2luZyB2MyBvZiB0aGUgc2Vy
aWVzIGxvbmdlcj8NCj4+DQo+PiBnaXQgZ3JlcCBxZW11X2lvdmVjX2luaXRfZXh0ZXJuYWwgfCBn
cmVwIDENCj4+DQo+PiBzaG93cyBhIGxvdCBvZiwgZXhhY3RseSAzNCBhZnRlciBpby5jIGFscmVh
ZHkgdXBkYXRlZC4NCj4+IFRoZXkgYXJlIGluIGRpZmZlcmVudCBzdWJzeXN0ZW1zLCBzbyBJIHRo
aW5rIGl0IHNob3VsZCBiZSBzaW1wbGVyIHRvIHB1c2ggdGhpcw0KPj4gb25lIGFzIGEgcHJlY2Vk
ZW50IGFuZCBleGFtcGxlLCBhbmQgdGhlbiBzZW5kIHNlcGFyYXRlIHBhdGNoZXMgKG9yIHNlcmll
cykNCj4+IHBlci1tYWludGFpbmVyLg0KPiANCj4gTW9zdCBhcmUgYmxvY2sgcmVsYXRlZCwgc28g
Z2V0dGluZyBpdCBpbiB0aHJvdWdoIHRoZSBibG9jayBtYWludGFpbmVycw0KPiBpcyBwcm9iYWJs
eSB0aGUgZWFzaWVzdCAtIGJ1dCB5b3UgQVJFIHJpZ2h0IHRoYXQgb25lIHBhdGNoIHBlciBvbmUg
b3INCj4gdHdvIGZpbGVzIG9yIHR3byBpcyBnb2luZyB0byBiZSBzbWFydGVzdCAob3RoZXJ3aXNl
LCBpdCBnZXRzIHRvbyBiaWcpLg0KPiANCj4+DQo+PiBobSwgaW4gb3RoZXIgd29yZHM6DQo+PiAj
IGdpdCBncmVwIC1sICdxZW11X2lvdmVjX2luaXRfZXh0ZXJuYWwuKjEnDQo+PiBibG9jay9iYWNr
dXAuYw0KPj4gYmxvY2svYmxvY2stYmFja2VuZC5jDQo+PiBibG9jay9jb21taXQuYw0KPj4gYmxv
Y2svcGFyYWxsZWxzLmMNCj4+IGJsb2NrL3Fjb3cuYw0KPj4gYmxvY2svcWNvdzIuYw0KPj4gYmxv
Y2svcWVkLXRhYmxlLmMNCj4+IGJsb2NrL3FlZC5jDQo+PiBibG9jay9zdHJlYW0uYw0KPj4gYmxv
Y2svdm1kay5jDQo+PiBody9pZGUvYXRhcGkuYw0KPj4gaHcvaWRlL2NvcmUuYw0KPj4gaHcvc2Nz
aS9zY3NpLWRpc2suYw0KPj4gbWlncmF0aW9uL2Jsb2NrLmMNCj4+IHFlbXUtaW1nLmMNCj4+IHRl
c3RzL3Rlc3QtYmRydi1kcmFpbi5jDQo+IA0KPiBJJ2QgZ3JvdXAgcWVkLXRhYmxlLmMgYW5kIHFl
ZC5jOyBhbmQgdGhlIHR3byBody9pZGUvIGZpbGVzOyByZXN1bHRpbmcgaW4NCj4gMTQgbW9yZSBw
YXRjaGVzIHRvIGdvLg0KPiANCg0KU28sIHlvdSwgdGhpbmsgYmV0dGVyIGlzIHRvIG1ha2Ugb25l
IGNvbW1vbiBwYXRjaCBzZXQ/IE9rLCBJJ2xsIGRvIChobW0gb3Igc3RhcnQgZG9pbmcpDQppdCB0
b21vcnJvdyBhcyB2MyBpZiBubyBvdGhlciBvcGluaW9ucy4NCg0KDQotLSANCkJlc3QgcmVnYXJk
cywNClZsYWRpbWlyDQo=

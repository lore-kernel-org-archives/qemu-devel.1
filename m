Received: from eggs.gnu.org ([209.51.188.92]:48645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gj2oc-0000vR-2Q
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:02:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gj2oR-0006sa-Le
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 09:02:09 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 14 Jan 2019 14:01:50 +0000
Message-ID: <5accce39-2c94-ca4e-5afc-2fec242836a8@virtuozzo.com>
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-2-vsementsov@virtuozzo.com>
	<cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
In-Reply-To: <cc033e38-2790-6dcd-6401-191ce9bf8d81@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <88FFE7DD2055594699080C853020993C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 01/11] block/backup: simplify
 backup_incremental_init_copy_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "eblake@redhat.com" <eblake@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

MTQuMDEuMjAxOSAxNjoxMCwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4xMi4xOCAxMzoyMCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFNpbXBsaWZ5IGJhY2t1cF9p
bmNyZW1lbnRhbF9pbml0X2NvcHlfYml0bWFwIHVzaW5nIHRoZSBmdW5jdGlvbg0KPj4gYmRydl9k
aXJ0eV9iaXRtYXBfbmV4dF9kaXJ0eV9hcmVhLg0KPj4NCj4+IE5vdGU6IG1vdmUgdG8gam9iLT5s
ZW4gaW5zdGVhZCBvZiBiaXRtYXAgc2l6ZTogaXQgc2hvdWxkIG5vdCBtYXR0ZXIgYnV0DQo+PiBs
ZXNzIGNvZGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2
c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8uY29tPg0KPj4gLS0tDQo+PiAgIGJsb2NrL2JhY2t1
cC5jIHwgNDAgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMjggZGVsZXRpb25zKC0pDQo+IA0KPiBP
dmVyYWxsOiBXaGF0IGlzIHRoaXMgZnVuY3Rpb24gZXZlbiBzdXBwb3NlZCB0byBkbz8gIFRvIG1l
LCBpdCBsb29rcw0KPiBsaWtlIGl0IG1hcmtzIGFsbCBhcmVhcyBpbiBqb2ItPmNvcHlfYml0bWFw
IGRpcnR5IHRoYXQgYXJlIGRpcnR5IGluDQo+IGpvYi0+c3luY19iaXRtYXAuDQo+IA0KPiBJZiBz
bywgd291bGRuJ3QganVzdCByZXBsYWNpbmcgdGhpcyBieSBoYml0bWFwX21lcmdlKCkgc2ltcGxp
ZnkgdGhpbmdzDQo+IGZ1cnRoZXI/DQo+IA0KPj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2JhY2t1cC5j
IGIvYmxvY2svYmFja3VwLmMNCj4+IGluZGV4IDQzNTQxNGU5NjQuLmZiZTdjZTE5ZTEgMTAwNjQ0
DQo+PiAtLS0gYS9ibG9jay9iYWNrdXAuYw0KPj4gKysrIGIvYmxvY2svYmFja3VwLmMNCj4+IEBA
IC00MDYsNDMgKzQwNiwyNyBAQCBzdGF0aWMgaW50IGNvcm91dGluZV9mbiBiYWNrdXBfcnVuX2lu
Y3JlbWVudGFsKEJhY2t1cEJsb2NrSm9iICpqb2IpDQo+IA0KPiBbLi4uXQ0KPiANCj4+ICsgICAg
d2hpbGUgKGJkcnZfZGlydHlfYml0bWFwX25leHRfZGlydHlfYXJlYShqb2ItPnN5bmNfYml0bWFw
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZvZmZz
ZXQsICZieXRlcykpDQo+PiArICAgIHsNCj4+ICsgICAgICAgIHVpbnQ2NF90IGNsdXN0ZXIgPSBv
ZmZzZXQgLyBqb2ItPmNsdXN0ZXJfc2l6ZTsNCj4+ICsgICAgICAgIHVpbnQ2NF90IGxhc3RfY2x1
c3RlciA9IChvZmZzZXQgKyBieXRlcykgLyBqb2ItPmNsdXN0ZXJfc2l6ZTsNCj4+ICAgDQo+PiAt
ICAgICAgICBuZXh0X2NsdXN0ZXIgPSBESVZfUk9VTkRfVVAob2Zmc2V0LCBqb2ItPmNsdXN0ZXJf
c2l6ZSk7DQo+PiAtICAgICAgICBoYml0bWFwX3NldChqb2ItPmNvcHlfYml0bWFwLCBjbHVzdGVy
LCBuZXh0X2NsdXN0ZXIgLSBjbHVzdGVyKTsNCj4+IC0gICAgICAgIGlmIChuZXh0X2NsdXN0ZXIg
Pj0gZW5kKSB7DQo+PiArICAgICAgICBoYml0bWFwX3NldChqb2ItPmNvcHlfYml0bWFwLCBjbHVz
dGVyLCBsYXN0X2NsdXN0ZXIgLSBjbHVzdGVyICsgMSk7DQo+IA0KPiBXaHkgdGhlICsxPyAgU2hv
dWxkbid0IHRoZSBkaXZpc2lvbiBmb3IgbGFzdF9jbHVzdGVyIHJvdW5kIHVwIGluc3RlYWQ/DQo+
IA0KPj4gKw0KPj4gKyAgICAgICAgb2Zmc2V0ID0gKGxhc3RfY2x1c3RlciArIDEpICogam9iLT5j
bHVzdGVyX3NpemU7DQo+IA0KPiBTYW1lIGhlcmUuDQoNCmxhc3QgY2x1c3RlciBpcyBub3QgImVu
ZCIsIGJ1dCBpdCdzIGxhc3QgZGlydHkgY2x1c3Rlci4gc28gbnVtYmVyIG9mIGRpcnR5IGNsdXN0
ZXJzIGlzIGxhc3RfY2x1c3RlciAtIGNsdXN0ZXIgKyAxLCBhbmQgbmV4dCBvZmZzZXQgaXMgY2Fs
Y3VsYXRlZCB0aHJvdWdoICsxIHRvby4NCg0KSWYgSSByb3VuZCB1cCBkaXZpc2lvbiByZXN1bHQs
IEknbGwgZ2V0IGxhc3QgZm9yIG1vc3QgY2FzZXMsIGJ1dCAiZW5kIiAobmV4dCBhZnRlciB0aGUg
bGFzdCksIGZvciB0aGUgY2FzZSB3aGVuIG9mZnNldCAlIGpvYi0+Y2x1c3Rlcl9zaXplID09IDAs
IHNvLCBob3cgdG8gdXNlIGl0Pw0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

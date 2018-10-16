Received: from eggs.gnu.org ([2001:4830:134:3::10]:57953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Stewart.Hildebrand@dornerworks.com>)
	id 1gCE1P-0002Gx-JJ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 21:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Stewart.Hildebrand@dornerworks.com>)
	id 1gCE1O-0002uW-PG
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 21:19:43 -0400
From: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>
Date: Tue, 16 Oct 2018 01:19:35 +0000
Message-ID: <65e2edeee9d94a288938da9cec4b16bb@dornerworks.com>
References: <40eb19fb56b24e10a5eaa99ccb78aff6@dornerworks.com>
	<73dcea68-2342-63b7-9691-a151f00a42e8@redhat.com>
In-Reply-To: <73dcea68-2342-63b7-9691-a151f00a42e8@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: Increase compliance with
 kernel arm64 boot protocol.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Andre Przywara <andre.przywara@arm.com>, Julien Grall <julien.grall@arm.com>, Peter Maydell <peter.maydell@linaro.org>

SGkgUGhpbGlwcGUsDQoNCk9uIE1vbmRheSwgT2N0b2JlciAxNSwgMjAxOCA2OjA1IFBNLCBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gSGkgU3Rld2FydCwNCj4gDQo+IE9uIDE1LzEw
LzIwMTggMjM6MjYsIFN0ZXdhcnQgSGlsZGVicmFuZCB3cm90ZToNCj4gPiArICAgICAgICAgICAg
LyogRm9yIHRoZSB2aXJ0IGJvYXJkLCB3ZSB3cml0ZSBvdXIgc3RhcnR1cCAiYm9vdGxvYWRlciIg
YXQgdGhlIHZlcnkNCj4gPiArICAgICAgICAgICAgICogYm90dG9tIG9mIFJBTSwgc28gdGhhdCBi
aXQgY2FuJ3QgYmUgdXNlZCBmb3IgdGhlIGltYWdlLiBUbyBhdm9pZA0KPiA+ICsgICAgICAgICAg
ICAgKiBvdmVybGFwIGluIGNhc2UgdGhlIGltYWdlIHJlcXVlc3RzIHRvIGJlIGxvYWRlZCBhdCBh
biBvZmZzZXQNCj4gPiArICAgICAgICAgICAgICogc21hbGxlciB0aGFuIG91ciBib290bG9hZGVy
LCB3ZSBpbmNyZW1lbnQgdGhlIGxvYWQgb2Zmc2V0IHRvIHRoZQ0KPiA+ICsgICAgICAgICAgICAg
KiBuZXh0IDJNQi4NCj4gPiArICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgIGlmIChr
ZXJuZWxfbG9hZF9vZmZzZXQgPCBGSVhVUF9NQVgpIHsNCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFu
ZCBob3cgdGhpcyBpcyByZWxhdGVkIHRvIEZJWFVQX01BWC4uLg0KDQpZb3UncmUgcmlnaHQsIG15
IGFwb2xvZ2llcywgaXQncyBub3QgZGlyZWN0bHkgcmVsYXRlZC4NCndyaXRlX2Jvb3Rsb2FkZXIo
KSBjYWxjdWxhdGVzIHRoZSBzaXplIG9mIHRoZSBib290bG9hZGVyIGxpa2Ugc286DQogICAgbGVu
ID0gMDsNCiAgICB3aGlsZSAoaW5zbnNbbGVuXS5maXh1cCAhPSBGSVhVUF9URVJNSU5BVE9SKSB7
DQogICAgICAgIGxlbisrOw0KICAgIH0NCg0KVGhlIHNpemUgb2YgdGhlIGJvb3Rsb2FkZXIgdGhl
biB3b3VsZCBiZSBsZW4gKiBzaXplb2YodWludDMyX3QpDQoNCkl0IHdvdWxkIGJlIG5pY2Ugbm90
IHRvIGhhdmUgdG8gcmVwZWF0IHRoYXQgbG9naWMgaW4gbG9hZF9hYXJjaDY0X2ltYWdlKCkuIEkn
bGwgc2VuZCBvdXQgYSB2MiBhZnRlciBJIHRha2Ugc29tZSB0aW1lIHRvIHdyYXAgbXkgaGVhZCBh
cm91bmQgaXQuLi4NCiANCj4gDQo+ID4gKyAgICAgICAgICAgICAgICBrZXJuZWxfbG9hZF9vZmZz
ZXQgKz0gMiA8PCAyMDsNCj4gDQo+IFlvdSBjYW4gdXNlICs9IDIgKiBNaUI7IHdoaWNoIGlzIGVh
c2llciB0byByZXZpZXcuDQoNCk9LLCBJIHdpbGwgaW5jbHVkZSB0aGlzIGluIHYyLg0K

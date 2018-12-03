Received: from eggs.gnu.org ([2001:4830:134:3::10]:51375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gToz5-0001PM-Bu
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:14:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gToz2-0004at-Ch
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:14:01 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 3 Dec 2018 14:13:47 +0000
Message-ID: <28cbfc9d-c734-835e-7e0c-5524af733453@virtuozzo.com>
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<da28be03-4e8a-c75f-8bfa-35e24ad14cca@redhat.com>
In-Reply-To: <da28be03-4e8a-c75f-8bfa-35e24ad14cca@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7F69AC7BA0BF644B7FABDF530BC2BC6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 0/2] mirror dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

MDMuMTIuMjAxOCAxNjo1OSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAyOS4xMS4xOCAxMToxNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEhpIGFsbCENCj4+DQo+PiB2
MjogYWRkIGZpeDopDQo+Pg0KPj4gV2UndmUgZmFjZWQgdGhlIGZvbGxvd2luZyBtaXJyb3IgYnVn
Og0KPj4NCj4+IEp1c3QgcnVuIG1pcnJvciBvbiBxY293MiBpbWFnZSBtb3JlIHRoYW4gMUcsIGFu
ZCBxZW11IGlzIGluIGRlYWQgbG9jay4NCj4gDQo+IFNvIGJlY2F1c2UgYXBwYXJlbnRseSB0aGVy
ZSBpcyBnb2luZyB0byBiZSBhbiByYzQgYW55d2F5IChsaWtlIGJhc2ljYWxseQ0KPiBhbHdheXMu
Li4pLCBJJ2QgcmVhbGx5IGxpa2UgdG8gYnJpbmcgdGhpcyBmaXggaW50byBpdCwgdW5sZXNzIHRo
ZXJlIGFyZQ0KPiBhbnkgb2JqZWN0aW9ucyBmcm9tIGFueW9uZSAodGhvdWdoIGFsbCBvZiB5b3Ug
YXJlIG1vcmUgdGhhbiB3ZWxjb21lIHRvDQo+IGV4cGxpY2l0bHkgYWdyZWUsIHRvbyA6LSkpLg0K
PiANCj4gRG8geW91IGhhdmUgYW55IHBsYW5zIGZvciB0aGUgaW90ZXN0PyAgUmlnaHQgbm93LCBJ
J2QgcmF0aGVyIGp1c3QgdGFrZQ0KPiBwYXRjaCAxIGFzLWlzIGFuZCBhZGQgdGhlIHRlc3QgbGF0
ZXIsIGJ1dCB0aGVuIGFnYWluLCBhZGRpbmcgYSBwYXRjaCBmb3INCj4gcmM0IHdpdGhvdXQgYSB0
ZXN0IGlzIG5vdCBzbyBuaWNlIGVpdGhlciwgSSBzdXBwb3NlLg0KPiANCj4gTWF4DQo+IA0KDQpJ
IHRoaW5rLCBldmVyeXRoaW5nIGlzIGJldHRlciB3aXRoIHRlc3Q6KSBJIGNhbid0IHNheSB0aGF0
IEkgcmVhbGx5IGxpa2UgeW91cg0KYWRkaXRpb25zLCBiZWNhdXNlIGl0J3MgYW55d2F5IGEga2lu
ZCBvZiBjaGVhdGluZywgbGVzcyByZWFsLWxpZmUsIGJ1dCBvbiB0aGUNCm90aGVyIGhhbmQsIGFz
IEkgdW5kZXJzdGFuZCwgYWxsb2NhdGluZyBhIGxvdCBvZiBkaXNrIHNwYWNlIGluIGlvdGVzdHMg
aXMgYSBiYWQNCnRoaW5nIHRvby4NCg0KTWF5IGJlIGl0IHNob3VsZCBiZSBhIGtpbmQgb2YgcGFy
YW1ldGVyLCB3aXRoIGRlZmF1bHQgdG8geW91ciB2YXJpYW50LCBzb21ldGhpbmcNCmxpa2UgLi9j
aGVjayAtLWJpZy1kaXNrLWFsbG9jYXRpb25zLWFsbG93ZWQgOikuIEJ1dCBsZXQncyBjb21taXQg
YXQgbGVhc3QgdGhlDQp0ZXN0IHdpdGggeW91ciBhZGRpdGlvbnMuDQoNCi0tIA0KQmVzdCByZWdh
cmRzLA0KVmxhZGltaXINCg==

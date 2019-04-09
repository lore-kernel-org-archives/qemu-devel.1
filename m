Received: from eggs.gnu.org ([209.51.188.92]:50338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDry5-0005yS-He
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDry4-00089i-Cb
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:43:21 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 9 Apr 2019 14:43:12 +0000
Message-ID: <e27a15f8-c299-7a08-3594-680aa1342b2b@virtuozzo.com>
References: <1554747741-918964-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554747741-918964-2-git-send-email-andrey.shinkevich@virtuozzo.com>
	<w517ec345zb.fsf@maestria.local.igalia.com>
In-Reply-To: <w517ec345zb.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A783892F3956984CA2907AF13D325C90@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 1/3] block: include base when checking
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

MDkuMDQuMjAxOSAxNzoxOCwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IE9uIE1vbiAwOCBBcHIg
MjAxOSAwODoyMjoxOSBQTSBDRVNULCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+ICAgICog
UmV0dXJuIHRydWUgaWYgKGEgcHJlZml4IG9mKSB0aGUgZ2l2ZW4gcmFuZ2UgaXMgYWxsb2NhdGVk
IGluIGFueSBpbWFnZQ0KPj4gLSAqIGJldHdlZW4gQkFTRSBhbmQgVE9QIChpbmNsdXNpdmUpLiAg
QkFTRSBjYW4gYmUgTlVMTCB0byBjaGVjayBpZiB0aGUgZ2l2ZW4NCj4+ICsgKiBiZXR3ZWVuIEJB
U0UgYW5kIFRPUCAoVE9QIGluY2x1ZGVkKS4gVG8gY2hlY2sgdGhlIEJBU0UgaW1hZ2UsIHNldCB0
aGUNCj4+ICsgKiAnaW5jbHVkZV9iYXNlJyB0byAndHJ1ZScuIFRoZSBCQVNFIGNhbiBiZSBOVUxM
IHRvIGNoZWNrIGlmIHRoZSBnaXZlbg0KPj4gICAgKiBvZmZzZXQgaXMgYWxsb2NhdGVkIGluIGFu
eSBpbWFnZSBvZiB0aGUgY2hhaW4uICBSZXR1cm4gZmFsc2Ugb3RoZXJ3aXNlLA0KPj4gICAgKiBv
ciBuZWdhdGl2ZSBlcnJubyBvbiBmYWlsdXJlLg0KPiANCj4gSSdtIG5vdCBhIG5hdGl2ZSBzcGVh
a2VyIGJ1dCB0aGF0IHNvdW5kcyBhIGJpdCBvZGQgdG8gbWUuDQo+IA0KPiBBbHRlcm5hdGl2ZToN
Cj4gDQo+ICAgICogUmV0dXJuIHRydWUgaWYgKGEgcHJlZml4IG9mKSB0aGUgZ2l2ZW4gcmFuZ2Ug
aXMgYWxsb2NhdGVkIGluIGFueSBpbWFnZQ0KPiAgICAqIGJldHdlZW4gQkFTRSBhbmQgVE9QIChC
QVNFIGlzIG9ubHkgaW5jbHVkZWQgaWYgaW5jbHVkZV9iYXNlIGlzIHNldCkuDQo+ICAgICogQkFT
RSBjYW4gYmUgTlVMTCB0byBjaGVjayBpZiB0aGUgZ2l2ZW4gb2Zmc2V0IGlzIGFsbG9jYXRlZCBp
biBhbnkNCj4gICAgKiBpbWFnZSBvZiB0aGUgY2hhaW4uICBSZXR1cm4gZmFsc2Ugb3RoZXJ3aXNl
LCBvciBuZWdhdGl2ZSBlcnJubyBvbg0KPiAgICAqIGZhaWx1cmUuDQo+IA0KPj4gLSAgICB3aGls
ZSAoaW50ZXJtZWRpYXRlICYmIGludGVybWVkaWF0ZSAhPSBiYXNlKSB7DQo+PiArICAgIHdoaWxl
IChpbmNsdWRlX2Jhc2UgfHwgaW50ZXJtZWRpYXRlICE9IGJhc2UpIHsNCj4+ICAgICAgICAgICBp
bnQ2NF90IHBudW1faW50ZXI7DQo+PiAgICAgICAgICAgaW50NjRfdCBzaXplX2ludGVyOw0KPj4g
ICANCj4+IEBAIC0yMzYwLDYgKzIzNjQsMTAgQEAgaW50IGJkcnZfaXNfYWxsb2NhdGVkX2Fib3Zl
KEJsb2NrRHJpdmVyU3RhdGUgKnRvcCwNCj4+ICAgICAgICAgICAgICAgbiA9IHBudW1faW50ZXI7
DQo+PiAgICAgICAgICAgfQ0KPj4gICANCj4+ICsgICAgICAgIGlmIChpbnRlcm1lZGlhdGUgPT0g
YmFzZSkgew0KPj4gKyAgICAgICAgICAgIGJyZWFrOw0KPj4gKyAgICAgICAgfQ0KPj4gKw0KPj4g
ICAgICAgICAgIGludGVybWVkaWF0ZSA9IGJhY2tpbmdfYnMoaW50ZXJtZWRpYXRlKTsNCj4gDQo+
IEkgZmluZCB0aGF0IHRoZSBuZXcgY29uZGl0aW9uICsgdGhlIGJyZWFrIG1ha2UgdGhpbmdzIGEg
Yml0IGxlc3MNCj4gcmVhZGFibGUuIEkgdGhpbmsgaXQgd291bGQgYmUgc2ltcGxlciB3aXRoIHNv
bWV0aGluZyBsaWtlIHRoaXM6DQo+IA0KPiAgICAgQmxvY2tEcml2ZXJTdGF0ZSAqc3RvcF9hdCA9
IGluY2x1ZGVfYmFzZSA/IGJhY2tpbmdfYnMoYmFzZSkgOiBiYXNlOw0KPiANCj4gICAgIHdoaWxl
IChpbnRlcm1lZGlhdGUgIT0gc3RvcF9hdCkgew0KPiAgICAgICAgLi4uDQo+ICAgICB9DQo+IA0K
DQpCdXQgaW4gdGhpcyB3YXkgeW91IHJldHVybiBiYWNrIGRlcGVuZGVuY2Ugb24gYmFzZSwgd2hp
Y2ggd2UgZG9uJ3QgZnJlZXplIGFuZCB3aGljaA0KbWF5IGRpc2FwcGVhciBvbiBzb21lIGl0ZXJh
dGlvbi4gV2Ugc2hvdWxkIG5vdCB0b3VjaCBiYWNraW5nX2JzKGJhc2UpIGluIGFueSB3YXkuDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

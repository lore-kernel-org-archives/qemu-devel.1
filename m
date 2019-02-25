Received: from eggs.gnu.org ([209.51.188.92]:41532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gyByl-00005z-Fq
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gyByk-0002Tc-J4
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 03:51:15 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon, 25 Feb 2019 08:51:07 +0000
Message-ID: <562467c9-1459-e118-d973-b00d4f358a89@virtuozzo.com>
References: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<83a234ca-cf14-76b9-0374-6425dab989bd@redhat.com>
In-Reply-To: <83a234ca-cf14-76b9-0374-6425dab989bd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E414261D79FB5C45A5290BFC340B82EF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] iotests: handle TypeError for Python3
 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, "philmd@redhat.com" <philmd@redhat.com>

DQoNCk9uIDIyLzAyLzIwMTkgMTg6MjAsIENsZWJlciBSb3NhIHdyb3RlOg0KPiANCj4gDQo+IE9u
IDIvMjIvMTkgNjoyNiBBTSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+PiBUaGUgZGF0YSB0
eXBlIGZvciBieXRlcyBpbiBQeXRob24zIGRpZmZlcnMgZnJvbSB0aGUgb25lIGluIFB5dGhvbjIu
DQo+PiBUaG9zZSBjYXNlcyBzaG91bGQgYmUgbWFuYWdlZCBzZXBhcmF0ZWx5Lg0KPj4NCj4+IHYx
Og0KPj4gSW4gdGhlIGZpcnN0IHZlcnNpb24sIHRoZSBUeXBlRXJyb3IgaW4gUHl0aG9uMyB3YXMg
aGFuZGxlZCBhcyB0aGUNCj4+IGV4Y2VwdGlvbi4NCj4+IERpc2N1c3NlZCBpbiB0aGUgZS1tYWls
IHRocmVhZCB3aXRoIHRoZSBNZXNzYWdlIElEOg0KPj4gPDE1NTA1MTk5OTctMjUzNTM0LTEtZ2l0
LXNlbmQtZW1haWwtYW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtldmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpv
LmNvbT4NCj4+IFJlcG9ydGVkLWJ5OiBLZXZpbiBXb2xmIDxrd29sZkByZWRoYXQuY29tPg0KPj4g
LS0tDQo+PiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yNDIgfCA4ICsrKysrKy0tDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDIgYi90ZXN0cy9xZW11LWlvdGVzdHMvMjQyDQo+
PiBpbmRleCAxNmM2NWVkLi40NDZmYmY4IDEwMDc1NQ0KPj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rl
c3RzLzI0Mg0KPj4gKysrIGIvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0Mg0KPj4gQEAgLTIwLDYgKzIw
LDcgQEANCj4+ICAgDQo+PiAgIGltcG9ydCBpb3Rlc3RzDQo+PiAgIGltcG9ydCBqc29uDQo+PiAr
aW1wb3J0IHN5cw0KPj4gICBmcm9tIGlvdGVzdHMgaW1wb3J0IHFlbXVfaW1nX2NyZWF0ZSwgcWVt
dV9pbywgcWVtdV9pbWdfcGlwZSwgXA0KPj4gICAgICAgZmlsZV9wYXRoLCBpbWdfaW5mb19sb2cs
IGxvZywgZmlsdGVyX3FlbXVfaW8NCj4+ICAgDQo+PiBAQCAtNjUsOSArNjYsMTIgQEAgZGVmIHRv
Z2dsZV9mbGFnKG9mZnNldCk6DQo+PiAgICAgICB3aXRoIG9wZW4oZGlzaywgInIrYiIpIGFzIGY6
DQo+PiAgICAgICAgICAgZi5zZWVrKG9mZnNldCwgMCkNCj4+ICAgICAgICAgICBjID0gZi5yZWFk
KDEpDQo+PiAtICAgICAgICB0b2dnbGVkID0gY2hyKG9yZChjKSBeIGJpdG1hcF9mbGFnX3Vua25v
d24pDQo+PiArICAgICAgICB0b2dnbGVkID0gb3JkKGMpIF4gYml0bWFwX2ZsYWdfdW5rbm93bg0K
Pj4gICAgICAgICAgIGYuc2VlaygtMSwgMSkNCj4+IC0gICAgICAgIGYud3JpdGUodG9nZ2xlZCkN
Cj4+ICsgICAgICAgIGlmIHN5cy52ZXJzaW9uX2luZm8ubWFqb3IgPj0gMzoNCj4+ICsgICAgICAg
ICAgICBmLndyaXRlKGJ5dGVzKFt0b2dnbGVkXSkpDQo+PiArICAgICAgICBlbHNlOg0KPj4gKyAg
ICAgICAgICAgIGYud3JpdGUoY2hyKHRvZ2dsZWQpKQ0KPj4gICANCj4gDQo+IEkgb3JpZ2luYWxs
eSBzdWdnZXN0ZWQ6DQo+IA0KPiBzeXMudmVyc2lvbl9pbmZvLm1ham9yID09IDI6DQo+ICAgLi4u
DQo+IA0KPiBCZWNhdXNlIHRoaXMgaXMgYWxyZWFkeSBwcmVzZW50IG9uIG90aGVyIHRlc3RzLCBh
bmQgSUlSQyBNYXggbWVudGlvbmVkDQo+IHVzaW5nIHRoaXMgYXMgYW4gZWFzeSB0byBmaW5kIGZs
YWcgdGhlIG1vbWVudCBQeXRob24gMiBzdXBwb3J0IGlzIHRvIGJlDQo+IGRyb3BwZWQuICBCdXQs
IGxvb2tpbmcgZm9yICJzeXMudmVyc2lvbl9pbmZvLm1ham9yIiBpcyBqdXN0IGFzDQo+IGVmZmVj
dGl2ZSwgc286DQo+IA0KPiBSZXZpZXdlZC1ieTogQ2xlYmVyIFJvc2EgPGNyb3NhQHJlZGhhdC5j
b20+DQo+IA0KDQpUaGFuayB5b3UgdmVyeSBtdWNoLCBDbGViZXIuIFlvdXIgcmV2aWV3IGlzIGhl
bHBmdWwuDQoNCj4+ICAgDQo+PiAgIHFlbXVfaW1nX2NyZWF0ZSgnLWYnLCBpb3Rlc3RzLmltZ2Zt
dCwgZGlzaywgJzFNJykNCj4+DQoNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5
IFNoaW5rZXZpY2gNCg==

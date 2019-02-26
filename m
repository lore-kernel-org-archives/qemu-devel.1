Received: from eggs.gnu.org ([209.51.188.92]:51601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gydPW-0005Yu-HE
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gydPV-0000KF-L8
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:08:42 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue, 26 Feb 2019 14:08:36 +0000
Message-ID: <6b9996ca-3a28-2e5b-ba65-f8239770b6fc@virtuozzo.com>
References: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190225202630.GA4925@habkost.net>
	<CAMRbyysWcfctB8AeSZrQ9x9HRAKut7mWYFqVP=oQ5uVoQgvh0w@mail.gmail.com>
	<a8ca5f99-43d0-610b-ea09-28b2655f5cda@virtuozzo.com>
	<d335bcf4-fae8-108d-2e24-9cfba80b5c2c@redhat.com>
In-Reply-To: <d335bcf4-fae8-108d-2e24-9cfba80b5c2c@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE8BEF16166D9644BE66086BF8A137C4@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] iotests: handle TypeError
 for Python3 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, qemu-block <qemu-block@nongnu.org>, "philmd@redhat.com" <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>

DQoNCk9uIDI2LzAyLzIwMTkgMTc6MDYsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDIvMjYvMTkg
NDozOSBBTSwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IA0KPj4+ICAgICAgKysrIGIvdGVz
dHMvcWVtdS1pb3Rlc3RzLzI0Mg0KPj4+ICAgICAgQEAgLTY0LDEwICs2NCwxMiBAQCBkZWYgd3Jp
dGVfdG9fZGlzayhvZmZzZXQsIHNpemUpOg0KPj4+ICAgICAgIMKgZGVmIHRvZ2dsZV9mbGFnKG9m
ZnNldCk6DQo+Pj4gICAgICAgwqAgwqAgwqB3aXRoIG9wZW4oZGlzaywgInIrYiIpIGFzIGY6DQo+
Pj4gICAgICAgwqAgwqAgwqAgwqAgwqBmLnNlZWsob2Zmc2V0LCAwKQ0KPj4+ICAgICAgLcKgIMKg
IMKgIMKgIGMgPSBmLnJlYWQoMSkNCj4+PiAgICAgIC3CoCDCoCDCoCDCoCB0b2dnbGVkID0gY2hy
KG9yZChjKSBeIGJpdG1hcF9mbGFnX3Vua25vd24pDQo+Pj4gICAgICArwqAgwqAgwqAgwqAgIyBU
aGUgY2FzdHMgdG8gYnl0ZWFycmF5KCkgYmVsb3cgYXJlIG9ubHkgbmVjZXNzYXJ5DQo+Pj4gICAg
ICArwqAgwqAgwqAgwqAgIyBmb3IgUHl0aG9uIDIgY29tcGF0aWJpbGl0eQ0KPj4+ICAgICAgK8Kg
IMKgIMKgIMKgIGMgPSBieXRlYXJyYXkoZi5yZWFkKDEpKVswXQ0KPj4+DQo+Pj4NCj4+PiBUaGlz
IGlzIHNpbXBsZXIgYW5kIG1ha2VzIHRoZSBpbnRlbnQgb2YgdGhlIGNvZGUgbW9yZSBjbGVhcjoN
Cj4+Pg0KPj4+ICAgwqAgwqAgZmxhZywgPSBzdHJ1Y3QudW5wYWNrKCJCIiwgZi5yZWFkKDEpKQ0K
Pj4+DQo+Pj4gICAgICArwqAgwqAgwqAgwqAgdG9nZ2xlZCA9IGMgXiBiaXRtYXBfZmxhZ191bmtu
b3duDQo+Pj4gICAgICAgwqAgwqAgwqAgwqAgwqBmLnNlZWsoLTEsIDEpDQo+Pj4gICAgICAtwqAg
wqAgwqAgwqAgZi53cml0ZSh0b2dnbGVkKQ0KPj4+ICAgICAgK8KgIMKgIMKgIMKgIGYud3JpdGUo
Ynl0ZWFycmF5KFt0b2dnbGVkXSkpDQo+Pj4NCj4+Pg0KPj4+IEZvciBjb25zaXN0ZW5jeSwgd2Ug
Y2FuIHVzZSBzdHJ1Y3QucGFjayBoZXJlOg0KPj4+DQo+Pj4gICDCoCDCoCBmLndyaXRlKHN0cnVj
dC5wYWNrKCJCIiwgdG9nZ2xlZCkpDQo+Pj4NCj4+PiBOaXINCj4+Pg0KPj4NCj4+IFRoYW5rIHlv
dSBhbGwuIEkgYW0gT0sgd2l0aCB0aGlzIGFwcHJvYWNoLg0KPj4gV2lsbCB3YWl0IGZvciBFcmlj
J3MgcmVzcG9uc2UuDQo+IA0KPiBUaGF0IGxvb2tzIGJldHRlci4gUGV0ZXIgaGFzbid0IGFwcGxp
ZWQgbXkgcHVsbCByZXF1ZXN0IHlldCwgc28geW91IGhhdmUNCj4gdGltZSB0byBzdWJtaXQgYSBm
b3JtYWwgdjMgKG1ha2luZyBpdCBlYXNpZXIgZm9yIG1lIHRvICdnaXQgYW0nIGl0DQo+IHJhdGhl
ciB0aGFuIHJlY29uc3RydWN0IGZyb20gdGhpcyBlbWFpbCksIGFuZCB0aGVuIEkgd2lsbCB1cGRh
dGUgbXkgcHVsbA0KPiByZXF1ZXN0IHRvIHVzZSB0aGlzIGltcHJvdmVkIHZlcnNpb24uDQo+IA0K
Tm90ZWQNCg0KLS0gDQpXaXRoIHRoZSBiZXN0IHJlZ2FyZHMsDQpBbmRyZXkgU2hpbmtldmljaA0K
DQo=

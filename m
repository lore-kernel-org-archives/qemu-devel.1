Received: from eggs.gnu.org ([209.51.188.92]:38419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gx7RF-0004vs-Rc
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:48:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1gx7RE-00026o-NJ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:48:13 -0500
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Fri, 22 Feb 2019 09:48:03 +0000
Message-ID: <a05ae653-88bb-cf37-e73c-3ca6595e05b5@virtuozzo.com>
References: <1550519997-253534-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<2cbb158f-a869-e24c-96cc-23f7f61a946b@redhat.com>
	<4f992059-b448-a234-d319-3eb3bb5e04c9@redhat.com>
	<dbd04ea0-6a60-9817-52b3-a0cc73f1a637@redhat.com>
In-Reply-To: <dbd04ea0-6a60-9817-52b3-a0cc73f1a637@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <091F0B2AA87644409054B3D6AC5AA638@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] iotests: handle TypeError for Python3 in
 test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>

DQoNCk9uIDIyLzAyLzIwMTkgMDM6MTcsIENsZWJlciBSb3NhIHdyb3RlOg0KPiANCj4gDQo+IE9u
IDIvMTgvMTkgNDoyNSBQTSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+PiBPbiAy
LzE4LzE5IDk6MDUgUE0sIEVyaWMgQmxha2Ugd3JvdGU6DQo+Pj4gW2FkZGluZyBFZHVhcmRvIGZv
ciBzb21lIHB5dGhvbiAyLXZzLTMgYWR2aWNlXQ0KPj4NCj4+IEFuZCBDbGViZXIuDQo+Pg0KPj4+
DQo+Pj4gT24gMi8xOC8xOSAxOjU5IFBNLCBBbmRyZXkgU2hpbmtldmljaCB3cm90ZToNCj4+Pj4g
VG8gd3JpdGUgb25lIGJ5dGUgdG8gZGlzaywgUHl0aG9uMiBtYXkgdXNlICdjaHInIHR5cGUuDQo+
Pj4+IEluIFB5dGhvbjMsIGNvbnZlcnNpb24gdG8gJ2J5dGUnIHR5cGUgaXMgcmVxdWlyZWQuDQo+
Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBTaGlua2V2aWNoIDxhbmRyZXkuc2hpbmtl
dmljaEB2aXJ0dW96em8uY29tPg0KPj4+PiAtLS0NCj4+Pj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
MjQyIHwgOSArKysrKysrLS0NCj4+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvdGVzdHMvcWVtdS1pb3Rl
c3RzLzI0MiBiL3Rlc3RzL3FlbXUtaW90ZXN0cy8yNDINCj4+Pj4gaW5kZXggMTZjNjVlZC4uNmIx
ZjdiOCAxMDA3NTUNCj4+Pj4gLS0tIGEvdGVzdHMvcWVtdS1pb3Rlc3RzLzI0Mg0KPj4+PiArKysg
Yi90ZXN0cy9xZW11LWlvdGVzdHMvMjQyDQo+Pj4+IEBAIC02NSw5ICs2NSwxNCBAQCBkZWYgdG9n
Z2xlX2ZsYWcob2Zmc2V0KToNCj4+Pj4gICAgICAgd2l0aCBvcGVuKGRpc2ssICJyK2IiKSBhcyBm
Og0KPj4+PiAgICAgICAgICAgZi5zZWVrKG9mZnNldCwgMCkNCj4+Pj4gICAgICAgICAgIGMgPSBm
LnJlYWQoMSkNCj4+Pj4gLSAgICAgICAgdG9nZ2xlZCA9IGNocihvcmQoYykgXiBiaXRtYXBfZmxh
Z191bmtub3duKQ0KPj4+PiArICAgICAgICB0b2dnbGVkID0gb3JkKGMpIF4gYml0bWFwX2ZsYWdf
dW5rbm93bg0KPj4+PiAgICAgICAgICAgZi5zZWVrKC0xLCAxKQ0KPj4+PiAtICAgICAgICBmLndy
aXRlKHRvZ2dsZWQpDQo+Pj4+ICsgICAgICAgIHRyeToNCj4+Pj4gKyAgICAgICAgICAgICMgcHl0
aG9uMg0KPj4+PiArICAgICAgICAgICAgZi53cml0ZShjaHIodG9nZ2xlZCkpDQo+Pj4+ICsgICAg
ICAgIGV4Y2VwdCBUeXBlRXJyb3I6DQo+Pj4+ICsgICAgICAgICAgICAjIHB5dGhvbjMNCj4+Pj4g
KyAgICAgICAgICAgIGYud3JpdGUoYnl0ZXMoW3RvZ2dsZWRdKSkNCj4+Pg0KPj4+IExvb2tzIGxp
a2UgaXQgd29ya3MsIGJ1dCBJJ20gbm90IGVub3VnaCBvZiBhIHB5dGhvbiBleHBlcnQgdG8ga25v
dyBpZg0KPj4+IHRoZXJlIGlzIGEgbW9yZSBQeXRob25pYyBlbGVnYW50IGFwcHJvYWNoLg0KPj4+
DQo+IA0KPiBXZWxsLCB0aGVyZSdzIG5vIHdheSBhcm91bmQgdGhlIGZhY3QgdGhhdCBieXRlcyBp
biBQeXRob24gMyBhcmUgdmVyeQ0KPiBkaWZmZXJlbnQgZnJvbSBieXRlcyBpbiBQeXRob24gMiAo
anVzdCBhbm90aGVyIG5hbWUgZm9yIGEgc3RyaW5nKS4NCj4gDQo+IFdoYXQgSSdkIHJlY29tbWVu
ZCBoZXJlIGlzIHRvIG5vdCBiYXNlIHRoZSB0eXBlIG9uIHRoZSBleGNlcHRpb24sIGJ1dA0KPiBj
aG9vc2UgaXQgZGVwZW5kaW5nIG9uIHRoZSBQeXRob24gdmVyc2lvbi4gIFNvbWV0aGluZyBsaWtl
Og0KPiANCj4gaWYgc3lzLnZlcnNpb25faW5mby5tYWpvciA9PSAyOg0KPiAgICAgZi53cml0ZShj
aHIodG9nZ2xlZCkpDQo+IGVsc2U6DQo+ICAgICBmLndyaXRlKGJ5dGVzKFt0b2dnbGVkXSldDQo+
IA0KPiBUaGlzIGlzIGNoZWFwZXIgdGhhbiByYWlzaW5nL2NhdGNoaW5nIGV4Y2VwdGlvbnMsIGl0
J3Mgc2VsZiBkb2N1bWVudGluZywNCj4gYW5kIGZvbGxvd3MgdGhlIHBhdHRlcm4gb24gb3RoZXIg
dGVzdHMuDQo+IA0KPiBSZWdhcmRzLA0KPiAtIENsZWJlci4NCj4gDQoNClRoYW5rIHlvdSB2ZXJ5
IG11Y2gsIENsZWJlci4NCkkgd291bGQgbGlrZSB0byB3cml0ZSBpdCBkb3duIGFzIHRoYXQgaXMg
aW4gaW90ZXN0cy5weSA6DQppZiBzeXMudmVyc2lvbl9pbmZvLm1ham9yID49IDM6DQogICAgIC4u
Lg0KDQo+Pj4gSWYgc29tZW9uZSBlbHNlIHBpY2tzIGl0IHVwIGJlZm9yZSBteSBuZXh0IE5CRCBw
dWxsIHJlcXVlc3QsDQo+Pj4gQWNrZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29t
Pg0KPj4+DQoNCi0tIA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gN
Cg0K

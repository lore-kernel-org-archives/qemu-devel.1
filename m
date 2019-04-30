Received: from eggs.gnu.org ([209.51.188.92]:45549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLOHG-0003yK-LK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLOHF-0000vU-OF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 04:38:14 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 Apr 2019 08:38:04 +0000
Message-ID: <66de1a9a-e9fd-b853-377d-f5acfe51737a@virtuozzo.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-8-vsementsov@virtuozzo.com>
	<44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
In-Reply-To: <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F28A108FD181584DA125271FBD57BF2B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "berto@igalia.com" <berto@igalia.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berrange@redhat.com" <berrange@redhat.com>

MjkuMDQuMjAxOSAxOTozNywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwMi4wNC4xOSAxNzozNywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IEJhY2tncm91bmQ6IGRlY3J5
cHRpb24gd2lsbCBiZSBkb25lIGluIHRocmVhZHMsIHRvIHRha2UgYmVuZWZpdCBvZiBpdCwNCj4+
IHdlIHNob3VsZCBtb3ZlIGl0IG91dCBvZiB0aGUgbG9jayBmaXJzdC4NCj4gDQo+IC4uLndoaWNo
IGlzIHNhZmUgYWZ0ZXIgeW91ciBjb21taXQgYzk3MmZhMTIzYzczNTAxYjQsIEkgcHJlc3VtZS4N
Cj4gDQo+IChBdCBmaXJzdCBnbGFuY2UsIHRoZSBwYXRjaGVkIGxvb2tlZCBhIGJpdCB3ZWlyZCB0
byBtZSBiZWNhdXNlIGl0DQo+IGRvZXNuJ3QgZ2l2ZSBhIHJlYXNvbiB3aHkgZHJvcHBpbmcgdGhl
IGxvY2sgYXJvdW5kDQo+IHFjcnlwdG9fYmxvY2tfZGVjcnlwdCgpIHdvdWxkIGJlIE9LLikNCj4g
DQo+PiBCdXQgbGV0J3MgZ28gZnVydGhlcjogaXQgdHVybnMgb3V0LCB0aGF0IGZvciBsb2NraW5n
IGFyb3VuZCBzd2l0Y2gNCj4+IGNhc2VzIHdlIGhhdmUgb25seSB0d28gdmFyaWFudHM6IHdoZW4g
d2UganVzdCBkbyBtZW1zZXQoMCkgbm90DQo+PiByZWxlYXNpbmcgdGhlIGxvY2sgKGl0IGlzIHVz
ZWxlc3MpIGFuZCB3aGVuIHdlIGFjdHVhbGx5IGNhbiBoYW5kbGUgdGhlDQo+PiB3aG9sZSBjYXNl
IG91dCBvZiB0aGUgbG9jay4gU28sIHJlZmFjdG9yIHRoZSB3aG9sZSB0aGluZyB0byByZWR1Y2UN
Cj4+IGxvY2tlZCBjb2RlIHJlZ2lvbiBhbmQgbWFrZSBpdCBjbGVhbi4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1b3p6
by5jb20+DQo+PiBSZXZpZXdlZC1ieTogQWxiZXJ0byBHYXJjaWEgPGJlcnRvQGlnYWxpYS5jb20+
DQo+PiAtLS0NCj4+ICAgYmxvY2svcWNvdzIuYyB8IDQ2ICsrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlv
bnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ibG9jay9xY293Mi5j
IGIvYmxvY2svcWNvdzIuYw0KPj4gaW5kZXggNDZlOGUzOWRhNS4uZmNmOTJhN2ViNiAxMDA2NDQN
Cj4+IC0tLSBhL2Jsb2NrL3Fjb3cyLmMNCj4+ICsrKyBiL2Jsb2NrL3Fjb3cyLmMNCj4+IEBAIC0x
OTgzLDYgKzE5ODMsNyBAQCBzdGF0aWMgY29yb3V0aW5lX2ZuIGludCBxY293Ml9jb19wcmVhZHYo
QmxvY2tEcml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IG9mZnNldCwNCj4+ICAgDQo+PiAgICAgICAg
ICAgcmV0ID0gcWNvdzJfZ2V0X2NsdXN0ZXJfb2Zmc2V0KGJzLCBvZmZzZXQsICZjdXJfYnl0ZXMs
ICZjbHVzdGVyX29mZnNldCk7DQo+IA0KPiBJc24ndCB0aGlzIHRoZSBvbmx5IGZ1bmN0aW9uIGlu
IHRoZSBsb29wIHRoYXQgYWN0dWFsbHkgbmVlZHMgdGhlIGxvY2s/DQo+IFdvdWxkbid0IGl0IG1h
a2UgbW9yZSBzZW5zZSB0byBqdXN0IHRha2UgaXQgYXJvdW5kIHRoaXMgY2FsbD8NCj4gDQoNCkht
bSwgbG9va3MgY29ycmVjdCwgSSdsbCByZXNlbmQuDQoNCg0KDQotLSANCkJlc3QgcmVnYXJkcywN
ClZsYWRpbWlyDQo=

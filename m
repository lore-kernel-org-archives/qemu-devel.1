Received: from eggs.gnu.org ([2001:4830:134:3::10]:37040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gK37f-000109-Nt
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gK37R-0002OD-Sf
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:18:25 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 6 Nov 2018 15:18:08 +0000
Message-ID: <e4d6f89f-5d27-7456-1f4c-adf8ec377faf@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
	<20181101182738.70462-6-vsementsov@virtuozzo.com>
	<w51a7mme2im.fsf@maestria.local.igalia.com>
In-Reply-To: <w51a7mme2im.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <61B374E08B82DE40BE656E3214E63E8C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 5/7] qcow2: use byte-based
 read in qcow2_decompress_cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>

MDYuMTEuMjAxOCAxNjo1MywgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IE9uIFRodSAwMSBOb3Yg
MjAxOCAwNzoyNzozNiBQTSBDRVQsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6
DQo+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svcWNvdzIuYyBiL2Jsb2NrL3Fjb3cyLmMNCj4+IGlu
ZGV4IGU5ZDI0YjgwMWUuLjk1MGI5ZjdlYzYgMTAwNjQ0DQo+PiAtLS0gYS9ibG9jay9xY293Mi5j
DQo+PiArKysgYi9ibG9jay9xY293Mi5jDQo+PiBAQCAtMzk1NiwxNCArMzk1NiwxNSBAQCBmYWls
Og0KPj4gICBpbnQgcWNvdzJfZGVjb21wcmVzc19jbHVzdGVyKEJsb2NrRHJpdmVyU3RhdGUgKmJz
LCB1aW50NjRfdCBjbHVzdGVyX29mZnNldCkNCj4+ICAgew0KPj4gICAgICAgQkRSVlFjb3cyU3Rh
dGUgKnMgPSBicy0+b3BhcXVlOw0KPj4gLSAgICBpbnQgcmV0LCBjc2l6ZSwgbmJfY3NlY3RvcnMs
IHNlY3Rvcl9vZmZzZXQ7DQo+PiArICAgIGludCByZXQsIGNzaXplLCBuYl9jc2VjdG9yczsNCj4+
ICAgICAgIHVpbnQ2NF90IGNvZmZzZXQ7DQo+PiArICAgIHN0cnVjdCBpb3ZlYyBpb3Y7DQo+PiAr
ICAgIFFFTVVJT1ZlY3RvciBsb2NhbF9xaW92Ow0KPj4gICANCj4+ICAgICAgIGNvZmZzZXQgPSBj
bHVzdGVyX29mZnNldCAmIHMtPmNsdXN0ZXJfb2Zmc2V0X21hc2s7DQo+PiAgICAgICBpZiAocy0+
Y2x1c3Rlcl9jYWNoZV9vZmZzZXQgIT0gY29mZnNldCkgew0KPj4gICAgICAgICAgIG5iX2NzZWN0
b3JzID0gKChjbHVzdGVyX29mZnNldCA+PiBzLT5jc2l6ZV9zaGlmdCkgJiBzLT5jc2l6ZV9tYXNr
KSArIDE7DQo+PiAtICAgICAgICBzZWN0b3Jfb2Zmc2V0ID0gY29mZnNldCAmIDUxMTsNCj4+IC0g
ICAgICAgIGNzaXplID0gbmJfY3NlY3RvcnMgKiA1MTIgLSBzZWN0b3Jfb2Zmc2V0Ow0KPj4gKyAg
ICAgICAgY3NpemUgPSBuYl9jc2VjdG9ycyAqIDUxMiAtIChjb2Zmc2V0ICYgNTExKTsNCj4+ICAg
DQo+PiAgICAgICAgICAgLyogQWxsb2NhdGUgYnVmZmVycyBvbiBmaXJzdCBkZWNvbXByZXNzIG9w
ZXJhdGlvbiwgbW9zdCBpbWFnZXMgYXJlDQo+PiAgICAgICAgICAgICogdW5jb21wcmVzc2VkIGFu
ZCB0aGUgbWVtb3J5IG92ZXJoZWFkIGNhbiBiZSBhdm9pZGVkLiAgVGhlIGJ1ZmZlcnMNCj4+IEBA
IC0zOTgxLDE0ICszOTgyLDE3IEBAIGludCBxY293Ml9kZWNvbXByZXNzX2NsdXN0ZXIoQmxvY2tE
cml2ZXJTdGF0ZSAqYnMsIHVpbnQ2NF90IGNsdXN0ZXJfb2Zmc2V0KQ0KPj4gICAgICAgICAgICAg
ICBzLT5jbHVzdGVyX2NhY2hlID0gZ19tYWxsb2Mocy0+Y2x1c3Rlcl9zaXplKTsNCj4+ICAgICAg
ICAgICB9DQo+PiAgIA0KPj4gKyAgICAgICAgaW92Lmlvdl9iYXNlID0gcy0+Y2x1c3Rlcl9kYXRh
Ow0KPj4gKyAgICAgICAgaW92Lmlvdl9sZW4gPSBjc2l6ZTsNCj4+ICsgICAgICAgIHFlbXVfaW92
ZWNfaW5pdF9leHRlcm5hbCgmbG9jYWxfcWlvdiwgJmlvdiwgMSk7DQo+PiArDQo+PiAgICAgICAg
ICAgQkxLREJHX0VWRU5UKGJzLT5maWxlLCBCTEtEQkdfUkVBRF9DT01QUkVTU0VEKTsNCj4+IC0g
ICAgICAgIHJldCA9IGJkcnZfcmVhZChicy0+ZmlsZSwgY29mZnNldCA+PiA5LCBzLT5jbHVzdGVy
X2RhdGEsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgbmJfY3NlY3RvcnMpOw0KPj4gKyAg
ICAgICAgcmV0ID0gYmRydl9jb19wcmVhZHYoYnMtPmZpbGUsIGNvZmZzZXQsIGNzaXplLCAmbG9j
YWxfcWlvdiwNCj4+IDApOw0KPiBJIHRoaW5rIHlvdSBzaG91bGQgYW5ub3RhdGUgdGhlIGZ1bmN0
aW9uIHdpdGggY29yb3V0aW5lX2ZuIG9yIHVzZQ0KPiBiZHJ2X3ByZWFkKCkgaW5zdGVhZC4NCj4N
Cj4gQmVydG8NCg0KaXQgaXMgY2FsbGVkIG9ubHkgZnJvbSBxY293Ml9jb19wcmVhZHYsIHNvIGl0
J3Mgb2sgdG8gbW92ZSB0byANCmFscmVhZHktaW4tY29yb3V0aW5lIGJlaGF2aW91ci4gSSdsbCBh
ZGQgY29yb3V0aW5lX2ZuIGlmIG5ldyB2ZXJzaW9uIGlzIA0KbmVlZGVkLCBvciBpdCBjYW4gYmUg
YWRkZWQgaW5mbGlnaHQuDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg0K

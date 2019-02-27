Received: from eggs.gnu.org ([209.51.188.92]:50991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyw8I-0008Rc-I3
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyw8F-0004Fw-9A
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:08:10 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 27 Feb 2019 10:07:53 +0000
Message-ID: <1d6c9336-d3d2-783f-6db4-4c3d000dc727@virtuozzo.com>
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
	<e2f687c3-ad05-8921-0528-8f28357542a6@virtuozzo.com>
In-Reply-To: <e2f687c3-ad05-8921-0528-8f28357542a6@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <B36756210FAF9946BFA713CE777D1B54@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 0/5] qcow2 check improvements part I
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

cGluZw0KDQoxMC4wMS4yMDE5IDE4OjI4LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBwaW5nDQo+IA0KPiAxNC4xMi4yMDE4IDE2OjQyLCBWbGFkaW1pciBTZW1lbnRzb3Yt
T2dpZXZza2l5IHdyb3RlOg0KPj4gSGkgYWxsIQ0KPj4NCj4+IFRoZXNlIHNlcmllcyBhcmUgZGVy
aXZlZCBmcm9tICJbUEFUQ0ggdjMgMC84XSBxY293MiBjaGVjayBpbXByb3ZlbWVudHMiDQo+PiAo
aHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTgtMTAvbXNn
MDIyODQuaHRtbCkNCj4+DQo+PiBTb21lIHBhdGNoZXMgYXJlIG5ldywgc29tZSBwYXRjaGVzIGFy
ZSBub3QgaW5jbHVkZWQgYW5kIGFyZSBwb3N0cG9uZWQgdG8NCj4+IHBhcnQgSUkuDQo+Pg0KPj4g
U28sIGhlcmU6DQo+PiAwMSwwMyAtIHVuY2hhbmdlZA0KPj4gMDI6IGhhbmRsZSBicm9rZW4gaW90
ZXN0DQo+PiAwNC0wNTogbmV3DQo+Pg0KPj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAo
NSk6DQo+PiDCoMKgIHFjb3cyLXJlZmNvdW50OiBmaXggY2hlY2tfb2ZsYWdfY29waWVkDQo+PiDC
oMKgIHFjb3cyLXJlZmNvdW50OiBhdm9pZCBlYXRpbmcgUkFNDQo+PiDCoMKgIHFjb3cyLXJlZmNv
dW50OiBjaGVja19yZWZjb3VudHNfbDI6IHJlZHVjZSBpZ25vcmVkIG92ZXJsYXBzDQo+PiDCoMKg
IHFjb3cyLXJlZmNvdW50OiBjaGVja19yZWZjb3VudHNfbDI6IGRvbid0IGNvdW50IGZpeGVkIGNs
dXN0ZXIgYXMNCj4+IMKgwqDCoMKgIGFsbG9jYXRlZA0KPj4gwqDCoCBxY293Mi1yZWZjb3VudDog
ZG9uJ3QgbWFzayBjb3JydXB0aW9ucyB1bmRlciBpbnRlcm5hbCBlcnJvcnMNCj4+DQo+PiDCoCBi
bG9jay9xY293Mi1yZWZjb3VudC5jwqDCoMKgwqAgfCA4NyArKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLQ0KPj4gwqAgdGVzdHMvcWVtdS1pb3Rlc3RzLzEzOMKgwqDCoMKgIHwg
MTIgKysrLS0tDQo+PiDCoCB0ZXN0cy9xZW11LWlvdGVzdHMvMTM4Lm91dCB8wqAgNSArKy0NCj4+
IMKgIDMgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKSwgNDMgZGVsZXRpb25zKC0pDQo+
Pg0KPiANCj4gDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

Received: from eggs.gnu.org ([209.51.188.92]:55010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIVj6-0007eq-9W
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 05:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIVj4-0005UG-JZ
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 05:59:04 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 09:58:38 +0000
Message-ID: <2bd2faa2-adeb-924f-656b-bdce6cd5d164@virtuozzo.com>
References: <20190408162617.258535-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190408162617.258535-1-vsementsov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <69B6ADC87773E041AD5EEFF7135F136D@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 for 4.1 0/2] avoid lseek on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>

cGluZw0KDQowOC4wNC4yMDE5IDE5OjI2LCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdy
b3RlOg0KPiBIaSENCj4gDQo+IEl0J3MgYSBjb250aW51YXRpb24gZm9yDQo+ICJbUEFUQ0hdIHFj
b3cyOiBhdm9pZCBsc2VlayBvbiBibG9ja19zdGF0dXMgaWYgcG9zc2libGUiDQo+IGh0dHBzOi8v
bGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE5LTAxL21zZzA2NTk4Lmh0
bWwNCj4gDQo+IHBlcmZvcm1hbmNlIHJlc3VsdHMgZm9yIGJsb2NrLXN0YXR1cyBvbiB0bXBmcyBb
dGVzdHMgb3JpZ2luYWxseSBieSBLZXZpbiwNCj4gbm93IHRoZXkgYXJlIGluIDAxXToNCj4gDQo+
IC4vdGVzdHMvcGVyZi9ibG9jay9xY293Mi9jb252ZXJ0LWJsb2Nrc3RhdHVzIC9yYW1kaXNrL3gN
Cj4gDQo+IGFmdGVyIDAxOg0KPiANCj4gcGxhaW46IDgxLjc3DQo+IGZvcndhcmQ6IDgyLjYxDQo+
IHByZWFsbG9jOiAwLjAxDQo+IA0KPiBhZnRlciAwMjoNCj4gDQo+IHBsYWluOiAwLjEyDQo+IGZv
cndhcmQ6IDAuMTINCj4gcHJlYWxsb2M6IDAuMDENCj4gDQo+IHYyOg0KPiAgIDAxOiBuZXcNCj4g
ICAwMjogW21vc3RseSBieSBLZXZpbidzIGNvbW1lbnRzXQ0KPiAgICAgICAtIHJld3JpdHRlbiB0
byBnbyB0aHJvdWdoIG5ldyBmbGFnIEJEUlZfQkxPQ0tfUkVDVVJTRQ0KPiAgICAgICAtIG5ldmVy
IHJldHJ5IGRldGVjdGlvbiBpZiBmYWlsZWQgZm9yIGZpcnN0IHRpbWUNCj4gICAgICAgLSByZXdy
aXRlIGRldGVjdGlvbiB0byBkbyBsZXNzIGl0ZXJhdGlvbnMgYW5kIHRvIGJlIG1vcmUgc2ltcGxl
DQo+IA0KPiAgICAgICBpb3Rlc3RzIDEwMiBiZWhhdmlvciBjaGFuZ2VkIFthbmQgbm90IHN1cmUg
YWJvdXQgb3RoZXIgdHdvIG9uZXMNCj4gICAgICAgaW4gY29tcGFyaXNvbiB3aXRoIHYxLCBidXQg
aXQgc2VlbXMgaXQgZG9lc24ndCBtYXR0ZXJdDQo+IA0KPiAgICAgICBhbHNvLCBwYXRjaCBzdWJq
ZWN0IGNoYW5nZWQsIGFzIG5vdyBpdCdzIGEgZ2VuZXJpYyBjaGFuZ2UgZm9yDQo+ICAgICAgIGJs
b2NrIGxheWVyDQo+IA0KPiANCj4gVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSAoMik6DQo+
ICAgIHRlc3RzL3BlcmY6IFRlc3QgbHNlZWsgaW5mbHVlbmNlIG9uIHFjb3cyIGJsb2NrLXN0YXR1
cw0KPiAgICBibG9jazogYXZvaWQgcmVjdXJzaXZlIGJsb2NrX3N0YXR1cyBjYWxsIGlmIHBvc3Np
YmxlDQo+IA0KPiAgIGJsb2NrL3Fjb3cyLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICA0ICsrDQo+ICAgaW5jbHVkZS9ibG9jay9ibG9jay5oICAgICAgICAgICAgICAgICAgICAgIHwg
IDggKystDQo+ICAgYmxvY2svaW8uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDkgKystDQo+ICAgYmxvY2svcWNvdzItcmVmY291bnQuYyAgICAgICAgICAgICAgICAgICAgIHwg
MzIgKysrKysrKysrKw0KPiAgIGJsb2NrL3Fjb3cyLmMgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8IDExICsrKysNCj4gICB0ZXN0cy9wZXJmL2Jsb2NrL3Fjb3cyL2NvbnZlcnQtYmxvY2tz
dGF0dXMgfCA3MSArKysrKysrKysrKysrKysrKysrKysrDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3Rz
LzEwMiAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICB0ZXN0cy9xZW11LWlvdGVzdHMv
MTAyLm91dCAgICAgICAgICAgICAgICAgfCAgMyArLQ0KPiAgIHRlc3RzL3FlbXUtaW90ZXN0cy8x
NDEub3V0ICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICAgdGVzdHMvcWVtdS1pb3Rlc3RzLzE0
NC5vdXQgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICAxMCBmaWxlcyBjaGFuZ2VkLCAxMzgg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA3NTUgdGVz
dHMvcGVyZi9ibG9jay9xY293Mi9jb252ZXJ0LWJsb2Nrc3RhdHVzDQo+IA0KDQoNCi0tIA0KQmVz
dCByZWdhcmRzLA0KVmxhZGltaXINCg==

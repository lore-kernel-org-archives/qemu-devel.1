Received: from eggs.gnu.org ([209.51.188.92]:58258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLPLq-0001OM-Tc
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hLPLo-0007Tz-PU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:47:02 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 Apr 2019 09:46:51 +0000
Message-ID: <808ccd2e-56ae-f1c9-3361-efd416ad2465@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
	<20190430093828.gu3b7yjyh447qw6j@steredhat>
In-Reply-To: <20190430093828.gu3b7yjyh447qw6j@steredhat>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CD7D38E64157D46868DFDADBCF63A2A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/9] block: buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, Denis Lunev <den@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>

MzAuMDQuMjAxOSAxMjozOCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOg0KPiBPbiBNb24sIEFw
ciAyMiwgMjAxOSBhdCAwNTo1ODoyOVBNICswMzAwLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZz
a2l5IHdyb3RlOg0KPj4gSGkgYWxsIQ0KPj4NCj4+IFdlIG9mdGVuIG5lZWQgdG8gZG8gcmVhZC93
cml0ZSB3aXRoIGJ1ZmZlciwgbm90IHFpb3YuIEluc3RlYWQgb2YNCj4+IGNyZWF0aW5nIHFpb3Yg
aW4gc3VjaCBjYXNlcywgbGV0J3MgaW50cm9kdWNlIGNvcnJlc3BvbmRpbmcgaGVscGVycy4NCj4+
DQo+PiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5ICg5KToNCj4+ICAgIGJsb2NrOiBpbnRy
b2R1Y2UgYnl0ZS1iYXNlZCBpbyBoZWxwZXJzDQo+PiAgICBibG9jay9xY293MjogdXNlIGJ1ZmZl
ci1iYXNlZCBpbw0KPj4gICAgYmxvY2svcWNvdzogdXNlIGJ1ZmZlci1iYXNlZCBpbw0KPj4gICAg
YmxvY2svcWVkOiB1c2UgYnVmZmVyLWJhc2VkIGlvDQo+PiAgICBibG9jay9wYXJhbGxlbHM6IHVz
ZSBidWZmZXItYmFzZWQgaW8NCj4+ICAgIGJsb2NrL2JhY2t1cDogdXNlIGJ1ZmZlci1iYXNlZCBp
bw0KPj4gICAgYmxvY2svY29tbWl0OiB1c2UgYnVmZmVyLWJhc2VkIGlvDQo+PiAgICBibG9jay9z
dHJlYW06IHVzZSBidWZmZXItYmFzZWQgaW8NCj4+ICAgIHFlbXUtaW1nOiB1c2UgYnVmZmVyLWJh
c2VkIGlvDQo+Pg0KPj4gICBpbmNsdWRlL2Jsb2NrL2Jsb2NrX2ludC5oICAgICAgfCAxNiArKysr
KysrKysrKysrKysrDQo+PiAgIGluY2x1ZGUvc3lzZW11L2Jsb2NrLWJhY2tlbmQuaCB8IDE5ICsr
KysrKysrKysrKysrKysrKysNCj4+ICAgYmxvY2svYmFja3VwLmMgICAgICAgICAgICAgICAgIHwg
MTQgKysrKysrLS0tLS0tLS0NCj4+ICAgYmxvY2svY29tbWl0LmMgICAgICAgICAgICAgICAgIHwg
IDUgKystLS0NCj4+ICAgYmxvY2svcGFyYWxsZWxzLmMgICAgICAgICAgICAgIHwgMTQgKysrKysr
LS0tLS0tLS0NCj4+ICAgYmxvY2svcWNvdy5jICAgICAgICAgICAgICAgICAgIHwgMTkgKysrKysr
LS0tLS0tLS0tLS0tLQ0KPj4gICBibG9jay9xY293Mi5jICAgICAgICAgICAgICAgICAgfCAgOSAr
Ky0tLS0tLS0NCj4+ICAgYmxvY2svcWVkLXRhYmxlLmMgICAgICAgICAgICAgIHwgMTIgKysrKyst
LS0tLS0tDQo+PiAgIGJsb2NrL3FlZC5jICAgICAgICAgICAgICAgICAgICB8ICA2ICsrLS0tLQ0K
Pj4gICBibG9jay9zdHJlYW0uYyAgICAgICAgICAgICAgICAgfCAgNCArLS0tDQo+PiAgIHFlbXUt
aW1nLmMgICAgICAgICAgICAgICAgICAgICB8IDEzICsrKystLS0tLS0tLS0NCj4+ICAgMTEgZmls
ZXMgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKSwgNjIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gLS0g
DQo+PiAyLjE4LjANCj4+DQo+IA0KPiBUaGUgc2VyaWVzIExHVE0gYW5kIG5ldyBoZWxwZXJzIGNv
dWxkIGJlIHZlcnkgdXNlZnVsIQ0KPiANCj4gUmV2aWV3ZWQtYnk6IFN0ZWZhbm8gR2FyemFyZWxs
YSA8c2dhcnphcmVAcmVkaGF0LmNvbT4NCj4gDQoNClRoYW5rcyENCg0KDQotLSANCkJlc3QgcmVn
YXJkcywNClZsYWRpbWlyDQo=

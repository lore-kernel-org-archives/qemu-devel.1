Received: from eggs.gnu.org ([209.51.188.92]:58914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmgpf-0003lE-M1
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmgpb-000077-Up
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:22:17 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 24 Jan 2019 15:22:05 +0000
Message-ID: <093415a1-c31c-c727-583f-bf3176621336@virtuozzo.com>
References: <20190124141731.21509-1-kwolf@redhat.com>
	<f3b34487-5c86-287e-00b5-331adf9ac931@virtuozzo.com>
	<20190124151105.GH4601@localhost.localdomain>
In-Reply-To: <20190124151105.GH4601@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <95D888035C7FF54581DF7AAC638AFFD6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] file-posix: Cache lseek result for data
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

MjQuMDEuMjAxOSAxODoxMSwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMjQuMDEuMjAxOSB1bSAx
NTo0MCBoYXQgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+IDI0
LjAxLjIwMTkgMTc6MTcsIEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gRGVwZW5kaW5nIG9uIHRoZSBl
eGFjdCBpbWFnZSBsYXlvdXQgYW5kIHRoZSBzdG9yYWdlIGJhY2tlbmQgKHRtcGZzIGlzDQo+Pj4g
a29ud24gdG8gaGF2ZSB2ZXJ5IHNsb3cgU0VFS19IT0xFL1NFRUtfREFUQSksIGNhY2hpbmcgbHNl
ZWsgcmVzdWx0cyBjYW4NCj4+PiBzYXZlIHVzIGEgbG90IG9mIHRpbWUgZS5nLiBkdXJpbmcgYSBt
aXJyb3IgYmxvY2sgam9iIG9yIHFlbXUtaW1nIGNvbnZlcnQNCj4+PiB3aXRoIGEgZnJhZ21lbnRl
ZCBzb3VyY2UgaW1hZ2UgKC5iZHJ2X2NvX2Jsb2NrX3N0YXR1cyBvbiB0aGUgcHJvdG9jb2wNCj4+
PiBsYXllciBjYW4gYmUgY2FsbGVkIGZvciBldmVyeSBzaW5nbGUgY2x1c3RlciBpbiB0aGUgZXh0
cmVtZSBjYXNlKS4NCj4+Pg0KPj4+IFdlIG1heSBvbmx5IGNhY2hlIGRhdGEgcmVnaW9ucyBiZWNh
dXNlIG9mIHBvc3NpYmxlIGNvbmN1cnJlbnQgd3JpdGVycy4NCj4+PiBUaGlzIG1lYW5zIHRoYXQg
d2UgY2FuIGxhdGVyIHRyZWF0IGEgcmVjZW50bHkgcHVuY2hlZCBob2xlIGFzIGRhdGEsIGJ1dA0K
Pj4+IHRoaXMgaXMgc2FmZS4gV2UgY2FuJ3QgY2FjaGUgaG9sZXMgYmVjYXVzZSB0aGVuIHdlIG1p
Z2h0IHRyZWF0IHJlY2VudGx5DQo+Pj4gd3JpdHRlbiBkYXRhIGFzIGhvbGVzLCB3aGljaCBjYW4g
Y2F1c2UgY29ycnVwdGlvbi4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEtldmluIFdvbGYgPGt3
b2xmQHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgYmxvY2svZmlsZS1wb3NpeC5jIHwgNTEg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPj4+ICAgIDEg
ZmlsZSBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4g
ZGlmZiAtLWdpdCBhL2Jsb2NrL2ZpbGUtcG9zaXguYyBiL2Jsb2NrL2ZpbGUtcG9zaXguYw0KPj4+
IGluZGV4IDhhZWU3YTNmYjguLjcyNzJjN2M5OWQgMTAwNjQ0DQo+Pj4gLS0tIGEvYmxvY2svZmls
ZS1wb3NpeC5jDQo+Pj4gKysrIGIvYmxvY2svZmlsZS1wb3NpeC5jDQo+Pj4gQEAgLTE2OCw2ICsx
NjgsMTIgQEAgdHlwZWRlZiBzdHJ1Y3QgQkRSVlJhd1N0YXRlIHsNCj4+PiAgICAgICAgYm9vbCBu
ZWVkc19hbGlnbm1lbnQ7DQo+Pj4gICAgICAgIGJvb2wgY2hlY2tfY2FjaGVfZHJvcHBlZDsNCj4+
PiAgICANCj4+PiArICAgIHN0cnVjdCBzZWVrX2RhdGFfY2FjaGUgew0KPj4+ICsgICAgICAgIGJv
b2wgICAgICAgIHZhbGlkOw0KPj4+ICsgICAgICAgIHVpbnQ2NF90ICAgIHN0YXJ0Ow0KPj4+ICsg
ICAgICAgIHVpbnQ2NF90ICAgIGVuZDsNCj4+PiArICAgIH0gc2Vla19kYXRhX2NhY2hlOw0KPj4N
Cj4+IFNob3VsZCB3ZSBoYXZlIHNvbWUgbXV0ZXgtbG9ja2luZyB0byBwcm90ZWN0IGl0Pw0KPiAN
Cj4gSXQgaXMgcHJvdGVjdGVkIGJ5IHRoZSBBaW9Db250ZXh0IGxvY2ssIGxpa2UgZXZlcnl0aGlu
ZyBlbHNlIGluDQo+IEJEUlZSYXdTdGF0ZS4NCj4gDQoNClJlY2VudGx5IFBhb2xvIGFza2VkIG1l
IG5vdCB0byBhZGQgbW9yZSB1c2VycyBvZiBBaW9Db250ZXh0IGxvY2suIFVuZm9ydHVuYXRlbHkN
CkkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgd2hvbGUgcGljdHVyZSBhcm91bmQgaXQuLiBEb2Vzbid0
IHRoaXMgYXBwbHkgaGVyZT8NCmh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVt
dS1kZXZlbC8yMDE4LTEyL21zZzAzNDEwLmh0bWwNCg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0K
VmxhZGltaXINCg==

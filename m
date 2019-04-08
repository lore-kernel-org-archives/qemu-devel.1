Received: from eggs.gnu.org ([209.51.188.92]:50700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDUxN-000299-Cj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hDUxM-0004A9-Cj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:09:05 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 8 Apr 2019 14:08:30 +0000
Message-ID: <2510ecea-6984-846a-4cd5-e0eba535a4c2@virtuozzo.com>
References: <1554483379-682051-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554483379-682051-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE9D162515C6054582975C6CD4AB46E8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 3/3] block/stream: introduce a bottom
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "berto@igalia.com" <berto@igalia.com>, Denis Lunev <den@virtuozzo.com>

MDUuMDQuMjAxOSAxOTo1NiwgQW5kcmV5IFNoaW5rZXZpY2ggd3JvdGU6DQo+IFRoZSBib3R0b20g
bm9kZSBpcyB0aGUgaW50ZXJtZWRpYXRlIGJsb2NrIGRldmljZSB0aGF0IGhhcyB0aGUgYmFzZSBh
cyBpdHMNCj4gYmFja2luZyBpbWFnZS4gSXQgaXMgdXNlZCBpbnN0ZWFkIG9mIHRoZSBiYXNlIG5v
ZGUgd2hpbGUgYSBibG9jayBzdHJlYW0NCj4gam9iIGlzIHJ1bm5pbmcgdG8gYXZvaWQgZGVwZW5k
ZW5jeSBvbiB0aGUgYmFzZSB0aGF0IG1heSBjaGFuZ2UgZHVlIHRvIHRoZQ0KPiBwYXJhbGxlbCBq
b2JzLiBUaGUgY2hhbmdlIG1heSB0YWtlIHBsYWNlIGR1ZSB0byBhIGZpbHRlciBub2RlIGFzIHdl
bGwgdGhhdA0KPiBpcyBpbnNlcnRlZCBiZXR3ZWVuIHRoZSBiYXNlIGFuZCB0aGUgaW50ZXJtZWRp
YXRlIGJvdHRvbSBub2RlLiBJdCBvY2N1cnMNCj4gd2hlbiB0aGUgYmFzZSBub2RlIGlzIHRoZSB0
b3Agb25lIGZvciBhbm90aGVyIGNvbW1pdCBvciBzdHJlYW0gam9iLg0KPiBBZnRlciB0aGUgaW50
cm9kdWN0aW9uIG9mIHRoZSBib3R0b20gbm9kZSwgZG9uJ3QgZnJlZXplIGl0cyBiYWNraW5nIGNo
aWxkLA0KPiB0aGF0J3MgdGhlIGJhc2UsIGFueW1vcmUuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogQW5kcmV5IFNoaW5rZXZpY2ggPGFuZHJleS5zaGlua2V2aWNoQHZpcnR1
b3p6by5jb20+DQo+IFJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2
c2VtZW50c292QHZpcnR1b3p6by5jb20+DQo+IC0tLQ0KPiAgIGJsb2NrL3N0cmVhbS5jICAgICAg
ICAgfCA1NiArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgIGJsb2NrL3RyYWNlLWV2ZW50cyAgICAgfCAgMiArLQ0KPiAgIHRlc3RzL3FlbXUtaW90
ZXN0cy8yNDUgfCAgNCArKy0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCsp
LCAyOSBkZWxldGlvbnMoLSkNCj4gDQoNClsuLl0NCg0KPiBAQCAtMjMyLDggKzIzMiwxMyBAQCB2
b2lkIHN0cmVhbV9zdGFydChjb25zdCBjaGFyICpqb2JfaWQsIEJsb2NrRHJpdmVyU3RhdGUgKmJz
LA0KPiAgICAgICBTdHJlYW1CbG9ja0pvYiAqczsNCj4gICAgICAgQmxvY2tEcml2ZXJTdGF0ZSAq
aXRlcjsNCj4gICAgICAgYm9vbCBic19yZWFkX29ubHk7DQo+ICsgICAgQmxvY2tEcml2ZXJTdGF0
ZSAqYm90dG9tID0gTlVMTDsNCg0KV2h5IHRvIHNldCBOVUxMPyB5b3UgY2FuIHNldCB0byBiZHJ2
X2ZpbmRfb3ZlcmxheSgpIGhlcmUuDQoNCj4gKyAgICBpbnQgYmFzaWNfZmxhZ3MgPSBCTEtfUEVS
TV9DT05TSVNURU5UX1JFQUQgfCBCTEtfUEVSTV9XUklURV9VTkNIQU5HRUQ7DQo+ICsNCj4gKyAg
ICAvKiBGaW5kIHRoZSBib3R0b20gbm9kZSB0aGF0IGhhcyB0aGUgYmFzZSBhcyBpdHMgYmFja2lu
ZyBpbWFnZSAqLw0KDQpJIGRvbid0IHRoaW5rIHdlIG5lZWQgY29tbWVudCwgYXMgaXQncyBleGFj
dGx5IHdoYXQgYmRydl9maW5kX292ZXJseSBkb2VzLg0KDQo+ICsgICAgYm90dG9tID0gYmRydl9m
aW5kX292ZXJsYXkoYnMsIGJhc2UpOw0KPiAgIA0KPiAtICAgIGlmIChiZHJ2X2ZyZWV6ZV9iYWNr
aW5nX2NoYWluKGJzLCBiYXNlLCBlcnJwKSA8IDApIHsNCj4gKyAgICBpZiAoYmRydl9mcmVlemVf
YmFja2luZ19jaGFpbihicywgYm90dG9tLCBlcnJwKSA8IDApIHsNCj4gICAgICAgICAgIHJldHVy
bjsNCj4gICAgICAgfQ0KPiAgIA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

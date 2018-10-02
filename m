Received: from eggs.gnu.org ([2001:4830:134:3::10]:46745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nshirokovskiy@virtuozzo.com>) id 1g7Lmj-0005Ih-Vs
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nshirokovskiy@virtuozzo.com>) id 1g7Lh8-0005Uy-Rw
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 10:30:42 -0400
From: Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Date: Tue, 2 Oct 2018 14:30:32 +0000
Message-ID: <211ca3d9-cf48-f789-16ac-86d2dc5b36d9@virtuozzo.com>
References: <20181002113325.12911-1-vsementsov@virtuozzo.com>
	<20181002113325.12911-2-vsementsov@virtuozzo.com>
	<5709dbd2-1de5-3440-870e-127aae8f469e@redhat.com>
In-Reply-To: <5709dbd2-1de5-3440-870e-127aae8f469e@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F4B38C3FE84214AB9121B8DCCE6C883@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: support device id for
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>

DQoNCk9uIDAyLjEwLjIwMTggMTc6MjIsIEVyaWMgQmxha2Ugd3JvdGU6DQo+IE9uIDEwLzIvMTgg
NjozMyBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IFN1cHBvcnQg
bW9kZXJuIHdheSBvZiBkZXZpY2Ugc2VsZWN0aW5nLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFZs
YWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4+
IC0tLQ0KPj4gwqAgcWFwaS9ibG9jay1jb3JlLmpzb24gfCA2ICsrKystLQ0KPj4gwqAgYmxvY2tk
ZXYuY8KgwqDCoMKgwqDCoMKgwqDCoMKgIHwgOCArKysrKy0tLQ0KPj4gwqAgMiBmaWxlcyBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L3FhcGkvYmxvY2stY29yZS5qc29uIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+IGluZGV4IGFj
M2I0OGVlNTQuLjRlZmQ2MGQ4YWIgMTAwNjQ0DQo+PiAtLS0gYS9xYXBpL2Jsb2NrLWNvcmUuanNv
bg0KPj4gKysrIGIvcWFwaS9ibG9jay1jb3JlLmpzb24NCj4+IEBAIC00ODksNyArNDg5LDkgQEAN
Cj4+IMKgICMgSWYgb25seSBAZGV2aWNlIHBhcmFtZXRlciBpcyBzcGVjaWZpZWQsIHJlbW92ZSBh
bGwgcHJlc2VudCBsYXRlbmN5IGhpc3RvZ3JhbXMNCj4+IMKgICMgZm9yIHRoZSBkZXZpY2UuIE90
aGVyd2lzZSwgYWRkL3Jlc2V0IHNvbWUgb2YgKG9yIGFsbCkgbGF0ZW5jeSBoaXN0b2dyYW1zLg0K
Pj4gwqAgIw0KPj4gLSMgQGRldmljZTogZGV2aWNlIG5hbWUgdG8gc2V0IGxhdGVuY3kgaGlzdG9n
cmFtIGZvci4NCj4+ICsjIEBkZXZpY2U6IGRldmljZSBuYW1lIHRvIHNldCBsYXRlbmN5IGhpc3Rv
Z3JhbSBmb3IgKGJldHRlciB1c2UgQGlkKS4NCj4+ICsjDQo+PiArIyBAaWQ6IFRoZSBuYW1lIG9y
IFFPTSBwYXRoIG9mIHRoZSBndWVzdCBkZXZpY2UuDQo+IA0KPiBBcyBsb25nIGFzIHdlIGFyZSBy
ZW5hbWluZyB0aGUgY29tbWFuZCwgdGhlcmUncyBubyBuZWVkIHRvIGtlZXAgYSBsZWdhY3kgcGFy
YW1ldGVyIGFyb3VuZC4gSnVzdCBnZXQgcmlkIG9mIGRldmljZSBhbmQgcmVwbGFjZSBpdCBieSBp
ZCwgcmF0aGVyIHRoYW4gd29ycnlpbmcgYWJvdXQgYm90aC7CoCBUaGUgaW50cm9kdWN0aW9uIG9m
IHRoZSBzdGFibGUgY29tbWFuZCBkb2VzIG5vdCBoYXZlIHRvIGNhcnJ5IGFueSBiYWdnYWdlIGxl
ZnQgb3ZlciBmcm9tIHRoZSB4LSBwcmVsaW1pbmFyeSB2ZXJzaW9uLg0KPiANCg0KSSdtIGFmcmFp
ZCBsaWJ2aXJ0IGlzIG5vdCByZWFkeSBmb3IgdGhpcy4gSXQgd29ya3MgZWl0aGVyIHRocnUgZHJp
dmUgYWxpYXNlcyBvciBxb20gcGF0aHMgZGVwZW5kaW5nDQpvbiBjYXBhYmlsaXR5IHRoYXQgaXMg
bm90IHR1cm5lZCBvbiB5ZXQuIEl0IHRha2VzIHNvbWUgdGltZSBiZWZvcmUgY2FwYWJpbGl0eSBj
YW4gYmUgc2FmZWx5IHR1cm5lZA0Kb24gKGJsb2Nram9iIGNvZGUgaXMgbm90IHJlYWR5IEFGQUlL
KS4gVW50aWwgdGhhdCBtb21lbnQgd2UgY2FuIG5vdCB1c2UgbGF0ZW5jeSBBUEkgd2l0aG91dCAi
ZGV2aWNlIiBwYXJhbWV0ZXIuDQoNCk5pa29sYXkNCg==

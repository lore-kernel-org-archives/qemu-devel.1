Received: from eggs.gnu.org ([2001:4830:134:3::10]:59104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gXPgu-00051t-4R
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gXPgr-0000EY-Jn
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:02:07 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Thu, 13 Dec 2018 12:01:55 +0000
Message-ID: <ab3c2681-0d84-4672-aff2-1865fc25ba86@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-7-anton.nefedov@virtuozzo.com>
	<7ca3779c-b552-97f1-8ce2-860db23be045@virtuozzo.com>
	<ba2723a2-fd5d-6e96-002f-70c14092ded8@virtuozzo.com>
	<312f075e-6e7f-5e8b-e7c9-e0d4c94e5ede@virtuozzo.com>
In-Reply-To: <312f075e-6e7f-5e8b-e7c9-e0d4c94e5ede@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A20E301C83C2FA4EBE06A53C0149EE66@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 6/9] file-posix: support
 BDRV_REQ_ALLOCATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

T24gMTIvMTIvMjAxOCA4OjE5IFBNLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3Rl
Og0KPiAwNS4xMi4yMDE4IDE3OjExLCBBbnRvbiBOZWZlZG92IHdyb3RlOg0KPj4gT24gNS8xMi8y
MDE4IDQ6MjUgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4gMDMu
MTIuMjAxOCAxMzoxNCwgQW50b24gTmVmZWRvdiB3cm90ZToNCj4+Pj4gICAgICAgICAgfQ0KPj4+
PiAgICAgICNlbmRpZg0KPj4+PiAgICAgIA0KPj4+PiAtICAgIGJzLT5zdXBwb3J0ZWRfemVyb19m
bGFncyA9IEJEUlZfUkVRX01BWV9VTk1BUDsNCj4+Pj4gKyAgICBicy0+c3VwcG9ydGVkX3plcm9f
ZmxhZ3MgfD0gQkRSVl9SRVFfTUFZX1VOTUFQOw0KPj4+PiAgICAgICAgICByZXQgPSAwOw0KPj4+
PiAgICAgIGZhaWw6DQo+Pj4+ICAgICAgICAgIGlmIChmaWxlbmFtZSAmJiAoYmRydl9mbGFncyAm
IEJEUlZfT19URU1QT1JBUlkpKSB7DQo+Pj4+IEBAIC0xNTIwLDYgKzE1MjIsMTAgQEAgc3RhdGlj
IHNzaXplX3QgaGFuZGxlX2Fpb2NiX3dyaXRlX3plcm9lcyhSYXdQb3NpeEFJT0RhdGEgKmFpb2Ni
KQ0KPj4+PiAgICAgICAgICAgICAgfQ0KPj4+PiAgICAgICAgICAgICAgcy0+aGFzX2ZhbGxvY2F0
ZSA9IGZhbHNlOw0KPj4+PiAgICAgICAgICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICBpZiAoIXMtPmhh
c19mYWxsb2NhdGUpIHsNCj4+Pj4gKyAgICAgICAgYWlvY2ItPmJzLT5zdXBwb3J0ZWRfemVyb19m
bGFncyAmPSB+QkRSVl9SRVFfQUxMT0NBVEU7DQo+Pj4+ICsgICAgfQ0KID4+Pj4+ICAgICAjZW5k
aWYNCj4gDQo+IGhtLCBpZiBDT05GSUdfRkFMTE9DQVRFIGlzIGRpc2FibGVkLCBmbGFnIHdpbGwg
cmVtYWluIGluIHN1cHBvcnRlZF96ZXJvX2ZsYWdzDQo+IA0KDQpyaWdodC4uDQpJIHRoaW5rIHRo
ZXJlIHNob3VsZCBiZSBhIHNlcGFyYXRlIHBhdGNoIHRvIHJlc2V0IHMtPmhhc18qIGluDQpub24t
Q09ORklHX0ZBTExPQ0FURSogY2FzZXMuIFRoZW4gSSdsbCBtb3ZlIHRoaXMgaHVuayBqdXN0IG9u
ZSBsaW5lIGRvd24NCnVuZGVyIHRoZSBmb2xsb3dpbmcgI2VuZGlmDQo=

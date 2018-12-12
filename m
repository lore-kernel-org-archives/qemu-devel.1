Received: from eggs.gnu.org ([2001:4830:134:3::10]:60108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gX8AW-0001cC-4H
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gX8AU-0008C7-CJ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 12:19:32 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 12 Dec 2018 17:19:21 +0000
Message-ID: <312f075e-6e7f-5e8b-e7c9-e0d4c94e5ede@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-7-anton.nefedov@virtuozzo.com>
	<7ca3779c-b552-97f1-8ce2-860db23be045@virtuozzo.com>
	<ba2723a2-fd5d-6e96-002f-70c14092ded8@virtuozzo.com>
In-Reply-To: <ba2723a2-fd5d-6e96-002f-70c14092ded8@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EDBB44510B3C248BB650FC80EA56BC6@eurprd08.prod.outlook.com>
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
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>

MDUuMTIuMjAxOCAxNzoxMSwgQW50b24gTmVmZWRvdiB3cm90ZToNCj4gT24gNS8xMi8yMDE4IDQ6
MjUgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+PiAwMy4xMi4yMDE4
IDEzOjE0LCBBbnRvbiBOZWZlZG92IHdyb3RlOg0KPj4+IEN1cnJlbnQgd3JpdGVfemVyb2VzIGlt
cGxlbWVudGF0aW9uIGlzIGdvb2QgZW5vdWdoIHRvIHNhdGlzZnkgdGhpcyBmbGFnIHRvbw0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogQW50b24gTmVmZWRvdiA8YW50b24ubmVmZWRvdkB2aXJ0dW96
em8uY29tPg0KPj4+IC0tLQ0KPj4+ICAgICBibG9jay9maWxlLXBvc2l4LmMgfCA4ICsrKysrKyst
DQo+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ibG9jay9maWxlLXBvc2l4LmMgYi9ibG9jay9maWxlLXBv
c2l4LmMNCj4+PiBpbmRleCAwN2JiZGFiOTUzLi5iMGI3YWIwMTU5IDEwMDY0NA0KPj4+IC0tLSBh
L2Jsb2NrL2ZpbGUtcG9zaXguYw0KPj4+ICsrKyBiL2Jsb2NrL2ZpbGUtcG9zaXguYw0KPj4+IEBA
IC02MDMsNiArNjAzLDcgQEAgc3RhdGljIGludCByYXdfb3Blbl9jb21tb24oQmxvY2tEcml2ZXJT
dGF0ZSAqYnMsIFFEaWN0ICpvcHRpb25zLA0KPj4+ICAgICAgICAgICAgIH0gZWxzZSB7DQo+Pj4g
ICAgICAgICAgICAgICAgIHMtPmRpc2NhcmRfemVyb2VzID0gdHJ1ZTsNCj4+PiAgICAgICAgICAg
ICAgICAgcy0+aGFzX2ZhbGxvY2F0ZSA9IHRydWU7DQo+Pj4gKyAgICAgICAgICAgIGJzLT5zdXBw
b3J0ZWRfemVyb19mbGFncyA9IEJEUlZfUkVRX0FMTE9DQVRFOw0KPj4+ICAgICAgICAgICAgIH0N
Cj4+PiAgICAgICAgIH0gZWxzZSB7DQo+Pj4gICAgICAgICAgICAgaWYgKCEoU19JU0NIUihzdC5z
dF9tb2RlKSB8fCBTX0lTQkxLKHN0LnN0X21vZGUpKSkgew0KPj4+IEBAIC02NDYsMTAgKzY0Nywx
MSBAQCBzdGF0aWMgaW50IHJhd19vcGVuX2NvbW1vbihCbG9ja0RyaXZlclN0YXRlICpicywgUURp
Y3QgKm9wdGlvbnMsDQo+Pj4gICAgICNpZmRlZiBDT05GSUdfWEZTDQo+Pj4gICAgICAgICBpZiAo
cGxhdGZvcm1fdGVzdF94ZnNfZmQocy0+ZmQpKSB7DQo+Pj4gICAgICAgICAgICAgcy0+aXNfeGZz
ID0gdHJ1ZTsNCj4+PiArICAgICAgICBicy0+c3VwcG9ydGVkX3plcm9fZmxhZ3MgPSBCRFJWX1JF
UV9BTExPQ0FURTsNCj4+DQo+PiB3aHkgd2Ugc2hvdWxkIGhhbmRsZSB4ZnMgc2VwYXJhdGVseT8g
aXMgdGhlcmUgYSBjYXNlIHdpdGggeGZzLCBub3QgaGFuZGxlZCBieSBwcmV2aW91cyBnZW5lcmlj
IGlmICgpPw0KPj4NCj4gDQo+IFRoZSBkcml2ZXIgc3VwcG9ydHMgQUxMT0NBVEUgZWl0aGVyIHdo
ZW4gaXQncyBYRlMsIG9yIHdoZW4gZmFsbG9jYXRlIGlzDQo+IGF2YWlsYWJsZS4gQ3VycmVudGx5
IHRoZXJlIGlzIG5vIHRlc3QgZm9yIGZhbGxvY2F0ZSwgaXQncyBqdXN0IGltcGxpZWQNCj4gaXQn
cyBzdXBwb3J0ZWQgdW50aWwgRU5PVFNVUCByZXR1cm5lZC4NCj4gSSB0aGluayBpdCdzIHNhZmVy
IChmb3IgcG9zc2libGUgZnV0dXJlIGNoYW5nZXMpIHRvIHNldCBpdCB0d2ljZSBldmVuDQo+IHRo
b3VnaCB5b3UncmUgcmlnaHQgYW5kIGZpcnN0IGNvbmRpdGlvbiBjdXJyZW50bHkgY292ZXJzIHRo
ZSBYRlMNCj4gY29uZGl0aW9uIHRvby4NCg0KQWhhLCBvay4NCg0KDQoNCj4gDQo+Pj4gICAgICAg
ICB9DQo+Pj4gICAgICNlbmRpZg0KPj4+ICAgICANCj4+PiAtICAgIGJzLT5zdXBwb3J0ZWRfemVy
b19mbGFncyA9IEJEUlZfUkVRX01BWV9VTk1BUDsNCj4+PiArICAgIGJzLT5zdXBwb3J0ZWRfemVy
b19mbGFncyB8PSBCRFJWX1JFUV9NQVlfVU5NQVA7DQo+Pj4gICAgICAgICByZXQgPSAwOw0KPj4+
ICAgICBmYWlsOg0KPj4+ICAgICAgICAgaWYgKGZpbGVuYW1lICYmIChiZHJ2X2ZsYWdzICYgQkRS
Vl9PX1RFTVBPUkFSWSkpIHsNCj4+PiBAQCAtMTUyMCw2ICsxNTIyLDEwIEBAIHN0YXRpYyBzc2l6
ZV90IGhhbmRsZV9haW9jYl93cml0ZV96ZXJvZXMoUmF3UG9zaXhBSU9EYXRhICphaW9jYikNCj4+
PiAgICAgICAgICAgICB9DQo+Pj4gICAgICAgICAgICAgcy0+aGFzX2ZhbGxvY2F0ZSA9IGZhbHNl
Ow0KPj4+ICAgICAgICAgfQ0KPj4+ICsNCj4+PiArICAgIGlmICghcy0+aGFzX2ZhbGxvY2F0ZSkg
ew0KPj4+ICsgICAgICAgIGFpb2NiLT5icy0+c3VwcG9ydGVkX3plcm9fZmxhZ3MgJj0gfkJEUlZf
UkVRX0FMTE9DQVRFOw0KPj4+ICsgICAgfQ0KDQpobSwgaWYgQ09ORklHX0ZBTExPQ0FURSBpcyBk
aXNhYmxlZCwgZmxhZyB3aWxsIHJlbWFpbiBpbiBzdXBwb3J0ZWRfemVyb19mbGFncw0KDQo+Pj4g
ICAgICNlbmRpZg0KPj4+ICAgICANCj4+PiAgICAgICAgIHJldHVybiAtRU5PVFNVUDsNCj4+Pg0K
Pj4NCj4+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

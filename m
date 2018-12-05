Received: from eggs.gnu.org ([2001:4830:134:3::10]:33778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gUXtk-0002vM-FT
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:11:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gUXti-0006Kg-PX
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:11:32 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 5 Dec 2018 14:11:16 +0000
Message-ID: <ba2723a2-fd5d-6e96-002f-70c14092ded8@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-7-anton.nefedov@virtuozzo.com>
	<7ca3779c-b552-97f1-8ce2-860db23be045@virtuozzo.com>
In-Reply-To: <7ca3779c-b552-97f1-8ce2-860db23be045@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <34655EB6B10D6D4ABF168A8CC43864C8@eurprd08.prod.outlook.com>
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

T24gNS8xMi8yMDE4IDQ6MjUgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6
DQo+IDAzLjEyLjIwMTggMTM6MTQsIEFudG9uIE5lZmVkb3Ygd3JvdGU6DQo+PiBDdXJyZW50IHdy
aXRlX3plcm9lcyBpbXBsZW1lbnRhdGlvbiBpcyBnb29kIGVub3VnaCB0byBzYXRpc2Z5IHRoaXMg
ZmxhZyB0b28NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbnRvbiBOZWZlZG92IDxhbnRvbi5uZWZl
ZG92QHZpcnR1b3p6by5jb20+DQo+PiAtLS0NCj4+ICAgIGJsb2NrL2ZpbGUtcG9zaXguYyB8IDgg
KysrKysrKy0NCj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYmxvY2svZmlsZS1wb3NpeC5jIGIvYmxvY2svZmls
ZS1wb3NpeC5jDQo+PiBpbmRleCAwN2JiZGFiOTUzLi5iMGI3YWIwMTU5IDEwMDY0NA0KPj4gLS0t
IGEvYmxvY2svZmlsZS1wb3NpeC5jDQo+PiArKysgYi9ibG9jay9maWxlLXBvc2l4LmMNCj4+IEBA
IC02MDMsNiArNjAzLDcgQEAgc3RhdGljIGludCByYXdfb3Blbl9jb21tb24oQmxvY2tEcml2ZXJT
dGF0ZSAqYnMsIFFEaWN0ICpvcHRpb25zLA0KPj4gICAgICAgICAgICB9IGVsc2Ugew0KPj4gICAg
ICAgICAgICAgICAgcy0+ZGlzY2FyZF96ZXJvZXMgPSB0cnVlOw0KPj4gICAgICAgICAgICAgICAg
cy0+aGFzX2ZhbGxvY2F0ZSA9IHRydWU7DQo+PiArICAgICAgICAgICAgYnMtPnN1cHBvcnRlZF96
ZXJvX2ZsYWdzID0gQkRSVl9SRVFfQUxMT0NBVEU7DQo+PiAgICAgICAgICAgIH0NCj4+ICAgICAg
ICB9IGVsc2Ugew0KPj4gICAgICAgICAgICBpZiAoIShTX0lTQ0hSKHN0LnN0X21vZGUpIHx8IFNf
SVNCTEsoc3Quc3RfbW9kZSkpKSB7DQo+PiBAQCAtNjQ2LDEwICs2NDcsMTEgQEAgc3RhdGljIGlu
dCByYXdfb3Blbl9jb21tb24oQmxvY2tEcml2ZXJTdGF0ZSAqYnMsIFFEaWN0ICpvcHRpb25zLA0K
Pj4gICAgI2lmZGVmIENPTkZJR19YRlMNCj4+ICAgICAgICBpZiAocGxhdGZvcm1fdGVzdF94ZnNf
ZmQocy0+ZmQpKSB7DQo+PiAgICAgICAgICAgIHMtPmlzX3hmcyA9IHRydWU7DQo+PiArICAgICAg
ICBicy0+c3VwcG9ydGVkX3plcm9fZmxhZ3MgPSBCRFJWX1JFUV9BTExPQ0FURTsNCj4gDQo+IHdo
eSB3ZSBzaG91bGQgaGFuZGxlIHhmcyBzZXBhcmF0ZWx5PyBpcyB0aGVyZSBhIGNhc2Ugd2l0aCB4
ZnMsIG5vdCBoYW5kbGVkIGJ5IHByZXZpb3VzIGdlbmVyaWMgaWYgKCk/DQo+IA0KDQpUaGUgZHJp
dmVyIHN1cHBvcnRzIEFMTE9DQVRFIGVpdGhlciB3aGVuIGl0J3MgWEZTLCBvciB3aGVuIGZhbGxv
Y2F0ZSBpcw0KYXZhaWxhYmxlLiBDdXJyZW50bHkgdGhlcmUgaXMgbm8gdGVzdCBmb3IgZmFsbG9j
YXRlLCBpdCdzIGp1c3QgaW1wbGllZA0KaXQncyBzdXBwb3J0ZWQgdW50aWwgRU5PVFNVUCByZXR1
cm5lZC4NCkkgdGhpbmsgaXQncyBzYWZlciAoZm9yIHBvc3NpYmxlIGZ1dHVyZSBjaGFuZ2VzKSB0
byBzZXQgaXQgdHdpY2UgZXZlbg0KdGhvdWdoIHlvdSdyZSByaWdodCBhbmQgZmlyc3QgY29uZGl0
aW9uIGN1cnJlbnRseSBjb3ZlcnMgdGhlIFhGUyANCmNvbmRpdGlvbiB0b28uDQoNCj4+ICAgICAg
ICB9DQo+PiAgICAjZW5kaWYNCj4+ICAgIA0KPj4gLSAgICBicy0+c3VwcG9ydGVkX3plcm9fZmxh
Z3MgPSBCRFJWX1JFUV9NQVlfVU5NQVA7DQo+PiArICAgIGJzLT5zdXBwb3J0ZWRfemVyb19mbGFn
cyB8PSBCRFJWX1JFUV9NQVlfVU5NQVA7DQo+PiAgICAgICAgcmV0ID0gMDsNCj4+ICAgIGZhaWw6
DQo+PiAgICAgICAgaWYgKGZpbGVuYW1lICYmIChiZHJ2X2ZsYWdzICYgQkRSVl9PX1RFTVBPUkFS
WSkpIHsNCj4+IEBAIC0xNTIwLDYgKzE1MjIsMTAgQEAgc3RhdGljIHNzaXplX3QgaGFuZGxlX2Fp
b2NiX3dyaXRlX3plcm9lcyhSYXdQb3NpeEFJT0RhdGEgKmFpb2NiKQ0KPj4gICAgICAgICAgICB9
DQo+PiAgICAgICAgICAgIHMtPmhhc19mYWxsb2NhdGUgPSBmYWxzZTsNCj4+ICAgICAgICB9DQo+
PiArDQo+PiArICAgIGlmICghcy0+aGFzX2ZhbGxvY2F0ZSkgew0KPj4gKyAgICAgICAgYWlvY2It
PmJzLT5zdXBwb3J0ZWRfemVyb19mbGFncyAmPSB+QkRSVl9SRVFfQUxMT0NBVEU7DQo+PiArICAg
IH0NCj4+ICAgICNlbmRpZg0KPj4gICAgDQo+PiAgICAgICAgcmV0dXJuIC1FTk9UU1VQOw0KPj4N
Cj4gDQo+IA0K

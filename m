Received: from eggs.gnu.org ([2001:4830:134:3::10]:45781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gUXDv-0000vE-Ab
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gUXDo-0005Wn-Qi
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 08:28:17 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 5 Dec 2018 13:27:54 +0000
Message-ID: <073888f8-b7ee-6740-30f2-37b21617e883@virtuozzo.com>
References: <20181203101429.88735-1-anton.nefedov@virtuozzo.com>
	<20181203101429.88735-2-anton.nefedov@virtuozzo.com>
	<02630e63-672a-43f3-5074-fc1691933d56@virtuozzo.com>
In-Reply-To: <02630e63-672a-43f3-5074-fc1691933d56@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <18DD7B2DC81A434883C995FDE2BC5C0F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v10 1/9] mirror: inherit supported
 write/zero flags
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

T24gNS8xMi8yMDE4IDM6NDMgUE0sIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6
DQo+IENvdWxkIHlvdSBwbGVhc2Ugd3JpdGUsIHdoYXQgaXMgdGhlIGJlaGF2aW9yIGNoYW5nZSBh
bmQgd2h5IGhlcmU/DQo+IA0KDQpUaGUgaWRlYSBpcyB0aGF0IHBhc3N0aHJvdWdoIGRyaXZlcnMg
c2hvdWxkIHJlcG9ydCB0aGUgZmxhZ3MgaWYgdGhlcmUNCmFyZSBubyBvYnN0YWNsZXMgdG8gc3Vw
cG9ydCBpdC4NClRlY2huaWNhbGx5LCB0aGVzZSBjaGFuZ2VzIGFyZSBub3QgY29ubmVjdGVkIHRv
IHRoaXMgc2VyaWVzLCBidXQgc2luY2UNCkJEUlZfUkVRX0FMTE9DQVRFIGZsYWcgaXMgYWRkZWQs
IHNvIHdlIG1pZ2h0IHdhbnQgdG8gZXhwb3NlIGl0IHdoZXJlDQpwb3NzaWJsZS4NCg0KPiBJcyBp
dCBhIGJ1ZywgdGhhdCBGVUEgd2FzIG5vdCBpbmhlcml0ZWQgYmVmb3JlPw0KPiANCg0KSSBkb24n
dCB0aGluayBpdCdzIGEgYnVnIHJlYWxseSBzaW5jZSB0aGVyZSBpcyBhIGZhbGxiYWNrIHBhdGgg
aW4NCmJsb2NrL2lvLmMuDQoNCj4gMDMuMTIuMjAxOCAxMzoxNCwgQW50b24gTmVmZWRvdiB3cm90
ZToNCj4+IFNpZ25lZC1vZmYtYnk6IEFudG9uIE5lZmVkb3YgPGFudG9uLm5lZmVkb3ZAdmlydHVv
enpvLmNvbT4NCj4+IC0tLQ0KPj4gICAgYmxvY2svbWlycm9yLmMgfCA4ICsrKysrKy0tDQo+PiAg
ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ibG9jay9taXJyb3IuYyBiL2Jsb2NrL21pcnJvci5jDQo+PiBpbmRleCA1
NmQ5ZWY3NDc0Li41NjkwOGM5YjE5IDEwMDY0NA0KPj4gLS0tIGEvYmxvY2svbWlycm9yLmMNCj4+
ICsrKyBiL2Jsb2NrL21pcnJvci5jDQo+PiBAQCAtMTUyOCw4ICsxNTI4LDEyIEBAIHN0YXRpYyB2
b2lkIG1pcnJvcl9zdGFydF9qb2IoY29uc3QgY2hhciAqam9iX2lkLCBCbG9ja0RyaXZlclN0YXRl
ICpicywNCj4+ICAgICAgICAgICAgbWlycm9yX3RvcF9icy0+aW1wbGljaXQgPSB0cnVlOw0KPj4g
ICAgICAgIH0NCj4+ICAgICAgICBtaXJyb3JfdG9wX2JzLT50b3RhbF9zZWN0b3JzID0gYnMtPnRv
dGFsX3NlY3RvcnM7DQo+PiAtICAgIG1pcnJvcl90b3BfYnMtPnN1cHBvcnRlZF93cml0ZV9mbGFn
cyA9IEJEUlZfUkVRX1dSSVRFX1VOQ0hBTkdFRDsNCj4+IC0gICAgbWlycm9yX3RvcF9icy0+c3Vw
cG9ydGVkX3plcm9fZmxhZ3MgPSBCRFJWX1JFUV9XUklURV9VTkNIQU5HRUQ7DQo+PiArICAgIG1p
cnJvcl90b3BfYnMtPnN1cHBvcnRlZF93cml0ZV9mbGFncyA9IEJEUlZfUkVRX1dSSVRFX1VOQ0hB
TkdFRCB8DQo+PiArICAgICAgICAoQkRSVl9SRVFfRlVBICYgYnMtPnN1cHBvcnRlZF93cml0ZV9m
bGFncyk7DQo+PiArICAgIG1pcnJvcl90b3BfYnMtPnN1cHBvcnRlZF96ZXJvX2ZsYWdzID0gQkRS
Vl9SRVFfV1JJVEVfVU5DSEFOR0VEIHwNCj4+ICsgICAgICAgICgoQkRSVl9SRVFfRlVBIHwgQkRS
Vl9SRVFfTUFZX1VOTUFQKQ0KPj4gKyAgICAgICAgICYgYnMtPnN1cHBvcnRlZF96ZXJvX2ZsYWdz
KTsNCj4+ICsNCj4+ICAgICAgICBic19vcGFxdWUgPSBnX25ldzAoTWlycm9yQkRTT3BhcXVlLCAx
KTsNCj4+ICAgICAgICBtaXJyb3JfdG9wX2JzLT5vcGFxdWUgPSBic19vcGFxdWU7DQo+PiAgICAg
ICAgYmRydl9zZXRfYWlvX2NvbnRleHQobWlycm9yX3RvcF9icywgYmRydl9nZXRfYWlvX2NvbnRl
eHQoYnMpKTsNCj4+DQo+IA0KPiANCg==

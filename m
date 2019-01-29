Received: from eggs.gnu.org ([209.51.188.92]:34896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1goRPB-0001dK-8v
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1goRPA-00060P-CU
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 06:18:13 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 29 Jan 2019 11:18:03 +0000
Message-ID: <49f1af0b-a245-3b17-7e74-6b3837e42406@virtuozzo.com>
References: <20190125164601.130556-1-vsementsov@virtuozzo.com>
	<20190129033155.GD3264@stefanha-x1.localdomain>
	<fa3cc31b-937c-a22c-4079-2ad7d968aac5@virtuozzo.com>
	<CAJSP0QUCeM2wHA5Z4wnBYHoE9=sLxxAqyDMZ5-i4g12v2DQEiQ@mail.gmail.com>
In-Reply-To: <CAJSP0QUCeM2wHA5Z4wnBYHoE9=sLxxAqyDMZ5-i4g12v2DQEiQ@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <C954E7396137A64C9A9BC86589A876FF@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] block: local qiov helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>

MjkuMDEuMjAxOSAxMzozMiwgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiBPbiBUdWUsIEphbiAy
OSwgMjAxOSBhdCA2OjI0IFBNIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkNCj4gPHZzZW1l
bnRzb3ZAdmlydHVvenpvLmNvbT4gd3JvdGU6DQo+PiAyOS4wMS4yMDE5IDY6MzEsIFN0ZWZhbiBI
YWpub2N6aSB3cm90ZToNCj4+PiBPbiBGcmksIEphbiAyNSwgMjAxOSBhdCAwNzo0NjowMVBNICsw
MzAwLCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4gSG1tLiBJbiB0aGlz
IGNhc2Ugd2UgZGVmaW5pdGVseSB3aWxsIGhhdmUgdGlueSBleHRyYSBtZW1vcnkgdXNhZ2UsIGJ1
dCB3ZSBnYWluIGJlYXV0aWZ1bA0KPj4gcmVhZGFiaWxpdHkuDQo+Pg0KPj4gU28sIGxpa2UgdGhp
czoNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2lvdi5oIGIvaW5jbHVkZS9xZW11
L2lvdi5oDQo+PiBpbmRleCA1ZjQzM2M3NzY4Li41M2RlMWIzOGJiIDEwMDY0NA0KPj4gLS0tIGEv
aW5jbHVkZS9xZW11L2lvdi5oDQo+PiArKysgYi9pbmNsdWRlL3FlbXUvaW92LmgNCj4+IEBAIC0x
MzQsOSArMTM0LDMxIEBAIHR5cGVkZWYgc3RydWN0IFFFTVVJT1ZlY3RvciB7DQo+PiAgICAgICAg
c3RydWN0IGlvdmVjICppb3Y7DQo+PiAgICAgICAgaW50IG5pb3Y7DQo+PiAgICAgICAgaW50IG5h
bGxvYzsNCj4+IC0gICAgc2l6ZV90IHNpemU7DQo+PiArICAgIHVuaW9uIHsNCj4+ICsgICAgICAg
IHN0cnVjdCB7DQo+PiArICAgICAgICAgICAgdm9pZCAqX191bnVzZWRfaW92X2Jhc2U7DQo+IA0K
PiBUaGlzIGNvdWxkIGJlIHN0cnVjdCBpb3ZlYyAqaW92IGZvciBuYWxsb2MgPiAwIHVzZXJzLiAg
TXVzdCByZXNpc3QgaGFja2luZXNzISA6KQ0KDQpjYW4ndCBiZSBpb3YsIGdjYyBjb21wbGFpbnM6
DQppbmNsdWRlL3FlbXUvaW92Lmg6MTM5OjI3OiBlcnJvcjogZHVwbGljYXRlIG1lbWJlciDigJhp
b3bigJkNCiAgICAgICAgICAgICAgc3RydWN0IGlvdmVjICppb3Y7DQoNCj4gDQo+PiArICAgICAg
ICAgICAgc2l6ZV90IHNpemU7DQo+PiArICAgICAgICB9Ow0KPj4gKyAgICAgICAgc3RydWN0IGlv
dmVjIGxvY2FsX2lvdjsNCj4+ICsgICAgfTsNCj4+ICAgIH0gUUVNVUlPVmVjdG9yOw0KPiANCj4g
VGhhdCdzIGNsZXZlciBhbmQgbm90IHRvbyBoYWNreS4gIFBsZWFzZSBpbmNsdWRlIGEgY29tbWVu
dCBzbyB0aGUNCj4gaW50ZW50IGlzIGNsZWFyOg0KPiANCj4gICAgLyogU2F2ZSBzcGFjZSBieSBy
ZXVzaW5nIHRoZSBlbWJlZGRlZCBpb3ZlYydzIHNpemUgZmllbGQgYXMgdGhlDQo+IHRvdGFsIHNp
emUgZmllbGQuICBVc2VycyB3aXRoIGV4dGVybmFsIGlvdmVjcyBkb24ndCB1c2UgdGhlIGVtYmVk
ZGVkDQo+IGlvdmVjIHNvIHRoaXMgaXMgc2FmZS4gKi8NCj4gDQo+IFN0ZWZhbg0KPiANCg0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

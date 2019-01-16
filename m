Received: from eggs.gnu.org ([209.51.188.92]:47737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gjhZB-0005Ky-KE
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:32:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gjhZ9-0008LU-JV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:32:57 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 16 Jan 2019 09:32:33 +0000
Message-ID: <9b9b651d-729e-d72f-5335-b9c8121135d3@virtuozzo.com>
References: <20190114111744.113188-1-anton.nefedov@virtuozzo.com>
	<20190114111744.113188-10-anton.nefedov@virtuozzo.com>
	<w5136pu54ao.fsf@maestria.local.igalia.com>
In-Reply-To: <w5136pu54ao.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <E55BE1C1A702944AB5509357F905FBCA@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v12 09/10] qcow2: skip writing zero buffers
 to empty COW areas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

T24gMTUvMS8yMDE5IDY6MjcgUE0sIEFsYmVydG8gR2FyY2lhIHdyb3RlOg0KPiBPbiBNb24gMTQg
SmFuIDIwMTkgMTI6MTg6MzAgUE0gQ0VULCBBbnRvbiBOZWZlZG92IHdyb3RlOg0KPj4gSWYgQ09X
IGFyZWFzIG9mIHRoZSBuZXdseSBhbGxvY2F0ZWQgY2x1c3RlcnMgYXJlIHplcm9lcyBvbiB0aGUg
YmFja2luZyBpbWFnZSwNCj4+IGVmZmljaWVudCBiZHJ2X3dyaXRlX3plcm9lcyhmbGFncz1CRFJW
X1JFUV9BTExPQ0FURSkgY2FuIGJlIHVzZWQgb24gdGhlIHdob2xlDQo+PiBjbHVzdGVyIGluc3Rl
YWQgb2Ygd3JpdGluZyBleHBsaWNpdCB6ZXJvIGJ1ZmZlcnMgbGF0ZXIgaW4gcGVyZm9ybV9jb3co
KS4NCj4+DQo+PiBpb3Rlc3QgMDYwOg0KPj4gd3JpdGUgdG8gdGhlIGRpc2NhcmRlZCBjbHVzdGVy
IGRvZXMgbm90IHRyaWdnZXIgQ09XIGFueW1vcmUuDQo+PiBVc2UgYSBiYWNraW5nIGltYWdlIGlu
c3RlYWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQW50b24gTmVmZWRvdiA8YW50b24ubmVmZWRv
dkB2aXJ0dW96em8uY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2ll
dnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbGJl
cnRvIEdhcmNpYSA8YmVydG9AaWdhbGlhLmNvbT4NCj4gDQo+PiArICAgICAgICByZXQgPSBoYW5k
bGVfYWxsb2Nfc3BhY2UoYnMsIGwybWV0YSk7DQo+IA0KPiBJIGluc2lzdCB0aGF0IGl0IHdvdWxk
IGJlIG5pY2UgdG8gaGF2ZSBhIHNob3J0IGNvbW1lbnQgZXhwbGFpbmluZyB3aGF0DQo+IHRoaXMg
ZG9lcy4NCj4gDQoNClJpZ2h0IHNvcnJ5IGZvcmdvdCB5b3VyIGNvbW1lbnQuDQpJJ2QgZ28gd2l0
aDoNCg0KKyAgICAgICAgLyogVHJ5IHRvIGVmZmljaWVudGx5IGluaXRpYWxpemUgdGhlIHBoeXNp
Y2FsIHNwYWNlIHdpdGggemVyb2VzICovDQogICAgICAgICAgcmV0ID0gaGFuZGxlX2FsbG9jX3Nw
YWNlKGJzLCBsMm1ldGEpOw0KICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQogICAgICAgICAgICAg
IHFlbXVfY29fbXV0ZXhfbG9jaygmcy0+bG9jayk7DQo=

Received: from eggs.gnu.org ([209.51.188.92]:52506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gk2i4-0003Ti-W5
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gk2hz-0005PV-DK
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 03:07:30 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 17 Jan 2019 08:07:14 +0000
Message-ID: <482d5377-e4c3-15e8-fd24-2d29c284e322@virtuozzo.com>
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-19-eblake@redhat.com>
	<0aee5c7f-2503-a927-c4ec-48a93b883d43@virtuozzo.com>
	<0bace5ce-8d59-0996-51b8-39d584729acd@redhat.com>
In-Reply-To: <0bace5ce-8d59-0996-51b8-39d584729acd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <84406DD4A25C4449A8C538566815D7A7@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 18/19] nbd/client: Work around 3.0 bug
 for listing meta contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

MTcuMDEuMjAxOSA2OjIxLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBPbiAxLzE2LzE5IDk6NDMgQU0s
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+IA0KPj4+IEBAIC04MzksOSAr
ODQyLDI1IEBAIHN0YXRpYyBpbnQgbmJkX2xpc3RfbWV0YV9jb250ZXh0cyhRSU9DaGFubmVsICpp
b2MsDQo+Pj4NCj4+PiAgICAgICAgICAgIHJldCA9IG5iZF9yZWNlaXZlX29uZV9tZXRhX2NvbnRl
eHQoaW9jLCBOQkRfT1BUX0xJU1RfTUVUQV9DT05URVhULA0KPj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmY29udGV4dCwgTlVMTCwgZXJycCk7DQo+Pj4g
KyAgICAgICAgaWYgKHJldCA9PSAwICYmIHNlZW5fYW55ICYmICFzZWVuX3FlbXUpIHsNCj4+PiAr
ICAgICAgICAgICAgLyoNCj4+PiArICAgICAgICAgICAgICogV29yayBhcm91bmQgcWVtdSAzLjAg
YnVnOiB0aGUgc2VydmVyIGZvcmdvdCB0byBzZW5kDQo+Pj4gKyAgICAgICAgICAgICAqICJxZW11
OiIgcmVwbGllcyB0byAwIHF1ZXJpZXMuIElmIHdlIHNhdyBhdCBsZWFzdCBvbmUNCj4+PiArICAg
ICAgICAgICAgICogcmVwbHkgKHByb2JhYmx5IGJhc2U6YWxsb2NhdGlvbiksIGJ1dCBub25lIG9m
IHRoZW0gd2VyZQ0KPj4NCj4+IGlmIHdlIGFyZSBzYXlpbmcgYWJvdXQgMy4wLCBpdCBpcyBiYXNl
OmFsbG9jYXRpb24gZm9yIHN1cmUsIGlzbid0IGl0Pw0KPj4NCj4+PiArICAgICAgICAgICAgICog
cWVtdTosIHRoZW4gcnVuIGEgbW9yZSBzcGVjaWZpYyBxdWVyeSB0byBtYWtlIHN1cmUuDQo+IA0K
PiBJZiB0aGUgc2VydmVyIGlzIHFlbXUgMy4wLCB0aGVuIHllcywgaXQgaXMgYmFzZTphbGxvY2F0
aW9uLiBCdXQgaXQgY291bGQNCj4gYmUgc29tZSBvdGhlciBzZXJ2ZXIgdGhhdCBoYXMgaXRzIG93
biBjdXN0b20gcmV0dXJuIHdpdGhvdXQgaW1wbGVtZW50aW5nDQo+IGJhc2U6YWxsb2NhdGlvbi4N
Cg0KSW5kZWVkKSBBbmQgaW4gdGhpcyBjb250ZXh0LCBoZXVyaXN0aWMgYWJvdXQgdGhhdCBzZXJ2
ZXIgc2hvdWxkIGhhdmUgYXQgbGVhc3Qgb25lDQpjb250ZXh0IGxpc3RlZCB3aXRoIG5vIHF1ZXJ5
IHNlZW1zIG5vdCBnZW5lcmljLiBXaHkgbm90IHF1ZXJ5ICdxZW11OicgZXZlbiBpZiBlbXB0eQ0K
cXVlcnkgcmV0dXJucyBub3RoaW5nPyBTbywgYXQgbGVhc3QsICJwcm9iYWJseSIgaXMgaW1iYWxh
bmNlZCB3aXRoIHRoaXMgbm90IGRlc2NyaWJlZA0KaW4gY29tbWVudCBoZXVyaXN0aWMgd2hpY2gg
c2VlbXMgYm91bmQgdG8gMy4wLg0KDQo+IA0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==

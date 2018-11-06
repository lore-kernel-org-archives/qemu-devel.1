Received: from eggs.gnu.org ([2001:4830:134:3::10]:56743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gK49v-0005N1-Cb
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gK49q-00079y-Om
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:24:55 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 6 Nov 2018 16:24:36 +0000
Message-ID: <fc16b42c-5825-b9f8-5127-4c8a6d8b173b@virtuozzo.com>
References: <20181101182738.70462-1-vsementsov@virtuozzo.com>
	<20181101182738.70462-7-vsementsov@virtuozzo.com>
	<w514lcudz3y.fsf@maestria.local.igalia.com>
	<e1d4fa92-9f84-080c-04e3-4fc9b683c11d@virtuozzo.com>
	<w511s7ydxzz.fsf@maestria.local.igalia.com>
In-Reply-To: <w511s7ydxzz.fsf@maestria.local.igalia.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <30F03B2E8B99C84985CB6E70F7C7BECB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 6/7] qcow2: aio support for
 compressed cluster read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>

MDYuMTEuMjAxOCAxODozMCwgQWxiZXJ0byBHYXJjaWEgd3JvdGU6DQo+IE9uIFR1ZSAwNiBOb3Yg
MjAxOCAwNDoxMzo1OCBQTSBDRVQsIFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6
DQo+PiAwNi4xMS4yMDE4IDE4OjA2LCBBbGJlcnRvIEdhcmNpYSB3cm90ZToNCj4+PiBPbiBUaHUg
MDEgTm92IDIwMTggMDc6Mjc6MzcgUE0gQ0VULCBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5
IHdyb3RlOg0KPj4+DQo+Pj4+ICsgICAgYnVmID0gZ190cnlfbWFsbG9jKGNzaXplKTsNCj4+Pj4g
KyAgICBpZiAoIWJ1Zikgew0KPj4+PiArICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+Pj4gKyAg
ICB9DQo+Pj4+ICsgICAgaW92Lmlvdl9iYXNlID0gYnVmOw0KPj4+PiArICAgIGlvdi5pb3ZfbGVu
ID0gY3NpemU7DQo+Pj4+ICsgICAgcWVtdV9pb3ZlY19pbml0X2V4dGVybmFsKCZsb2NhbF9xaW92
LCAmaW92LCAxKTsNCj4+Pj4gICAgDQo+Pj4+IC0gICAgICAgIGlvdi5pb3ZfYmFzZSA9IHMtPmNs
dXN0ZXJfZGF0YTsNCj4+Pj4gLSAgICAgICAgaW92Lmlvdl9sZW4gPSBjc2l6ZTsNCj4+Pj4gLSAg
ICAgICAgcWVtdV9pb3ZlY19pbml0X2V4dGVybmFsKCZsb2NhbF9xaW92LCAmaW92LCAxKTsNCj4+
Pj4gKyAgICBvdXRfYnVmID0gcWVtdV9ibG9ja2FsaWduKGJzLCBzLT5jbHVzdGVyX3NpemUpOw0K
Pj4+IFlvdSBzaG91bGQgYWxzbyBjaGVjayB3aGV0aGVyIG91dF9idWYgaXMgTlVMTCwgc2hvdWxk
bid0IHlvdT8NCj4+IE5vLCBpdCB3aWxsIGFib3J0IG9uIGZhaWwuIHFlbXVfdHJ5X2Jsb2NrYWxp
Z24gcmVzdWx0IHNob3VsZCBiZQ0KPj4gY2hlY2tlZC4NCj4gSXMgdGhlcmUgYW55IHJlYXNvbiB3
aHkgc29tZSBwYXJ0cyBvZiB0aGUgUUVNVSBjb2RlIHVzZSBxZW11X2Jsb2NrYWxpZ24NCj4gYW5k
IG90aGVycyBxZW11X3RyeV9ibG9ja2FsaWduKCkgPyBGcm9tIHdoYXQgSSBjYW4gc2VlIGl0IHNl
ZW1zIHRvIGJlIHVwDQo+IHRvIHdob2V2ZXIgd3JvdGUgaXQuLi4NCj4NCj4gQmVydG8NCg0KQXMg
SSB1bmRlcnN0YW5kLCB0aGUgZ29vZCByZWFzb24gdG8gdXNlIF90cnlfIHZlcnNpb25zLCBpcyB3
aGVuIHdlIGFyZSANCmFsbG9jYXRpbmcgc29tZSBzaXplLCB0YWtlbiBmcm9tIHVzZXIgaW5wdXQs
IHNvIGl0IG1heSBiZSB1bnByZWRpY3RhYmxlIA0KbGFyZ2UgKGhtLCBvciBqdXN0IGFueSByZWFs
bHkgbGFyZ2UgYWxsb2NhdGlvbiksIHNvLCBJIHVzZSB0cnlfbWFsbG9jIA0KZm9yIGNvbXByZXNz
ZWQgc2l6ZSwgd2hpY2ggbWF5IGJlIHZlcnkgbGFyZ2UgaW4gc29tZWhvdyBjb3JydXB0ZWQgaW1h
Z2UuIA0KQW5kIGl0IGxvb2tzIGEgY29tbW9uIHByYWN0aWNlIHRvIHVzZSBub3QtZmFpbGluZyAo
YWJvcnRpbmcpIGFsbG9jYXRpb24gDQpmdW5jdGlvbnMgZm9yIGNsdXN0ZXJfc2l6ZSBhbGxvY2F0
aW9ucyBpbiBxY293Mi5jDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg0K

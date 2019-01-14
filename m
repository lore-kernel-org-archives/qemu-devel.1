Received: from eggs.gnu.org ([209.51.188.92]:52647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gixZQ-0001KS-Ls
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 03:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gixZQ-0000MY-01
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 03:26:08 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 14 Jan 2019 08:25:57 +0000
Message-ID: <e96bdd9f-a470-8b12-0c27-275a608c4244@virtuozzo.com>
References: <20190111194720.15671-1-eblake@redhat.com>
	<20190111194720.15671-2-eblake@redhat.com>
In-Reply-To: <20190111194720.15671-2-eblake@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF0645808990BA4D8FEFA8A4A752DA35@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 1/8] nbd: Add some error case testing to
 iotests 223
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

MTEuMDEuMjAxOSAyMjo0NywgRXJpYyBCbGFrZSB3cm90ZToNCj4gVGVzdGluZyBzdWNjZXNzIHBh
dGhzIGlzIGltcG9ydGFudCwgYnV0IGl0J3MgYWxzbyBuaWNlIHRvIGhpZ2hsaWdodA0KPiBleHBl
Y3RlZCBmYWlsdXJlIGhhbmRsaW5nLCB0byBzaG93IHRoYXQgd2UgZG9uJ3QgY3Jhc2gsIGFuZCBz
byB0aGF0DQo+IHVwY29taW5nIHRlc3RzIHRoYXQgY2hhbmdlIGJlaGF2aW9yIGNhbiBkZW1vbnN0
cmF0ZSB0aGUgcmVzdWx0aW5nDQo+IGVmZmVjdHMgb24gZXJyb3IgcGF0aHMuDQo+IA0KPiBBZGQg
dGhlIGZvbGxvd2luZyBlcnJvcnM6DQo+IEF0dGVtcHRpbmcgdG8gZXhwb3J0IHdpdGhvdXQgYSBy
dW5uaW5nIHNlcnZlcg0KPiBBdHRlbXB0aW5nIHRvIHN0YXJ0IGEgc2Vjb25kIHNlcnZlcg0KPiBB
dHRlbXB0aW5nIHRvIGV4cG9ydCBhIGJhZCBub2RlIG5hbWUNCj4gQXR0ZW1wdGluZyB0byBleHBv
cnQgYSBuYW1lIHRoYXQgaXMgYWxyZWFkeSBleHBvcnRlZA0KPiBBdHRlbXB0aW5nIHRvIGV4cG9y
dCBhbiBlbmFibGVkIGJpdG1hcA0KPiBBdHRlbXB0aW5nIHRvIGNsZWFuIGFuIGFscmVhZHkgY2xl
YW5lZCBleHBvcnQNCg0KRm9yIG1lICJjbGVhbiIgc291bmRzIG5vdCB0aGUgc2FtZSBhcyAicmVt
b3ZlIiAoSSB1c2VkIHRvIHRoZSB0aG91Z2h0IHRoYXQNCnJlbW92ZSBtZWFucyB0byByZW1vdmUg
b2JqZWN0IGZyb20gbGFyZ2VyIG9iamVjdCwgYW5kIGNsZWFuIGlzIGNsZWFuIHRoZQ0Kb2JqZWN0
IGludGVybmFsbHkgKHJlbW92ZSBpdHMgY29udGVudD8pLCBidXQgaXQgY29udGludWVzIHRvIGV4
aXN0IGFuZCBhbGwNCml0cyByZWxhdGlvbnMgd2l0aCBwYXJlbnRzIGFyZSBub3QgdG91Y2hlZCks
IGJ1dCBJJ20gcmVhbGx5IGZhciBmcm9tIGJlaW5nDQphbiBleHBlcnQgaW4gRW5nbGlzaC4NCg0K
PiBBdHRlbXB0aW5nIHRvIHF1aXQgc2VydmVyIGEgc2Vjb25kIHRpbWUNCj4gDQo+IEFsbCBvZiB0
aGVzZSBwcm9wZXJseSBjb21wbGFpbiBleGNlcHQgZm9yIGEgc2Vjb25kIHNlcnZlci1zdG9wLA0K
PiB3aGljaCB3aWxsIGJlIGZpeGVkIG5leHQuDQoNCmhtLCBsb29rcyBhIGJpdCBzdHJhbmdlIHRv
IGFkZCB0ZXN0IGZpcnN0IGFuZCB0aGVuIGZpeCBidWcsIGJ1dCBvbiB0aGUNCm90aGVyIGhhbmQg
aXQncyBtb3JlIGRlbW9uc3RyYXRpdmUsIE9LIGZvciBtZS4NCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogRXJpYyBCbGFrZSA8ZWJsYWtlQHJlZGhhdC5jb20+DQoNCg0KUmV2aWV3ZWQtYnk6IFZsYWRp
bWlyIFNlbWVudHNvdi1PZ2lldnNraXkgPHZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbT4NCg0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

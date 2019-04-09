Received: from eggs.gnu.org ([209.51.188.92]:59513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDqeJ-0007Lh-8E
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hDqeI-0008Jc-7y
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 09:18:51 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Tue, 9 Apr 2019 13:18:43 +0000
Message-ID: <105c6869-c2a7-bb3c-3c73-b06fd5280813@virtuozzo.com>
References: <1551346019-293202-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1c64f75a-d379-980f-aab9-d4ce75c1144b@redhat.com>
In-Reply-To: <1c64f75a-d379-980f-aab9-d4ce75c1144b@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <88720ACCE045634AAB0DBC73409A7B9F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] qcow2: discard bitmap when removed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

DQoNCk9uIDA4LzA0LzIwMTkgMjI6MDMsIE1heCBSZWl0eiB3cm90ZToNCj4gT24gMjguMDIuMTkg
MTA6MjYsIEFuZHJleSBTaGlua2V2aWNoIHdyb3RlOg0KPj4gV2hlbiBhIGJpdG1hcCBpcyByZW1v
dmVkLCB3ZSBjYW4gY2xlYW4gc29tZSBzcGFjZSBvbiB0aGUgZGlzay4gVGhlIHNpemUNCj4+IG9m
IGEgY2x1c3RlciBtYXkgYmUgbGFyZ2VyLCBzbyBpcyB0aGUgc2l6ZSBvZiB0aGUgYml0bWFwIHRo
YXQgaW5jbHVkZXMNCj4+IG1hbnkgY2x1c3RlcnMuIFNvbWUgYml0bWFwcyBjYW4gYmUgYXMgbGFy
Z2UgYXMgdGVucyBvZiBtZWdhYnl0ZXMuDQo+PiBUaGUgZmxhZyBRQ09XMl9ESVNDQVJEX0FMV0FZ
UyBhbGxvd3MgYSBjYWxsIHRvIHRoZSByYXdfY29fcGRpc2NhcmQoKQ0KPj4gdGhhdCBkb2VzIHRo
ZSBhY3R1YWwgY2xlYW5pbmcgb2YgdGhlIGltYWdlIG9uIGRpc2ssIHdoaWxlIHdpdGggdGhlIGZs
YWcNCj4+IFFDT1cyX0RJU0NBUkRfT1RIRVIsIGEgcmVmZXJlbmNlIGNvdW50IG9mIHRoZSBjbHVz
dGVyIGlzIHVwZGF0ZWQgb25seS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkgU2hpbmtl
dmljaCA8YW5kcmV5LnNoaW5rZXZpY2hAdmlydHVvenpvLmNvbT4NCj4+IC0tLQ0KPj4gdjE6IERp
c2NhcmQgb2xkIGJpdG1hcCBkaXJlY3RvcmllcyBpbiBRQ09XMiBpbWFnZQ0KPj4NCj4+IEluIHRo
ZSBmaXJzdCB2ZXJzaW9uIG9mIHRoZSBwYXRjaCwgYW55IGNhbGwgdG8gcWNvdzJfZnJlZV9jbHVz
dGVycygpIGluDQo+PiBibG9jay9xY293Mi1iaXRtYXAuYyB3YXMgd2l0aCB0aGUgZmxhZyBRQ09X
Ml9ESVNDQVJEX0FMV0FZUywgZXZlbiBpbiB0aGUNCj4+IGNhc2VzIHdoZW4gdGhlIGNsZWFuZWQg
c3BhY2UgaXMgaW5zaWduaWZpY2FudCwgcGFydGljdWxhcmx5LCBpbiBjYXNlIG9mDQo+PiBiaXRt
YXAgZGlyZWN0b3JpZXMuDQo+PiBEaXNjdXNzZWQgaW4gdGhlIGVtYWlsIHRocmVhZCB3aXRoIHRo
ZSBtZXNzYWdlIElEDQo+PiA8MTU0OTk3NDk1MS03MzEyODUtMS1naXQtc2VuZC1lbWFpbC1hbmRy
ZXkuc2hpbmtldmljaEB2aXJ0dW96em8uY29tPg0KPj4NCj4+ICAgYmxvY2svcWNvdzItYml0bWFw
LmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQ0KPiANCj4gVGhhbmtzLCBjaGFuZ2VkIHRoZSBjb21taXQgbWVzc2FnZSB0byBWbGFkaW1p
cuKAmXMgcHJvcG9zYWwgYW5kIGFwcGxpZWQgdG8NCj4gbXkgYmxvY2stbmV4dCBicmFuY2g6DQo+
IA0KPiBodHRwczovL2dpdC54YW5jbGljLm1vZS9YYW5DbGljL3FlbXUvY29tbWl0cy9icmFuY2gv
YmxvY2stbmV4dA0KPiANCj4gTWF4DQo+IA0KDQpUaGFuayB5b3UsIE1heCENCi0tIA0KV2l0aCB0
aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg0K

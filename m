Received: from eggs.gnu.org ([209.51.188.92]:46699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvmS6-0000I6-F1
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:11:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gvmS5-0006e4-Lx
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:11:34 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 18 Feb 2019 17:11:27 +0000
Message-ID: <3b02bf4c-f6ce-5767-d456-82b6a1111007@virtuozzo.com>
References: <20190213232356.21034-1-jsnow@redhat.com>
	<20190213232356.21034-3-jsnow@redhat.com>
	<b0847f1f-c142-0c35-f04a-7436f840af25@virtuozzo.com>
In-Reply-To: <b0847f1f-c142-0c35-f04a-7436f840af25@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CE269D76342024CB94424DE668F6B9F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/6] block/dirty-bitmaps: rename frozen
 predicate helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, "libvir-list@redhat.com" <libvir-list@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

MTguMDIuMjAxOSAxNjo1NywgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4g
MTQuMDIuMjAxOSAyOjIzLCBKb2huIFNub3cgd3JvdGU6DQo+PiAiRnJvemVuIiB3YXMgYSBnb29k
IGRlc2NyaXB0aW9uIGEgbG9uZyB0aW1lIGFnbywgYnV0IGl0IGlzbid0IGFkZXF1YXRlIG5vdy4N
Cj4+IFJlbmFtZSB0aGUgZnJvemVuIHByZWRpY2F0ZSB0byBoYXNfc3VjY2Vzc29yIHRvIG1ha2Ug
dGhlIHNlbWFudGljcyBvZiB0aGUNCj4+IHByZWRpY2F0ZSBtb3JlIGNsZWFyIHRvIG91dHNpZGUg
Y2FsbGVycy4NCj4+DQo+PiBJbiB0aGUgcHJvY2VzcywgcmVtb3ZlIHNvbWUgY2FsbHMgdG8gZnJv
emVuKCkgdGhhdCBubyBsb25nZXIgc2VtYW50aWNhbGx5DQo+PiBtYWtlIHNlbnNlLiBGb3IgZW5h
YmxlZCBhbmQgZGlzYWJsZWQgaW4gcGFydGljdWxhciwgaXQncyBhY3R1YWxseSBva2F5IGZvcg0K
Pj4gdGhlIGludGVybmFscyB0byBkbyB0aGlzIGJ1dCBvbmx5IGZvcmJpZGRlbiBmb3IgdXNlcnMg
dG8gaW52b2tlIHRoZW0sIGFuZA0KPiANCj4gSSdtIGEgYml0IGxvc3QgaW4gdGhpcyBwYXJhZ3Jh
cGguLiB0byB0aGlzIC0gd2hhdD8sIHRvIGludm9rZSB0aGVtIC0gd2hvbT8NCj4gSSB0aGluaywg
aXQgd291bGQgYmUgc2ltcGxlciBmb3IgbWUgdG8gcmVhZCBwYXRjaCBpdHNlbGYgOikNCj4gDQo+
PiBhbGwgb2YgdGhlIFFNUCBlbnRyeSB1c2VzIGFscmVhZHkgY2hlY2sgYWdhaW5zdCBxbXBfbG9j
a2VkLg0KPj4NCj4+IFNldmVyYWwgb3RoZXIgYXNzZXJ0aW9ucyByZWFsbHkgd2FudCB0byBjaGVj
ayB0aGF0IHRoZSBiaXRtYXAgaXNuJ3QgaW4tdXNlDQo+PiBieSBhbm90aGVyIG9wZXJhdGlvbiAt
LSB1c2UgdGhlIHFtcF9sb2NrZWQgZnVuY3Rpb24gZm9yIHRoaXMgaW5zdGVhZCwgd2hpY2gNCj4+
IHByZXNlbnRseSBhbHNvIGNoZWNrcyBmb3IgaGFzX3N1Y2Nlc3Nvci4NCj4gDQo+IGhtLCB5b3Ug
bWVhbiB1c2VyX2xvY2tlZCwgbm90IHFtcF9sb2NrZWQuDQo+IA0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEpvaG4gU25vdyA8anNub3dAcmVkaGF0LmNvbT4NCj4+IC0tLQ0KPj4gwqAgYmxvY2svZGly
dHktYml0bWFwLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMyICsrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tDQo+PiDCoCBpbmNsdWRlL2Jsb2NrL2RpcnR5LWJpdG1hcC5owqDCoCB8wqAg
MiArLQ0KPj4gwqAgbWlncmF0aW9uL2Jsb2NrLWRpcnR5LWJpdG1hcC5jIHzCoCAyICstDQo+PiDC
oCAzIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDE3IGRlbGV0aW9ucygtKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9ibG9jay9kaXJ0eS1iaXRtYXAuYyBiL2Jsb2NrL2RpcnR5LWJpdG1h
cC5jDQo+PiBpbmRleCAxMDEzODNiM2FmLi42MzllYmMwNjQ1IDEwMDY0NA0KPj4gLS0tIGEvYmxv
Y2svZGlydHktYml0bWFwLmMNCj4+ICsrKyBiL2Jsb2NrL2RpcnR5LWJpdG1hcC5jDQo+PiBAQCAt
NTAsNyArNTAsNyBAQCBzdHJ1Y3QgQmRydkRpcnR5Qml0bWFwIHsNCj4+IMKgwqDCoMKgwqAgSEJp
dG1hcCAqbWV0YTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBNZXRhIGRpcnR5IGJpdG1h
cCAqLw0KPj4gwqDCoMKgwqDCoCBib29sIHFtcF9sb2NrZWQ7wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAvKiBCaXRtYXAgaXMgbG9ja2VkLCBpdCBjYW4ndCBiZSBtb2RpZmllZA0KPj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHRocm91Z2ggUU1QICovDQo+PiAtwqDCoMKgIEJkcnZEaXJ0eUJpdG1hcCAqc3VjY2Vz
c29yOyAvKiBBbm9ueW1vdXMgY2hpbGQ7IGltcGxpZXMgZnJvemVuIHN0YXR1cyAqLw0KPj4gK8Kg
wqDCoCBCZHJ2RGlydHlCaXRtYXAgKnN1Y2Nlc3NvcjsgLyogQW5vbnltb3VzIGNoaWxkOyBpbXBs
aWVzIHVzZXJfbG9ja2VkIHN0YXRlICovDQo+IA0KPiBhaGEsIGxvb2tzIGxpa2UgYSBnb29kIG1v
bWVudCB0byBmaXggcHJlZXhpc3RpbmcgbWlzYWxpZ25tZW50IG9mIHRoZSBjb21tZW50LA0KPiBi
dXQgbmV3IGxpbmUgaXMgZXhhY3RseSA4MCBjaGFyYWN0ZXJzIGxlbmd0aCwgc28sIG5vdCBhIGdv
b2QgbW9tZW50KQ0KDQphbmQgdGhlcmUgd2FzIG5vIGFueSBtaXNhbGlnbm1lbnQsIG9ubHkgdGh1
bmRlcmJpcmQgYnVnLi4uDQoNCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

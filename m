Received: from eggs.gnu.org ([209.51.188.92]:38355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1Z9k-00068q-G8
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1h1Z9i-0003Do-Da
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:12:32 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 6 Mar 2019 16:12:13 +0000
Message-ID: <d362b81a-1e9c-0761-3cbe-65739a051ce7@virtuozzo.com>
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-3-jsnow@redhat.com>
	<28d6183a-f654-de55-36ed-ee0bafb47739@redhat.com>
	<fe8ae9ab-068d-cc24-76de-e2a99215ea5f@redhat.com>
In-Reply-To: <fe8ae9ab-068d-cc24-76de-e2a99215ea5f@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CB973945F7AC146A4F41DB68D5384DE@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 2/5] block/qcow2-bitmap: Allow bitmap
 flushing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

MDYuMDMuMjAxOSAxODo1OSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDMvNi8xOSA3
OjU4IEFNLCBFcmljIEJsYWtlIHdyb3RlOg0KPj4gT24gMy81LzE5IDU6NDMgUE0sIEpvaG4gU25v
dyB3cm90ZToNCj4+PiBVc3VhbGx5LCB3ZSBvbmx5IHdyaXRlIG91dCBiaXRtYXBzIHdoZW4gd2Un
cmUgYWJvdXQgdG8gY2xvc2Ugb3V0IHRoZSBmaWxlLA0KPj4+IHNvIHdlIGFsd2F5cyByZW1vdmUg
dGhlIGJpdG1hcHMgYWZ0ZXIgdG8gbWFrZSBpdCBlYXNpZXIgdG8gZGV0ZXJtaW5lIHRoZQ0KPj4+
IHNvdXJjZSBvZiB0cnV0aCBmb3IgbWlncmF0aW9uIHB1cnBvc2VzLg0KPj4+DQo+Pj4gSG93ZXZl
ciwgdGhlcmUgbWF5IGJlIHRpbWVzIHdlIHdhbnQgdG8gZmx1c2ggYml0bWFwIGRhdGEgbW9yZSBh
Z2dyZXNzaXZlbHksDQo+Pj4gbGlrZSBhZnRlciBhIHRydW5jYXRlIGV2ZW50IHdoZXJlIHdlIG5l
ZWQgdG8gbWFrZSB0aGUgbWV0YWRhdGEgY29uc2lzdGVudA0KPj4+IGFnYWluLg0KPj4NCj4+IE9y
LCBhcyBJJ3ZlIG1lbnRpb25lZCBpbiBvdGhlciB0aHJlYWRzLCBhZnRlciBldmVyeQ0KPj4gYml0
bWFwLWFkZC9iaXRtYXAtZGVsZXRlIG9wZXJhdGlvbiwgc28gdGhhdCAncWVtdS1pbWcgaW5mbyAt
VScgY2FuIHNlZQ0KPj4gd2hpY2ggcGVyc2lzdGVudCBiaXRtYXBzIGV4aXN0LiBCdXQgdGhhdCdz
IG9uZSBzdGVwIGZ1cnRoZXIgdGhhbiB0aGlzDQo+PiBzZXJpZXMsIHNvIEkgd29uJ3QgaW5zaXN0
IG9uIGl0IHRvZGF5Lg0KPj4NCj4gDQo+IFllcywgSSB3YXMga2VlcGluZyB0aGF0IGluIG1pbmQg
YXMgSSB3cm90ZSB0aGlzLiBJIHRoaW5rIGl0IGV4dGVuZHMgdG8NCj4gdGhvc2UgY2FzZXMgdHJp
dmlhbGx5LCBzbyBsb25nIGFzIFZsYWRpbWlyIGlzIE9LIHdpdGggd2hhdCBJJ20gdHJ5aW5nIHRv
IGRvLg0KPiANCg0KSSBzdGlsbCBkb24ndCBzZWUgdGhlIHBvaW50IG9mIGZsdXNoaW5nIGJpdG1h
cHMsIHRoZSBvbmx5IHRoaW5nIGlzIG9wdGltaXppbmcNCnFlbXUtaW1nIGluZm8gLS1mb3JjZS1z
aGFyZSwgd2hpY2ggc2hvdWxkIG5ldmVyIHVzZWQgZXhjZXB0IGZvciBkZWJ1Z2dpbmcuDQoNClNv
LCBhdCBsZWFzdCwgaWYgd2UnbGwgaGF2ZSBpdCwgSSdkIHByZWZlciBiaXRtYXAgZmx1c2hpbmcg
dG8gYmUgb3B0aW9uYWwsDQphbmQgb3RoZXIgY29kZSBzaG91bGQgbm90IHJlbHkgb24gaXQuDQoN
Cg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K

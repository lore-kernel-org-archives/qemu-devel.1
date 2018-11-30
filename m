Received: from eggs.gnu.org ([2001:4830:134:3::10]:54950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSkeU-0003KB-KK
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:24:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSkeT-000163-QS
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:24:22 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Nov 2018 15:24:12 +0000
Message-ID: <8a2d8bc5-1144-9b20-c80c-934a9c732e2c@virtuozzo.com>
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-3-vsementsov@virtuozzo.com>
	<2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
	<e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
	<abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
	<73cb2885-3a40-6d2b-24fa-c528decdbc9b@virtuozzo.com>
	<20181130141017.GF5106@localhost.localdomain>
	<97939091-38e2-565b-7aa3-cfb9ebf239cb@virtuozzo.com>
	<e6a8ba59-4871-35f4-88a4-43567997e3bc@redhat.com>
In-Reply-To: <e6a8ba59-4871-35f4-88a4-43567997e3bc@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A701DC7FF4704E4F88694800EBF88ED6@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: simple mirror test with
 kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jcody@redhat.com" <jcody@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

MzAuMTEuMjAxOCAxNzo1OSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAzMC4xMS4xOCAxNTo1MSwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDMwLjExLjIwMTggMTc6MTAs
IEtldmluIFdvbGYgd3JvdGU6DQo+Pj4gQW0gMzAuMTEuMjAxOCB1bSAxNDo0OCBoYXQgVmxhZGlt
aXIgU2VtZW50c292LU9naWV2c2tpeSBnZXNjaHJpZWJlbjoNCj4+Pj4gMzAuMTEuMjAxOCAxNjox
MywgTWF4IFJlaXR6IHdyb3RlOg0KPj4+Pj4gT24gMzAuMTEuMTggMTQ6MDYsIFZsYWRpbWlyIFNl
bWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQo+Pj4+Pj4gMzAuMTEuMjAxOCAxNTozMCwgTWF4IFJl
aXR6IHdyb3RlOg0KPj4+Pj4+PiBPbiAyOS4xMS4xOCAxMToxOCwgVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+Pj4+IFRoaXMgdGVzdCBpcyBicm9rZW4gd2l0aG91dCBw
cmV2aW91cyBjb21taXQgZml4aW5nIGRlYWQtbG9jayBpbiBtaXJyb3IuDQo+Pj4+Pj4+Pg0KPj4+
Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeTx2c2VtZW50
c292QHZpcnR1b3p6by5jb20+DQo+Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+ICAgICAgdGVzdHMvcWVt
dS1pb3Rlc3RzLzIzNSAgICAgfCA1OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPj4+Pj4+Pj4gICAgICB0ZXN0cy9xZW11LWlvdGVzdHMvMjM1Lm91dCB8ICAxICsNCj4+
Pj4+Pj4+ICAgICAgdGVzdHMvcWVtdS1pb3Rlc3RzL2dyb3VwICAgfCAgMSArDQo+Pj4+Pj4+PiAg
ICAgIDMgZmlsZXMgY2hhbmdlZCwgNjEgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4+Pj4gICAgICBjcmVh
dGUgbW9kZSAxMDA3NTUgdGVzdHMvcWVtdS1pb3Rlc3RzLzIzNQ0KPj4+Pj4+Pj4gICAgICBjcmVh
dGUgbW9kZSAxMDA2NDQgdGVzdHMvcWVtdS1pb3Rlc3RzLzIzNS5vdXQNCj4+Pj4+Pj4gSSdsbCBn
ZXQgdG8gdGhlIGZpcnN0IHBhdGNoIGluIGEgc2Vjb25kLCBidXQgZmlyc3QgYSBzdWdnZXN0aW9u
IGZvciB0aGlzDQo+Pj4+Pj4+IHBhdGNoOiBJIHRoaW5rIGl0J3Mgbm90IHNvIGdvb2QgdG8gdXNl
IDIgR0Igb2Ygc3BhY2UgZm9yIGEgdGVzdCAoMSBHQg0KPj4+Pj4+PiBmb3IgdGhlIHNvdXJjZSwg
MSBHQiBmb3IgdGhlIHRhcmdldCkuICBTbyBJIHRyaWVkIG15IGx1Y2sgYW5kIGZvdW5kIHRoYXQN
Cj4+Pj4+Pj4gdGhlIHRlc3Qgd29ya3MsIHRvbywgaWYgeW91IGp1c3QgdXNlIHByZWFsbG9jYXRp
b249bWV0YWRhdGEgZm9yIHRoZQ0KPj4+Pj4+PiBzb3VyY2UgKGluc3RlYWQgb2YgYWN0dWFsbHkg
d3JpdGluZyBkYXRhKSBhbmQgYmxvY2tkZXYtbWlycm9yJ2luZyB0aGUNCj4+Pj4+Pj4gZGF0YSB0
byBhIHRocm90dGxlZCBudWxsLWNvIGRldmljZS4NCj4+Pj4+Pg0KPj4+Pj4+IEhtbSwgc28gcGFy
c2luZyBtZXRhZGF0YSBpcyBlbm91Z2ggZm9yIHFjb3cyIHRvIHlpZWxkIG9uIHdyaXRlLCB5ZXM/
DQo+Pj4+Pg0KPj4+Pj4gQXBwYXJlbnRseSBzby4gIElmIHlvdSBjYW4gY29uZmlybSB0aGF0IGFw
cGx5aW5nIHRob3NlIGNoYW5nZXMgdG8gdGhlDQo+Pj4+PiB0ZXN0IHN0aWxsIG1ha2UgaXQgd29y
ayAoaS5lLiwgZmFpbCBiZWZvcmUgcGF0Y2ggMSwgcGFzcyBhZnRlcndhcmRzKSwNCj4+Pj4+IHRo
ZW4gSSB0aGluayBpdCBpcyBqdXN0IGFzIGdvb2QuDQo+Pj4+DQo+Pj4+IE9rLCBJJ3ZlIGNoZWNr
ZWQgdGhhdCB5b3VyIGNoYW5nZXMgd29ya3MgZm9yIG1lLg0KPj4+Pg0KPj4+PiBobSwgYnV0IHdl
IHdyaXRlIHRvIG51bGwsIHNvLCB5aWVsZCBvbiB3cml0ZSBjb21lcyBmcm9tIHRocm90dGxpbmcs
IGhvd2V2ZXIsDQo+Pj4+IHdpdGhvdXQgcHJlYWxsb2NhdGlvbj1tZXRhZGF0YSwgaXQgZG9uJ3Qg
d29yay4uLCBkbyB5b3Uga25vdywgd2h5IHdlIG5lZWQNCj4+Pj4gcHJlYWxsb2NhdGlvbiB0byBy
ZXByb2R1Y2U/DQo+Pj4NCj4+PiBJZiBJIHNob3VsZCB0YWtlIGEgZ3Vlc3MsIHByb2JhYmx5IGJl
Y2F1c2UgbWlycm9yIG9ubHkgY29waWVzIGFsbG9jYXRlZA0KPj4+IGNsdXN0ZXJzPw0KPj4+DQo+
Pj4gS2V2aW4NCj4+Pg0KPj4NCj4+IGhtLCBzbywgd2hhdCBwcmVhbGxvY2F0aW9uPW1ldGFkYXRh
IGRvZXM/IEkgdGhvdWdodCwgaXQgcHJlYWxsb2NhdGVzIHRhYmxlcywgYnV0IGFsbCBxY293MiBj
bHVzdGVycyB3b3VsZCBiZSB1bmFsbG9jYXRlZC4uDQo+IA0KPiBObywgaXQgaW5pdGlhbGl6ZXMg
YWxsIG1ldGFkYXRhIHN0cnVjdHVyZXMgKGkuZS4sIEwyIHRhYmxlcykgc28gdGhleQ0KPiBwb2lu
dCB0byBkYXRhIGNsdXN0ZXJzOyB3aGljaCBpcyB3aHkgeW91IGNhbm5vdCB1c2UgaXQgd2l0aCBi
YWNraW5nDQo+IGZpbGVzLiAgSXQncyBqdXN0IHRoYXQgdGhlIGRhdGEgY2x1c3RlcnMgYXJlIG5v
dCB3cml0dGVuLg0KDQpzbywgY2x1c3RlcnMgYXJlIGFsbG9jYXRlZD8gaW4gdGhpcyBjYXNlLCB3
ZSBkb24ndCBhdm9pZCBhbGxvY2F0aW5nIG9mIDFHLCBidXQgb25seSBoYXZlIGEgcGVyZm9ybWFu
Y2UgZ2Fpbj8NCg0KPiANCj4gSXQgbWlnaHQgbWFrZSBzZW5zZSB0byB1c2UgcHJlYWxsb2NhdGVk
IHplcm8gY2x1c3RlcnMgaW4gcWNvdzIgdjM7IGJ1dA0KPiB0aGVuIHdyaXRpbmcgdG8gdGhlIGlt
YWdlIHdvdWxkIGNhdXNlIENPV3MgYWdhaW4sIHNvIHRoZXJlIHdvdWxkbid0IGJlDQo+IHRvbyBt
dWNoIGJlbmVmaXQgb3ZlciBqdXN0IG5vdCBwcmVhbGxvY2F0aW5nLg0KPiANCj4gTWF4DQo+IA0K
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

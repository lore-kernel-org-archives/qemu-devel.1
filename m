Received: from eggs.gnu.org ([2001:4830:134:3::10]:45387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSlR6-0003v8-SZ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gSlR5-0007fN-GW
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 11:14:36 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 30 Nov 2018 16:14:23 +0000
Message-ID: <d7eb30d3-1bfa-fc1f-4653-06badc435a80@virtuozzo.com>
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-3-vsementsov@virtuozzo.com>
	<2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
	<e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
	<abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
	<73cb2885-3a40-6d2b-24fa-c528decdbc9b@virtuozzo.com>
	<20181130141017.GF5106@localhost.localdomain>
	<97939091-38e2-565b-7aa3-cfb9ebf239cb@virtuozzo.com>
	<e6a8ba59-4871-35f4-88a4-43567997e3bc@redhat.com>
	<8a2d8bc5-1144-9b20-c80c-934a9c732e2c@virtuozzo.com>
	<a8113670-91d6-4c6b-fe1c-d124e5015f36@redhat.com>
In-Reply-To: <a8113670-91d6-4c6b-fe1c-d124e5015f36@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B17E0814F38304788F926FBC176016A@eurprd08.prod.outlook.com>
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

MzAuMTEuMjAxOCAxODozMywgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAzMC4xMS4xOCAxNjoyNCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDMwLjExLjIwMTggMTc6NTks
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAzMC4xMS4xOCAxNTo1MSwgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gMzAuMTEuMjAxOCAxNzoxMCwgS2V2aW4gV29sZiB3
cm90ZToNCj4+Pj4+IEFtIDMwLjExLjIwMTggdW0gMTQ6NDggaGF0IFZsYWRpbWlyIFNlbWVudHNv
di1PZ2lldnNraXkgZ2VzY2hyaWViZW46DQo+Pj4+Pj4gMzAuMTEuMjAxOCAxNjoxMywgTWF4IFJl
aXR6IHdyb3RlOg0KPj4+Pj4+PiBPbiAzMC4xMS4xOCAxNDowNiwgVmxhZGltaXIgU2VtZW50c292
LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4+Pj4+IDMwLjExLjIwMTggMTU6MzAsIE1heCBSZWl0eiB3
cm90ZToNCj4+Pj4+Pj4+PiBPbiAyOS4xMS4xOCAxMToxOCwgVmxhZGltaXIgU2VtZW50c292LU9n
aWV2c2tpeSB3cm90ZToNCj4+Pj4+Pj4+Pj4gVGhpcyB0ZXN0IGlzIGJyb2tlbiB3aXRob3V0IHBy
ZXZpb3VzIGNvbW1pdCBmaXhpbmcgZGVhZC1sb2NrIGluIG1pcnJvci4NCj4+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeTx2c2Vt
ZW50c292QHZpcnR1b3p6by5jb20+DQo+Pj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4+PiAgICAgICB0
ZXN0cy9xZW11LWlvdGVzdHMvMjM1ICAgICB8IDU5ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+Pj4+Pj4+Pj4+ICAgICAgIHRlc3RzL3FlbXUtaW90ZXN0cy8yMzUub3V0
IHwgIDEgKw0KPj4+Pj4+Pj4+PiAgICAgICB0ZXN0cy9xZW11LWlvdGVzdHMvZ3JvdXAgICB8ICAx
ICsNCj4+Pj4+Pj4+Pj4gICAgICAgMyBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspDQo+
Pj4+Pj4+Pj4+ICAgICAgIGNyZWF0ZSBtb2RlIDEwMDc1NSB0ZXN0cy9xZW11LWlvdGVzdHMvMjM1
DQo+Pj4+Pj4+Pj4+ICAgICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy9xZW11LWlvdGVzdHMv
MjM1Lm91dA0KPj4+Pj4+Pj4+IEknbGwgZ2V0IHRvIHRoZSBmaXJzdCBwYXRjaCBpbiBhIHNlY29u
ZCwgYnV0IGZpcnN0IGEgc3VnZ2VzdGlvbiBmb3IgdGhpcw0KPj4+Pj4+Pj4+IHBhdGNoOiBJIHRo
aW5rIGl0J3Mgbm90IHNvIGdvb2QgdG8gdXNlIDIgR0Igb2Ygc3BhY2UgZm9yIGEgdGVzdCAoMSBH
Qg0KPj4+Pj4+Pj4+IGZvciB0aGUgc291cmNlLCAxIEdCIGZvciB0aGUgdGFyZ2V0KS4gIFNvIEkg
dHJpZWQgbXkgbHVjayBhbmQgZm91bmQgdGhhdA0KPj4+Pj4+Pj4+IHRoZSB0ZXN0IHdvcmtzLCB0
b28sIGlmIHlvdSBqdXN0IHVzZSBwcmVhbGxvY2F0aW9uPW1ldGFkYXRhIGZvciB0aGUNCj4+Pj4+
Pj4+PiBzb3VyY2UgKGluc3RlYWQgb2YgYWN0dWFsbHkgd3JpdGluZyBkYXRhKSBhbmQgYmxvY2tk
ZXYtbWlycm9yJ2luZyB0aGUNCj4+Pj4+Pj4+PiBkYXRhIHRvIGEgdGhyb3R0bGVkIG51bGwtY28g
ZGV2aWNlLg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IEhtbSwgc28gcGFyc2luZyBtZXRhZGF0YSBpcyBl
bm91Z2ggZm9yIHFjb3cyIHRvIHlpZWxkIG9uIHdyaXRlLCB5ZXM/DQo+Pj4+Pj4+DQo+Pj4+Pj4+
IEFwcGFyZW50bHkgc28uICBJZiB5b3UgY2FuIGNvbmZpcm0gdGhhdCBhcHBseWluZyB0aG9zZSBj
aGFuZ2VzIHRvIHRoZQ0KPj4+Pj4+PiB0ZXN0IHN0aWxsIG1ha2UgaXQgd29yayAoaS5lLiwgZmFp
bCBiZWZvcmUgcGF0Y2ggMSwgcGFzcyBhZnRlcndhcmRzKSwNCj4+Pj4+Pj4gdGhlbiBJIHRoaW5r
IGl0IGlzIGp1c3QgYXMgZ29vZC4NCj4+Pj4+Pg0KPj4+Pj4+IE9rLCBJJ3ZlIGNoZWNrZWQgdGhh
dCB5b3VyIGNoYW5nZXMgd29ya3MgZm9yIG1lLg0KPj4+Pj4+DQo+Pj4+Pj4gaG0sIGJ1dCB3ZSB3
cml0ZSB0byBudWxsLCBzbywgeWllbGQgb24gd3JpdGUgY29tZXMgZnJvbSB0aHJvdHRsaW5nLCBo
b3dldmVyLA0KPj4+Pj4+IHdpdGhvdXQgcHJlYWxsb2NhdGlvbj1tZXRhZGF0YSwgaXQgZG9uJ3Qg
d29yay4uLCBkbyB5b3Uga25vdywgd2h5IHdlIG5lZWQNCj4+Pj4+PiBwcmVhbGxvY2F0aW9uIHRv
IHJlcHJvZHVjZT8NCj4+Pj4+DQo+Pj4+PiBJZiBJIHNob3VsZCB0YWtlIGEgZ3Vlc3MsIHByb2Jh
Ymx5IGJlY2F1c2UgbWlycm9yIG9ubHkgY29waWVzIGFsbG9jYXRlZA0KPj4+Pj4gY2x1c3RlcnM/
DQo+Pj4+Pg0KPj4+Pj4gS2V2aW4NCj4+Pj4+DQo+Pj4+DQo+Pj4+IGhtLCBzbywgd2hhdCBwcmVh
bGxvY2F0aW9uPW1ldGFkYXRhIGRvZXM/IEkgdGhvdWdodCwgaXQgcHJlYWxsb2NhdGVzIHRhYmxl
cywgYnV0IGFsbCBxY293MiBjbHVzdGVycyB3b3VsZCBiZSB1bmFsbG9jYXRlZC4uDQo+Pj4NCj4+
PiBObywgaXQgaW5pdGlhbGl6ZXMgYWxsIG1ldGFkYXRhIHN0cnVjdHVyZXMgKGkuZS4sIEwyIHRh
Ymxlcykgc28gdGhleQ0KPj4+IHBvaW50IHRvIGRhdGEgY2x1c3RlcnM7IHdoaWNoIGlzIHdoeSB5
b3UgY2Fubm90IHVzZSBpdCB3aXRoIGJhY2tpbmcNCj4+PiBmaWxlcy4gIEl0J3MganVzdCB0aGF0
IHRoZSBkYXRhIGNsdXN0ZXJzIGFyZSBub3Qgd3JpdHRlbi4NCj4+DQo+PiBzbywgY2x1c3RlcnMg
YXJlIGFsbG9jYXRlZD8gaW4gdGhpcyBjYXNlLCB3ZSBkb24ndCBhdm9pZCBhbGxvY2F0aW5nIG9m
IDFHLCBidXQgb25seSBoYXZlIGEgcGVyZm9ybWFuY2UgZ2Fpbj8NCj4gDQo+IFRoZSBkYXRhIGlz
bid0IHdyaXR0ZW4sIHNvIGxlc3MgdGhhbiAxIE1CIGFyZSBhY3R1YWxseSBhbGxvY2F0ZWQgb24t
ZGlzay4NCj4gDQo+IFRoZSBMMiB0YWJsZXMgZG8gcG9pbnQgdG8gb2Zmc2V0cyBvdmVyIGEgcmFu
Z2Ugb2YgMSBHQiwgYnV0IHRoZXkgc2hvdWxkDQo+IGFsbCBiZSBob2xlcyBvbiB0aGUgZmlsZXN5
c3RlbS4NCj4gDQo+IE1heA0KPiANCg0KVW5kZXJzdGFuZCwgb2ssIHRoYW5rIHlvdSENCg0KDQot
LSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

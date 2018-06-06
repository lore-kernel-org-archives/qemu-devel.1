Received: from eggs.gnu.org ([2001:4830:134:3::10]:45211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xuyandong2@huawei.com>) id 1fQZHC-0001BW-CN
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xuyandong2@huawei.com>) id 1fQZH7-0004J1-VR
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:19:02 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2273 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xuyandong2@huawei.com>)
	id 1fQZH7-0004Fp-GW
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:18:57 -0400
From: xuyandong <xuyandong2@huawei.com>
Date: Wed, 6 Jun 2018 14:18:41 +0000
Message-ID: <7CECC2DFC21538489F72729DF5EFB4D9C1D8F1@dggemm501-mbs.china.huawei.com>
References: <7CECC2DFC21538489F72729DF5EFB4D9C1486C@DGGEMM501-MBX.china.huawei.com>
	<20180601122307.3e6ade66@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB00F4E4@dggeml511-mbx.china.huawei.com>
	<50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
In-Reply-To: <50481bea-bb5b-dd71-b712-6418c3bb29ac@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] An emulation failure occurs,
 if I hotplug vcpus immediately after the VM start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQm9uemluaSBb
bWFpbHRvOnBib256aW5pQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAwNiwg
MjAxOCA5OjU4IFBNDQo+IFRvOiBHb25nbGVpIChBcmVpKSA8YXJlaS5nb25nbGVpQGh1YXdlaS5j
b20+OyBJZ29yIE1hbW1lZG92DQo+IDxpbWFtbWVkb0ByZWRoYXQuY29tPjsgeHV5YW5kb25nIDx4
dXlhbmRvbmcyQGh1YXdlaS5jb20+DQo+IENjOiBaaGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hh
aWxpYW5nQGh1YXdlaS5jb20+OyB3YW5neGluIChVKQ0KPiA8d2FuZ3hpbnhpbi53YW5nQGh1YXdl
aS5jb20+OyBsaWRvbmdsaW4gPGxpZG9uZ2xpbkBodWF3ZWkuY29tPjsNCj4ga3ZtQHZnZXIua2Vy
bmVsLm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBIdWFuZ3dlaWRvbmcgKEMpDQo+IDx3ZWlk
b25nLmh1YW5nQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBBbiBlbXVsYXRpb24gZmFpbHVy
ZSBvY2N1cnMsaWYgSSBob3RwbHVnIHZjcHVzIGltbWVkaWF0ZWx5IGFmdGVyDQo+IHRoZSBWTSBz
dGFydA0KPiANCj4gT24gMDYvMDYvMjAxOCAxNToyOCwgR29uZ2xlaSAoQXJlaSkgd3JvdGU6DQo+
ID4gZ29uZ2xlaSoqKioqKioqOiBtZW0uc2xvdDogMywgbWVtLmd1ZXN0X3BoeXNfYWRkcj0weGMw
MDAwLA0KPiA+IG1lbS51c2Vyc3BhY2VfYWRkcj0weDdmYzM0M2VjMDAwMCwgbWVtLmZsYWdzPTAs
IG1lbW9yeV9zaXplPTB4MA0KPiA+IGdvbmdsZWkqKioqKioqKjogbWVtLnNsb3Q6IDMsIG1lbS5n
dWVzdF9waHlzX2FkZHI9MHhjMDAwMCwNCj4gPiBtZW0udXNlcnNwYWNlX2FkZHI9MHg3ZmMzNDNl
YzAwMDAsIG1lbS5mbGFncz0wLA0KPiBtZW1vcnlfc2l6ZT0weDkwMDANCj4gPg0KPiA+IFdoZW4g
dGhlIG1lbW9yeSByZWdpb24gaXMgY2xlYXJlZCwgdGhlIEtWTSB3aWxsIHRlbGwgdGhlIHNsb3Qg
dG8gYmUNCj4gPiBpbnZhbGlkICh3aGljaCBpdCBpcyBzZXQgdG8gS1ZNX01FTVNMT1RfSU5WQUxJ
RCkuDQo+ID4NCj4gPiBJZiBTZWFCSU9TIGFjY2Vzc2VzIHRoaXMgbWVtb3J5IGFuZCBjYXVzZSBw
YWdlIGZhdWx0LCBpdCB3aWxsIGZpbmQgYW4NCj4gPiBpbnZhbGlkIHZhbHVlIGFjY29yZGluZyB0
byBnZm4gKGJ5IF9fZ2ZuX3RvX3Bmbl9tZW1zbG90KSwgYW5kIGZpbmFsbHkNCj4gPiBpdCB3aWxs
IHJldHVybiBhbiBpbnZhbGlkIHZhbHVlLCBhbmQgZmluYWxseSBpdCB3aWxsIHJldHVybiBhIGZh
aWx1cmUuDQo+ID4NCj4gPiBTbywgTXkgcXVlc3Rpb25zIGFyZToNCj4gPg0KPiA+IDEpIFdoeSBk
b24ndCB3ZSBob2xkIGt2bS0+c2xvdHNfbG9jayBkdXJpbmcgcGFnZSBmYXVsdCBwcm9jZXNzaW5n
Pw0KPiANCj4gQmVjYXVzZSBpdCdzIHByb3RlY3RlZCBieSBTUkNVLiAgV2UgZG9uJ3QgbmVlZCBr
dm0tPnNsb3RzX2xvY2sgb24gdGhlIHJlYWQNCj4gc2lkZS4NCj4gDQo+ID4gMikgSG93IGRvIHdl
IGFzc3VyZSB0aGF0IHZjcHVzIHdpbGwgbm90IGFjY2VzcyB0aGUgY29ycmVzcG9uZGluZw0KPiA+
IHJlZ2lvbiB3aGVuIGRlbGV0aW5nIGFuIG1lbW9yeSBzbG90Pw0KPiANCj4gV2UgZG9uJ3QuICBJ
dCdzIGdlbmVyYWxseSBhIGd1ZXN0IGJ1ZyBpZiB0aGV5IGRvLCBidXQgdGhlIHByb2JsZW0gaGVy
ZSBpcyB0aGF0DQo+IFFFTVUgaXMgc3BsaXR0aW5nIGEgbWVtb3J5IHJlZ2lvbiBpbiB0d28gcGFy
dHMgYW5kIHRoYXQgaXMgbm90IGF0b21pYy4NCj4gCQ0KPiBPbmUgZml4IGNvdWxkIGJlIHRvIGFk
ZCBhIEtWTV9TRVRfVVNFUl9NRU1PUllfUkVHSU9OUyBpb2N0bCB0aGF0DQo+IHJlcGxhY2VzIHRo
ZSBlbnRpcmUgbWVtb3J5IG1hcCBhdG9taWNhbGx5Lg0KPiANCj4gUGFvbG8NCg0KQWZ0ZXIgd2Ug
YWRkIGEgS1ZNX1NFVF9VU0VSX01FTU9SWV9SRUdJT05TIGlvY3RsIHRoYXQgcmVwbGFjZXMgdGhl
IGVudGlyZQ0KbWVtb3J5IG1hcCBhdG9taWNhbGx5LCBob3cgdG8gdXNlIGl0IGluIGFkZHJlc3Nf
c3BhY2VfdXBkYXRlX3RvcG9sb2d5Pw0KU2hhbGwgd2UgY2hlY2tvdXQgdGhlIHNwaWx0IG1lbW9y
eSByZWdpb24gYmVmb3JlIA0KIiBhZGRyZXNzX3NwYWNlX3VwZGF0ZV90b3BvbG9neV9wYXNzKGFz
LCBvbGRfdmlldywgbmV3X3ZpZXcsIGZhbHNlKTsgDQphZGRyZXNzX3NwYWNlX3VwZGF0ZV90b3Bv
bG9neV9wYXNzKGFzLCBvbGRfdmlldywgbmV3X3ZpZXcsIHRydWUpOw0KIi4NCg0KDQo=

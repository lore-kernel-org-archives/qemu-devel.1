Received: from eggs.gnu.org ([2001:4830:134:3::10]:35384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1fCF4X-0004t6-Rh
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1fCF4T-0004pD-Uo
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:54:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:11679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1fCF4T-0004p7-LD
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 21:54:41 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Sat, 28 Apr 2018 01:54:37 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19113D477@SHSMSX101.ccr.corp.intel.com>
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-4-peterx@redhat.com>
	<2492f7d8-ed63-6f1c-773f-baa223020022@redhat.com>
	<20180427062615.GY9036@xz-mi>
	<AADFC41AFE54684AB9EE6CBC0274A5D19113B628@SHSMSX101.ccr.corp.intel.com>
	<20180427095352.GD13269@xz-mi>
In-Reply-To: <20180427095352.GD13269@xz-mi>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 03/10] intel-iommu: add iommu lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBGcmlk
YXksIEFwcmlsIDI3LCAyMDE4IDU6NTQgUE0NCj4gDQo+IE9uIEZyaSwgQXByIDI3LCAyMDE4IGF0
IDA3OjE5OjI1QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gRnJvbTogUGV0ZXIg
WHUNCj4gPiA+IFNlbnQ6IEZyaWRheSwgQXByaWwgMjcsIDIwMTggMjoyNiBQTQ0KPiA+ID4NCj4g
PiA+IE9uIEZyaSwgQXByIDI3LCAyMDE4IGF0IDAxOjEzOjAyUE0gKzA4MDAsIEphc29uIFdhbmcg
d3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IE9uIDIwMTjlubQwNOaciDI15pelIDEy
OjUxLCBQZXRlciBYdSB3cm90ZToNCj4gPiA+ID4gPiBBZGQgYSBwZXItaW9tbXUgYmlnIGxvY2sg
dG8gcHJvdGVjdCBJT01NVSBzdGF0dXMuICBDdXJyZW50bHkgdGhlDQo+IG9ubHkNCj4gPiA+ID4g
PiB0aGluZyB0byBiZSBwcm90ZWN0ZWQgaXMgdGhlIElPVExCIGNhY2hlLCBzaW5jZSB0aGF0IGNh
biBiZSBhY2Nlc3NlZA0KPiA+ID4gPiA+IGV2ZW4gd2l0aG91dCBCUUwsIGUuZy4sIGluIElPIGRh
dGFwbGFuZS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE5vdGUgdGhhdCBkZXZpY2UgcGFnZSB0YWJs
ZXMgc2hvdWxkIG5vdCBuZWVkIGFueSBwcm90ZWN0aW9uLiAgVGhlDQo+ID4gPiBzYWZldHkNCj4g
PiA+ID4gPiBvZiB0aGF0IHNob3VsZCBiZSBwcm92aWRlZCBieSBndWVzdCBPUy4gIEUuZy4sIHdo
ZW4gYSBwYWdlIGVudHJ5IGlzDQo+ID4gPiA+ID4gZnJlZWQsIHRoZSBndWVzdCBPUyBzaG91bGQg
YmUgcmVzcG9uc2libGUgdG8gbWFrZSBzdXJlIHRoYXQgbm8NCj4gZGV2aWNlDQo+ID4gPiA+ID4g
d2lsbCBiZSB1c2luZyB0aGF0IHBhZ2UgYW55IG1vcmUuDQo+ID4NCj4gPiBkZXZpY2UgcGFnZSB0
YWJsZSBkZWZpbml0ZWx5IGRvZXNuJ3QgcmVxdWlyZSBwcm90ZWN0aW9uLCBzaW5jZSBpdCBpcw0K
PiA+IGluLW1lbW9yeSBzdHJ1Y3R1cmUgbWFuYWdlZCBieSBndWVzdC4gSG93ZXZlciB0aGUgcmVh
c29uDQo+ID4gYWJvdmUgaXMgbm90IGFjY3VyYXRlIC0gdGhlcmUgaXMgbm8gd2F5IHRoYXQgZ3Vl
c3QgT1MgY2FuIG1ha2UNCj4gPiBzdXJlIG5vIGRldmljZSB1c2VzIG5vbi1wcmVzZW50IHBhZ2Ug
ZW50cnksIG90aGVyd2lzZSBpdCBkb2Vzbid0DQo+ID4gcmVxdWlyZSB2aXJ0dWFsIElPTU1VIHRv
IHByb3RlY3QgaXRzZWxmLiBUaGVyZSBjb3VsZCBiZSBib2d1cy8NCj4gPiBtYWxpY2lvdXMgZHJp
dmVycyB3aGljaCBzdXJlbHkgbWF5IHByb2dyYW0gdGhlIGRldmljZSB0byBhdHRlbXB0IHNvLg0K
PiANCj4gSG93IGFib3V0IHRoaXM6DQo+IA0KPiAgIE5vdGUgdGhhdCB3ZSBkb24ndCBuZWVkIHRv
IHByb3RlY3QgZGV2aWNlIHBhZ2UgdGFibGVzIHNpbmNlIHRoYXQncw0KPiAgIGZ1bGx5IGNvbnRy
b2xsZWQgYnkgdGhlIGd1ZXN0IGtlcm5lbC4gIEhvd2V2ZXIgdGhlcmUgaXMgc3RpbGwNCj4gICBw
b3NzaWJpbGl0aWVzIHRoYXQgbWFsaWNpb3VzIGRyaXZlcnMgd2lsbCBzdGlsbCBwcm9ncmFtIHRo
ZSBkZXZpY2UNCj4gICB0byBub3QgZGlzb2JleSB0aGUgcnVsZS4gIEluIHRoYXQgY2FzZSBRRU1V
IGNhbid0IHJlYWxseSBkbyBhbnl0aGluZw0KPiAgIHVzZWZ1bCwgaW5zdGVhZCB0aGUgZ3Vlc3Qg
aXRzZWxmIHdpbGwgYmUgcmVzcG9uc2libGUgZm9yIGFsbA0KPiAgIHVuY2VydGFpbnRpZXMuDQo+
IA0KDQp5ZXMsIE9LIHRvIG1lDQoNClRoYW5rcw0KS2V2aW4NCg==

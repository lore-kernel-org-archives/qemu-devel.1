Received: from eggs.gnu.org ([2001:4830:134:3::10]:41181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUVsY-0000bl-Aa
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUVsV-0007FE-7x
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:53:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:42388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cUVsU-0007Ew-R9
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:53:03 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 20 Jan 2017 09:52:01 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C1525C@SHSMSX101.ccr.corp.intel.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-3-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14F86@SHSMSX101.ccr.corp.intel.com>
	<20170120090506.GJ4914@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C15103@SHSMSX101.ccr.corp.intel.com>
	<20170120092736.GM4914@pxdev.xzpeter.org>
In-Reply-To: <20170120092736.GM4914@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RFC v3 02/14] intel_iommu: simplify irq
 region translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBGcmlk
YXksIEphbnVhcnkgMjAsIDIwMTcgNToyOCBQTQ0KPiANCj4gT24gRnJpLCBKYW4gMjAsIDIwMTcg
YXQgMDk6MTU6MjdBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBQZXRl
ciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiA+ID4gU2VudDogRnJpZGF5LCBKYW51
YXJ5IDIwLCAyMDE3IDU6MDUgUE0NCj4gPiA+DQo+ID4gPiBPbiBGcmksIEphbiAyMCwgMjAxNyBh
dCAwODoyMjoxNEFNICswMDAwLCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPiA+ID4gPiBGcm9tOiBQ
ZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiA+ID4gPiA+IFNlbnQ6IEZyaWRh
eSwgSmFudWFyeSAxMywgMjAxNyAxMTowNiBBTQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQmVmb3Jl
IHdlIGhhdmUgaW50LXJlbWFwLCB3ZSBuZWVkIHRvIGJ5cGFzcyBpbnRlcnJ1cHQgd3JpdGUgcmVx
dWVzdHMuDQo+ID4gPiA+ID4gVGhhdCdzIG5vdCBuZWNlc3Nhcnkgbm93IC0gd2UgaGF2ZSBzdXBw
b3J0ZWQgaW50LXJlbWFwLCBhbmQgYWxsIHRoZSBpcnENCj4gPiA+ID4gPiByZWdpb24gcmVxdWVz
dHMgc2hvdWxkIGJlIHJlZGlyZWN0ZWQgdGhlcmUuIENsZWFuaW5nIHVwIHRoZSBibG9jayB3aXRo
DQo+ID4gPiA+ID4gYW4gYXNzZXJ0aW9uIGluc3RlYWQuDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMg
Y29tbWVudCBpcyBub3QgYWNjdXJhdGUuIEFjY29yZGluZyB0byBjb2RlLCB0aGUgcmVhc29uIHdo
eSB5b3UNCj4gPiA+ID4gY2FuIGRvIHN1Y2ggc2ltcGxpZmljYXRpb24gaXMgYmVjYXVzZSB3ZSBo
YXZlIHN0YW5kYWxvbmUgbWVtb3J5DQo+ID4gPiA+IHJlZ2lvbiBub3cgZm9yIGludGVycnVwdCBh
ZGRyZXNzZXMuIFRoZXJlIHNob3VsZCBiZSBub3RoaW5nIHRvIGRvDQo+ID4gPiA+IHdpdGggaW50
LXJlbWFwLCB3aGljaCBjYW4gYmUgZGlzYWJsZWQgYnkgZ3Vlc3QuLi4gTWF5YmUgdGhlIHN0YW5k
YWxvbmUNCj4gPiA+ID4gcmVnaW9uIHdhcyBhZGRlZCB3aGVuIGRldmVsb3BpbmcgaW50LXJlbWFw
LCBidXQgZnVuY3Rpb25hbGx5IHRoZXkNCj4gPiA+ID4gYXJlIG5vdCByZWxhdGVkLiA6LSkNCj4g
PiA+DQo+ID4gPiBJTUhPIHRoZSBhYm92ZSBjb21taXQgbWVzc2FnZSBpcyBmYWlybHkgY2xlYXIu
IDotKQ0KPiA+ID4NCj4gPiA+IEJ1dCBzdXJlIEkgY2FuIGFkZCBzb21lIG1vcmUgZW1waGFzaXNl
IGxpa2U6DQo+ID4gPg0KPiA+ID4gICAiQmVmb3JlIHdlIGhhdmUgaW50LXJlbWFwIG1lbW9yeSBy
ZWdpb24sIC4uLiINCj4gPiA+DQo+ID4gPiBEbyB5b3UgdGhpbmsgaXQncyBva2F5PyBPciBhbnkg
YmV0dGVyIHN1Z2dlc3Rpb24/DQo+ID4gPg0KPiA+ID4gKEp1c3QgdG8gbWVudGlvbiB0aGF0IGV2
ZW4gZ3Vlc3QgZGlzYWJsZXMgSVIsIHRoZSBNU0kgcmVnaW9uIHdpbGwNCj4gPiA+ICBzdGlsbCBi
ZSB0aGVyZS4pDQo+ID4gPg0KPiA+DQo+ID4gTXkgb3B0aW9uIGlzIHNpbXBsZSAtIHRoaXMgcGF0
Y2ggaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCBpbnQtcmVtYXAuDQo+ID4gSXQncyBub3QgbmVjZXNz
YXJ5LCBub3QgYmVjYXVzZSB3ZSBzdXBwb3J0ZWQgaW50LXJlbWFwLiBJdCdzIGJlY2F1c2UNCj4g
PiB3ZSBoYXZlIGEgc3RhbmRhbG9uZSBtZW1vcnkgcmVnaW9uIGZvciBpbnRlcnJ1cHQgYWRkcmVz
c2VzLCBhcyB5b3UNCj4gPiBkZXNjcmliZWQgaW4gdGhlIGNvZGUuIDotKQ0KPiANCj4gSSByZWFs
bHkgdGhpbmsgdGhleSBhcmUgdGhlIHNhbWUgdGhpbmcuLi4NCj4gDQo+IEhvdyBhYm91dCB0aGlz
Og0KPiANCj4gICAgIE5vdyB3ZSBoYXZlIGEgc3RhbmRhbG9uZSBtZW1vcnkgcmVnaW9uIGZvciBN
U0ksIGFsbCB0aGUgaXJxIHJlZ2lvbg0KPiAgICAgcmVxdWVzdHMgc2hvdWxkIGJlIHJlZGlyZWN0
ZWQgdGhlcmUuIENsZWFuaW5nIHVwIHRoZSBibG9jayB3aXRoIGFuDQo+ICAgICBhc3NlcnRpb24g
aW5zdGVhZC4NCj4gDQoNCmJ0dyB3aGF0IGFib3V0IGd1ZXN0IHNldHVwcyBhIHZhbGlkIG1hcHBp
bmcgYXQgMHhGRUV4X3h4eHggaW4NCml0cyByZW1hcHBpbmcgc3RydWN0dXJlLCB3aGljaCBpcyB0
aGVuIHByb2dyYW1tZWQgdG8gdmlydHVhbA0KZGV2aWNlIGFzIERNQSBkZXN0aW5hdGlvbj8gVGhl
biB3aGVuIGVtdWxhdGluZyB0aGF0IHZpcnR1YWwgRE1BLA0KdnRkX2RvX2lvbW11X3RyYW5zbGF0
ZSBzaG91bGQgc2ltcGx5IHJldHVybiAobWF5YmUgdGhyb3cgb3V0DQphIHdhcm5pbmcgZm9yIGRp
YWdub3N0aWMgcHVycG9zZSkgaW5zdGVhZCBvZiBhc3NlcnQgaGVyZS4gDQoNClZULWQgc3BlYyBk
ZWZpbmVzIGFzIGJlbG93Og0KDQoJU29mdHdhcmUgbXVzdCBlbnN1cmUgdGhlIHNlY29uZC1sZXZl
bCBwYWdpbmctc3RydWN0dXJlIGVudHJpZXMgDQoJYXJlIHByb2dyYW1tZWQgbm90IHRvIHJlbWFw
IGlucHV0IGFkZHJlc3NlcyB0byB0aGUgaW50ZXJydXB0IA0KCWFkZHJlc3MgcmFuZ2UuIEhhcmR3
YXJlIGJlaGF2aW9yIGlzIHVuZGVmaW5lZCBmb3IgbWVtb3J5IA0KCXJlcXVlc3RzIHJlbWFwcGVk
IHRvIHRoZSBpbnRlcnJ1cHQgYWRkcmVzcyByYW5nZS4NCg0KSSBkb24ndCB0aGluayAiaGFyZHdh
cmUgYmVoYXZpb3IgaXMgdW5kZWZpbmVkIiBpcyBlcXVhbCB0byAiYXNzZXJ0DQp0aHVzIGtpbGwg
Vk0iLi4uDQoNClRoYW5rcw0KS2V2aW4NCg==

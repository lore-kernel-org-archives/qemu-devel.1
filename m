Received: from eggs.gnu.org ([2001:4830:134:3::10]:56785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1ep7sP-0004z5-4J
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 02:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1ep7sM-000214-0N
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 02:34:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:55904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1ep7sL-0001ua-MR
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 02:34:37 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 23 Feb 2018 07:34:28 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191015735@SHSMSX101.ccr.corp.intel.com>
References: <CAHyh4xii5y-8=uMJeQGARrHZAETtW4ugmBWUypbQ923vk0P3Lw@mail.gmail.com>
	<20180223035555.GL18962@xz-mi>
	<CAHyh4xiCpJQZgtQR-KDrDntZZnAK5V5D=oB7UwQbuZNy7G_z7g@mail.gmail.com>
	<20180223061034.GM18962@xz-mi>
	<CAHyh4xh+EP6-vvrcQiQTBQQ4+3yrQvVFNGrtgt0w57ZZ0LNcZA@mail.gmail.com>
	<20180223070927.GN18962@xz-mi>
In-Reply-To: <20180223070927.GN18962@xz-mi>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] intel-iommu and vhost: Do we need 'device-iotlb'
 and 'ats'?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>
Cc: Eric Auger <eric.auger@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, QEMU
	Devel Mailing List <qemu-devel@nongnu.org>

PiBGcm9tOiBQZXRlciBYdQ0KPiBTZW50OiBGcmlkYXksIEZlYnJ1YXJ5IDIzLCAyMDE4IDM6MDkg
UE0NCj4gDQo+ID4NCj4gPiBSaWdodC4gSSB0aGluayBteSBxdWVzdGlvbiB3YXMgbm90IGNsZWFy
LiBNeSBxdWVzdGlvbiB3YXMgdGhhdCB3aHkgZG9u4oCZdA0KPiA+IElPTU1VIGludmFsaWRhdGUg
ZGV2aWNlLWlvdGxiIGFsb25nIHdpdGggaXRzIG1hcHBpbmdzIGluIG9uZSBnby4gVGhlbg0KPiBJ
T01NVQ0KPiA+IGRldmljZSBkcml2ZXIgZG9lc27igJl0IG5lZWQgdG8gZmx1c2ggZGV2aWNlLWlv
dGxiIGV4cGxpY2l0bHkuIE1heWJlIHRoZQ0KPiA+IHJlYXNvbiBpcyB0aGF0IEFUUyBhbmQgSU9N
TVUgYXJlIG5vdCBhbHdheXMgY291cGxlZC4uIGJ1dCBJIGd1ZXNzIGl04oCZcw0KPiB0aW1lDQo+
ID4gZm9yIG1lIHRvIGdldCBzb21lIG1vcmUgYmFja2dyb3VuZCA6KQ0KPiANCj4gQWgsIEkgc2Vl
IHlvdXIgcG9pbnQuDQo+IA0KPiBJIGRvbid0IGtub3cgdGhlIGFuc3dlci4gIE15IHdpbGQgZ3Vl
c3MgaXMgdGhhdCBJT01NVSBpcyBqdXN0IHRyeWluZw0KPiB0byBiZSBzaW1wbGUgYW5kIG9ubHkg
cHJvdmlkZSBtb3N0IGJhc2ljIGZ1bmN0aW9uYWxpdGllcywgbGVhdmluZw0KPiBjb21wbGV4IHN0
dWZmIHRvIENQVS4gIEZvciBleGFtcGxlLCBpZiBJT01NVSB0YWtlcyBvdmVyIHRoZSBvd25lcnNo
aXANCj4gdG8gZGVsaWV2ZXIgZGV2aWNlLWlvdGxiIGludmFsaWRhdGlvbnMgd2hlbiByZWNlaXZp
bmcgaW90bGINCj4gaW52YWxpZGF0aW9ucywgaXQgcG9zc2libHkgbmVlZHMgdG8gdHJhdmVyc2Ug
dGhlIGRldmljZSB0cmVlIHNvbWV0aW1lcw0KPiAoZS5nLiwgZm9yIGRvbWFpbiBpbnZhbGlkYXRp
b25zKSB0byBrbm93IHdoYXQgZGV2aWNlIGlzIHVuZGVyIHdoYXQNCj4gZG9tYWluLCB3aGljaCBp
cyByZWFsbHkgY29tcGxpYXRlZC4gIFdoaWxlIGl0J2xsIGJlIHNpbXBsZXIgZm9yIENQVSB0bw0K
PiBkbyB0aGlzIHNpbmNlIGl0J3MgdmVyeSBwb3NzaWJsZSB0aGF0IHRoZSBPUyBrZWVwcyBhIGxp
c3Qgb2YgZGV2aWNlcw0KPiBmb3IgYSBkb21haW4gYWxyZWFkeS4NCj4gDQo+IElNSE8gdGhhdCBm
b2xsb3dzIHRoZSAqbml4IHBoaWxvc29waHkgdG9vIC0gRG8gT25lIFRoaW5nIEFuZCBEbyBJdA0K
PiBXZWxsLiAgVGhvdWdoIGFnYWluLCBpdCdzIHdpbGQgZ3Vlc3MgYW5kIEkgbWF5IGJlIHdyb25n
LiA6KQ0KPiANCj4gQ0NpbmcgQWxleCwgaW4gY2FzZSBoZSBoYXMgcXVpY2sgYW5zd2Vycy4NCj4g
DQoNCklPTU1VIGFuZCBkZXZpY2VzIGFyZSBkZS1jb3VwbGVkLiBZb3UgbmVlZCBhIHByb3RvY29s
IHNvIElPTU1VDQprbm93cyB3aGljaCBkZXZpY2UgZW5hYmxlcyB0cmFuc2xhdGlvbiBjYWNoZXMg
YW5kIHRodXMgcmVxdWlyZXMNCmV4cGxpY2l0IGludmFsaWRhdGlvbiwgd2hpY2ggaXMgaG93IEFU
UyBjb21lcyB0byBwbGF5LiBBVFMgaXMgbm90DQptYW5kYXRvcnkgZm9yIHZob3N0LCBidXQgZG9p
bmcgc28gcHJvdmlkZXMgbW9yZSBmbGV4aWJpbGl0eSBlLmcuDQp0byBlbmFibGUgSS9PIHBhZ2Ug
ZmF1bHQgaWYgZnVydGhlciBlbXVsYXRpbmcgUENJIFBSUyBjYXAuDQoNClRoYW5rcw0KS2V2aW4N
Cg==

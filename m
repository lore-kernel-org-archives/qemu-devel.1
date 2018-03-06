Received: from eggs.gnu.org ([2001:4830:134:3::10]:52037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1etAl4-0007Ou-VN
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1etAl1-0005Aq-OG
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:27:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:35804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1etAl1-0005AQ-Dw
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:27:47 -0500
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Tue, 6 Mar 2018 11:27:41 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439B88B68@SHSMSX104.ccr.corp.intel.com>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-9-git-send-email-yi.l.liu@linux.intel.com>
	<f9ee648a-ff93-b57a-4b05-6bd0f40c15bf@redhat.com>
	<20180305084207.GE2482@sky-dev>
	<2160f478-2c8a-8fbe-1df8-78c1984cf375@redhat.com>
	<20180306110337.GC3158@sky-dev>
	<c888c285-ffb8-aa4c-6486-2b9bddb64844@redhat.com>
In-Reply-To: <c888c285-ffb8-aa4c-6486-2b9bddb64844@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 08/12] hw/pci: introduce
 pci_device_notify_iommu()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>

PiBGcm9tOiBQYW9sbyBCb256aW5pIFttYWlsdG86cGJvbnppbmlAcmVkaGF0LmNvbV0NCj4gU2Vu
dDogVHVlc2RheSwgTWFyY2ggNiwgMjAxOCA3OjIyIFBNDQo+IFN1YmplY3Q6IFJlOiBbUWVtdS1k
ZXZlbF0gW1BBVENIIHYzIDA4LzEyXSBody9wY2k6IGludHJvZHVjZQ0KPiBwY2lfZGV2aWNlX25v
dGlmeV9pb21tdSgpDQo+IA0KPiBPbiAwNi8wMy8yMDE4IDEyOjAzLCBMaXUsIFlpIEwgd3JvdGU6
DQo+ID4gT24gVHVlLCBNYXIgMDYsIDIwMTggYXQgMTE6MTg6NDNBTSArMDEwMCwgUGFvbG8gQm9u
emluaSB3cm90ZToNCj4gPj4gT24gMDUvMDMvMjAxOCAwOTo0MiwgTGl1LCBZaSBMIHdyb3RlOg0K
PiA+Pj4+IEluIGdlbmVyYWwgSSB0aGluayBpdCdzIGJldHRlciB0byBjaGFuZ2UgeW91ciBuYW1l
cyBmcm9tICJhc3NpZ25lZF9kZXYiDQo+ID4+Pj4gdG8gInN2YV9kZXYiLCBiZWNhdXNlIHRoZSBw
b2ludCBvZiB0aGUgbGlzdCBpcyB0byBvbmx5IGl0ZXJhdGUgb3Zlcg0KPiA+Pj4+IGRldmljZXMg
dGhhdCBtaWdodCBiZSBpbnRlcmVzdGVkIGluIHVzaW5nIFNWQS4NCj4gPj4+DQo+ID4+PiBGb3Ig
ImFzc2lnbmVkX2RldiIsIG15IHB1cnBvc2UgaXMgdG8gZGlzdGluZ3Vpc2ggImFzc2lnbmVkIGRl
dmljZXMiDQo+ID4+PiBmcm9tIGVtdWxhdGVkIGRldmljZXMuIE9ubHkgdGhlIFNWQSB1c2FnZSBv
biAiYXNzaWduZWQgZGV2aWNlcyIgaXMgY2FyZWQgaGVyZS4NCj4gPj4+IEJ1dCBpdCBpcyB0cnVl
IG9ubHkgU1ZBIGNhcGFibGUgZGV2aWNlIGlzIGludGVyZXN0ZWQuIFNvIEkgbWF5IG5lZWQNCj4g
Pj4+IHRvIHJlbmFtZSBpdCBhcyAiYXNzaWduZWRfc3ZhX2RldiIuIEhvdyBhYm91dCB5b3VyIG9w
aW5pb24/DQo+ID4+DQo+ID4+IFdoYXQgeW91IGNhcmUgYWJvdXQgaXMgbm90IHdoZXRoZXIgdGhl
IGRldmljZSBhc3NpZ25lZCwgYnV0IHJhdGhlcg0KPiA+PiB3aGV0aGVyIGl0IGNhbGxlZCBvciBu
b3QgcGNpX3NldHVwX3N2YV9vcHMuICBDdXJyZW50bHkgb25seSBWRklPIGRvZXMNCj4gPj4gdGhp
cywgYnV0IHRoYXQncyBub3QgYSByZXF1aXJlbWVudC4gIEhlbmNlIG15IHN1Z2dlc3Rpb24gb2Yg
Y2FsbGluZw0KPiA+PiBpdCBzdmFfZGV2Lg0KPiA+DQo+ID4gWWVzLCBvbmx5IFZGSU8gY2FsbHMg
cGNpX3NldHVwX3N2YV9vcHMgc28gZmFyLCBidXQgaXQgc2hvdWxkIG5vdCBsaW1pdGVkIHRvLg0K
PiA+IEknbGwgYXBwbHkgaW4gbmV4dCB2ZXJzaW9uLg0KPiANCj4gRm9yIHdoYXQgaXQncyB3b3J0
aCwgSSBhZ3JlZSB3aXRoIERhdmlkJ3Mgc3VnZ2VzdGlvbiBmb3IgbmFtaW5nIChzbw0KPiBwY2lf
c2V0dXBfcGFzaWRfb3BzLCBwYXNpZF9kZXYsIGV0Yy4pDQoNClRoYW5rcywgUGFvbG8uIEkgd291
bGQgZm9sbG93IHN1Z2dlc3Rpb25zIGZyb20geW91IHR3by4NCg0KUmVnYXJkcywNCllpIExpdQ0K

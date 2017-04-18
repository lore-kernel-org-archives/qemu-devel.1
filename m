Received: from eggs.gnu.org ([2001:4830:134:3::10]:54065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1d0ME3-0002f1-G9
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:02:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1d0MDy-0008Ku-Gi
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:02:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:49019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1d0MDy-0008KW-4v
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:02:50 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Tue, 18 Apr 2017 06:02:44 +0000
Message-ID: <A2975661238FB949B60364EF0F2C2574390540D1@shsmsx102.ccr.corp.intel.com>
References: <1492428730-13438-1-git-send-email-peterx@redhat.com>
	<1492428730-13438-8-git-send-email-peterx@redhat.com>
	<A2975661238FB949B60364EF0F2C257439054049@shsmsx102.ccr.corp.intel.com>
	<20170418045400.GC22226@pxdev.xzpeter.org>
In-Reply-To: <20170418045400.GC22226@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough
 (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

PiA+IEhpIFBldGVyLA0KPiA+DQo+ID4gU2tpcCBhZGRyZXNzIHNwYWNlIHN3aXRjaGluZyBpcyBh
IGdvb2QgaWRlYSB0byBzdXBwb3J0IFBhc3N0aHJ1IG1vZGUuDQo+ID4gSG93ZXZlciwgd2l0aG91
dCB0aGUgYWRkcmVzcyBzcGFjZSwgdGhlIHZmaW8gbm90aWZpZXIgd291bGQgbm90IGJlDQo+ID4g
cmVnaXN0ZXJlZCwgdGh1cyB2SU9NTVUgZW11bGF0b3IgaGFzIG5vIHdheSB0byBjb25uZWN0IHRv
IGhvc3QuIEl0IGlzDQo+ID4gbm8gaGFybSBpZiB0aGVyZSBpcyBvbmx5IG1hcC91bm1hcCBub3Rp
Zmllci4gQnV0IGlmIHdlIGhhdmUgbW9yZQ0KPiA+IG5vdGlmaWVycyBvdGhlciB0aGFuIG1hcC91
bm1hcCwgaXQgbWF5IGJlIGEgcHJvYmxlbS4NCj4gPg0KPiA+IEkgdGhpbmsgd2UgbmVlZCB0byBy
ZWNvbnNpZGVyIGl0IGhlcmUuDQo+IA0KPiBGb3Igbm93IEkgdGhpbmsgYXMgc3dpdGNoaW5nIGlz
IGdvb2QgdG8gdXMgaW4gZ2VuZXJhbC4gQ291bGQgSSBrbm93IG1vcmUgY29udGV4dA0KPiBhYm91
dCB0aGlzPyBXb3VsZCBpdCBiZSBva2F5IHRvIHdvcmsgb24gdG9wIG9mIHRoaXMgaW4gdGhlIGZ1
dHVyZT8NCj4gDQoNCkxldCBtZSBleHBsYWluLiBGb3IgdlNWTSBlbmFibGluZywgaXQgbmVlZHMg
dG8gYWRkIG5ldyBub3RpZmllciB0byBiaW5kIGdQQVNJRCB0YWJsZQ0KdG8gaG9zdC4gSWYgYW4g
YXNzaWduZWQgZGV2aWNlIHVzZXMgU1ZNIGluIGd1ZXN0LCBhcyBkZXNpZ25lZCBndWVzdCBJT01N
VSBkcml2ZXIgd291bGQNCnNldCAicHQiIGZvciBpdC4gVGhpcyBpcyB0byBtYWtlIHN1cmUgdGhl
IGhvc3Qgc2Vjb25kLWxldmVsIHBhZ2UgdGFibGUgc3RvcmVzIEdQQS0+SFBBDQptYXBwaW5nLiBT
byB0aGF0IHBJT01NVSBjYW4gZG8gbmVzdGVkIHRyYW5zbGF0aW9uIHRvIGFjaGlldmUgZ1ZBLT5H
UEEgR1BBLT5IUEEgDQptYXBwaW5nLg0KDQpTbyB0aGUgc2l0dWF0aW9uIGlzIGlmIHdlIHdhbnQg
dG8ga2VlcCBHUEEtPkhQQSBtYXBwaW5nLCB3ZSBzaG91bGQgc2tpcCBhZGRyZXNzIHNwYWNlDQpz
d2l0Y2gsIGJ1dCB0aGUgdmZpbyBsaXN0ZW5lciB3b3VsZCBub3Qga25vdyB2SU9NTVUgaXMgYWRk
ZWQsIHNvIG5vIHZmaW8gbm90aWZpZXIgd291bGQNCmJlIHJlZ2lzdGVyZWQuIEJ1dCBpZiB3ZSBk
byB0aGUgc3dpdGNoLCB0aGUgR1BBLT5IUEEgbWFwcGluZyBpcyB1bm1hcHBlZC4gQW5kIG5lZWQN
CmFub3RoZXIgd2F5IHRvIGJ1aWxkIHRoZSBHUEEtPkhQQSBtYXBwaW5nLg0KDQpJIHRoaW5rIHdl
IG1heSBoYXZlIHR3byBjaG9pY2UgaGVyZS4gUGxzIGxldCBtZSBrbm93IHlvdXIgaWRlYXMuDQoN
CjEuIHNraXAgdGhlIHN3aXRjaCBmb3IgInB0IiBtb2RlLCBmaW5kIG90aGVyIHdheSB0byByZWdp
c3RlciB2ZmlvIG5vdGlmaWVycy4gbm90IHN1cmUgaWYgdGhpcw0KaXMgd29ya2FibGUuIEp1c3Qg
YSBxdWljayB0aG91Z2h0Lg0KDQoyLiBkbyB0aGUgc3dpdGNoLCBhbmQgcmVidWlsZCBHUEEtPkhQ
QSBtYXBwaW5nIGlmIGRldmljZSB1c2UgInB0IiBtb2RlLiBGb3IgdGhpcyBvcHRpb24sDQpJIGFs
c28gaGF2ZSB0d28gd2F5IHRvIGJ1aWxkIHRoZSBHUEEtPkhQQSBtYXBwaW5nLg0KYSkgd2FsayBh
bGwgdGhlIG1lbW9yeSByZWdpb24gc2VjdGlvbnMgaW4gYWRkcmVzc19zcGFjZV9tZW1vcnksIGFu
ZCBidWlsZCB0aGUgbWFwcGluZy4NCmFkZHJlc3Nfc3BhY2VfbWVtb3J5LmRpc3BhdGNoLT5tYXAu
c2VjdGlvbnMsIHNlY3Rpb25zIHN0b3JlcyBhbGwgdGhlIG1hcHBlZCBzZWN0aW9ucy4NCg0KYikg
bGV0IGd1ZXN0IGlvbW11IGRyaXZlciBtaW1pY3MgYSAxOjEgbWFwcGluZyBmb3IgdGhlIGRldmlj
ZXMgdXNlICJwdCIgbW9kZS4gaW4gdGhpcyB3YXksDQp0aGUgR1BBLT5IUEEgbWFwcGluZyBjb3Vs
ZCBiZSBzZXR1cCBieSB3YWxraW5nIHRoZSBndWVzdCBTTCBwYWdlIHRhYmxlLiBUaGlzIGlzIGNv
bnNpc3RlbnQNCndpdGggeW91ciB2SU9WQSByZXBsYXkgc29sdXRpb24uDQoNCkFsc28gSSdtIGN1
cmlvdXMgaWYgVGlhbnl1J3MgZmF1bHQgcmVwb3J0IGZyYW1ld29yayBuZWVkcyB0byByZWdpc3Rl
ciBuZXcgbm90aWZpZXJzLg0KDQpUaGFua3MsDQpZaSBMDQo=

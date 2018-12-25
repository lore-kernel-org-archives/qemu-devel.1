Received: from eggs.gnu.org ([208.118.235.92]:54143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1gbc0B-0000F4-L4
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 20:59:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1gbc06-0005zW-Ml
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 20:59:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:15718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1gbc05-0005vm-12
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 20:59:17 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Tue, 25 Dec 2018 01:59:07 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19BEBDB0C@SHSMSX101.ccr.corp.intel.com>
References: <20181218134540.2q43v6fpvzbsam6h@linux.intel.com>
	<20181218094527-mutt-send-email-mst@kernel.org>
	<20181219034006.d4drqoz5b6r6h3mn@linux.intel.com>
	<20181218233451-mutt-send-email-mst@kernel.org>
	<20181219055743.okeszdqlqkg7tagk@linux.intel.com>
	<20181219100355-mutt-send-email-mst@kernel.org>
	<20181220054921.sk5wnmlo2vvjgcs6@linux.intel.com>
	<20181220132644-mutt-send-email-mst@kernel.org>
	<20181221161920.45fnlmcp7aqu6ibi@linux.intel.com>
	<20181221120657-mutt-send-email-mst@kernel.org>
	<20181221173401.cb5vgokgxopnnpes@linux.intel.com>
In-Reply-To: <20181221173401.cb5vgokgxopnnpes@linux.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 2/2] intel-iommu: extend VTD emulation
 to allow 57-bit IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, "Liu, Yi L" <yi.l.liu@intel.com>

PiBGcm9tOiBZdSBaaGFuZw0KPiBTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIgMjIsIDIwMTggMToz
NCBBTQ0KPiANClsuLi5dDQo+ID4NCj4gPiA+IEFzIHRvIHRoZSBjaGVjayBhZ2FpbnN0IGhhcmR3
YXJlIElPTU1VLCBQZXRlciBvbmNlIGhhZCBhIHByb3Bvc2FsIGluDQo+ID4gPiBodHRwOi8vbGlz
dHMubm9uZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4LQ0KPiAxMS9tc2cwMjI4
MS5odG1sDQo+ID4gPg0KPiA+ID4gRG8geW91IGhhdmUgYW55IGNvbW1lbnQgb3Igc3VnZ2VzdGlv
biBvbiBQZXRlcidzIHByb3Bvc2FsPw0KPiA+DQo+ID4gU291bmRzIHJlYXNvbmFibGUgdG8gbWUu
IERvIHdlIGRvIGl0IG9uIHZmaW8gYXR0YWNoIG9yIHVuY29uZGl0aW9uYWxseT8NCj4gPg0KPiAN
Cj4gSSBndWVzcyBvbiB2ZmlvIGF0dGFjaD8gV2lsbCBuZWVkIG1vcmUgdGhpbmtpbmcgaW4gaXQu
DQo+IA0KDQplaXRoZXIgd2F5IGlzIG5vdCBwZXJmZWN0LiBVbmNvbmRpdGlvbmFsIGNoZWNrIGRv
ZXNuJ3QgbWFrZSBzZW5zZSBpZg0KdGhlcmUgaXMgbm8gdmZpbyBkZXZpY2UgYXR0YWNoZWQsIHdo
aWxlIHZmaW8gYXR0YWNoIG1pZ2h0IGhhcHBlbiBsYXRlDQooZS5nLiBob3RwbHVnKSBhZnRlciB2
SU9NTVUgaXMgaW5pdGlhbGl6ZWQuLi4NCg0KQmFzaWNhbGx5IHRoZXJlIGFyZSB0d28gY2hlY2tz
IHRvIGJlIGNvbmNlcm5lZC4gT25lIGlzIHRoZSBjaGVjayBhdCANCmJvb3QgdGltZSwgd2hpY2gg
ZGVjaWRlcyB2SU9NTVUgY2FwYWJpbGl0aWVzLiBUaGUgb3RoZXIgaXMgdGhlIGNoZWNrIA0KYXQg
dmZpbyBhdHRhY2gsIHdoaWNoIGRlY2lkZXMgd2hldGhlciBhdHRhY2htZW50IGNhbiBzdWNjZWVk
IChpLmUuDQp3aGV0aGVyIHRoZSB2SU9NTVUgY2FwYWJpbGl0aWVzIHdoaWNoIGFyZSB1c2VkIGJ5
IGRldmljZSBhcmUgaW5kZWVkDQpzdXBwb3J0ZWQgYnkgaGFyZHdhcmUpLiANCg0KUG9zc2libHkg
d2UgY2FuIG1ha2UgYm9vdC10aW1lIGNoZWNrIGNvbmZpZ3VyYWJsZS4gDQoNCklmIGJvb3QtdGlt
ZSBjaGVjayBpcyB0dXJuZWQgb24sIHZJT01NVSBjYXBhYmlsaXRpZXMgYXJlIGFsd2F5cyBhIA0K
c3Vic2V0IG9mIHBJT01NVSByZWdhcmRsZXNzIG9mIHdoZXRoZXIgdmZpbyBkZXZpY2UgaXMgYXR0
YWNoZWQuIA0KY2hlY2sgb24gdmZpbyBhdHRhY2ggbWF5IGJlIHNraXBwZWQgc2luY2UgaXQgd2ls
bCBhbHdheXMgcGFzcy4gdmlydHVhbCANCmRldmljZXMgYWxzbyBiZWFyIHdpdGggc2FtZSBsaW1p
dGF0aW9uIG9mIHBJT01NVS4gDQoNCklmIGJvb3QtdGltZSBjaGVjayBpcyBvZmYsIHZJT01NVSBj
YXBhYmlsaXRpZXMgYXJlIGFsd2F5cyBzcGVjaWZpZWQgDQpieSBlbmQgdXNlciwgd2hpY2ggbWln
aHQgYmUgZGlmZmVyZW50IGZyb20gcElPTU1VLiB2aXJ0dWFsIGRldmljZXMgDQpjYW4gdXNlIGFu
eSBjYXBhYmlsaXR5LCBidXQgdmZpbyBhdHRhY2ggbWF5IGZhaWwgaWYgcmVxdWlyZWQgdklPTU1V
DQpjYXBhYmlsaXRpZXMgYXJlIG5vdCBzdXBwb3J0ZWQgYnkgcElPTU1VLg0KDQpidHcgNSBsZXZl
bCBpcyBqdXN0IG9uZSBleGFtcGxlIG9mIGRlbWFuZGluZyBjaGVjayB3aXRoIHBJT01NVS4gDQpU
aGVyZSBhcmUgbW9yZSB3aGVuIGVtdWxhdGluZyBWVC1kIHNjYWxhYmxlIG1vZGUgKCtZaSkuDQoN
ClRoYW5rcw0KS2V2aW4NCg==

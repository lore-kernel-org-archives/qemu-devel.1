Received: from eggs.gnu.org ([2001:4830:134:3::10]:50716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1ereoO-0005ta-G0
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1ereoL-0003iN-A4
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:09:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:46107)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1ereoK-0003gL-VL
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 02:08:57 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 2 Mar 2018 07:08:51 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19102545C@SHSMSX101.ccr.corp.intel.com>
References: <20180228195504.25283.45666.stgit@gimli.home>
In-Reply-To: <20180228195504.25283.45666.stgit@gimli.home>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/3] vfio/pci: ioeventfd support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>

PiBGcm9tOiBBbGV4IFdpbGxpYW1zb24NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDEsIDIwMTgg
NDoxNSBBTQ0KPiANCj4gQSB2ZmlvIGlvZXZlbnRmZCB3aWxsIHBlcmZvcm0gdGhlIHByZS1zcGVj
aWZpZWQgZGV2aWNlIHdyaXRlIG9uDQo+IHRyaWdnZXJpbmcgb2YgYW4gZXZlbnRmZC4gIFdoZW4g
Y291cGxlZCB3aXRoIEtWTSBpb2V2ZW50ZmRzLCB0aGlzDQo+IGZlYXR1cmUgYWxsb3dzIGEgVk0g
dG8gdHJhcCBhIGRldmljZSBwYWdlIGZvciB2aXJ0dWFsaXphdGlvbiwgd2hpbGUNCj4gYWxzbyBy
ZWdpc3RlcmluZyB0YXJnZXRlZCBpb2V2ZW50ZmRzIHRvIG1haW50YWluIHBlcmZvcm1hbmNlIG9m
IGhpZ2gNCj4gZnJlcXVlbmN5IHJlZ2lzdGVyIHdyaXRlcyB3aXRoaW4gdGhlIHRyYXBwZWQgcmFu
Z2UuICBNdWNoIGxpa2UgdGhlDQo+IGV4aXN0aW5nIGludGVycnVwdCBldmVudGZkL2lycWZkIGNv
dXBsaW5nLCBzdWNoIHdyaXRlcyBjYW4gYmUgaGFuZGxlZA0KPiBlbnRpcmVseSBpbiB0aGUgaG9z
dCBrZXJuZWwuDQo+IA0KPiBUaGUgbmV3IFZGSU8gZGV2aWNlIGlvY3RsIG1heSBiZSBzdXBwb3J0
ZWQgYnkgYW55IHZmaW8gYnVzIGRyaXZlciwNCj4gaW5jbHVkaW5nIG1kZXYgZHJpdmVycywgYnV0
IHRoZSBpbXBsZW1lbnRhdGlvbiBoZXJlIG9ubHkgZW5hYmxlcw0KPiB2ZmlvLXBjaS4gIFRoaXMg
aXMgaW50ZW5kZWQgYXMgYW4gYWNjZWxlcmF0aW9uIHBhdGgsIGJ1cyBkcml2ZXJzDQo+IG1heSBj
aG9vc2Ugd2hpY2ggcmVnaW9ucyB0byBzdXBwb3J0IGFuZCB1c2Vyc3BhY2Ugc2hvdWxkIGFsd2F5
cw0KPiBpbnRlbmQgdG8gZmFsbCBiYWNrIHRvIG5vbi1hY2NlbGVyYXRlZCBoYW5kbGluZyB3aGVu
IHVuYXZhaWxhYmxlLg0KPiANCg0KaXQncyBhIG5pY2UgZmVhdHVyZSEgQSBjdXJpb3VzIHF1ZXN0
aW9uLiBJcyBpdCBwb3NzaWJsZSBmb3IgbWRldiBkcml2ZXINCnRvIGRpcmVjdGx5IGNyZWF0ZSBp
b2V2ZW50ZmQgb24gc3BlY2lmaWVkIG9mZnNldD8gQ3VycmVudGx5IGlvZXZlbnRmZA0KcmVxdWly
ZXMgcXVpcmtzIGluIFFlbXUsIHdoaWNoIG11c3Qga25vdyB0aGUgZGV2aWNlIGRldGFpbCB0bw0K
Y3JlYXRlIGlvZXZlbnRmZCBhbmQgdGhlbiBjb25uZWN0IHZmaW8gYW5kIGt2bSB0b2dldGhlci4g
SG93ZXZlcg0KbWRldiBpbnN0YW5jZSBpcyBtb3JlIHNvZnR3YXJlIGRlZmluZWQgdGh1cyBJJ20g
bm90IHN1cmUgd2hldGhlciANCmFza2luZyBRZW11IHRvIGNhdGNoIHVwIHF1aXJrIHdpdGggdW5k
ZXJseWluZyBzb2Z0d2FyZSBsb2dpYyBjb3VsZA0KYmUgb3ZlcndoZWxtZWQuIEFsc28gaW4gY2Fz
ZSBvZiB2ZW5kb3IgZHJpdmVyIGVtdWxhdGluZyBtZGV2DQp3aXRoIHNhbWUgRElEL1ZJRCBhcyBh
IHJlYWwgZGV2aWNlLCBpdCBtaWdodCBiZSBkaWZmaWN1bHQgZm9yIFFlbXUNCnRvIGZpZ3VyZSBv
dXQgd2hldGhlciBhIHZmaW8gZGV2aWNlIGlzIGEgcmVhbCBvbmUgb3IgbWRldiBvbmUgdG8NCmFw
cGx5IGEgbWRldiBzcGVjaWZpYyBxdWlyay4gT24gdGhlIG90aGVyIGhhbmQsIHNpbmNlIHZlbmRv
cg0KZHJpdmVyIGtub3dzIGFsbCB0aGUgbG9naWMgY29uc3RydWN0aW5nIG1kZXYsIGl0IHdvdWxk
IGJlIG1vcmUNCmNvbnZlbmllbnQgYWxsb3dpbmcgdmVuZG9yIGRyaXZlciB0byBkaXJlY3RseSBj
cmVhdGUvZGVzdHJveQ0KaW9ldmVudGZkIG9uIGl0cyBkZW1hbmQ/DQoNClRoYW5rcw0KS2V2aW4N
Cg==

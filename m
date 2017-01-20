Received: from eggs.gnu.org ([2001:4830:134:3::10]:33711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUVIH-00048C-4H
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUVIC-0003MZ-2i
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:15:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:53443)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cUVIB-0003Li-Ov
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:15:31 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 20 Jan 2017 09:15:27 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C15103@SHSMSX101.ccr.corp.intel.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-3-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14F86@SHSMSX101.ccr.corp.intel.com>
	<20170120090506.GJ4914@pxdev.xzpeter.org>
In-Reply-To: <20170120090506.GJ4914@pxdev.xzpeter.org>
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
YXksIEphbnVhcnkgMjAsIDIwMTcgNTowNSBQTQ0KPiANCj4gT24gRnJpLCBKYW4gMjAsIDIwMTcg
YXQgMDg6MjI6MTRBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBQZXRl
ciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiA+ID4gU2VudDogRnJpZGF5LCBKYW51
YXJ5IDEzLCAyMDE3IDExOjA2IEFNDQo+ID4gPg0KPiA+ID4gQmVmb3JlIHdlIGhhdmUgaW50LXJl
bWFwLCB3ZSBuZWVkIHRvIGJ5cGFzcyBpbnRlcnJ1cHQgd3JpdGUgcmVxdWVzdHMuDQo+ID4gPiBU
aGF0J3Mgbm90IG5lY2Vzc2FyeSBub3cgLSB3ZSBoYXZlIHN1cHBvcnRlZCBpbnQtcmVtYXAsIGFu
ZCBhbGwgdGhlIGlycQ0KPiA+ID4gcmVnaW9uIHJlcXVlc3RzIHNob3VsZCBiZSByZWRpcmVjdGVk
IHRoZXJlLiBDbGVhbmluZyB1cCB0aGUgYmxvY2sgd2l0aA0KPiA+ID4gYW4gYXNzZXJ0aW9uIGlu
c3RlYWQuDQo+ID4NCj4gPiBUaGlzIGNvbW1lbnQgaXMgbm90IGFjY3VyYXRlLiBBY2NvcmRpbmcg
dG8gY29kZSwgdGhlIHJlYXNvbiB3aHkgeW91DQo+ID4gY2FuIGRvIHN1Y2ggc2ltcGxpZmljYXRp
b24gaXMgYmVjYXVzZSB3ZSBoYXZlIHN0YW5kYWxvbmUgbWVtb3J5DQo+ID4gcmVnaW9uIG5vdyBm
b3IgaW50ZXJydXB0IGFkZHJlc3Nlcy4gVGhlcmUgc2hvdWxkIGJlIG5vdGhpbmcgdG8gZG8NCj4g
PiB3aXRoIGludC1yZW1hcCwgd2hpY2ggY2FuIGJlIGRpc2FibGVkIGJ5IGd1ZXN0Li4uIE1heWJl
IHRoZSBzdGFuZGFsb25lDQo+ID4gcmVnaW9uIHdhcyBhZGRlZCB3aGVuIGRldmVsb3BpbmcgaW50
LXJlbWFwLCBidXQgZnVuY3Rpb25hbGx5IHRoZXkNCj4gPiBhcmUgbm90IHJlbGF0ZWQuIDotKQ0K
PiANCj4gSU1ITyB0aGUgYWJvdmUgY29tbWl0IG1lc3NhZ2UgaXMgZmFpcmx5IGNsZWFyLiA6LSkN
Cj4gDQo+IEJ1dCBzdXJlIEkgY2FuIGFkZCBzb21lIG1vcmUgZW1waGFzaXNlIGxpa2U6DQo+IA0K
PiAgICJCZWZvcmUgd2UgaGF2ZSBpbnQtcmVtYXAgbWVtb3J5IHJlZ2lvbiwgLi4uIg0KPiANCj4g
RG8geW91IHRoaW5rIGl0J3Mgb2theT8gT3IgYW55IGJldHRlciBzdWdnZXN0aW9uPw0KPiANCj4g
KEp1c3QgdG8gbWVudGlvbiB0aGF0IGV2ZW4gZ3Vlc3QgZGlzYWJsZXMgSVIsIHRoZSBNU0kgcmVn
aW9uIHdpbGwNCj4gIHN0aWxsIGJlIHRoZXJlLikNCj4gDQoNCk15IG9wdGlvbiBpcyBzaW1wbGUg
LSB0aGlzIHBhdGNoIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggaW50LXJlbWFwLg0KSXQncyBub3Qg
bmVjZXNzYXJ5LCBub3QgYmVjYXVzZSB3ZSBzdXBwb3J0ZWQgaW50LXJlbWFwLiBJdCdzIGJlY2F1
c2UNCndlIGhhdmUgYSBzdGFuZGFsb25lIG1lbW9yeSByZWdpb24gZm9yIGludGVycnVwdCBhZGRy
ZXNzZXMsIGFzIHlvdQ0KZGVzY3JpYmVkIGluIHRoZSBjb2RlLiA6LSkNCg0KVGhhbmtzDQpLZXZp
bg0K

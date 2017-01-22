Received: from eggs.gnu.org ([2001:4830:134:3::10]:54953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cV9yy-0002Xg-Ms
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 23:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cV9yv-000219-J9
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 23:42:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:39423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cV9yv-00020N-9q
	for qemu-devel@nongnu.org; Sat, 21 Jan 2017 23:42:21 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Sun, 22 Jan 2017 04:42:13 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C16A18@SHSMSX101.ccr.corp.intel.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-3-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14F86@SHSMSX101.ccr.corp.intel.com>
	<20170120090506.GJ4914@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C15103@SHSMSX101.ccr.corp.intel.com>
	<20170120092736.GM4914@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C1525C@SHSMSX101.ccr.corp.intel.com>
	<20170120100426.GO4914@pxdev.xzpeter.org>
In-Reply-To: <20170120100426.GO4914@pxdev.xzpeter.org>
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
YXksIEphbnVhcnkgMjAsIDIwMTcgNjowNCBQTQ0KPiANCj4gT24gRnJpLCBKYW4gMjAsIDIwMTcg
YXQgMDk6NTI6MDFBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiAN
Cj4gPiBidHcgd2hhdCBhYm91dCBndWVzdCBzZXR1cHMgYSB2YWxpZCBtYXBwaW5nIGF0IDB4RkVF
eF94eHh4IGluDQo+ID4gaXRzIHJlbWFwcGluZyBzdHJ1Y3R1cmUsIHdoaWNoIGlzIHRoZW4gcHJv
Z3JhbW1lZCB0byB2aXJ0dWFsDQo+ID4gZGV2aWNlIGFzIERNQSBkZXN0aW5hdGlvbj8gVGhlbiB3
aGVuIGVtdWxhdGluZyB0aGF0IHZpcnR1YWwgRE1BLA0KPiA+IHZ0ZF9kb19pb21tdV90cmFuc2xh
dGUgc2hvdWxkIHNpbXBseSByZXR1cm4gKG1heWJlIHRocm93IG91dA0KPiA+IGEgd2FybmluZyBm
b3IgZGlhZ25vc3RpYyBwdXJwb3NlKSBpbnN0ZWFkIG9mIGFzc2VydCBoZXJlLg0KPiA+DQo+ID4g
VlQtZCBzcGVjIGRlZmluZXMgYXMgYmVsb3c6DQo+ID4NCj4gPiAJU29mdHdhcmUgbXVzdCBlbnN1
cmUgdGhlIHNlY29uZC1sZXZlbCBwYWdpbmctc3RydWN0dXJlIGVudHJpZXMNCj4gPiAJYXJlIHBy
b2dyYW1tZWQgbm90IHRvIHJlbWFwIGlucHV0IGFkZHJlc3NlcyB0byB0aGUgaW50ZXJydXB0DQo+
ID4gCWFkZHJlc3MgcmFuZ2UuIEhhcmR3YXJlIGJlaGF2aW9yIGlzIHVuZGVmaW5lZCBmb3IgbWVt
b3J5DQo+ID4gCXJlcXVlc3RzIHJlbWFwcGVkIHRvIHRoZSBpbnRlcnJ1cHQgYWRkcmVzcyByYW5n
ZS4NCj4gDQo+IFRoYW5rcyBmb3IgdGhpcyByZWZlcmVuY2UuIFRoYXQncyBzb21ldGhpbmcgSSB3
YXMgY3VyaW91cyBhYm91dC4NCj4gDQo+ID4NCj4gPiBJIGRvbid0IHRoaW5rICJoYXJkd2FyZSBi
ZWhhdmlvciBpcyB1bmRlZmluZWQiIGlzIGVxdWFsIHRvICJhc3NlcnQNCj4gPiB0aHVzIGtpbGwg
Vk0iLi4uDQo+IA0KPiBJIGRvbid0IHRoaW5rIGl0IHdpbGwga2lsbCB0aGUgVk0uIEFmdGVyIHdl
IGhhdmUgdGhlIE1TSSByZWdpb24sIGl0DQo+IHNob3VsZCBqdXN0IHVzZSB0aGF0IElSIHJlZ2lv
biBmb3IgZXZlcnl0aGluZyAocmVhZC93cml0ZS90cmFuc2xhdGUpLg0KPiBTbyBpaXVjIHdoZW4g
YW55b25lIHNldHVwcyBJT1ZBIG1hcHBpbmcgd2l0aGluIHJhbmdlIDB4ZmVleHh4eHgsIHRoZW4N
Cj4gYSBETUEgd2lsbCB0cmlnZ2VyIGFuIGludGVycnVwdCAocmF0aGVyIHRoYW4gbWVtb3J5IG1v
dmVzKSwgYnV0IGluDQo+IG1vc3QgY2FzZXMgdGhlIGludGVycnVwdCB3aWxsIGJlIGlsbGVnYWwg
c2luY2UgZWl0aGVyIHRoZSBkYXRhIGlzDQo+IGludmFsaWQgKGUuZy4sIG5vbi16ZXJvIHJlc2Vy
dmVkIGJpdHMsIG9yIFNJRCB2ZXJpZmljYXRpb24gZmFpbHVyZSksDQo+IGZ1cnRoZXIgaXQgc2hv
dWxkIHRyaWdnZXIgYSB2SU9NTVUgZmF1bHQgKHRob3VnaCBJUiBmYXVsdCByZXBvcnRpbmcgaXMN
Cj4gc3RpbGwgaW5jb21wbGV0ZSwgdGhhdCdzIG15IG5leHQgdGhpbmcgdG8gZG8gYWZ0ZXIgdGhp
cyBzZXJpZXMpLg0KPiANCg0KWWVzLCB5b3UncmUgcmlnaHQgaGVyZS4gU29ycnkgZm9yIGJvdGhl
cmluZyB3aXRoIG15IHdyb25nIHVuZGVyc3RhbmRpbmcuIDotKQ0KDQpUaGFua3MNCktldmluDQo=

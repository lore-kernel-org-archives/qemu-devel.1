Received: from eggs.gnu.org ([209.51.188.92]:40342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1guCWD-0002WK-MQ
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1guCHc-0007Ps-Nz
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:22:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:49907)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1guCHc-0007KL-Eo
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:22:12 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Thu, 14 Feb 2019 08:22:05 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19C9403C2@SHSMSX104.ccr.corp.intel.com>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<1548824953-23413-3-git-send-email-yi.y.sun@linux.intel.com>
	<20190212062728.GK1011@xz-x1> <20190213090041.GF16968@yi.y.sun>
	<20190213104224.GA4405@xz-x1> <20190214015204.GG16968@yi.y.sun>
	<20190214032435.GA3197@xz-x1> <20190214062730.GH16968@yi.y.sun>
	<20190214071330.GA9932@xz-x1>
	<AADFC41AFE54684AB9EE6CBC0274A5D19C9402DA@SHSMSX104.ccr.corp.intel.com>
	<20190214081305.GB9932@xz-x1>
In-Reply-To: <20190214081305.GB9932@xz-x1>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1 2/3] intel_iommu: add 256 bits qi_desc
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Yi Sun <yi.y.sun@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVy
c2RheSwgRmVicnVhcnkgMTQsIDIwMTkgNDoxMyBQTQ0KPiANCj4gT24gVGh1LCBGZWIgMTQsIDIw
MTkgYXQgMDc6MzU6MjBBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBQ
ZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiA+ID4gU2VudDogVGh1cnNkYXks
IEZlYnJ1YXJ5IDE0LCAyMDE5IDM6MTQgUE0NCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID4gV2hl
biAyNTYgYml0cyBpbnZhbGlkYXRpb24gZGVzY3JpcHRvciBpcyB1c2VkLCB0aGUgZ3Vlc3QgZHJp
dmVyDQo+ID4gPiA+ID4gc2hvdWxkIGJlIHJlc3BvbnNpYmxlIHRvIGZpbGwgaW4gemVyb3MgaW50
byByZXNlcnZlZCBmaWVsZHMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbm90aGVyIHF1ZXN0aW9u
OiBpcyB2YWxbMl0gJiB2YWxbM10gdXNlZCBpbiBhbnkgcGxhY2UgZXZlbiB3aXRoDQo+ID4gPiA+
ID4gMjU2Yml0cyBtb2RlPyAgRnJvbSB3aGF0IEkgc2VlIGZyb20gdGhlIHNwZWMgKGNoYXAgNi41
LjIpLCBhbGwgb2YNCj4gdGhlbQ0KPiA+ID4gPiA+IHNlZW1zIHRvIGJlIHJlc2VydmVkIGFzIHpl
cm9zLCB0aGVuIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgYm90aGVyDQo+ID4gPiA+ID4gZXh0ZW5k
aW5nIHRoaXMgdG8gMjU2Yml0cy4uLiAgRGlkIEkgbWlzcyBzb21ldGhpbmc/DQo+ID4gPiA+ID4N
Cj4gPg0KPiA+IFBSUSBpcyBleHRlbmRlZCB0byBjYXJyeSBsYXJnZXIgcHJpdmF0ZSBkYXRhIHdo
aWNoIHJlcXVpcmVzIDI1NmJpdHMNCj4gPiBtb2RlLiBZb3UgY2FuIHRha2UgYSBsb29rIGF0IDcu
NS4xLjEgUGFnZSBSZXF1ZXN0IERlc2NyaXB0b3IuDQo+IA0KPiBCdXQgd2UgYXJlIHRhbGtpbmcg
YWJvdXQgSVEgKEludmFsaWRhdGlvbiBRdWV1ZSksIG5vdCBQUlEsIHJpZ2h0Pw0KPiANCj4gSSBz
ZWUgdGhhdCBQYWdlIFJlcXVlc3QgUXVldWUgc2VlbXMgdG8gYWx3YXlzIGhhdmUgMjU2Yml0cyBk
ZXNjcmlwdG9ycw0KPiAoY2hhcCAxMC40LjMyLCB0aGVyZSBpcyBubyBEZXNjcmlwdG9yIFdpZHRo
IGZpZWxkLCBhbmQgSSB0aGluayBpdA0KPiBtZWFucyBEVz09MSBhbHdheXMpLCBob3dldmVyIHRo
ZSBJbnZhbGlkYXRpb24gUXVldWUgc2VlbXMgdG8gc3VwcG9ydA0KPiBib3RoIG1vZGVzIChjaGFw
IDEwLjQuMjMsIHRoZXJlIGlzIERlc2NyaXB0b3IgV2lkdGggZmllbGQsIERXPT0wDQo+IHNob3Vs
ZCBiZSB0aGUgbGVnYWN5IG1vZGUsIGFuZCBEVz09MSBzaG91bGQgYmUgdGhlIG5ldyBtb2RlKS4g
IFdoaWxlLA0KPiBub25lIG9mIHRoZSBpbnZhbGlkYXRlIGRlc2NyaXB0b3JzIGRlc2NyaWJlZCBp
biBjaGFwIDYuNS4yIGlzIHVzaW5nDQo+IHRoZSB1cHBlciAxMjhiaXRzIGV2ZW4gaWYgMjU2Yml0
cyBtb2RlIGlzIHN1cHBvcnRlZC4NCj4gDQoNClBhZ2UgR3JvdXAgUmVzcG9uc2UgZGVzY3JpcHRv
ciBpcyBjb21wb3NlZCBieSBzb2Z0d2FyZSB0aHJvdWdoDQppbnZhbGlkYXRpb24gcXVldWUsIHdo
aWNoIG5lZWRzIHRvIGNhcnJ5IHNhbWUgcHJpdmF0ZSBkYXRhIGJhY2sNCihhcyBpbiBwYWdlIHJl
cXVlc3QgZGVzY3JpcHRvcikuIGl0J3MgZGVzY3JpYmVkIGluIDcuNy4xLg0KDQpUaGFua3MNCktl
dmluDQo=

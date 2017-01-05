Received: from eggs.gnu.org ([2001:4830:134:3::10]:60878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cOzSQ-0005zX-CZ
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cOzSN-0001rP-75
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:15:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:30916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cOzSM-0001qi-Ue
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 23:15:15 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Thu, 5 Jan 2017 04:15:08 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190BF8158@SHSMSX101.ccr.corp.intel.com>
References: <1482400096-23078-1-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190BF810D@SHSMSX101.ccr.corp.intel.com>
	<20170105035244.GO22664@pxdev.xzpeter.org>
In-Reply-To: <20170105035244.GO22664@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] intel_iommu: allow dynamic switch of
 IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVy
c2RheSwgSmFudWFyeSAwNSwgMjAxNyAxMTo1MyBBTQ0KPiANCj4gPiA+ICAvKiBIYW5kbGUgVHJh
bnNsYXRpb24gRW5hYmxlL0Rpc2FibGUgKi8NCj4gPiA+ICBzdGF0aWMgdm9pZCB2dGRfaGFuZGxl
X2djbWRfdGUoSW50ZWxJT01NVVN0YXRlICpzLCBib29sIGVuKQ0KPiA+ID4gIHsNCj4gPiA+ICsg
ICAgaWYgKHMtPmRtYXJfZW5hYmxlZCA9PSBlbikgew0KPiA+ID4gKyAgICAgICAgcmV0dXJuOw0K
PiA+ID4gKyAgICB9DQo+ID4gPiArDQo+ID4gPiAgICAgIFZURF9EUFJJTlRGKENTUiwgIlRyYW5z
bGF0aW9uIEVuYWJsZSAlcyIsIChlbiA/ICJvbiIgOiAib2ZmIikpOw0KPiA+ID4NCj4gPiA+ICAg
ICAgaWYgKGVuKSB7DQo+ID4gPiBAQCAtMTE5Niw2ICsxMjM3LDggQEAgc3RhdGljIHZvaWQgdnRk
X2hhbmRsZV9nY21kX3RlKEludGVsSU9NTVVTdGF0ZSAqcywgYm9vbA0KPiBlbikNCj4gPiA+ICAg
ICAgICAgIC8qIE9rIC0gcmVwb3J0IGJhY2sgdG8gZHJpdmVyICovDQo+ID4gPiAgICAgICAgICB2
dGRfc2V0X2NsZWFyX21hc2tfbG9uZyhzLCBETUFSX0dTVFNfUkVHLCBWVERfR1NUU19URVMsIDAp
Ow0KPiA+ID4gICAgICB9DQo+ID4gPiArDQo+ID4gPiArICAgIHZ0ZF9zd2l0Y2hfYWRkcmVzc19z
cGFjZV9hbGwocywgZW4pOw0KPiA+ID4gIH0NCj4gPg0KPiA+IEEgY29udGV4dCBlbnRyeSBjYW4g
YmUgY29uZmlndXJlZCBhcyBwYXNzLXRocm91Z2gsIG1lYW5pbmcgbm8gYWRkcg0KPiA+IHRyYW5z
bGF0aW9uIGZvciBETUFzIGZyb20gdGhpcyBkZXZpY2Ugd2hlbiBJT01NVSBpcyBnbG9iYWxseSBl
bmFibGVkLg0KPiA+IFRoZXJlIGlzIG5vIHRyYW5zbGF0aW9uIHN0cnVjdHVyZSBwZXIgc2UsIHNv
ICdzeXNfYWxpYXMiIGlzIGFsc28gcmVxdWlyZWQNCj4gPiBpbiBzdWNoIGNvbmZpZ3VyYXRpb24u
DQo+IA0KPiBSaWdodC4gQnV0IGN1cnJlbnQgdnQtZCBlbXVsYXRpb24gc3RpbGwgZG9lc24ndCBz
dXBwb3J0IHBlci1kZXZpY2UNCj4gcGFzcy10aHJvdWdoLiBTZWUgdnRkX2Rldl90b19jb250ZXh0
X2VudHJ5KCk6DQo+IA0KPiAgICAgLi4uDQo+ICAgICB9IGVsc2UgaWYgKGNlLT5sbyAmIFZURF9D
T05URVhUX0VOVFJZX1RUKSB7DQo+ICAgICAgICAgVlREX0RQUklOVEYoR0VORVJBTCwgImVycm9y
OiB1bnN1cHBvcnRlZCBUcmFuc2xhdGlvbiBUeXBlIGluICINCj4gICAgICAgICAgICAgICAgICAg
ICAiY29udGV4dC1lbnRyeSBoaSAweCUiUFJJeDY0ICIgbG8gMHglIlBSSXg2NCwNCj4gICAgICAg
ICAgICAgICAgICAgICBjZS0+aGksIGNlLT5sbyk7DQo+ICAgICAgICAgcmV0dXJuIC1WVERfRlJf
Q09OVEVYVF9FTlRSWV9JTlY7DQo+ICAgICB9DQo+ICAgICAuLi4NCj4gDQo+IEFuZDoNCj4gDQo+
ICAgICAjZGVmaW5lIFZURF9DT05URVhUX0VOVFJZX1RUICAgICAgICAoM1VMTCA8PCAyKSAvKiBU
cmFuc2xhdGlvbiBUeXBlICovDQo+ICAgICAjZGVmaW5lIFZURF9DT05URVhUX1RUX1BBU1NfVEhS
T1VHSCAyDQo+IA0KPiBJTU8gd2UgY2FuIGFkZCBpdCB3aGVuIHdlIHN1cHBvcnQgZGV2aWNlIHBh
c3N0aHJvdWdoLg0KPiANCg0KVGhlbiBmaW5lIHdpdGggbWUuIDotKQ0KDQpUaGFua3MNCktldmlu
DQo=

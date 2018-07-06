Received: from eggs.gnu.org ([2001:4830:134:3::10]:56956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fbMAd-0005oK-GL
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1fbMAZ-0003cQ-Hs
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:32:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:41814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1fbMAZ-0003M8-91
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:32:47 -0400
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Date: Fri, 6 Jul 2018 08:32:38 +0000
Message-ID: <09D68D4CF52CAF489B702DEBDD12D3D352762282@SHSMSX103.ccr.corp.intel.com>
References: <1530710466-88309-1-git-send-email-jingqi.liu@intel.com>
	<17a63c95-8deb-1112-ca11-f98ee7f5876e@redhat.com>
In-Reply-To: <17a63c95-8deb-1112-ca11-f98ee7f5876e@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386: Add support to get/set/migrate MSR
 (33H)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com" <ehabkost@redhat.com>, "mtosatti@redhat.com" <mtosatti@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wang, Wei W" <wei.w.wang@intel.com>

T24gMDQvMDcvMjAxOCAyMTozNywgUGFvbG8gQm9uemluaSB3cm90ZToNCiANCj4gT24gMDQvMDcv
MjAxOCAxNToyMSwgSmluZ3FpIExpdSB3cm90ZToNCj4gPiBUaGUgTVNSICgzM0gpIGNvbnRyb2xz
IHN1cHBvcnQgZm9yICNBQyBleGNlcHRpb24gZm9yIHNwbGl0IGxvY2tlZA0KPiA+IGFjY2Vzc2Vz
LiBXaGVuIGJpdCAyOSBvZiB0aGUgTVNSICgzM0gpIGlzIHNldCwgdGhlIHByb2Nlc3NvciBjYXVz
ZXMgYW4NCj4gPiAjQUMgZXhjZXB0aW9uIHRvIGJlIGlzc3VlZCBpbnN0ZWFkIG9mIHN1cHByZXNz
aW5nIExPQ0sgb24gYnVzIChkdXJpbmcNCj4gPiBzcGxpdCBsb2NrIGFjY2VzcykuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBKaW5ncWkgTGl1IDxqaW5ncWkubGl1QGludGVsLmNvbT4NCj4gPiAt
LS0NCj4gPiAgdGFyZ2V0L2kzODYvY3B1LmggICAgIHwgIDIgKysNCj4gPiAgdGFyZ2V0L2kzODYv
a3ZtLmMgICAgIHwgMTMgKysrKysrKysrKysrKw0KPiA+ICB0YXJnZXQvaTM4Ni9tYWNoaW5lLmMg
fCAyMCArKysrKysrKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDM1IGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9jcHUuaCBiL3Rhcmdl
dC9pMzg2L2NwdS5oIGluZGV4DQo+ID4gOGVhZWZlZS4uOTcyODU1MiAxMDA2NDQNCj4gPiAtLS0g
YS90YXJnZXQvaTM4Ni9jcHUuaA0KPiA+ICsrKyBiL3RhcmdldC9pMzg2L2NwdS5oDQo+ID4gQEAg
LTM0OCw2ICszNDgsNyBAQCB0eXBlZGVmIGVudW0gWDg2U2VnIHsNCj4gPiAgI2RlZmluZSBNU1Jf
SUEzMl9BUElDQkFTRV9FTkFCTEUgICAgICAgICgxPDwxMSkNCj4gPiAgI2RlZmluZSBNU1JfSUEz
Ml9BUElDQkFTRV9FWFREICAgICAgICAgICgxIDw8IDEwKQ0KPiA+ICAjZGVmaW5lIE1TUl9JQTMy
X0FQSUNCQVNFX0JBU0UgICAgICAgICAgKDB4ZmZmZmZVPDwxMikNCj4gPiArI2RlZmluZSBNU1Jf
U1BMSVRfTE9DS19DVFJMICAgICAgICAgICAgIDB4MDAwMDAwMzMNCj4gPiAgI2RlZmluZSBNU1Jf
SUEzMl9GRUFUVVJFX0NPTlRST0wgICAgICAgIDB4MDAwMDAwM2ENCj4gPiAgI2RlZmluZSBNU1Jf
VFNDX0FESlVTVCAgICAgICAgICAgICAgICAgIDB4MDAwMDAwM2INCj4gPiAgI2RlZmluZSBNU1Jf
SUEzMl9TUEVDX0NUUkwgICAgICAgICAgICAgIDB4NDgNCj4gPiBAQCAtMTIwOSw2ICsxMjEwLDcg
QEAgdHlwZWRlZiBzdHJ1Y3QgQ1BVWDg2U3RhdGUgew0KPiA+ICAgICAgdWludDMyX3QgcGtydTsN
Cj4gPg0KPiA+ICAgICAgdWludDY0X3Qgc3BlY19jdHJsOw0KPiA+ICsgICAgdWludDY0X3Qgc3Bs
aXRfbG9ja19jdHJsOw0KPiANCj4gUGxlYXNlIGNhbGwgZXZlcnl0aGluZyBNU1JfVEVTVF9DVEwg
b3IgdGVzdF9jdGwuICBZZXMsIGl0J3MgYSBob3JyaWJsZSBuYW1lLCBidXQgaWYNCj4gdGhhdCdz
IHdoYXQgdGhlIG1hbnVhbCBjYWxscyBpdCwgd2Ugc2hvdWxkIGRvIHRoZSBzYW1lLg0KPiANCkhp
IFBhb2xvLCANClN1cmUuIEkgd2lsbCB1bmlmeSB0aGUgbmFtZSBpbiBuZXh0IHZlcnNpb24uDQpU
aGFua3MsDQpKaW5ncWkNCg0KPiBUaGFua3MsDQo+IA0KPiBQYW9sbw0KPiANCg0K

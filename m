Received: from eggs.gnu.org ([2001:4830:134:3::10]:59245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUV2Q-0007BQ-Rs
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUV2N-0003tZ-QT
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:59:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:41627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cUV2N-0003rc-D5
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 03:59:11 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 20 Jan 2017 08:59:01 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C150AD@SHSMSX101.ccr.corp.intel.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-2-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14FD2@SHSMSX101.ccr.corp.intel.com>
	<20170120085457.GI4914@pxdev.xzpeter.org>
In-Reply-To: <20170120085457.GI4914@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RFC v3 01/14] IOMMU: add option to enable
 VTD_CAP_CM to vIOMMU capility exposoed to guest
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
YXksIEphbnVhcnkgMjAsIDIwMTcgNDo1NSBQTQ0KPiANCj4gT24gRnJpLCBKYW4gMjAsIDIwMTcg
YXQgMDg6MzI6MDZBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBQZXRl
ciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiA+ID4gU2VudDogRnJpZGF5LCBKYW51
YXJ5IDEzLCAyMDE3IDExOjA2IEFNDQo+ID4gPg0KPiA+ID4gRnJvbTogQXZpdiBCZW4tRGF2aWQg
PGJkLmF2aXZAZ21haWwuY29tPg0KPiA+ID4NCj4gPiA+IFRoaXMgY2FwYWJpbGl0eSBhc2tzIHRo
ZSBndWVzdCB0byBpbnZhbGlkYXRlIGNhY2hlIGJlZm9yZSBlYWNoIG1hcCBvcGVyYXRpb24uDQo+
ID4gPiBXZSBjYW4gdXNlIHRoaXMgaW52YWxpZGF0aW9uIHRvIHRyYXAgbWFwIG9wZXJhdGlvbnMg
aW4gdGhlIGh5cGVydmlzb3IuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQXZpdiBCZW4t
RGF2aWQgPGJkLmF2aXZAZ21haWwuY29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWHUg
PHBldGVyeEByZWRoYXQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgaHcvaTM4Ni9pbnRlbF9pb21t
dS5jICAgICAgICAgIHwgNSArKysrKw0KPiA+ID4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaCB8IDEgKw0KPiA+ID4gIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oICB8IDIgKysN
Cj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRp
ZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4gPiA+IGluZGV4IGVjNjIyMzkuLjI4NjhlMzcgMTAwNjQ0DQo+ID4gPiAtLS0gYS9ody9pMzg2
L2ludGVsX2lvbW11LmMNCj4gPiA+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiA+ID4g
QEAgLTIxMDcsNiArMjEwNyw3IEBAIHN0YXRpYyBQcm9wZXJ0eSB2dGRfcHJvcGVydGllc1tdID0g
ew0KPiA+ID4gICAgICBERUZJTkVfUFJPUF9PTl9PRkZfQVVUTygiZWltIiwgSW50ZWxJT01NVVN0
YXRlLCBpbnRyX2VpbSwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT05fT0ZG
X0FVVE9fQVVUTyksDQo+ID4gPiAgICAgIERFRklORV9QUk9QX0JPT0woIngtYnVnZ3ktZWltIiwg
SW50ZWxJT01NVVN0YXRlLCBidWdneV9laW0sIGZhbHNlKSwNCj4gPiA+ICsgICAgREVGSU5FX1BS
T1BfQk9PTCgiY2FjaGUtbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwgY2FjaGVfbW9kZV9lbmFibGVk
LA0KPiA+ID4gRkFMU0UpLA0KPiA+ID4gICAgICBERUZJTkVfUFJPUF9FTkRfT0ZfTElTVCgpLA0K
PiA+ID4gIH07DQo+ID4gPg0KPiA+ID4gQEAgLTI0ODgsNiArMjQ4OSwxMCBAQCBzdGF0aWMgdm9p
ZCB2dGRfaW5pdChJbnRlbElPTU1VU3RhdGUgKnMpDQo+ID4gPiAgICAgICAgICBzLT5lY2FwIHw9
IFZURF9FQ0FQX0RUOw0KPiA+ID4gICAgICB9DQo+ID4gPg0KPiA+ID4gKyAgICBpZiAocy0+Y2Fj
aGVfbW9kZV9lbmFibGVkKSB7DQo+ID4gPiArICAgICAgICBzLT5jYXAgfD0gVlREX0NBUF9DTTsN
Cj4gPiA+ICsgICAgfQ0KPiA+ID4gKw0KPiA+DQo+ID4gSSB0aGluayBzb21lIG9mIG15IG9sZCBj
b21tZW50cyBhcmUgbm90IGFuc3dlcmVkOg0KPiA+DQo+ID4gMSkgQmV0dGVyIHRvIHVzZSBjYWNo
aW5nX21vZGUgdG8gZm9sbG93IHNwZWMNCj4gDQo+IFN1cmUuDQo+IA0KPiA+DQo+ID4gMikgRG9l
cyBpdCBtYWtlIHNlbnNlIHRvIGF1dG9tYXRpY2FsbHkgc2V0IHRoaXMgZmxhZyBpZiBhbnkgVkZJ
TyBkZXZpY2UNCj4gPiBoYXMgYmVlbiBzdGF0aWNhbGx5IGFzc2lnbmVkIHdoZW4gc3RhcnRpbmcg
UWVtdT8NCj4gDQo+IEknbSBva2F5IHdpdGggYm90aCwgY29uc2lkZXJpbmcgdGhhdCBwZW9wbGUg
dXNpbmcgdGhpcyBmbGFnIHdpbGwgYmUNCj4gcG9zc2libHkgYWR2YW5jZWQgdXNlcnMuIFNvIEkg
d291bGQgbGlrZSB0byBoZWFyIG90aGVycycgb3Bpbmlvbi4NCj4gDQo+ID4gQWxzbyBmb3IgaG90
LWFkZA0KPiA+IGRldmljZSBwYXRoLCBzb21lIGNoZWNrIG9mIGNhY2hpbmcgbW9kZSBpcyByZXF1
aXJlZC4gSWYgbm90IHNldCwNCj4gPiBzaG91bGQgd2UgZmFpbCBob3QtYWRkIG9wZXJhdGlvbj8g
SSBkb24ndCB0aGluayB3ZSBoYXZlIHN1Y2ggcGh5c2ljYWwNCj4gPiBwbGF0Zm9ybSB3aXRoIHNv
bWUgZGV2aWNlcyBiZWhpbmQgSU9NTVUgd2hpbGUgb3RoZXJzIG5vdC4NCj4gDQo+IENvdWxkIHlv
dSBleHBsYWluIGluIHdoYXQgY2FzZSB3aWxsIHdlIGZhaWwgYSBob3QgcGx1Zz8NCj4gDQoNCnVz
ZXIgZW5hYmxlcyBpbnRlbC1pb21tdSwgYnV0IGRvbid0IHNldCBjYWNoaW5nIG1vZGUuDQoNClRo
ZW4gbGF0ZXIgdXNlciBob3QtYWRkIGEgUENJIGRldmljZSB0byB0aGUgVk0uIEd1ZXN0IHdpbGwg
YXNzdW1lDQpuZXdseSBhc3NpZ25lZCBkZXZpY2UgYWxzbyBiZWhpbmQgdGhlIGRlZmF1bHQgdklP
TU1VLCBhbmQgdGh1cw0KbmVlZHMgdG8gc2V0dXAgSU9WQSBtYXBwaW5ncywgd2hpY2ggaXMgdGhl
biBicm9rZW4uLi4NCg0KVGhhbmtzDQpLZXZpbg0K

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUVhI-0008KT-Mo
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1cUVhE-0000Bx-Nj
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:41:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:1299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1cUVhE-0000Ab-D5
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:41:24 -0500
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 20 Jan 2017 09:41:18 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190C151FC@SHSMSX101.ccr.corp.intel.com>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-4-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14FAA@SHSMSX101.ccr.corp.intel.com>
	<20170120092348.GL4914@pxdev.xzpeter.org>
In-Reply-To: <20170120092348.GL4914@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RFC v3 03/14] intel_iommu: renaming gpa to
 iova where proper
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
YXksIEphbnVhcnkgMjAsIDIwMTcgNToyNCBQTQ0KPiANCj4gT24gRnJpLCBKYW4gMjAsIDIwMTcg
YXQgMDg6Mjc6MzFBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBQZXRl
ciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiA+ID4gU2VudDogRnJpZGF5LCBKYW51
YXJ5IDEzLCAyMDE3IDExOjA2IEFNDQo+ID4gPg0KPiA+ID4gVGhlcmUgYXJlIGxvdHMgb2YgcGxh
Y2VzIGluIGN1cnJlbnQgaW50ZWxfaW9tbXUuYyBjb2RlcyB0aGF0IG5hbWVkDQo+ID4gPiAiaW92
YSIgYXMgImdwYSIuIEl0IGlzIHJlYWxseSBjb25mdXNpbmcgdG8gdXNlIGEgbmFtZSAiZ3BhIiBp
biB0aGVzZQ0KPiA+ID4gcGxhY2VzICh3aGljaCBpcyB2ZXJ5IGVhc2lseSB0byBiZSB1bmRlcnN0
b29kIGFzICJHdWVzdCBQaHlzaWNhbA0KPiA+ID4gQWRkcmVzcyIsIHdoaWxlIGl0J3Mgbm90KS4g
VG8gbWFrZSB0aGUgY29kZXMgKG11Y2gpIGVhc2llciB0byBiZSByZWFkLCBJDQo+ID4gPiBkZWNp
ZGVkIHRvIGRvIHRoaXMgb25jZSBhbmQgZm9yIGFsbC4NCj4gPiA+DQo+ID4gPiBObyBmdW5jdGlv
bmFsIGNoYW5nZSBpcyBtYWRlLiBPbmx5IGxpdGVyYWwgb25lcy4NCj4gPg0KPiA+IElmIGxvb2tp
bmcgYXQgVlQtZCBzcGVjICgzLjIgRG9tYWlucyBhbmQgQWRkcmVzcyBUcmFuc2xhdGlvbikNCj4g
Pg0KPiA+IAlSZW1hcHBpbmcgaGFyZHdhcmUgdHJlYXRzIHRoZSBhZGRyZXNzIGluIGluYm91bmQg
cmVxdWVzdHMgYXMgRE1BDQo+ID4gCUFkZHJlc3MuIERlcGVuZGluZyBvbiB0aGUgc29mdHdhcmUg
dXNhZ2UgbW9kZWwsIHRoZSBETUEgYWRkcmVzcw0KPiA+IAlzcGFjZSBtYXkgYmUgdGhlIEd1ZXN0
LVBoeXNpY2FsIEFkZHJlc3MgKEdQQSkgc3BhY2Ugb2YgdGhlIHZpcnR1YWwNCj4gPiAJbWFjaGlu
ZSB0byB3aGljaCB0aGUgZGV2aWNlIGlzIGFzc2lnbmVkLCBvciBhcHBsaWNhdGlvbiBWaXJ0dWFs
IEFkZHJlc3MNCj4gPiAJKFZBKSBzcGFjZSBkZWZpbmVkIGJ5IHRoZSBQQVNJRCBhc3NpZ25lZCB0
byBhbiBhcHBsaWNhdGlvbiwgb3Igc29tZQ0KPiA+IAlhYnN0cmFjdCBJL08gdmlydHVhbCBhZGRy
ZXNzIChJT1ZBKSBzcGFjZSBkZWZpbmVkIGJ5IHNvZnR3YXJlLg0KPiA+DQo+ID4gCUZvciBzaW1w
bGljaXR5LCB0aGlzIGRvY3VtZW50IHJlZmVycyB0byBhZGRyZXNzIGluIHJlcXVlc3RzLXdpdGhv
dXQtDQo+ID4gCVBBU0lEIGFzIEdQQSwgYW5kIGFkZHJlc3MgaW4gcmVxdWVzdHMtd2l0aC1QQVNJ
RCBhcyBWaXJ0dWFsIEFkZHJlc3MNCj4gPiAJKFZBKSAob3IgR3Vlc3QgVmlydHVhbCBBZGRyZXNz
IChHVkEpLCBpZiBzdWNoIHJlcXVlc3QgaXMgZnJvbSBhIGRldmljZQ0KPiA+IAlhc3NpZ25lZCB0
byBhIHZpcnR1YWwgbWFjaGluZSkuIFRoZSB0cmFuc2xhdGVkIGFkZHJlc3MgaXMgcmVmZXJyZWQg
dG8gYXMNCj4gPiAJSFBBLg0KPiA+DQo+ID4gSXQgd2lsbCBhZGQgbW9yZSByZWFkYWJpbGl0eSBp
ZiBzaW1pbGFyIGNvbW1lbnQgaXMgYWRkZWQgaW4gdGhpcyBmaWxlIC0geW91DQo+ID4gY2FuIHNh
eSBjaG9vc2luZyBpb3ZhIHRvIHJlcHJlc2VudCBhZGRyZXNzIGluIHJlcXVlc3RzLXdpdGhvdXQt
UEFTSUQuDQo+IA0KPiBJIGFncmVlIHRoYXQgdGhlIGNvZGUgd2lsbCBiZSBtb3JlIHJlYWRhYmxl
IGlmIHdlIGNhbiBleHBsYWluIGFsbCB0aGUNCj4gYml0cyBpbiBkZXRhaWwuDQo+IA0KPiBIb3dl
dmVyIHRoaXMgcGF0Y2ggaXMgbm90IGFkZGluZyBjb21tZW50cywgYnV0IHRvICJmaXgiIGFuIGV4
aXN0aW5nDQo+IGxpdGVyYWwgcHJvYmxlbSwgd2hpY2ggaXMgdmVyeSBtaXNsZWFkaW5nIHRvIHBl
b3BsZSByZWFkaW5nIHRoZSBjb2Rlcw0KPiBmb3IgdGhlIGZpcnN0IHRpbWUuIFRoZSBwbGFjZXMg
dG91Y2hlZCBpbiB0aGlzIHBhdGNoIHdhcyBkb2luZyB0aGUNCj4gbmFtaW5ncyBpbmNvcnJlY3Rs
eSwgc28gSSBqdXN0IGNvcnJlY3RlZCB0aGVtLiBTbyBldmVuIGlmIHdlIHdhbnQgdG8NCj4gaGF2
ZSBtb3JlIGNvbW1lbnRzIG9uIGV4cGxhaW5pbmcgdGhlIGJpdHMsIElNSE8gaXQnbGwgYmUgbmlj
ZXIgdG8gdXNlDQo+IGEgc2VwYXJhdGUgcGF0Y2gsIG5vdCBzcXVhc2hpbmcgYWxsIHRoZSB0aGlu
Z3MgaW50byBhIHNpbmdsZSBvbmUuDQo+IA0KPiBJZiB5b3Ugd29uJ3QgZGlzYWdyZWUsIEknZCBs
aWtlIHRvIGtlZXAgdGhpcyBzaW5nbGUgcGF0Y2ggYXMtaXQtaXMsIHRvDQo+IG1ha2Ugc3VyZSB0
aGlzIHNlcmllcyBjYW4gY29udmVyZ2Ugc29vbiAoSSB3aWxsIGJlIHNvcnJ5IHNpbmNlIEknbGwN
Cj4gZXh0ZW5kIHRoaXMgc2VyaWVzIGEgYml0LCBJIGhvcGUgdGhhdCB3b24ndCBleHRlbmQgdGhl
IHJldmlldyBwcm9jZXNzDQo+IHRvbyBsb25nIGZvciBpdCkuIEFmdGVyIHRoYXQsIHdlIGNhbiBh
ZGQgbW9yZSBkb2N1bWVudGF0aW9ucyBpZg0KPiBuZWVkZWQuDQo+IA0KDQpmaW5lIHdpdGggbWUu
DQoNClRoYW5rcw0KS2V2aW4NCg==

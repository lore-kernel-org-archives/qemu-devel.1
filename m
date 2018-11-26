Received: from eggs.gnu.org ([2001:4830:134:3::10]:55181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gRKdW-00051m-3b
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gRKdV-0000je-7Q
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 12:25:30 -0500
From: gengdongjiu <gengdongjiu@huawei.com>
Date: Mon, 26 Nov 2018 17:25:09 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201F96F02@dggema523-mbx.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RESEND v15 08/10] target-arm: kvm64: inject
 synchronous External Abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard
	Henderson <rth@twiddle.net>, "zhengxiang (A)" <zhengxiang9@huawei.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

PiA+Pg0KPiA+PiBIaSBQZXRlciwNCj4gPj4gICBUaGFua3MgZm9yIHRoZSByZXZpZXcgYW5kIGNv
bW1lbnRzLg0KPiA+Pg0KPiA+PiA+DQo+ID4+ID4gT24gOCBOb3ZlbWJlciAyMDE4IGF0IDEwOjI5
LCBEb25naml1IEdlbmcgPGdlbmdkb25naml1QGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+PiA+ID4g
K2Jvb2wgd3JpdGVfcGFydF9jcHVzdGF0ZV90b19saXN0KEFSTUNQVSAqY3B1LCBwdHJkaWZmX3QN
Cj4gPj4gPiA+ICtmaWVsZG9mZnNldCkNCj4gPj4gPg0KPiA+PiA+IFdoYXQgaXMgdGhpcyBhYm91
dD8gTm90aGluZyBlbHNlIGluIFFFTVUgbmVlZHMgdG8gbWVzcyB3aXRoIHRoZQ0KPiA+PiA+IGNw
dXN0YXRlIHN5bmNocm9uaXphdGlvbi4gTXkgZmlyc3QgYXNzdW1wdGlvbiBpcyB0aGF0IHlvdSBz
aG91bGQgbm90IG5lZWQgdG8gZG8gc28gZWl0aGVyLg0KPiA+Pg0KPiA+PiBXZSBzaG91bGQgY2hh
bmdlIHRoZSBndWVzdCBDUDE1IEVTUl9FTDEncyB2YWx1ZSwgdGhlIG9ubHkgbWV0aG9kIGlzDQo+
ID4+IHRvIGNoYW5nZSB0aGUgY3B1LT5jcHJlZ192YWx1ZXNbXSBpbiBRRU1VLCB0aGVuIFFFTVUg
Y2FsbCB3cml0ZV9saXN0X3RvX2t2bXN0YXRlKCkgdG8gc2V0IHRoZSBjcHUtPmNwcmVnX3ZhbHVl
c1tdIHRvIEtWTSB3aGljaA0KPiBpbmNsdWRlIHRoZSBzcGVjaWZpZWQgRVNSX0VMMSB2YWx1ZSwg
S1ZNIGRvIHdvcmxkIHN3aXRjaCwgYW5kIHRoZW4gc2V0IHRoZSBzcGVjaWZpZWQgRVNSX0VMMSdz
IHZhbHVlIHRvIGd1ZXN0IGtlcm5lbC4NCj4gPg0KPiA+IEFoLCBJIHNlZS4gVGhpcyBpcyBhIGJ1
ZyBpbiBvdXIgY3VycmVudCBoYW5kbGluZyBvZiB0aGUgcmVnaXN0ZXINCj4gPiBzdGF0ZSwgd2hl
cmUgd2UgaW1wbGljaXRseSBhc3N1bWUgdGhhdCBub3RoaW5nIGluIFFFTVUgd2lsbCBldmVyIHdh
bnQNCj4gPiB0byBjaGFuZ2UgYW55IHN5c3RlbSByZWdpc3RlciB2YWx1ZXMuIFRoaXMgYXNzdW1w
dGlvbiBpcyBub3cgZmFsc2UgLS0NCj4gPiBrdm1fYXJtX2hhbmRsZV9kZWJ1ZygpIGJyb2tlIGl0
IC0tIHNvIHdlIG5lZWQgdG8gZml4IHRoZSBjb2RlIHRoYXQNCj4gPiBkb2VzIGt2bV9hcmNoX3B1
dF9yZWdpc3RlcnMoKS4gVGhlcmUgaXMgYSBjb21tZW50IGluIHRoZSBrdm0zMi5jDQo+ID4gdmVy
c2lvbiBvZiB0aGF0IGZ1bmN0aW9uIGFib3V0IHRoaXMuIChUaGUga3ZtNjQuYyB2ZXJzaW9uIGhh
cyB0aGUgc2FtZQ0KPiA+IGFzc3VtcHRpb24gYnV0IGRvZXNuJ3QgY29tbWVudCBvbiBpdC4pDQo+
ID4NCj4gPiBXZSBzaG91bGQgKGlkZWFsbHkpIGZpeCB0aGlzIGJ1ZyBpbiB0aGUgY29kZSB0aGF0
IGRvZXMgcmVnaXN0ZXINCj4gPiBzeW5jaW5nLCB3aXRob3V0IHJlcXVpcmluZyBwbGFjZXMgaW4g
UUVNVSB0aGF0IHVwZGF0ZSBzeXN0ZW0gcmVnaXN0ZXJzDQo+ID4gdG8gaGF2ZSB0byBtYW51YWxs
eSBpbmRpY2F0ZSB3aGljaCByZWdpc3RlcnMgdGhleSBoYXZlIGNoYW5nZWQuIEknbGwNCj4gPiBo
YXZlIGEgdGhpbmsgYWJvdXQgaG93IGJlc3QgdG8gZG8gdGhpcy4NCj4gPg0KPiA+PiBBYm91dCB0
aGUgZGV0YWlsZWQgZXhwbGFuYXRpb24sIGFzIHNob3duIGluIFsyXS4NCj4gPj4NCj4gPj4ga3Zt
X2FybV9oYW5kbGVfZGVidWcoKSBkb2VzIG5vdCBuZWVkIHRvIGRvIHRoaXMgYmVjYXVzZSBRRU1V
IGRvZXMgbm90IG5lZWQgdG8gY2hhbmdlIENQMTUgcmVnaXN0ZXJzLCBzdWNoIGFzIEVTUl9FTDEu
DQo+ID4NCj4gPiBrdm1fYXJtX2hhbmRsZV9kZWJ1ZyBkb2VzIGNoYW5nZSBFU1JfRUwxOiBpdCBp
cyBpbmplY3RpbmcgYW4gZXhjZXB0aW9uDQo+ID4gYW5kIHNvIHNob3VsZCBzZXQgdGhlIGV4Y2Vw
dGlvbiByZWdpc3Rlci4gVGhpcyBoYXBwZW5zIHdoZW4gaXQgY2FsbHMNCj4gPiB0aGUgZG9faW50
ZXJydXB0KCkgaG9vaywgYmVjYXVzZSBhcm1fY3B1X2RvX2ludGVycnVwdF9hYXJjaDY0KCkgd3Jp
dGVzDQo+ID4gdG8gZW52LT5jcDE1LmVzcl9lbFtuZXdfZWxdLg0KPiA+DQo+ID4gSSdtIG5vdCBl
bnRpcmVseSBzdXJlIHdoeSB0aGlzIGlzIHdvcmtpbmcgdG9kYXksIGluIGZhY3QuDQo+ID4gQWxl
eCwgZGlkIHlvdSB0ZXN0IHdoZXRoZXIgb3VyIGRlYnVnLWV4Y2VwdGlvbi1pbmplY3Rpb24gcmVw
b3J0cyB0aGUNCj4gPiBjb3JyZWN0IEVTUl9FTDEgdG8gdGhlIGd1ZXN0ID8NCj4gPHNuaXA+DQo+
IA0KPiBJIGRpZCBub3QgLSBJIHdhcyBtb3N0bHkgZm9jdXNpbmcgaW4gdGhlIGhvc3QtZGVidWdn
aW5nLXRoZS1ndWVzdCB0ZXN0IGNhc2UuIEknbGwgZ2V0IGEgdGVzdCByaWcgdXAgYW5kIGNoZWNr
Lg0KDQpUaGFua3MsIHBsZWFzZSB0ZXN0IGl0IGluIHRoZSBLVk0gbW9kZSwgbm90IGluIHRoZSBU
Q0cgbW9kZS4gV2FpdGluZyBmb3IgeW91ciB0ZXN0IHJlc3VsdC4NCg0KPiANCj4gLS0NCj4gQWxl
eCBCZW5uw6llDQo=

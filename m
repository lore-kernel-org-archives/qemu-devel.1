Received: from eggs.gnu.org ([2001:4830:134:3::10]:33611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <d.hatayama@jp.fujitsu.com>) id 1e9THA-0002yx-C2
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 05:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <d.hatayama@jp.fujitsu.com>) id 1e9TH4-0001tc-DL
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 05:56:04 -0400
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:49163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <d.hatayama@jp.fujitsu.com>)
	id 1e9TH3-0001mx-Tl
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 05:55:58 -0400
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
	(g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
	by yt-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 07A9BAC0235
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 18:55:42 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Date: Tue, 31 Oct 2017 09:55:39 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B153BF6@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E21B120583@G01JPEXMBYT03>
	<20171030181711-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171030181711-mutt-send-email-mst@kernel.org>
Content-Language: ja-JP
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 5/5] RFC: fw_cfg: add DMA write
 operation in sysfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'Michael S. Tsirkin'" <mst@redhat.com>
Cc: "'marcandre.lureau@redhat.com'" <marcandre.lureau@redhat.com>, "'somlo@cmu.edu'" <somlo@cmu.edu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGlu
dXgta2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZw0KPiBbbWFpbHRvOmxp
bnV4LWtlcm5lbC1vd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBP
ZiBNaWNoYWVsIFMuIFRzaXJraW4NCj4gU2VudDogVHVlc2RheSwgT2N0b2Jl
ciAzMSwgMjAxNyAxOjE5IEFNDQo+IFRvOiBIYXRheWFtYSwgRGFpc3VrZSA8
ZC5oYXRheWFtYUBqcC5mdWppdHN1LmNvbT4NCj4gQ2M6ICdtYXJjYW5kcmUu
bHVyZWF1QHJlZGhhdC5jb20nIDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5j
b20+Ow0KPiAnc29tbG9AY211LmVkdScgPHNvbWxvQGNtdS5lZHU+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiAncWVtdS1kZXZlbEBub25n
bnUub3JnJyA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHYzIDUvNV0gUkZDOiBmd19jZmc6IGFkZCBETUEgd3JpdGUg
b3BlcmF0aW9uIGluIHN5c2ZzDQo+IA0KPiBPbiBNb24sIE9jdCAzMCwgMjAx
NyBhdCAxMTowNzoyMEFNICswMDAwLCBIYXRheWFtYSwgRGFpc3VrZSB3cm90
ZToNCj4gPiA+IEZyb206IE1hcmMtQW5kcqimIEx1cmVhdSA8bWFyY2FuZHJl
Lmx1cmVhdUByZWRoYXQuY29tPg0KPiA+ID4NCj4gPiA+IFNpbmNlIHFlbXUg
Mi45LCBETUEgd3JpdGUgb3BlcmF0aW9ucyBhcmUgYWxsb3dlZC4gSG93ZXZl
ciwgdXNhZ2Ugb2YgdGhpcw0KPiA+ID4gaW50ZXJmYWNlIGZyb20ga2VybmVs
IG9yIHVzZXItc3BhY2UgaXMgc3Ryb25nbHkgZGlzY291cmFnZWQgYnkgdGhl
DQo+ID4gPiBtYWludGFpbmVycy4gVGhpcyBwYXRjaCBpcyBtZWFudCBmb3Ig
ZXhwZXJpbWVudGF0aW9ucyBmb3Igbm93Lg0KPiA+ID4NCj4gPg0KPiA+IENv
dWxkIHlvdSAob3IgbWFpbnRhaW5lcnM/KSB0ZWxsIG1lIGhvdyBleHBlcmlt
ZW50YWwgdGhlIERNQSB3cml0ZQ0KPiA+IG9wZXJhdGlvbnMgZnJvbSBrZXJu
ZWwgYXJlPw0KPiA+DQo+ID4gRnJvbSBzb21lIHRlY2huaWNhbCByZWFzb24/
DQo+ID4gT3Igc2ltcGx5IHRoZXJlIGhhcyBub3QgYmVlbiBlbm91Z2ggdGVz
dCB5ZXQgc28gZmFyPw0KPiANCj4gVGhlIGNvbmNlcm4gaXMgc2VjdXJpdHks
IHRhbGtpbmcgZnJvbSB1c2Vyc3BhY2UgdG8gaHlwZXJ2aXNvcg0KPiBtaWdo
dCBiZWNvbWUgYSB0cml2aWFsIERPUyB2ZWN0b3IuDQo+IA0KPiBJZiB0aGVy
ZSdzIG5lZWQgZm9yIGEgc3BlY2lmaWMgZW50cnkgdG8gYmUgYWNjZXNzaWJs
ZSBmcm9tIHVzZXJzcGFjZSwNCj4gSSdkIHJhdGhlciB3aGl0ZS1saXN0IGl0
Lg0KPiANCg0KVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uDQoNCklmIHNv
LCBJIGd1ZXNzIHRoZSB3aGl0ZS1saXN0IGlzIGRvbmUgaW4gdXNlcnNwYWNl
IHFlbXUgc2lkZSwNCmFuZCBubyBhZGRpdGlvbmFsIGNoYW5nZSB3b3VsZCBi
ZSBuZWVkZWQgZm9yIHRoaXMga2VybmVsLXNpZGUgcGF0Y2ggc2V0IGZvciB0
aGUgd2hpdGUtbGlzdCBmZWF0dXJlLg0KSXMgdGhpcyB1bmRlcnN0YW5kaW5n
IGNvcnJlY3Q/DQoNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmMtQW5kcqim
IEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiAgZHJpdmVycy9maXJtd2FyZS9xZW11X2Z3X2NmZy5jIHwg
MjEgKysrKysrKysrKysrKysrKysrKystDQo+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDIwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9xZW11X2Z3X2Nm
Zy5jDQo+IGIvZHJpdmVycy9maXJtd2FyZS9xZW11X2Z3X2NmZy5jDQo+ID4g
PiBpbmRleCA1NGI1NjlkYTMyNTcuLmUyZjJhZDFjOWMwYyAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvcWVtdV9md19jZmcuYw0KPiA+
ID4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9xZW11X2Z3X2NmZy5jDQo+ID4g
PiBAQCAtNTI0LDkgKzUyNCwyOCBAQCBzdGF0aWMgc3NpemVfdCBmd19jZmdf
c3lzZnNfcmVhZF9yYXcoc3RydWN0IGZpbGUgKmZpbHAsDQo+IHN0cnVjdCBr
b2JqZWN0ICprb2JqLA0KPiA+ID4gICAgICAgcmV0dXJuIGZ3X2NmZ19yZWFk
X2Jsb2IoZW50cnktPmYuc2VsZWN0LCBidWYsIHBvcywgY291bnQsIHRydWUp
Ow0KPiA+ID4gIH0NCj4gPiA+DQo+ID4gPiArc3RhdGljIHNzaXplX3QgZndf
Y2ZnX3N5c2ZzX3dyaXRlX3JhdyhzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0
IGtvYmplY3QNCj4gKmtvYmosDQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgYmluX2F0dHJpYnV0ZSAqYmluX2F0
dHIsDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjaGFyICpidWYsIGxvZmZfdCBwb3MsIHNpemVfdCBjb3VudCkNCj4gPiA+
ICt7DQo+ID4gPiArICAgICBzdHJ1Y3QgZndfY2ZnX3N5c2ZzX2VudHJ5ICpl
bnRyeSA9IHRvX2VudHJ5KGtvYmopOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAg
aWYgKCFmd19jZmdfZG1hX2VuYWJsZWQoKSkNCj4gPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9UU1VQUDsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIGlm
IChwb3MgPiBlbnRyeS0+Zi5zaXplKQ0KPiA+ID4gKyAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIGlmIChjb3Vu
dCA+IGVudHJ5LT5mLnNpemUgLSBwb3MpDQo+ID4gPiArICAgICAgICAgICAg
IGNvdW50ID0gZW50cnktPmYuc2l6ZSAtIHBvczsNCj4gPiA+ICsNCj4gPiA+
ICsgICAgIHJldHVybiBmd19jZmdfd3JpdGVfYmxvYihlbnRyeS0+Zi5zZWxl
Y3QsIGJ1ZiwgcG9zLCBjb3VudCk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+
ID4gIHN0YXRpYyBzdHJ1Y3QgYmluX2F0dHJpYnV0ZSBmd19jZmdfc3lzZnNf
YXR0cl9yYXcgPSB7DQo+ID4gPiAtICAgICAuYXR0ciA9IHsgLm5hbWUgPSAi
cmF3IiwgLm1vZGUgPSBTX0lSVVNSIH0sDQo+ID4gPiArICAgICAuYXR0ciA9
IHsgLm5hbWUgPSAicmF3IiwgLm1vZGUgPSBTX0lSVVNSIHwgU19JV1VTUiB9
LA0KPiA+ID4gICAgICAgLnJlYWQgPSBmd19jZmdfc3lzZnNfcmVhZF9yYXcs
DQo+ID4gPiArICAgICAud3JpdGUgPSBmd19jZmdfc3lzZnNfd3JpdGVfcmF3
LA0KPiA+ID4gIH07DQo+ID4gPg0KPiA+ID4gIC8qDQo+ID4gPiAtLQ0KPiA+
ID4gMi4xNC4xLjE0Ni5nZDM1ZmFhODE5DQo+ID4NCj4gPiBUaGFua3MuDQo+
ID4gSEFUQVlBTUEsIERhaXN1a2UNCj4gPg0KPiANCg0K

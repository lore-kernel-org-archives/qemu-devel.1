Received: from eggs.gnu.org ([2001:4830:134:3::10]:58284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liqiang6-s@360.cn>) id 1cu80g-0005v2-6g
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 21:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liqiang6-s@360.cn>) id 1cu80b-0004sd-Em
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 21:39:22 -0400
Received: from mtabjsc2.360.cn ([123.125.82.7]:60022)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liqiang6-s@360.cn>) id 1cu80a-0004sI-QM
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 21:39:17 -0400
From: =?utf-8?B?5p2O5by6?= <liqiang6-s@360.cn>
Date: Sat, 1 Apr 2017 01:39:13 +0000
Message-ID: <143C0AFC63FC204CB0C55BB88F3A8ABB3339E74F@EX02.corp.qihoo.net>
References: <149095959109.26233.3201018420228514740.stgit@bahia>
	<149095965106.26233.18168802196576430962.stgit@bahia.lan>
In-Reply-To: <149095965106.26233.18168802196576430962.stgit@bahia.lan>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [for-2.9 PATCH 3/3] 9pfs: drop useless loop in
 v9fs_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLdXJ6IFttYWls
dG86Z3JvdWdAa2FvZC5vcmddDQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMzEsIDIwMTcgNzoyOCBQ
TQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBFcmljIEJsYWtlOyDmnY7lvLo7
IEdyZWcgS3Vyeg0KPiBTdWJqZWN0OiBbZm9yLTIuOSBQQVRDSCAzLzNdIDlwZnM6IGRyb3AgdXNl
bGVzcyBsb29wIGluIHY5ZnNfcmVzZXQoKQ0KPiANCj4gV2UgZG9uJ3QgbmVlZCB0byB3YWl0IGZv
ciB0aGUgUERVIGFjdGl2ZSBsaXN0IHRvIGJlIGVtcHR5OiB2aXJ0ZnNfcmVzZXQoKSBhbHJlYWR5
DQo+IHRha2VzIGNhcmUgb2YgdGhhdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEdyZWcgS3VyeiA8
Z3JvdWdAa2FvZC5vcmc+DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTogTGkgUWlhbmcgPGxpcWlhbmc2
LXNAMzYwLmNuPg0KDQo+ICBody85cGZzLzlwLmMgfCAgICA1ICstLS0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aHcvOXBmcy85cC5jIGIvaHcvOXBmcy85cC5jIGluZGV4IDg2ZWQ5MDY1YzRlMi4uMTZlZjZiZDVi
ZDhjDQo+IDEwMDY0NA0KPiAtLS0gYS9ody85cGZzLzlwLmMNCj4gKysrIGIvaHcvOXBmcy85cC5j
DQo+IEBAIC0zNjAxLDYgKzM2MDEsNyBAQCBzdGF0aWMgdm9pZCBjb3JvdXRpbmVfZm4gdmlydGZz
X2NvX3Jlc2V0KHZvaWQNCj4gKm9wYXF1ZSkNCj4gICAgICBWaXJ0ZnNDb1Jlc2V0RGF0YSAqZGF0
YSA9IG9wYXF1ZTsNCj4gDQo+ICAgICAgdmlydGZzX3Jlc2V0KCZkYXRhLT5wZHUpOw0KPiArICAg
IGFzc2VydChRTElTVF9FTVBUWSgmZGF0YS0+cGR1LnMtPmFjdGl2ZV9saXN0KSk7DQo+ICAgICAg
ZGF0YS0+ZG9uZSA9IHRydWU7DQo+ICB9DQo+IA0KPiBAQCAtMzYwOSwxMCArMzYxMCw2IEBAIHZv
aWQgdjlmc19yZXNldChWOWZzU3RhdGUgKnMpDQo+ICAgICAgVmlydGZzQ29SZXNldERhdGEgZGF0
YSA9IHsgLnBkdSA9IHsgLnMgPSBzIH0sIC5kb25lID0gZmFsc2UgfTsNCj4gICAgICBDb3JvdXRp
bmUgKmNvOw0KPiANCj4gLSAgICB3aGlsZSAoIVFMSVNUX0VNUFRZKCZzLT5hY3RpdmVfbGlzdCkp
IHsNCj4gLSAgICAgICAgYWlvX3BvbGwocWVtdV9nZXRfYWlvX2NvbnRleHQoKSwgdHJ1ZSk7DQo+
IC0gICAgfQ0KPiAtDQo+ICAgICAgY28gPSBxZW11X2Nvcm91dGluZV9jcmVhdGUodmlydGZzX2Nv
X3Jlc2V0LCAmZGF0YSk7DQo+ICAgICAgcWVtdV9jb3JvdXRpbmVfZW50ZXIoY28pOw0KPiANCg0K

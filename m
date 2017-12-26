Received: from eggs.gnu.org ([2001:4830:134:3::10]:36280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1eTmpr-0000B5-Sd
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 05:51:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1eTmpo-0004LQ-OE
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 05:51:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:53899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1eTmpo-0004HZ-Ep
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 05:51:48 -0500
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Tue, 26 Dec 2017 10:51:41 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439B2BAD8@SHSMSX104.ccr.corp.intel.com>
References: <CAMxP3BRqxD8tC1-M3+Pr8q8JZ1G_fGPbcvNQehwdPGFykdEk0g@mail.gmail.com>
In-Reply-To: <CAMxP3BRqxD8tC1-M3+Pr8q8JZ1G_fGPbcvNQehwdPGFykdEk0g@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [GPU and VFIO] qemu hang at startup,
 VFIO_IOMMU_MAP_DMA is extremely slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bob Chen <a175818323@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBRZW11LWRldmVsIFttYWlsdG86
cWVtdS1kZXZlbC1ib3VuY2VzK3lpLmwubGl1PWludGVsLmNvbUBub25nbnUub3JnXQ0KPiBPbiBC
ZWhhbGYgT2YgQm9iIENoZW4NCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMjYsIDIwMTcgNjoz
MCBQTQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IFN1YmplY3Q6IFtRZW11LWRldmVs
XSBbR1BVIGFuZCBWRklPXSBxZW11IGhhbmcgYXQgc3RhcnR1cCwNCj4gVkZJT19JT01NVV9NQVBf
RE1BIGlzIGV4dHJlbWVseSBzbG93DQo+IA0KPiBIaSwNCj4gDQo+IEkgaGF2ZSBhIGhvc3Qgc2Vy
dmVyIHdpdGggbXVsdGlwbGUgR1BVIGNhcmRzLCBhbmQgd2FzIGFzc2lnbmluZyB0aGVtIHRvIHFl
bXUNCj4gd2l0aCBWRklPLg0KPiANCj4gSSBmb3VuZCB0aGF0IHdoZW4gc2V0dGluZyB1cCB0aGUg
bGFzdCBmcmVlIEdQVSwgdGhlIHFlbXUgcHJvY2VzcyB3b3VsZCBoYW5nDQoNCkFyZSBhbGwgdGhl
IEdQVXMgaW4gdGhlIHNhbWUgaW9tbXUgZ3JvdXA/DQoNCj4gdGhlcmUgYW5kIHRvb2sgYWxtb3N0
IDEwIG1pbnV0ZXMgYmVmb3JlIGZpbmlzaGluZyBzdGFydHVwLiBJIG1hZGUgc29tZSBkaWcgYnkN
Cj4gZ2RiLCBhbmQgZm91bmQgdGhlIHNsb3dlc3QgcGFydCBvY2N1cnJlZCBhdCB0aGUNCj4gaHcv
dmZpby9jb21tb24uYzp2ZmlvX2RtYV9tYXAgZnVuY3Rpb24gY2FsbC4NCg0KVGhpcyBpcyB0byBz
ZXR1cCBtYXBwaW5nIGFuZCBpdCB0YWtlcyB0aW1lLiBUaGlzIGZ1bmN0aW9uIHdvdWxkIGJlIGNh
bGxlZCBtdWx0aXBsZQ0KdGltZXMgYW5kIGl0IHdpbGwgdGFrZSBzb21lIHRpbWUuIFRoZSBzbG93
ZXN0IHBhcnQsIGRvIHlvdSBtZWFuIGl0IHRha2VzDQphIGxvbmcgdGltZSBmb3IgYSBzaW5nbGUg
dmZpb19kbWFfbWFwKCkgY2FsbGluZyBvciB0aGUgd2hvbGUgcGFzc3RocnUgc3BlbmRzIGEgbG90
DQpvZiB0aW1lIG9uIGNyZWF0aW5nIG1hcHBpbmcuIElmIGEgc2luZ2xlIGNhbGxpbmcgdGFrZXMg
YSBsb3Qgb2YgdGltZSwgdGhlbiBpdCBtYXkgYmUNCmEgcHJvYmxlbS4NCg0KWW91IG1heSBwYXN0
ZSB5b3VyIFFlbXUgY29tbWFuZCB3aGljaCBtaWdodCBoZWxwLiBBbmQgdGhlIGRtZXNnIGluIGhv
c3QNCndvdWxkIGFsc28gaGVscC4NCg0KPiANCj4gDQo+IHN0YXRpYyBpbnQgdmZpb19kbWFfbWFw
KFZGSU9Db250YWluZXIgKmNvbnRhaW5lciwgaHdhZGRyIGlvdmEsIHJhbV9hZGRyX3QNCj4gc2l6
ZSwgdm9pZCAqdmFkZHIsIGJvb2wgcmVhZG9ubHkpIHsgLi4uDQo+ICAgICBpZiAoaW9jdGwoY29u
dGFpbmVyLT5mZCwgVkZJT19JT01NVV9NQVBfRE1BLCAmbWFwKSA9PSAwIHx8DQo+ICAgICAgICAg
KGVycm5vID09IEVCVVNZICYmIHZmaW9fZG1hX3VubWFwKGNvbnRhaW5lciwgaW92YSwgc2l6ZSkg
PT0gMCAmJg0KPiAgICAgICAgICBpb2N0bChjb250YWluZXItPmZkLCBWRklPX0lPTU1VX01BUF9E
TUEsICZtYXApID09IDApKSB7DQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICAgICB9DQo+IC4uLg0K
PiB9DQo+IA0KPiANCj4gVGhlIGhhbmcgd2FzIGVuYWJsZSB0byByZXByb2R1Y2Ugb24gb25lIG9m
IG15IGhvc3RzLCBJIHdhcyBzZXR0aW5nIHVwIGEgNEdCDQo+IG1lbW9yeSBWTSwgd2hpbGUgdGhl
IGhvc3Qgc3RpbGwgaGFkIDE2R0IgZnJlZS4gR1BVIHBoeXNpY2FsIG1lbSBpcyA4Ry4NCg0KRG9l
cyBpdCBoYXBwZW4gd2hlbiB5b3Ugb25seSBhc3NpZ24gYSBzaW5nbGUgR1BVPw0KDQo+IEFsc28s
IHRoaXMgcGhlbm9tZW5vbiB3YXMgb2JzZXJ2ZWQgb24gb3RoZXIgaG9zdHMgb2NjYXNpb25hbGx5
LCBhbmQgdGhlDQo+IHNpbWlsYXJpdHkgaXMgdGhhdCB0aGV5IGFsd2F5cyBoYXBwZW5lZCBvbiB0
aGUgbGFzdCBmcmVlIEdQVS4NCj4gDQo+IA0KPiBGdWxsIHN0YWNrIHRyYWNlIGZpbGUgaXMgYXR0
YWNoZWQuIExvb2tpbmcgZm9yd2FyZCBmb3IgeW91IGhlbHAsIHRoYW5rcw0KPiANCj4gDQo+IC0g
Qm9iDQoNClJlZ2FyZHMsDQpZaSBMDQo=

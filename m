Received: from eggs.gnu.org ([2001:4830:134:3::10]:58433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1et7IE-0006uG-3d
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1et7I9-0004QV-VQ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:45:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:24582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1et7I9-0004Pf-MM
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 02:45:45 -0500
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Tue, 6 Mar 2018 07:45:39 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439B87835@SHSMSX104.ccr.corp.intel.com>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<20180306065545.GE3615@xz-mi>
In-Reply-To: <20180306065545.GE3615@xz-mi>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Introduce new iommu notifier
 framework for virt-SVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "Tian, Kevin" <kevin.tian@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBUdWVz
ZGF5LCBNYXJjaCA2LCAyMDE4IDI6NTYgUE0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwMC8x
Ml0gSW50cm9kdWNlIG5ldyBpb21tdSBub3RpZmllciBmcmFtZXdvcmsgZm9yIHZpcnQtU1ZBDQo+
IA0KPiBPbiBUaHUsIE1hciAwMSwgMjAxOCBhdCAwNjozMzoyM1BNICswODAwLCBMaXUsIFlpIEwg
d3JvdGU6DQo+ID4gVGhpcyBwYXRjaHNldCBpcyB0byBpbnRyb2R1Y2UgYSBub3RpZmllciBmcmFt
ZXdvcmsgZm9yIHZpcnQtU1ZBLg0KPiA+IFlvdSBtYXkgZmluZCB2aXJ0LVNWQSBkZXNpZ24gZGV0
YWlscyBmcm9tIHRoZSBsaW5rIGJlbG93Lg0KPiA+DQo+ID4gaHR0cHM6Ly9saXN0cy5nbnUub3Jn
L2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMTctMDQvbXNnMDQ5MjUuaHRtbA0KPiA+DQo+ID4g
U1ZBIGlzIHNob3J0IGZvciBTaGFyZWQgVmlydHVhbCBBZGRyZXNzaW5nLiBUaGlzIGlzIGFsc28g
Y2FsbGVkIFNoYXJlZA0KPiA+IFZpcnR1YWwgTWVtb3J5IGluIHByZXZpb3VzIHBhdGNoc2V0cy4g
SG93ZXZlciwgU1ZNIGlzIGNvbmZ1c2luZyBhcyBpdA0KPiA+IGNhbiBhbHNvIGJlIHNob3J0IGZv
ciBTZWN1cmUgVmlydHVhbCBNYWNoaW5lLiBTbyB0aGlzIHBhdGNoc2V0IHVzZQ0KPiA+IFNoYXJl
ZCBWaXJ0dWFsIEFkZHJlc3NpbmcgaW5zdGVhZCBvZiBTaGFyZWQgVmlydHVhbCBNZW1vcnkuIEFu
ZCBpdA0KPiA+IHdvdWxkIGJlIGFwcGxpZWQgaW4gZnV0dXJlIChTVkEpcmVsYXRlZCBwYXRjaCBz
ZXJpZXMgYXMgd2VsbC4NCj4gPg0KPiA+IFFlbXUgaGFzIGFuIGV4aXN0aW5nIG5vdGlmaWVyIGZy
YW1ld29yayBiYXNlZCBvbiBNZW1vcnlSZWdpb24sIHdoaWNoDQo+ID4gYXJlIHVzZWQgZm9yIE1B
UC9VTk1BUC4gSG93ZXZlciwgaXQgaXMgbm90IHdlbGwgc3VpdGVkIGZvciB2aXJ0LVNWQS4NCj4g
PiBSZWFzb25zIGFyZSBhcyBiZWxvdzoNCj4gPiAtIHZpcnQtU1ZBIHdvcmtzIGFsb25nIHdpdGgg
UFQgPSAxDQo+ID4gLSBpZiBQVCA9IDEgSU9NTVUgTVIgYXJlIGRpc2FibGVkIHNvIE1SIG5vdGlm
aWVyIGFyZSBub3QgcmVnaXN0ZXJlZA0KPiA+IC0gbmV3IG5vdGlmaWVycyBkbyBub3QgZml0IG5p
Y2VseSBpbiB0aGlzIGZyYW1ld29yayBhcyB0aGV5IG5lZWQgdG8gYmUNCj4gPiAgIHJlZ2lzdGVy
ZWQgZXZlbiBpZiBQVCA9IDENCj4gPiAtIG5lZWQgYSBuZXcgZnJhbWV3b3JrIHRvIGF0dGFjaCB0
aGUgbmV3IG5vdGlmaWVycw0KPiA+IC0gQWRkaXRpb25hbCBiYWNrZ3JvdW5kIGNhbiBiZSBnb3Qg
ZnJvbToNCj4gPiAgIGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZl
bC8yMDE3LTA0L21zZzA0OTMxLmh0bWwNCj4gPg0KPiA+IFNvIGEgbmV3IGlvbW11IG5vdGlmaWVy
IGZyYW1ld29yayBpcyBuZWVkZWQuIFRoaXMgcGF0Y2hzZXQgaW50cm9kdWNlcw0KPiA+IGEgbm90
aWZpZXIgZnJhbWV3b3JrIGJhc2VkIG9uIElPTU1VU1ZBQ29udGV4dC4gSU9NTVVTVkFDb250ZXh0
IGlzDQo+ID4gaW50cm9kdWNlZCB0byBiZSBhbiBhYnN0cmFjdCBvZiB2aXJ0LVNWQSBvcGVyYXRp
b25zIGluIFFlbXUuDQo+ID4NCj4gPiBQYXRjaCBPdmVydmlldzoNCj4gPiAqIDEgLSAyOiByZW5h
bWUgZXhpc3RpbmcgbmFtaW5nLCB0aGUgSU9NTVUgTWVtb3J5UmVnaW9uIE5vdGlmaWVyDQo+ID4g
ICAgICAgICAgZnJhbWV3b3JrDQo+ID4gKiAzIC0gNDogaW50cm9kdWNlIFNWQSBub3RpZmllciBm
cmFtZXdvcmsgYmFzZWQgb24gSU9NTVVTVkFDb250ZXh0DQo+ID4gKiA1IC0gNzogaW50cm9kdWNl
IFBDSVNWQU9wcyBhbmQgZXhwb3NlIHRoZSBTVkEgbm90ZmllciBmcmFtZXdvcmsNCj4gPiAgICAg
ICAgICB0aHJvdWdoIGh3L3BjaSBsYXllcg0KPiA+ICogOCAtIDEyOiBzaG93IHRoZSB1c2FnZSBv
ZiBTVkEgbm90aWZpZXIgaW4gSW50ZWwgdklPTU1VIGVtdWxhdG9yDQo+IA0KPiBEbyB5b3UgaGF2
ZSBvbmxpbmUgYnJhbmNoIHNvIHRoYXQgSSBjYW4gY2hlY2sgb3V0Pw0KDQp5ZXMsIEkgc2hvdWxk
IGhhdmUgcGFzdGVkIGl0LiBIZXJlIGl0IGlzOg0KaHR0cHM6Ly9naXRodWIuY29tL2x1eGlzMTk5
OS9zdmFfbm90aWZpZXIuZ2l0DQoNCj4gVGhlIHBhdGNoZXMgYXJlIGEgYml0IHNjYXR0ZXJlZCBh
bmQgaXQncyByZWFsbHkgaGFyZCBmb3IgbWUgdG8NCj4gcmVmZXJlbmNlIHRoaW5ncyB3aXRoaW4g
aXQuLi4gU28gYSBjb21wbGV0ZSB0cmVlIHRvIHJlYWQgd291bGQgYmUNCj4gbmljZS4NCj4gDQo+
IEkgcm91Z2hseSB3ZW50IG92ZXIgbW9zdCBvZiB0aGUgcGF0Y2hlcywgYW5kIHRoZSBmcmFtZXdv
cmsgeW91DQo+IGludHJvZHVjZWQgaXMgc3RpbGwgbm90IHRoYXQgY2xlYXIgdG8gbWUuICBGb3Ig
bm93IEkgZmVlbCBsaWtlIGl0IGNhbg0KPiBiZSBzaW1wbGlmaWVkIHNvbWVob3csIGJ1dCBJJ2xs
IGhvbGQgYW5kIHNwZWFrIGFmdGVyIEkgcmVhZCB0aGUgd2hvbGUNCj4gdHJlZSBhZ2Fpbi4NCj4g
DQo+IEFsc28sIGl0J2xsIGJlIGdvb2QgdG9vIGlmIHlvdSBjYW4gYWx3YXlzIHByb3ZpZGUgc29t
ZSBzdGF0dXMgdXBkYXRlDQo+IG9mIHRoZSBrZXJuZWwtY291bnRlcnBhcnQgaXQuDQoNCkdvb2Qg
c3VnZ2VzdGlvbi4gRm9yIHRoaXMgcGF0Y2hzZXQsIGl0IG9ubHkgYWZmZWN0cyBRZW11LiBZZWFo
LCBidXQgZm9yDQp0aGUgd2hvbGUgdmlydC1TVkEgZW5hYmxpbmcsIHRoZXJlIGlzIGtlcm5lbC1j
b3VudGVycGFydHMuIEkgd291bGQgZG8NCml0IGluIHRoZSB2aXJ0LVNWQSBwYXRjaHNldCBzZXJp
ZXMuDQoNClRoYW5rcywNCllpIExpdQ0K

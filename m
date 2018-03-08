Received: from eggs.gnu.org ([2001:4830:134:3::10]:45860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1etrZC-00035B-JA
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1etrZ8-0007PJ-O9
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:10:26 -0500
Received: from mga01.intel.com ([192.55.52.88]:4319)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1etrZ8-0007Oq-Bv
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 04:10:22 -0500
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Thu, 8 Mar 2018 09:10:17 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439B8A8FE@SHSMSX104.ccr.corp.intel.com>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<20180306065545.GE3615@xz-mi>
	<A2975661238FB949B60364EF0F2C257439B87835@SHSMSX104.ccr.corp.intel.com>
	<20180307053800.GH17720@xz-mi>
In-Reply-To: <20180307053800.GH17720@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "Tian, Kevin" <kevin.tian@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>

PiBGcm9tOiBQZXRlciBYdSBbbWFpbHRvOnBldGVyeEByZWRoYXQuY29tXQ0KPiBTZW50OiBXZWRu
ZXNkYXksIE1hcmNoIDcsIDIwMTggMTozOCBQTQ0KPiBUbzogTGl1LCBZaSBMIDx5aS5sLmxpdUBp
bnRlbC5jb20+DQo+IENjOiBMaXUsIFlpIEwgPHlpLmwubGl1QGxpbnV4LmludGVsLmNvbT47IHFl
bXUtZGV2ZWxAbm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb207DQo+IGRhdmlkQGdpYnNvbi5kcm9w
YmVhci5pZC5hdTsgcGJvbnppbmlAcmVkaGF0LmNvbTsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5j
b207DQo+IGVyaWMuYXVnZXIucHJvQGdtYWlsLmNvbTsgVGlhbiwgS2V2aW4gPGtldmluLnRpYW5A
aW50ZWwuY29tPjsNCj4gamFzb3dhbmdAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYzIDAwLzEyXSBJbnRyb2R1Y2UgbmV3IGlvbW11IG5vdGlmaWVyIGZyYW1ld29yayBmb3Igdmly
dC1TVkENCj4gDQo+IE9uIFR1ZSwgTWFyIDA2LCAyMDE4IGF0IDA3OjQ1OjM5QU0gKzAwMDAsIExp
dSwgWWkgTCB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPiA+ID4gRG8geW91IGhhdmUgb25saW5l
IGJyYW5jaCBzbyB0aGF0IEkgY2FuIGNoZWNrIG91dD8NCj4gPg0KPiA+IHllcywgSSBzaG91bGQg
aGF2ZSBwYXN0ZWQgaXQuIEhlcmUgaXQgaXM6DQo+ID4gaHR0cHM6Ly9naXRodWIuY29tL2x1eGlz
MTk5OS9zdmFfbm90aWZpZXIuZ2l0DQo+IA0KPiBUaGFua3MuDQo+IA0KPiA+DQo+ID4gPiBUaGUg
cGF0Y2hlcyBhcmUgYSBiaXQgc2NhdHRlcmVkIGFuZCBpdCdzIHJlYWxseSBoYXJkIGZvciBtZSB0
bw0KPiA+ID4gcmVmZXJlbmNlIHRoaW5ncyB3aXRoaW4gaXQuLi4gU28gYSBjb21wbGV0ZSB0cmVl
IHRvIHJlYWQgd291bGQgYmUNCj4gPiA+IG5pY2UuDQo+ID4gPg0KPiA+ID4gSSByb3VnaGx5IHdl
bnQgb3ZlciBtb3N0IG9mIHRoZSBwYXRjaGVzLCBhbmQgdGhlIGZyYW1ld29yayB5b3UNCj4gPiA+
IGludHJvZHVjZWQgaXMgc3RpbGwgbm90IHRoYXQgY2xlYXIgdG8gbWUuICBGb3Igbm93IEkgZmVl
bCBsaWtlIGl0DQo+ID4gPiBjYW4gYmUgc2ltcGxpZmllZCBzb21laG93LCBidXQgSSdsbCBob2xk
IGFuZCBzcGVhayBhZnRlciBJIHJlYWQgdGhlDQo+ID4gPiB3aG9sZSB0cmVlIGFnYWluLg0KPiA+
ID4NCj4gPiA+IEFsc28sIGl0J2xsIGJlIGdvb2QgdG9vIGlmIHlvdSBjYW4gYWx3YXlzIHByb3Zp
ZGUgc29tZSBzdGF0dXMgdXBkYXRlDQo+ID4gPiBvZiB0aGUga2VybmVsLWNvdW50ZXJwYXJ0IGl0
Lg0KPiA+DQo+ID4gR29vZCBzdWdnZXN0aW9uLiBGb3IgdGhpcyBwYXRjaHNldCwgaXQgb25seSBh
ZmZlY3RzIFFlbXUuIFllYWgsIGJ1dA0KPiA+IGZvciB0aGUgd2hvbGUgdmlydC1TVkEgZW5hYmxp
bmcsIHRoZXJlIGlzIGtlcm5lbC1jb3VudGVycGFydHMuIEkgd291bGQNCj4gPiBkbyBpdCBpbiB0
aGUgdmlydC1TVkEgcGF0Y2hzZXQgc2VyaWVzLg0KPiANCj4gSWYgeW91IHN0aWxsIHdhbnQgdG8g
cG9zdCBzZXBhcmF0ZWx5IC0gSSdtIHRoaW5raW5nIHdoZXRoZXIgaXQnbGwgYmUgZ29vZCB5b3Ug
cHV0IHRoZQ0KPiB2ZmlvIGNoYW5nZXMgaW50byB0aGUgMm5kIHZpcnQtc3ZhIHNlcmllcywgc2lu
Y2UgdGhhdCBsb29rcyBtb3JlIGxpa2UgaW4gdGhhdCBjYXRlZ29yeS4NCj4gT3Igc2F5LCB3ZSBj
YW4gaW50cm9kdWNlIFNWQU9wcy9QQVNJRE9wcywgd2UgaW1wbGVtZW50IG1vcmUgdklPTU1VDQo+
IGludmFsaWRhdGlvbiByZXF1ZXN0IGhhbmRsaW5nLCB3ZSBjYWxsIGl0IGluIElPTU1VIGNvZGUs
IGJ1dCB3ZSBkb24ndCBpbXBsZW1lbnQgYW55DQo+IG9mIHRoZSBkZXZpY2UgKHZmaW8pIHRoYXQg
cHJvdmlkZSB0aGF0IG9wcy4NCj4gDQo+IE9yIG1heWJlIHdlIGNhbiBqdXN0IHBvc3QgdGhlIHdo
b2xlIHN0dWZmIGFsdG9nZXRoZXIsIHNpbmNlIGFmdGVyIGFsbCB0aGVzZSB0d28gc2VyaWVzDQo+
IGFyZSBzdGlsbCBjbG9zZWx5IHJlbGF0ZWQgSU1ITyAoZS5nLiwgdGhlIFNWQU9wcyBkZWZpbml0
aW9uIHNob3VsZCBiZSBjbG9zZWx5IHJlbGF0ZWQgdG8NCj4gaG93IHRoZSBmaXJzdCB2ZmlvIHVz
ZXIgd291bGQgbGlrZSB0byB1c2UgaXQpLg0KPiANCj4gT25seSBteSB0d28gY2VudHMsIGFuZCBJ
IGRvbid0IGtub3cgaG93IG90aGVyIHBlb3BsZSB0aGluay4gIEl0J3MgdXAgdG8geW91IGFmdGVy
DQo+IGFsbC4gOikNCg0KWW91ciBzdWdnZXN0aW9uIGlzIGFwcHJlY2lhdGVkLiBNeSBpbml0aWFs
IHBsYW4gaXM6IGlmIHRoZSBTVkFPcHMvUEFTSURPcHMgYW5kDQpTVkFDb250ZXh0IHByb3Bvc2Fs
IGlzIGFjY2VwdGVkIGJ5IHJldmlld2Vycy4gVGhlbiBJIGNhbiBmdXJ0aGVyIG1lcmdlIHRoZSB0
d28NCnNlcmllcy4gU28gZmFyLCBzdGlsbCBuZWVkcyB0byB3b3JrIHdpdGggRGF2aWQgb24gdGhl
IFNWQUNvbnRleHQgZGVmaW5pdGlvbi4gSSdsbA0KYmFsYW5jZSB0aGUgc3VnZ2VzdGlvbiBmcm9t
IHlvdSB3aGVuIHNlbmRpbmcgbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MsDQpZaSBMaXUNCg0K

Received: from eggs.gnu.org ([209.51.188.92]:37018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@intel.com>) id 1gjDjv-00085P-2N
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 20:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@intel.com>) id 1gjDcU-0006kw-ST
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 20:34:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:60683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@intel.com>) id 1gjDcS-0006gI-3A
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 20:34:20 -0500
From: "Xu, Like" <like.xu@intel.com>
Date: Tue, 15 Jan 2019 01:34:08 +0000
Message-ID: <F7FC466FA1E455449AD0F9063BBE758E0BC3A340@SHSMSX101.ccr.corp.intel.com>
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
	<1547468699-17633-2-git-send-email-like.xu@linux.intel.com>
	<e0fe9258-dcb6-f0eb-edfc-bf158ba2dbb4@redhat.com>
In-Reply-To: <e0fe9258-dcb6-f0eb-edfc-bf158ba2dbb4@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v1 1/5] cpu: introduce die,
 the new cpu toppolgy emulation level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Like Xu <like.xu@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "drjones@redhat.com" <drjones@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIEJsYWtlIFttYWlsdG86
ZWJsYWtlQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTUsIDIwMTkgNDow
OCBBTQ0KPiBUbzogTGlrZSBYdSA8bGlrZS54dUBsaW51eC5pbnRlbC5jb20+OyBxZW11LWRldmVs
QG5vbmdudS5vcmcNCj4gQ2M6IGRyam9uZXNAcmVkaGF0LmNvbTsgUGV0ZXIgQ3Jvc3Rod2FpdGUN
Cj4gPGNyb3N0aHdhaXRlLnBldGVyQGdtYWlsLmNvbT47IEVkdWFyZG8gSGFia29zdCA8ZWhhYmtv
c3RAcmVkaGF0LmNvbT47DQo+IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyBY
dSwgTGlrZSA8bGlrZS54dUBpbnRlbC5jb20+Ow0KPiBNYXJjZWxvIFRvc2F0dGkgPG10b3NhdHRp
QHJlZGhhdC5jb20+OyBQYW9sbyBCb256aW5pDQo+IDxwYm9uemluaUByZWRoYXQuY29tPjsgaW1h
bW1lZG9AcmVkaGF0LmNvbTsgUmljaGFyZCBIZW5kZXJzb24NCj4gPHJ0aEB0d2lkZGxlLm5ldD4N
Cj4gU3ViamVjdDogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0ggdjEgMS81XSBjcHU6IGludHJvZHVj
ZSBkaWUsIHRoZSBuZXcgY3B1DQo+IHRvcHBvbGd5IGVtdWxhdGlvbiBsZXZlbA0KPiANCj4gT24g
MS8xNC8xOSA2OjI0IEFNLCBMaWtlIFh1IHdyb3RlOg0KPiA+IEZvbGxvd2luZyBjb2RlcyBvbiBz
bXBfY29yZXMsIHRoZSBzbXBfZGllcy9ucl9kaWVzL2RpZS1pZCBpcyBhZGRlZCB0bw0KPiA+IG1h
Y2hpbmUgYW5kIENQVVN0YXRlLiBJbiBhZGRpdGlvbiB0byBlbmFibGVfY3B1aWRfMHhiLA0KPiBl
bmFibGVfY3B1aWRfMHgxZg0KPiA+IGlzIGludHJvZHVjZWQgdG8gdHJhY2sgd2V0aGVyIGhvc3Qg
aXMgYSBuZXcgTUNQIG1hY2luZSBvciBqdXN0IGlnbm9yZWQuDQo+IA0KPiBzL3dldGhlci93aGV0
aGVyLywgcy9tYWNpbmUvbWFjaGluZS8NCltYdSwgTGlrZV0gU29ycnkgZm9yIHR5cG9zIGFuZCBp
bmNvbnZlbmllbmNlLg0KPiANCj4gPiBUaGUgbnVtYmVyIGZvciBkaWUgbGV2ZWxfdHlwZSBvbiBJ
bnRlbCBpcyA1IHdoaWxlIGNvcmUgdHlwZSBrZWVwcyAyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogTGlrZSBYdSA8bGlrZS54dUBsaW51eC5pbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGNwdXMu
YyAgICAgICAgICAgICAgICB8IDEgKw0KPiA+ICBpbmNsdWRlL3FvbS9jcHUuaCAgICAgfCAxICsN
Cj4gPiAgaW5jbHVkZS9zeXNlbXUvY3B1cy5oIHwgMSArDQo+ID4gIHFhcGkvbWlzYy5qc29uICAg
ICAgICB8IDEgKw0KPiA+ICB0YXJnZXQvaTM4Ni9jcHUuaCAgICAgfCA1ICsrKysrDQo+ID4gIDUg
ZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspDQo+ID4NCj4gDQo+ID4gKysrIGIvcWFwaS9t
aXNjLmpzb24NCj4gPiBAQCAtMzIyOSw2ICszMjI5LDcgQEANCj4gPiAgeyAnc3RydWN0JzogJ0Nw
dUluc3RhbmNlUHJvcGVydGllcycsDQo+ID4gICAgJ2RhdGEnOiB7ICcqbm9kZS1pZCc6ICdpbnQn
LA0KPiA+ICAgICAgICAgICAgICAnKnNvY2tldC1pZCc6ICdpbnQnLA0KPiA+ICsgICAgICAgICAg
ICAnKmRpZS1pZCc6ICdpbnQnLA0KPiANCj4gTWlzc2luZyBkb2N1bWVudGF0aW9uIG9mIHRoZSBu
ZXcgZmllbGQsIGluY2x1ZGluZyBhICcoc2luY2UgNC4wKScgdGFnLg0KW1h1LCBMaWtlXSBMZXQg
bWUgYWRkIG1vcmUgZG9jcyBpbiBuZXh0IHZlcnNpb24gYW5kIHRoYW5rcy4NCj4gDQo+ID4gICAg
ICAgICAgICAgICcqY29yZS1pZCc6ICdpbnQnLA0KPiA+ICAgICAgICAgICAgICAnKnRocmVhZC1p
ZCc6ICdpbnQnDQo+ID4gICAgfQ0KPiANCj4gDQo+IC0tDQo+IEVyaWMgQmxha2UsIFByaW5jaXBh
bCBTb2Z0d2FyZSBFbmdpbmVlcg0KPiBSZWQgSGF0LCBJbmMuICAgICAgICAgICArMS05MTktMzAx
LTMyMjYNCj4gVmlydHVhbGl6YXRpb246ICBxZW11Lm9yZyB8IGxpYnZpcnQub3JnDQoNCg==

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1fQSMx-00005m-KD
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1fQSMt-000475-LU
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:56:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:57636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1fQSMt-00045o-BH
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 02:56:27 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Wed, 6 Jun 2018 06:56:22 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1911F8B6B@SHSMSX101.ccr.corp.intel.com>
References: <CAHyh4xhckUtH=gfa5K+KVehz27hVznUg7UX-Ca-AcjCvtiAhHg@mail.gmail.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D1911F3CAE@SHSMSX101.ccr.corp.intel.com>
	<CAHyh4xhbVROe3xUXwojOMBHKdTxNms7ZqRkhpm+1N0XZm3xBuA@mail.gmail.com>
In-Reply-To: <CAHyh4xhbVROe3xUXwojOMBHKdTxNms7ZqRkhpm+1N0XZm3xBuA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] vIOMMU Posted-interrupt implementation - atomic
 operation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jintack Lim <jintack@cs.columbia.edu>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

PiBGcm9tOiBKaW50YWNrIExpbSBbbWFpbHRvOmppbnRhY2tAY3MuY29sdW1iaWEuZWR1XQ0KPiBT
ZW50OiBUdWVzZGF5LCBKdW5lIDUsIDIwMTggODo1NyBQTQ0KPiANCj4gVGhhbmtzLCBLZXZpbi4N
Cj4gDQo+IE9uIFR1ZSwgSnVuIDUsIDIwMTggYXQgMjo1NCBBTSwgVGlhbiwgS2V2aW4gPGtldmlu
LnRpYW5AaW50ZWwuY29tPiB3cm90ZToNCj4gPj4gRnJvbTogSmludGFjayBMaW0NCj4gPj4gU2Vu
dDogRnJpZGF5LCBKdW5lIDEsIDIwMTggMTE6NDcgQU0NCj4gPj4NCj4gPj4gSGksDQo+ID4+DQo+
ID4+IEknbSBpbXBsZW1lbnRpbmcgUG9zdGVkLWludGVycnVwdCBmdW5jdGlvbmFsaXR5IGluIHZJ
T01NVS4gQWNjb3JkaW5nDQo+ID4+IHRvIFZ0LWQgc3BlYyA1LjIuMywgSU9NTVUgcGVyZm9ybXMg
YSBjb2hlcmVudCBhdG9taWMgcmVhZC1tb2RpZnktDQo+IHdyaXRlDQo+ID4+IG9wZXJhdGlvbiBv
ZiB0aGUgcG9zdGVkLWludGVycnVwdCBkZXNjcmlwdG9yLiBJIHdvbmRlciBob3cgY2FuIHdlDQo+
ID4+IGFjaGlldmUgdGhpcyBjb25zaWRlcmluZyB0aGUgZ3Vlc3QgY2FuIG1vZGlmeSB0aGUgc2Ft
ZQ0KPiA+PiBwb3N0ZWQtaW50ZXJydXB0IGRlc2NyaXB0b3IgYW55dGltZS4gSXMgdGhlcmUgYW55
IGV4aXN0aW5nIG1lY2hhbmlzbQ0KPiA+PiB0aGF0IEkgY2FuIHVzZSBpbiBRRU1VPw0KPiA+Pg0K
PiA+DQo+ID4gSSBkb24ndCB0aGluayBpdCdzIHBvc3NpYmxlIHRvIGVtdWxhdGUgc3VjaCBvcGVy
YXRpb24gaW4gc29mdHdhcmUsIHVubGVzcw0KPiA+IHlvdSB3YW50IHRvIGNoYW5nZSBndWVzdCB0
byBiZSBjb29wZXJhdGl2ZS4gQWN0dWFsbHkgaXQgaXMgbm90IG5lY2Vzc2FyeS4NCj4gPiBWVC1k
IGRvZXMgc28gZHVlIHRvIHNvbWUgaGFyZHdhcmUgaW1wbGVtZW50YXRpb24gY29uc2lkZXJhdGlv
bi4NCj4gDQo+IFdvdWxkIHlvdSBtaW5kIGV4cGFuZGluZyB0aGlzPyBJJ20gY3VyaW91cyB3aGF0
IGl0IHdvdWxkIGJlLiBJcyBpdA0KPiBiZWNhdXNlIElPTU1VIGNhbid0IGRvIHNvbWV0aGluZyBs
aWtlIGNtcHhjaGcgaW5zdHJ1Y3Rpb25zPw0KDQpJIGRvbid0IGhhdmUgZnVydGhlciBpbmZvcm1h
dGlvbi4gQWJvdmUgaXMgd2hhdCBJIHdhcyB0b2xkIGJ5IGhhcmR3YXJlDQp0ZWFtLg0KDQo+IA0K
PiA+IFNpbmNlIHlvdSBhcmUgZW11bGF0aW5nIG9uIENQVSwgY291bGQganVzdCBmb2xsb3cgaG93
IENQVSBwb3N0ZWQNCj4gPiBpbnRlcnJ1cHQgaXMgY29uZHVjdGVkLiBJZiB5b3UgbG9vayBhdCBT
RE0gKDI5LjYgUG9zdGVkLUludGVycnVwdA0KPiA+IFByb2Nlc3NpbmcpOg0KPiA+DQo+ID4gICAg
ICAgICAiVGhlcmUgaXMgYSByZXF1aXJlbWVudCwgaG93ZXZlciwgdGhhdCBzdWNoIG1vZGlmaWNh
dGlvbnMgYmUNCj4gPiBkb25lIHVzaW5nIGxvY2tlZCByZWFkLW1vZGlmeS13cml0ZSBpbnN0cnVj
dGlvbnMuIg0KPiA+DQo+ID4gW2luc3RydWN0aW9uc10gbWVhbnMgeW91IGNhbiBkbyB1cGRhdGUg
bXVsdGlwbGUgdGltZXMgd2hlbiBwb3N0aW5nIGFuDQo+ID4gaW50ZXJydXB0LCBhcyBsb25nIGFz
IGVhY2ggdXBkYXRlIGlzIGF0b21pYy4NCj4gDQo+IEFoLCB0aGF0J3MgYSBnb29kIHBvaW50LiBT
byB0aGUgdW5pdCBvZiBhdG9taWMgb3BlcmF0aW9uIGRvZXNuJ3QgbmVlZA0KPiB0byBiZSB0aGUg
d2hvbGUgUEkgZGVzY3JpcHRvciwgYnV0IGl0IGNhbiBiZSBhbnkgc3Vic2V0IChlLmcuIGp1c3Qg
b25lDQo+IGJpdCkgb2YgdGhlIGRlc2NyaXB0b3I/IEJ5IGxvb2tpbmcgYXQgTGludXgga2VybmVs
IGNvZGUsIHRoYXQgc2VlbXMgdG8NCj4gYmUgdGhlIGNhc2UuDQo+IA0KDQpFeGFjdGx5LiA6LSkN
Cg0KVGhhbmtzDQpLZXZpbg0K

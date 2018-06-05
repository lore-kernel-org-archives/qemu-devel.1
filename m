Received: from eggs.gnu.org ([2001:4830:134:3::10]:51704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1fQ5rR-000477-58
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin.tian@intel.com>) id 1fQ5rN-0000oz-UJ
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:54:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:29356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kevin.tian@intel.com>)
	id 1fQ5rN-0000mM-LK
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 02:54:25 -0400
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Tue, 5 Jun 2018 06:54:17 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1911F3CAE@SHSMSX101.ccr.corp.intel.com>
References: <CAHyh4xhckUtH=gfa5K+KVehz27hVznUg7UX-Ca-AcjCvtiAhHg@mail.gmail.com>
In-Reply-To: <CAHyh4xhckUtH=gfa5K+KVehz27hVznUg7UX-Ca-AcjCvtiAhHg@mail.gmail.com>
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
To: Jintack Lim <jintack@cs.columbia.edu>, QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>

PiBGcm9tOiBKaW50YWNrIExpbQ0KPiBTZW50OiBGcmlkYXksIEp1bmUgMSwgMjAxOCAxMTo0NyBB
TQ0KPiANCj4gSGksDQo+IA0KPiBJJ20gaW1wbGVtZW50aW5nIFBvc3RlZC1pbnRlcnJ1cHQgZnVu
Y3Rpb25hbGl0eSBpbiB2SU9NTVUuIEFjY29yZGluZw0KPiB0byBWdC1kIHNwZWMgNS4yLjMsIElP
TU1VIHBlcmZvcm1zIGEgY29oZXJlbnQgYXRvbWljIHJlYWQtbW9kaWZ5LXdyaXRlDQo+IG9wZXJh
dGlvbiBvZiB0aGUgcG9zdGVkLWludGVycnVwdCBkZXNjcmlwdG9yLiBJIHdvbmRlciBob3cgY2Fu
IHdlDQo+IGFjaGlldmUgdGhpcyBjb25zaWRlcmluZyB0aGUgZ3Vlc3QgY2FuIG1vZGlmeSB0aGUg
c2FtZQ0KPiBwb3N0ZWQtaW50ZXJydXB0IGRlc2NyaXB0b3IgYW55dGltZS4gSXMgdGhlcmUgYW55
IGV4aXN0aW5nIG1lY2hhbmlzbQ0KPiB0aGF0IEkgY2FuIHVzZSBpbiBRRU1VPw0KPiANCg0KSSBk
b24ndCB0aGluayBpdCdzIHBvc3NpYmxlIHRvIGVtdWxhdGUgc3VjaCBvcGVyYXRpb24gaW4gc29m
dHdhcmUsIHVubGVzcw0KeW91IHdhbnQgdG8gY2hhbmdlIGd1ZXN0IHRvIGJlIGNvb3BlcmF0aXZl
LiBBY3R1YWxseSBpdCBpcyBub3QgbmVjZXNzYXJ5Lg0KVlQtZCBkb2VzIHNvIGR1ZSB0byBzb21l
IGhhcmR3YXJlIGltcGxlbWVudGF0aW9uIGNvbnNpZGVyYXRpb24uIA0KU2luY2UgeW91IGFyZSBl
bXVsYXRpbmcgb24gQ1BVLCBjb3VsZCBqdXN0IGZvbGxvdyBob3cgQ1BVIHBvc3RlZCANCmludGVy
cnVwdCBpcyBjb25kdWN0ZWQuIElmIHlvdSBsb29rIGF0IFNETSAoMjkuNiBQb3N0ZWQtSW50ZXJy
dXB0DQpQcm9jZXNzaW5nKToNCg0KCSJUaGVyZSBpcyBhIHJlcXVpcmVtZW50LCBob3dldmVyLCB0
aGF0IHN1Y2ggbW9kaWZpY2F0aW9ucyBiZSANCmRvbmUgdXNpbmcgbG9ja2VkIHJlYWQtbW9kaWZ5
LXdyaXRlIGluc3RydWN0aW9ucy4iDQoNCltpbnN0cnVjdGlvbnNdIG1lYW5zIHlvdSBjYW4gZG8g
dXBkYXRlIG11bHRpcGxlIHRpbWVzIHdoZW4gcG9zdGluZyBhbg0KaW50ZXJydXB0LCBhcyBsb25n
IGFzIGVhY2ggdXBkYXRlIGlzIGF0b21pYy4NCg0KVGhhbmtzDQpLZXZpbg0KDQo=

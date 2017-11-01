Received: from eggs.gnu.org ([2001:4830:134:3::10]:48189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9uWL-0004BL-NB
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9uWG-0004o4-53
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:01:33 -0400
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:58096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1e9uWF-0004mU-Vw
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 11:01:28 -0400
From: "Nawrocki, Michael" <Michael.Nawrocki@gtri.gatech.edu>
Date: Wed, 1 Nov 2017 15:01:25 +0000
Message-ID: <015284D3-971A-469F-A801-9573DA3F1F36@gtri.gatech.edu>
References: <20171031154407.4184-1-michael.nawrocki@gtri.gatech.edu>
	<CAFEAcA8Cv1+E9v3dSqPkUDd7s9zp=V+UJ1V7oXJBWzwnQdzFSg@mail.gmail.com>
In-Reply-To: <CAFEAcA8Cv1+E9v3dSqPkUDd7s9zp=V+UJ1V7oXJBWzwnQdzFSg@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <500BC32DCBE361459B7E932B6DE097D3@gtri.org>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] Add 8-byte wide AMD flash support,
 partial interleaving
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Michael Walle <michael@walle.cc>, Jan Kiszka <jan.kiszka@web.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max
	Reitz <mreitz@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

DQpPbiAxMC8zMS8xNywgMTM6MDAsICJQZXRlciBNYXlkZWxsIiA8cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnPiB3cm90ZToNCg0KICAgIE9uIDMxIE9jdG9iZXIgMjAxNyBhdCAxNTo0NCwgTWlrZSBO
YXdyb2NraQ0KICAgIDxtaWNoYWVsLm5hd3JvY2tpQGd0cmkuZ2F0ZWNoLmVkdT4gd3JvdGU6DQog
ICAgPiBUaGlzIHBhdGNoIHNldCBkb2VzIGEgZmV3IHRoaW5ncy4gRmlyc3QsIGl0IHN3aXRjaGVz
IHRoZSBBTUQgQ0ZJIGZsYXNoIE1NSU8NCiAgICA+IG9wZXJhdGlvbnMgZnJvbSB0aGUgb2xkIE1N
SU8gQVBJIHRvIHRoZSBuZXcgb25lLiBTZWNvbmQsIGl0IGVuYWJsZXMgOC1ieXRlDQogICAgPiB3
aWRlIGZsYXNoIGFycmF5cy4gRmluYWxseSwgaXQgc3VwcG9ydHMgcnVkaW1lbnRhcnkgaW50ZXJs
ZWF2aW5nIG9mIG5vdGlvbmFsDQogICAgPiBmbGFzaCAiY2hpcHMiLiBJdCBpcyBleHBlY3RlZCB0
aGF0IGNvbW1hbmRzIHdpbGwgYmUgc2VudCB0byBhbGwgImNoaXBzIg0KICAgID4gc2ltdWx0YW5l
b3VzbHkuIFNlZSB0aGUgZXhhbXBsZSBpbiB0aGUgc2Vjb25kIHBhdGNoIGZvciBtb3JlIGRldGFp
bHMuIFRoaXMNCiAgICA+IGJlaGF2aW9yIGlzIHVzZWQgYnkgZHJpdmVycyBmb3IgdGhlIFBQTUM3
NDAwIFBvd2VyUEMgZXZhbHVhdGlvbiBib2FyZC4NCiAgICANCiAgICBJJ20gY29uZnVzZWQgYnkg
dGhlIGludGVybGVhdmluZyBwYXJ0LiBDYW4geW91IGV4cGxhaW4gaG93IHRoaXMNCiAgICBkaWZm
ZXJzIGZyb20gdGhlIGludGVybGVhdmluZyB3ZSBhbHJlYWR5IHN1cHBvcnQgaW4gcGZsYXNoX2Nm
aTAxLmMNCiAgICB2aWEgc2V0dGluZyB3aWR0aCwgZGV2aWNlLXdpZHRoIGFuZCBtYXgtZGV2aWNl
LXdpZHRoID8gKHNlZSB0aGUgY29tbWVudA0KICAgIGluIHRoZSBwZmxhc2hfY2ZpMDFfcHJvcGVy
dGllc1tdIGFycmF5IGFib3V0IGhvdyB0aG9zZSBzZXR0aW5ncw0KICAgIGludGVyYWN0KS4gSWYg
aXQgaXMgdGhlIHNhbWUgdGhpbmcsIHdlIHNob3VsZCByZWFsbHkgaW1wbGVtZW50IGl0DQogICAg
aW4gdGhlIHNhbWUgd2F5IGZvciBib3RoIGtpbmRzIG9mIGZsYXNoIGRldmljZS4NCiAgICANCiAg
ICB0aGFua3MNCiAgICAtLSBQTU0NCiAgICANCg0KTG9va2luZyB0aHJvdWdoIHBmbGFzaF9jZmkw
MS5jLCBpdCBsb29rcyBlc3NlbnRpYWxseSB0aGUgc2FtZSwgdGhvdWdoIG15IGNvZGUgZG9lc27i
gJl0IHJlcHJlc2VudCBtYXhfZGV2aWNlX3dpZHRoLiBUaGUgaW50ZXJsZWF2aW5nIGluIHBmbGFz
aF9jZmkwMS5jIGlzIG1vcmUgcm9idXN0IHRoYW4gd2hhdCBJIGltcGxlbWVudGVkLiBTaG91bGQg
SSByZXZlcnQgdGhlIGNoYW5nZXMgdG8gdGhlIHBmbGFzaF9jZmkwMl9yZWdpc3RlciBwcm90b3R5
cGUgYW5kIG1pcnJvciB0aGUgcWRldiBwcm9wZXJ0eSBpbXBsZW1lbnRhdGlvbiBwZmxhc2hfY2Zp
MDEgdXNlcz8gVGhpcyB3b3VsZCBkcmFzdGljYWxseSByZWR1Y2UgdGhlIG51bWJlciBvZiBmaWxl
cyBhZmZlY3RlZC4NCg0KVGhhbmtzLA0KTWlrZQ0KDQo=

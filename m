Received: from eggs.gnu.org ([2001:4830:134:3::10]:32770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkib-0005us-Hg
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkiY-0001tp-3P
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:17:09 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:26696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkiR-0001e1-M8
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:17:01 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 11 Dec 2018 16:15:10 +0000
Message-ID: <2abf113b34c0478d853810ee1605a015@AMSPEX02CL03.citrite.net>
References: <20181211153047.GB18447@aepfle.de>
	<74c1c30c147444cea915ee1befa56cf6@AMSPEX02CL03.citrite.net>
	<20181211160752.GD18447@aepfle.de>
In-Reply-To: <20181211160752.GD18447@aepfle.de>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Xen-devel] memory leak in block/xen_disk in
 qemu-3.x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Olaf Hering' <olaf@aepfle.de>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBPbGFmIEhlcmluZyBbbWFpbHRv
Om9sYWZAYWVwZmxlLmRlXQ0KPiBTZW50OiAxMSBEZWNlbWJlciAyMDE4IDE2OjA4DQo+IFRvOiBQ
YXVsIER1cnJhbnQgPFBhdWwuRHVycmFudEBjaXRyaXguY29tPg0KPiBDYzogeGVuLWRldmVsQGxp
c3RzLnhlbnByb2plY3Qub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6
IFtYZW4tZGV2ZWxdIG1lbW9yeSBsZWFrIGluIGJsb2NrL3hlbl9kaXNrIGluIHFlbXUtMy54DQo+
IA0KPiBPbiBUdWUsIERlYyAxMSwgUGF1bCBEdXJyYW50IHdyb3RlOg0KPiANCj4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBYZW4tZGV2ZWwgW21haWx0bzp4ZW4t
ZGV2ZWwtYm91bmNlc0BsaXN0cy54ZW5wcm9qZWN0Lm9yZ10gT24NCj4gQmVoYWxmDQo+ID4gPiBP
ZiBPbGFmIEhlcmluZw0KPiA+ID4gU2VudDogMTEgRGVjZW1iZXIgMjAxOCAxNTozMQ0KPiA+ID4g
VG86IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3Jn
DQo+ID4gPiBTdWJqZWN0OiBbWGVuLWRldmVsXSBtZW1vcnkgbGVhayBpbiBibG9jay94ZW5fZGlz
ayBpbiBxZW11LTMueA0KPiA+ID4NCj4gPiA+IFdoYXQgYXJlIHRoZSBsaXZlIHRpbWUgcnVsZXMg
b2YgaW9yZXEtPmJ1Zj8NCj4gPiA+IEluIG15IHRlc3RpbmcgdGhlIG1lbW9yeSB1c2FnZSBvZiBx
ZW11IGlzIGNvbnN0YW50bHkgZ3Jvd2luZyBmcm9tDQo+IGFib3V0DQo+ID4gPiAyNTBNQiB0byBz
ZXZlcmFsIEdCIGFmdGVyIGEgZmV3IGRheXMuDQo+ID4gQXJlIHlvdSBwZXJoYXBzIHJ1bm5pbmcg
aW50byB0aGUgcHJvYmxlbSBhZGRyZXNzZWQgYnkgdGhpcyBwYXRjaD8NCj4gPiBodHRwczovL2xp
c3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAxOC0xMS9tc2cwMDI0NC5odG1s
DQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgYSBmaXgsIHJhdGhlciB0aGFuIGFuIGltcHJvdmVtZW50
Lg0KPiBNb3JlIHRoYW4gYSBtb250aCBwYXNzZWQgYWxyZWFkeSwgd2h5IGlzIGl0IG5vdCB5ZXQg
aW4gcWVtdS5naXQjbWFzdGVyPw0KPiANCg0KSXQgd2FzIG5hY2tlZCBvbiB0aGUgYmFzaXMgdGhh
dCB4ZW5fZGlzayBpcyBsZWdhY3kuIEkgaGF2ZSByZS1iYXNlZCBpdCBvbiBteSBzZXJpZXMgcmUt
d29ya2luZyB4ZW5fZGlzayBhbmQsIGFzIHNvb24gYXMgdGhhdCBpcyBhbGwgYWNrZWQsIEkgd2ls
bCBwb3N0IHRoZSByZS1iYXNlZCBwYXRjaC4NCg0KICBQYXVsDQoNCj4gT2xhZg0K

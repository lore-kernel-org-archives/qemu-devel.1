Received: from eggs.gnu.org ([2001:4830:134:3::10]:55644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkUv-0000JG-UM
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkUr-0007oS-27
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:03:01 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:25917)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWkUq-0007mq-Ln
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:02:56 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 11 Dec 2018 16:01:51 +0000
Message-ID: <74c1c30c147444cea915ee1befa56cf6@AMSPEX02CL03.citrite.net>
References: <20181211153047.GB18447@aepfle.de>
In-Reply-To: <20181211153047.GB18447@aepfle.de>
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
To: 'Olaf Hering' <olaf@aepfle.de>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYZW4tZGV2ZWwgW21haWx0bzp4
ZW4tZGV2ZWwtYm91bmNlc0BsaXN0cy54ZW5wcm9qZWN0Lm9yZ10gT24gQmVoYWxmDQo+IE9mIE9s
YWYgSGVyaW5nDQo+IFNlbnQ6IDExIERlY2VtYmVyIDIwMTggMTU6MzENCj4gVG86IHhlbi1kZXZl
bEBsaXN0cy54ZW5wcm9qZWN0Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IFN1YmplY3Q6
IFtYZW4tZGV2ZWxdIG1lbW9yeSBsZWFrIGluIGJsb2NrL3hlbl9kaXNrIGluIHFlbXUtMy54DQo+
IA0KPiBXaGF0IGFyZSB0aGUgbGl2ZSB0aW1lIHJ1bGVzIG9mIGlvcmVxLT5idWY/DQo+IA0KPiBJ
biBteSB0ZXN0aW5nIHRoZSBtZW1vcnkgdXNhZ2Ugb2YgcWVtdSBpcyBjb25zdGFudGx5IGdyb3dp
bmcgZnJvbSBhYm91dA0KPiAyNTBNQiB0byBzZXZlcmFsIEdCIGFmdGVyIGEgZmV3IGRheXMuDQoN
CkFyZSB5b3UgcGVyaGFwcyBydW5uaW5nIGludG8gdGhlIHByb2JsZW0gYWRkcmVzc2VkIGJ5IHRo
aXMgcGF0Y2g/DQoNCmh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZl
bC8yMDE4LTExL21zZzAwMjQ0Lmh0bWwNCg0KICBQYXVsDQoNCj4gDQo+IFNvbWUgZGVidWdnaW5n
IHNob3dzIHRoYXQgaW9yZXFfcnVuaW9fcWVtdV9haW8oKSBvdmVyd3JpdGVzIGlvcmVxLT5idWYs
DQo+IHdoaWNoIGNvbnRyaWJ1dGVzIHRvIHRoZSBsZWFrLiBJbiBhZGRpdGlvbiwgaW9yZXFfcmVz
ZXQoKSBhbHNvIGp1c3QNCj4gZ2xvYmJlcnMgaW9yZXctPmJ1Zi4gV2hpbGUgdGhpcyB3YXMgb2Jz
ZXJ2ZWQgd2l0aCBhIGJhY2twb3J0IG9mIHhlbl9kaXNrDQo+IGNoYW5nZXMgdG8gcWVtdS0yLjks
IHRoZSBjb2RlIGluIHhlbl9kaXNrLmMgZGlkIG5vdCBjaGFuZ2UgaW4gdGhpcw0KPiByZWdhcmQu
IEkgY2hhbmdlZCB0aGUgY29kZSB0byBjYWxsIHFlbXVfdmZyZWUoaW9yZXEtPmJ1ZikgaW4gdGhl
IGZldw0KPiBwbGFjZXMgdGhhdCBnbG9iYmVyIHRoZSBwb2ludGVyLCB0aGF0IGZpeGVzIHRoZSBs
ZWFrIGZvciBtZS4NCj4gDQo+IFJpZ2h0IG5vdyBuZWl0aGVyIHFlbXUtMy4wIG5vciAzLjEgZm9y
IG1lLCBzbyBJIGNhbiBub3QgdGVzdA0KPiBxZW11LmdpdCNtYXN0ZXIgaWYgaXQgZXZlbnR1YWxs
eSBiZWhhdmVzIGRpZmZlcmVudCB0aGFuDQo+IHFlbXUuZ2l0I3N0YWJsZS0yLjkrYmFja3BvcnQu
DQo+IA0KPiBPbGFmDQo=

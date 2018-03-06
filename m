Received: from eggs.gnu.org ([2001:4830:134:3::10]:32771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1et4Hx-0002lE-3P
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:33:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1et4Ht-0000HL-Vw
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:33:21 -0500
Received: from smtp65.cstnet.cn ([159.226.251.65]:37384 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1et4Ht-0000Ga-BY
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 23:33:17 -0500
Date: Tue, 6 Mar 2018 12:33:11 +0800 (GMT+08:00)
From: "Su Hang" <suhang16@mails.ucas.ac.cn>
In-Reply-To: <20180302112911.GE6026@stefanha-x1.localdomain>
References: <1519788689-11967-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<20180302112911.GE6026@stefanha-x1.localdomain>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2feee67f.29662.161f995af1c.Coremail.suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v3] scripts/checkpatch.pl: add check for
 `while` and `for`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: thuth@redhat.com, qemu-devel@nongnu.org

QXMgdG9vIG1hbnkgZW1haWxzIG92ZXJ3aGVsbWVkIG15IGVtYWlsIGJveCwgSSBhbSB2ZXJ5IHNv
cnJ5IGZvciBub3Qgc2VlaW5nIHlvdXIgcmVwbHkgdW50aWwgdGhpcyBtb3JuaW5nLgoKSSB3aWxs
IGZpeCB3cm9uZyB1c2luZyBvZiBnaXQgcmlnaHQgbm93IQoKIlN0ZWZhbiBIYWpub2N6aSIgPHN0
ZWZhbmhhQHJlZGhhdC5jb20+d3JvdGU6Cj4gT24gV2VkLCBGZWIgMjgsIDIwMTggYXQgMTE6MzE6
MjlBTSArMDgwMCwgU3UgSGFuZyB3cm90ZToNCj4gPiBBZGRpbmcgY2hlY2sgZm9yIGB3aGlsZWAg
YW5kIGBmb3JgIHN0YXRlbWVudHMsIHdoaWNoIGNvbmRpdGlvbiBoYXMgbW9yZSB0aGFuDQo+ID4g
b25lIGxpbmUuDQo+ID4gDQo+ID4gVGhlIGZvcm1lciBjaGVja3BhdGNoLnBsIGNhbiBjaGVjayBg
aWZgIHN0YXRlbWVudCwgd2hpY2ggY29uZGl0aW9uIGhhcyBtb3JlDQo+ID4gdGhhbiBvbmUgbGlu
ZSwgd2hldGhlciBibG9jayBtaXNzZXMgYnJhY2Ugcm91bmQsIGxpa2UgdGhpczoNCj4gPiAnJycN
Cj4gPiBpZiAoY29uZDEgfHwNCj4gPiAgICAgY29uZDIpDQo+ID4gICAgIHN0YXRlbWVudDsNCj4g
PiAnJycNCj4gPiBCdXQgaXQgZG9lc24ndCBkbyB0aGUgc2FtZSBjaGVjayBmb3IgYGZvcmAgYW5k
IGB3aGlsZWAgc3RhdGVtZW50cy4NCj4gPiANCj4gPiBVc2luZyBgKD86Li4uKWAgaW5zdGVhZCBv
ZiBgKC4uLilgIGluIHJlZ2V4IHBhdHRlcm4gY2F0Y2guDQo+ID4gQmVjYXVzZSBgKD86Li4uKWAg
aXMgZmFzdGVyIGFuZCBhdm9pZHMgdW53YW50ZWQgc2lkZS1lZmZlY3QuDQo+IA0KPiBUaGlzIHBh
dGNoIGRvZXNuJ3QgYXBwbHkgdG8gcWVtdS5naXQvbWFzdGVyIGJlY2F1c2UgaXQncyBiYXNlZCBv
biB5b3VyDQo+IHYyIHBhdGNoLg0KPiANCj4gUGxlYXNlIHNlbmQgYSBzaW5nbGUgdjQgcGF0Y2gg
dGhhdCBjb21iaW5lcyB2MiBhbmQgdjMgY2hhbmdlcyBhbmQgY2FuIGJlDQo+IGFwcGxpZWQgdG8g
cWVtdS5naXQvbWFzdGVyLg0KPiANCj4gWW91IGNhbiB1c2UgImdpdCByZWJhc2UgLWkgb3JpZ2lu
L21hc3RlciIgdG8gY29tYmluZSBjaGFuZ2VzIGFuZCBwdXQNCj4gdGhlbSBvbnRvIHRoZSBsYXRl
c3Qgb3JpZ2luL21hc3Rlci4gIFNlZSB0aGUgImZpeHVwIiBhbmQgInNxdWFzaCINCj4gY29tbWFu
ZHMgaW4gZ2l0LXJlYmFzZSgxKSdzIGludGVyYWN0aXZlIG1vZGUgZm9yIGNvbWJpbmluZyBwYXRj
aGVzLg0KPiANCj4gVGhhbmtzIQ0KPiANCj4gPiBTdWdnZXN0ZWQtYnk6IFN0ZWZhbiBIYWpub2N6
aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4NCj4gPiBTdWdnZXN0ZWQtYnk6IEVyaWMgQmxha2UgPGVi
bGFrZUByZWRoYXQuY29tPg0KPiA+IFN1Z2dlc3RlZC1ieTogVGhvbWFzIEh1dGggPHRodXRoQHJl
ZGhhdC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3UgSGFuZyA8c3VoYW5nMTZAbWFpbHMudWNh
cy5hYy5jbj4NCj4gPiAtLS0NCj4gPiAgc2NyaXB0cy9jaGVja3BhdGNoLnBsIHwgNiArKystLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9jaGVja3BhdGNoLnBsIGIvc2NyaXB0cy9jaGVj
a3BhdGNoLnBsDQo+ID4gaW5kZXggMTBjMTM4MzQ0ZmE5Li5iZWQxZGJiZDU0ZDEgMTAwNzU1DQo+
ID4gLS0tIGEvc2NyaXB0cy9jaGVja3BhdGNoLnBsDQo+ID4gKysrIGIvc2NyaXB0cy9jaGVja3Bh
dGNoLnBsDQo+ID4gQEAgLTIzNTIsOSArMjM1Miw5IEBAIHN1YiBwcm9jZXNzIHsNCj4gPiAgCQkJ
fQ0KPiA+ICAJCX0NCj4gPiAgDQo+ID4gLSMgY2hlY2sgZm9yIG1pc3NpbmcgYnJhY2luZyByb3Vu
ZCBpZiBldGMNCj4gPiAtCQlpZiAoJGxpbmUgPX4gLyheLiopXGIoZm9yfHdoaWxlfGlmKVxiLyAm
Jg0KPiA+IC0JCQkkbGluZSAhfiAvXCNccyooZm9yfHdoaWxlfGlmKS8pIHsNCj4gPiArIyBjaGVj
ayBmb3IgbWlzc2luZyBicmFjaW5nIGFyb3VuZCBpZiBldGMNCj4gPiArCQlpZiAoJGxpbmUgPX4g
LyheLiopXGIoPzpmb3J8d2hpbGV8aWYpXGIvICYmDQo+ID4gKwkJCSRsaW5lICF+IC9cI1xzKig/
OmZvcnx3aGlsZXxpZikvKSB7DQo+ID4gIAkJCW15ICgkbGV2ZWwsICRlbmRsbiwgQGNodW5rcykg
PQ0KPiA+ICAJCQkJY3R4X3N0YXRlbWVudF9mdWxsKCRsaW5lbnIsICRyZWFsY250LCAxKTsNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCRkYmdfYWR2X2Fwdykgew0KPiA+IC0tIA0K
PiA+IDIuNy40DQo+ID4gDQo=

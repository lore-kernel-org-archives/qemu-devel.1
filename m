Received: from eggs.gnu.org ([209.51.188.92]:50241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9126ffe88=Paul.Durrant@citrix.com>)
	id 1gjkAd-0006nE-Dg
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:19:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9126ffe88=Paul.Durrant@citrix.com>)
	id 1gjkAa-00013f-8l
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:19:47 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 16 Jan 2019 12:19:40 +0000
Message-ID: <0dbd67c55295400980f87a191fc5d22c@AMSPEX02CL03.citrite.net>
References: <20190116121350.23863-1-alex.bennee@linaro.org>
In-Reply-To: <20190116121350.23863-1-alex.bennee@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] hw/block/xen: use proper format string for
 printing sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?J0FsZXggQmVubsOpZSc=?= <alex.bennee@linaro.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin
	Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, "open list:Block layer core" <qemu-block@nongnu.org>, =?utf-8?B?J1BoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpJw==?= <philmd@redhat.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IEJlbm7DqWUgW21haWx0
bzphbGV4LmJlbm5lZUBsaW5hcm8ub3JnXQ0KPiBTZW50OiAxNiBKYW51YXJ5IDIwMTkgMTI6MTQN
Cj4gVG86IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZw0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUu
b3JnOyBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+OyBTdGVmYW5vDQo+IFN0
YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+OyBBbnRob255IFBlcmFyZA0KPiA8YW50
aG9ueS5wZXJhcmRAY2l0cml4LmNvbT47IFBhdWwgRHVycmFudCA8UGF1bC5EdXJyYW50QGNpdHJp
eC5jb20+OyBLZXZpbg0KPiBXb2xmIDxrd29sZkByZWRoYXQuY29tPjsgTWF4IFJlaXR6IDxtcmVp
dHpAcmVkaGF0LmNvbT47IG9wZW4gbGlzdDpYODYNCj4gPHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9q
ZWN0Lm9yZz47IG9wZW4gbGlzdDpCbG9jayBsYXllciBjb3JlIDxxZW11LQ0KPiBibG9ja0Bub25n
bnUub3JnPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGh3L2Jsb2NrL3hlbjogdXNlIHByb3BlciBmb3Jt
YXQgc3RyaW5nIGZvciBwcmludGluZw0KPiBzZWN0b3JzDQo+IA0KPiBUaGUgJWx1IGZvcm1hdCBz
dHJpbmcgaXMgZGlmZmVyZW50IGRlcGVuZGluZyBvbiB0aGUgaG9zdCBhcmNoaXRlY3R1cmUNCj4g
d2hpY2ggY2F1c2VzIGJ1aWxkcyBsaWtlIHRoZSBkZWJpYW4tYXJtaGYtY3Jvc3MgYnVpbGQgdG8g
ZmFpbC4gVXNlIHRoZQ0KPiBjb3JyZWN0IFBSaTY0IGZvcm1hdCBzdHJpbmcuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQoNClRoaXMg
ZG9lcyB0aGUgc2FtZSB0aGluZyBhcyAieGVuOiBGaXggZm9ybWF0IHN0cmluZyIgZnJvbSBQaGls
aXBwZSwgYnV0IHRoaXMgdmFyaWFudCBpcyBiZXR0ZXIuLi4NCg0KUmV2aWV3ZWQtYnk6IFBhdWwg
RHVycmFudCA8cGF1bC5kdXJyYW50QGNpdHJpeC5jb20+DQoNCj4gLS0tDQo+ICBody9ibG9jay94
ZW4tYmxvY2suYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2Jsb2NrL3hlbi1ibG9jay5jIGIvaHcv
YmxvY2sveGVuLWJsb2NrLmMNCj4gaW5kZXggYmUyOGI2MzQ0Mi4uYTYzNjQ4N2IzZSAxMDA2NDQN
Cj4gLS0tIGEvaHcvYmxvY2sveGVuLWJsb2NrLmMNCj4gKysrIGIvaHcvYmxvY2sveGVuLWJsb2Nr
LmMNCj4gQEAgLTIxNSw3ICsyMTUsNyBAQCBzdGF0aWMgdm9pZCB4ZW5fYmxvY2tfcmVhbGl6ZShY
ZW5EZXZpY2UgKnhlbmRldiwgRXJyb3INCj4gKiplcnJwKQ0KPiANCj4gICAgICB4ZW5fZGV2aWNl
X2JhY2tlbmRfcHJpbnRmKHhlbmRldiwgInNlY3Rvci1zaXplIiwgIiV1IiwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbmYtPmxvZ2ljYWxfYmxvY2tfc2l6ZSk7DQo+IC0gICAg
eGVuX2RldmljZV9iYWNrZW5kX3ByaW50Zih4ZW5kZXYsICJzZWN0b3JzIiwgIiVsdSIsDQo+ICsg
ICAgeGVuX2RldmljZV9iYWNrZW5kX3ByaW50Zih4ZW5kZXYsICJzZWN0b3JzIiwgIiUiUFJJaTY0
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmxrX2dldGxlbmd0aChjb25mLT5i
bGspIC8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmYtPmxvZ2ljYWxfYmxv
Y2tfc2l6ZSk7DQo+IA0KPiAtLQ0KPiAyLjE3LjENCg0K

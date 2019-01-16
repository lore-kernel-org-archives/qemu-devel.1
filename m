Received: from eggs.gnu.org ([209.51.188.92]:57551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9126ffe88=Paul.Durrant@citrix.com>)
	id 1gjjvs-00018m-Jm
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9126ffe88=Paul.Durrant@citrix.com>)
	id 1gjjvZ-0008Cx-15
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:04:19 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 16 Jan 2019 12:03:42 +0000
Message-ID: <507850720d604665987131aed1ee47b6@AMSPEX02CL03.citrite.net>
References: <20190116120041.17095-1-philmd@redhat.com>
In-Reply-To: <20190116120041.17095-1-philmd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xen: Fix format string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?J1BoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpJw==?= <philmd@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSBbbWFpbHRvOnBoaWxtZEByZWRoYXQuY29tXQ0KPiBTZW50OiAxNiBKYW51YXJ5IDIwMTkg
MTI6MDENCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogUGF1bCBEdXJyYW50IDxQ
YXVsLkR1cnJhbnRAY2l0cml4LmNvbT47IEFudGhvbnkgUGVyYXJkDQo+IDxhbnRob255LnBlcmFy
ZEBjaXRyaXguY29tPjsgTWF4IFJlaXR6IDxtcmVpdHpAcmVkaGF0LmNvbT47IHFlbXUtDQo+IGJs
b2NrQG5vbmdudS5vcmc7IFN0ZWZhbm8gU3RhYmVsbGluaSA8c3N0YWJlbGxpbmlAa2VybmVsLm9y
Zz47IHhlbi0NCj4gZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmc7IEtldmluIFdvbGYgPGt3b2xm
QHJlZGhhdC5jb20+OyBQaGlsaXBwZQ0KPiBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5j
b20+DQo+IFN1YmplY3Q6IFtQQVRDSF0geGVuOiBGaXggZm9ybWF0IHN0cmluZw0KPiANCj4gVHJp
dmlhbCBmb3JtYXQgc3RyaW5nIGZpeCB0byBzb2x2ZToNCj4gDQo+ICAgaHcvYmxvY2sveGVuLWJs
b2NrLmM6IEluIGZ1bmN0aW9uICd4ZW5fYmxvY2tfcmVhbGl6ZSc6DQo+ICAgaHcvYmxvY2sveGVu
LWJsb2NrLmM6MjE4OjUzOiBlcnJvcjogZm9ybWF0ICclbHUnIGV4cGVjdHMgYXJndW1lbnQgb2YN
Cj4gdHlwZSAnbG9uZyB1bnNpZ25lZCBpbnQnLCBidXQgYXJndW1lbnQgNCBoYXMgdHlwZSAnaW50
NjRfdCB7YWthIGxvbmcgbG9uZw0KPiBpbnR9JyBbLVdlcnJvcj1mb3JtYXQ9XQ0KPiAgICAgICB4
ZW5fZGV2aWNlX2JhY2tlbmRfcHJpbnRmKHhlbmRldiwgInNlY3RvcnMiLCAiJWx1IiwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJsa19nZXRsZW5ndGgoY29uZi0+YmxrKSAv
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uZi0+bG9naWNhbF9ibG9ja19z
aXplKTsNCj4gDQo+IGJsa19nZXRsZW5ndGgoKSByZXR1cm5zIGFuIGludDY0X3QuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+
DQoNClJldmlld2VkLWJ5OiBQYXVsIER1cnJhbnQgPHBhdWwuZHVycmFudEBjaXRyaXguY29tPg0K
DQo+IC0tLQ0KPiAgaHcvYmxvY2sveGVuLWJsb2NrLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9i
bG9jay94ZW4tYmxvY2suYyBiL2h3L2Jsb2NrL3hlbi1ibG9jay5jDQo+IGluZGV4IGJlMjhiNjM0
NDIuLjNjZjIxNWI3MzAgMTAwNjQ0DQo+IC0tLSBhL2h3L2Jsb2NrL3hlbi1ibG9jay5jDQo+ICsr
KyBiL2h3L2Jsb2NrL3hlbi1ibG9jay5jDQo+IEBAIC0yMTUsNyArMjE1LDcgQEAgc3RhdGljIHZv
aWQgeGVuX2Jsb2NrX3JlYWxpemUoWGVuRGV2aWNlICp4ZW5kZXYsIEVycm9yDQo+ICoqZXJycCkN
Cj4gDQo+ICAgICAgeGVuX2RldmljZV9iYWNrZW5kX3ByaW50Zih4ZW5kZXYsICJzZWN0b3Itc2l6
ZSIsICIldSIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25mLT5sb2dpY2Fs
X2Jsb2NrX3NpemUpOw0KPiAtICAgIHhlbl9kZXZpY2VfYmFja2VuZF9wcmludGYoeGVuZGV2LCAi
c2VjdG9ycyIsICIlbHUiLA0KPiArICAgIHhlbl9kZXZpY2VfYmFja2VuZF9wcmludGYoeGVuZGV2
LCAic2VjdG9ycyIsICIlbGxkIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJs
a19nZXRsZW5ndGgoY29uZi0+YmxrKSAvDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25mLT5sb2dpY2FsX2Jsb2NrX3NpemUpOw0KPiANCj4gLS0NCj4gMi4xNy4yDQoNCg==

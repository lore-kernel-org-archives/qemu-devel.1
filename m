Received: from eggs.gnu.org ([209.51.188.92]:39985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=948d70b84=Paul.Durrant@citrix.com>)
	id 1gwkl1-0002ys-EW
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:35:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=948d70b84=Paul.Durrant@citrix.com>)
	id 1gwkkz-00045Y-BY
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:35:07 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 21 Feb 2019 09:34:16 +0000
Message-ID: <5816cdd23b46411392eee8e00ff08041@AMSPEX02CL03.citrite.net>
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-12-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-12-philmd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 11/25] xen: Let xencons_send() take a
 'size' argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?J1BoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpJw==?= <philmd@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S.
	Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano
	Stabellini <sstabellini@kernel.org>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSBbbWFpbHRvOnBoaWxtZEByZWRoYXQuY29tXQ0KPiBTZW50OiAyMCBGZWJydWFyeSAyMDE5
IDAxOjAyDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IFByYXNhZCBKIFBhbmRpdCA8cGpw
QGZlZG9yYXByb2plY3Qub3JnPjsgTWFyYy0NCj4gQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1
cmVhdUByZWRoYXQuY29tPjsgUGFvbG8gQm9uemluaQ0KPiA8cGJvbnppbmlAcmVkaGF0LmNvbT4N
Cj4gQ2M6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+OyBBbnRob255IFBlcmFyZA0K
PiA8YW50aG9ueS5wZXJhcmRAY2l0cml4LmNvbT47IHFlbXUtcHBjQG5vbmdudS5vcmc7IFN0ZWZh
biBCZXJnZXINCj4gPHN0ZWZhbmJAbGludXguaWJtLmNvbT47IERhdmlkIEdpYnNvbiA8ZGF2aWRA
Z2lic29uLmRyb3BiZWFyLmlkLmF1PjsgR2VyZA0KPiBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5j
b20+OyBaaGFuZyBDaGVuIDx6aGFuZ2NraWRAZ21haWwuY29tPjsgeGVuLQ0KPiBkZXZlbEBsaXN0
cy54ZW5wcm9qZWN0Lm9yZzsgQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhhdC5jb20+OyBTYW11
ZWwNCj4gVGhpYmF1bHQgPHNhbXVlbC50aGliYXVsdEBlbnMtbHlvbi5vcmc+OyBDaHJpc3RpYW4g
Qm9ybnRyYWVnZXINCj4gPGJvcm50cmFlZ2VyQGRlLmlibS5jb20+OyBBbWl0IFNoYWggPGFtaXRA
a2VybmVsLm9yZz47IExpIFpoaWppYW4NCj4gPGxpemhpamlhbkBjbi5mdWppdHN1LmNvbT47IENv
cmV5IE1pbnlhcmQgPG1pbnlhcmRAYWNtLm9yZz47IE1pY2hhZWwgUy4NCj4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+OyBQYXVsIER1cnJhbnQgPFBhdWwuRHVycmFudEBjaXRyaXguY29tPjsgSGFs
aWwNCj4gUGFzaWMgPHBhc2ljQGxpbnV4LmlibS5jb20+OyBTdGVmYW5vIFN0YWJlbGxpbmkgPHNz
dGFiZWxsaW5pQGtlcm5lbC5vcmc+Ow0KPiBxZW11LXMzOTB4QG5vbmdudS5vcmc7IFBhdmVsIERv
dmdhbHl1ayA8cGF2ZWwuZG92Z2FsdWtAaXNwcmFzLnJ1PjsNCj4gUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjMgMTEvMjVdIHhl
bjogTGV0IHhlbmNvbnNfc2VuZCgpIHRha2UgYSAnc2l6ZScgYXJndW1lbnQNCj4gDQo+IFRoZSBz
aW5nbGUgY2FsbGVyIG9mIHhlbmNvbnNfc2VuZCgpLCBjb25fZXZlbnQoKSBhbHJlYWR5IHVzZSB0
aGUNCj4gZGlmZmVyZW5jZSAnY29uLT5idWZmZXIuc2l6ZSAtIGNvbi0+YnVmZmVyLmNvbnN1bWVk
Jy4NCj4gRGVkdXBsaWNhdGUgYnkgcGFzc2luZyB0aGUgZGlmZmVyZW5jZSBhcyBhbiBhcmd1bWVu
dC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
cmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBody9jaGFyL3hlbl9jb25zb2xlLmMgfCAxMiArKysrKysr
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvY2hhci94ZW5fY29uc29sZS5jIGIvaHcvY2hhci94ZW5f
Y29uc29sZS5jDQo+IGluZGV4IDkxZjM0ZWYwNmMuLjA4M2IyYzhlMmEgMTAwNjQ0DQo+IC0tLSBh
L2h3L2NoYXIveGVuX2NvbnNvbGUuYw0KPiArKysgYi9ody9jaGFyL3hlbl9jb25zb2xlLmMNCj4g
QEAgLTE0NCwxMSArMTQ0LDEwIEBAIHN0YXRpYyB2b2lkIHhlbmNvbnNfcmVjZWl2ZSh2b2lkICpv
cGFxdWUsIGNvbnN0DQo+IHVpbnQ4X3QgKmJ1ZiwgaW50IGxlbikNCj4gICAgICB4ZW5fcHZfc2Vu
ZF9ub3RpZnkoJmNvbi0+eGVuZGV2KTsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgdm9pZCB4ZW5jb25z
X3NlbmQoc3RydWN0IFhlbkNvbnNvbGUgKmNvbikNCj4gK3N0YXRpYyB2b2lkIHhlbmNvbnNfc2Vu
ZChzdHJ1Y3QgWGVuQ29uc29sZSAqY29uLCBzc2l6ZV90IHNpemUpDQo+ICB7DQo+IC0gICAgc3Np
emVfdCBsZW4sIHNpemU7DQo+ICsgICAgc3NpemVfdCBsZW47DQo+IA0KPiAtICAgIHNpemUgPSBj
b24tPmJ1ZmZlci5zaXplIC0gY29uLT5idWZmZXIuY29uc3VtZWQ7DQo+ICAgICAgaWYgKHFlbXVf
Y2hyX2ZlX2JhY2tlbmRfY29ubmVjdGVkKCZjb24tPmNocikpIHsNCj4gICAgICAgICAgbGVuID0g
cWVtdV9jaHJfZmVfd3JpdGUoJmNvbi0+Y2hyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBjb24tPmJ1ZmZlci5kYXRhICsgY29uLT5idWZmZXIuY29uc3VtZWQsDQo+IEBAIC0y
ODAsMTAgKzI3OSwxMyBAQCBzdGF0aWMgdm9pZCBjb25fZGlzY29ubmVjdChzdHJ1Y3QgWGVuTGVn
YWN5RGV2aWNlDQo+ICp4ZW5kZXYpDQo+ICBzdGF0aWMgdm9pZCBjb25fZXZlbnQoc3RydWN0IFhl
bkxlZ2FjeURldmljZSAqeGVuZGV2KQ0KPiAgew0KPiAgICAgIHN0cnVjdCBYZW5Db25zb2xlICpj
b24gPSBjb250YWluZXJfb2YoeGVuZGV2LCBzdHJ1Y3QgWGVuQ29uc29sZSwNCj4geGVuZGV2KTsN
Cj4gKyAgICBzc2l6ZV90IHNpemU7DQo+IA0KPiAgICAgIGJ1ZmZlcl9hcHBlbmQoY29uKTsNCj4g
LSAgICBpZiAoY29uLT5idWZmZXIuc2l6ZSAtIGNvbi0+YnVmZmVyLmNvbnN1bWVkKQ0KPiAtICAg
ICAgICB4ZW5jb25zX3NlbmQoY29uKTsNCj4gKyAgICBzaXplID0gY29uLT5idWZmZXIuc2l6ZSAt
IGNvbi0+YnVmZmVyLmNvbnN1bWVkOw0KPiArICAgIGlmIChzaXplKSB7DQo+ICsgICAgICAgIHhl
bmNvbnNfc2VuZChjb24sIHNpemUpOw0KPiArICAgIH0NCg0KWW91IGludHJvZHVjZSB0aGlzIGhl
cmUsIG9ubHkgdG8gbW9kaWZ5IGl0IGluIHBhdGNoICMxMi4gV2h5IG5vdCBzcXVhc2ggdGhlIHR3
byB0b2dldGhlcj8NCg0KICBQYXVsDQoNCj4gIH0NCj4gDQo+ICAvKiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAq
Lw0KPiAtLQ0KPiAyLjIwLjENCg0K

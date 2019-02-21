Received: from eggs.gnu.org ([209.51.188.92]:47465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=948d70b84=Paul.Durrant@citrix.com>)
	id 1gwl4W-0001Kd-18
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=948d70b84=Paul.Durrant@citrix.com>)
	id 1gwl4L-00082T-53
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 04:55:12 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 21 Feb 2019 09:54:35 +0000
Message-ID: <16ead6a8b47b46858d5f7cd687e742be@AMSPEX02CL03.citrite.net>
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-14-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-14-philmd@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH v3 13/25] xen: Let buffer_append()
 return a size_t
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhpbGlwcGUgTWF0aGll
dS1EYXVkw6kgW21haWx0bzpwaGlsbWRAcmVkaGF0LmNvbV0NCj4gU2VudDogMjAgRmVicnVhcnkg
MjAxOSAwMTowMg0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBQcmFzYWQgSiBQYW5kaXQg
PHBqcEBmZWRvcmFwcm9qZWN0Lm9yZz47IE1hcmMtDQo+IEFuZHLDqSBMdXJlYXUgPG1hcmNhbmRy
ZS5sdXJlYXVAcmVkaGF0LmNvbT47IFBhb2xvIEJvbnppbmkNCj4gPHBib256aW5pQHJlZGhhdC5j
b20+DQo+IENjOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsgQW50aG9ueSBQZXJh
cmQNCj4gPGFudGhvbnkucGVyYXJkQGNpdHJpeC5jb20+OyBxZW11LXBwY0Bub25nbnUub3JnOyBT
dGVmYW4gQmVyZ2VyDQo+IDxzdGVmYW5iQGxpbnV4LmlibS5jb20+OyBEYXZpZCBHaWJzb24gPGRh
dmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdT47IEdlcmQNCj4gSG9mZm1hbm4gPGtyYXhlbEByZWRo
YXQuY29tPjsgWmhhbmcgQ2hlbiA8emhhbmdja2lkQGdtYWlsLmNvbT47IHhlbi0NCj4gZGV2ZWxA
bGlzdHMueGVucHJvamVjdC5vcmc7IENvcm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQuY29tPjsg
U2FtdWVsDQo+IFRoaWJhdWx0IDxzYW11ZWwudGhpYmF1bHRAZW5zLWx5b24ub3JnPjsgQ2hyaXN0
aWFuIEJvcm50cmFlZ2VyDQo+IDxib3JudHJhZWdlckBkZS5pYm0uY29tPjsgQW1pdCBTaGFoIDxh
bWl0QGtlcm5lbC5vcmc+OyBMaSBaaGlqaWFuDQo+IDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+
OyBDb3JleSBNaW55YXJkIDxtaW55YXJkQGFjbS5vcmc+OyBNaWNoYWVsIFMuDQo+IFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPjsgUGF1bCBEdXJyYW50IDxQYXVsLkR1cnJhbnRAY2l0cml4LmNvbT47
IEhhbGlsDQo+IFBhc2ljIDxwYXNpY0BsaW51eC5pYm0uY29tPjsgU3RlZmFubyBTdGFiZWxsaW5p
IDxzc3RhYmVsbGluaUBrZXJuZWwub3JnPjsNCj4gcWVtdS1zMzkweEBub25nbnUub3JnOyBQYXZl
bCBEb3ZnYWx5dWsgPHBhdmVsLmRvdmdhbHVrQGlzcHJhcy5ydT47DQo+IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogW1JGQyBQQVRDSCB2MyAx
My8yNV0geGVuOiBMZXQgYnVmZmVyX2FwcGVuZCgpIHJldHVybiBhIHNpemVfdA0KPiANCj4gVG8g
dGhlIFhlbiB0ZWFtOiB0aGlzIGlzIG5vdCB0cml2aWFsIHRvIG1lIHRvIGRlbW9uc3RyYXRlDQo+
IHRoaXMgYXNzZXJ0aW9uIGNhbiBuZXZlciBoYXBwZW4sIGJ1dCB0aGVuIHRoZSB3aG9sZSBzZXJp
ZXMNCj4gaXMganVzdGlmaWVkIGFuZCBJIGNhbiBjb252ZXJ0IHFlbXVfY2hyX2ZlX3dyaXRlKCkg
dG8gdXNlDQo+IHNpemVfdCBhcmd1bWVudC4NCj4gQ2FuIHlvdSBoZWxwIG1lIGhlcmU/DQoNCkkn
bSBub3QgcGFydGljdWxhcmx5IGZhbWlsaWFyIHdpdGggdGhpcyBiaXQgb2YgY29kZSBidXQgSSBj
YW4gdHJ5Li4uDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBody9jaGFyL3hlbl9jb25zb2xlLmMgfCAx
ICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2h3L2NoYXIveGVuX2NvbnNvbGUuYyBiL2h3L2NoYXIveGVuX2NvbnNvbGUuYw0KPiBpbmRleCAx
YTMwMDE0YTExLi41YjY3MmE1YTI0IDEwMDY0NA0KPiAtLS0gYS9ody9jaGFyL3hlbl9jb25zb2xl
LmMNCj4gKysrIGIvaHcvY2hhci94ZW5fY29uc29sZS5jDQo+IEBAIC05Miw2ICs5Miw3IEBAIHN0
YXRpYyBzc2l6ZV90IGJ1ZmZlcl9hcHBlbmQoc3RydWN0IFhlbkNvbnNvbGUgKmNvbikNCj4gICAg
ICB9DQo+IA0KPiAgIG91dDoNCj4gKyAgICBhc3NlcnQoYnVmZmVyLT5zaXplID49IGJ1ZmZlci0+
Y29uc3VtZWQpOw0KPiAgICAgIHJldHVybiBidWZmZXItPnNpemUgLSBidWZmZXItPmNvbnN1bWVk
Ow0KDQpJIHRoaW5rIHRoaXMgYXNzZXJ0aW9uIGlzIHJlYXNvbmFibGUgYXM6DQoNCi0gYnVmZmVy
X2FkdmFuY2UoKSBhcHBlYXJzIHRvIGhpdCBhIHRlcm1pbmF0aW9uIGNvbmRpdGlvbiB3aGVuIGJ1
ZmZlci0+Y29uc3VtZWQgPT0gYnVmZmVyLT5zaXplLiAoTm90aGluZyBjaGVja3MgZm9yIG92ZXJm
bG93IHdoaWNoIGlzIGJhZCwgYnV0IHRoYXQgZmFjdCBhbHNvIGxlbmRzIHdlaWdodCB0byB0aGUg
YXNzZXJ0aW9uIHRoYXQgY29uc3VtZWQgPiBzaXplIGlzIGEgYnVnKS4NCi0gaWYgYnVmZmVyLT5z
aXplIGV2ZXIgZXhjZWVkcyBidWZmZXItPm1heF9jYXBhY2l0eSB0aGVuIGJvdGggc2l6ZSBhbmQg
Y29uc3VtZWQgYXJlIHJlLWNhbGN1bGF0ZWQgc3VjaCB0aGF0IGNvbnN1bWVkIDw9IHNpemUuDQoN
CiAgUGF1bA0KDQo+ICB9DQo+IA0KPiAtLQ0KPiAyLjIwLjENCg0K

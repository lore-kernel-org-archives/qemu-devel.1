Received: from eggs.gnu.org ([2001:4830:134:3::10]:55172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fCED8-0006i4-SA
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 20:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fCED5-0008Vr-NN
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 20:59:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2325 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1fCED5-0008Tl-BB
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 20:59:31 -0400
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Sat, 28 Apr 2018 00:59:12 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AC76790@DGGEMM505-MBS.china.huawei.com>
References: <1519922735-29054-1-git-send-email-mst@redhat.com>
	<1519922735-29054-11-git-send-email-mst@redhat.com>
	<CAFEAcA8=4nyvq4949e171pScH86HbFdKxArHxC-gBcvm6Kytww@mail.gmail.com>
In-Reply-To: <CAFEAcA8=4nyvq4949e171pScH86HbFdKxArHxC-gBcvm6Kytww@mail.gmail.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 10/13] cryptodev: add vhost-user as a new
 cryptodev backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng <longpeng2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

SGkgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIg
TWF5ZGVsbCBbbWFpbHRvOnBldGVyLm1heWRlbGxAbGluYXJvLm9yZ10NCj4gU2VudDogU2F0dXJk
YXksIEFwcmlsIDI4LCAyMDE4IDEyOjE1IEFNDQo+IFRvOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPg0KPiBDYzogUUVNVSBEZXZlbG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5v
cmc+OyBHb25nbGVpIChBcmVpKQ0KPiA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+OyBsb25ncGVu
ZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+OyBaaG91amlhbiAoamF5KQ0KPiA8amlhbmpheS56aG91
QGh1YXdlaS5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BVTEwgMTAvMTNdIGNyeXB0b2RldjogYWRkIHZob3N0LXVzZXIgYXMgYSBuZXcg
Y3J5cHRvZGV2DQo+IGJhY2tlbmQNCj4gDQo+IE9uIDEgTWFyY2ggMjAxOCBhdCAxNjo0NiwgTWlj
aGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4gRnJvbTogR29uZ2xl
aSA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+DQo+ID4NCj4gPiBVc2FnZToNCj4gPiAgLWNoYXJk
ZXYgc29ja2V0LGlkPWNoYXJjcnlwdG8wLHBhdGg9L3BhdGgvdG8veW91ci9zb2NrZXQNCj4gPiAg
LW9iamVjdCBjcnlwdG9kZXYtdmhvc3QtdXNlcixpZD1jcnlwdG9kZXYwLGNoYXJkZXY9Y2hhcmNy
eXB0bzANCj4gPiAgLWRldmljZSB2aXJ0aW8tY3J5cHRvLXBjaSxpZD1jcnlwdG8wLGNyeXB0b2Rl
dj1jcnlwdG9kZXYwDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHb25nbGVpIDxhcmVpLmdvbmds
ZWlAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMb25ncGVuZyhNaWtlKSA8bG9uZ3Bl
bmcyQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmF5IFpob3UgPGppYW5qYXkuemhv
dUBodWF3ZWkuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJl
ZGhhdC5jb20+DQo+IA0KPiBIaTsgQ292ZXJpdHkgKENJRCAxMzkwNjAwKSBwb2ludHMgb3V0IHRo
YXQgdGhlcmUncyBkZWFkIGNvZGUgaW4gdGhpcyBmdW5jdGlvbjoNCj4gDQo+ID4gK3N0YXRpYyB2
b2lkIGNyeXB0b2Rldl92aG9zdF91c2VyX2V2ZW50KHZvaWQgKm9wYXF1ZSwgaW50IGV2ZW50KSB7
DQo+ID4gKyAgICBDcnlwdG9EZXZCYWNrZW5kVmhvc3RVc2VyICpzID0gb3BhcXVlOw0KPiA+ICsg
ICAgQ3J5cHRvRGV2QmFja2VuZCAqYiA9IENSWVBUT0RFVl9CQUNLRU5EKHMpOw0KPiA+ICsgICAg
RXJyb3IgKmVyciA9IE5VTEw7DQo+IA0KPiBXZSBzZXQgZXJyIHRvIE5VTEwgaGVyZS4uLg0KPiAN
Cj4gPiArICAgIGludCBxdWV1ZXMgPSBiLT5jb25mLnBlZXJzLnF1ZXVlczsNCj4gPiArDQo+ID4g
KyAgICBhc3NlcnQocXVldWVzIDwgTUFYX0NSWVBUT19RVUVVRV9OVU0pOw0KPiA+ICsNCj4gPiAr
ICAgIHN3aXRjaCAoZXZlbnQpIHsNCj4gPiArICAgIGNhc2UgQ0hSX0VWRU5UX09QRU5FRDoNCj4g
PiArICAgICAgICBpZiAoY3J5cHRvZGV2X3Zob3N0X3VzZXJfc3RhcnQocXVldWVzLCBzKSA8IDAp
IHsNCj4gPiArICAgICAgICAgICAgZXhpdCgxKTsNCj4gPiArICAgICAgICB9DQo+ID4gKyAgICAg
ICAgYi0+cmVhZHkgPSB0cnVlOw0KPiA+ICsgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgY2FzZSBD
SFJfRVZFTlRfQ0xPU0VEOg0KPiA+ICsgICAgICAgIGItPnJlYWR5ID0gZmFsc2U7DQo+ID4gKyAg
ICAgICAgY3J5cHRvZGV2X3Zob3N0X3VzZXJfc3RvcChxdWV1ZXMsIHMpOw0KPiA+ICsgICAgICAg
IGJyZWFrOw0KPiA+ICsgICAgfQ0KPiANCj4gLi4uYW5kIG5vdGhpbmcgaGVyZSBkb2VzIGFueXRo
aW5nIHdpdGggZXJyLi4uDQo+IA0KPiA+ICsNCj4gPiArICAgIGlmIChlcnIpIHsNCj4gPiArICAg
ICAgICBlcnJvcl9yZXBvcnRfZXJyKGVycik7DQo+ID4gKyAgICB9DQo+IA0KPiAuLi5zbyB0aGlz
IGlmKCkgaXMgYWxsIGRlYWQgY29kZSBhbmQgd2UgY291bGQgcmVtb3ZlIGVyciBlbnRpcmVseS4N
Cg0KVGhhbmtzIGZvciByZXBvcnRpbmcgdGhpcy4gSSdsbCBzZW5kIGEgcGF0Y2ggdG8gZml4IGl0
Lg0KDQpSZWdhcmRzLA0KSmF5DQo=

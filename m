Received: from eggs.gnu.org ([2001:4830:134:3::10]:50273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cpmpY-0003vw-1v
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 22:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cpmpU-0005Fc-Sy
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 22:13:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:21343)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1cpmpU-0005FF-KW
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 22:13:52 -0400
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Mon, 20 Mar 2017 02:12:15 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743901F039@shsmsx102.ccr.corp.intel.com>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-18-git-send-email-peterx@redhat.com>
	<20170316040526.GJ5971@pxdev.xzpeter.org>
	<CAM3WwMiuSG3KGEg7WnN7fhxi-0Yswtsk1Wnh_uVSeuN1HZSLaQ@mail.gmail.com>
	<20170320015654.GI17405@pxdev.xzpeter.org>
In-Reply-To: <20170320015654.GI17405@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 17/17] intel_iommu: enable vfio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Aviv B.D." <bd.aviv@gmail.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

SGkgUGV0ZXIsDQoNCkhvdyBhYm91dCB0aGUgbWVyZ2Ugb2YgdGhpcyBzZXJpZXM/IEknbSBhbHNv
IHRyeWluZyB0byByZWJhc2UgbXkgd29yayBhbmQgcHJlcGFyZSB0byBzZW5kDQpvdXQgUkZDIHBh
dGNoLg0KDQpSZWdhcmRzLA0KWWkgTA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFFlbXUtZGV2ZWwgW21haWx0bzpxZW11LWRldmVsLWJvdW5jZXMreWkubC5saXU9aW50
ZWwuY29tQG5vbmdudS5vcmddIE9uDQo+IEJlaGFsZiBPZiBQZXRlciBYdQ0KPiBTZW50OiBNb25k
YXksIE1hcmNoIDIwLCAyMDE3IDk6NTcgQU0NCj4gVG86IEF2aXYgQi5ELiA8YmQuYXZpdkBnbWFp
bC5jb20+DQo+IENjOiBMYW4sIFRpYW55dSA8dGlhbnl1LmxhbkBpbnRlbC5jb20+OyBUaWFuLCBL
ZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+Ow0KPiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPjsgSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47IEphc29uDQo+
IFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+OyBxZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdu
dS5vcmc+OyBBbGV4DQo+IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPjsg
RGF2aWQgR2lic29uDQo+IDxkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXU+DQo+IFN1YmplY3Q6
IFJlOiBbUWVtdS1kZXZlbF0gW1BBVENIIHY3IDE3LzE3XSBpbnRlbF9pb21tdTogZW5hYmxlIHZm
aW8gZGV2aWNlcw0KPiANCj4gT24gU3VuLCBNYXIgMTksIDIwMTcgYXQgMDU6MzQ6MzFQTSArMDIw
MCwgQXZpdiBCLkQuIHdyb3RlOg0KPiA+IEhpIFBldGVyLA0KPiA+IFRoYW5rcywgSSB0aGluayB0
aGF0IEkgc2hvdWxkIHJlY2VpdmUgY3JlZGl0IGZvciB0aGlzIHBhdGNoLg0KPiA+DQo+ID4gUGxl
YXNlIGF0dHJpYnV0ZSBpdCB1bmRlciBteSB0ZWNobmlvbiBtYWlsOiBiZGF2aXZAY3MudGVjaG5p
b24uYWMuaWwuDQo+ID4NCj4gPiBUaGUgc2lnbmVkLW9mZiBsaW5lIHNob3VsZCBiZToNCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEF2aXYgQmVuLURhdmlkIDxiZGF2aXZAY3MudGVjaG5pb24uYWMu
aWw+DQo+IA0KPiBObyBwcm9ibGVtLiBJJ2xsIHVwZGF0ZSBpbiBuZXh0IHBvc3QuIFRoYW5rcywN
Cj4gDQo+IC0tIHBldGVyeA0KDQo=

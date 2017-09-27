Received: from eggs.gnu.org ([2001:4830:134:3::10]:42894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dx7lJ-0003UZ-7M
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharat.bhushan@nxp.com>) id 1dx7lI-0004dP-6h
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 04:32:09 -0400
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Date: Wed, 27 Sep 2017 08:32:00 +0000
Message-ID: <AM5PR0401MB2545CCAEDA61222A171863F49A780@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1506494000-31982-1-git-send-email-Bharat.Bhushan@nxp.com>
	<AM5PR0401MB25458FFED2D7D405A71F954C9A780@AM5PR0401MB2545.eurprd04.prod.outlook.com>
	<20170927070133.GB25011@pxdev.xzpeter.org>
In-Reply-To: <20170927070133.GB25011@pxdev.xzpeter.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 0/5] virtio-iommu: VFIO integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wei@redhat.com" <wei@redhat.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "tn@semihalf.com" <tn@semihalf.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "drjones@redhat.com" <drjones@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>

SGkgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIg
WHUgW21haWx0bzpwZXRlcnhAcmVkaGF0LmNvbV0NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1i
ZXIgMjcsIDIwMTcgMTI6MzIgUE0NCj4gVG86IEJoYXJhdCBCaHVzaGFuIDxiaGFyYXQuYmh1c2hh
bkBueHAuY29tPg0KPiBDYzogZXJpYy5hdWdlckByZWRoYXQuY29tOyBlcmljLmF1Z2VyLnByb0Bn
bWFpbC5jb207DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgYWxleC53aWxsaWFtc29uQHJl
ZGhhdC5jb207IG1zdEByZWRoYXQuY29tOw0KPiBxZW11LWFybUBub25nbnUub3JnOyBxZW11LWRl
dmVsQG5vbmdudS5vcmc7IHdlaUByZWRoYXQuY29tOw0KPiBrZXZpbi50aWFuQGludGVsLmNvbTsg
bWFyYy56eW5naWVyQGFybS5jb207IHRuQHNlbWloYWxmLmNvbTsNCj4gd2lsbC5kZWFjb25AYXJt
LmNvbTsgZHJqb25lc0ByZWRoYXQuY29tOyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsNCj4gY2hyaXN0
b2ZmZXIuZGFsbEBsaW5hcm8ub3JnOyBiaGFyYXRiLnlhZGF2QGdtYWlsLmNvbQ0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY0IDAvNV0gdmlydGlvLWlvbW11OiBWRklPIGludGVncmF0aW9uDQo+IA0K
PiBPbiBXZWQsIFNlcCAyNywgMjAxNyBhdCAwNjo0NjoxOEFNICswMDAwLCBCaGFyYXQgQmh1c2hh
biB3cm90ZToNCj4gPiBIaSBQZXRlciwNCj4gDQo+IEhpLCBCaGFyYXQhDQo+IA0KPiA+DQo+ID4g
V2hpbGUgdmZpbyB3aXRoIHZpcnRpby1pb21tdSBJIG9ic2VydmVkIG9uZSBpc3N1ZSwgIFdoZW4g
dmlydGlvLWlvbW11DQo+IGRldmljZSBleGlzdHMgYnV0IGd1ZXN0IGtlcm5lbCBkb2VzIG5vdCBo
YXZlIHZpcnRpby1pb21tdSBkcml2ZXIgKG5vdA0KPiBlbmFibGVkIGluIENvbmZpZykgdGhlbiBJ
T01NVSBmYXVsdHMgYXJlIHJlcG9ydGVkIG9uIGhvc3QuDQo+ID4NCj4gPiBUaGlzIGlzIGJlY2F1
c2Ugbm8gbWFwcGluZyBpcyBjcmVhdGVkIGluIElPTU1VLCBub3QgZXZlbiBkZWZhdWx0DQo+IGd1
ZXN0LXBoeXNpY2FsIHRvIHJlYWwtcGh5c2ljYWwuIFdoaWxlIGxvb2tpbmcgYXQgdmZpb19saXN0
ZW5lcl9yZWdpb25fYWRkKCksIGl0DQo+IGRvZXMgbm90IGNyZWF0ZSBpbml0aWFsIG1hcHBpbmcg
aW4gSU9NTVUgYW5kIHJlbGllcyBvbiBndWVzdCB0byBjcmVhdGUNCj4gbWFwcGluZy4gSXMgdGhp
cyBzb21ldGhpbmcga25vd24gb3IgSSBhbSBtaXNzaW5nIHNvbWV0aGluZz8NCj4gDQo+IEZvciBW
VC1kLCB0aGUgdHJpY2sgaXMgcGxheWVkIHVzaW5nIGR5bmFtaWMgSU9NTVUgbWVtb3J5IHJlZ2lv
bi4NCj4gUGxlYXNlIHJlZmVyIHRvIGNvbW1pdCA1NThlMDAyNGE0MjggKCJpbnRlbF9pb21tdTog
YWxsb3cgZHluYW1pYyBzd2l0Y2ggb2YNCj4gSU9NTVUgcmVnaW9uIikgZm9yIG1vcmUgaW5mb3Jt
YXRpb24uDQo+IA0KPiBUaGUgd2hvbGUgaWRlYSBpcyB0aGF0LCB0aGUgSU9NTVUgcmVnaW9uIHdp
bGwgbm90IGJlIGVuYWJsZWQgb25seSBpZiB0aGUNCj4gZ3Vlc3QgZW5hYmxlcyB0aGF0IGV4cGxp
Y2l0bHkgZm9yIHRoZSBkZXZpY2UuICBPdGhlcndpc2UgKGZvciB5b3VyIGNhc2UsIHdoZW4NCj4g
Z3Vlc3QgZHJpdmVyIGlzIG5vdCBsb2FkZWQgYXQgYWxsKSwgdGhlIElPTU1VIHJlZ2lvbiBpcyBi
eSBkZWZhdWx0IG9mZiwgdGhlbg0KPiB0aGUgZGVmYXVsdCBHUEEgcmVnaW9uIHdpbGwgYmUgdXNl
ZCB0byBidWlsZCB1cCB0aGUgbWFwcGluZyAoanVzdCBsaWtlIHdoZW4NCj4gd2UgZG9uJ3QgaGF2
ZSB2SU9NTVUgYXQgYWxsKS4gIFRoYW5rcywNCg0KVGhhbmtzLCBJIHdpbGwgYW5hbHl6ZSBhbmQg
c2VlIGhvdyB3ZSBjYW4gdXNlIGZvciB2aXJ0aW8taW9tbXUuDQoNClJlZ2FyZHMNCi1CaGFyYXQN
Cg0KPiANCj4gLS0NCj4gUGV0ZXIgWHUNCg==

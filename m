Received: from eggs.gnu.org ([2001:4830:134:3::10]:46709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cunming.liang@intel.com>) id 1gKnU5-0007mW-Hr
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:48:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cunming.liang@intel.com>) id 1gKnU1-000838-Mx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:48:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:41305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cunming.liang@intel.com>)
	id 1gKnTz-00080x-N4
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:48:41 -0500
From: "Liang, Cunming" <cunming.liang@intel.com>
Date: Thu, 8 Nov 2018 16:48:32 +0000
Message-ID: <D0158A423229094DA7ABF71CF2FA0DA34EBCB34F@SHSMSX104.ccr.corp.intel.com>
References: <20181016132327.121839-1-xiao.w.wang@intel.com>
	<2e010e02-f7a2-d009-ac7a-fdc266f99254@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34EBC9415@SHSMSX104.ccr.corp.intel.com>
	<e516b798-ecf3-030c-621b-468250bcc7d3@redhat.com>
	<D0158A423229094DA7ABF71CF2FA0DA34EBC98A4@SHSMSX104.ccr.corp.intel.com>
	<925d4df0-13e3-39ea-5d91-991144a29ffe@redhat.com>
In-Reply-To: <925d4df0-13e3-39ea-5d91-991144a29ffe@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC 0/2] vhost-vfio: introduce mdev based HW
 vhost backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "mst@redhat.com" <mst@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Bie, Tiwei" <tiwei.bie@intel.com>, "Ye, Xiaolong" <xiaolong.ye@intel.com>, "Wang,
	Zhihong" <zhihong.wang@intel.com>, "Daly, Dan" <dan.daly@intel.com>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyBbbWFp
bHRvOmphc293YW5nQHJlZGhhdC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA4LCAy
MDE4IDI6MTYgQU0NCj4gVG86IExpYW5nLCBDdW5taW5nIDxjdW5taW5nLmxpYW5nQGludGVsLmNv
bT47IFdhbmcsIFhpYW8gVw0KPiA8eGlhby53LndhbmdAaW50ZWwuY29tPjsgbXN0QHJlZGhhdC5j
b207IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tDQo+IENjOiBxZW11LWRldmVsQG5vbmdudS5v
cmc7IEJpZSwgVGl3ZWkgPHRpd2VpLmJpZUBpbnRlbC5jb20+OyBZZSwgWGlhb2xvbmcNCj4gPHhp
YW9sb25nLnllQGludGVsLmNvbT47IFdhbmcsIFpoaWhvbmcgPHpoaWhvbmcud2FuZ0BpbnRlbC5j
b20+OyBEYWx5LCBEYW4NCj4gPGRhbi5kYWx5QGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtS
RkMgMC8yXSB2aG9zdC12ZmlvOiBpbnRyb2R1Y2UgbWRldiBiYXNlZCBIVyB2aG9zdCBiYWNrZW5k
DQo+IA0KPiANCj4gT24gMjAxOC8xMS83IOS4i+WNiDExOjA4LCBMaWFuZywgQ3VubWluZyB3cm90
ZToNCj4gPj4+PiBiZWxpZXZlLg0KPiA+Pj4gW0xDXSBBZ3JlZWQsIHNvIGl0IHJldXNlcyBDTUQg
ZGVmaW5lZCBieSB2aG9zdC1rZXJuZWwgaW9jdGwuIEJ1dA0KPiA+Pj4gVkZJTyBwcm92aWRlcw0K
PiA+PiBkZXZpY2Ugc3BlY2lmaWMgdGhpbmdzIChlLmcuIERNQVIsIElOVFIgYW5kIGV0Yy4pIHdo
aWNoIGlzIHRoZSBleHRyYQ0KPiA+PiBBUElzIGJlaW5nIGludHJvZHVjZWQgYnkgdGhpcyB0cmFu
c3BvcnQuDQo+ID4+DQo+ID4+DQo+ID4+IEknbSBub3QgcXVpdGUgc3VyZSBJIHVuZGVyc3RhbmQg
aGVyZS4gSSB0aGluayBoYXZpbmcgdmhvc3Qta2VybmVsDQo+ID4+IGNvbXBhdGlibGUgaW9jdGwg
ZG9lcyBub3QgY29uZmxpY3Qgb2YgdXNpbmcgVkZJTyBpb2N0bCBsaWtlIERNQSBvciBJTlRSPw0K
PiA+Pg0KPiA+PiBCdHcsIFZGSU8gRE1BIGlvY3RsIGlzIGV2ZW4gbm90IGEgbXVzdCBmcm9tIG15
IHBvaW50IG9mIHZpZXcsDQo+ID4+IHZob3N0LW1kZXYgY2FuIGZvcndhcmQgdGhlIG1lbSB0YWJs
ZSBpbmZvcm1hdGlvbiB0byBkZXZpY2UgZHJpdmVyIGFuZA0KPiA+PiBsZXQgaXQgY2FsbCBETUEg
QVBJIHRvIG1hcC91bWFwIHBhZ2VzLg0KPiA+IFtMQ10gSWYgbm90IHJlZ2FyZGluZyB2aG9zdC1t
ZGV2IGFzIGEgZGV2aWNlLCB0aGVuIGZvcndhcmQgbWVtIHRhYmxlIHdvbid0IGJlIGENCj4gY29u
Y2Vybi4NCj4gPiBJZiBpbnRyb2R1Y2luZyBhIG5ldyBtZGV2IGJ1cyBkcml2ZXIgKHZob3N0LW1k
ZXYpIHdoaWNoIGFsbG93cyBtZGV2IGluc3RhbmNlIHRvDQo+IGJlIGEgbmV3IHR5cGUgb2YgcHJv
dmlkZXIgZm9yIHZob3N0LWtlcm5lbC4gSXQgYmVjb21lcyBhIHByZXR0eSBnb29kIGFsdGVybmF0
aXZlIHRvDQo+IGZ1bGx5IGxldmVyYWdlIHZob3N0LWtlcm5lbCBpb2N0bC4NCj4gPiBJJ20gbm90
IHN1cmUgaXQncyB0aGUgc2FtZSB2aWV3IGFzIHlvdXJzIHdoZW4geW91IHNheXMgcmV1c2luZyB2
aG9zdC1rZXJuZWwgaW9jdGwuDQo+ID4NCj4gDQo+IFllcyBpdCBpcy4NCltMQ10gSXQgc291bmRz
IGEgcHJldHR5IGdvb2QgaWRlYSB0byBtZS4gTGV0IHVzIHNwZW5kIHNvbWUgdGltZSB0byBmaWd1
cmUgb3V0IHRoZSBuZXh0IGxldmVsIGRldGFpbCwgYW5kIHN5bmMtdXAgZnVydGhlciBwbGFuIGlu
IGNvbW11bml0eSBjYWxsLiA6KQ0KDQo+IA0KPiBUaGFua3MNCg0K

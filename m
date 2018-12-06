Received: from eggs.gnu.org ([2001:4830:134:3::10]:52436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@outlook.com>) id 1gUpes-0004JR-3m
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@outlook.com>) id 1gUpYd-0007iA-Dm
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:02:59 -0500
Received: from mail-oln040092006039.outbound.protection.outlook.com
	([40.92.6.39]:39721
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liq3ea@outlook.com>) id 1gUpYd-0007hK-0i
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:02:55 -0500
From: li qiang <liq3ea@outlook.com>
Date: Thu, 6 Dec 2018 09:02:50 +0000
Message-ID: <BN6PR18MB1220A0A33454573CA39058659FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
References: <20181206084816.30485-1-ppandit@redhat.com>
In-Reply-To: <20181206084816.30485-1-ppandit@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-ID: <540CCC2EB8EBFE45B87D8AEEC73A75CF@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Hanselmann <public@hansmi.ch>, Prasad J Pandit <pjp@fedoraproject.org>, "Michael S .
	Tsirkin" <mst@redhat.com>

DQrU2iAyMDE4LzEyLzYgMTY6NDgsIFAgSiBQINC0tcA6DQo+IEZyb206IFByYXNhZCBKIFBhbmRp
dCA8cGpwQGZlZG9yYXByb2plY3Qub3JnPg0KPg0KPiBXaGlsZSBwZXJmb3JtaW5nIGJsb2NrIHRy
YW5zZmVyIHdyaXRlIGluIHNtYl9pb3BvcnRfd3JpdGViKCksDQo+ICdzbWJfaW5kZXgnIGlzIGlu
Y3JlbWVudGVkIGFuZCB1c2VkIHRvIGluZGV4IHNtYl9kYXRhW10gYXJyYXkuDQo+IENoZWNrICdz
bWJfaW5kZXgnIHZhbHVlIHRvIGF2b2lkIE9PQiBhY2Nlc3MuDQo+DQo+IFJlcG9ydGVkLWJ5OiBN
aWNoYWVsIEhhbnNlbG1hbm4gPHB1YmxpY0BoYW5zbWkuY2g+DQo+IFNpZ25lZC1vZmYtYnk6IFBy
YXNhZCBKIFBhbmRpdCA8cGpwQGZlZG9yYXByb2plY3Qub3JnPg0KPiAtLS0NCj4gICBody9pMmMv
cG1fc21idXMuYyB8IDMgKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0K
Pg0KPiBkaWZmIC0tZ2l0IGEvaHcvaTJjL3BtX3NtYnVzLmMgYi9ody9pMmMvcG1fc21idXMuYw0K
PiBpbmRleCA2ODVhMjM3OGVkLi4wMzA2Mjc0MGNjIDEwMDY0NA0KPiAtLS0gYS9ody9pMmMvcG1f
c21idXMuYw0KPiArKysgYi9ody9pMmMvcG1fc21idXMuYw0KPiBAQCAtMjQwLDYgKzI0MCw5IEBA
IHN0YXRpYyB2b2lkIHNtYl9pb3BvcnRfd3JpdGViKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFkZHIs
IHVpbnQ2NF90IHZhbCwNCj4gICAgICAgICAgICAgICB1aW50OF90IHJlYWQgPSBzLT5zbWJfYWRk
ciAmIDB4MDE7DQo+ICAgDQo+ICAgICAgICAgICAgICAgcy0+c21iX2luZGV4Kys7DQo+ICsgICAg
ICAgICAgICBpZiAocy0+c21iX2luZGV4ID49IFBNX1NNQlVTX01BWF9NU0dfU0laRSkgew0KPiAr
ICAgICAgICAgICAgICAgIHMtPnNtYl9pbmRleCA9IDA7DQo+ICsgICAgICAgICAgICB9DQo+ICAg
ICAgICAgICAgICAgaWYgKCFyZWFkICYmIHMtPnNtYl9pbmRleCA9PSBzLT5zbWJfZGF0YTApIHsN
Cj4gICAgICAgICAgICAgICAgICAgdWludDhfdCBwcm90ID0gKHMtPnNtYl9jdGwgPj4gMikgJiAw
eDA3Ow0KPiAgICAgICAgICAgICAgICAgICB1aW50OF90IGNtZCA9IHMtPnNtYl9jbWQ7DQoNCk9o
Li4uIEZpbmFsbHkgYW5vdGhlciBvbmUgZmluZCB0aGlzLi4uLi4NCg0KSSd2ZSBhbHJlYWR5IGZv
dW5kIHRoaXMuIFRoaXMgaXMgdmVyeSBhIHNlcmlvdXMgc2VjdXJpdHkgaXNzdWUuDQoNCkkgaGF2
ZSB3cm90ZSBhIGZ1bGwgZXhwbG9pdCB0byBtYWtlIGEgVk0gZXNjYXBlIHVzaW5nIHRoaXMgdnVs
bmVyYWJpbGl0eS4NCg0KVGhpcyBndWVzdCBjYW4gcmVhZC93cml0ZSBhIDRHIG1lbW9yeSBvZiBx
ZW11IHByb2Nlc3MgYnkgZGVmYXVsdCANCmNvbmZpZ3VyYXRpb24uDQoNCkFzIGZhciBhcyBJIGtu
b3csIHRoaXMgdnVsbmVyYWJpbGl0eSBtYXkgYmUgdGhlIG1vc3Qgc2VyaW91cyANCnZ1bG5lcmFi
aWxpdHkgb2YgdGhlIHFlbXUgaGlzdG9yeS4NCg0KUGxlYXNlIHBheSBhIGxvdCBvZiBhdHRlbnRp
b24gZm9yIHRoaXMgaXNzdWUuDQoNCkxhdGVyIEkgd2lsbCByZWxlYXNlIHRoZSBmdWxsIHBhcGVy
IGFuZCBleHBsb2l0LiBJdCdzIG5vdCBoYXJtIGFzIHRoaXMgDQppcyBpbnRyb2R1Y2VkIGluIDMu
MQ0KDQphbmQgbm8gb25lIHVzZSBpdCBub3cuDQoNCg0KVGhhbmtzLA0KDQpMaSBRaWFuZw0KDQoN
Cg0KDQo=

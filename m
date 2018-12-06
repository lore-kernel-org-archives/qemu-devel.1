Received: from eggs.gnu.org ([2001:4830:134:3::10]:47478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@outlook.com>) id 1gUqgJ-0006qy-OW
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@outlook.com>) id 1gUqgG-0002X7-7v
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:14:55 -0500
Received: from mail-oln040092004075.outbound.protection.outlook.com
	([40.92.4.75]:29856
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liq3ea@outlook.com>) id 1gUqgF-0002Rd-Nk
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 05:14:52 -0500
From: li qiang <liq3ea@outlook.com>
Date: Thu, 6 Dec 2018 10:14:41 +0000
Message-ID: <BN6PR18MB122003892BAC2B0EA609432C9FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
References: <20181206084816.30485-1-ppandit@redhat.com>
	<BN6PR18MB1220A0A33454573CA39058659FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
In-Reply-To: <BN6PR18MB1220A0A33454573CA39058659FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-ID: <2AB66C47798C3F44B80AD527C567EFDE@namprd18.prod.outlook.com>
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

RllJOg0KDQpodHRwOi8vdGVyZW5jZWxpLmdpdGh1Yi5pby8lRTYlOEElODAlRTYlOUMlQUYvMjAx
OC8xMi8wNi9xZW11LWVzY2FwZQ0KDQoNCtTaIDIwMTgvMTIvNiAxNzowMiwgbGkgcWlhbmcg0LS1
wDoNCj4g1NogMjAxOC8xMi82IDE2OjQ4LCBQIEogUCDQtLXAOg0KPj4gRnJvbTogUHJhc2FkIEog
UGFuZGl0IDxwanBAZmVkb3JhcHJvamVjdC5vcmc+DQo+Pg0KPj4gV2hpbGUgcGVyZm9ybWluZyBi
bG9jayB0cmFuc2ZlciB3cml0ZSBpbiBzbWJfaW9wb3J0X3dyaXRlYigpLA0KPj4gJ3NtYl9pbmRl
eCcgaXMgaW5jcmVtZW50ZWQgYW5kIHVzZWQgdG8gaW5kZXggc21iX2RhdGFbXSBhcnJheS4NCj4+
IENoZWNrICdzbWJfaW5kZXgnIHZhbHVlIHRvIGF2b2lkIE9PQiBhY2Nlc3MuDQo+Pg0KPj4gUmVw
b3J0ZWQtYnk6IE1pY2hhZWwgSGFuc2VsbWFubiA8cHVibGljQGhhbnNtaS5jaD4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFByYXNhZCBKIFBhbmRpdCA8cGpwQGZlZG9yYXByb2plY3Qub3JnPg0KPj4gLS0t
DQo+PiAgICBody9pMmMvcG1fc21idXMuYyB8IDMgKysrDQo+PiAgICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kyYy9wbV9zbWJ1cy5jIGIv
aHcvaTJjL3BtX3NtYnVzLmMNCj4+IGluZGV4IDY4NWEyMzc4ZWQuLjAzMDYyNzQwY2MgMTAwNjQ0
DQo+PiAtLS0gYS9ody9pMmMvcG1fc21idXMuYw0KPj4gKysrIGIvaHcvaTJjL3BtX3NtYnVzLmMN
Cj4+IEBAIC0yNDAsNiArMjQwLDkgQEAgc3RhdGljIHZvaWQgc21iX2lvcG9ydF93cml0ZWIodm9p
ZCAqb3BhcXVlLCBod2FkZHIgYWRkciwgdWludDY0X3QgdmFsLA0KPj4gICAgICAgICAgICAgICAg
dWludDhfdCByZWFkID0gcy0+c21iX2FkZHIgJiAweDAxOw0KPj4gICAgDQo+PiAgICAgICAgICAg
ICAgICBzLT5zbWJfaW5kZXgrKzsNCj4+ICsgICAgICAgICAgICBpZiAocy0+c21iX2luZGV4ID49
IFBNX1NNQlVTX01BWF9NU0dfU0laRSkgew0KPj4gKyAgICAgICAgICAgICAgICBzLT5zbWJfaW5k
ZXggPSAwOw0KPj4gKyAgICAgICAgICAgIH0NCj4+ICAgICAgICAgICAgICAgIGlmICghcmVhZCAm
JiBzLT5zbWJfaW5kZXggPT0gcy0+c21iX2RhdGEwKSB7DQo+PiAgICAgICAgICAgICAgICAgICAg
dWludDhfdCBwcm90ID0gKHMtPnNtYl9jdGwgPj4gMikgJiAweDA3Ow0KPj4gICAgICAgICAgICAg
ICAgICAgIHVpbnQ4X3QgY21kID0gcy0+c21iX2NtZDsNCj4gT2guLi4gRmluYWxseSBhbm90aGVy
IG9uZSBmaW5kIHRoaXMuLi4uLg0KPg0KPiBJJ3ZlIGFscmVhZHkgZm91bmQgdGhpcy4gVGhpcyBp
cyB2ZXJ5IGEgc2VyaW91cyBzZWN1cml0eSBpc3N1ZS4NCj4NCj4gSSBoYXZlIHdyb3RlIGEgZnVs
bCBleHBsb2l0IHRvIG1ha2UgYSBWTSBlc2NhcGUgdXNpbmcgdGhpcyB2dWxuZXJhYmlsaXR5Lg0K
Pg0KPiBUaGlzIGd1ZXN0IGNhbiByZWFkL3dyaXRlIGEgNEcgbWVtb3J5IG9mIHFlbXUgcHJvY2Vz
cyBieSBkZWZhdWx0DQo+IGNvbmZpZ3VyYXRpb24uDQo+DQo+IEFzIGZhciBhcyBJIGtub3csIHRo
aXMgdnVsbmVyYWJpbGl0eSBtYXkgYmUgdGhlIG1vc3Qgc2VyaW91cw0KPiB2dWxuZXJhYmlsaXR5
IG9mIHRoZSBxZW11IGhpc3RvcnkuDQo+DQo+IFBsZWFzZSBwYXkgYSBsb3Qgb2YgYXR0ZW50aW9u
IGZvciB0aGlzIGlzc3VlLg0KPg0KPiBMYXRlciBJIHdpbGwgcmVsZWFzZSB0aGUgZnVsbCBwYXBl
ciBhbmQgZXhwbG9pdC4gSXQncyBub3QgaGFybSBhcyB0aGlzDQo+IGlzIGludHJvZHVjZWQgaW4g
My4xDQo+DQo+IGFuZCBubyBvbmUgdXNlIGl0IG5vdy4NCj4NCj4NCj4gVGhhbmtzLA0KPg0KPiBM
aSBRaWFuZw0KPg0KPg0KPg0KPg0K

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@outlook.com>) id 1gUruW-0004yQ-1R
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@outlook.com>) id 1gUruS-0008KB-0m
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:33:39 -0500
Received: from mail-oln040092006013.outbound.protection.outlook.com
	([40.92.6.13]:53364
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liq3ea@outlook.com>) id 1gUruR-0008JL-QK
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:33:35 -0500
From: li qiang <liq3ea@outlook.com>
Date: Thu, 6 Dec 2018 11:33:33 +0000
Message-ID: <BN6PR18MB1220BBD5A4D0B95AFF0BAAD59FA90@BN6PR18MB1220.namprd18.prod.outlook.com>
References: <20181206084816.30485-1-ppandit@redhat.com>
In-Reply-To: <20181206084816.30485-1-ppandit@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="gb2312"
Content-ID: <B13039ED30CD9743964FFDD0C19CD5B4@namprd18.prod.outlook.com>
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
YXNhZCBKIFBhbmRpdCA8cGpwQGZlZG9yYXByb2plY3Qub3JnPg0KDQpSZXZpZXdlZC1ieTogTGkg
UWlhbmcgPGxpcTNlYUBnbWFpbC5jb20+DQoNCj4gLS0tDQo+ICAgaHcvaTJjL3BtX3NtYnVzLmMg
fCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAt
LWdpdCBhL2h3L2kyYy9wbV9zbWJ1cy5jIGIvaHcvaTJjL3BtX3NtYnVzLmMNCj4gaW5kZXggNjg1
YTIzNzhlZC4uMDMwNjI3NDBjYyAxMDA2NDQNCj4gLS0tIGEvaHcvaTJjL3BtX3NtYnVzLmMNCj4g
KysrIGIvaHcvaTJjL3BtX3NtYnVzLmMNCj4gQEAgLTI0MCw2ICsyNDAsOSBAQCBzdGF0aWMgdm9p
ZCBzbWJfaW9wb3J0X3dyaXRlYih2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1aW50NjRfdCB2
YWwsDQo+ICAgICAgICAgICAgICAgdWludDhfdCByZWFkID0gcy0+c21iX2FkZHIgJiAweDAxOw0K
PiAgIA0KPiAgICAgICAgICAgICAgIHMtPnNtYl9pbmRleCsrOw0KPiArICAgICAgICAgICAgaWYg
KHMtPnNtYl9pbmRleCA+PSBQTV9TTUJVU19NQVhfTVNHX1NJWkUpIHsNCj4gKyAgICAgICAgICAg
ICAgICBzLT5zbWJfaW5kZXggPSAwOw0KPiArICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAg
IGlmICghcmVhZCAmJiBzLT5zbWJfaW5kZXggPT0gcy0+c21iX2RhdGEwKSB7DQo+ICAgICAgICAg
ICAgICAgICAgIHVpbnQ4X3QgcHJvdCA9IChzLT5zbWJfY3RsID4+IDIpICYgMHgwNzsNCj4gICAg
ICAgICAgICAgICAgICAgdWludDhfdCBjbWQgPSBzLT5zbWJfY21kOw0K

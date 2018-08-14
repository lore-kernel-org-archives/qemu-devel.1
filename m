Received: from eggs.gnu.org ([2001:4830:134:3::10]:49497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fpYzS-00014K-PV
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1fpYzO-00074T-Ec
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:04:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2404 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1fpYzN-00072b-TX
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:03:58 -0400
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Tue, 14 Aug 2018 13:03:43 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473B7345BB@DGGEMM528-MBX.china.huawei.com>
References: <1534243693-9560-1-git-send-email-jianjay.zhou@huawei.com>
	<2278afdb-d2a6-54b3-67c7-c1f43e4d311c@redhat.com>
	<20180814115202.GH2580@work-vm>
	<517f613f-3885-7b6f-aff7-cffee9d8f35f@redhat.com>
In-Reply-To: <517f613f-3885-7b6f-aff7-cffee9d8f35f@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH] vl: fix migration when watchdog expires
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com" <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBCb256aW5pIFttYWls
dG86cGJvbnppbmlAcmVkaGF0LmNvbV0NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDE0LCAyMDE4
IDg6MDIgUE0NCj4gVG86IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgPGRnaWxiZXJ0QHJlZGhhdC5j
b20+DQo+IENjOiBaaG91amlhbiAoamF5KSA8amlhbmpheS56aG91QGh1YXdlaS5jb20+OyBxZW11
LWRldmVsQG5vbmdudS5vcmc7DQo+IHF1aW50ZWxhQHJlZGhhdC5jb207IHdhbmd4aW4gKFUpIDx3
YW5neGlueGluLndhbmdAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0hdIHZs
OiBmaXggbWlncmF0aW9uIHdoZW4gd2F0Y2hkb2cgZXhwaXJlcw0KPiANCj4gT24gMTQvMDgvMjAx
OCAxMzo1MiwgRHIuIERhdmlkIEFsYW4gR2lsYmVydCB3cm90ZToNCj4gPiAgYSkgU2hvdWxkIHRo
ZSB3YXRjaGRvZyBleHBpcmUgd2hlbiB0aGUgVk0gaXMgc3RvcHBlZDsgSSB0aGluayBpdA0KPiA+
IHNob3VsZG4ndCAtIGh3L2FjcGkvdGNvLmMgdXNlcyBhIHZpcnR1YWwgdGltZXIgYXMgZG9lcyBp
NjMwMGVzYjsgc28gaXMNCj4gPiB0aGUgYnVnIGhlcmUgdGhhdCB0aGUgd2F0Y2hkb2cgYmVpbmcg
dXNlZCBkaWRuJ3QgdXNlIGEgdmlydHVhbCB0aW1lcj8NCj4gDQo+IEFsbCB3YXRjaGRvZ3MgZG8u
DQo+IA0KPiA+ICBiKSBJZiB0aGUgd2F0Y2hkb2cgZXhwaXJlcyBqdXN0IGJlZm9yZSB0aGUgVk0g
Z2V0cyBzdG9wcGVkLCBpcyB0aGVyZQ0KPiA+IGEgcmFjZSB3aGljaCBjb3VsZCBoaXQgdGhpcz8g
IFBvc3NpYmx5Lg0KPiANCj4gWWVzLCBJIHRoaW5rIGl0IGlzIGEgcmFjZSB0aGF0IGhhcHBlbnMg
anVzdCBiZWZvcmUgdm1fc3RvcCwgYnV0IEkgZG9uJ3QNCj4gdW5kZXJzdGFuZCB3aHkgdGhlICJx
ZW11X2Nsb2NrX2VuYWJsZSIgaW4gcGF1c2VfYWxsX3ZjcHVzIGRvZXMgbm90IHByZXZlbnQgaXQu
DQoNCkhpIFBhb2xvLA0KVGhlIHNlcXVlbmNlIGlzIGxpa2UgdGhpcyBJIHRoaW5rDQoNCiAgICAg
ICAgIHwNCiAgICAgICAgIHwgIDwtLS0tLSAgd2F0Y2hkb2cgZXhwaXJlZCwgd2hpY2ggc2V0IHJl
c2V0X3JlcXVlc3RlZCB0byBTSFVURE9XTl9DQVVTRV9HVUVTVF9SRVNFVA0KICAgICAgICAgfCAN
CiAgICAgICAgIHwgIDwtLS0tLSAgbWlncmF0aW9uIHRocmVhZCBzZXRzIHRvIFJVTl9TVEFURV9G
SU5JU0hfTUlHUkFURSwgaXQgd2lsbCBkaXNhYmxlIFFFTVVfQ0xPQ0tfVklSVFVBTCBjbG9jaywN
CiAgICAgICAgIHwgICAgICAgICAgYnV0IGl0IGlzIGRvbmUgYWZ0ZXIgdGhlIHNldHRpbmcgb2Yg
cmVzZXRfcmVxdWVzdGVkDQogICAgICAgICB8DQogICAgICAgICB8ICA8LS0tLS0gIG1haW4gbG9v
cCB0aHJlYWQgc2V0cyB0byBSVU5fU1RBVEVfUFJFTEFVTkNIIHNpbmNlIGl0IGRldGVjdGVkIGEg
cmVzZXQgcmVxdWVzdA0KICAgICAgICAgfA0KICAgICAgICAgfCAgPC0tLS0tICBtaWdyYXRpb24g
dGhyZWFkIHNldHMgdG8gUlVOX1NUQVRFX1BPU1RNSUdSQVRFDQoNCg0KUmVnYXJkcywNCkpheSBa
aG91DQoNCj4gDQo+IEl0IHNob3VsZCBiZSBwb3NzaWJsZSB0byB3cml0ZSBhIGRldGVybWluaXN0
aWMgdGVzdGNhc2Ugd2l0aCBxdGVzdC4uLg0KPiANCj4gUGFvbG8NCg==

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cH9GK-0000iW-Gp
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:06:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cH9GH-0004az-EN
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:06:24 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:59146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <hangaohuai@huawei.com>) id 1cH9GD-0004SP-Gp
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:06:21 -0500
From: Hangaohuai <hangaohuai@huawei.com>
Date: Wed, 14 Dec 2016 13:04:37 +0000
Message-ID: <643686C90A8F6046B2C3783E2A7A06AD3D20FD94@SZXEMA504-MBX.china.huawei.com>
References: <20161214064820.12480-1-hangaohuai@huawei.com>
	<4bfd3066-6c2b-c21f-b6ea-9cc156fa4389@redhat.com>
In-Reply-To: <4bfd3066-6c2b-c21f-b6ea-9cc156fa4389@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] bugfix: vm halt when in reset looping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

VGhhbmtzIGZvciB0aGUgcmV2aWV3IGFuZCBwcm9wb3NhbHMgLiANCkkgd2lsbCB0aGluayBvdmVy
IHRoZSBzdXNwZW5kIGFuZCByZXN1bWUgb2YgVk0uIA0KDQoNCk9uIDE0LzEyLzIwMTYgMDc6NDgs
IGhhbmdhb2h1YWkgd3JvdGU6DQo+IHJlc2V0IG1jMTQ2ODE4cnRjIGRldmljZSB3aGVuIFJFU0VU
IGV2ZW50IGhhcHBlbnMuDQo+IA0KPiBGaXggdGhlIHByb2JsZW06DQo+ICAgMS4gR3Vlc3QgYm9v
dCB0aGUgc2Vjb25kIGNwdSwgc2V0IENNT1NfUkVTRVRfQ09ERSAweDBhIHRvIHByb3RlY3Qgc2Vs
ZmJvb3Q7DQo+ICAgMi4gVk0gYmVpbmcgcmVzZXQgYnkgb3RoZXJzLCBobXBfc3lzdGVtX3Jlc2V0
Ow0KPiAgIDMuIHNlYWJpb3MgcmVzdW1lIGNoZWNrIHRoZSBDTU9TX1JFU0VUX0NPREUsIGlmIDB4
MGEsIGp1bXAgdG8gdGhlIEJEQQ0KPiAgICAgIHJlc3VtZSBleGVjdXRpb24gYnkganVtcCB2aWEg
NDBoOjAwNjdoOw0KPiAgIDQuIEd1ZXN0IGhhbHQ7DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBoYW5n
YW9odWFpIDxoYW5nYW9odWFpQGh1YXdlaS5jb20+DQoNCkkgdGhpbmsgdGhpcyB3b3VsZCBicmVh
ayBTMyByZXN1bWUuDQoNClBhb2xvDQoNCj4gLS0tDQo+ICBody90aW1lci9tYzE0NjgxOHJ0Yy5j
IHwgOCArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2h3L3RpbWVyL21jMTQ2ODE4cnRjLmMgYi9ody90aW1lci9tYzE0NjgxOHJ0
Yy5jIGluZGV4IA0KPiBkYTIwOWQwLi42N2Q3MDdkIDEwMDY0NA0KPiAtLS0gYS9ody90aW1lci9t
YzE0NjgxOHJ0Yy5jDQo+ICsrKyBiL2h3L3RpbWVyL21jMTQ2ODE4cnRjLmMNCj4gQEAgLTk0Niwx
MSArOTQ2LDE5IEBAIHN0YXRpYyBQcm9wZXJ0eSBtYzE0NjgxOHJ0Y19wcm9wZXJ0aWVzW10gPSB7
DQo+ICAgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwNCj4gIH07DQo+ICANCj4gK3N0YXRp
YyB2b2lkIHJ0Y19yZXNldGRldihEZXZpY2VTdGF0ZSAqZCkgew0KPiArICAgIFJUQ1N0YXRlICpz
ID0gTUMxNDY4MThfUlRDKGQpOw0KPiArDQo+ICsgICAgcy0+Y21vc19kYXRhWzB4MGZdID0gMHgw
MDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgcnRjX2NsYXNzX2luaXRmbihPYmplY3RDbGFz
cyAqa2xhc3MsIHZvaWQgKmRhdGEpICB7DQo+ICAgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNF
X0NMQVNTKGtsYXNzKTsNCj4gIA0KPiAgICAgIGRjLT5yZWFsaXplID0gcnRjX3JlYWxpemVmbjsN
Cj4gKyAgICBkYy0+cmVzZXQgPSBydGNfcmVzZXRkZXY7DQo+ICAgICAgZGMtPnZtc2QgPSAmdm1z
dGF0ZV9ydGM7DQo+ICAgICAgZGMtPnByb3BzID0gbWMxNDY4MThydGNfcHJvcGVydGllczsNCj4g
ICAgICAvKiBSZWFzb246IG5lZWRzIHRvIGJlIHdpcmVkIHVwIGJ5IHJ0Y19pbml0KCkgKi8NCj4g
DQo=

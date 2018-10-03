Received: from eggs.gnu.org ([2001:4830:134:3::10]:38460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7iDG-0001zL-2b
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7iD6-0006cu-Fn
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:33:18 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 3 Oct 2018 14:32:44 +0000
Message-ID: <79b55f31-00a9-273f-e004-6c097a2f1542@virtuozzo.com>
References: <20181002233314.30159-1-jsnow@redhat.com>
In-Reply-To: <20181002233314.30159-1-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <D471780547E7574E83389A419E39B51B@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] bitmap: Update count after a merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>

MDMuMTAuMjAxOCAwMjozMywgSm9obiBTbm93IHdyb3RlOg0KPiBGcm9tOiBFcmljIEJsYWtlIDxl
Ymxha2VAcmVkaGF0LmNvbT4NCj4NCj4gV2UgbmVlZCBhbiBhY2N1cmF0ZSBjb3VudCBvZiB0aGUg
bnVtYmVyIG9mIGJpdHMgc2V0IGluIGEgYml0bWFwDQo+IGFmdGVyIGEgbWVyZ2UuIEluIHBhcnRp
Y3VsYXIsIHNpbmNlIHRoZSBtZXJnZSBvcGVyYXRpb24gc2hvcnQtY2lyY3VpdHMNCj4gYSBtZXJn
ZSBmcm9tIGFuIGVtcHR5IHNvdXJjZSwgaWYgeW91IGhhdmUgYml0bWFwcyBBLCBCLCBhbmQgQyB3
aGVyZQ0KPiBCIHN0YXJ0ZWQgZW1wdHksIHRoZW4gbWVyZ2UgQyBpbnRvIEIsIGFuZCBCIGludG8g
QSwgYW4gaW5hY2N1cmF0ZQ0KPiBjb3VudCBtZWFudCB0aGF0IEEgZGlkIG5vdCBnZXQgdGhlIGNv
bnRlbnRzIG9mIEMuDQo+DQo+IEluIHRoZSB3b3JzdCBjYXNlLCB3ZSBtYXkgZmFsc2VseSByZWdh
cmQgdGhlIGJpdG1hcCBhcyBlbXB0eSB3aGVuDQo+IGl0IGhhcyBoYWQgbmV3IHdyaXRlcyBtZXJn
ZWQgaW50byBpdC4NCj4NCj4gRml4ZXM6IGJlNTg3MjFkYg0KPiBDQzogcWVtdS1zdGFibGVAbm9u
Z251Lm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBFcmljIEJsYWtlIDxlYmxha2VAcmVkaGF0LmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogSm9obiBTbm93IDxqc25vd0ByZWRoYXQuY29tPg0KDQpSZXZpZXdl
ZC1ieTogVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSA8dnNlbWVudHNvdkB2aXJ0dW96em8u
Y29tPg0KDQpIbSwgSSByZW1lbWJlcmQ6DQpjb21taXQgMzI2MGNkZmZmYmYwMGYzMzkyM2Y1Zjlm
NmJlZjQ1OTMyZDdhYzI4Yg0KQXV0aG9yOiBMaWFuZyBMaSA8bGlsaWFuZ2xlb0BkaWRpY2h1eGlu
Zy5jb20+DQpEYXRlOsKgwqAgV2VkIEZlYiA3IDExOjM1OjQ5IDIwMTggLTA1MDANCg0KIMKgwqDC
oCBoYml0bWFwOiBmaXggbWlzc2luZyByZXN0b3JlIGNvdW50IHdoZW4gZmluaXNoIGRlc2VyaWFs
aXphdGlvbg0KDQogwqDCoMKgIFRoZSAuY291bnQgb2YgSEJpdG1hcCBpcyBmb3Jnb3QgdG8gc2V0
IGluIGZ1bmN0aW9uDQogwqDCoMKgIGhiaXRtYXBfZGVzZXJpYWxpemVfZmluaXNoLCBsZXQncyBz
ZXQgaXQgdG8gdGhlIHJpZ2h0IHZhbHVlLg0KDQoNCiDCoC0gSSBhbHdheXMgZm9yZ2V0IHRvIHVw
ZGF0ZSB0aGlzIGZpZWxkLi4gV2UgZGVmaW5pdGVseSBzaG91bGQgYWRkIHNvbWUgDQpnZW5lcmlj
IGNoZWNrIG9uIGl0IHNvbWV3aGVyZSwgYXQgbGVhc3QgaW4gdGVzdHMuDQoNCj4gLS0tDQo+DQo+
IHYyOiBiYXNlZCBvZmYgb2YgRXJpYydzIGNvdmVyIGxldHRlciwgbm93IHJlYmFzZWQgcHJvcGVy
bHkNCj4gICAgICBvbiB0b3Agb2YgdGhlIGpzbm93L2JpdG1hcHMgc3RhZ2luZyBicmFuY2ggdG8g
dXNlIHRoZQ0KPiAgICAgIGNvcnJlY3QgYml0bWFwIHRhcmdldCAocmVzdWx0KS4NCj4NCj4NCj4g
ICB1dGlsL2hiaXRtYXAuYyB8IDMgKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvdXRpbC9oYml0bWFwLmMgYi91dGlsL2hiaXRtYXAuYw0K
PiBpbmRleCBkNWFjYTUxNTlmLi44ZDQwMmM1OWQ5IDEwMDY0NA0KPiAtLS0gYS91dGlsL2hiaXRt
YXAuYw0KPiArKysgYi91dGlsL2hiaXRtYXAuYw0KPiBAQCAtNzU5LDYgKzc1OSw5IEBAIGJvb2wg
aGJpdG1hcF9tZXJnZShjb25zdCBIQml0bWFwICphLCBjb25zdCBIQml0bWFwICpiLCBIQml0bWFw
ICpyZXN1bHQpDQo+ICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4gICANCj4gKyAgICAvKiBSZWNv
bXB1dGUgdGhlIGRpcnR5IGNvdW50ICovDQo+ICsgICAgcmVzdWx0LT5jb3VudCA9IGhiX2NvdW50
X2JldHdlZW4ocmVzdWx0LCAwLCByZXN1bHQtPnNpemUgLSAxKTsNCj4gKw0KPiAgICAgICByZXR1
cm4gdHJ1ZTsNCj4gICB9DQo+ICAgDQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1pcg0K
DQo=

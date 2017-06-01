Received: from eggs.gnu.org ([2001:4830:134:3::10]:41892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dGOKj-0001bD-CT
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dGOKg-0007Qs-8R
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:32:05 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dGOKf-0007P8-Lj
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:32:02 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Thu, 1 Jun 2017 11:31:35 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA2C10AE@DGGEMA505-MBX.china.huawei.com>
References: <1495865408-13848-1-git-send-email-arei.gonglei@huawei.com>
	<bdb80431-8046-2e2d-4645-6ff23676ceab@redhat.com>
In-Reply-To: <bdb80431-8046-2e2d-4645-6ff23676ceab@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] kvm: don't register smram_listener when
 smm is off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yechuan <yechuan@huawei.com>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBhb2xvIEJvbnppbmkgW21h
aWx0bzpwYm9uemluaUByZWRoYXQuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAwMSwgMjAx
NyA2OjA0IFBNDQo+IFRvOiBHb25nbGVpIChBcmVpKTsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+
IENjOiBZZWNodWFuDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGt2bTogZG9uJ3QgcmVnaXN0ZXIg
c21yYW1fbGlzdGVuZXIgd2hlbiBzbW0gaXMgb2ZmDQo+IA0KPiANCj4gDQo+IE9uIDI3LzA1LzIw
MTcgMDg6MTAsIEdvbmdsZWkgd3JvdGU6DQo+ID4gSWYgdGhlIHVzZXIgc2V0IGRpc2FibGUgc21t
IGJ5ICctbWFjaGluZSBzbW09b2ZmJywgd2UNCj4gPiBzaG91bGQgbm90IHJlZ2lzdGVyIHNtcmFt
X2xpc3RlbmVyIHNvIHRoYXQgd2UgY2FuDQo+ID4gYXZvaWQgd2FzdGVyIG1lbW9yeSBpbiBrdm0g
c2luY2UgdGhlIGFkZGVkIHNlbmNvbmQNCj4gPiBhZGRyZXNzIHNwYWNlLg0KPiA+DQo+ID4gTWVh
bndoaWxlIHdlIHNob3VsZCBhc3NpZ24gdmFsdWUgb2YgdGhlIGdsb2JhbCBrdm1fc3RhdGUNCj4g
PiBiZWZvcmUgaW52b2tpbmcgdGhlIGt2bV9hcmNoX2luaXQoKSwgYmVjYXVzZQ0KPiA+IHBjX21h
Y2hpbmVfaXNfc21tX2VuYWJsZWQoKSBtYXkgdXNlIGl0IGJ5IGt2bV9oYXNfbW0oKS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEdvbmdsZWkgPGFyZWkuZ29uZ2xlaUBodWF3ZWkuY29tPg0KPiA+
IC0tLQ0KPiA+ICBrdm0tYWxsLmMgICAgICAgICB8IDQgKystLQ0KPiA+ICB0YXJnZXQvaTM4Ni9r
dm0uYyB8IDMgKystDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2t2bS1hbGwuYyBiL2t2bS1hbGwuYw0K
PiA+IGluZGV4IDkwYjg1NzMuLjkyYmRmMmMgMTAwNjQ0DQo+ID4gLS0tIGEva3ZtLWFsbC5jDQo+
ID4gKysrIGIva3ZtLWFsbC5jDQo+ID4gQEAgLTE3NDYsNiArMTc0Niw4IEBAIHN0YXRpYyBpbnQg
a3ZtX2luaXQoTWFjaGluZVN0YXRlICptcykNCj4gPiAgICAgIGt2bV9pb2V2ZW50ZmRfYW55X2xl
bmd0aF9hbGxvd2VkID0NCj4gPiAgICAgICAgICAoa3ZtX2NoZWNrX2V4dGVuc2lvbihzLCBLVk1f
Q0FQX0lPRVZFTlRGRF9BTllfTEVOR1RIKSA+DQo+IDApOw0KPiA+DQo+ID4gKyAgICBrdm1fc3Rh
dGUgPSBzOw0KPiA+ICsNCj4gPiAgICAgIHJldCA9IGt2bV9hcmNoX2luaXQobXMsIHMpOw0KPiA+
ICAgICAgaWYgKHJldCA8IDApIHsNCj4gPiAgICAgICAgICBnb3RvIGVycjsNCj4gPiBAQCAtMTc1
NSw4ICsxNzU3LDYgQEAgc3RhdGljIGludCBrdm1faW5pdChNYWNoaW5lU3RhdGUgKm1zKQ0KPiA+
ICAgICAgICAgIGt2bV9pcnFjaGlwX2NyZWF0ZShtcywgcyk7DQo+ID4gICAgICB9DQo+ID4NCj4g
PiAtICAgIGt2bV9zdGF0ZSA9IHM7DQo+ID4gLQ0KPiA+ICAgICAgaWYgKGt2bV9ldmVudGZkc19h
bGxvd2VkKSB7DQo+ID4gICAgICAgICAgcy0+bWVtb3J5X2xpc3RlbmVyLmxpc3RlbmVyLmV2ZW50
ZmRfYWRkID0NCj4ga3ZtX21lbV9pb2V2ZW50ZmRfYWRkOw0KPiA+ICAgICAgICAgIHMtPm1lbW9y
eV9saXN0ZW5lci5saXN0ZW5lci5ldmVudGZkX2RlbCA9DQo+IGt2bV9tZW1faW9ldmVudGZkX2Rl
bDsNCj4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYva3ZtLmMgYi90YXJnZXQvaTM4Ni9rdm0u
Yw0KPiA+IGluZGV4IDAxMWQ0YTUuLmNiNWI0N2UgMTAwNjQ0DQo+ID4gLS0tIGEvdGFyZ2V0L2kz
ODYva3ZtLmMNCj4gPiArKysgYi90YXJnZXQvaTM4Ni9rdm0uYw0KPiA+IEBAIC0xMjU0LDcgKzEy
NTQsOCBAQCBpbnQga3ZtX2FyY2hfaW5pdChNYWNoaW5lU3RhdGUgKm1zLCBLVk1TdGF0ZQ0KPiAq
cykNCj4gPiAgICAgICAgICB9DQo+ID4gICAgICB9DQo+ID4NCj4gPiAtICAgIGlmIChrdm1fY2hl
Y2tfZXh0ZW5zaW9uKHMsIEtWTV9DQVBfWDg2X1NNTSkpIHsNCj4gPiArICAgIGlmIChrdm1fY2hl
Y2tfZXh0ZW5zaW9uKHMsIEtWTV9DQVBfWDg2X1NNTSkgJiYNCj4gPiArICAgICAgICAgICAgcGNf
bWFjaGluZV9pc19zbW1fZW5hYmxlZChQQ19NQUNISU5FKG1zKSkpIHsNCj4gPiAgICAgICAgICBz
bXJhbV9tYWNoaW5lX2RvbmUubm90aWZ5ID0gcmVnaXN0ZXJfc21yYW1fbGlzdGVuZXI7DQo+ID4N
Cj4gcWVtdV9hZGRfbWFjaGluZV9pbml0X2RvbmVfbm90aWZpZXIoJnNtcmFtX21hY2hpbmVfZG9u
ZSk7DQo+ID4gICAgICB9DQo+ID4NCj4gDQo+IEkgdGhpbmsgdGhpcyBicmVha3MNCj4gDQo+ICAg
ICB4ODZfNjQtc29mdG1tdS9xZW11LXN5c3RlbS14ODZfNjQgLU0gbm9uZSAtUyAtLWVuYWJsZS1r
dm0NCj4gDQo+IFlvdSBuZWVkIHRvIGRvIGEgb2JqZWN0X2R5bmFtaWNfY2FzdCBiZWZvcmUgaW52
b2tpbmcgUENfTUFDSElORShtcykuDQo+IA0KR29vZCBjYXRjaCEgVjIgd2lsbCBiZSBwb3N0ZWQg
c29vbi4NCg0KVGhhbmtzLA0KLUdvbmdsZWkNCg==

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d8GqT-0000Ij-Ti
	for qemu-devel@nongnu.org; Tue, 09 May 2017 21:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d8GqQ-0007Wo-R8
	for qemu-devel@nongnu.org; Tue, 09 May 2017 21:55:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <wangyunjian@huawei.com>) id 1d8GqQ-0007EU-6d
	for qemu-devel@nongnu.org; Tue, 09 May 2017 21:55:14 -0400
From: wangyunjian <wangyunjian@huawei.com>
Date: Wed, 10 May 2017 01:54:59 +0000
Message-ID: <34EFBCA9F01B0748BEB6B629CE643AE60BB56000@DGGEMA505-MBX.china.huawei.com>
References: <1494338586-13416-1-git-send-email-wangyunjian@huawei.com>
	<CAJ+F1CKL3vgJSSb8JGzNNBDS0xGKhtuP+2JEy1tsszauBMAUyA@mail.gmail.com>
In-Reply-To: <CAJ+F1CKL3vgJSSb8JGzNNBDS0xGKhtuP+2JEy1tsszauBMAUyA@mail.gmail.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vhost-user: fix watcher need be removed
 when vhost-user hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, caihe <caihe@huawei.com>, "mst@redhat.com" <mst@redhat.com>

T24gVHVlLCBNYXkgOSwgMjAxNyBhdCA1OjA0IFBNIFl1bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5A
aHVhd2VpLmNvbT4gd3JvdGU6DQoNCj4gPiBGcm9tOiB3MDAyNzMxODYgPHdhbmd5dW5qaWFuQGh1
YXdlaS5jb20+DQo+ID4NCj4gPiAibmMiIGlzIGZyZWVkIGFmdGVyIGhvdHBsdWcgdmhvc3QtdXNl
ciwgYnV0IHRoZSB3YXRjaGVyIGRvbid0IGJlIHJlbW92ZWQuDQo+ID4NCj4gDQo+IA0KPiA+IFRo
ZSBRRU1VIGNyYXNoIHdoZW4gdGhlIHdhdGNoZXIgYWNjZXNzIHRoZSAibmMiIG9uIHNvY2tldCBk
aXNjb25uZWN0Lg0KPiA+DQo+ID4NCj4gRG8geW91IGhhdmUgYSByZXByb2R1Y2VyPyB0aGFua3MN
Cj4NCg0KcmVwcm9kdWNlIHN0ZXBzOg0KDQoxLiB2aXJzaCBhdHRhY2gtZGV2aWNlIHZtMCB2aG9z
dC11c2VyLnhtbA0KMi4gdmlyc2ggZGV0YWNoLWRldmljZSB2bTAgdmhvc3QtdXNlci54bWwNCjMu
IHZpcnNoIGF0dGFjaC1kZXZpY2Ugdm0wIHZob3N0LXVzZXIueG1sDQo0LiBzZXJ2aWNlIG9wZW52
c3dpdGNoIHJlc3RhcnQNCjUuIHJlcGVhdCBzdGVwIDJ+NA0KDQpUaGUgdmhvc3QtdXNlciB4bWw6
DQoNCiAgICA8aW50ZXJmYWNlIHR5cGU9J3Zob3N0dXNlcic+DQogICAgICA8bWFjIGFkZHJlc3M9
JzAwOjAxOjAxOjAwOjEwOjQxJy8+DQogICAgICA8c291cmNlIHR5cGU9J3VuaXgnIHBhdGg9Jy92
YXIvcnVuL3Zob3N0LXVzZXIvdGFwMScgbW9kZT0nY2xpZW50Jy8+DQogICAgICA8bW9kZWwgdHlw
ZT0ndmlydGlvJy8+DQogICAgICA8ZHJpdmVyIHF1ZXVlcz0nOCcvPg0K44CAPC9pbnRlcmZhY2U+
DQoNClRoYW5rcw0KDQo+IA0KPiA+IENhbGwgVHJhY2U6DQo+ID4gICAgICMwICBvYmplY3RfZ2V0
X2NsYXNzIChvYmo9b2JqQGVudHJ5PTB4MikgYXQgcW9tL29iamVjdC5jOjc1MQ0KPiA+ICAgICAj
MSAgMHgwMDAwN2ZjMDMxYzc5ZjQxIGluIHFlbXVfY2hyX2ZlX2Rpc2Nvbm5lY3QgKGJlPTxvcHRp
bWl6ZWQgb3V0PikNCj4gPiBhdCBjaGFyZGV2L2NoYXIuYzoxMDQ4DQo+ID4gICAgICMyICAweDAw
MDA3ZmMwMzFiZDYyZTAgaW4gbmV0X3Zob3N0X3VzZXJfd2F0Y2ggKGNoYW49PG9wdGltaXplZCBv
dXQ+LA0KPiA+IGNvbmQ9PG9wdGltaXplZCBvdXQ+LCBvcGFxdWU9PG9wdGltaXplZCBvdXQ+KSBh
dCBuZXQvdmhvc3QtdXNlci5jOjE5MQ0KPiA+ICAgICAjMyAgMHgwMDAwN2ZjMDJjMjNlOTlhIGlu
IGdfbWFpbl9jb250ZXh0X2Rpc3BhdGNoICgpIGZyb20NCj4gPiAvbGliNjQvbGliZ2xpYi0yLjAu
c28uMA0KPiA+ICAgICAjNCAgMHgwMDAwN2ZjMDMxY2NmYzBjIGluIGdsaWJfcG9sbGZkc19wb2xs
ICgpIGF0IHV0aWwvbWFpbi1sb29wLmM6MjEzDQo+ID4gICAgICM1ICBvc19ob3N0X21haW5fbG9v
cF93YWl0ICh0aW1lb3V0PTxvcHRpbWl6ZWQgb3V0PikgYXQNCj4gPiB1dGlsL21haW4tbG9vcC5j
OjI2MQ0KPiA+ICAgICAjNiAgbWFpbl9sb29wX3dhaXQgKG5vbmJsb2NraW5nPW5vbmJsb2NraW5n
QGVudHJ5PTApIGF0DQo+ID4gdXRpbC9tYWluLWxvb3AuYzo1MTcNCj4gPiAgICAgIzcgIDB4MDAw
MDdmYzAzMTkzYmM4NyBpbiBtYWluX2xvb3AgKCkgYXQgdmwuYzoxODk5DQo+ID4gICAgICM4ICBt
YWluIChhcmdjPTxvcHRpbWl6ZWQgb3V0PiwgYXJndj08b3B0aW1pemVkIG91dD4sIGVudnA9PG9w
dGltaXplZA0KPiA+IG91dD4pIGF0IHZsLmM6NDcxOQ0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
WXVuamlhbiBXYW5nIDx3YW5neXVuamlhbkBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICBuZXQv
dmhvc3QtdXNlci5jIHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9uZXQvdmhvc3QtdXNlci5jIGIvbmV0L3Zob3N0LXVz
ZXIuYw0KPiA+IGluZGV4IDAwYTBjMWMuLjVjYzIxNzggMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3Zo
b3N0LXVzZXIuYw0KPiA+ICsrKyBiL25ldC92aG9zdC11c2VyLmMNCj4gPiBAQCAtMTU1LDYgKzE1
NSwxMCBAQCBzdGF0aWMgdm9pZCB2aG9zdF91c2VyX2NsZWFudXAoTmV0Q2xpZW50U3RhdGUgKm5j
KQ0KPiA+DQo+ID4gICAgICAgICAgcWVtdV9jaHJfZmVfZGVpbml0KCZzLT5jaHIpOw0KPiA+ICAg
ICAgICAgIG9iamVjdF91bnBhcmVudChPQkpFQ1QoY2hyKSk7DQo+ID4gKyAgICAgICAgaWYgKHMt
PndhdGNoKSB7DQo+ID4gKyAgICAgICAgICAgIGdfc291cmNlX3JlbW92ZShzLT53YXRjaCk7DQo+
ID4gKyAgICAgICAgICAgIHMtPndhdGNoID0gMDsNCj4gPiArICAgICAgICB9DQo+ID4gICAgICB9
DQo+ID4NCj4gPiAgICAgIHFlbXVfcHVyZ2VfcXVldWVkX3BhY2tldHMobmMpOw0KPiA+IC0tDQo+
ID4gMS44LjMuMQ0KPiA+DQo+ID4NCj4gPg0KPiA+IC0tDQo+IE1hcmMtQW5kcsOpIEx1cmVhdQ0K

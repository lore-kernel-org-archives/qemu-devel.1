Received: from eggs.gnu.org ([2001:4830:134:3::10]:54409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1elS0u-0007aM-NT
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1elS0s-0003kE-13
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:16:16 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2382 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1elS0r-0003jV-Li
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:16:13 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 13 Feb 2018 04:16:02 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302C5A89D@dggemm509-mbx.china.huawei.com>
References: <20180213025306.16736-1-linzhecheng@huawei.com>
	<11266f1b-1001-4ddc-173b-7d079b3cc221@amsat.org>
In-Reply-To: <11266f1b-1001-4ddc-173b-7d079b3cc221@amsat.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiAgW1BBVENIXSB2aG9zdC11c2VyOiBm?=
 =?utf-8?q?ix_memory_leak?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "mst@redhat.com" <mst@redhat.com>

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIFttYWlsdG86cGhpbGlwcGUubWF0aGlldS5kYXVkZUBnbWFpbC5jb21dDQo+IOS7
o+ihqCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqQ0KPiDlj5HpgIHml7bpl7Q6IDIwMTjlubQy5pyI
MTPml6UgMTE6NTQNCj4g5pS25Lu25Lq6OiBsaW56aGVjaGVuZyA8bGluemhlY2hlbmdAaHVhd2Vp
LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiDmioTpgIE6IHBib256aW5pQHJlZGhhdC5j
b207IHdhbmd4aW4gKFUpIDx3YW5neGlueGluLndhbmdAaHVhd2VpLmNvbT47DQo+IGxpZG9uZ2xp
biA8bGlkb25nbGluQGh1YXdlaS5jb20+OyBtc3RAcmVkaGF0LmNvbQ0KPiDkuLvpopg6IFJlOiBb
UWVtdS1kZXZlbF0gW1BBVENIXSB2aG9zdC11c2VyOiBmaXggbWVtb3J5IGxlYWsNCj4gDQo+IEhp
IExpbnpoZWNoZW5nLA0KPiANCj4gT24gMDIvMTIvMjAxOCAxMTo1MyBQTSwgbGluemhlY2hlbmcg
d3JvdGU6DQo+ID4gZml4IG1lbW9yeSBsZWFrDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBsaW56
aGVjaGVuZyA8bGluemhlY2hlbmdAaHVhd2VpLmNvbT4NCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9u
ZXQvdmhvc3QtdXNlci5jIGIvbmV0L3Zob3N0LXVzZXIuYyBpbmRleA0KPiA+IGNiNDU1MTI1MDYu
LmQwMjQ1NzNlNDUgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L3Zob3N0LXVzZXIuYw0KPiA+ICsrKyBi
L25ldC92aG9zdC11c2VyLmMNCj4gPiBAQCAtMTA5LDYgKzEwOSw3IEBAIHN0YXRpYyBpbnQgdmhv
c3RfdXNlcl9zdGFydChpbnQgcXVldWVzLA0KPiA+IE5ldENsaWVudFN0YXRlICpuY3NbXSwgQ2hh
ckJhY2tlbmQgKmJlKQ0KPiA+ICBlcnI6DQo+ID4gICAgICBpZiAobmV0KSB7DQo+ID4gICAgICAg
ICAgdmhvc3RfbmV0X2NsZWFudXAobmV0KTsNCj4gPiArICAgICAgICBnX2ZyZWUobmV0KTsNCj4g
DQo+IEkgdGhpbmsgdGhpcyBnX2ZyZWUoKSBiZWxvbmdzIHRvIHZob3N0X25ldF9jbGVhbnVwKCkg
aW4gbmV0L3Zob3N0X25ldC5jOg0KSSB0aGluayB5b3VyIHFlbXUgdmVyc2lvbiBpcyBvdXQgb2Yg
ZGF0ZSwgIGdfZnJlZSB3YXMgbW92ZWQgZnJvbSB2aG9zdF9uZXRfY2xlYW51cCBpbiBjb21taXQg
ZTZiY2IxYg0KPiANCj4gdm9pZCB2aG9zdF9uZXRfY2xlYW51cChzdHJ1Y3Qgdmhvc3RfbmV0ICpu
ZXQpIHsNCj4gICAgIHZob3N0X2Rldl9jbGVhbnVwKCZuZXQtPmRldik7DQo+ICAgICBnX2ZyZWUo
bmV0KTsNCj4gfQ0KPiANCj4gUmVnYXJkcywNCj4gDQo+IFBoaWwuDQo+IA0KPiA+ICAgICAgfQ0K
PiA+ICAgICAgdmhvc3RfdXNlcl9zdG9wKGksIG5jcyk7DQo+ID4gICAgICByZXR1cm4gLTE7DQo+
ID4NCg==

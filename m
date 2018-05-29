Received: from eggs.gnu.org ([2001:4830:134:3::10]:48646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fNb16-0007TT-F0
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fNb13-0004AJ-AJ
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:34:08 -0400
Received: from [45.249.212.255] (port=43931 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fNb12-00048K-Vw
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:34:05 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 29 May 2018 09:33:46 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302C89900@dggemm509-mbx.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] socket: dont't free msgfds if error equals
 EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "peterx@redhat.com" <peterx@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>

SSB0aGluayB0aGlzIHBhdGNoIGRvZXNuJ3QgZml4IG15IGlzc3VlLiBGb3IgbW9yZSBkZXRhaWxz
LCBwbGVhc2Ugc2VlIEdvbmdsZWkncyByZXBseS4NCmh0dHBzOi8vbGlzdHMuZ251Lm9yZy9hcmNo
aXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4LTA1L21zZzA2Mjk2Lmh0bWwNCg0KPiAtLS0tLemCruS7
tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyYy1BbmRyw6kgTHVyZWF1IFttYWlsdG86bWFy
Y2FuZHJlLmx1cmVhdUBnbWFpbC5jb21dDQo+IOWPkemAgeaXtumXtDogMjAxOOW5tDXmnIgyOeaX
pSAxNzoxMQ0KPiDmlLbku7bkuro6IGxpbnpoZWNoZW5nIDxsaW56aGVjaGVuZ0BodWF3ZWkuY29t
Pg0KPiDmioTpgIE6IFFFTVUgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IFBhb2xvIEJvbnppbmkN
Cj4gPHBib256aW5pQHJlZGhhdC5jb20+OyB3YW5neGluIChVKSA8d2FuZ3hpbnhpbi53YW5nQGh1
YXdlaS5jb20+DQo+IOS4u+mimDogUmU6IFtRZW11LWRldmVsXSBbUEFUQ0hdIHNvY2tldDogZG9u
dCd0IGZyZWUgbXNnZmRzIGlmIGVycm9yIGVxdWFscw0KPiBFQUdBSU4NCj4gDQo+IEhpDQo+IA0K
PiBPbiBUdWUsIE1heSAyOSwgMjAxOCBhdCA0OjUyIEFNLCBsaW56aGVjaGVuZyA8bGluemhlY2hl
bmdAaHVhd2VpLmNvbT4NCj4gd3JvdGU6DQo+ID4gU2lnbmVkLW9mZi1ieTogbGluemhlY2hlbmcg
PGxpbnpoZWNoZW5nQGh1YXdlaS5jb20+DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvY2hhcmRldi9j
aGFyLXNvY2tldC5jIGIvY2hhcmRldi9jaGFyLXNvY2tldC5jIGluZGV4DQo+ID4gMTU5ZTY5YzNi
MS4uMTc1MTllYzU4OSAxMDA2NDQNCj4gPiAtLS0gYS9jaGFyZGV2L2NoYXItc29ja2V0LmMNCj4g
PiArKysgYi9jaGFyZGV2L2NoYXItc29ja2V0LmMNCj4gPiBAQCAtMTM0LDggKzEzNCw4IEBAIHN0
YXRpYyBpbnQgdGNwX2Nocl93cml0ZShDaGFyZGV2ICpjaHIsIGNvbnN0IHVpbnQ4X3QNCj4gKmJ1
ZiwgaW50IGxlbikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHMtPndyaXRlX21zZ2ZkcywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHMtPndyaXRlX21zZ2Zkc19udW0pOw0KPiA+DQo+ID4gLSAgICAgICAgLyogZnJlZSB0
aGUgd3JpdHRlbiBtc2dmZHMsIG5vIG1hdHRlciB3aGF0ICovDQo+ID4gLSAgICAgICAgaWYgKHMt
PndyaXRlX21zZ2Zkc19udW0pIHsNCj4gPiArICAgICAgICAvKiBmcmVlIHRoZSB3cml0dGVuIG1z
Z2ZkcyBpbiBhbnkgY2FzZXMgb3RoZXIgdGhhbiBlcnJubz09RUFHQUlOICovDQo+ID4gKyAgICAg
ICAgaWYgKEVBR0FJTiAhPSBlcnJubyAmJiBzLT53cml0ZV9tc2dmZHNfbnVtKSB7DQo+ID4gICAg
ICAgICAgICAgIGdfZnJlZShzLT53cml0ZV9tc2dmZHMpOw0KPiA+ICAgICAgICAgICAgICBzLT53
cml0ZV9tc2dmZHMgPSAwOw0KPiA+ICAgICAgICAgICAgICBzLT53cml0ZV9tc2dmZHNfbnVtID0g
MDsNCj4gPiAtLQ0KPiANCj4gSXQgaXMgYWxyZWFkeSBmaXggc2luY2UgdjIuMTI6DQo+IA0KPiBj
b21taXQgYzg2M2ZkZWM2YWZmNmI1YTRjYThmZmYxNTM3YjgwZDlmOGI5NzcyNg0KPiBBdXRob3I6
IERhbmllbCBQLiBCZXJyYW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+DQo+IERhdGU6ICAgVGh1
IEZlYiAyMiAxMjoxMzo1MSAyMDE4ICswMDAwDQo+IA0KPiAgICAgY2hhcmRldjogZml4IGhhbmRs
aW5nIG9mIEVBR0FJTiBmb3IgVENQIGNoYXJkZXYNCj4gDQo+ID4gMi4xMi4yLndpbmRvd3MuMg0K
PiA+DQo+ID4NCj4gPg0KPiANCj4gDQo+IA0KPiAtLQ0KPiBNYXJjLUFuZHLDqSBMdXJlYXUNCg==

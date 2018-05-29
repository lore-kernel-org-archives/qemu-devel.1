Received: from eggs.gnu.org ([2001:4830:134:3::10]:39845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fNaay-00007k-Mt
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fNaat-0002R9-Ue
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:07:08 -0400
Received: from [45.249.212.255] (port=58793 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fNaat-0002OQ-JU
	for qemu-devel@nongnu.org; Tue, 29 May 2018 05:07:03 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 29 May 2018 08:20:13 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302C898BB@dggemm509-mbx.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="gb2312"
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
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

Q0MnaW5nIERhbmllbCBQLiBCZXJyYW5nqKYgLCBQZXRlciBYdSwgTWFyYy1BbmRyqKYgTHVyZWF1
LCBFcmljIEJsYWtlLCBHb25nbGVpDQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7Iyzog
bGluemhlY2hlbmcNCj4gt6LLzcqxvOQ6IDIwMTjE6jXUwjI5yNUgMTA6NTMNCj4gytW8/sjLOiBx
ZW11LWRldmVsQG5vbmdudS5vcmcNCj4gs63LzTogcGJvbnppbmlAcmVkaGF0LmNvbTsgd2FuZ3hp
biAoVSkgPHdhbmd4aW54aW4ud2FuZ0BodWF3ZWkuY29tPjsNCj4gbGluemhlY2hlbmcgPGxpbnpo
ZWNoZW5nQGh1YXdlaS5jb20+DQo+INb3zOI6IFtQQVRDSF0gc29ja2V0OiBkb250J3QgZnJlZSBt
c2dmZHMgaWYgZXJyb3IgZXF1YWxzIEVBR0FJTg0KPiANCj4gU2lnbmVkLW9mZi1ieTogbGluemhl
Y2hlbmcgPGxpbnpoZWNoZW5nQGh1YXdlaS5jb20+DQo+IA0KPiBkaWZmIC0tZ2l0IGEvY2hhcmRl
di9jaGFyLXNvY2tldC5jIGIvY2hhcmRldi9jaGFyLXNvY2tldC5jIGluZGV4DQo+IDE1OWU2OWMz
YjEuLjE3NTE5ZWM1ODkgMTAwNjQ0DQo+IC0tLSBhL2NoYXJkZXYvY2hhci1zb2NrZXQuYw0KPiAr
KysgYi9jaGFyZGV2L2NoYXItc29ja2V0LmMNCj4gQEAgLTEzNCw4ICsxMzQsOCBAQCBzdGF0aWMg
aW50IHRjcF9jaHJfd3JpdGUoQ2hhcmRldiAqY2hyLCBjb25zdCB1aW50OF90DQo+ICpidWYsIGlu
dCBsZW4pDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcy0+d3Jp
dGVfbXNnZmRzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHMt
PndyaXRlX21zZ2Zkc19udW0pOw0KPiANCj4gLSAgICAgICAgLyogZnJlZSB0aGUgd3JpdHRlbiBt
c2dmZHMsIG5vIG1hdHRlciB3aGF0ICovDQo+IC0gICAgICAgIGlmIChzLT53cml0ZV9tc2dmZHNf
bnVtKSB7DQo+ICsgICAgICAgIC8qIGZyZWUgdGhlIHdyaXR0ZW4gbXNnZmRzIGluIGFueSBjYXNl
cyBvdGhlciB0aGFuIGVycm5vPT1FQUdBSU4gKi8NCj4gKyAgICAgICAgaWYgKEVBR0FJTiAhPSBl
cnJubyAmJiBzLT53cml0ZV9tc2dmZHNfbnVtKSB7DQo+ICAgICAgICAgICAgICBnX2ZyZWUocy0+
d3JpdGVfbXNnZmRzKTsNCj4gICAgICAgICAgICAgIHMtPndyaXRlX21zZ2ZkcyA9IDA7DQo+ICAg
ICAgICAgICAgICBzLT53cml0ZV9tc2dmZHNfbnVtID0gMDsNCj4gLS0NCj4gMi4xMi4yLndpbmRv
d3MuMg0KPiANCg0K

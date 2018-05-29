Received: from eggs.gnu.org ([2001:4830:134:3::10]:33916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fNaBz-0001zN-74
	for qemu-devel@nongnu.org; Tue, 29 May 2018 04:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1fNaBw-00054Q-1B
	for qemu-devel@nongnu.org; Tue, 29 May 2018 04:41:19 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2271 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1fNaBv-00050u-MN
	for qemu-devel@nongnu.org; Tue, 29 May 2018 04:41:15 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Tue, 29 May 2018 08:41:04 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA64285E@DGGEMA505-MBX.china.huawei.com>
References: <D9DE8DBB19F2A24080482022C1DE758302C898BB@dggemm509-mbx.china.huawei.com>
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302C898BB@dggemm509-mbx.china.huawei.com>
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
To: linzhecheng <linzhecheng@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "berrange@redhat.com" <berrange@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>

SGkgYWxsLA0KDQpUaGUgaXNzdWUgaXMgZWFzeSB0byByZXByb2R1Y2Ugd2hlbiB3ZSBjb25maXVn
cmVkIG11bHRpLXF1ZXVlIGZ1bmN0aW9uIGZvciB2aG9zdC11c2VyIG5pY3MuDQoNClRoZSBtYWlu
IGJhY2t0cmFjZSBpcyBhcyBmb2xsb3dzOg0KDQp2aG9zdF91c2VyX3dyaXRlICA9PT4gIDApICBz
ZXRzIHMtPndyaXRlX21zZ2Zkc19udW0gdG8gOA0KCXFlbXVfY2hyX2ZlX3dyaXRlX2FsbA0KCQlx
ZW11X2Nocl9mZV93cml0ZV9idWZmZXIgID09PiA0KSByZXdyaXRlIGJlY2F1c2UgKHJldCA8MCAm
JiBlcnJubyBpcyBFQUdBSU4pDQoJCQl0Y3BfY2hyX3dyaXRlICA9PT4gMykgY2xlYXIgcmVzb3Vy
Y2UgYWJvdXQgcy0+d3JpdGVfbXNnZmRzIGFuZCBzZXQgcy0+d3JpdGVfbXNnZmRzX251bSB0byAw
DQoJCQkJaW9fY2hhbm5lbF9zZW5kX2Z1bGwgID09PiAgMikgZXJybm8gPSBFQUdBSU4gYW5kIHJl
dHVybiAtMQ0KCQkJCQlxaW9fY2hhbm5lbF9zb2NrZXRfd3JpdGV2ICA9PT4gMSkgcmV0dXJucyBR
SU9fQ0hBTk5FTF9FUlJfQkxPQ0sgd2hlbiByZXQgPDAgJiYgZXJybm8gPT0gRUFHQUlODQoNClRo
ZW4gYXQgdGhlIGFib3ZlIHN0ZXAgNCkgbWF5IGNhdXNlIHVuZGVmaW5lZCBiZWhhdmlvcnMgb24g
dGhlIHZob3N0LXVzZXIgc2VydmVyIHNpZGUgYmVjYXVzZSBudWxsIGNvbnRyb2wgbWVzc2FnZSBp
cyBzZW50LiANCg0KU28sIHdlIHN1Ym1pdCBhIHBhdGNoIHRvIGZpeCBpdC4gV2hhdCdzIHlvdXIg
b3Bpbmlvbj8NCg0KUmVnYXJkcywNCi1Hb25nbGVpDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogbGluemhlY2hlbmcNCj4gU2VudDogVHVlc2RheSwgTWF5IDI5LCAyMDE4
IDQ6MjAgUE0NCj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogcGJvbnppbmlAcmVk
aGF0LmNvbTsgd2FuZ3hpbiAoVSkgPHdhbmd4aW54aW4ud2FuZ0BodWF3ZWkuY29tPjsNCj4gYmVy
cmFuZ2VAcmVkaGF0LmNvbTsgcGV0ZXJ4QHJlZGhhdC5jb207IG1hcmNhbmRyZS5sdXJlYXVAcmVk
aGF0LmNvbTsNCj4gZWJsYWtlQHJlZGhhdC5jb207IEdvbmdsZWkgKEFyZWkpIDxhcmVpLmdvbmds
ZWlAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gc29ja2V0OiBkb250J3QgZnJl
ZSBtc2dmZHMgaWYgZXJyb3IgZXF1YWxzIEVBR0FJTg0KPiANCj4gQ0MnaW5nIERhbmllbCBQLiBC
ZXJyYW5nqKYgLCBQZXRlciBYdSwgTWFyYy1BbmRyqKYgTHVyZWF1LCBFcmljIEJsYWtlLCBHb25n
bGVpDQo+IA0KPiA+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiA+ILeivP7IyzogbGluemhlY2hlbmcN
Cj4gPiC3osvNyrG85DogMjAxOMTqNdTCMjnI1SAxMDo1Mw0KPiA+IMrVvP7IyzogcWVtdS1kZXZl
bEBub25nbnUub3JnDQo+ID4gs63LzTogcGJvbnppbmlAcmVkaGF0LmNvbTsgd2FuZ3hpbiAoVSkN
Cj4gPHdhbmd4aW54aW4ud2FuZ0BodWF3ZWkuY29tPjsNCj4gPiBsaW56aGVjaGVuZyA8bGluemhl
Y2hlbmdAaHVhd2VpLmNvbT4NCj4gPiDW98ziOiBbUEFUQ0hdIHNvY2tldDogZG9udCd0IGZyZWUg
bXNnZmRzIGlmIGVycm9yIGVxdWFscyBFQUdBSU4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IGxp
bnpoZWNoZW5nIDxsaW56aGVjaGVuZ0BodWF3ZWkuY29tPg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2NoYXJkZXYvY2hhci1zb2NrZXQuYyBiL2NoYXJkZXYvY2hhci1zb2NrZXQuYyBpbmRleA0KPiA+
IDE1OWU2OWMzYjEuLjE3NTE5ZWM1ODkgMTAwNjQ0DQo+ID4gLS0tIGEvY2hhcmRldi9jaGFyLXNv
Y2tldC5jDQo+ID4gKysrIGIvY2hhcmRldi9jaGFyLXNvY2tldC5jDQo+ID4gQEAgLTEzNCw4ICsx
MzQsOCBAQCBzdGF0aWMgaW50IHRjcF9jaHJfd3JpdGUoQ2hhcmRldiAqY2hyLCBjb25zdCB1aW50
OF90DQo+ID4gKmJ1ZiwgaW50IGxlbikNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHMtPndyaXRlX21zZ2ZkcywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHMtPndyaXRlX21zZ2Zkc19udW0pOw0KPiA+DQo+ID4gLSAgICAg
ICAgLyogZnJlZSB0aGUgd3JpdHRlbiBtc2dmZHMsIG5vIG1hdHRlciB3aGF0ICovDQo+ID4gLSAg
ICAgICAgaWYgKHMtPndyaXRlX21zZ2Zkc19udW0pIHsNCj4gPiArICAgICAgICAvKiBmcmVlIHRo
ZSB3cml0dGVuIG1zZ2ZkcyBpbiBhbnkgY2FzZXMgb3RoZXIgdGhhbiBlcnJubz09RUFHQUlODQo+
ICovDQo+ID4gKyAgICAgICAgaWYgKEVBR0FJTiAhPSBlcnJubyAmJiBzLT53cml0ZV9tc2dmZHNf
bnVtKSB7DQo+ID4gICAgICAgICAgICAgIGdfZnJlZShzLT53cml0ZV9tc2dmZHMpOw0KPiA+ICAg
ICAgICAgICAgICBzLT53cml0ZV9tc2dmZHMgPSAwOw0KPiA+ICAgICAgICAgICAgICBzLT53cml0
ZV9tc2dmZHNfbnVtID0gMDsNCj4gPiAtLQ0KPiA+IDIuMTIuMi53aW5kb3dzLjINCj4gPg0KDQo=

Received: from eggs.gnu.org ([2001:4830:134:3::10]:43144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eRrio-0007ot-Ff
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 22:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1eRril-0007Sx-SC
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 22:40:38 -0500
Received: from [45.249.212.255] (port=54947 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1eRril-0007QI-DH
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 22:40:35 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Thu, 21 Dec 2017 03:40:23 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302C51F05@dggemm509-mbx.china.huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PULL 02/46] qemu-thread: fix races on threads
 that exit very quickly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "famz@redhat.com" <famz@redhat.com>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEVyaWMgQmxha2UgW21h
aWx0bzplYmxha2VAcmVkaGF0LmNvbV0NCj4g5Y+R6YCB5pe26Ze0OiAyMDE35bm0MTLmnIgyMeaX
pSAxMTozNg0KPiDmlLbku7bkuro6IGxpbnpoZWNoZW5nIDxsaW56aGVjaGVuZ0BodWF3ZWkuY29t
PjsgUGFvbG8gQm9uemluaQ0KPiA8cGJvbnppbmlAcmVkaGF0LmNvbT47IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsgZmFtekByZWRoYXQuY29tDQo+IOaKhOmAgTogd2FuZ3hpbiAoVSkgPHdhbmd4aW54
aW4ud2FuZ0BodWF3ZWkuY29tPg0KPiDkuLvpopg6IFJlOiBbUWVtdS1kZXZlbF0gW1BVTEwgMDIv
NDZdIHFlbXUtdGhyZWFkOiBmaXggcmFjZXMgb24gdGhyZWFkcyB0aGF0DQo+IGV4aXQgdmVyeSBx
dWlja2x5DQo+IA0KPiBPbiAxMi8yMC8yMDE3IDA5OjI5IFBNLCBsaW56aGVjaGVuZyB3cm90ZToN
Cj4gDQo+ID4+ICt9IFFlbXVUaHJlYWRBcmdzOw0KPiA+PiArDQo+ID4+ICtzdGF0aWMgdm9pZCAq
cWVtdV90aHJlYWRfc3RhcnQodm9pZCAqYXJncykgew0KPiA+PiArICAgIFFlbXVUaHJlYWRBcmdz
ICpxZW11X3RocmVhZF9hcmdzID0gYXJnczsNCj4gPj4gKyAgICB2b2lkICooKnN0YXJ0X3JvdXRp
bmUpKHZvaWQgKikgPSBxZW11X3RocmVhZF9hcmdzLT5zdGFydF9yb3V0aW5lOw0KPiA+PiArICAg
IHZvaWQgKmFyZyA9IHFlbXVfdGhyZWFkX2FyZ3MtPmFyZzsNCj4gPj4gKw0KPiA+PiArICAgIC8q
IEF0dGVtcHQgdG8gc2V0IHRoZSB0aHJlYWRzIG5hbWU7IG5vdGUgdGhhdCB0aGlzIGlzIGZvciBk
ZWJ1Zywgc28NCj4gPj4gKyAgICAgKiB3ZSdyZSBub3QgZ29pbmcgdG8gZmFpbCBpZiB3ZSBjYW4n
dCBzZXQgaXQuDQo+ID4+ICsgICAgICovDQo+ID4+ICsgICAgcHRocmVhZF9zZXRuYW1lX25wKHB0
aHJlYWRfc2VsZigpLCBxZW11X3RocmVhZF9hcmdzLT5uYW1lKTsNCj4gPj4gKyAgICBnX2ZyZWUo
cWVtdV90aHJlYWRfYXJncy0+bmFtZSk7DQo+ID4+ICsgICAgZ19mcmVlKHFlbXVfdGhyZWFkX2Fy
Z3MpOw0KPiA+IElmIHFlbXVfdGhyZWFkX2FyZ3MgaXMgZnJlZWQgaGVyZSwgc3RhcnRfcm91dGlu
ZShhcmcpIHdpbGwgbGVhZCB0byB1c2UNCj4gPiBhZnRlciBmcmVlIGJlY2F1c2UgYXJnIGVxdWFs
cyB0byBxZW11X3RocmVhZF9hcmdzDQo+IA0KPiBObywgd2UgZXhwbGljaXRseSBjb3BpZWQgcWVt
dV90aHJlYWRfYXJncy0+YXJnIGludG8gYSBsb2NhbCB2YXJpYWJsZSBwcmlvciB0bw0KPiBmcmVl
aW5nIHFlbXVfdGhyZWFkX2FyZ3MsIHNvIHRoYXQgd2UgZG8gbm90IGhhdmUgdG8gZGVyZWZlcmVu
Y2UgdGhlIGZyZWVkDQo+IHZhcmlhYmxlLg0KT0ssIHRoYXQncyB0cnVlLiANCj4gDQo+IC0tDQo+
IEVyaWMgQmxha2UsIFByaW5jaXBhbCBTb2Z0d2FyZSBFbmdpbmVlcg0KPiBSZWQgSGF0LCBJbmMu
ICAgICAgICAgICArMS05MTktMzAxLTMyNjYNCj4gVmlydHVhbGl6YXRpb246ICBxZW11Lm9yZyB8
IGxpYnZpcnQub3JnDQo=

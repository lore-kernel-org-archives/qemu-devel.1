Received: from eggs.gnu.org ([2001:4830:134:3::10]:43700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dp2LC-0006OB-6i
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 21:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dp2L7-0002wh-4M
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 21:07:46 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:59248 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wang.yong155@zte.com.cn>)
	id 1dp2L6-0002qR-Fj
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 21:07:41 -0400
Date: Tue, 5 Sep 2017 09:07:28 +0800 (CST)
Message-ID: <201709050907288048417@zte.com.cn>
References: 1503991359-3353-1-git-send-email-wang.yong155@zte.com.cn,
	20170831101322.GL13619@stefanha-x1.localdomain
Mime-Version: 1.0
From: <wang.yong155@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCHv5_01/03=5D_qemu-iothread=3A_IOTh?=
 =?utf-8?q?read_supports_theGMainContext_event_loop?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, pbonzini@redhat.com, famz@redhat.com, jasowang@redhat.com
Cc: zhangchen.fnst@cn.fujitsu.com, zhang.zhanghailiang@huawei.com, wang.guang55@zte.com.cn, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org

Pj4gSU9UaHJlYWQgdXNlcyBBaW9Db250ZXh0IGV2ZW50IGxvb3AgYW5kIGRvZXMgbm90IHJ1biBh
IEdNYWluQ29udGV4dC4NCg0KPj4gVGhlcmVmb3JlLGNoYXJkZXYgY2Fubm90IHdvcmsgaW4gSU9U
aHJlYWQsc3VjaCBhcyB0aGUgY2hhcmRldiBpcw0KDQo+PiB1c2VkIGZvciBjb2xvLWNvbXBhcmUg
cGFja2V0cyByZWNlcHRpb24uDQoNCj4+IA0KDQo+PiBUaGlzIHBhdGNoIG1ha2VzIHRoZSBJT1Ro
cmVhZCBydW4gdGhlIEdNYWluQ29udGV4dCBldmVudCBsb29wLA0KDQo+PiBjaGFyZGV2IGFuZCBJ
T1RocmVhZCBjYW4gd29yayB0b2dldGhlci4NCg0KPj4gDQoNCj4+IFNpZ25lZC1vZmYtYnk6IFdh
bmcgWW9uZyA8d2FuZy55b25nMTU1QHp0ZS5jb20uY24+DQoNCj4+IFNpZ25lZC1vZmYtYnk6IFdh
bmcgR3VhbmcgPHdhbmcuZ3Vhbmc1NUB6dGUuY29tLmNuPg0KDQo+PiAtLS0NCg0KPj4gIGluY2x1
ZGUvc3lzZW11L2lvdGhyZWFkLmggfCAgNCArKysrDQoNCj4+ICBpb3RocmVhZC5jICAgICAgICAg
ICAgICAgIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQoNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykNCg0KPg0KDQo+UmV2aWV3
ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4NCg0KVGhhbmtzLg0K
DQoNCg0KDQpIaSBhbGwsDQoNCkEgZmV3IGRheXMgd2l0aG91dCBuZXdzLCBwaW5nLi4uDQoNCg0K
DQoNCg0KDQoNCldhbmdZb25nDQoNCg0KDQoNCg0KDQrljp/lp4vpgq7ku7YNCg0KDQoNCuWPkeS7
tuS6uu+8miA8c3RlZmFuaGFAcmVkaGF0LmNvbT4NCuaUtuS7tuS6uu+8mueOi+WLhzEwMTcwNTMw
DQrmioTpgIHkurrvvJogPHBib256aW5pQHJlZGhhdC5jb20+IDxmYW16QHJlZGhhdC5jb20+IDxq
YXNvd2FuZ0ByZWRoYXQuY29tPiA8emhhbmdjaGVuLmZuc3RAY24uZnVqaXRzdS5jb20+IDx6aGFu
Zy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+546L5bm/MTAxNjU5OTIgPGxpemhpamlhbkBjbi5m
dWppdHN1LmNvbT4gPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCuaXpSDmnJ8g77yaMjAxN+W5tDA4
5pyIMzHml6UgMTk6NTUNCuS4uyDpopgg77yaUmU6IFtQQVRDSHY1IDAxLzAzXSBxZW11LWlvdGhy
ZWFkOiBJT1RocmVhZCBzdXBwb3J0cyB0aGVHTWFpbkNvbnRleHQgZXZlbnQgbG9vcA0KDQoNCg0K
DQoNCk9uIFR1ZSwgQXVnIDI5LCAyMDE3IGF0IDAzOjIyOjM3UE0gKzA4MDAsIFdhbmcgeW9uZyB3
cm90ZToNCj4gRnJvbTogV2FuZyBZb25nIDx3YW5nLnlvbmcxNTVAenRlLmNvbS5jbj4NCj4gDQo+
IElPVGhyZWFkIHVzZXMgQWlvQ29udGV4dCBldmVudCBsb29wIGFuZCBkb2VzIG5vdCBydW4gYSBH
TWFpbkNvbnRleHQuDQo+IFRoZXJlZm9yZSxjaGFyZGV2IGNhbm5vdCB3b3JrIGluIElPVGhyZWFk
LHN1Y2ggYXMgdGhlIGNoYXJkZXYgaXMNCj4gdXNlZCBmb3IgY29sby1jb21wYXJlIHBhY2tldHMg
cmVjZXB0aW9uLg0KPiANCj4gVGhpcyBwYXRjaCBtYWtlcyB0aGUgSU9UaHJlYWQgcnVuIHRoZSBH
TWFpbkNvbnRleHQgZXZlbnQgbG9vcCwNCj4gY2hhcmRldiBhbmQgSU9UaHJlYWQgY2FuIHdvcmsg
dG9nZXRoZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIFlvbmcgPHdhbmcueW9uZzE1NUB6
dGUuY29tLmNuPg0KPiBTaWduZWQtb2ZmLWJ5OiBXYW5nIEd1YW5nIDx3YW5nLmd1YW5nNTVAenRl
LmNvbS5jbj4NCj4gLS0tDQo+ICBpbmNsdWRlL3N5c2VtdS9pb3RocmVhZC5oIHwgIDQgKysrKw0K
PiAgaW90aHJlYWQuYyAgICAgICAgICAgICAgICB8IDQ1ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25z
KCspDQoNClJldmlld2VkLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+

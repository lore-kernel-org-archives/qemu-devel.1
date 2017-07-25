Received: from eggs.gnu.org ([2001:4830:134:3::10]:42585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dZoFt-0005re-Q0
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 21:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dZoFp-0006Cg-LD
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 21:03:21 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:60822)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dZoFo-0006Bp-M9
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 21:03:17 -0400
Date: Tue, 25 Jul 2017 09:02:59 +0800 (CST)
Message-ID: <201707250902596770211@zte.com.cn>
References: 201707241838172813942@zte.com.cn,
	effe3acf-9471-97cc-793d-5826c19f422b@redhat.com
Mime-Version: 1.0
From: <wang.yong155@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCHv2_02/04=5D_colo-compare=3A_Proce?=
 =?utf-8?q?sspactkets_in_the_IOThreadofthe_primary?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: stefanha@redhat.com, jasowang@redhat.com, marcandre.lureau@gmail.com, zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.guang55@zte.com.cn

Pk9uIDI0LzA3LzIwMTcgMTI6MzgsIHdhbmcueW9uZzE1NUB6dGUuY29tLmNuIHdyb3RlOg0KDQo+
PiBmaW5hbGx5IHVzZSBnX21haW5fbG9vcF9ydW4gdG8gcmVwbGFjZSBhaW9fcG9sbCAgaW4gdGhl
DQoNCj4+IGlvdGhyZWFkX3J1biBmdW5jdGlvbi4NCg0KPg0KDQo+VGhhdCB3b3VsZCBtYWtlIHRo
ZSBwZXJmb3JtYW5jZSBvZiB2aXJ0aW8tYmxrIHdpdGggaW90aHJlYWRzIHdvcnNlLA0KDQo+dW5m
b3J0dW5hdGVseS4gIGFpb19wb2xsIGlzIG11Y2ggbW9yZSBvcHRpbWl6ZWQgdGhhbiBnX21haW5f
bG9vcF9ydW4uDQoNCkhpIFBhb2xvLA0KDQpBbnkgb3RoZXIgZ29vZCBpZGVhIHRvIGFjaGlldmUg
dGhpcz8NCg0KDQoNCg0KVGhhbmtzDQoNCg0KDQoNCj4NCg0KPlBhb2xvDQoNCj4NCg0KPj4gQWZ0
ZXIgdGhhdCBJT1RocmVhZA0KDQo+PiBydW5zIHRoZSBHTWFpbkNvbnRleHQgZXZlbnQgbG9vcCxj
aGFyZGV2IGFuZCBJT1RocmVhZCBjYW4gd29yayB0b2dldGhlci4NCg0KPj4gDQoNCj4+IEhvdyBh
Ym91dCBpdD8gSWYgZmVhc2libGUsIEkgd2lsbCB0cnkgdG8gc3VibWl0IA0KDQoNCg0KDQoNCg0K
DQoNCg0KDQoNCg0K5Y6f5aeL6YKu5Lu2DQoNCg0KDQrlj5Hku7bkurrvvJogPHBib256aW5pQHJl
ZGhhdC5jb20+DQrmlLbku7bkurrvvJrnjovli4cxMDE3MDUzMCA8c3RlZmFuaGFAcmVkaGF0LmNv
bT4gPGphc293YW5nQHJlZGhhdC5jb20+IDxtYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbT4NCuaK
hOmAgeS6uu+8miA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPiA8emhhbmdjaGVuLmZu
c3RAY24uZnVqaXRzdS5jb20+IDxsaXpoaWppYW5AY24uZnVqaXRzdS5jb20+IDxxZW11LWRldmVs
QG5vbmdudS5vcmc+546L5bm/MTAxNjU5OTINCuaXpSDmnJ8g77yaMjAxN+W5tDA35pyIMjTml6Ug
MTk6NTkNCuS4uyDpopgg77yaUmU6IFtQQVRDSHYyIDAyLzA0XSBjb2xvLWNvbXBhcmU6IFByb2Nl
c3NwYWN0a2V0cyBpbiB0aGUgSU9UaHJlYWRvZnRoZSBwcmltYXJ5DQoNCg0KDQoNCg0KT24gMjQv
MDcvMjAxNyAxMjozOCwgd2FuZy55b25nMTU1QHp0ZS5jb20uY24gd3JvdGU6DQo+IGZpbmFsbHkg
dXNlIGdfbWFpbl9sb29wX3J1biB0byByZXBsYWNlIGFpb19wb2xsICBpbiB0aGUNCj4gaW90aHJl
YWRfcnVuIGZ1bmN0aW9uLg0KDQpUaGF0IHdvdWxkIG1ha2UgdGhlIHBlcmZvcm1hbmNlIG9mIHZp
cnRpby1ibGsgd2l0aCBpb3RocmVhZHMgd29yc2UsDQp1bmZvcnR1bmF0ZWx5LiAgYWlvX3BvbGwg
aXMgbXVjaCBtb3JlIG9wdGltaXplZCB0aGFuIGdfbWFpbl9sb29wX3J1bi4NCg0KUGFvbG8NCg0K
PiBBZnRlciB0aGF0IElPVGhyZWFkDQo+IHJ1bnMgdGhlIEdNYWluQ29udGV4dCBldmVudCBsb29w
LGNoYXJkZXYgYW5kIElPVGhyZWFkIGNhbiB3b3JrIHRvZ2V0aGVyLg0KPiANCj4gSG93IGFib3V0
IGl0PyBJZiBmZWFzaWJsZSwgSSB3aWxsIHRyeSB0byBzdWJtaXQgYSBwYXRjaC4=

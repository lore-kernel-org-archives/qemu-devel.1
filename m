Received: from eggs.gnu.org ([2001:4830:134:3::10]:49486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dZalj-0004S4-U5
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dZalg-0005X7-M5
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:39:19 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:41637)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dZalf-0005S7-Ge
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:39:16 -0400
Date: Mon, 24 Jul 2017 18:38:17 +0800 (CST)
Message-ID: <201707241838172813942@zte.com.cn>
References: 201706131924483092713@zte.com.cn,
	20170616092004.GF31462@stefanha-x1.localdomain
Mime-Version: 1.0
From: <wang.yong155@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCHv2_02/04=5D_colo-compare=3A_Proce?=
 =?utf-8?q?sspactkets_in_the_IOThread_ofthe_primary?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, marcandre.lureau@gmail.com
Cc: zhang.zhanghailiang@huawei.com, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.guang55@zte.com.cn

Pk9uIFRodSwgSnVuIDE1LCAyMDE3IGF0IDEyOjIzOjI3UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6DQoNCj4+IFBhb2xvLCBNYXJjIGFuZCBTdGVmYW46DQoNCj4+IA0KDQo+PiBXZSB3YW50IGxl
dCBjaGFyZGV2IGZyb250LWVuZCBydW4gaW4gY29sbyBjb21wYXJpbmcgSU9UaHJlYWQuIFRoaXMg
bG9va3Mgbm90DQoNCj4+IHN1cHBvcnRlZCBieSBjdXJyZW50IGNoYXJkZXYgZnJvbnRlbmQgQVBJ
LiBBbnkgaWRlYS9zdWdnZXN0aW9uIG9uIGhvdyB0bw0KDQo+PiBhY2hpZXZlIHRoaXM/DQoNCj4N
Cg0KPkEgZm9sbG93LXVwOg0KDQo+DQoNCj5JIGp1c3Qgbm90aWNlZCB0aGF0IGlvLyBzdXBwb3J0
cyBBaW9Db250ZXh0Lg0KDQo+DQoNCj5UaGlzIG1lYW5zIGEgZGlmZmVyZW50IGFwcHJvYWNoIGlz
IHRvIGFkZCBBaW9Db250ZXh0IHN1cHBvcnQgdG8gdGhlDQoNCj5jaGFyZGV2IEFQSSBzbyB0aGF0
IGVpdGhlciBHTWFpbkNvbnRleHQgb3IgQWlvQ29udGV4dCBjYW4gYmUgdXNlZC4NCg0KSGkgU3Rl
ZmFuLA0KDQpJT1RocmVhZCBkb2VzIG5vdCBydW4gYSBHTWFpbkNvbnRleHQsIEkgdGhpbmsgd2Ug
Y2FuIGNyZWF0ZSBhIG5ldyBHTWFpbkNvbnRleHQNCg0KaW4gdGhlIElPVGhyZWFkIGFuZCBhdHRh
Y2ggSU9UaHJlYWQncyBBaW9Db250ZXh0IHRvIHRoZSBHTWFpbkNvbnRleHQgLCANCg0KZmluYWxs
eSB1c2UgZ19tYWluX2xvb3BfcnVuIHRvIHJlcGxhY2UgYWlvX3BvbGwgIGluIHRoZSBpb3RocmVh
ZF9ydW4gZnVuY3Rpb24uDQoNCkFmdGVyIHRoYXQgSU9UaHJlYWQgcnVucyB0aGUgR01haW5Db250
ZXh0IGV2ZW50IGxvb3AsY2hhcmRldiBhbmQgSU9UaHJlYWQgY2FuIHdvcmsgdG9nZXRoZXIuDQoN
CkhvdyBhYm91dCBpdD8gSWYgZmVhc2libGUsIEkgd2lsbCB0cnkgdG8gc3VibWl0IGEgcGF0Y2gu
DQoNCg0KDQoNClRoYW5rcw0KDQo+DQoNCj5BZ2FpbiwgSSdtIG5vdCBzdXJlIGhvdyBmZWFzaWJs
ZSB0aGlzIGlzLg0KDQo+DQoNCj5TdGVmYW4NCg0KDQoNCg0KDQoNCg0KDQoNCg0KDQoNCuWOn+Wn
i+mCruS7tg0KDQoNCg0K5Y+R5Lu25Lq677yaIDxzdGVmYW5oYUByZWRoYXQuY29tPg0K5pS25Lu2
5Lq677yaIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0K5oqE6YCB5Lq677ya546L5YuHMTAxNzA1MzAg
PHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT4gPHpoYW5nY2hlbi5mbnN0QGNuLmZ1aml0
c3UuY29tPiA8bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tPiA8cWVtdS1kZXZlbEBub25nbnUub3Jn
PueOi+W5vzEwMTY1OTkyIDxwYm9uemluaUByZWRoYXQuY29tPiA8bWFyY2FuZHJlLmx1cmVhdUBn
bWFpbC5jb20+DQrml6Ug5pyfIO+8mjIwMTflubQwNuaciDE25pelIDE3OjIwDQrkuLsg6aKYIO+8
mlJlOiDnrZTlpI06IFJlOiDnrZTlpI06IFJlOiBbUEFUQ0h2MiAwMi8wNF0gY29sby1jb21wYXJl
OiBQcm9jZXNzcGFjdGtldHMgaW4gdGhlIElPVGhyZWFkIG9mdGhlIHByaW1hcnkNCg0KDQoNCg0K
DQpPbiBUaHUsIEp1biAxNSwgMjAxNyBhdCAxMjoyMzoyN1BNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOg0KPiBQYW9sbywgTWFyYyBhbmQgU3RlZmFuOg0KPiANCj4gV2Ugd2FudCBsZXQgY2hhcmRl
diBmcm9udC1lbmQgcnVuIGluIGNvbG8gY29tcGFyaW5nIElPVGhyZWFkLiBUaGlzIGxvb2tzIG5v
dA0KPiBzdXBwb3J0ZWQgYnkgY3VycmVudCBjaGFyZGV2IGZyb250ZW5kIEFQSS4gQW55IGlkZWEv
c3VnZ2VzdGlvbiBvbiBob3cgdG8NCj4gYWNoaWV2ZSB0aGlzPw0KDQpBIGZvbGxvdy11cDoNCg0K
SSBqdXN0IG5vdGljZWQgdGhhdCBpby8gc3VwcG9ydHMgQWlvQ29udGV4dC4NCg0KVGhpcyBtZWFu
cyBhIGRpZmZlcmVudCBhcHByb2FjaCBpcyB0byBhZGQgQWlvQ29udGV4dCBzdXBwb3J0IHRvIHRo
ZQ0KY2hhcmRldiBBUEkgc28gdGhhdCBlaXRoZXIgR01haW5Db250ZXh0IG9yIEFpb0NvbnRleHQg
Y2FuIGJlIHVzZWQuDQoNCkFnYWluLCBJJ20gbm90IHN1cmUgaG93IGZlYXNpYmxlIHRoaXMgaXMu
DQoNClN0ZWZhbg==

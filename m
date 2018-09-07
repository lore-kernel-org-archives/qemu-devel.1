Received: from eggs.gnu.org ([2001:4830:134:3::10]:51996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fyAFm-0003SR-1T
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fyAFi-0003fr-P8
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:28:25 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:33710 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fyAFi-0003TW-CG
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 02:28:22 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Fri, 7 Sep 2018 06:27:59 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302CED816@DGGEMM529-MBX.china.huawei.com>
References: <D9DE8DBB19F2A24080482022C1DE758302CED514@DGGEMM529-MBX.china.huawei.com>
	<20180906120404.zuvf3kkgmzwkb6a3@sirius.home.kraxel.org>
	<D9DE8DBB19F2A24080482022C1DE758302CED55C@DGGEMM529-MBX.china.huawei.com>
	<20180906135223.fy5bsibinxqdhp7t@sirius.home.kraxel.org>
	<9cc5ff6.583e8.165af44797e.Coremail.linzc@zju.edu.cn>
	<20180907062307.f7dnpvbok37ztkvo@sirius.home.kraxel.org>
In-Reply-To: <20180907062307.f7dnpvbok37ztkvo@sirius.home.kraxel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Some confusion about live migration of usb device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gerd hoffmann <kraxel@redhat.com>, CheneyLin <linzc@zju.edu.cn>
Cc: "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZ2VyZCBob2ZmbWFubiBb
bWFpbHRvOmtyYXhlbEByZWRoYXQuY29tXQ0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAwNywg
MjAxOCAyOjIzIFBNDQo+IFRvOiBDaGVuZXlMaW4gPGxpbnpjQHpqdS5lZHUuY24+DQo+IENjOiBs
aW56aGVjaGVuZyA8bGluemhlY2hlbmdAaHVhd2VpLmNvbT47IHdhbmd4aW4gKFUpDQo+IDx3YW5n
eGlueGluLndhbmdAaHVhd2VpLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJqZWN0
OiBSZTogW1FlbXUtZGV2ZWxdIFNvbWUgY29uZnVzaW9uIGFib3V0IGxpdmUgbWlncmF0aW9uIG9m
IHVzYiBkZXZpY2UNCj4gDQo+IE9uIFRodSwgU2VwIDA2LCAyMDE4IGF0IDEwOjIzOjQ1UE0gKzA4
MDAsIENoZW5leUxpbiB3cm90ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0t5Y6f5aeL6YKu
5Lu2LS0tLS0NCj4gPiA+IOWPkeS7tuS6ujogImdlcmQgaG9mZm1hbm4iIDxrcmF4ZWxAcmVkaGF0
LmNvbT4NCj4gPiA+IOWPkemAgeaXtumXtDogMjAxOC0wOS0wNiAyMTo1MjoyMyAo5pif5pyf5Zub
KQ0KPiA+ID4g5pS25Lu25Lq6OiBsaW56aGVjaGVuZyA8bGluemhlY2hlbmdAaHVhd2VpLmNvbT4N
Cj4gPiA+IOaKhOmAgTogIndhbmd4aW4gKFUpIiA8d2FuZ3hpbnhpbi53YW5nQGh1YXdlaS5jb20+
LCBDaGVuZXlMaW4NCj4gPiA+IDxsaW56Y0B6anUuZWR1LmNuPiwgInFlbXUtZGV2ZWxAbm9uZ251
Lm9yZyIgPHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4NCj4gPiA+IOS4u+mimDogUmU6IFtRZW11LWRl
dmVsXSBTb21lIGNvbmZ1c2lvbiBhYm91dCBsaXZlIG1pZ3JhdGlvbiBvZiB1c2INCj4gPiA+IGRl
dmljZQ0KPiA+ID4NCj4gPiA+IE9uIFRodSwgU2VwIDA2LCAyMDE4IGF0IDEyOjEwOjA4UE0gKzAw
MDAsIGxpbnpoZWNoZW5nIHdyb3RlOg0KPiA+ID4gPiBZb3UgaGFkIHNhaWQgdGhhdCBjb3B5aW5n
IHZtc3RhdGUgb2YgdXNiLWhvc3QgaXMgcG9pbnRsZXNzLCBzbw0KPiA+ID4gPiBqdXN0IHVucHVs
ZyBhbmQgcGx1ZyBpdCBhZnRlciBtaWdyYXRpb24gaXMgYWxsIHJpZ2h0LCAgYnV0IHdpbGwgb3Ro
ZXIgdXNiDQo+IGRldmljZXMgbGlrZSB1c2Itc3RvcmFnZSBkZXZpY2VzIGxvc2UgcGVuZGluZyBV
U0JQYWNrZXRzIHRoZW4/DQo+ID4gPg0KPiA+ID4gQWgsIGVtdWxhdGVkIHVzYiBkZXZpY2VzLiAg
VGhlIHVzYiBob3N0IGFkYXB0ZXJzIHdpbGwgcmUtc3VibWl0IGFueQ0KPiA+ID4gdW5maW5pc2hl
ZCB1c2IgdHJhbnNmZXJzIG9uIHRoZSB0YXJnZXQgbWFjaGluZS4NCj4gPiBZb3UgbWVhbiB0YXJn
ZXQgdm0gdXNiIGNvbnRyb2xsZXJzIHdpbGwgcmUtc3VibWl0IHRoZW0/DQo+IA0KPiBZZXMuDQo+
IA0KPiA+IEFuZCB3aGF0IGFib3V0IHVzYi1yZWRpciwgYnR3Pw0KPiANCj4gQmFzaWNhbGx5IHRo
ZSBzYW1lLiAgQnV0IHNvbWUgZXh0cmEgY2FyZSBpcyBuZWVkZWQgdG8gbWFrZSBzdXJlIHRoZSBw
aHlzaWNhbA0KPiBkZXZpY2Ugd2lsbCBub3Qgc2VlIHJlcXVlc3RzIHR3aWNlIHdoZW4gdGhlIHRh
cmdldCBzdGFydHMgcmVwbGF5aW5nIHVuZmluaXNoZWQNCj4gcmVxdWVzdHMuICBBbGwgdXNiIHJl
cXVlc3RzIGdldCBhIHVuaXF1ZSB0YWcNCj4gKFVTQlBhY2tldC0+aWQpIHNvIHRoZSB1c2JyZWRp
ciBzZXJ2ZXIgKHR5cGljYWxseSBzcGljZSBjbGllbnQpIGhhcyBhIGNoYW5jZSB0bw0KPiBoYW5k
bGUgdGhpcyBjb3JyZWN0bHkuDQpJIGdvdCBpdCEgVGhhbmsgeW91IGZvciBwYXRpZW50bHkgYW5z
d2VyaW5nIG15IHF1ZXN0aW9ucy4NCj4gDQo+IGNoZWVycywNCj4gICBHZXJkDQoNCg==

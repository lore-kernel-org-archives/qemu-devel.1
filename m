Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3E3C76186
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF372075C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 03:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF372075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqUIB-0002xS-KB
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 23:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39485)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hqUI0-0002ZG-EY
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hqUHz-0007l0-4K
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:19:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2483 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <oscar.zhangbo@huawei.com>)
 id 1hqUHy-0007hY-QB
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 23:19:31 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id B3B635D909CA58C79098;
 Thu, 25 Jul 2019 11:19:23 +0800 (CST)
Received: from DGGEML421-HUB.china.huawei.com (10.1.199.38) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 25 Jul 2019 11:19:21 +0800
Received: from DGGEML509-MBX.china.huawei.com ([169.254.1.213]) by
 dggeml421-hub.china.huawei.com ([10.1.199.38]) with mapi id 14.03.0439.000;
 Thu, 25 Jul 2019 11:19:12 +0800
From: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: CC wangxiongfeng. : RE: [PATCH] pcie: fix device hotplug
 failure at the meantime of VM boot
Thread-Index: AdVCl7gS0TqQMz47ToirPvNCaC/XMw==
Date: Thu, 25 Jul 2019 03:19:11 +0000
Message-ID: <0259E1C966E8C54AA93AA2B1240828E672DF606C@dggeml509-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.17.158]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.188
Subject: [Qemu-devel] CC wangxiongfeng. : RE: [PATCH] pcie: fix device
 hotplug failure at the meantime of VM boot
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fangying <fangying1@huawei.com>,
 "wangxiongfeng \(C\)" <wangxiongfeng2@huawei.com>,
 "limingwang \(A\)" <limingwang@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pj4gSWYgdGhlIFBDSV9FWFBfTE5LU1RBX0RMTExBIGNhcGFiaWxpdHkgaXMgc2V0IGJ5IGRlZmF1
bHQsIGxpbnV4IGtlcm5lbCB3aWxsIHNlbmQNCj4+IFBEQyBldmVudCB0byBkZXRlY3Qgd2hldGhl
ciB0aGVyZSBpcyBhIGRldmljZSBpbiBwY2llIHNsb3QuIElmIGEgZGV2aWNlIGlzIHBsdWdlZA0K
Pj4gaW4gdGhlIHBjaWUtcm9vdC1wb3J0IGF0IHRoZSBzYW1lIHRpbWUsIGhvdC1wbHVnIGRldmlj
ZSB3aWxsIHNlbmQgQUJQICsgUERDDQo+PiBldmVudHMgdG8gdGhlIGtlcm5lbC4gVGhlIFZNIGtl
cm5lbCB3aWxsIHdyb25nbHkgdW5wbHVnIHRoZSBkZXZpY2UgaWYgdHdvIFBEQw0KPj4gZXZlbnRz
IGdldCB0b28gY2xvc2UuIFRodXMgd2UnZCBiZXR0ZXIgc2V0IHRoZSBQQ0lfRVhQX0xOS1NUQV9E
TExMQQ0KPj4gY2FwYWJpbGl0eSBvbmx5IGluIGhvdHBsdWcgY2FsbGJhY2suDQo+DQo+Q291bGQg
eW91IHBsZWFzZSBkZXNjcmliZSBhIHJlcHJvZHVjZXIgaW4gYSBiaXQgbW9yZSBkZXRhaWw/DQo+
DQpTdGVwMTogc3RhcnQgYSBWTSB3aXRoIHFlbXUsIHRoZSBWTSBib290cyB1cCB3aXRoaW4gNTAw
bXMuDQogIC9wYXRoL3RvL3FlbXUtMi44LjEvYWFyY2g2NC1zb2Z0bW11L3FlbXUtc3lzdGVtLWFh
cmNoNjQgXA0KICAtbmFtZSB0ZXN0LWM2NTk2MTY1MjYzOWNjZjljZTBiODQ3NmEzMjU0MjE4MTFk
NGZkYzg3M2U5MGMyNzE2ODQ5N2JjOWUyMDQ3NzYgXA0KICAtdXVpZCBhOGVkNGE4Ni0zZjQ5LTQ1
YTMtYThjZS0yOGQ2MWIyZjI5MTQgXA0KICAtbWFjaGluZSB2aXJ0LHVzYj1vZmYsYWNjZWw9a3Zt
LGdpYy12ZXJzaW9uPTMgXA0KICAtY3B1IGhvc3QgXA0KICAtbSAyMDQ4TSxzbG90cz0xMCxtYXht
ZW09MjM5NDc3TSBcDQogIC1xbXAgdW5peDovdmFyL3J1bi9xbXAuc29jayxzZXJ2ZXIsbm93YWl0
IFwNCiAgLWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4OCxjaGFzc2lzPTEsaWQ9cGNpLjEs
YnVzPXBjaWUuMCxtdWx0aWZ1bmN0aW9uPW9uLGFkZHI9MHgxIFwNCiAgLWRldmljZSBwY2llLXJv
b3QtcG9ydCxwb3J0PTB4OSxjaGFzc2lzPTIsaWQ9cGNpLjIsYnVzPXBjaWUuMCxhZGRyPTB4MS4w
eDEgXA0KICAtZGV2aWNlIHBjaWUtcm9vdC1wb3J0LHBvcnQ9MHhhLGNoYXNzaXM9MyxpZD1wY2ku
MyxidXM9cGNpZS4wLGFkZHI9MHgxLjB4MiBcDQogIC1kZXZpY2UgcGNpZS1yb290LXBvcnQscG9y
dD0weGIsY2hhc3Npcz00LGlkPXBjaS40LGJ1cz1wY2llLjAsYWRkcj0weDEuMHgzIFwNCiAgLWRl
dmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4YyxjaGFzc2lzPTUsaWQ9cGNpLjUsYnVzPXBjaWUu
MCxhZGRyPTB4MS4weDQgXA0KICAtZGV2aWNlIHBjaWUtcm9vdC1wb3J0LHBvcnQ9MHhkLGNoYXNz
aXM9NixpZD1wY2kuNixidXM9cGNpZS4wLGFkZHI9MHgxLjB4NSBcDQogIC1kZXZpY2UgcGNpZS1y
b290LXBvcnQscG9ydD0weGUsY2hhc3Npcz03LGlkPXBjaS43LGJ1cz1wY2llLjAsYWRkcj0weDEu
MHg2IFwNCiAgLWRldmljZSBwY2llLXBjaS1icmlkZ2UsaWQ9cGNpLjgsYnVzPXBjaS4xLGFkZHI9
MHgwIFwNCiAgLWRldmljZSBwY2llLXJvb3QtcG9ydCxwb3J0PTB4ZixjaGFzc2lzPTksaWQ9cGNp
LjksYnVzPXBjaWUuMCxhZGRyPTB4MS4weDcgXA0KICAuLi4uLi4uDQogIA0KU3RlcDI6IEltbWVk
aWF0ZWx5IGhvdHBsdWcgYSBwY2llIGRldmljZToNCiAgcW1wX21zZz0neyAiZXhlY3V0ZSI6ICJx
bXBfY2FwYWJpbGl0aWVzIiB9DQp7ImFyZ3VtZW50cyI6eyJhZGRyIjoiMHgwIiwiYnVzIjoicGNp
LjQiLCJkcml2ZXIiOiJ2aXJ0aW8tbmV0LXBjaSIsImlkIjoidmlydGlvLWUxMzU2ODAyLTRiOWYt
NDRiYi1iOGYwLTVmOThiZjc2NTgyMyIsIm1hYyI6IjAyOjQyOjIwOjZlOmEyOjU5In0sImV4ZWN1
dGUiOiJkZXZpY2VfZGVsIn0NCnsiYXJndW1lbnRzIjp7ImlkIjoibmV0cG9ydF90ZXN0XzEiLCJp
Zm5hbWUiOiJuZnNfdGFwIn0sImV4ZWN1dGUiOiJuZXRkZXZfZGVsIn0nDQoNCiAgZWNobyAkcW1w
X21zZyB8IG5jIC1VIC92YXIvcnVuL3FtcC5zb2NrDQoNClJlc3VsdCBleHBlY3RlZDogIGhvdHBs
dWcgc3VjY2Vzc2Z1bCwgdGhlIHBjaWUgZGV2aWNlIGNvdWxkIGJlIHNlZW4gaW5zaWRlIHRoZSBW
TQ0KDQpSZXN1bHQgaW4gZmFjdDogd2UgZm91bmQgYSAiaG90cGx1ZyIgYW5kICJ1bnBsdWciIG1l
c3NhZ2UgaW5zaWRlIHRoZSBWTSwgaXQgZmFpbGVkIGluIGhvdHBsdWcuDQoNCj4NCj4+DQo+PiBC
eSB0aGUgd2F5LCB3ZSBzaG91bGQgY2xlYW4gdXAgdGhlIFBDSV9FWFBfTE5LU1RBX0RMTExBIGNh
cGFiaWxpdHkgZHVyaW5nDQo+PiB1bnBsdWcgdG8gYXZvaWQgVk0gcmVzdGFydCBvciBtaWdyYXRp
b24gZmFpbHVyZSB3aGljaCB3aWxsIGVudGVyIHRoZSBzYW1lDQo+PiBhYm5vcm1hbCBzY2VuYXJp
byBhcyBhYm92ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBsaW1pbmd3YW5nQGh1YXdlaS5jb20N
Cj4+IFNpZ25lZC1vZmYtYnk6IGZhbmd5aW5nMUBodWF3ZWkuY29tDQo+PiBTaWduZWQtb2ZmLWJ5
OiBvc2Nhci56aGFuZ2JvQGh1YXdlaS5jb20NCj4NCj5TbyBsb29raW5nIGF0IGxpbnV4IEkgc2Vl
Og0KPg0KPiAqIHBjaWVocF9jYXJkX3ByZXNlbnRfb3JfbGlua19hY3RpdmUoKSAtIHdoZXRoZXIg
Z2l2ZW4gc2xvdCBpcyBvY2N1cGllZA0KPiAqIEBjdHJsOiBQQ0llIGhvdHBsdWcgY29udHJvbGxl
cg0KPiAqDQo+ICogVW5saWtlIHBjaWVocF9jYXJkX3ByZXNlbnQoKSwgd2hpY2ggZGV0ZXJtaW5l
cyBwcmVzZW5jZSBzb2xlbHkgZnJvbSB0aGUNCj4gKiBQcmVzZW5jZSBEZXRlY3QgU3RhdGUgYml0
LCB0aGlzIGhlbHBlciBhbHNvIHJldHVybnMgdHJ1ZSBpZiB0aGUgTGluayBBY3RpdmUNCj4gKiBi
aXQgaXMgc2V0LiAgVGhpcyBpcyBhIGNvbmNlc3Npb24gdG8gYnJva2VuIGhvdHBsdWcgcG9ydHMg
d2hpY2ggaGFyZHdpcmUNCj4gKiBQcmVzZW5jZSBEZXRlY3QgU3RhdGUgdG8gemVybywgc3VjaCBh
cyBXaWxvY2l0eSdzIFsxYWU5OjAyMDBdLg0KPg0KPnNvIGl0IGxvb2tzIGxpa2UgbGludXggYWN0
dWFsbHkgbG9va3MgYXQgcHJlc2VuY2UgZGV0ZWN0IHN0YXRlLA0KPmJ1dCB3ZSBoYXZlIGEgYnVn
IGp1c3QgbGlrZSBXaWxvY2l0eSdzIGFuZCBrZWVwaW5nDQo+bGluayBhY3RpdmUgdXAgZml4ZXMg
dGhhdC4gQ2FuJ3Qgd2UgZml4IHRoZSBidWcgaW5zdGVhZD8NCj4NCkB3YW5neGlvbmdmZW5nIA0K
Pj4gLS0tDQo+PiAgaHcvcGNpL3BjaWUuYyB8IDkgKysrKystLS0tDQo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
aHcvcGNpL3BjaWUuYyBiL2h3L3BjaS9wY2llLmMNCj4+IGluZGV4IGE2YmViNTYuLjE3NGYzOTIg
MTAwNjQ0DQo+PiAtLS0gYS9ody9wY2kvcGNpZS5jDQo+PiArKysgYi9ody9wY2kvcGNpZS5jDQo+
PiBAQCAtNzUsMTAgKzc1LDYgQEAgcGNpZV9jYXBfdjFfZmlsbChQQ0lEZXZpY2UgKmRldiwgdWlu
dDhfdCBwb3J0LCB1aW50OF90DQo+dHlwZSwgdWludDhfdCB2ZXJzaW9uKQ0KPj4NCj5RRU1VX1BD
SV9FWFBfTE5LU1RBX05MVyhRRU1VX1BDSV9FWFBfTE5LX1gxKSB8DQo+Pg0KPlFFTVVfUENJX0VY
UF9MTktTVEFfQ0xTKFFFTVVfUENJX0VYUF9MTktfMl81R1QpKTsNCj4+DQo+PiAtICAgIGlmIChk
ZXYtPmNhcF9wcmVzZW50ICYgUUVNVV9QQ0lFX0xOS1NUQV9ETExMQSkgew0KPj4gLSAgICAgICAg
cGNpX3dvcmRfdGVzdF9hbmRfc2V0X21hc2soZXhwX2NhcCArIFBDSV9FWFBfTE5LU1RBLA0KPj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJX0VYUF9MTktTVEFfRExMTEEp
Ow0KPj4gLSAgICB9DQo+Pg0KPj4gICAgICAvKiBXZSBjaGFuZ2VkIGxpbmsgc3RhdHVzIGJpdHMg
b3ZlciB0aW1lLCBhbmQgY2hhbmdpbmcgdGhlbSBhY3Jvc3MNCj4+ICAgICAgICogbWlncmF0aW9u
cyBpcyBnZW5lcmFsbHkgZmluZSBhcyBoYXJkd2FyZSBjaGFuZ2VzIHRoZW0gdG9vLg0KPg0KPkRv
ZXMgdGhpcyBhY3R1YWxseSBjaGFuZ2UgYW55dGhpbmc/DQo+DQo+SSBkb24ndCBrbm93IHdoeSBk
byB3ZSBib3RoZXIgc2V0dGluZyBpdCBoZXJlIGJ1dCB3ZSBkbw0KPnNldCBpdCBsYXRlciBpbiBw
Y2llX2NhcF9zbG90X3BsdWdfY2IsIGNvcnJlY3Q/DQo+DQo+SSdkIGxpa2UgdG8gdW5kZXJzdGFu
ZCB3aGV0aGVyIHRoaXMgaXMgcGFydCBvZiBmaXggb3INCj5qdXN0IGEgY2xlYW51cC4NCj4NCj4N
Cj4+IEBAIC00ODQsNiArNDgwLDExIEBAIHZvaWQNCj5wY2llX2NhcF9zbG90X3VucGx1Z19yZXF1
ZXN0X2NiKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2RldiwNCj4+ICAgICAgICAgIHJldHVybjsN
Cj4+ICAgICAgfQ0KPj4NCj4+ICsgICAgaWYgKHBjaV9kZXYtPmNhcF9wcmVzZW50ICYgUUVNVV9Q
Q0lFX0xOS1NUQV9ETExMQSkgew0KPj4gKyAgICAgICAgcGNpX3dvcmRfdGVzdF9hbmRfY2xlYXJf
bWFzayhleHBfY2FwICsgUENJX0VYUF9MTktTVEEsDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFBDSV9FWFBfTE5LU1RBX0RMTExBKTsNCj4+ICsgICAgfQ0KPj4gKw0K
Pj4gICAgICBwY2llX2NhcF9zbG90X3B1c2hfYXR0ZW50aW9uX2J1dHRvbihQQ0lfREVWSUNFKGhv
dHBsdWdfZGV2KSk7DQo+PiAgfQ0KPg0KPlNvIHRoaXMgcmVwb3J0cyBkYXRhIGxpbmsgaW5hY3Rp
dmUgaW1tZWRpYXRlbHkgYWZ0ZXINCj51bnBsdWcgcmVxdWVzdC4gU2VlbXMgYSBiaXQgcXVlc3Rp
b25hYmxlOiBndWVzdCBkaWQgbm90DQo+cmVzcG9uZCB5ZXQuIEknZCBsaWtlIHRvIHNlZSBhIGNv
bW1lbnQgZXhwbGFpbmluZyB3aHkNCj50aGlzIG1ha2VzIHNlbnNlLg0KPg0KPg0KPj4gLS0NCj4+
IDEuOC4zLjENCg==


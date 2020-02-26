Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C78BC4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 06:36:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E515206E2
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 06:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E515206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6qJP-00044Q-8n
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 01:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6qId-000358-V7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 01:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6qIc-00029M-Q2
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 01:36:03 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2070 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j6qIY-0001vS-Uc; Wed, 26 Feb 2020 01:35:59 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 3D3F2FAAF39E4F860F97;
 Wed, 26 Feb 2020 14:35:49 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Feb 2020 14:35:44 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.163]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0439.000;
 Wed, 26 Feb 2020 14:35:38 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH] hw/net/imx_fec: write TGSR and TCSR3 in imx_enet_write()
Thread-Topic: [PATCH] hw/net/imx_fec: write TGSR and TCSR3 in imx_enet_write()
Thread-Index: AQHV64ecnD2knEVSV0edVn6KHPMEf6gq31MAgABNfACAARiLAIAAvtHw
Date: Wed, 26 Feb 2020 06:35:37 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B662AA1@dggemm531-mbx.china.huawei.com>
References: <20200225025923.19328-1-kuhn.chenqun@huawei.com>
 <9206dda7-0e12-b68e-87ca-1985b61381bc@redhat.com>
 <CAFEAcA-W+brVEmGr29i6JO4GFrnoLAce-qoMQpQc56x6B4BY3A@mail.gmail.com>
 <9fc2581c-56a1-0969-6a13-1454a1865264@redhat.com>
In-Reply-To: <9fc2581c-56a1-0969-6a13-1454a1865264@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.205.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.189
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBKYXNvbiBXYW5nIFttYWlsdG86
amFzb3dhbmdAcmVkaGF0LmNvbV0NCj5TZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI2LCAyMDIw
IDExOjAzIEFNDQo+VG86IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4N
Cj5DYzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPjsgUUVNVSBEZXZl
bG9wZXJzDQo+PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz47IFFFTVUgVHJpdmlhbCA8cWVtdS10cml2
aWFsQG5vbmdudS5vcmc+Ow0KPlpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVh
d2VpLmNvbT47IFBldGVyIENodWJiDQo+PHBldGVyLmNodWJiQG5pY3RhLmNvbS5hdT47IHFlbXUt
YXJtIDxxZW11LWFybUBub25nbnUub3JnPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh3L25ldC9p
bXhfZmVjOiB3cml0ZSBUR1NSIGFuZCBUQ1NSMyBpbg0KPmlteF9lbmV0X3dyaXRlKCkNCj4NCj4N
Cj5PbiAyMDIwLzIvMjUg5LiL5Y2INjoxOCwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4+IE9uIFR1
ZSwgMjUgRmViIDIwMjAgYXQgMDU6NDEsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOg0KPj4+DQo+Pj4gT24gMjAyMC8yLzI1IOS4iuWNiDEwOjU5LCBDaGVuIFF1biB3cm90
ZToNCj4+Pj4gVGhlIGN1cnJlbnQgY29kZSBjYXVzZXMgY2xhbmcgc3RhdGljIGNvZGUgYW5hbHl6
ZXIgZ2VuZXJhdGUgd2FybmluZzoNCj4+Pj4gaHcvbmV0L2lteF9mZWMuYzo4NTg6OTogd2Fybmlu
ZzogVmFsdWUgc3RvcmVkIHRvICd2YWx1ZScgaXMgbmV2ZXIgcmVhZA0KPj4+PiAgICAgICAgICAg
dmFsdWUgPSB2YWx1ZSAmIDB4MDAwMDAwMGY7DQo+Pj4+ICAgICAgICAgICBeICAgICAgIH5+fn5+
fn5+fn5+fn5+fn5+fg0KPj4+PiBody9uZXQvaW14X2ZlYy5jOjg2NDo5OiB3YXJuaW5nOiBWYWx1
ZSBzdG9yZWQgdG8gJ3ZhbHVlJyBpcyBuZXZlciByZWFkDQo+Pj4+ICAgICAgICAgICB2YWx1ZSA9
IHZhbHVlICYgMHgwMDAwMDBmZDsNCj4+Pj4gICAgICAgICAgIF4gICAgICAgfn5+fn5+fn5+fn5+
fn5+fn5+DQo+Pj4+DQo+Pj4+IEFjY29yZGluZyB0byB0aGUgZGVmaW5pdGlvbiBvZiB0aGUgZnVu
Y3Rpb24sIHRoZSB0d28g4oCcdmFsdWXigJ0gYXNzaWdubWVudHMNCj4+Pj4gICAgc2hvdWxkIGJl
IHdyaXR0ZW4gdG8gcmVnaXN0ZXJzLg0KPj4+Pg0KPj4+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9i
b3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENoZW4gUXVu
IDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+IEknbSBub3Qgc3VyZSBp
ZiB0aGlzIG1vZGlmaWNhdGlvbiBpcyBjb3JyZWN0LCBqdXN0IGZyb20gdGhlIGZ1bmN0aW9uDQo+
Pj4+ICAgIGRlZmluaXRpb24sIGl0IGlzIGNvcnJlY3QuDQo+Pj4+IC0tLQ0KPj4+PiAgICBody9u
ZXQvaW14X2ZlYy5jIHwgNCArKy0tDQo+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9uZXQvaW14
X2ZlYy5jIGIvaHcvbmV0L2lteF9mZWMuYyBpbmRleA0KPj4+PiA2YTEyNGExNTRhLi45MmY2MjE1
NzEyIDEwMDY0NA0KPj4+PiAtLS0gYS9ody9uZXQvaW14X2ZlYy5jDQo+Pj4+ICsrKyBiL2h3L25l
dC9pbXhfZmVjLmMNCj4+Pj4gQEAgLTg1NSwxMyArODU1LDEzIEBAIHN0YXRpYyB2b2lkIGlteF9l
bmV0X3dyaXRlKElNWEZFQ1N0YXRlICpzLA0KPnVpbnQzMl90IGluZGV4LCB1aW50MzJfdCB2YWx1
ZSkNCj4+Pj4gICAgICAgICAgICBicmVhazsNCj4+Pj4gICAgICAgIGNhc2UgRU5FVF9UR1NSOg0K
Pj4+PiAgICAgICAgICAgIC8qIGltcGxlbWVudCBjbGVhciB0aW1lciBmbGFnICovDQo+Pj4+IC0g
ICAgICAgIHZhbHVlID0gdmFsdWUgJiAweDAwMDAwMDBmOw0KPj4+PiArICAgICAgICBzLT5yZWdz
W2luZGV4XSA9IHZhbHVlICYgMHgwMDAwMDAwZjsNCj4+Pj4gICAgICAgICAgICBicmVhazsNCj4+
IEhpOyB0aGUgZGF0YXNoZWV0IGZvciB0aGlzIFNvQyBzYXlzIHRoYXQgdGhlc2UgYml0cyBvZiB0
aGUgcmVnaXN0ZXINCj4+IGFyZSB3cml0ZS0xLXRvLWNsZWFyLCBzbyB3aGlsZSB0aGlzIGlzIGRl
ZmluaXRlbHkgYSBidWcgSSBkb24ndCB0aGluaw0KPj4gdGhpcyBpcyB0aGUgcmlnaHQgZml4Lg0K
Pj4NCj4+Pj4gICAgICAgIGNhc2UgRU5FVF9UQ1NSMDoNCj4+Pj4gICAgICAgIGNhc2UgRU5FVF9U
Q1NSMToNCj4+Pj4gICAgICAgIGNhc2UgRU5FVF9UQ1NSMjoNCj4+Pj4gICAgICAgIGNhc2UgRU5F
VF9UQ1NSMzoNCj4+Pj4gLSAgICAgICAgdmFsdWUgPSB2YWx1ZSAmIDB4MDAwMDAwZmQ7DQo+Pj4+
ICsgICAgICAgIHMtPnJlZ3NbaW5kZXhdID0gdmFsdWUgJiAweDAwMDAwMGZkOw0KPj4+PiAgICAg
ICAgICAgIGJyZWFrOw0KPj4gSGVyZSBiaXQgNyBpcyB3cml0ZS0xLXRvLWNsZWFyLCB0aG91Z2gg
Yml0cyAwIGFuZA0KPj4gMi4uNSBhcmUgc2ltcGxlIHdyaXRlLXRoZS12YWx1ZS4NCj4+DQo+Pj4+
ICAgICAgICBjYXNlIEVORVRfVENDUjA6DQo+Pj4+ICAgICAgICBjYXNlIEVORVRfVENDUjE6DQo+
Pj4NCj4+PiBBcHBsaWVkLg0KPj4gQ291bGQgeW91IGRyb3AgdGhpcyBmcm9tIHlvdXIgcXVldWUs
IHBsZWFzZT8NCj4+DQo+PiB0aGFua3MNCj4+IC0tIFBNTQ0KPg0KPg0KPlN1cmUsIENoZW4gcGxl
YXNlIHNlbmQgVjIgdG8gYWRkcmVzcyBQZXRlcidzIGNvbW1lbnQuDQpPSywgIGJ1dCBJIGRpZG4n
dCBmaW5kIHRoZSBkYXRhc2hlZXQgdGhhdCBjb250YWlucyB0aGVzZSB0d28gcmVnaXN0ZXJzIGRl
c2NyaXB0aW9uLg0KQ291bGQgc29tZW9uZSBwcm92aWRlIG1lIHdpdGggYSAgY29ubmVjdGlvbiBm
b3IgdGhlIGRhdGFzaGVldCA/DQoNCg==


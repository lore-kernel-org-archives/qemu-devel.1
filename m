Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FFDC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196922073E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 07:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196922073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCeM0-0001KS-6w
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 03:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiangyifei@huawei.com>) id 1jCeL1-0000Zt-3L
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:02:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiangyifei@huawei.com>) id 1jCeKz-0004V9-K4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 03:02:30 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2510 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiangyifei@huawei.com>)
 id 1jCeKy-0004Be-U6; Fri, 13 Mar 2020 03:02:29 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 3D56C256F584CE755062;
 Fri, 13 Mar 2020 15:02:20 +0800 (CST)
Received: from DGGEMM505-MBX.china.huawei.com ([169.254.1.8]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0439.000;
 Fri, 13 Mar 2020 15:02:12 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: Anup Patel <anup@brainfault.org>
Subject: RE: [PATCH RFC 0/9] Add riscv64 kvm accel support
Thread-Topic: [PATCH RFC 0/9] Add riscv64 kvm accel support
Thread-Index: AQHV+OqsP3y56Dmww0a/2synn2NrhKhFgTqAgACQGBA=
Date: Fri, 13 Mar 2020 07:02:12 +0000
Message-ID: <3915816D913D8241BB43E932213F57D4ADC56065@DGGEMM505-MBX.china.huawei.com>
References: <20200313034949.3028-1-jiangyifei@huawei.com>
 <CAAhSdy3-K5rxiJkjBp8iUnDqVZz0hQkNCVactmamsOcVZv3GOQ@mail.gmail.com>
In-Reply-To: <CAAhSdy3-K5rxiJkjBp8iUnDqVZz0hQkNCVactmamsOcVZv3GOQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.201.158]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.188
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
Cc: "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <anup.patel@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFudXAgUGF0ZWwgW21haWx0
bzphbnVwQGJyYWluZmF1bHQub3JnXQ0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDEzLCAyMDIwIDI6
MDAgUE0NCj4gVG86IEppYW5neWlmZWkgPGppYW5neWlmZWlAaHVhd2VpLmNvbT4NCj4gQ2M6IFFF
TVUgRGV2ZWxvcGVycyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgb3BlbiBsaXN0OlJJU0MtViA8
cWVtdS0NCj4gcmlzY3ZAbm9uZ251Lm9yZz47IEFudXAgUGF0ZWwgPGFudXAucGF0ZWxAd2RjLmNv
bT47IFpoYW5naGFpbGlhbmcNCj4gPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IFNh
Z2FyIEthcmFuZGlrYXINCj4gPHNhZ2Fya0BlZWNzLmJlcmtlbGV5LmVkdT47IEJhc3RpYW4gS29w
cGVsbWFubiA8a2Jhc3RpYW5AbWFpbC51bmktDQo+IHBhZGVyYm9ybi5kZT47IFpoYW5neGlhb2Zl
bmcgKEYpIDx2aWN0b3Iuemhhbmd4aWFvZmVuZ0BodWF3ZWkuY29tPjsNCj4gQWxpc3RhaXIgRnJh
bmNpcyA8QWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tPjsgeWlueWlwZW5nDQo+IDx5aW55aXBlbmcx
QGh1YXdlaS5jb20+OyBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQGRhYmJlbHQuY29tPjsNCj4gZGVu
Z2thaSAoQSkgPGRlbmdrYWkxQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZD
IDAvOV0gQWRkIHJpc2N2NjQga3ZtIGFjY2VsIHN1cHBvcnQNCj4gDQo+IE9uIEZyaSwgTWFyIDEz
LCAyMDIwIGF0IDk6MjMgQU0gWWlmZWkgSmlhbmcgPGppYW5neWlmZWlAaHVhd2VpLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+IFRoaXMgc2VyaWVzIGFkZHMgcmlzY3Y2NCBrdm0g
c3VwcG9ydCwgSXQgaXMgYmFzZWQgb24gcmlzY3Zfa3ZtX21hc3Rlcg0KPiA+IGJyYW5jaCBhdCBo
dHRwczovL2dpdGh1Yi5jb20va3ZtLXJpc2N2L2xpbnV4Lg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMg
ZGVwZW5kcyBvbiBhYm92ZSBwZW5kaW5nIGNoYW5nZXMgd2hpY2ggaGF2ZW4ndCB5ZXQgYmVlbg0K
PiA+IGFjY2VwdGVkLCBzbyB0aGlzIFFFTVUgcGF0Y2ggc2VyaWVzIGlzIGJsb2NrZWQgdW50aWwg
dGhhdCBkZXBlbmRlbmN5DQo+ID4gaGFzIGJlZW4gZGVhbHQgd2l0aCwgYnV0IGlzIHdvcnRoIHJl
dmlld2luZyBhbnl3YXkuDQo+ID4NCj4gPiBTZXZlcmFsIHN0ZXBzIHRvIHVzZSB0aGlzOg0KPiA+
DQo+ID4gMS4gQnVpbGQgcmlzY3Y2NCBlbXVsYXRpb24NCj4gPiAkIC4vY29uZmlndXJlIC0tdGFy
Z2V0LWxpc3Q9cmlzY3Y2NC1zb2Z0bW11ICQgbWFrZSAtaiQobnByb2MpDQo+ID4NCj4gPiAyLiBC
dWlsZCBrZXJuZWwNCj4gPiByaXNjdl9rdm1fbWFzdGVyIGJyYW5jaCBhdCBodHRwczovL2dpdGh1
Yi5jb20va3ZtLXJpc2N2L2xpbnV4DQo+ID4NCj4gPiAzLiBCdWlsZCBRRU1VIFZNDQo+ID4gSSBj
cm9zcyBidWlsZCBpbiByaXNjdiB0b29sY2hhaW4NCj4gPiAkIFBLR19DT05GSUdfTElCRElSPTx0
b29sY2hhaW4gcGtnY29uZmlnIHBhdGg+ICQgZXhwb3J0DQo+ID4gUEtHX0NPTkZJR19TWVNST09U
X0RJUj08dG9vbGNoYWluIHN5c3Jvb3QgcGF0aD4gJCAuL2NvbmZpZ3VyZQ0KPiA+IC0tdGFyZ2V0
LWxpc3Q9cmlzY3Y2NC1zb2Z0bW11IC0tZW5hYmxlLWt2bSBcDQo+ID4gLS1jcm9zcy1wcmVmaXg9
cmlzY3Y2NC1saW51eC1nbnUtIC0tZGlzYWJsZS1saWJpc2NzaQ0KPiA+IC0tZGlzYWJsZS1nbHVz
dGVyZnMgXCAtLWRpc2FibGUtbGlidXNiIC0tZGlzYWJsZS11c2ItcmVkaXINCj4gPiAtLWF1ZGlv
LWRydi1saXN0PSAtLWRpc2FibGUtb3BlbmdsIFwNCj4gPiAtLWRpc2FibGUtbGlieG1sMg0KPiA+
DQo+ID4gNC4gU3RhcnQgcmlzY3Y2NCBlbXVsYXRpb24NCj4gPiAkIC4vcWVtdS1zeXN0ZW0tcmlz
Y3Y2NCAtTSB2aXJ0IC1tIDQwOTZNIC1jcHUgcnY2NCx4LWg9dHJ1ZSAtbm9ncmFwaGljIFwNCj4g
PiAgICAgICAgIC1uYW1lIGd1ZXN0PXJpc2N2LWh5cCxkZWJ1Zy10aHJlYWRzPW9uIFwNCj4gPiAg
ICAgICAgIC1zbXAgNCBcDQo+ID4gICAgICAgICAta2VybmVsIC4vZndfanVtcC5lbGYgXA0KPiA+
ICAgICAgICAgLWRldmljZSBsb2FkZXIsZmlsZT0uL0ltYWdlLGFkZHI9MHg4MDIwMDAwMCBcDQo+
ID4gICAgICAgICAtZHJpdmUgZmlsZT0uL2h5cC5pbWcsZm9ybWF0PXJhdyxpZD1oZDAgXA0KPiA+
ICAgICAgICAgLWRldmljZSB2aXJ0aW8tYmxrLWRldmljZSxkcml2ZT1oZDAgXA0KPiA+ICAgICAg
ICAgLWFwcGVuZCAicm9vdD0vZGV2L3ZkYSBydyBjb25zb2xlPXR0eVMwIGVhcmx5Y29uPXNiaSIN
Cj4gPg0KPiA+IDUuIFN0YXJ0IGt2bS1hY2NlbGVkIFFFTVUgVk0gaW4gcmlzY3Y2NCBlbXVsYXRp
b24gJA0KPiA+IC4vcWVtdS1zeXN0ZW0tcmlzY3Y2NCAtTSB2aXJ0LGFjY2VsPWt2bSAtbSAxMDI0
TSAtY3B1IGhvc3QgLW5vZ3JhcGhpYyBcDQo+ID4gICAgICAgICAtbmFtZSBndWVzdD1yaXNjdi1n
dXNldCBcDQo+ID4gICAgICAgICAgLXNtcCAyIFwNCj4gPiAgICAgICAgIC1rZXJuZWwgLi9JbWFn
ZSBcDQo+ID4gICAgICAgICAtZHJpdmUgZmlsZT0uL2d1ZXN0LmltZyxmb3JtYXQ9cmF3LGlkPWhk
MCBcDQo+ID4gICAgICAgICAtZGV2aWNlIHZpcnRpby1ibGstZGV2aWNlLGRyaXZlPWhkMCBcDQo+
ID4gICAgICAgICAtYXBwZW5kICJyb290PS9kZXYvdmRhIHJ3IGNvbnNvbGU9dHR5UzAgZWFybHlj
b249c2JpIg0KPiA+DQo+ID4gWWlmZWkgSmlhbmcgKDkpOg0KPiA+ICAgbGludXgtaGVhZGVyOiBV
cGRhdGUgbGludXgva3ZtLmgNCj4gPiAgIHRhcmdldC9yaXNjdjogQWRkIHRhcmdldC9yaXNjdi9r
dm0uYyB0byBwbGFjZSB0aGUgcHVibGljIGt2bSBpbnRlcmZhY2UNCj4gPiAgIHRhcmdldC9yaXNj
djogSW1wbGVtZW50IGZ1bmN0aW9uIGt2bV9hcmNoX2luaXRfdmNwdQ0KPiA+ICAgdGFyZ2V0L3Jp
c2N2OiBJbXBsZW1lbnQga3ZtX2FyY2hfZ2V0X3JlZ2lzdGVycw0KPiA+ICAgdGFyZ2V0L3Jpc2N2
OiBJbXBsZW1lbnQga3ZtX2FyY2hfcHV0X3JlZ2lzdGVycw0KPiA+ICAgdGFyZ2V0L3Jpc2N2OiBT
dXBwb3J0IHN0YXJ0IGtlcm5lbCBkaXJlY3RseSBieSBLVk0NCj4gPiAgIGh3L3Jpc2N2OiBQTElD
IHVwZGF0ZSBleHRlcm5hbCBpbnRlcnJ1cHQgYnkgS1ZNIHdoZW4ga3ZtIGVuYWJsZWQNCj4gPiAg
IHRhcmdldC9yaXNjdjogSGFuZGxlciBLVk1fRVhJVF9SSVNDVl9TQkkgZXhpdA0KPiA+ICAgdGFy
Z2V0L3Jpc2N2OiBhZGQgaG9zdCByaXNjdjY0IGNwdSB0eXBlDQo+ID4NCj4gPiAgY29uZmlndXJl
ICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBody9yaXNjdi9zaWZpdmVfcGxpYy5jICAg
ICB8ICAzMSArKy0NCj4gPiAgaHcvcmlzY3YvdmlydC5jICAgICAgICAgICAgfCAgMTUgKy0NCj4g
PiAgbGludXgtaGVhZGVycy9saW51eC9rdm0uaCAgfCAgIDggKw0KPiA+ICB0YXJnZXQvcmlzY3Yv
TWFrZWZpbGUub2JqcyB8ICAgMSArDQo+ID4gIHRhcmdldC9yaXNjdi9jcHUuYyAgICAgICAgIHwg
ICA5ICsNCj4gPiAgdGFyZ2V0L3Jpc2N2L2NwdS5oICAgICAgICAgfCAgIDQgKw0KPiA+ICB0YXJn
ZXQvcmlzY3Yva3ZtLmMgICAgICAgICB8IDUxMw0KPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIHRhcmdldC9yaXNjdi9rdm1fcmlzY3YuaCAgIHwgIDI1ICsrDQo+
ID4gIDkgZmlsZXMgY2hhbmdlZCwgNTk2IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKSAg
Y3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgdGFyZ2V0L3Jpc2N2L2t2bS5jICBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0L3Jpc2N2L2t2bV9yaXNjdi5oDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTkuMQ0K
PiA+DQo+ID4NCj4gPg0KPiANCj4gRmlyc3Qgb2YgYWxsIG1hbnkgdGhhbmtzIGZvciBkb2luZyBR
RU1VIEtWTSBzdXBwb3J0LiBJdCB3YXN0ZWQgYml0IG9mIG15DQo+IHRpbWUgYmVjYXVzZSBJIHdh
cyBhbHJlYWR5IGRvaW5nIGl0IGJ1dCBJIGFtIGhhcHB5IHRvIHNlZSB0aGUgcGF0Y2hlcyBvbiBs
aXN0DQo+IHNvb25lci4NCj4gDQo+IEluIGZ1dHVyZSwgcGxlYXNlIENDIHRoZSBLVk0gUklTQy1W
IG1haWxpbmcgbGlzdCBmb3IgYWxsIFFFTVUgS1ZNIFJJU0MtVg0KPiB3b3JrLiBUaGUgS1ZNIFJJ
U0MtViBtYWlsaW5nIGxpc3QgZm9yIHJlbGF0ZWQgcHJvamVjdHMgKFFFTVUsIEtWTVRPT0wsDQo+
IGxpYnZpcnQsIGV0YykgYW5kIG5vdCBqdXN0IExpbnV4IEtWTSBSSVNDLVYuDQo+IA0KPiBDdXJy
ZW50bHksIHdlIGNhbiBvbmx5IHJldmlldyB0aGlzIHBhdGNoIHNlcmllcyBhbmQgZ2V0IGl0IGlu
IGZpbmFsIHNoYXBlIGJ1dCBpdA0KPiBjYW4gb25seSBiZSBtZXJnZWQgaW4gUUVNVSBhZnRlciBM
aW51eCBLVk0gUklTQy1WIHBhdGNoZXMgYXJlIG1lcmdlZCBpbg0KPiBMaW51eCBrZXJuZWwuDQo+
IA0KPiBJIHdpbGwgYmUgc2VuZGluZyBvdXQgS1ZNIFJJU0MtViB2MTEgc2VyaWVzIHRvZGF5LiBU
aGVyZSBpcyBhIGNydWNpYWwgYnVnIGZpeA0KPiByZWxhdGVkIHRvIEhJREVMRUcgQ1NSIHByb2dy
YW1pbmcuIFRoaXMgYnVnIGZpeCBpcyByZXF1aXJlZCBpbiBib3RoIFFFTVUNCj4gYW5kIEtWTSBS
SVNDLVYuIFBhbG1lciBoYXMgYWxyZWFkeSBhY2NlcHRlZCBRRU1VIEhJREVMRUcgQ1NSIGZpeC4g
VGhlDQo+IEtWTSBSSVNDLVYNCj4gdjExIHNlcmllcyB3aWxsIGhhdmUgdGhpcyBmaXggYXMgd2Vs
bC4NCj4gDQo+IFRoYW5rcyAmIFJlZ2FyZHMsDQo+IEFudXAgUGF0ZWwNCg0KVGhhbmsgeW91IGZv
ciB5b3VyIHF1aWNrIHJlcGx5IGFuZCBiZWluZyBhYmxlIHRvIHJldmlldyBmb3IgdXMuIFdlIHdp
bGwgc29vbiBiZSB2ZXJpZnlpbmcgYmFzZWQgb24gdGhlIEtWTSBSSVNDLVYgdjExIHNlcmllcy4N
Cg0KUmVnYXJkcywNCllpZmVpIEppYW5nDQo=


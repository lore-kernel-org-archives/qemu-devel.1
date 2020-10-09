Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EE7C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B205122240
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B205122240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQnnh-0000pX-HS
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 04:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kQnmA-0000Gt-GZ; Fri, 09 Oct 2020 04:29:18 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:33232 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kQnm7-0005Eo-SH; Fri, 09 Oct 2020 04:29:18 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 06C15196E1DB82C64339;
 Fri,  9 Oct 2020 16:29:04 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 9 Oct 2020 16:29:03 +0800
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 9 Oct 2020 16:29:03 +0800
Received: from dggpemm000001.china.huawei.com ([7.185.36.245]) by
 dggpemm000001.china.huawei.com ([7.185.36.245]) with mapi id 15.01.1913.007;
 Fri, 9 Oct 2020 16:29:03 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Subject: RE: [PATCH 3/5] target/riscv: Add H extention state description
Thread-Topic: [PATCH 3/5] target/riscv: Add H extention state description
Thread-Index: AQHWlgTPDj3GKB4dC0y+2FIpBPS75amCfl6AgAyA2wA=
Date: Fri, 9 Oct 2020 08:29:03 +0000
Message-ID: <e7be2fdaaf364c11a1124544da497e4f@huawei.com>
References: <20200929020337.1559-1-jiangyifei@huawei.com>
 <20200929020337.1559-4-jiangyifei@huawei.com>
 <2e725e26-3952-dbd2-c4aa-d9e933406220@linaro.org>
In-Reply-To: <2e725e26-3952-dbd2-c4aa-d9e933406220@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.47]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=jiangyifei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 04:03:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "sagark@eecs.berkeley.edu" <sagark@eecs.berkeley.edu>,
 "kbastian@mail.uni-paderborn.de" <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "Alistair.Francis@wdc.com" <Alistair.Francis@wdc.com>,
 yinyipeng <yinyipeng1@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "Wubin \(H\)" <wu.wubin@huawei.com>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmljaGFyZCBIZW5kZXJz
b24gW21haWx0bzpyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnXQ0KPiBTZW50OiBGcmlkYXks
IE9jdG9iZXIgMiwgMjAyMCAxOjI4IEFNDQo+IFRvOiBKaWFuZ3lpZmVpIDxqaWFuZ3lpZmVpQGh1
YXdlaS5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IHFlbXUtcmlzY3ZAbm9uZ251Lm9y
Zw0KPiBDYzogWmhhbmdoYWlsaWFuZyA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsN
Cj4gc2FnYXJrQGVlY3MuYmVya2VsZXkuZWR1OyBrYmFzdGlhbkBtYWlsLnVuaS1wYWRlcmJvcm4u
ZGU7IFpoYW5neGlhb2ZlbmcNCj4gKEYpIDx2aWN0b3Iuemhhbmd4aWFvZmVuZ0BodWF3ZWkuY29t
PjsgQWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tOyB5aW55aXBlbmcNCj4gPHlpbnlpcGVuZzFAaHVh
d2VpLmNvbT47IHBhbG1lckBkYWJiZWx0LmNvbTsgV3ViaW4gKEgpDQo+IDx3dS53dWJpbkBodWF3
ZWkuY29tPjsgZGVuZ2thaSAoQSkgPGRlbmdrYWkxQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggMy81XSB0YXJnZXQvcmlzY3Y6IEFkZCBIIGV4dGVudGlvbiBzdGF0ZSBkZXNjcmlw
dGlvbg0KPiANCj4gT24gOS8yOC8yMCA5OjAzIFBNLCBZaWZlaSBKaWFuZyB3cm90ZToNCj4gPiAr
ICAgICAgICBWTVNUQVRFX1VJTlRUTChlbnYudnNzdGF0dXMsIFJJU0NWQ1BVKSwNCj4gPiArICAg
ICAgICBWTVNUQVRFX1VJTlRUTChlbnYudnN0dmVjLCBSSVNDVkNQVSksDQo+ID4gKyAgICAgICAg
Vk1TVEFURV9VSU5UVEwoZW52LnZzc2NyYXRjaCwgUklTQ1ZDUFUpLA0KPiA+ICsgICAgICAgIFZN
U1RBVEVfVUlOVFRMKGVudi52c2VwYywgUklTQ1ZDUFUpLA0KPiA+ICsgICAgICAgIFZNU1RBVEVf
VUlOVFRMKGVudi52c2NhdXNlLCBSSVNDVkNQVSksDQo+ID4gKyAgICAgICAgVk1TVEFURV9VSU5U
VEwoZW52LnZzdHZhbCwgUklTQ1ZDUFUpLA0KPiA+ICsgICAgICAgIFZNU1RBVEVfVUlOVFRMKGVu
di52c2F0cCwgUklTQ1ZDUFUpLA0KPiANCj4gU28uLi4gaWYgSSB1bmRlcnN0YW5kIHRoaW5ncyBj
b3JyZWN0bHksIHRoaXMgaXMgc3ludGhldGljIHN0YXRlLCBpbnRlcm5hbCB0byBRRU1VLg0KPiBJ
dCBpcyBnZW5lcmFsbHkgYmV0dGVyIHRvIG9ubHkgc2VyaWFsaXplIGFyY2hpdGVjdHVyYWwgc3Rh
dGUsIHNvIHRoYXQgaWYgcWVtdQ0KPiBpbnRlcm5hbHMgYXJlIHJlYXJyYW5nZWQsIGl0IGlzIGVh
c3kgdG8gZGVjaWRlIG9uIHRoZSBjb3JyZWN0IHNlcXVlbmNlIG9mDQo+IG9wZXJhdGlvbnMuDQo+
IA0KPiBJdCBzZWVtcyBsaWtlIHRoaXMgc2hvdWxkIGJlIHJlLWdlbmVyYXRlZCB3aXRoIGEgcG9z
dF9sb2FkIGhvb2ssIGNhbGxpbmcgc29tZSBvZg0KPiB0aGUgY29kZSBjdXJyZW50bHkgaW4gcmlz
Y3ZfY3B1X3N3YXBfaHlwZXJ2aXNvcl9yZWdzKCkuICBOb3RlIHRoYXQgc29tZQ0KPiBtaW5vciBy
ZWFycmFuZ2VtZW50IHdvdWxkIGJlIG5lZWRlZCB0byBjYWxsIHRoYXQgY29kZSBmcm9tIHRoaXMg
bmV3IGNvbnRleHQuDQo+IA0KPiANCj4gcn4NCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRz
Lg0KDQpBcyBBbGlzdGFpciBzYWlkLCBUaG9zZSB2cyogYXJlIFZpcnR1YWwgU3VwZXJ2aXNvciBD
U1JzLiBIeXBlcnZpc29yIG1heSB3cml0ZSB0aG9zZS4NCkFjdHVhbGx577yMZXhjZXB0ICpfaHMs
IGFsbCBzdGF0ZXMgYXJlIHJlYWwgQ1NScyBhbmQgY2Fubm90IGJlIHJlZ2VuZXJhdGVkLg0KKl9o
cyBhcmUgYmFja3VwIG9mIFN1cGVydmlzb3IgQ1NScyB3aGVuIFY9Me+8jHNvLCBJIGRvbid0IHRo
aW5rIGNvdWxkIHJlLWdlbmVyYXRlIHRoZW0uDQoNCkluIGNvbmNsdXNpb24sIEkgdGhpbmsgYWxs
IEggZXh0ZW5zaW9uIHN0YXRlcyBpbiB0aGlzIHBhdGNoIG5lZWQgdG8gYmUgZGVzY3JpYmVkIGlu
IHZtc3RhdGUuDQoNCllpZmVpDQoNCg==


Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A487C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEADD22260
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 08:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEADD22260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQnrT-00028P-I9
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 04:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kQnqR-0001gu-P5; Fri, 09 Oct 2020 04:33:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2938 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kQnqP-0005h0-Kt; Fri, 09 Oct 2020 04:33:43 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 26A08E0B1F0D74EC38CF;
 Fri,  9 Oct 2020 16:33:37 +0800 (CST)
Received: from dggemm752-chm.china.huawei.com (10.1.198.58) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 9 Oct 2020 16:33:36 +0800
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemm752-chm.china.huawei.com (10.1.198.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 9 Oct 2020 16:33:36 +0800
Received: from dggpemm000001.china.huawei.com ([7.185.36.245]) by
 dggpemm000001.china.huawei.com ([7.185.36.245]) with mapi id 15.01.1913.007;
 Fri, 9 Oct 2020 16:33:36 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: Alistair Francis <alistair23@gmail.com>
Subject: RE: [PATCH 2/5] target/riscv: Add PMP state description
Thread-Topic: [PATCH 2/5] target/riscv: Add PMP state description
Thread-Index: AQHWlgTPdwzJAFmCmEa/JKusRGLC9amJFpIAgAXqceA=
Date: Fri, 9 Oct 2020 08:33:36 +0000
Message-ID: <f867553f20c744f6a4d0c0da639ca86d@huawei.com>
References: <20200929020337.1559-1-jiangyifei@huawei.com>
 <20200929020337.1559-3-jiangyifei@huawei.com>
 <CAKmqyKMXdiTJYoNbATTfGTO-FT1+Ke9bHk_kGwpT0mH26xsSVg@mail.gmail.com>
In-Reply-To: <CAKmqyKMXdiTJYoNbATTfGTO-FT1+Ke9bHk_kGwpT0mH26xsSVg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.47]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=jiangyifei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 04:33:37
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Wubin \(H\)" <wu.wubin@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpc3RhaXIgRnJhbmNp
cyBbbWFpbHRvOmFsaXN0YWlyMjNAZ21haWwuY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVy
IDYsIDIwMjAgNjoxMSBBTQ0KPiBUbzogSmlhbmd5aWZlaSA8amlhbmd5aWZlaUBodWF3ZWkuY29t
Pg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnIERldmVsb3BlcnMgPHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz47IG9wZW4NCj4gbGlzdDpSSVNDLVYgPHFlbXUtcmlzY3ZAbm9uZ251Lm9yZz47IFpo
YW5naGFpbGlhbmcNCj4gPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IFNhZ2FyIEth
cmFuZGlrYXINCj4gPHNhZ2Fya0BlZWNzLmJlcmtlbGV5LmVkdT47IEJhc3RpYW4gS29wcGVsbWFu
bg0KPiA8a2Jhc3RpYW5AbWFpbC51bmktcGFkZXJib3JuLmRlPjsgWmhhbmd4aWFvZmVuZyAoRikN
Cj4gPHZpY3Rvci56aGFuZ3hpYW9mZW5nQGh1YXdlaS5jb20+OyBBbGlzdGFpciBGcmFuY2lzDQo+
IDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+OyB5aW55aXBlbmcgPHlpbnlpcGVuZzFAaHVhd2Vp
LmNvbT47IFBhbG1lcg0KPiBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBXdWJpbiAoSCkg
PHd1Lnd1YmluQGh1YXdlaS5jb20+Ow0KPiBkZW5na2FpIChBKSA8ZGVuZ2thaTFAaHVhd2VpLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzVdIHRhcmdldC9yaXNjdjogQWRkIFBNUCBzdGF0
ZSBkZXNjcmlwdGlvbg0KPiANCj4gT24gTW9uLCBTZXAgMjgsIDIwMjAgYXQgNzowNSBQTSBZaWZl
aSBKaWFuZyA8amlhbmd5aWZlaUBodWF3ZWkuY29tPiB3cm90ZToNCj4gPg0KPiA+IEluIHRoZSBj
YXNlIG9mIHN1cHBvcnRpbmcgUE1QIGZlYXR1cmUsIGFkZCBQTVAgc3RhdGUgZGVzY3JpcHRpb24g
dG8NCj4gPiB2bXN0YXRlX3Jpc2N2X2NwdS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlpZmVp
IEppYW5nIDxqaWFuZ3lpZmVpQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWlwZW5n
IFlpbiA8eWlueWlwZW5nMUBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICB0YXJnZXQvcmlzY3Yv
bWFjaGluZS5jIHwgNDkNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvbWFjaGluZS5jIGIvdGFyZ2V0L3Jpc2N2L21hY2hpbmUu
YyBpbmRleA0KPiA+IDM0NTFiODg4YjEuLmIxZmM4MzliNDMgMTAwNjQ0DQo+ID4gLS0tIGEvdGFy
Z2V0L3Jpc2N2L21hY2hpbmUuYw0KPiA+ICsrKyBiL3RhcmdldC9yaXNjdi9tYWNoaW5lLmMNCj4g
PiBAQCAtNCw2ICs0LDUxIEBADQo+ID4gICNpbmNsdWRlICJzeXNlbXUva3ZtLmgiDQo+ID4gICNp
bmNsdWRlICJtaWdyYXRpb24vY3B1LmgiDQo+ID4NCj4gPiArc3RhdGljIGJvb2wgcG1wX25lZWRl
ZCh2b2lkICpvcGFxdWUpDQo+ID4gK3sNCj4gPiArICAgIFJJU0NWQ1BVICpjcHUgPSBvcGFxdWU7
DQo+ID4gKyAgICBDUFVSSVNDVlN0YXRlICplbnYgPSAmY3B1LT5lbnY7DQo+ID4gKw0KPiA+ICsg
ICAgcmV0dXJuIHJpc2N2X2ZlYXR1cmUoZW52LCBSSVNDVl9GRUFUVVJFX1BNUCk7IH0NCj4gPiAr
DQo+ID4gK3N0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9wbXBfZW50cnkg
PSB7DQo+ID4gKyAgICAubmFtZSA9ICJjcHUvcG1wL2VudHJ5IiwNCj4gPiArICAgIC52ZXJzaW9u
X2lkID0gMSwNCj4gPiArICAgIC5taW5pbXVtX3ZlcnNpb25faWQgPSAxLA0KPiA+ICsgICAgLmZp
ZWxkcyA9IChWTVN0YXRlRmllbGRbXSkgew0KPiA+ICsgICAgICAgIFZNU1RBVEVfVUlOVFRMKGFk
ZHJfcmVnLCBwbXBfZW50cnlfdCksDQo+ID4gKyAgICAgICAgVk1TVEFURV9VSU5UOChjZmdfcmVn
LCBwbXBfZW50cnlfdCksDQo+ID4gKyAgICAgICAgVk1TVEFURV9FTkRfT0ZfTElTVCgpDQo+ID4g
KyAgICB9DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3QgVk1TdGF0ZURlc2NyaXB0
aW9uIHZtc3RhdGVfcG1wX2FkZHIgPSB7DQo+ID4gKyAgICAubmFtZSA9ICJjcHUvcG1wL2FkZHIi
LA0KPiA+ICsgICAgLnZlcnNpb25faWQgPSAxLA0KPiA+ICsgICAgLm1pbmltdW1fdmVyc2lvbl9p
ZCA9IDEsDQo+ID4gKyAgICAuZmllbGRzID0gKFZNU3RhdGVGaWVsZFtdKSB7DQo+ID4gKyAgICAg
ICAgVk1TVEFURV9VSU5UVEwoc2EsIHBtcF9hZGRyX3QpLA0KPiA+ICsgICAgICAgIFZNU1RBVEVf
VUlOVFRMKGVhLCBwbXBfYWRkcl90KSwNCj4gPiArICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNU
KCkNCj4gPiArICAgIH0NCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBWTVN0YXRl
RGVzY3JpcHRpb24gdm1zdGF0ZV9wbXAgPSB7DQo+ID4gKyAgICAubmFtZSA9ICJjcHUvcG1wIiwN
Cj4gPiArICAgIC52ZXJzaW9uX2lkID0gMSwNCj4gPiArICAgIC5taW5pbXVtX3ZlcnNpb25faWQg
PSAxLA0KPiA+ICsgICAgLm5lZWRlZCA9IHBtcF9uZWVkZWQsDQo+ID4gKyAgICAuZmllbGRzID0g
KFZNU3RhdGVGaWVsZFtdKSB7DQo+ID4gKyAgICAgICAgVk1TVEFURV9TVFJVQ1RfQVJSQVkoZW52
LnBtcF9zdGF0ZS5wbXAsIFJJU0NWQ1BVLA0KPiBNQVhfUklTQ1ZfUE1QUywNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAwLCB2bXN0YXRlX3BtcF9lbnRyeSwgcG1wX2VudHJ5X3Qp
LA0KPiA+ICsgICAgICAgIFZNU1RBVEVfU1RSVUNUX0FSUkFZKGVudi5wbXBfc3RhdGUuYWRkciwg
UklTQ1ZDUFUsDQo+IE1BWF9SSVNDVl9QTVBTLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDAsIHZtc3RhdGVfcG1wX2FkZHIsIHBtcF9hZGRyX3QpLA0KPiA+ICsgICAgICAgIFZN
U1RBVEVfVUlOVDMyKGVudi5wbXBfc3RhdGUubnVtX3J1bGVzLCBSSVNDVkNQVSksDQo+IA0KPiBJ
IHdvdWxkIHByZWZlciB0byByZS1nZW5lcmF0ZSB0aGVzZSBmcm9tIHRoZSBQTVAgQ1NScyBwb3N0
IGxvYWQuDQo+IA0KPiBBbGlzdGFpcg0KPiANCg0KVGhhbmtzIGZvciB5b3VyIGFkdmljZS4gWWVz
LCB5b3UgYXJlIHJpZ2h0Lg0Kdm1zdGF0ZV9wbXBfZW50cnkgY2Fubm90IGJlIHJlZ2VuZXJhdGVk
LCBidXQgdm1zdGF0ZV9wbXBfYWRkciBhbmQgbnVtX3J1bGVzIGNvdWxkIGJlIHJlZ2VuZXJhdGVk
Lg0KDQpJJ2xsIGFkZCBwb3N0X2xvYWQgaG9vayBmb3IgcmVnZW5lcmF0aW5nIHZtc3RhdGVfcG1w
X2FkZHIgYW5kIG51bV9ydWxlcyBpbiB0aGUgbmV4dCBzZXJpZXMuDQoNCllpZmVpDQoNCj4gPiAr
ICAgICAgICBWTVNUQVRFX0VORF9PRl9MSVNUKCkNCj4gPiArICAgIH0NCj4gPiArfTsNCj4gPiAr
DQo+ID4gIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX3Jpc2N2X2NwdSA9IHsNCj4g
PiAgICAgIC5uYW1lID0gImNwdSIsDQo+ID4gICAgICAudmVyc2lvbl9pZCA9IDEsDQo+ID4gQEAg
LTU1LDUgKzEwMCw5IEBAIGNvbnN0IFZNU3RhdGVEZXNjcmlwdGlvbiB2bXN0YXRlX3Jpc2N2X2Nw
dSA9IHsNCj4gPiAgICAgICAgICBWTVNUQVRFX1VJTlRUTChlbnYubXN0YXR1c2gsIFJJU0NWQ1BV
KSwgICNlbmRpZg0KPiA+ICAgICAgICAgIFZNU1RBVEVfRU5EX09GX0xJU1QoKQ0KPiA+ICsgICAg
fSwNCj4gPiArICAgIC5zdWJzZWN0aW9ucyA9IChjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gKiBb
XSkgew0KPiA+ICsgICAgICAgICZ2bXN0YXRlX3BtcCwNCj4gPiArICAgICAgICBOVUxMDQo+ID4g
ICAgICB9DQo+ID4gIH07DQo+ID4gLS0NCj4gPiAyLjE5LjENCj4gPg0KPiA+DQo=


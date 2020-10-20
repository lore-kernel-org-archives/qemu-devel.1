Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D940EC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBD522265
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBD522265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUqiS-0002Fm-7l
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 08:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUqgf-0001Wf-EB; Tue, 20 Oct 2020 08:24:21 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2550 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUqgd-0000L6-BS; Tue, 20 Oct 2020 08:24:21 -0400
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 568189413CF9E1705EDF;
 Tue, 20 Oct 2020 20:24:14 +0800 (CST)
Received: from DGGEMI422-HUB.china.huawei.com (10.1.199.151) by
 dggemi405-hub.china.huawei.com (10.3.17.143) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 20 Oct 2020 20:24:13 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 dggemi422-hub.china.huawei.com ([10.1.199.151]) with mapi id 14.03.0487.000;
 Tue, 20 Oct 2020 20:24:05 +0800
From: ganqixin <ganqixin@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH 00/10] Fix line over 80 characters warning
Thread-Topic: [PATCH 00/10] Fix line over 80 characters warning
Thread-Index: AQHWptCti2+LocN7wES+Gm5O7/e0H6mf0LeAgACY1aA=
Date: Tue, 20 Oct 2020 12:24:04 +0000
Message-ID: <A5B86EC83C48EF4CB2BC58BEF3A2F4960658E4E1@DGGEMI525-MBS.china.huawei.com>
References: <20201019203023.658555-1-ganqixin@huawei.com>
 <CAFEAcA-NPcXxh7QPtUtY5CornQjb-vTb_kCzRUSwMCZqkVVkBg@mail.gmail.com>
In-Reply-To: <CAFEAcA-NPcXxh7QPtUtY5CornQjb-vTb_kCzRUSwMCZqkVVkBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.184.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189; envelope-from=ganqixin@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:17:20
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
Cc: Laurent
 Vivier <lvivier@redhat.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgTWF5ZGVsbCBb
bWFpbHRvOnBldGVyLm1heWRlbGxAbGluYXJvLm9yZ10NCj4gU2VudDogVHVlc2RheSwgT2N0b2Jl
ciAyMCwgMjAyMCA3OjE1IFBNDQo+IFRvOiBnYW5xaXhpbiA8Z2FucWl4aW5AaHVhd2VpLmNvbT4N
Cj4gQ2M6IFFFTVUgRGV2ZWxvcGVycyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgUUVNVSBUcml2
aWFsDQo+IDxxZW11LXRyaXZpYWxAbm9uZ251Lm9yZz47IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+OyBQaGlsaXBwZQ0KPiBNYXRoaWV1LURhdWTDqSA8ZjRidWdAYW1zYXQub3Jn
PjsgTGF1cmVudCBWaXZpZXIgPGx2aXZpZXJAcmVkaGF0LmNvbT47DQo+IERhdmlkIEdpYnNvbiA8
ZGF2aWRAZ2lic29uLmRyb3BiZWFyLmlkLmF1PjsgQWxpc3RhaXIgRnJhbmNpcw0KPiA8YWxpc3Rh
aXIuZnJhbmNpc0B3ZGMuY29tPjsgQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3ZWku
Y29tPjsNCj4gWmhhbmdoYWlsaWFuZyA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDAwLzEwXSBGaXggbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMg
d2FybmluZw0KPiANCj4gT24gVHVlLCAyMCBPY3QgMjAyMCBhdCAxMjowMywgR2FuIFFpeGluIDxn
YW5xaXhpbkBodWF3ZWkuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhpIGFsbCwNCj4gPiAgICAgSSB1
c2VkIHNjcmlwdHMvY2hlY2twYXRjaC5wbCB0byBmaW5kIHRoYXQgbWFueSBmaWxlcyBpbiB0aGUg
aHcNCj4gPiBkaXJlY3RvcnkgY29udGFpbiBsaW5lcyB3aXRoIG1vcmUgdGhhbiA4MCBjaGFyYWN0
ZXJzLiBUaGVyZWZvcmUsIEkNCj4gPiBzcGxpdGVkIHNvbWUgbGluZXMgdG8gZml4IHRoaXMgd2Fy
bmluZy4NCj4gDQo+IEkgcGVyc29uYWxseSBoYXZlIGNvbWUgcm91bmQgdG8gdGhlIGlkZWEgdGhh
dCB3ZSBzaG91bGQgaW5zdGVhZCBhZGp1c3QNCj4gY2hlY2twYXRjaCBzbyB0aGF0IGl0IGRvZXNu
J3QgaGF2ZSBhIGhhcmQgODAgY2hhcmFjdGVyIGNvbXBsYWludCBsaW1pdC4NCj4gDQoNCkhpIFBl
dGVyLA0KICBJdCBzb3VuZHMgbGlrZSBhIGdvb2QgaWRlYSwgSSB0aGluayBJIGNhbiB0cnkgdG8g
bW9kaWZ5IGNoZWNrcGF0Y2gucGwgYnkgcmVmZXJyaW5nIHRvIHRoZSBMaW51eCBwYXRjaC4NCg0K
VGhhbmtzLA0KR2FuIFFpeGluDQoNCj4gQ29tcGFyZSB0aGUga2VybmVsIGNvZGluZyBzdHlsZSBj
aGFuZ2U6DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPQ0KPiBiZGM0OGZhMTFlNDZmODY3ZWE0ZDc1
ZmE1OWVlODdhN2Y0OGJlMTQ0DQo+IA0KPiB3aG9zZSByYXRpb25hbGUgSSBhZ3JlZSB3aXRoLiBX
ZSBzaG91bGQgKnByZWZlciogODAgY2hhcmFjdGVyIHdyYXBwaW5nLCBidXQNCj4gdGhlcmUgYXJl
IHNvbWUgcGxhY2VzIHdoZXJlIGFuIDg1LWNoYXJhY3RlciBsaW5lIGlzIG11Y2ggbW9yZSByZWFk
YWJsZSBhbmQNCj4gc2Vuc2libGUgc3R5bGUgdGhhbiBpbnNlcnRpbmcgYSBsaW5lIGJyZWFrIGp1
c3QgdG8gcGxlYXNlIGNoZWNrcGF0Y2guDQo+IA0KPiB0aGFua3MNCj4gLS0gUE1NDQo=


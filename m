Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C03C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 386CF20723
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 386CF20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSdxB-0005lE-7q
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 06:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kSdv2-0003oZ-1d; Wed, 14 Oct 2020 06:22:04 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2939 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kSduz-0005uI-J7; Wed, 14 Oct 2020 06:22:03 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 96F2283813DAAEB6B744;
 Wed, 14 Oct 2020 18:21:55 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 14 Oct 2020 18:21:55 +0800
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 14 Oct 2020 18:21:55 +0800
Received: from dggpemm000001.china.huawei.com ([7.185.36.245]) by
 dggpemm000001.china.huawei.com ([7.185.36.245]) with mapi id 15.01.1913.007;
 Wed, 14 Oct 2020 18:21:55 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Subject: RE: [PATCH V2 1/5] target/riscv: Add basic vmstate description of CPU
Thread-Topic: [PATCH V2 1/5] target/riscv: Add basic vmstate description of CPU
Thread-Index: AQHWntxJ5AggHdvtL0uIIsQkOTs3q6mQTSIAgAab+aA=
Date: Wed, 14 Oct 2020 10:21:54 +0000
Message-ID: <cbbaee32aaca498294e599ba7768279a@huawei.com>
References: <20201010080623.768-1-jiangyifei@huawei.com>
 <20201010080623.768-2-jiangyifei@huawei.com>
 <0bc022ca-35f6-8579-51f1-65005e89a9a3@linaro.org>
In-Reply-To: <0bc022ca-35f6-8579-51f1-65005e89a9a3@linaro.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 06:21:56
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJpY2hhcmQgSGVuZGVyc29u
IFttYWlsdG86cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZ10NCj4gU2VudDogU2F0dXJkYXks
IE9jdG9iZXIgMTAsIDIwMjAgOToyMyBQTQ0KPiBUbzogSmlhbmd5aWZlaSA8amlhbmd5aWZlaUBo
dWF3ZWkuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiBxZW11LXJpc2N2QG5vbmdudS5v
cmcNCj4gQ2M6IHBhbG1lckBkYWJiZWx0LmNvbTsgQWxpc3RhaXIuRnJhbmNpc0B3ZGMuY29tOw0K
PiBzYWdhcmtAZWVjcy5iZXJrZWxleS5lZHU7IGtiYXN0aWFuQG1haWwudW5pLXBhZGVyYm9ybi5k
ZTsgWmhhbmd4aWFvZmVuZw0KPiAoRikgPHZpY3Rvci56aGFuZ3hpYW9mZW5nQGh1YXdlaS5jb20+
OyBXdWJpbiAoSCkgPHd1Lnd1YmluQGh1YXdlaS5jb20+Ow0KPiBaaGFuZ2hhaWxpYW5nIDx6aGFu
Zy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBkZW5na2FpIChBKQ0KPiA8ZGVuZ2thaTFAaHVh
d2VpLmNvbT47IHlpbnlpcGVuZyA8eWlueWlwZW5nMUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIFYyIDEvNV0gdGFyZ2V0L3Jpc2N2OiBBZGQgYmFzaWMgdm1zdGF0ZSBkZXNjcmlw
dGlvbiBvZiBDUFUNCj4gDQo+IE9uIDEwLzEwLzIwIDM6MDYgQU0sIFlpZmVpIEppYW5nIHdyb3Rl
Og0KPiA+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHUuaA0KPiA+IEBAIC0zMTEsNiArMzExLDEwIEBA
IGV4dGVybiBjb25zdCBjaGFyICogY29uc3QgcmlzY3ZfZnByX3JlZ25hbWVzW107DQo+ID4gZXh0
ZXJuIGNvbnN0IGNoYXIgKiBjb25zdCByaXNjdl9leGNwX25hbWVzW107ICBleHRlcm4gY29uc3Qg
Y2hhciAqDQo+ID4gY29uc3QgcmlzY3ZfaW50cl9uYW1lc1tdOw0KPiA+DQo+ID4gKyNpZm5kZWYg
Q09ORklHX1VTRVJfT05MWQ0KPiA+ICtleHRlcm4gY29uc3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZt
c3RhdGVfcmlzY3ZfY3B1OyAjZW5kaWYNCj4gPiArDQo+IA0KPiBUaGlzIGlzIG5vdCBwYXJ0IG9m
IHRoZSBwdWJsaWMgaW50ZXJmYWNlIHRvIFJJU0NWQ1BVLCBzbyBpdCBzaG91bGQgZ28gaW4NCj4g
aW50ZXJuYWxzLmguDQo+IA0KPiBOb3QgdGhhdCB0aGVyZSBhcmVuJ3Qgb3RoZXIgdGhpbmdzIGlu
IGNwdS5oIHRoYXQgZG9uJ3QgYmVsb25nLiAgTm8gdGFyZ2V0IGhhcw0KPiBiZWVuIHBlcmZlY3Qg
aW4gZGlmZmVyZW50aWF0aW5nIHdoYXQncyBpbnRlcmZhY2UgYW5kIHdoYXQncyBpbXBsZW1lbnRh
dGlvbi4NCj4gDQoNClllcywgSSB0aGluayBpdCBzaG91bGQgZ28gaW4gaW50ZXJuYWxzLmgsIGFs
dGhvdWdoIG1vc3QgYXJjaGl0ZWN0dXJlcyBkZWNsYXJlIGl0IGluIGNwdS5oLg0KSSB3b3VsZCBt
b3ZlIGl0IHRvIGludGVybmFscy5oIGluIHRoZSBuZXh0IHNlcmllcy4NCg0KPiA+ICsNCj4gPiAr
I2lmZGVmIFRBUkdFVF9SSVNDVjMyDQo+ID4gKyAgICAgICAgVk1TVEFURV9VSU5UVEwoZW52Lm1z
dGF0dXNoLCBSSVNDVkNQVSksICNlbmRpZg0KPiANCj4gV291bGQgdGhpcyBiZSBhIGdvb2QgdGlt
ZSB0byBleHBhbmQgbXN0YXR1cyB0byB1aW50NjRfdCBpbnN0ZWFkIG9mDQo+IHRhcmdldF91bG9u
ZyBzbyB0aGF0IGl0IGNhbiBiZSBzYXZlZCBhcyBvbmUgdW5pdCBhbmQgcmVkdWNlIHNvbWUgaWZk
ZWZzIGluIHRoZQ0KPiBjb2RlIGJhc2U/DQo+IA0KPiBTaW1pbGFybHkgd2l0aCBzb21lIG9mIHRo
ZSBvdGhlciBzdGF0dXMgcmVnaXN0ZXJzIHRoYXQgYXJlIHR3byBoYWx2ZWQgZm9yDQo+IHJpc2N2
MzIuDQoNCkkgYWdyZWUgd2l0aCB5b3UgdGhhdCBpdCBzaG91bGQgYmUgcmVhcnJhbmdlZC4NCkJ1
dCBJIGhvcGUgdGhpcyBzZXJpZXMgd2lsbCBmb2N1cyBvbiBhY2hpZXZpbmcgbWlncmF0aW9uLg0K
Q2FuIEkgc2VuZCBhbm90aGVyIHBhdGNoIHRvIHJlYXJyYW5nZSBpdCBsYXRlcj8NCg0KWWlmZWkN
Cj4gDQo+IA0KPiByfg0K


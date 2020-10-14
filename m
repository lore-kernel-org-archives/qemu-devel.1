Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA452C43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A2262068E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2262068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSdmK-0008Ue-KN
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 06:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kSdl5-00082t-3B; Wed, 14 Oct 2020 06:11:47 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:46518 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kSdl1-0004aJ-SU; Wed, 14 Oct 2020 06:11:46 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id EAB0B478FCF32D31E9A9;
 Wed, 14 Oct 2020 18:11:26 +0800 (CST)
Received: from dggemm753-chm.china.huawei.com (10.1.198.59) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 14 Oct 2020 18:11:21 +0800
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemm753-chm.china.huawei.com (10.1.198.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 14 Oct 2020 18:11:21 +0800
Received: from dggpemm000001.china.huawei.com ([7.185.36.245]) by
 dggpemm000001.china.huawei.com ([7.185.36.245]) with mapi id 15.01.1913.007;
 Wed, 14 Oct 2020 18:11:21 +0800
From: Jiangyifei <jiangyifei@huawei.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Subject: RE: [PATCH V2] target/riscv: raise exception to HS-mode at
 get_physical_address
Thread-Topic: [PATCH V2] target/riscv: raise exception to HS-mode at
 get_physical_address
Thread-Index: AQHWnhHnXPtMgSAunEGXhyDV2VmGsamO0FUAgAgXmEA=
Date: Wed, 14 Oct 2020 10:11:21 +0000
Message-ID: <ae815b3a9fda468e839cecf6fbfc0a6e@huawei.com>
References: <20201009075740.688-1-jiangyifei@huawei.com>
 <26316865-1a25-0e12-ee65-76d79e26603d@linaro.org>
In-Reply-To: <26316865-1a25-0e12-ee65-76d79e26603d@linaro.org>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 06:11:27
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
IFttYWlsdG86cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZ10NCj4gU2VudDogRnJpZGF5LCBP
Y3RvYmVyIDksIDIwMjAgMTA6MzQgUE0NCj4gVG86IEppYW5neWlmZWkgPGppYW5neWlmZWlAaHVh
d2VpLmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsNCj4gcWVtdS1yaXNjdkBub25nbnUub3Jn
DQo+IENjOiBaaGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+Ow0K
PiBzYWdhcmtAZWVjcy5iZXJrZWxleS5lZHU7IGtiYXN0aWFuQG1haWwudW5pLXBhZGVyYm9ybi5k
ZTsgWmhhbmd4aWFvZmVuZw0KPiAoRikgPHZpY3Rvci56aGFuZ3hpYW9mZW5nQGh1YXdlaS5jb20+
OyBBbGlzdGFpci5GcmFuY2lzQHdkYy5jb207IHlpbnlpcGVuZw0KPiA8eWlueWlwZW5nMUBodWF3
ZWkuY29tPjsgcGFsbWVyQGRhYmJlbHQuY29tOyBXdWJpbiAoSCkNCj4gPHd1Lnd1YmluQGh1YXdl
aS5jb20+OyBkZW5na2FpIChBKSA8ZGVuZ2thaTFAaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBWMl0gdGFyZ2V0L3Jpc2N2OiByYWlzZSBleGNlcHRpb24gdG8gSFMtbW9kZSBhdA0K
PiBnZXRfcGh5c2ljYWxfYWRkcmVzcw0KPiANCj4gT24gMTAvOS8yMCAyOjU3IEFNLCBZaWZlaSBK
aWFuZyB3cm90ZToNCj4gPiAgI2RlZmluZSBUUkFOU0xBVEVfRkFJTCAxDQo+ID4gICNkZWZpbmUg
VFJBTlNMQVRFX1NVQ0NFU1MgMA0KPiA+ICAjZGVmaW5lIE1NVV9VU0VSX0lEWCAzDQo+ID4gKyNk
ZWZpbmUgVFJBTlNMQVRFX0dfU1RBR0VfRkFJTCA0DQo+IA0KPiBOb3RlIHRoYXQgeW91J3JlIGlu
dGVybGVhdmluZyBUUkFOU0xBVEVfKiBhcm91bmQgYW4gdW5yZWxhdGVkIGRlZmluZS4NCj4gUGVy
aGFwcyByZWFycmFuZ2UgdG8NCj4gDQo+IGVudW0gew0KPiAgICAgVFJBTlNMQVRFX1NVQ0NFU1Mg
PSAwLA0KPiAgICAgVFJBTlNMQVRFX0ZBSUwsDQo+ICAgICBUUkFOU0xBVEVfUE1QX0ZBSUwsDQo+
ICAgICBUUkFOU0xBVEVfR19TVEFHRV9GQUlMLA0KPiB9Ow0KPiANCg0KT0sNCg0KPiANCj4gPiAr
KysgYi90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jDQo+ID4gQEAgLTQ1MSw3ICs0NTEsMTAgQEAg
cmVzdGFydDoNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIG1tdV9pZHgsDQo+IGZhbHNlLA0KPiA+IHRydWUpOw0KPiA+DQo+ID4gICAgICAgICAg
ICAgIGlmICh2YmFzZV9yZXQgIT0gVFJBTlNMQVRFX1NVQ0NFU1MpIHsNCj4gPiAtICAgICAgICAg
ICAgICAgIHJldHVybiB2YmFzZV9yZXQ7DQo+ID4gKyAgICAgICAgICAgICAgICBlbnYtPmd1ZXN0
X3BoeXNfZmF1bHRfYWRkciA9IChiYXNlIHwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIChhZGRyICYNCj4gPiArDQo+IChUQVJHRVRfUEFHRV9TSVpF
IC0gMSkpKSA+PiAyOw0KPiA+ICsgICAgICAgICAgICAgICAgcmV0dXJuIFRSQU5TTEFURV9HX1NU
QUdFX0ZBSUw7DQo+ID4gICAgICAgICAgICAgIH0NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgeW91IGNh
biBtYWtlIHRoaXMgY2hhbmdlIHRvIGNwdSBzdGF0ZSwgYXMgdGhpcyBmdW5jdGlvbiBpcyBhbHNv
IHVzZWQNCj4gYnkgZ2RiLiAgSSB0aGluayB5b3UnbGwgbmVlZCB0byBhZGQgYSBuZXcgKHRhcmdl
dF91bG9uZyAqKSBwYXJhbWV0ZXIgdG8NCj4gZ2V0X3BoeXNpY2FsX2FkZHJlc3MgdG8gcmV0dXJu
IHRoaXMuDQo+IA0KPiBUaGUgdXNhZ2UgaW4gcmlzY3ZfY3B1X3RsYl9maWxsIGNvdWxkIHBhc3Mg
JmVudi0+Z3Vlc3RfcGh5c19mYXVsdF9hZGRyLCBhbmQNCj4gdGhlIHVzYWdlIGluIHJpc2N2X2Nw
dV9nZXRfcGh5c19wYWdlX2RlYnVnIGNvdWxkIHBhc3MgdGhlIGFkZHJlc3Mgb2YgYSBsb2NhbA0K
PiB2YXJpYWJsZSAod2hpY2ggaXQgdGhlbiBpZ25vcmVzKS4NCj4gDQoNCk9LDQoNCj4gQWxzbywg
aXNuJ3QgdGhlIG9mZnNldCBtb3JlIG5hdHVyYWxseSB3cml0dGVuIGlkeCAqIHB0ZXNpemUsIGFz
IHNlZW4ganVzdCBhIGZldw0KPiBsaW5lcyBiZWxvdz8NCg0KT0sNCg0KPiANCj4gPiArICAgICAg
ICBpZiAocmV0ICE9IFRSQU5TTEFURV9GQUlMICYmIHJldCAhPSBUUkFOU0xBVEVfR19TVEFHRV9G
QUlMKSB7DQo+IA0KPiBTaG91bGQgdGhpcyBub3QgYmUgcmV0ID09IFRSQU5TTEFURV9TVUNDRVNT
Pw0KPiBUaGlzIGxvb2tzIGJ1Z2d5IHdpdGggVFJBTlNMQVRFX1BNUF9GQUlMLi4uDQoNCk9uIFRS
QU5TTEFURV9QTVBfRkFJTCwgaXQgc2hvdWxkIG5vdCBleGVjdXRlIEctc3RhZ2UgdHJhbnNsYXRp
b24uDQpTbyBJIHRoaW5rIGl0IGlzIG9rIGZvciAncmV0ID09IFRSQU5TTEFURV9TVUNDRVNTJw0K
DQpJIHdpbGwgc2VuZCBWMy4NCg0KWWlmZWkNCg0KPiANCj4gDQo+IHJ+DQo=


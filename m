Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0204CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:05:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF292072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:05:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF292072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7epW-0005uq-3Q
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 09:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1k7eon-0005Dz-DV; Mon, 17 Aug 2020 09:04:53 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2532 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1k7eol-00036D-5l; Mon, 17 Aug 2020 09:04:53 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 401D5BDAF7469904C6B9;
 Mon, 17 Aug 2020 21:04:34 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 17 Aug 2020 21:04:33 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.129]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0487.000;
 Mon, 17 Aug 2020 21:04:28 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH 08/11] tcg/optimize: Remove redundant statement in
 tcg_optimize()
Thread-Topic: [PATCH 08/11] tcg/optimize: Remove redundant statement in
 tcg_optimize()
Thread-Index: AQHWcUTH2Y7VXUemDEOWXcrz0b7Qcqk1s16AgAaK1KA=
Date: Mon, 17 Aug 2020 13:04:27 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B8B60E4@dggemm531-mbx.china.huawei.com>
References: <20200813073712.4001404-1-kuhn.chenqun@huawei.com>
 <20200813073712.4001404-9-kuhn.chenqun@huawei.com>
 <800035ed-a522-a974-1c1d-437efe7ff25b@linaro.org>
In-Reply-To: <800035ed-a522-a974-1c1d-437efe7ff25b@linaro.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.187.50]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 09:04:35
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
Cc: Richard Henderson <rth@twiddle.net>, Pannengyuan <pannengyuan@huawei.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+IGRpZmYgLS1naXQgYS90Y2cvb3B0aW1pemUuYyBiL3RjZy9vcHRpbWl6ZS5jIGluZGV4DQo+
ID4gNTNhYThlNTMyOS4uZDViZWEzNzI5MCAxMDA2NDQNCj4gPiAtLS0gYS90Y2cvb3B0aW1pemUu
Yw0KPiA+ICsrKyBiL3RjZy9vcHRpbWl6ZS5jDQo+ID4gQEAgLTEyNjQsNyArMTI2NCw2IEBAIHZv
aWQgdGNnX29wdGltaXplKFRDR0NvbnRleHQgKnMpDQo+ID4gICAgICAgICAgICAgICAgICBvcC0+
b3BjID0gb3BjID0gKG9wYyA9PSBJTkRFWF9vcF9tb3Zjb25kX2kzMg0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA/IElOREVYX29wX3NldGNvbmRfaTMyDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDogSU5ERVhfb3Bfc2V0Y29uZF9pNjQpOw0KPiA+
IC0gICAgICAgICAgICAgICAgbmJfaWFyZ3MgPSAyOw0KPiA+ICAgICAgICAgICAgICB9DQo+ID4g
ICAgICAgICAgICAgIGdvdG8gZG9fZGVmYXVsdDsNCj4gDQo+IEkgcHJlZmVyIG5vdCB0byBtYWtl
IHRoaXMgY2hhbmdlLg0KPiANCj4gbmJfaWFyZ3MgaXMgdGhlIGNhY2hlZCB2YWx1ZSB0aGF0IGNv
cnJlc3BvbmRzIHRvIG9wYywgd2hpY2ggd2UgaGF2ZSBqdXN0DQo+IGNoYW5nZWQuICBJZiB3ZSBs
YXRlciBtYWtlIGEgY2hhbmdlIGF0ICJkb19kZWZhdWx0IiB0aGF0IHVzZXMgbmJfaWFyZ3MsDQo+
IGZhaWx1cmUgdG8gdXBkYXRlIHRoZSB2YWx1ZSBoZXJlIHdpbGwgYmUgYSB2ZXJ5IGhhcmQgYnVn
IHRvIGZpbmQuDQpIaSBSaWNoYXJkLA0KDQogIEkgdGhpbmsgeW91J3JlIHRoaW5raW5nIG1vcmUg
Y2FyZWZ1bGx5LCBldmVuIHRob3VnaCAnIG5iX2lhcmdzJyBub3QgdXNlZCBpbiAnZG9fZGVmYXVs
dCcgbm93Lg0KDQpIb3dldmVyLCBJIGhhdmUgb25seSBvbmUgc21hbGwgcXVlc3Rpb24uIFdoeSBk
b2VzICduYl9pYXJncycgbmVlZCB0byBiZSBhc3NpZ25lZCBhIHZhbHVlIGZvciB0aGlzIGNhc2Ug
YnJhbmNoPw0KT3RoZXIgYnJhbmNoZXMoZWc6JyBDQVNFX09QXzMyXzY0KGJyY29uZCknKSBoYXZl
IGNoYW5nZWQgdGhlIG9wYyB2YWx1ZSB0b28uIERvIHdlIG5lZWQgdG8gYXNzaWduIGEgdmFsdWUg
dG8gbmJfaWFyZ3MgZm9yIGl0Pw0KDQpUaGFua3MuDQo=


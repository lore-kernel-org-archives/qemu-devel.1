Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2774EC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C67206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 02:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C67206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAlPR-0006oV-4A
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 22:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kAlOs-0006Id-Pw; Tue, 25 Aug 2020 22:42:58 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2533 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kAlOq-00033w-9R; Tue, 25 Aug 2020 22:42:58 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id D6A79902BBDB066998AC;
 Wed, 26 Aug 2020 10:42:45 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 26 Aug 2020 10:42:45 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.141]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0487.000;
 Wed, 26 Aug 2020 10:42:37 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v2 03/10] target/arm/translate-a64:Remove dead
 assignment in handle_scalar_simd_shli()
Thread-Topic: [PATCH v2 03/10] target/arm/translate-a64:Remove dead
 assignment in handle_scalar_simd_shli()
Thread-Index: AQHWetKHlCk5CuE1o0+ZVVgokc3Y46lIPU0AgAFxfxA=
Date: Wed, 26 Aug 2020 02:42:37 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B8E2491@dggemm511-mbx.china.huawei.com>
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-4-kuhn.chenqun@huawei.com>
 <CAFEAcA9mbQmGRNqJC7FmV8gBi3XOuMmYRVhWmczZPTuTW9tfVw@mail.gmail.com>
In-Reply-To: <CAFEAcA9mbQmGRNqJC7FmV8gBi3XOuMmYRVhWmczZPTuTW9tfVw@mail.gmail.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 22:42:46
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
 QEMU Trivial <qemu-trivial@nongnu.org>, Pannengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiBPbiBUdWUsIDI1IEF1ZyAyMDIwIGF0IDEyOjI2LCBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1
YXdlaS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQ2xhbmcgc3RhdGljIGNvZGUgYW5hbHl6ZXIgc2hv
dyB3YXJuaW5nOg0KPiA+IHRhcmdldC9hcm0vdHJhbnNsYXRlLWE2NC5jOjg2MzU6MTQ6IHdhcm5p
bmc6IFZhbHVlIHN0b3JlZCB0byAndGNnX3JuJw0KPiA+IGR1cmluZyBpdHMgIGluaXRpYWxpemF0
aW9uIGlzIG5ldmVyIHJlYWQNCj4gPiAgICAgVENHdl9pNjQgdGNnX3JuID0gbmV3X3RtcF9hNjQo
cyk7DQo+ID4gICAgICAgICAgICAgIF5+fn5+fiAgIH5+fn5+fn5+fn5+fn5+DQo+ID4gdGFyZ2V0
L2FybS90cmFuc2xhdGUtYTY0LmM6ODYzNjoxNDogd2FybmluZzogVmFsdWUgc3RvcmVkIHRvICd0
Y2dfcmQnDQo+ID4gZHVyaW5nIGl0cyAgaW5pdGlhbGl6YXRpb24gaXMgbmV2ZXIgcmVhZA0KPiA+
ICAgICBUQ0d2X2k2NCB0Y2dfcmQgPSBuZXdfdG1wX2E2NChzKTsNCj4gPiAgICAgICAgICAgICAg
Xn5+fn5+ICAgfn5+fn5+fn5+fn5+fn4NCj4gPg0KPiA+IFRoZXJlIGlzIGEgbWVtb3J5IGxlYWsg
Zm9yIHRoZSB2YXJpYWJsZSBuZXdfdG1wX2E2NCAicyIuDQo+IA0KPiBUaGVyZSBpcyBub3QsIGJl
Y2F1c2UgVENHIHRlbXBzIGFsbG9jYXRlZCB2aWEgbmV3X3RtcF9hNjQoKSBhcmUgYWxsIGZyZWVk
IHZpYQ0KPiBmcmVlX3RtcF9hNjQoKSBhdCB0aGUgZW5kIG9mIGRpc2FzX2E2NF9pbnNuKCkuDQo+
IA0KT0ssIEknbGwgZGVsZXRlIHRoYXQgZGVzY3JpcHRpb24gbGF0ZXIuDQoNClRoYW5rcywNCkNo
ZW5RdW4NCg==


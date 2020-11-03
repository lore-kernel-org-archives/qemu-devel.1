Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CC2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE5C206F1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 10:45:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE5C206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZtok-0006js-TA
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 05:45:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kZtnq-0005tT-FA; Tue, 03 Nov 2020 05:44:38 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kZtno-0007o4-2r; Tue, 03 Nov 2020 05:44:38 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CQRHL680rzQmtC;
 Tue,  3 Nov 2020 18:44:30 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0487.000;
 Tue, 3 Nov 2020 18:44:23 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH 0/6] fix uninitialized variable warning
Thread-Topic: [PATCH 0/6] fix uninitialized variable warning
Thread-Index: AQHWsYQK80SH2zv/JEWjnKsR4D/51qm1q04AgACKTmA=
Date: Tue, 3 Nov 2020 10:44:23 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA265A9@dggemm531-mbx.china.huawei.com>
References: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
 <CAFEAcA-P8iM1PpKajNv7R3EOtFrM6_bWg9Lo_YRY87E+D2uKZQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-P8iM1PpKajNv7R3EOtFrM6_bWg9Lo_YRY87E+D2uKZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga02-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 05:44:32
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, ganqixin <ganqixin@huawei.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBNYXlkZWxsIFttYWls
dG86cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnXQ0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAz
LCAyMDIwIDY6MTUgUE0NCj4gVG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2Vp
LmNvbT4NCj4gQ2M6IFFFTVUgRGV2ZWxvcGVycyA8cWVtdS1kZXZlbEBub25nbnUub3JnPjsgUUVN
VSBUcml2aWFsDQo+IDxxZW11LXRyaXZpYWxAbm9uZ251Lm9yZz47IFpoYW5naGFpbGlhbmcNCj4g
PHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IGdhbnFpeGluIDxnYW5xaXhpbkBodWF3
ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDAvNl0gZml4IHVuaW5pdGlhbGl6ZWQgdmFy
aWFibGUgd2FybmluZw0KPiANCj4gT24gVHVlLCAzIE5vdiAyMDIwIGF0IDAyOjA3LCBDaGVuIFF1
biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgYWxsLA0KPiA+
ICAgVGhlcmUgYXJlIHNvbWUgdmFyaWFibGVzIGluaXRpYWxpemVkIHdhcm5pbmdzIHJlcG9ydGVk
IGJ5IHRoZQ0KPiA+IGNvbXBpbGVyLCBldmVuIGlmIHRoZSBkZWZhdWx0IENGTEFHIGZvciB0aGUg
Y29tcGlsZXIgcGFyYW1ldGVycyBhcmUgdWVzZWQuDQo+ID4NCj4gPiBUaGlzIHNlcmlhbCBoYXMg
YWRkZWQgc29tZSBkZWZhdWx0IHZhbHVlcyBvciBjaGFuZ2VkIHRoZSBhc3NpZ25tZW50IHBsYWNl
cw0KPiBmb3IgdGhlIHZhcmlhYmxpZXMgdG8gZml4IHRoZW0uDQo+IA0KPiANCj4gSGk7IGlmIHlv
dSdyZSByZXBvcnRpbmcvZml4aW5nIGNvbXBpbGVyIGVycm9ycy93YXJuaW5ncyBwbGVhc2UgY2Fu
IHlvdSBpbmNsdWRlDQo+IHRoZSBjb21waWxlciB2ZXJzaW9uIHRoYXQgcHJvZHVjZWQgdGhlIGVy
cm9yIGluIHRoZSBjb21taXQgbWVzc2FnZT8gVGhpcyBpcw0KPiBoZWxwZnVsIGZvciB0ZWxsaW5n
IHVzIHdoZXRoZXIgaXQncyBhIHByb2JsZW0gd2l0aCBvbGRlciBjb21waWxlcnMgb3Igd2hldGhl
ciB0aGlzDQo+IGlzIGEgbmV3IGNvbXBpbGVyIHRoYXQgY2hlY2tzIGZvciBzb21lIHRoaW5ncyBt
b3JlIGNhcmVmdWxseS4NCj4gDQpPb3BzLCBJIGRpZG4ndCBjb25zaWRlciB0aGF0LiANClRoZXNl
IHdhcm5pbmdzIHdlcmUgcmVwb3J0ZWQgYnkgR0NDIDkuMywgDQoNClRoYW5rcywNCkNoZW4gUXVu
DQoNCg==


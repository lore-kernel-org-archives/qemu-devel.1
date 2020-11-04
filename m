Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F37C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88BDC21556
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BDC21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaBgR-0000tI-5G
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kaBfa-0000LW-It; Wed, 04 Nov 2020 00:49:18 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kaBfW-00077H-On; Wed, 04 Nov 2020 00:49:18 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CQwgw2crRzVknV;
 Wed,  4 Nov 2020 13:49:00 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.225]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0487.000;
 Wed, 4 Nov 2020 13:49:02 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>, "lvivier@redhat.com" <lvivier@redhat.com>
Subject: RE: [PATCH RESEND v2 0/7] some memleak trivial patchs
Thread-Topic: [PATCH RESEND v2 0/7] some memleak trivial patchs
Thread-Index: AQHWqQOAYexAkoH4WUOcMVYmxKZpOamv9+ywgAeRBtA=
Date: Wed, 4 Nov 2020 05:49:01 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83BA2B5E7@dggemm531-mbx.china.huawei.com>
References: <20201023061218.2080844-1-kuhn.chenqun@huawei.com> 
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.185.149]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga01-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 00:49:08
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Pannengyuan <pannengyuan@huawei.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>, ganqixin <ganqixin@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGluZyENCg0KSGkgTGF1cmVudCwNCiAgVGhlc2UgcGF0Y2hlcyBoYXZlIGJlZW4gcmV2aWV3ZWQg
YnkgbWFueSBwZW9wbGUgMiBtb250aHMgYWdvLiANCkNvdWxkIHlvdSBoZWxwIGFkZCB0aGVtIHRv
IHRoZSB0cml2aWFsIGJyYW5jaD8NCg0KIFBhbiBOZW5neXVhbiAoNik6DQogICBxZ2EvY2hhbm5l
bC1wb3NpeDogUGx1ZyBtZW1vcnkgbGVhayBpbiBnYV9jaGFubmVsX3dyaXRlX2FsbCgpDQogICBl
bGYyZG1wL3FlbXVfZWxmOiBQbHVnIG1lbWxlYWsgaW4gUUVNVV9FbGZfaW5pdA0KICAgZWxmMmRt
cC9wZGI6IFBsdWcgbWVtbGVhayBpbiBwZGJfaW5pdF9mcm9tX2ZpbGUNCiAgIG1pZ3JhdGlvbi9j
b2xvOiBQbHVnIG1lbWxlYWtzIGluIGNvbG9fcHJvY2Vzc19pbmNvbWluZ190aHJlYWQNCiAgIGJs
b2NrZGV2OiBGaXggYSBtZW1sZWFrIGluIGRyaXZlX2JhY2t1cF9wcmVwYXJlKCkNCiAgIGJsb2Nr
L2ZpbGUtcG9zaXg6IGZpeCBhIHBvc3NpYmxlIHVuZGVmaW5lZCBiZWhhdmlvcg0KDQpUaGFua3Oj
rA0KQ2hlbiBRdW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDaGVu
cXVuIChrdWhuKQ0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMzAsIDIwMjAgNjoyMyBQTQ0KPiBU
bzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZw0KPiBDYzog
UGFubmVuZ3l1YW4gPHBhbm5lbmd5dWFuQGh1YXdlaS5jb20+OyBsdml2aWVyQHJlZGhhdC5jb207
DQo+IFpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IGdhbnFp
eGluDQo+IDxnYW5xaXhpbkBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIFJFU0VO
RCB2MiAwLzddIHNvbWUgbWVtbGVhayB0cml2aWFsIHBhdGNocw0KPiANCj4gUGluZyENCj4gDQo+
IEhpIGFsbCwNCj4gICBUaGUgcGF0Y2hlMiB+NyBoYXZlIGJlZW4gcmV2aWV3ZWQgZm9yIHNvbWUg
dGltZS4NCj4gQ291bGQgc29tZW9uZSBwbGVhc2UgcGljayBpdCB1cKO/DQo+IA0KPiBUaGFua3Ms
DQo+IENoZW4gUXVuDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJv
bTogQ2hlbnF1biAoa3VobikNCj4gPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjMsIDIwMjAgMjox
MiBQTQ0KPiA+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUu
b3JnDQo+ID4gQ2M6IFBhbm5lbmd5dWFuIDxwYW5uZW5neXVhbkBodWF3ZWkuY29tPjsgbHZpdmll
ckByZWRoYXQuY29tOw0KPiA+IFpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVh
d2VpLmNvbT47IGdhbnFpeGluDQo+ID4gPGdhbnFpeGluQGh1YXdlaS5jb20+OyBDaGVucXVuIChr
dWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+ID4gU3ViamVjdDogW1BBVENIIFJFU0VO
RCB2MiAwLzddIHNvbWUgbWVtbGVhayB0cml2aWFsIHBhdGNocw0KPiA+DQo+ID4gSGkgYWxsLA0K
PiA+DQo+ID4gICBIZXJlIGFyZSBzb21lIG1lbW9yeSBsZWFrIHBhdGNoZXMgcmVwb3J0ZWQgYnkg
RXVsZXJSb2JvdC4NCj4gPiBTb21lIHBhdGNoIHN1Ym1pc3Npb25zIGhhdmUgYmVlbiB1bmF0dGVu
ZGVkIGZvciBhIHdoaWxlIGFuZCBJIHJlc2VuZCB0aGVtLg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+
IENoZW4gUXVuDQo+ID4NCj4gPg0KPiA+IENoZW4gUXVuICgxKToNCj4gPiAgIHRlc3RzL21pZ3Jh
dGlvbjogZml4IG1lbWxlYWsgaW4gd2FpdF9jb21tYW5kL3dhaXRfY29tbWFuZF9mZA0KPiA+DQo+
ID4gUGFuIE5lbmd5dWFuICg2KToNCj4gPiAgIHFnYS9jaGFubmVsLXBvc2l4OiBQbHVnIG1lbW9y
eSBsZWFrIGluIGdhX2NoYW5uZWxfd3JpdGVfYWxsKCkNCj4gPiAgIGVsZjJkbXAvcWVtdV9lbGY6
IFBsdWcgbWVtbGVhayBpbiBRRU1VX0VsZl9pbml0DQo+ID4gICBlbGYyZG1wL3BkYjogUGx1ZyBt
ZW1sZWFrIGluIHBkYl9pbml0X2Zyb21fZmlsZQ0KPiA+ICAgbWlncmF0aW9uL2NvbG86IFBsdWcg
bWVtbGVha3MgaW4gY29sb19wcm9jZXNzX2luY29taW5nX3RocmVhZA0KPiA+ICAgYmxvY2tkZXY6
IEZpeCBhIG1lbWxlYWsgaW4gZHJpdmVfYmFja3VwX3ByZXBhcmUoKQ0KPiA+ICAgYmxvY2svZmls
ZS1wb3NpeDogZml4IGEgcG9zc2libGUgdW5kZWZpbmVkIGJlaGF2aW9yDQo+ID4NCj4gPiAgYmxv
Y2svZmlsZS1wb3NpeC5jICAgICAgICAgICAgICB8ICAyICstDQo+ID4gIGJsb2NrZGV2LmMgICAg
ICAgICAgICAgICAgICAgICAgfCAgMSArDQo+ID4gIGNvbnRyaWIvZWxmMmRtcC9wZGIuYyAgICAg
ICAgICAgfCAgMSArDQo+ID4gIGNvbnRyaWIvZWxmMmRtcC9xZW11X2VsZi5jICAgICAgfCAgMSAr
DQo+ID4gIG1pZ3JhdGlvbi9jb2xvLmMgICAgICAgICAgICAgICAgfCAgNSArKysrLQ0KPiA+ICBx
Z2EvY2hhbm5lbC1wb3NpeC5jICAgICAgICAgICAgIHwgIDYgKysrKystDQo+ID4gIHRlc3RzL3F0
ZXN0L21pZ3JhdGlvbi1oZWxwZXJzLmMgfCAxNiArKysrKysrKysrKystLS0tDQo+ID4gIDcgZmls
ZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IC0t
DQo+ID4gMi4yMy4wDQoNCg==


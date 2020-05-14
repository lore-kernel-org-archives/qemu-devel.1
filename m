Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06425C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA0162065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0162065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDHI-0001s5-VY
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZDEz-0007SU-0Q
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:45:33 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2088 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZDEx-00005E-0g
 for qemu-devel@nongnu.org; Thu, 14 May 2020 08:45:32 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 70E06530A5CD4660889B;
 Thu, 14 May 2020 20:45:21 +0800 (CST)
Received: from dggeme706-chm.china.huawei.com (10.1.199.102) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 14 May 2020 20:45:20 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 14 May 2020 20:45:20 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Thu, 14 May 2020 20:45:20 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDMvNl0gbWlncmF0aW9uL2NvbG8uYzogRmx1c2ggcmFt?=
 =?gb2312?Q?_cache_only_after_receiving_device_state?=
Thread-Topic: [PATCH 3/6] migration/colo.c: Flush ram cache only after
 receiving device state
Thread-Index: AQHWJ4Ta1+qwh4Qsu0+OmYrCIsg0B6iniRbQ
Date: Thu, 14 May 2020 12:45:20 +0000
Message-ID: <ccbdcf61094749729337b86251b920d8@huawei.com>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <3289d007d494cb0e2f05b1cf4ae6a78d300fede3.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <3289d007d494cb0e2f05b1cf4ae6a78d300fede3.1589193382.git.lukasstraub2@web.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 08:45:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 MIME_CHARSET_FARAWAY=2.45, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UmV2aWV3ZWQtYnk6IHpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNv
bT4NCg0KPiANCj4gSWYgd2Ugc3VjZWVkIGluIHJlY2VpdmluZyByYW0gc3RhdGUsIGJ1dCBmYWls
IHJlY2VpdmluZyB0aGUgZGV2aWNlIHN0YXRlLCB0aGVyZQ0KPiB3aWxsIGJlIGEgbWlzbWF0Y2gg
YmV0d2VlbiB0aGUgdHdvLg0KPiANCj4gRml4IHRoaXMgYnkgZmx1c2hpbmcgdGhlIHJhbSBjYWNo
ZSBvbmx5IGFmdGVyIHRoZSB2bXN0YXRlIGhhcyBiZWVuIHJlY2VpdmVkLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTHVrYXMgU3RyYXViIDxsdWthc3N0cmF1YjJAd2ViLmRlPg0KPiAtLS0NCj4gIG1p
Z3JhdGlvbi9jb2xvLmMgfCAxICsNCj4gIG1pZ3JhdGlvbi9yYW0uYyAgfCA1ICstLS0tDQo+ICBt
aWdyYXRpb24vcmFtLmggIHwgMSArDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vY29sby5jIGIv
bWlncmF0aW9uL2NvbG8uYyBpbmRleA0KPiA2YjJhZDM1YWE0Li4yOTQ3MzYzYWU1IDEwMDY0NA0K
PiAtLS0gYS9taWdyYXRpb24vY29sby5jDQo+ICsrKyBiL21pZ3JhdGlvbi9jb2xvLmMNCj4gQEAg
LTczOSw2ICs3MzksNyBAQCBzdGF0aWMgdm9pZA0KPiBjb2xvX2luY29taW5nX3Byb2Nlc3NfY2hl
Y2twb2ludChNaWdyYXRpb25JbmNvbWluZ1N0YXRlICptaXMsDQo+IA0KPiAgICAgIHFlbXVfbXV0
ZXhfbG9ja19pb3RocmVhZCgpOw0KPiAgICAgIHZtc3RhdGVfbG9hZGluZyA9IHRydWU7DQo+ICsg
ICAgY29sb19mbHVzaF9yYW1fY2FjaGUoKTsNCj4gICAgICByZXQgPSBxZW11X2xvYWRfZGV2aWNl
X3N0YXRlKGZiKTsNCj4gICAgICBpZiAocmV0IDwgMCkgew0KPiAgICAgICAgICBlcnJvcl9zZXRn
KGVycnAsICJDT0xPOiBsb2FkIGRldmljZSBzdGF0ZSBmYWlsZWQiKTsgZGlmZiAtLWdpdA0KPiBh
L21pZ3JhdGlvbi9yYW0uYyBiL21pZ3JhdGlvbi9yYW0uYyBpbmRleCAwNGYxM2ZlYjJlLi41YmFl
YzVmY2U5IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmFtLmMNCj4gKysrIGIvbWlncmF0aW9u
L3JhbS5jDQo+IEBAIC0zMzEzLDcgKzMzMTMsNyBAQCBzdGF0aWMgYm9vbCBwb3N0Y29weV9pc19y
dW5uaW5nKHZvaWQpDQo+ICAgKiBGbHVzaCBjb250ZW50IG9mIFJBTSBjYWNoZSBpbnRvIFNWTSdz
IG1lbW9yeS4NCj4gICAqIE9ubHkgZmx1c2ggdGhlIHBhZ2VzIHRoYXQgYmUgZGlydGllZCBieSBQ
Vk0gb3IgU1ZNIG9yIGJvdGguDQo+ICAgKi8NCj4gLXN0YXRpYyB2b2lkIGNvbG9fZmx1c2hfcmFt
X2NhY2hlKHZvaWQpDQo+ICt2b2lkIGNvbG9fZmx1c2hfcmFtX2NhY2hlKHZvaWQpDQo+ICB7DQo+
ICAgICAgUkFNQmxvY2sgKmJsb2NrID0gTlVMTDsNCj4gICAgICB2b2lkICpkc3RfaG9zdDsNCj4g
QEAgLTM1ODUsOSArMzU4NSw2IEBAIHN0YXRpYyBpbnQgcmFtX2xvYWQoUUVNVUZpbGUgKmYsIHZv
aWQgKm9wYXF1ZSwNCj4gaW50IHZlcnNpb25faWQpDQo+ICAgICAgfQ0KPiAgICAgIHRyYWNlX3Jh
bV9sb2FkX2NvbXBsZXRlKHJldCwgc2VxX2l0ZXIpOw0KPiANCj4gLSAgICBpZiAoIXJldCAgJiYg
bWlncmF0aW9uX2luY29taW5nX2luX2NvbG9fc3RhdGUoKSkgew0KPiAtICAgICAgICBjb2xvX2Zs
dXNoX3JhbV9jYWNoZSgpOw0KPiAtICAgIH0NCj4gICAgICByZXR1cm4gcmV0Ow0KPiAgfQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yYW0uaCBiL21pZ3JhdGlvbi9yYW0uaCBpbmRleCA1
Y2VhZmY3Y2I0Li4yZWVhYWNmYTEzDQo+IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmFtLmgN
Cj4gKysrIGIvbWlncmF0aW9uL3JhbS5oDQo+IEBAIC02NSw2ICs2NSw3IEBAIGludCByYW1fZGly
dHlfYml0bWFwX3JlbG9hZChNaWdyYXRpb25TdGF0ZSAqcywNCj4gUkFNQmxvY2sgKnJiKTsNCj4g
DQo+ICAvKiByYW0gY2FjaGUgKi8NCj4gIGludCBjb2xvX2luaXRfcmFtX2NhY2hlKHZvaWQpOw0K
PiArdm9pZCBjb2xvX2ZsdXNoX3JhbV9jYWNoZSh2b2lkKTsNCj4gIHZvaWQgY29sb19yZWxlYXNl
X3JhbV9jYWNoZSh2b2lkKTsNCj4gIHZvaWQgY29sb19pbmNvbWluZ19zdGFydF9kaXJ0eV9sb2co
dm9pZCk7DQo+IA0KPiAtLQ0KPiAyLjIwLjENCg0K


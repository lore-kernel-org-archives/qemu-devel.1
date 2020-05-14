Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61F6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786892065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786892065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDuJ-0007aT-Ni
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZDtl-00079t-Uq
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:27:41 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2090 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZDth-00028W-B0
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:27:41 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 8C603CE6E210C77FCE19;
 Thu, 14 May 2020 21:27:31 +0800 (CST)
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 14 May 2020 21:27:31 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 14 May 2020 21:27:30 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Thu, 14 May 2020 21:27:30 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>,
 Zhang Chen <chen.zhang@intel.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDYvNl0gbWlncmF0aW9uL2NvbG8uYzogTW92ZSBjb2xv?=
 =?gb2312?B?X25vdGlmeV9jb21wYXJlc19ldmVudCB0byB0aGUgcmlnaHQgcGxhY2U=?=
Thread-Topic: [PATCH 6/6] migration/colo.c: Move colo_notify_compares_event to
 the right place
Thread-Index: AQHWJ4TiQj+MPkHLC0679rdb0mOVNainlUqg
Date: Thu, 14 May 2020 13:27:30 +0000
Message-ID: <f2ea9b8ff1824a09ae8837625d6ac3f5@huawei.com>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <d4555dd5146a54518c4d9d4efd996b7c745c6687.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <d4555dd5146a54518c4d9d4efd996b7c745c6687.1589193382.git.lukasstraub2@web.de>
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

Q2M6IFpoYW5nIENoZW4gPGNoZW4uemhhbmdAaW50ZWwuY29tPg0KDQo+IA0KPiBJZiB0aGUgc2Vj
b25kYXJ5IGhhcyB0byBmYWlsb3ZlciBkdXJpbmcgY2hlY2twb2ludGluZywgaXQgc3RpbGwgaXMg
aW4gdGhlIG9sZCBzdGF0ZQ0KPiAoaS5lLiBkaWZmZXJlbnQgc3RhdGUgdGhhbiBwcmltYXJ5KS4g
VGh1cyB3ZSBjYW4ndCBleHBvc2UgdGhlIHByaW1hcnkgc3RhdGUNCj4gdW50aWwgYWZ0ZXIgdGhl
IGNoZWNrcG9pbnQgaXMgc2VudC4NCj4gDQoNCkhtbSwgZG8geW91IG1lYW4gd2Ugc2hvdWxkIG5v
dCBmbHVzaCB0aGUgbmV0IHBhY2thZ2VzIHRvIGNsaWVudCBjb25uZWN0aW9uIHVudGlsIGNoZWNr
cG9pbnRpbmcNClByb2Nlc3MgYWxtb3N0IHN1Y2Nlc3MgYmVjYXVzZSBpdCBtYXkgZmFpbCBkdXJp
bmcgY2hlY2twb2ludGluZyA/DQoNCj4gVGhpcyBmaXhlcyBzcG9yYWRpYyBjb25uZWN0aW9uIHJl
c2V0IG9mIGNsaWVudCBjb25uZWN0aW9ucyBkdXJpbmcgZmFpbG92ZXIuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBMdWthcyBTdHJhdWIgPGx1a2Fzc3RyYXViMkB3ZWIuZGU+DQo+IC0tLQ0KPiAgbWln
cmF0aW9uL2NvbG8uYyB8IDEyICsrKysrKy0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24v
Y29sby5jIGIvbWlncmF0aW9uL2NvbG8uYyBpbmRleA0KPiBhNjk3ODJlZmM1Li5hM2ZjMjFlODZl
IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vY29sby5jDQo+ICsrKyBiL21pZ3JhdGlvbi9jb2xv
LmMNCj4gQEAgLTQzMCwxMiArNDMwLDYgQEAgc3RhdGljIGludA0KPiBjb2xvX2RvX2NoZWNrcG9p
bnRfdHJhbnNhY3Rpb24oTWlncmF0aW9uU3RhdGUgKnMsDQo+ICAgICAgICAgIGdvdG8gb3V0Ow0K
PiAgICAgIH0NCj4gDQo+IC0gICAgcWVtdV9ldmVudF9yZXNldCgmcy0+Y29sb19jaGVja3BvaW50
X2V2ZW50KTsNCj4gLSAgICBjb2xvX25vdGlmeV9jb21wYXJlc19ldmVudChOVUxMLCBDT0xPX0VW
RU5UX0NIRUNLUE9JTlQsDQo+ICZsb2NhbF9lcnIpOw0KPiAtICAgIGlmIChsb2NhbF9lcnIpIHsN
Cj4gLSAgICAgICAgZ290byBvdXQ7DQo+IC0gICAgfQ0KPiAtDQo+ICAgICAgLyogRGlzYWJsZSBi
bG9jayBtaWdyYXRpb24gKi8NCj4gICAgICBtaWdyYXRlX3NldF9ibG9ja19lbmFibGVkKGZhbHNl
LCAmbG9jYWxfZXJyKTsNCj4gICAgICBxZW11X211dGV4X2xvY2tfaW90aHJlYWQoKTsNCj4gQEAg
LTQ5NCw2ICs0ODgsMTIgQEAgc3RhdGljIGludA0KPiBjb2xvX2RvX2NoZWNrcG9pbnRfdHJhbnNh
Y3Rpb24oTWlncmF0aW9uU3RhdGUgKnMsDQo+ICAgICAgICAgIGdvdG8gb3V0Ow0KPiAgICAgIH0N
Cj4gDQo+ICsgICAgcWVtdV9ldmVudF9yZXNldCgmcy0+Y29sb19jaGVja3BvaW50X2V2ZW50KTsN
Cj4gKyAgICBjb2xvX25vdGlmeV9jb21wYXJlc19ldmVudChOVUxMLCBDT0xPX0VWRU5UX0NIRUNL
UE9JTlQsDQo+ICZsb2NhbF9lcnIpOw0KPiArICAgIGlmIChsb2NhbF9lcnIpIHsNCj4gKyAgICAg
ICAgZ290byBvdXQ7DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgY29sb19yZWNlaXZlX2NoZWNrX21l
c3NhZ2Uocy0+cnBfc3RhdGUuZnJvbV9kc3RfZmlsZSwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgQ09MT19NRVNTQUdFX1ZNU1RBVEVfTE9BREVELCAmbG9jYWxfZXJyKTsNCj4gICAgICBpZiAo
bG9jYWxfZXJyKSB7DQo+IC0tDQo+IDIuMjAuMQ0K


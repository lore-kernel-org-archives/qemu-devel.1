Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D412ECA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA02E206D6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 11:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA02E206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYpfd-0001cc-UV
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 07:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jYpbg-0002cj-TX
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:31:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2520 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jYpbe-0000fd-LR
 for qemu-devel@nongnu.org; Wed, 13 May 2020 07:31:24 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id AC72F8CCDC248E5EE773;
 Wed, 13 May 2020 19:31:07 +0800 (CST)
Received: from dggeme706-chm.china.huawei.com (10.1.199.102) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 13 May 2020 19:31:07 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 13 May 2020 19:31:07 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Wed, 13 May 2020 19:31:07 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDEvNl0gbWlncmF0aW9uL2NvbG8uYzogVXNlIGV2ZW50?=
 =?gb2312?Q?_instead_of_semaphore?=
Thread-Topic: [PATCH 1/6] migration/colo.c: Use event instead of semaphore
Thread-Index: AQHWJ4TW5lp+1J6Yi0yErChMAFDRwKil5Bzg
Date: Wed, 13 May 2020 11:31:06 +0000
Message-ID: <d2d88cfacf8846589b66816198a725bb@huawei.com>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <fd601ba1beb524aada54ba66e87ebfc12cf4574b.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <fd601ba1beb524aada54ba66e87ebfc12cf4574b.1589193382.git.lukasstraub2@web.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 07:31:08
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

PiBJZiBtdWx0aXBsZSBwYWNrZXRzIG1pc2NvbXBhcmUgaW4gYSBzaG9ydCB0aW1lZnJhbWUsIHRo
ZSBzZW1hcGhvcmUgdmFsdWUNCj4gd2lsbCBiZSBpbmNyZWFzZWQgbXVsdGlwbGUgdGltZXMuIFRo
aXMgY2F1c2VzIG11bHRpcGxlIGNoZWNrcG9pbnRzIGV2ZW4gaWYgb25lDQo+IHdvdWxkIGJlIHN1
ZmZpY2llbnQuDQo+IA0KDQpZb3UgcmlnaHQsIGdvb2QgY2F0Y2ggOykNCg0KUmV2aWV3ZWQtYnk6
IHpoYW5naGFpbGlhbmcgPHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT4NCg0KPiBGaXgg
dGhpcyBieSB1c2luZyBhIGV2ZW50IGluc3RlYWQgb2YgYSBzZW1hcGhvcmUgZm9yIHRyaWdnZXJp
bmcgY2hlY2twb2ludHMuDQo+IE5vdywgY2hlY2twb2ludCByZXF1ZXN0cyB3aWxsIGJlIGlnbm9y
ZWQgdW50aWwgdGhlIGNoZWNrcG9pbnQgZXZlbnQgaXMgc2VudA0KPiB0byBjb2xvLWNvbXBhcmUg
KHdoaWNoIHJlbGVhc2VzIHRoZSBtaXNjb21wYXJlZCBwYWNrZXRzKS4NCj4gDQo+IEJlbmNobWFy
ayByZXN1bHRzIChpcGVyZjMpOg0KPiBDbGllbnQtdG8tc2VydmVyIHRjcDoNCj4gd2l0aG91dCBw
YXRjaDogfjY2IE1iaXQvcw0KPiB3aXRoIHBhdGNoOiB+NjEgTWJpdC9zDQo+IFNlcnZlci10by1j
bGllbnQgdGNwOg0KPiB3aXRob3V0IHBhdGNoOiB+NzAyIEtiaXQvcw0KPiB3aXRoIHBhdGNoOiB+
MTYgTWJpdC9zDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWthcyBTdHJhdWIgPGx1a2Fzc3RyYXVi
MkB3ZWIuZGU+DQo+IC0tLQ0KPiAgbWlncmF0aW9uL2NvbG8uYyAgICAgIHwgOSArKysrKy0tLS0N
Cj4gIG1pZ3JhdGlvbi9taWdyYXRpb24uaCB8IDQgKystLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0
aW9uL2NvbG8uYyBiL21pZ3JhdGlvbi9jb2xvLmMgaW5kZXgNCj4gYTU0YWM4NGY0MS4uMDkxNjg2
MjdiYyAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL2NvbG8uYw0KPiArKysgYi9taWdyYXRpb24v
Y29sby5jDQo+IEBAIC00MzAsNiArNDMwLDcgQEAgc3RhdGljIGludA0KPiBjb2xvX2RvX2NoZWNr
cG9pbnRfdHJhbnNhY3Rpb24oTWlncmF0aW9uU3RhdGUgKnMsDQo+ICAgICAgICAgIGdvdG8gb3V0
Ow0KPiAgICAgIH0NCj4gDQo+ICsgICAgcWVtdV9ldmVudF9yZXNldCgmcy0+Y29sb19jaGVja3Bv
aW50X2V2ZW50KTsNCj4gICAgICBjb2xvX25vdGlmeV9jb21wYXJlc19ldmVudChOVUxMLCBDT0xP
X0VWRU5UX0NIRUNLUE9JTlQsDQo+ICZsb2NhbF9lcnIpOw0KPiAgICAgIGlmIChsb2NhbF9lcnIp
IHsNCj4gICAgICAgICAgZ290byBvdXQ7DQo+IEBAIC01ODAsNyArNTgxLDcgQEAgc3RhdGljIHZv
aWQgY29sb19wcm9jZXNzX2NoZWNrcG9pbnQoTWlncmF0aW9uU3RhdGUNCj4gKnMpDQo+ICAgICAg
ICAgICAgICBnb3RvIG91dDsNCj4gICAgICAgICAgfQ0KPiANCj4gLSAgICAgICAgcWVtdV9zZW1f
d2FpdCgmcy0+Y29sb19jaGVja3BvaW50X3NlbSk7DQo+ICsgICAgICAgIHFlbXVfZXZlbnRfd2Fp
dCgmcy0+Y29sb19jaGVja3BvaW50X2V2ZW50KTsNCj4gDQo+ICAgICAgICAgIGlmIChzLT5zdGF0
ZSAhPSBNSUdSQVRJT05fU1RBVFVTX0NPTE8pIHsNCj4gICAgICAgICAgICAgIGdvdG8gb3V0Ow0K
PiBAQCAtNjI4LDcgKzYyOSw3IEBAIG91dDoNCj4gICAgICBjb2xvX2NvbXBhcmVfdW5yZWdpc3Rl
cl9ub3RpZmllcigmcGFja2V0c19jb21wYXJlX25vdGlmaWVyKTsNCj4gICAgICB0aW1lcl9kZWwo
cy0+Y29sb19kZWxheV90aW1lcik7DQo+ICAgICAgdGltZXJfZnJlZShzLT5jb2xvX2RlbGF5X3Rp
bWVyKTsNCj4gLSAgICBxZW11X3NlbV9kZXN0cm95KCZzLT5jb2xvX2NoZWNrcG9pbnRfc2VtKTsN
Cj4gKyAgICBxZW11X2V2ZW50X2Rlc3Ryb3koJnMtPmNvbG9fY2hlY2twb2ludF9ldmVudCk7DQo+
IA0KPiAgICAgIC8qDQo+ICAgICAgICogTXVzdCBiZSBjYWxsZWQgYWZ0ZXIgZmFpbG92ZXIgQkgg
aXMgY29tcGxldGVkLCBAQCAtNjQ1LDcgKzY0Niw3DQo+IEBAIHZvaWQgY29sb19jaGVja3BvaW50
X25vdGlmeSh2b2lkICpvcGFxdWUpDQo+ICAgICAgTWlncmF0aW9uU3RhdGUgKnMgPSBvcGFxdWU7
DQo+ICAgICAgaW50NjRfdCBuZXh0X25vdGlmeV90aW1lOw0KPiANCj4gLSAgICBxZW11X3NlbV9w
b3N0KCZzLT5jb2xvX2NoZWNrcG9pbnRfc2VtKTsNCj4gKyAgICBxZW11X2V2ZW50X3NldCgmcy0+
Y29sb19jaGVja3BvaW50X2V2ZW50KTsNCj4gICAgICBzLT5jb2xvX2NoZWNrcG9pbnRfdGltZSA9
DQo+IHFlbXVfY2xvY2tfZ2V0X21zKFFFTVVfQ0xPQ0tfSE9TVCk7DQo+ICAgICAgbmV4dF9ub3Rp
ZnlfdGltZSA9IHMtPmNvbG9fY2hlY2twb2ludF90aW1lICsNCj4gICAgICAgICAgICAgICAgICAg
ICAgcy0+cGFyYW1ldGVycy54X2NoZWNrcG9pbnRfZGVsYXk7IEBAIC02NTUsNw0KPiArNjU2LDcg
QEAgdm9pZCBjb2xvX2NoZWNrcG9pbnRfbm90aWZ5KHZvaWQgKm9wYXF1ZSkgIHZvaWQNCj4gbWln
cmF0ZV9zdGFydF9jb2xvX3Byb2Nlc3MoTWlncmF0aW9uU3RhdGUgKnMpICB7DQo+ICAgICAgcWVt
dV9tdXRleF91bmxvY2tfaW90aHJlYWQoKTsNCj4gLSAgICBxZW11X3NlbV9pbml0KCZzLT5jb2xv
X2NoZWNrcG9pbnRfc2VtLCAwKTsNCj4gKyAgICBxZW11X2V2ZW50X2luaXQoJnMtPmNvbG9fY2hl
Y2twb2ludF9ldmVudCwgZmFsc2UpOw0KPiAgICAgIHMtPmNvbG9fZGVsYXlfdGltZXIgPSAgdGlt
ZXJfbmV3X21zKFFFTVVfQ0xPQ0tfSE9TVCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29sb19jaGVja3BvaW50X25vdGlmeSwgcyk7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWln
cmF0aW9uL21pZ3JhdGlvbi5oIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5oIGluZGV4DQo+IDUwNzI4
NGU1NjMuLmY2MTc5NjA1MjIgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9taWdyYXRpb24uaA0K
PiArKysgYi9taWdyYXRpb24vbWlncmF0aW9uLmgNCj4gQEAgLTIxNSw4ICsyMTUsOCBAQCBzdHJ1
Y3QgTWlncmF0aW9uU3RhdGUNCj4gICAgICAvKiBUaGUgc2VtYXBob3JlIGlzIHVzZWQgdG8gbm90
aWZ5IENPTE8gdGhyZWFkIHRoYXQgZmFpbG92ZXIgaXMgZmluaXNoZWQNCj4gKi8NCj4gICAgICBR
ZW11U2VtYXBob3JlIGNvbG9fZXhpdF9zZW07DQo+IA0KPiAtICAgIC8qIFRoZSBzZW1hcGhvcmUg
aXMgdXNlZCB0byBub3RpZnkgQ09MTyB0aHJlYWQgdG8gZG8gY2hlY2twb2ludCAqLw0KPiAtICAg
IFFlbXVTZW1hcGhvcmUgY29sb19jaGVja3BvaW50X3NlbTsNCj4gKyAgICAvKiBUaGUgZXZlbnQg
aXMgdXNlZCB0byBub3RpZnkgQ09MTyB0aHJlYWQgdG8gZG8gY2hlY2twb2ludCAqLw0KPiArICAg
IFFlbXVFdmVudCBjb2xvX2NoZWNrcG9pbnRfZXZlbnQ7DQo+ICAgICAgaW50NjRfdCBjb2xvX2No
ZWNrcG9pbnRfdGltZTsNCj4gICAgICBRRU1VVGltZXIgKmNvbG9fZGVsYXlfdGltZXI7DQo+IA0K
PiAtLQ0KPiAyLjIwLjENCg0K


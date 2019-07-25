Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067DAC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B28218EA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B28218EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZyS-0001Am-6K
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37129)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hqZyH-0000mK-Ou
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:23:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <oscar.zhangbo@huawei.com>) id 1hqZyG-0006yi-J3
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:23:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2484 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <oscar.zhangbo@huawei.com>)
 id 1hqZyG-0006xJ-70
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:23:32 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 8D2E038D4F799632AA88;
 Thu, 25 Jul 2019 17:23:26 +0800 (CST)
Received: from DGGEML509-MBX.china.huawei.com ([169.254.1.213]) by
 DGGEML402-HUB.china.huawei.com ([fe80::fca6:7568:4ee3:c776%31]) with mapi id
 14.03.0439.000; Thu, 25 Jul 2019 17:23:18 +0800
From: "Zhangbo (Oscar)" <oscar.zhangbo@huawei.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "wangxiongfeng (C)"
 <wangxiongfeng2@huawei.com>
Thread-Topic: CC wangxiongfeng. RE: [PATCH] pcie: fix device unplug timeout
Thread-Index: AdVCyncrVmQiWqhESdmweEDxO2X+Cg==
Date: Thu, 25 Jul 2019 09:23:17 +0000
Message-ID: <0259E1C966E8C54AA93AA2B1240828E672DF61CC@dggeml509-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.17.158]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.188
Subject: [Qemu-devel] CC wangxiongfeng. RE: [PATCH] pcie: fix device unplug
 timeout
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
Cc: fangying <fangying1@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "limingwang \(A\)" <limingwang@huawei.com>, "dengkai
 \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pj4gSWYgdGhlIGxpbnV4IGtlcm5lbCBvbmx5IHJlY2VpdmVzIGFuIEFCUCBldmVudCBkdXJpbmcg
cGNpZSB1bnBsdWcsIGl0IHdpbGwgc2xlZXAgNXMNCj4+IHRvIGV4cGVjdCBhIFBEQyBldmVudCwg
d2hpY2ggd2lsbCBjYXVzZSBkZXZpY2UgdW5wbHVnIHRpbWVvdXQuDQo+DQo+TXkgdW5kZXJzdGFu
ZGluZyBpcyB0aGF0IHRoZXJlJ3Mgbm8gdGltZW91dC4gU3BlYyBzYXlzOg0KPglJZiBwcmVzZW50
LCB0aGUgUG93ZXIgSW5kaWNhdG9yIHByb3ZpZGVzIHZpc3VhbCBmZWVkYmFjayB0byB0aGUgaHVt
YW4NCj5vcGVyYXRvciAoaWYgdGhlIHN5c3RlbQ0KPglzb2Z0d2FyZSBhY2NlcHRzIHRoZSByZXF1
ZXN0IGluaXRpYXRlZCBieSB0aGUgQXR0ZW50aW9uIEJ1dHRvbikgYnkgYmxpbmtpbmcuDQo+T25j
ZSB0aGUgUG93ZXINCj4JSW5kaWNhdG9yIGJlZ2lucyBibGlua2luZywgYSA1LXNlY29uZCBhYm9y
dCBpbnRlcnZhbCBleGlzdHMgZHVyaW5nIHdoaWNoIGENCj5zZWNvbmQgZGVwcmVzc2lvbiBvZiB0
aGUNCj4JQXR0ZW50aW9uIEJ1dHRvbiBjYW5jZWxzIHRoZSBvcGVyYXRpb24uDQo+DQo+dGhpcyBp
cyBleGFjdGx5IHdoYXQgbGludXggaW1wbGVtZW50cy4NCj5UaHVzIGFmdGVyIGFuIEFCUCBldmVu
dCwgbGludXggc3RhcnRzIGEgNSBzZWNvbmQgdGltZXI6DQo+CXNjaGVkdWxlX2RlbGF5ZWRfd29y
aygmY3RybC0+YnV0dG9uX3dvcmssIDUgKiBIWik7DQo+DQo+DQo+PiBJbiB0aGUgbWVhbndoaWxl
LCBpZiB0aGUga2VybmVsIG9ubHkgcmVjZWl2ZXMgYSBQREMgZXZlbnQgZHVyaW5nIHRoZSB1bnBs
dWcsIGl0DQo+PiB3aWxsIHdhaXQgZm9yIGF0IGxlYXN0IDEgc2Vjb25kIGJlZm9yZSBjaGVja2lu
ZyBjYXJkIHByZXNlbnQgYXMgZGF0YSBsaW5rIGxheWVyDQo+PiBzdGF0ZSBjaGFuZ2VkIChsaW5r
IGRvd24pIGV2ZW50IHJlcG9ydGVkIHByaW9yIHRvIHByZXNlbmNlIGRldGVjdCBjaGFuZ2VkDQo+
PiAoY2FyZCBpcyBub3QgcHJlc2VudCkuDQo+DQo+SSBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91
IGFyZSBzYXlpbmcgZXhhY3RseS4NCj5CdXQgSSBkb24ndCBzZWUgYW55IG90aGVyIGRlbGF5ZWQg
d29yayBpbg0KPmRyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX2N0cmwuYw0KPg0KPg0KPj4gVGhl
cmVmb3JlIHdlIGNhbiBzZW5kIGJvdGggQUJQIGFuZCBQREMgZXZlbnRzIHRvIHRoZSBrZXJuZWwg
aW4gdW5wbHVnDQo+cHJvY2Vzcw0KPj4gdG8gYXZvaWQgdW5wbHVnIHRpbWVvdXQuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogbGltaW5nd2FuZ0BodWF3ZWkuY29tDQo+PiBTaWduZWQtb2ZmLWJ5OiBm
YW5neWluZzFAaHVhd2VpLmNvbQ0KPj4gU2lnbmVkLW9mZi1ieTogb3NjYXIuemhhbmdib0BodWF3
ZWkuY29tDQo+DQo+SSBzZWUgdGhpcyBpbiBsaW51eDoNCj4NCj4vKioNCj4gKiBwY2llaHBfY2hl
Y2tfcHJlc2VuY2UoKSAtIHN5bnRoZXNpemUgZXZlbnQgaWYgcHJlc2VuY2UgaGFzIGNoYW5nZWQN
Cj4gKg0KPiAqIE9uIHByb2JlIGFuZCByZXN1bWUsIGFuIGV4cGxpY2l0IHByZXNlbmNlIGNoZWNr
IGlzIG5lY2Vzc2FyeSB0byBicmluZyB1cCBhbg0KPiAqIG9jY3VwaWVkIHNsb3Qgb3IgYnJpbmcg
ZG93biBhbiB1bm9jY3VwaWVkIHNsb3QuICBUaGlzIGNhbid0IGJlIHRyaWdnZXJlZCBieQ0KPiAq
IGV2ZW50cyBpbiB0aGUgU2xvdCBTdGF0dXMgcmVnaXN0ZXIsIHRoZXkgbWF5IGJlIHN0YWxlIGFu
ZCBhcmUgdGhlcmVmb3JlDQo+ICogY2xlYXJlZC4gIFNlY29uZGx5LCBzZW5kaW5nIGFuIGludGVy
cnVwdCBmb3IgImV2ZW50cyB0aGF0IG9jY3VyIHdoaWxlDQo+ICogaW50ZXJydXB0IGdlbmVyYXRp
b24gaXMgZGlzYWJsZWQgW3doZW5dIGludGVycnVwdCBnZW5lcmF0aW9uIGlzIHN1YnNlcXVlbnRs
eQ0KPiAqIGVuYWJsZWQiIGlzIG9wdGlvbmFsIHBlciBQQ0llIHI0LjAsIHNlYyA2LjcuMy40Lg0K
PiAqLw0KPg0KPg0KPk15IHN1Z2dlc3Rpb24gdGhlcmVmb3JlIGlzIHRvIHRyeSB0byBjbGVhciBQ
cmVzZW5jZSBEZXRlY3QgU3RhdGUsDQo+c2V0IHByZXNlbmNlIGRldGVjdCBjaGFuZ2VkIGFuZCBk
byBub3Qgc2V0IGF0dGVudGlvbiBidXR0b24NCj5wcmVzc2VkLg0KPg0KQHdhbmd4aW9uZ2ZlbmcN
Cg0KPg0KPj4gLS0tDQo+PiAgaHcvcGNpL3BjaWUuYyAgICAgICAgIHwgOCArKy0tLS0tLQ0KPj4g
IGluY2x1ZGUvaHcvcGNpL3BjaWUuaCB8IDEgLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9wY2kvcGNp
ZS5jIGIvaHcvcGNpL3BjaWUuYw0KPj4gaW5kZXggMTc0ZjM5Mi4uYTgwMGYyMyAxMDA2NDQNCj4+
IC0tLSBhL2h3L3BjaS9wY2llLmMNCj4+ICsrKyBiL2h3L3BjaS9wY2llLmMNCj4+IEBAIC00ODUs
NyArNDg1LDggQEAgdm9pZA0KPnBjaWVfY2FwX3Nsb3RfdW5wbHVnX3JlcXVlc3RfY2IoSG90cGx1
Z0hhbmRsZXIgKmhvdHBsdWdfZGV2LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBQQ0lfRVhQX0xOS1NUQV9ETExMQSk7DQo+PiAgICAgIH0NCj4+DQo+PiAtICAgIHBj
aWVfY2FwX3Nsb3RfcHVzaF9hdHRlbnRpb25fYnV0dG9uKFBDSV9ERVZJQ0UoaG90cGx1Z19kZXYp
KTsNCj4+ICsgICAgcGNpZV9jYXBfc2xvdF9ldmVudChQQ0lfREVWSUNFKGhvdHBsdWdfZGV2KSwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICBQQ0lfRVhQX0hQX0VWX1BEQyB8IFBDSV9FWFBf
SFBfRVZfQUJQKTsNCj4+ICB9DQo+Pg0KPj4gIC8qIHBjaSBleHByZXNzIHNsb3QgZm9yIHBjaSBl
eHByZXNzIHJvb3QvZG93bnN0cmVhbSBwb3J0DQo+PiBAQCAtNzAxLDExICs3MDIsNiBAQCBpbnQg
cGNpZV9jYXBfc2xvdF9wb3N0X2xvYWQodm9pZCAqb3BhcXVlLCBpbnQNCj52ZXJzaW9uX2lkKQ0K
Pj4gICAgICByZXR1cm4gMDsNCj4+ICB9DQo+Pg0KPj4gLXZvaWQgcGNpZV9jYXBfc2xvdF9wdXNo
X2F0dGVudGlvbl9idXR0b24oUENJRGV2aWNlICpkZXYpDQo+PiAtew0KPj4gLSAgICBwY2llX2Nh
cF9zbG90X2V2ZW50KGRldiwgUENJX0VYUF9IUF9FVl9BQlApOw0KPj4gLX0NCj4+IC0NCj4+ICAv
KiByb290IGNvbnRyb2wvY2FwYWJpbGl0aWVzL3N0YXR1cy4gUE1FIGlzbid0IGVtdWxhdGVkIGZv
ciBub3cgKi8NCj4+ICB2b2lkIHBjaWVfY2FwX3Jvb3RfaW5pdChQQ0lEZXZpY2UgKmRldikNCj4+
ICB7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kvcGNpZS5oIGIvaW5jbHVkZS9ody9w
Y2kvcGNpZS5oDQo+PiBpbmRleCA4Y2YzMzYxLi4wOTc1YTU0IDEwMDY0NA0KPj4gLS0tIGEvaW5j
bHVkZS9ody9wY2kvcGNpZS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L3BjaS9wY2llLmgNCj4+IEBA
IC0xMTIsNyArMTEyLDYgQEAgdm9pZCBwY2llX2NhcF9zbG90X3dyaXRlX2NvbmZpZyhQQ0lEZXZp
Y2UgKmRldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90IG9s
ZF9zbHRfY3RsLCB1aW50MTZfdA0KPm9sZF9zbHRfc3RhLA0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgYWRkciwgdWludDMyX3QgdmFsLCBpbnQgbGVuKTsNCj4+
ICBpbnQgcGNpZV9jYXBfc2xvdF9wb3N0X2xvYWQodm9pZCAqb3BhcXVlLCBpbnQgdmVyc2lvbl9p
ZCk7DQo+PiAtdm9pZCBwY2llX2NhcF9zbG90X3B1c2hfYXR0ZW50aW9uX2J1dHRvbihQQ0lEZXZp
Y2UgKmRldik7DQo+Pg0KPj4gIHZvaWQgcGNpZV9jYXBfcm9vdF9pbml0KFBDSURldmljZSAqZGV2
KTsNCj4+ICB2b2lkIHBjaWVfY2FwX3Jvb3RfcmVzZXQoUENJRGV2aWNlICpkZXYpOw0KPj4gLS0N
Cj4+IDEuOC4zLjENCg==


Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B0AC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC0A21556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC0A21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XDK-0000Z3-3f
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6XCU-0007v3-U8
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:12:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j6XCT-0000Aq-Mn
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:12:26 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:50774 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j6XCT-00008p-Cx; Tue, 25 Feb 2020 05:12:25 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id C208D19239E6CADF7304;
 Tue, 25 Feb 2020 18:12:19 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 25 Feb 2020 18:12:19 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.163]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0439.000;
 Tue, 25 Feb 2020 18:12:09 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org"
 <qemu-trivial@nongnu.org>
Subject: RE: [PATCH 13/13] monitor/hmp-cmds: Remove redundant statement in
 hmp_rocker_of_dpa_groups()
Thread-Topic: [PATCH 13/13] monitor/hmp-cmds: Remove redundant statement in
 hmp_rocker_of_dpa_groups()
Thread-Index: AQHV64DJGO7qJyDt3kiSwvqgJy15P6grIz2AgACK+hA=
Date: Tue, 25 Feb 2020 10:12:09 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B661C02@dggemm531-mbx.china.huawei.com>
References: <20200225020937.25028-1-kuhn.chenqun@huawei.com>
 <20200225020937.25028-14-kuhn.chenqun@huawei.com>
 <1f4c5308-4a6f-fe1f-3832-f1c762b4c4c2@redhat.com>
In-Reply-To: <1f4c5308-4a6f-fe1f-3832-f1c762b4c4c2@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.205.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.255
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgW21haWx0bzpwaGlsbWRAcmVkaGF0LmNvbV0NCj5TZW50OiBUdWVzZGF5LCBGZWJydWFyeSAy
NSwgMjAyMCA1OjQ1IFBNDQo+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2Vp
LmNvbT47IHFlbXUtDQo+ZGV2ZWxAbm9uZ251Lm9yZzsgcWVtdS10cml2aWFsQG5vbmdudS5vcmcN
Cj5DYzogcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBaaGFuZ2hhaWxpYW5nDQo+PHpoYW5nLnpo
YW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IERyLiBEYXZpZCBBbGFuIEdpbGJlcnQNCj48ZGdpbGJl
cnRAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDEzLzEzXSBtb25pdG9yL2htcC1j
bWRzOiBSZW1vdmUgcmVkdW5kYW50DQo+c3RhdGVtZW50IGluIGhtcF9yb2NrZXJfb2ZfZHBhX2dy
b3VwcygpDQo+DQo+T24gMi8yNS8yMCAzOjA5IEFNLCBrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbSB3
cm90ZToNCj4+IEZyb206IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4+DQo+
PiBDbGFuZyBzdGF0aWMgY29kZSBhbmFseXplciBzaG93IHdhcm5pbmc6DQo+PiBtb25pdG9yL2ht
cC1jbWRzLmM6Mjg2NzoxNzogd2FybmluZzogVmFsdWUgc3RvcmVkIHRvICdzZXQnIGlzIG5ldmVy
IHJlYWQNCj4+ICAgICAgICAgICAgICAgICAgc2V0ID0gdHJ1ZTsNCj4+ICAgICAgICAgICAgICAg
ICAgXiAgICAgfn5+fg0KPj4NCj4+IFJlcG9ydGVkLWJ5OiBFdWxlciBSb2JvdCA8ZXVsZXIucm9i
b3RAaHVhd2VpLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5A
aHVhd2VpLmNvbT4NCj4+IC0tLQ0KPj4gQ2M6ICJEci4gRGF2aWQgQWxhbiBHaWxiZXJ0IiA8ZGdp
bGJlcnRAcmVkaGF0LmNvbT4NCj4+IC0tLQ0KPj4gICBtb25pdG9yL2htcC1jbWRzLmMgfCAxIC0N
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
bW9uaXRvci9obXAtY21kcy5jIGIvbW9uaXRvci9obXAtY21kcy5jIGluZGV4DQo+PiA1M2JjM2Y3
NmM0Li44NGY5NDY0N2NkIDEwMDY0NA0KPj4gLS0tIGEvbW9uaXRvci9obXAtY21kcy5jDQo+PiAr
KysgYi9tb25pdG9yL2htcC1jbWRzLmMNCj4+IEBAIC0yODY0LDcgKzI4NjQsNiBAQCB2b2lkIGht
cF9yb2NrZXJfb2ZfZHBhX2dyb3VwcyhNb25pdG9yICptb24sDQo+PiBjb25zdCBRRGljdCAqcWRp
Y3QpDQo+Pg0KPj4gICAgICAgICAgIGlmIChncm91cC0+aGFzX3NldF9ldGhfZHN0KSB7DQo+PiAg
ICAgICAgICAgICAgIGlmICghc2V0KSB7DQo+PiAtICAgICAgICAgICAgICAgIHNldCA9IHRydWU7
DQo+PiAgICAgICAgICAgICAgICAgICBtb25pdG9yX3ByaW50Zihtb24sICIgc2V0Iik7DQo+PiAg
ICAgICAgICAgICAgIH0NCj4+ICAgICAgICAgICAgICAgbW9uaXRvcl9wcmludGYobW9uLCAiIGRz
dCAlcyIsIGdyb3VwLT5zZXRfZXRoX2RzdCk7DQo+Pg0KPg0KPkNhbiB5b3UgbW92ZSB0aGUgJ3Nl
dCcgZGVjbGFyYXRpb24gdG8gdGhlIGZvcigpIHN0YXRlbWVudCBhbmQgYWxzbyByZW1vdmUgdGhl
DQo+bGFzdCAic2V0ID0gZmFsc2U7Ij8NClllcywgIHlvdSBhcmUgcmlnaHQhICAgSXQgd2lsbCBi
ZSBiZXR0ZXIhICAgIEkgd2lsbCBtb2RpZnkgaXQgbGF0ZXIgaW4gVjIuDQoNClRoYW5rcy4NCg0K


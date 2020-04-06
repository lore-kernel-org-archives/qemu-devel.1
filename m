Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C7FC2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0102072A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0102072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOzR-0004s6-Vi
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jLOtS-0007gp-SS
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jLOtI-0000Lm-42
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:22:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2517 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jLOtH-0000I1-Ln
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:22:04 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 7BF00715EB37C17E0AC9;
 Mon,  6 Apr 2020 18:21:52 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.178]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0487.000;
 Mon, 6 Apr 2020 18:21:42 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH  v3 06/12] gdbstub: fix compiler complaining
Thread-Topic: [PATCH  v3 06/12] gdbstub: fix compiler complaining
Thread-Index: AQHWCevDTrLZ5qVCuEuUMRmztNFdkahr5I2Q
Date: Mon, 6 Apr 2020 10:21:42 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B6E40C6@dggemm531-mbx.china.huawei.com>
References: <20200403191150.863-1-alex.bennee@linaro.org>
 <20200403191150.863-7-alex.bennee@linaro.org>
In-Reply-To: <20200403191150.863-7-alex.bennee@linaro.org>
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
X-Received-From: 45.249.212.188
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
Cc: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQWxleCBCZW5uw6llIFttYWlsdG86
YWxleC5iZW5uZWVAbGluYXJvLm9yZ10NCj5TZW50OiBTYXR1cmRheSwgQXByaWwgNCwgMjAyMCAz
OjEyIEFNDQo+VG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPkNjOiBEZW5pcyBQbG90bmlrb3Yg
PGRwbG90bmlrb3ZAdmlydHVvenpvLmNvbT47IEV1bGVyIFJvYm90DQo+PGV1bGVyLnJvYm90QGh1
YXdlaS5jb20+OyBDaGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+Ow0KPlJp
Y2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsgQWxleCBCZW5u
w6llDQo+PGFsZXguYmVubmVlQGxpbmFyby5vcmc+OyBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQHJlZGhhdC5jb20+DQo+U3ViamVjdDogW1BBVENIIHYzIDA2LzEyXSBnZGJzdHViOiBm
aXggY29tcGlsZXIgY29tcGxhaW5pbmcNCj4NCj5Gcm9tOiBEZW5pcyBQbG90bmlrb3YgPGRwbG90
bmlrb3ZAdmlydHVvenpvLmNvbT4NCj4NCj4gICAgLi9nZGJzdHViLmM6IEluIGZ1bmN0aW9uIOKA
mGhhbmRsZV9xdWVyeV90aHJlYWRfZXh0cmHigJk6DQo+ICAgICAgICAvdXNyL2luY2x1ZGUvZ2xp
Yi0yLjAvZ2xpYi9nbGliLWF1dG9jbGVhbnVwcy5oOjI4OjEwOg0KPiAgICBlcnJvcjog4oCYY3B1
X25hbWXigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uDQo+ICAg
IFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdDQo+ICAgICAgICBnX2ZyZWUgKCpwcCk7DQo+
ICAgICAgICAgICAgICAgXg0KPiAgICAuL2dkYnN0dWIuYzoyMDYzOjI2OiBub3RlOiDigJhjcHVf
bmFtZeKAmSB3YXMgZGVjbGFyZWQgaGVyZQ0KPiAgICAgICAgZ19hdXRvZnJlZSBjaGFyICpjcHVf
bmFtZTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgICBjYzE6IGFsbCB3YXJuaW5n
cyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KPg0KPlNpZ25lZC1vZmYtYnk6IERlbmlzIFBsb3Ru
aWtvdiA8ZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tPg0KPk1lc3NhZ2UtSWQ6IDwyMDIwMDMyNjE1
MTQwNy4yNTA0Ni0xLWRwbG90bmlrb3ZAdmlydHVvenpvLmNvbT4NCj5SZXBvcnRlZC1ieTogRXVs
ZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+UmVwb3J0ZWQtYnk6IENoZW4gUXVu
IDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj5SZXZpZXdlZC1ieTogUmljaGFyZCBIZW5kZXJz
b24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+U2lnbmVkLW9mZi1ieTogQWxleCBC
ZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPlJldmlld2VkLWJ5OiBQaGlsaXBwZSBN
YXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5jb20+DQo+LS0tDQpBZGQgTWlyb3NsYXYgUmV6
YW5pbmEncyAgIlJldmlld2VkLWJ5IiB0YWcuDQpodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2
ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMC0wMy9tc2cwNzY1MS5odG1sDQoNClJldmlld2VkLWJ5OiBN
aXJvc2xhdiBSZXphbmluYSA8bXJlemFuaW5AcmVkaGF0LmNvbT4NCg0KVGhhbmtzLg0KPiBnZGJz
dHViLmMgfCA0ICsrLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvZ2Ric3R1Yi5jIGIvZ2Ric3R1Yi5jDQo+aW5kZXgg
MDEzZmIxYWMwZjEuLjE3MWUxNTA5NTA5IDEwMDY0NA0KPi0tLSBhL2dkYnN0dWIuYw0KPisrKyBi
L2dkYnN0dWIuYw0KPkBAIC0yMDYwLDggKzIwNjAsOCBAQCBzdGF0aWMgdm9pZA0KPmhhbmRsZV9x
dWVyeV90aHJlYWRfZXh0cmEoR2RiQ21kQ29udGV4dCAqZ2RiX2N0eCwgdm9pZCAqdXNlcl9jdHgp
DQo+ICAgICAgICAgLyogUHJpbnQgdGhlIENQVSBtb2RlbCBhbmQgbmFtZSBpbiBtdWx0aXByb2Nl
c3MgbW9kZSAqLw0KPiAgICAgICAgIE9iamVjdENsYXNzICpvYyA9IG9iamVjdF9nZXRfY2xhc3Mo
T0JKRUNUKGNwdSkpOw0KPiAgICAgICAgIGNvbnN0IGNoYXIgKmNwdV9tb2RlbCA9IG9iamVjdF9j
bGFzc19nZXRfbmFtZShvYyk7DQo+LSAgICAgICAgZ19hdXRvZnJlZSBjaGFyICpjcHVfbmFtZTsN
Cj4tICAgICAgICBjcHVfbmFtZSAgPSBvYmplY3RfZ2V0X2Nhbm9uaWNhbF9wYXRoX2NvbXBvbmVu
dChPQkpFQ1QoY3B1KSk7DQo+KyAgICAgICAgZ19hdXRvZnJlZSBjaGFyICpjcHVfbmFtZSA9DQo+
KyAgICAgICAgICAgIG9iamVjdF9nZXRfY2Fub25pY2FsX3BhdGhfY29tcG9uZW50KE9CSkVDVChj
cHUpKTsNCj4gICAgICAgICBnX3N0cmluZ19wcmludGYocnMsICIlcyAlcyBbJXNdIiwgY3B1X21v
ZGVsLCBjcHVfbmFtZSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgY3B1LT5oYWx0ZWQgPyAi
aGFsdGVkICIgOiAicnVubmluZyIpOw0KPiAgICAgfSBlbHNlIHsNCj4tLQ0KPjIuMjAuMQ0KDQo=


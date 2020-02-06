Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5950C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99797217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99797217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izhD1-0005dH-QL
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1izhAV-0002mX-CQ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1izhAU-0006YK-6H
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:26:07 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2432 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1izhAT-0006Go-P9; Thu, 06 Feb 2020 08:26:06 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 0088CAA9443754BADC53;
 Thu,  6 Feb 2020 21:25:59 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.189]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0439.000;
 Thu, 6 Feb 2020 21:25:52 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH] tests/plugin: prevent uninitialized warning
Thread-Topic: [PATCH] tests/plugin: prevent uninitialized warning
Thread-Index: AQHV3NBpMk//FkblI0SoQDe0zkZRMqgNlueAgACKrAA=
Date: Thu, 6 Feb 2020 13:25:51 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B10AD31@dggemm511-mbx.china.huawei.com>
References: <20200206093238.203984-1-kuhn.chenqun@huawei.com>
 <87d0ar995e.fsf@linaro.org>
In-Reply-To: <87d0ar995e.fsf@linaro.org>
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
X-Received-From: 45.249.212.187
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEFsZXggQmVubsOpZSBbbWFp
bHRvOmFsZXguYmVubmVlQGxpbmFyby5vcmddDQo+U2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDYs
IDIwMjAgODo0NiBQTQ0KPlRvOiBDaGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5j
b20+DQo+Q2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgWmhhbmdoYWlsaWFuZw0KPjx6aGFuZy56
aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBxZW11LXRyaXZpYWxAbm9uZ251Lm9yZzsNCj5yaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnDQo+U3ViamVjdDogUmU6IFtQQVRDSF0gdGVzdHMvcGx1
Z2luOiBwcmV2ZW50IHVuaW5pdGlhbGl6ZWQgd2FybmluZw0KPg0KPg0KPmt1aG4uY2hlbnF1bkBo
dWF3ZWkuY29tIHdyaXRlczoNCj4NCj4+IEZyb206IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVh
d2VpLmNvbT4NCj4+DQo+PiBBY2NvcmRpbmcgdG8gdGhlIGdsaWJjIGZ1bmN0aW9uIHJlcXVpcmVt
ZW50cywgd2UgbmVlZCBpbml0aWFsaXNlICB0aGUNCj4+IHZhcmlhYmxlLiBPdGhlcndpc2UgdGhl
cmUgd2lsbCBiZSBjb21waWxhdGlvbiB3YXJuaW5nczoNCj4+DQo+PiBnbGliLWF1dG9jbGVhbnVw
cy5oOjI4OjM6IHdhcm5pbmc6IOKAmG91dOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGlu
DQo+PiB0aGlzIGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQo+PiAgICBnX2ZyZWUg
KCpwcCk7DQo+PiAgICBefn5+fn5+fn5+fn4NCj4+DQo+PiBSZXBvcnRlZC1ieTogRXVsZXIgUm9i
b3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFF1biA8
a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+DQo+UXVldWVkIHRvIHBsdWdpbnMvbmV4dCB3aXRo
IFRob21hcycgc2luZ2xlIGxpbmUgc3VnZ2VzdGlvbiwgdGhhbmtzLg0KDQpUaGFuayB5b3UhDQpC
eSB0aGUgd2F5LCAgd2hhdCBpcyBwbHVnaW5zL25leHQgY29ubmVjdGlvbiBhZGRyZXNzPw0KDQo+
DQo+PiAtLS0NCj4+ICB0ZXN0cy9wbHVnaW4vYmIuYyAgIHwgMiArLQ0KPj4gIHRlc3RzL3BsdWdp
bi9pbnNuLmMgfCAyICstDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3BsdWdpbi9iYi5jIGIvdGVz
dHMvcGx1Z2luL2JiLmMgaW5kZXgNCj4+IGYzMGJlYTA4ZGMuLjhiOWRhMjNhMDQgMTAwNjQ0DQo+
PiAtLS0gYS90ZXN0cy9wbHVnaW4vYmIuYw0KPj4gKysrIGIvdGVzdHMvcGx1Z2luL2JiLmMNCj4+
IEBAIC0yMiw3ICsyMiw3IEBAIHN0YXRpYyBib29sIGRvX2lubGluZTsNCj4+DQo+PiAgc3RhdGlj
IHZvaWQgcGx1Z2luX2V4aXQocWVtdV9wbHVnaW5faWRfdCBpZCwgdm9pZCAqcCkgIHsNCj4+IC0g
ICAgZ19hdXRvZnJlZSBnY2hhciAqb3V0Ow0KPj4gKyAgICBnX2F1dG9mcmVlIGdjaGFyICpvdXQg
PSBOVUxMOw0KPj4gICAgICBvdXQgPSBnX3N0cmR1cF9wcmludGYoImJiJ3M6ICUiIFBSSXU2NCIs
IGluc25zOiAlIiBQUkl1NjQgIlxuIiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJi
X2NvdW50LCBpbnNuX2NvdW50KTsNCj4+ICAgICAgcWVtdV9wbHVnaW5fb3V0cyhvdXQpOw0KPj4g
ZGlmZiAtLWdpdCBhL3Rlc3RzL3BsdWdpbi9pbnNuLmMgYi90ZXN0cy9wbHVnaW4vaW5zbi5jIGlu
ZGV4DQo+PiAwYThmNWEwMDAwLi5jODNiMWMwMTU3IDEwMDY0NA0KPj4gLS0tIGEvdGVzdHMvcGx1
Z2luL2luc24uYw0KPj4gKysrIGIvdGVzdHMvcGx1Z2luL2luc24uYw0KPj4gQEAgLTQ0LDcgKzQ0
LDcgQEAgc3RhdGljIHZvaWQgdmNwdV90Yl90cmFucyhxZW11X3BsdWdpbl9pZF90IGlkLA0KPj4g
c3RydWN0IHFlbXVfcGx1Z2luX3RiICp0YikNCj4+DQo+PiAgc3RhdGljIHZvaWQgcGx1Z2luX2V4
aXQocWVtdV9wbHVnaW5faWRfdCBpZCwgdm9pZCAqcCkgIHsNCj4+IC0gICAgZ19hdXRvZnJlZSBn
Y2hhciAqb3V0Ow0KPj4gKyAgICBnX2F1dG9mcmVlIGdjaGFyICpvdXQgPSBOVUxMOw0KPj4gICAg
ICBvdXQgPSBnX3N0cmR1cF9wcmludGYoImluc25zOiAlIiBQUkl1NjQgIlxuIiwgaW5zbl9jb3Vu
dCk7DQo+PiAgICAgIHFlbXVfcGx1Z2luX291dHMob3V0KTsNCj4+ICB9DQo+DQo+DQo+LS0NCj5B
bGV4IEJlbm7DqWUNCg==


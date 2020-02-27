Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CD2C4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8F524656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 07:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8F524656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7DCd-00082g-Lq
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 02:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53680)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j7DBj-0007ab-OZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j7DBW-0008B5-B7
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:02:20 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2073 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j7DBW-0007ZM-0W
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 02:02:14 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id E468B8EA4623831D8D76;
 Thu, 27 Feb 2020 15:02:02 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.163]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0439.000;
 Thu, 27 Feb 2020 15:01:53 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v3 12/19] tests/plugin: prevent uninitialized warning
Thread-Topic: [PATCH v3 12/19] tests/plugin: prevent uninitialized warning
Thread-Index: AQHV7K0RS6rDoJWrb0GDP0Lm6u5IrKgunULw
Date: Thu, 27 Feb 2020 07:01:52 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B663B13@dggemm531-mbx.china.huawei.com>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
 <20200225124710.14152-13-alex.bennee@linaro.org>
 <39f4a2a5-01d2-2f1d-6519-da8429a6dd3b@redhat.com>
In-Reply-To: <39f4a2a5-01d2-2f1d-6519-da8429a6dd3b@redhat.com>
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
X-Received-From: 45.249.212.189
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
Cc: "fam@euphon.net" <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "robert.foley@linaro.org" <robert.foley@linaro.org>,
 "stefanb@linux.vnet.ibm.com" <stefanb@linux.vnet.ibm.com>,
 "peter.puhov@linaro.org" <peter.puhov@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "f4bug@amsat.org" <f4bug@amsat.org>,
 "robhenry@microsoft.com" <robhenry@microsoft.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "aaron@os.amperecomputing.com" <aaron@os.amperecomputing.com>,
 "cota@braap.org" <cota@braap.org>, "stefanha@redhat.com" <stefanha@redhat.com>,
 Euler Robot <euler.robot@huawei.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURh
dWTDqSBbbWFpbHRvOnBoaWxtZEByZWRoYXQuY29tXQ0KPlNlbnQ6IFdlZG5lc2RheSwgRmVicnVh
cnkgMjYsIDIwMjAgMTA6MDAgUE0NCj5UbzogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5h
cm8ub3JnPjsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+Q2M6IGZhbUBldXBob24ubmV0OyBUaG9t
YXMgSHV0aCA8dGh1dGhAcmVkaGF0LmNvbT47DQo+YmVycmFuZ2VAcmVkaGF0LmNvbTsgcm9iZXJ0
LmZvbGV5QGxpbmFyby5vcmc7IHBib256aW5pQHJlZGhhdC5jb207DQo+c3RlZmFuYkBsaW51eC52
bmV0LmlibS5jb207IEV1bGVyIFJvYm90IDxldWxlci5yb2JvdEBodWF3ZWkuY29tPjsNCj5yaWNo
YXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOyBmNGJ1Z0BhbXNhdC5vcmc7IHJvYmhlbnJ5QG1pY3Jv
c29mdC5jb207DQo+bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tOyBhYXJvbkBvcy5hbXBlcmVj
b21wdXRpbmcuY29tOw0KPmNvdGFAYnJhYXAub3JnOyBzdGVmYW5oYUByZWRoYXQuY29tOyBDaGVu
cXVuIChrdWhuKQ0KPjxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT47IHBldGVyLnB1aG92QGxpbmFy
by5vcmc7DQo+YXVyZWxpZW5AYXVyZWwzMi5uZXQNCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDEy
LzE5XSB0ZXN0cy9wbHVnaW46IHByZXZlbnQgdW5pbml0aWFsaXplZCB3YXJuaW5nDQo+DQo+T24g
Mi8yNS8yMCAxOjQ3IFBNLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+PiBGcm9tOiBDaGVuIFF1biA8
a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+Pg0KPj4gQWNjb3JkaW5nIHRvIHRoZSBnbGliYyBm
dW5jdGlvbiByZXF1aXJlbWVudHMsIHdlIG5lZWQgaW5pdGlhbGlzZQ0KPg0KPkdMaWI/DQpZZXMs
IEdsaWIgZnVuY3Rpb24gcmVxdWlyZW1lbnRzLg0KaHR0cHM6Ly9kZXZlbG9wZXIuZ25vbWUub3Jn
L2dsaWIvc3RhYmxlL2dsaWItTWlzY2VsbGFuZW91cy1NYWNyb3MuaHRtbCNnLWF1dG9mcmVlDQoN
ClRoYW5rcy4NCj4NCj4+ICAgdGhlIHZhcmlhYmxlLiBPdGhlcndpc2UgdGhlcmUgd2lsbCBiZSBj
b21waWxhdGlvbiB3YXJuaW5nczoNCj4+DQo+PiBnbGliLWF1dG9jbGVhbnVwcy5oOjI4OjM6IHdh
cm5pbmc6IOKAmG91dOKAmSBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluDQo+PiB0aGlzIGZ1
bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQo+PiAgICAgZ19mcmVlICgqcHApOw0KPj4g
ICAgIF5+fn5+fn5+fn5+fg0KPj4NCj4+IFJlcG9ydGVkLWJ5OiBFdWxlciBSb2JvdCA8ZXVsZXIu
cm9ib3RAaHVhd2VpLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IENoZW4gUXVuIDxrdWhuLmNoZW5x
dW5AaHVhd2VpLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBUaG9tYXMgSHV0aCA8dGh1dGhAcmVkaGF0
LmNvbT4NCj4+IE1lc3NhZ2UtSWQ6IDwyMDIwMDIwNjA5MzIzOC4yMDM5ODQtMS1rdWhuLmNoZW5x
dW5AaHVhd2VpLmNvbT4NCj4+IFtBSkI6IHVzZXMgVGhvbWFzJ3Mgc2luZ2xlIGxpbmUgYWxsb2Nh
dGlvbl0NCj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJv
Lm9yZz4NCj4+IFJldmlld2VkLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJz
b25AbGluYXJvLm9yZz4NCj4+IC0tLQ0KPj4gICB0ZXN0cy9wbHVnaW4vYmIuYyAgIHwgNiArKyst
LS0NCj4+ICAgdGVzdHMvcGx1Z2luL2luc24uYyB8IDMgKy0tDQo+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90
ZXN0cy9wbHVnaW4vYmIuYyBiL3Rlc3RzL3BsdWdpbi9iYi5jIGluZGV4DQo+PiBmMzBiZWEwOGRj
Yy4uZGYxOWZkMzU5ZGYgMTAwNjQ0DQo+PiAtLS0gYS90ZXN0cy9wbHVnaW4vYmIuYw0KPj4gKysr
IGIvdGVzdHMvcGx1Z2luL2JiLmMNCj4+IEBAIC0yMiw5ICsyMiw5IEBAIHN0YXRpYyBib29sIGRv
X2lubGluZTsNCj4+DQo+PiAgIHN0YXRpYyB2b2lkIHBsdWdpbl9leGl0KHFlbXVfcGx1Z2luX2lk
X3QgaWQsIHZvaWQgKnApDQo+PiAgIHsNCj4+IC0gICAgZ19hdXRvZnJlZSBnY2hhciAqb3V0Ow0K
Pj4gLSAgICBvdXQgPSBnX3N0cmR1cF9wcmludGYoImJiJ3M6ICUiIFBSSXU2NCIsIGluc25zOiAl
IiBQUkl1NjQgIlxuIiwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgIGJiX2NvdW50LCBp
bnNuX2NvdW50KTsNCj4+ICsgICAgZ19hdXRvZnJlZSBnY2hhciAqb3V0ID0gZ19zdHJkdXBfcHJp
bnRmKA0KPj4gKyAgICAgICAgImJiJ3M6ICUiIFBSSXU2NCIsIGluc25zOiAlIiBQUkl1NjQgIlxu
IiwNCj4+ICsgICAgICAgIGJiX2NvdW50LCBpbnNuX2NvdW50KTsNCj4+ICAgICAgIHFlbXVfcGx1
Z2luX291dHMob3V0KTsNCj4+ICAgfQ0KPj4NCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9wbHVnaW4v
aW5zbi5jIGIvdGVzdHMvcGx1Z2luL2luc24uYyBpbmRleA0KPj4gMGE4ZjVhMDAwMGUuLmE5YTZl
NDEyMzczIDEwMDY0NA0KPj4gLS0tIGEvdGVzdHMvcGx1Z2luL2luc24uYw0KPj4gKysrIGIvdGVz
dHMvcGx1Z2luL2luc24uYw0KPj4gQEAgLTQ0LDggKzQ0LDcgQEAgc3RhdGljIHZvaWQgdmNwdV90
Yl90cmFucyhxZW11X3BsdWdpbl9pZF90IGlkLA0KPj4gc3RydWN0IHFlbXVfcGx1Z2luX3RiICp0
YikNCj4+DQo+PiAgIHN0YXRpYyB2b2lkIHBsdWdpbl9leGl0KHFlbXVfcGx1Z2luX2lkX3QgaWQs
IHZvaWQgKnApDQo+PiAgIHsNCj4+IC0gICAgZ19hdXRvZnJlZSBnY2hhciAqb3V0Ow0KPj4gLSAg
ICBvdXQgPSBnX3N0cmR1cF9wcmludGYoImluc25zOiAlIiBQUkl1NjQgIlxuIiwgaW5zbl9jb3Vu
dCk7DQo+PiArICAgIGdfYXV0b2ZyZWUgZ2NoYXIgKm91dCA9IGdfc3RyZHVwX3ByaW50ZigiaW5z
bnM6ICUiIFBSSXU2NCAiXG4iLA0KPj4gKyBpbnNuX2NvdW50KTsNCj4+ICAgICAgIHFlbXVfcGx1
Z2luX291dHMob3V0KTsNCj4+ICAgfQ0KPj4NCj4+DQoNCg==


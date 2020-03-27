Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D40C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E08206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 09:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E08206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHlXP-0000py-2w
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 05:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jHlWl-0000P6-Qd
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jHlWk-0000dy-Es
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 05:43:47 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2081 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jHlWj-0000P3-K3; Fri, 27 Mar 2020 05:43:46 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 3C76AF4FE95B2783E299;
 Fri, 27 Mar 2020 17:43:37 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 27 Mar 2020 17:43:36 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.202]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0487.000;
 Fri, 27 Mar 2020 17:43:29 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH 1/3] gdbstub: prevent uninitialized warning
Thread-Topic: [PATCH 1/3] gdbstub: prevent uninitialized warning
Thread-Index: AQHWAoba+W411pX0qU+twtHpe83Qn6hbpIQAgACL2AA=
Date: Fri, 27 Mar 2020 09:43:29 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B6C9255@dggemm511-mbx.china.huawei.com>
References: <20200325092137.24020-1-kuhn.chenqun@huawei.com>
 <20200325092137.24020-2-kuhn.chenqun@huawei.com> <874kuanou9.fsf@linaro.org>
In-Reply-To: <874kuanou9.fsf@linaro.org>
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>,
 "mrezanin@redhat.com" <mrezanin@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQWxleCBCZW5uw6llIFttYWlsdG86
YWxleC5iZW5uZWVAbGluYXJvLm9yZ10NCj5TZW50OiBGcmlkYXksIE1hcmNoIDI3LCAyMDIwIDU6
MTMgUE0NCj5UbzogQ2hlbnF1biAoa3VobikgPGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0KPkNj
OiBxZW11LWRldmVsQG5vbmdudS5vcmc7IHFlbXUtdHJpdmlhbEBub25nbnUub3JnOyBaaGFuZ2hh
aWxpYW5nDQo+PHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IGxhdXJlbnRAdml2aWVy
LmV1OyBFdWxlciBSb2JvdA0KPjxldWxlci5yb2JvdEBodWF3ZWkuY29tPjsgUGhpbGlwcGUgTWF0
aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8z
XSBnZGJzdHViOiBwcmV2ZW50IHVuaW5pdGlhbGl6ZWQgd2FybmluZw0KPg0KPg0KPkNoZW4gUXVu
IDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4gd3JpdGVzOg0KPg0KPj4gQWNjb3JkaW5nIHRvIHRo
ZSBnbGliIGZ1bmN0aW9uIHJlcXVpcmVtZW50cywgd2UgbmVlZCBpbml0aWFsaXNlDQo+PiAgICAg
IHRoZSB2YXJpYWJsZS4gT3RoZXJ3aXNlIHRoZXJlIHdpbGwgYmUgY29tcGlsYXRpb24gd2Fybmlu
Z3M6DQo+Pg0KPj4gcWVtdS9nZGJzdHViLmM6IEluIGZ1bmN0aW9uIOKAmGhhbmRsZV9xdWVyeV90
aHJlYWRfZXh0cmHigJk6DQo+PiAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi9nbGliLWF1dG9j
bGVhbnVwcy5oOjI4OjM6IHdhcm5pbmc6DQo+PiAg4oCYY3B1X25hbWXigJkgbWF5IGJlIHVzZWQg
dW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV21heWJlLXVuaW5pdGlhbGl6ZWRdDQo+
PiAgICBnX2ZyZWUgKCpwcCk7DQo+PiAgICBefn5+fn5+fn5+fn4NCj4+DQo+PiBSZXBvcnRlZC1i
eTogRXVsZXIgUm9ib3QgPGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBDaGVuIFF1biA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+DQo+DQo+VGhhbmtzLA0KPg0KPkkn
dmUgcHVsbGVkIGluIGEgZHVwbGljYXRlIGZpeCBmcm9tOg0KPg0KPiAgTWVzc2FnZS1JZDogPDIw
MjAwMzI2MTUxNDA3LjI1MDQ2LTEtZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tPg0KPg0KPmFuZCBh
ZGRlZCB5b3VyIFJlcG9ydGVkLWJ5J3MNCg0KT0ssICBJZiBwb3NzaWJsZSwgYnJpbmcgTWlyb3Ns
YXYgUmV6YW5pbmEncyAgIlJldmlld2VkLWJ5IiB0YWcuDQoNCmh0dHBzOi8vbGlzdHMuZ251Lm9y
Zy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIwLTAzL21zZzA3NjUxLmh0bWwNCg0KVGhhbmtz
Lg0KPg0KPj4gLS0tDQo+PiBDYzogIkFsZXggQmVubsOpZSIgPGFsZXguYmVubmVlQGxpbmFyby5v
cmc+DQo+PiBDYzogIlBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIiA8cGhpbG1kQHJlZGhhdC5jb20+
DQo+PiAtLS0NCj4+ICBnZGJzdHViLmMgfCA0ICsrLS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9nZGJzdHVi
LmMgYi9nZGJzdHViLmMNCj4+IGluZGV4IDAxM2ZiMWFjMGYuLjE3MWUxNTA5NTAgMTAwNjQ0DQo+
PiAtLS0gYS9nZGJzdHViLmMNCj4+ICsrKyBiL2dkYnN0dWIuYw0KPj4gQEAgLTIwNjAsOCArMjA2
MCw4IEBAIHN0YXRpYyB2b2lkDQo+aGFuZGxlX3F1ZXJ5X3RocmVhZF9leHRyYShHZGJDbWRDb250
ZXh0ICpnZGJfY3R4LCB2b2lkICp1c2VyX2N0eCkNCj4+ICAgICAgICAgIC8qIFByaW50IHRoZSBD
UFUgbW9kZWwgYW5kIG5hbWUgaW4gbXVsdGlwcm9jZXNzIG1vZGUgKi8NCj4+ICAgICAgICAgIE9i
amVjdENsYXNzICpvYyA9IG9iamVjdF9nZXRfY2xhc3MoT0JKRUNUKGNwdSkpOw0KPj4gICAgICAg
ICAgY29uc3QgY2hhciAqY3B1X21vZGVsID0gb2JqZWN0X2NsYXNzX2dldF9uYW1lKG9jKTsNCj4+
IC0gICAgICAgIGdfYXV0b2ZyZWUgY2hhciAqY3B1X25hbWU7DQo+PiAtICAgICAgICBjcHVfbmFt
ZSAgPSBvYmplY3RfZ2V0X2Nhbm9uaWNhbF9wYXRoX2NvbXBvbmVudChPQkpFQ1QoY3B1KSk7DQo+
PiArICAgICAgICBnX2F1dG9mcmVlIGNoYXIgKmNwdV9uYW1lID0NCj4+ICsgICAgICAgICAgICBv
YmplY3RfZ2V0X2Nhbm9uaWNhbF9wYXRoX2NvbXBvbmVudChPQkpFQ1QoY3B1KSk7DQo+PiAgICAg
ICAgICBnX3N0cmluZ19wcmludGYocnMsICIlcyAlcyBbJXNdIiwgY3B1X21vZGVsLCBjcHVfbmFt
ZSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBjcHUtPmhhbHRlZCA/ICJoYWx0ZWQgIiA6
ICJydW5uaW5nIik7DQo+PiAgICAgIH0gZWxzZSB7DQo+DQo+DQo+LS0NCj5BbGV4IEJlbm7DqWUN
Cg==


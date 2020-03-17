Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DCEC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7909C20663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7909C20663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9Tm-0003m9-L6
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57436)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jE9GQ-0005N2-Ik
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:15:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jE9GO-0006My-KO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:15:58 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2511 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jE9GO-0005Lp-7S
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:15:56 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id DA7D17B9018C35A16583;
 Tue, 17 Mar 2020 18:15:49 +0800 (CST)
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.221]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0439.000;
 Tue, 17 Mar 2020 18:15:39 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] qom-qmp-cmds: Fix another memory leak in qmp_object_add()
Thread-Topic: [PATCH] qom-qmp-cmds: Fix another memory leak in qmp_object_add()
Thread-Index: AQHV/D3In4NOl2cshU65ZirmzAslvahMjsHQ
Date: Tue, 17 Mar 2020 10:15:39 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B69E58A@dggemm531-mbx.china.huawei.com>
References: <20200317092241.31660-1-armbru@redhat.com>
In-Reply-To: <20200317092241.31660-1-armbru@redhat.com>
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
Cc: Kevin Wolf <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 Pannengyuan <pannengyuan@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUWVtdS1kZXZlbCBbbWFpbHRvOnFl
bXUtZGV2ZWwtDQo+Ym91bmNlcytrdWhuLmNoZW5xdW49aHVhd2VpLmNvbUBub25nbnUub3JnXSBP
biBCZWhhbGYgT2YgTWFya3VzDQo+QXJtYnJ1c3Rlcg0KPlNlbnQ6IFR1ZXNkYXksIE1hcmNoIDE3
LCAyMDIwIDU6MjMgUE0NCj5UbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+Q2M6IEtldmluIFdv
bGYgPGt3b2xmQHJlZGhhdC5jb20+OyBwYm9uemluaUByZWRoYXQuY29tOw0KPmJlcnJhbmdlQHJl
ZGhhdC5jb207IGVoYWJrb3N0QHJlZGhhdC5jb20NCj5TdWJqZWN0OiBbUEFUQ0hdIHFvbS1xbXAt
Y21kczogRml4IGFub3RoZXIgbWVtb3J5IGxlYWsgaW4NCj5xbXBfb2JqZWN0X2FkZCgpDQo+DQo+
V2hlbiB1c2VyX2NyZWF0YWJsZV9hZGRfdHlwZSgpIGZhaWxzLCBxbXBfb2JqZWN0X2FkZCgpIHJl
dHVybnMgYm90aCBpdHMNCj5lcnJvciBhbmQgdGhlIHVzdWFsIGVtcHR5IFFEaWN0IHN1Y2Nlc3Mg
dmFsdWUuICBUaGUgUU1QIGNvcmUgaGFuZGxlcyB0aGUNCj5lcnJvciwgYW5kIGlnbm9yZXMgdGhl
IHN1Y2Nlc3MgdmFsdWUsIGxlYWtpbmcgaXQuICBFeHBvc2VkIGJ5IHFtcC1jbWQtdGVzdA0KPmNh
c2UgL3g4Nl82NC9xbXAvb2JqZWN0LWFkZC13aXRob3V0LXByb3BzLCBhbmQgZHVseSByZXBvcnRl
ZCBib3RoIGJ5DQo+QVNhbiBhbmQgdmFsZ3JpbmQuDQo+DQo+VG8gcGx1ZyB0aGUgbGVhaywgc2V0
IHRoZSBzdWNjZXNzIHZhbHVlIG9ubHkgb24gc3VjY2Vzcy4NCj4NCj5GaXhlczogNWYwN2M0ZDYw
ZDA5MTMyMDE4NmU3YjBlZGFmOWVkMmNjMTZiMmQxZQ0KPkNjOiBLZXZpbiBXb2xmIDxrd29sZkBy
ZWRoYXQuY29tPg0KPlNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVk
aGF0LmNvbT4NCj4tLS0NCkhpLCAgTWFya3VzDQoNCiAgICAgICAgTG9va3MgbGlrZSB0aGUgc2Ft
ZSBwYXRjaCB0aGF0IGhhcyBiZWVuIHJlcG9ydGVkIGFscmVhZHkgaGVyZToNCmh0dHBzOi8vbGlz
dHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDIwLTAzL21zZzAzOTI4Lmh0bWwN
Cg0KTWF5YmUgd2Ugc2hvdWxkIGluaXRpYWxpemUgcmV0X2RhdGEgaW4geGVuLWJsb2NrIHRvIGF2
b2lkIGEgcG9zc2libGUgdW5pbml0aWFsaXplZCBlcnJvciDvvJ8NCg0KVGhhbmtzLg0KPiBxb20v
cW9tLXFtcC1jbWRzLmMgfCAyICstDQo+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQ0KPg0KPmRpZmYgLS1naXQgYS9xb20vcW9tLXFtcC1jbWRzLmMgYi9xb20v
cW9tLXFtcC1jbWRzLmMgaW5kZXgNCj40MzUxOTNiMDM2Li42YmQxMzdjY2JmIDEwMDY0NA0KPi0t
LSBhL3FvbS9xb20tcW1wLWNtZHMuYw0KPisrKyBiL3FvbS9xb20tcW1wLWNtZHMuYw0KPkBAIC0y
ODcsOCArMjg3LDggQEAgdm9pZCBxbXBfb2JqZWN0X2FkZChRRGljdCAqcWRpY3QsIFFPYmplY3QN
Cj4qKnJldF9kYXRhLCBFcnJvciAqKmVycnApDQo+ICAgICB2aXNpdF9mcmVlKHYpOw0KPiAgICAg
aWYgKG9iaikgew0KPiAgICAgICAgIG9iamVjdF91bnJlZihvYmopOw0KPisgICAgICAgICpyZXRf
ZGF0YSA9IFFPQkpFQ1QocWRpY3RfbmV3KCkpOw0KPiAgICAgfQ0KPi0gICAgKnJldF9kYXRhID0g
UU9CSkVDVChxZGljdF9uZXcoKSk7DQo+IH0NCj4NCj4gdm9pZCBxbXBfb2JqZWN0X2RlbChjb25z
dCBjaGFyICppZCwgRXJyb3IgKiplcnJwKQ0KPi0tDQo+Mi4yMS4xDQo+DQoNCg==


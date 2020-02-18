Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE182C34034
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21E520659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21E520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zZU-0000xh-0H
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44015)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j3zSV-0005TH-Ps
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1j3zSU-0006mA-9b
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:46:27 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2445 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1j3zST-0006kK-VE; Tue, 18 Feb 2020 04:46:26 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id A3E3917E15AFEF0B8EC3;
 Tue, 18 Feb 2020 17:46:19 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 17:46:19 +0800
Received: from DGGEMM531-MBX.china.huawei.com ([169.254.5.165]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0439.000;
 Tue, 18 Feb 2020 17:46:09 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org"
 <qemu-ppc@nongnu.org>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
 "crwulff@gmail.com" <crwulff@gmail.com>, "marex@denx.de" <marex@denx.de>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Subject: RE: [PATCH 0/3]hw: Fixs memleak of fdevice tree blob
Thread-Topic: [PATCH 0/3]hw: Fixs memleak of fdevice tree blob
Thread-Index: AQHV5jvGomOGww3FYUqlb9mV7XuhSKggsH8g
Date: Tue, 18 Feb 2020 09:46:09 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B64D2E5@dggemm531-mbx.china.huawei.com>
References: <20200218091154.21696-1-kuhn.chenqun@huawei.com>
In-Reply-To: <20200218091154.21696-1-kuhn.chenqun@huawei.com>
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
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Pannengyuan <pannengyuan@huawei.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENoZW5xdW4gKGt1aG4pDQo+
U2VudDogVHVlc2RheSwgRmVicnVhcnkgMTgsIDIwMjAgNToxMiBQTQ0KPlRvOiBxZW11LWRldmVs
QG5vbmdudS5vcmc7IHFlbXUtcHBjQG5vbmdudS5vcmc7IGpjbXZia2JjQGdtYWlsLmNvbTsNCj5j
cnd1bGZmQGdtYWlsLmNvbTsgbWFyZXhAZGVueC5kZTsgZWRnYXIuaWdsZXNpYXNAZ21haWwuY29t
Ow0KPmRhdmlkQGdpYnNvbi5kcm9wYmVhci5pZC5hdQ0KPkNjOiBaaGFuZ2hhaWxpYW5nIDx6aGFu
Zy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+OyBxZW11LQ0KPnRyaXZpYWxAbm9uZ251Lm9yZzsg
cGJvbnppbmlAcmVkaGF0LmNvbTsgUGFubmVuZ3l1YW4NCj48cGFubmVuZ3l1YW5AaHVhd2VpLmNv
bT47IENoZW5xdW4gKGt1aG4pDQo+PGt1aG4uY2hlbnF1bkBodWF3ZWkuY29tPg0KPlN1YmplY3Q6
IFtQQVRDSCAwLzNdaHc6IEZpeHMgbWVtbGVhayBvZiBmZGV2aWNlIHRyZWUgYmxvYg0KPg0KPkZy
b206IENoZW4gUXVuIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj4NCkhpIGFsbCwgYWZ0ZXIg
cmV2aWV3aW5nIHZhcmlvdXMgcGF0Y2hlcyBmcm9tIFBhbiBOZW5neXVhbiBmaXggcHBjLWU1MDAN
CmZkdCBtZW1sZWFrcywgSSBzZWFyY2ggZm9yIHJlbGF0ZWQgY29udGVudCBhbmQgZm91bmQgUGFv
bG8gQm9uemluaSdzDQpzaW1pbGFybHkgcGF0Y2hzLiAoc29ycnksIHRoaXMgZGVzY3JpcHRpb24g
aXMgbWlzc2luZyBoZXJlIGJlY2F1c2Ugb2YgdGhpcyBwYXRjaCBmb3JtYXQuKQ0KDQo+VGhlIGRl
dmljZSB0cmVlIGJsb2IgcmV0dXJuZWQgYnkgbG9hZF9kZXZpY2VfdHJlZSBpcyBtYWxsb2NlZC4N
Cj5XZSBzaG91bGQgZnJlZSBpdCBhZnRlciBjcHVfcGh5c2ljYWxfbWVtb3J5X3dyaXRlKCkuT3Ro
ZXJ3aXNlLA0KPmlmIHdlIHJlcGVhdGVkbHkgY2FsbCAnc3lzdGVtX3Jlc2V0JyxpdCB3aWxsIHJl
cGVhdGVkbHkgbG9hZCBmZHQsIHNvIHRoZXJlIGFyZQ0KPm1hbnkgbWVtbGVha3MuDQo+DQo+UGFv
bG8gQm9uemluaSA6DQo+aHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRl
dmVsLzIwMTktMTAvbXNnMDAxMjkuaHRtbA0KPg0KPlBhbiBOZW5neXVhbjoNCj5odHRwczovL2xp
c3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMC0wMi9tc2cwMzU5NC5odG1s
DQo+DQo+QWZ0ZXIgc2VhcmNoaW5nIHRoZSBkZXZpY2UgY29kZSwgSSBmb3VuZCB0aHJlZSBzaW1p
bGFyIGlzc3Vlcy4NCj5UaGlzIHNlcmllcyBmaXhlcyB0aGUgbGFzdCB0aHJlZS4NCj4NCj5DaGVu
IFF1biAoMyk6DQo+ICBody9uaW9zMjpmaXggbGVhayBvZiBmZGV2aWNlIHRyZWUgYmxvYg0KPiAg
aHcvcHBjL3ZpcnRleF9tbDUwNzpmaXggbGVhayBvZiBmZGV2aWNlIHRyZWUgYmxvYg0KPiAgaHcv
eHRlbnNhL3h0ZnBnYTpmaXggbGVhayBvZiBmZGV2aWNlIHRyZWUgYmxvYg0KPg0KPiBody9uaW9z
Mi9ib290LmMgICAgICAgfCAxICsNCj4gaHcvcHBjL3ZpcnRleF9tbDUwNy5jIHwgMSArDQo+IGh3
L3h0ZW5zYS94dGZwZ2EuYyAgICB8IDEgKw0KPiAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQ0KPg0KPi0tDQo+Mi4yMy4wDQo+DQoNCg==


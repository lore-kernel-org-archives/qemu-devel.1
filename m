Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFCAC2BB85
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 01:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D40A32064A
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 01:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40A32064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNncf-0002k7-W9
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 21:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1jNnbv-0002FB-J3
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 21:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.zhanghailiang@huawei.com>) id 1jNnbt-0004JX-Ji
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 21:10:03 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2518 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jNnbs-0004A1-9E
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 21:10:01 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id B53E280D4546FFB21919;
 Mon, 13 Apr 2020 09:09:52 +0800 (CST)
Received: from dggeme705-chm.china.huawei.com (10.1.199.101) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 13 Apr 2020 09:09:51 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme705-chm.china.huawei.com (10.1.199.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Mon, 13 Apr 2020 09:09:52 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1713.004;
 Mon, 13 Apr 2020 09:09:52 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Lukas Straub <lukasstraub2@web.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: =?gb2312?B?tPC4tDogY29sbzogcWVtdSA0LjIuMCB2cy4gcWVtdSA1LjAuMC1yYzIgcGVy?=
 =?gb2312?Q?formance_regression?=
Thread-Topic: colo: qemu 4.2.0 vs. qemu 5.0.0-rc2 performance regression
Thread-Index: AQHWECUPCma/tvNQPkyB0P5DKRtjX6h2O8hg
Date: Mon, 13 Apr 2020 01:09:52 +0000
Message-ID: <7abf22034e5d4c41a5ca369bf94a681a@huawei.com>
References: <20200411191655.0365532d@luklap>
In-Reply-To: <20200411191655.0365532d@luklap>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="gb2312"
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
Cc: Zhang Chen <chen.zhang@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "quintela@redhat.com" <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGksDQoNClRoaXMgcGF0Y2ggIiBDT0xPOiBPcHRpbWl6ZSBtZW1vcnkgYmFjay11cCBwcm9jZXNz
ICIgc2hvdWxkIG9ubHkgYWZmZWN0cyBWTSdzIG1pZ3JhdGlvbiBwcm9jZXNzIGJlZm9yZSBDT0xP
IGNvbXBhcmUgc3RhcnRpbmcgdG8gd29yay4NCkhhdmUgeW91IHRyaWVkIHRvIHJldmVydCB0aGlz
IHBhdGNoIHRvIHNlZSBpZiBpdCBhZmZlY3RzIHlvdXIgdGVzdHMgPw0KDQpGb3IgbWVtb3J5IHNp
emUgd2UgdXNlZCBmb3Igc2Vjb25kYXJ5IHFlbXUsIHdlIG9ubHkgbmVlZCBhIGJhY2t1cCBvZiBW
TSdzIHJhbSwgc28gaXQgc2hvdWxkIGJlIGRvdWJsZSBhbW91bnQuDQoNCg0KVGhhbmtzLA0KSGFp
bGlhbmcNCg0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogTHVrYXMgU3RyYXViIFttYWls
dG86bHVrYXNzdHJhdWIyQHdlYi5kZV0gDQq3osvNyrG85DogMjAyMMTqNNTCMTLI1SAxOjE3DQrK
1bz+yMs6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0Ks63LzTogZGdpbGJlcnRAcmVkaGF0LmNvbTsg
cXVpbnRlbGFAcmVkaGF0LmNvbTsgWmhhbmdoYWlsaWFuZyA8emhhbmcuemhhbmdoYWlsaWFuZ0Bo
dWF3ZWkuY29tPjsgWmhhbmcgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+DQrW98ziOiBjb2xv
OiBxZW11IDQuMi4wIHZzLiBxZW11IDUuMC4wLXJjMiBwZXJmb3JtYW5jZSByZWdyZXNzaW9uDQoN
CkhlbGxvIEV2ZXJ5b25lLA0KSSBkaWQgc29tZSBCZW5jaG1hcmtpbmcgd2l0aCBpcGVyZjMgYW5k
IG1lbXRlc3RlciAodG8gZGlydHkgc29tZSBndWVzdCBtZW1vcnkpIG9mIGNvbG8gcGVyZm9ybWFu
Y2UgaW4gcWVtdSA0LjIuMCBhbmQgaW4gcWVtdSA1LjAuMC1yYzIgd2l0aCBteSBidWdmaXhlcyBv
biB0b3AuKCBodHRwczovL2xpc3RzLm5vbmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwv
MjAyMC0wNC9tc2cwMTQzMi5odG1sICkNCg0KSSBoYXZlIHRha2VuIHRoZSBhdmVyYWdlIG92ZXIg
NCBydW5zLg0KQ2xpZW50LXRvLXNlcnZlciB0Y3AgYmFuZHdpZHRoIHJvc2Ugc2xpZ2h0bHkgZnJv
bSB+ODMuOTggTWJpdC9zIHRvIH44OS40MCBNYml0cy4NClNlcnZlci10by1jbGllbnQgdGNwIGJh
bmR3aWR0aCBmZWxsIGZyb20gfjkuNzMgTWJpdC9zIHRvIH4xLjc5IE1iaXQvcy4NCkNsaWVudC10
by1zZXJ2ZXIgdWRwIGJhbmR3aWR0aCBzdGF5ZWQgdGhlIHNhbWUgYXQgMS4wNSBNYml0L3MgYW5k
IGppdHRlciByb3NlIGZyb20gfjUuMTIgbXMgdG8gfjEwLjc3IG1zLg0KU2VydmVyLXRvLWNsaWVu
dCB1ZHAgYmFuZHdpZHRoIGZlbGwgZnJvbSB+MzgwLjUgS2JpdC9zIHRvIH4zMy42IEtiaXQvcyBh
bmQgaml0dGVyIHJvc2UgZnJvbSB+NDEuNzQgbXMgdG8gfjgzOTc2LjE1IG1zICghKS4NCg0KSSBo
YXZlbid0IGxvb2tlZCBjbG9zZWx5IGludG8gaXQsIGJ1dCBpIHRoaW5rDQowMzkzMDMxYTE2NzM1
ODM1YTQ0MWI2ZDZlMDQ5NWExYmQxNGFkYjkwICJDT0xPOiBPcHRpbWl6ZSBtZW1vcnkgYmFjay11
cCBwcm9jZXNzIg0KaXMgdGhlIGN1bHByaW50IGFzIGl0IHJlZHVjZXMgdm0gZG93bnRpbWUgZm9y
IHRoZSBjaGVja3BvaW50cyBidXQgaW5jcmVhc2VzIHRoZSBvdmVyYWxsIGNoZWNrcG9pbnQgdGlt
ZSBhbmQgd2UgY2FuIG9ubHkgcmVsZWFzZSBtaXNjb21wYXJlZCBwcmltYXJ5IHBhY2tldHMgYWZ0
ZXIgdGhlIGNoZWNrcG9pbnQgaXMgY29tcGxldGVseSBmaW5pc2hlZC4NCg0KQW5vdGhlciB0aGlu
ZyB0aGF0IEkgbm90aWNlZDogV2l0aCA0LjIuMCwgdGhlIHNlY29uZGFyeSBxZW11IHVzZXMgdGhy
aWNlIHRoZSBhbW91bnQgb2YgZ2VzdCBtZW1vcnkuIFdpdGggNS4wLjAtcmMyIGl0J3MganVzdCBk
b3VibGUgdGhlIGFtb3VudCBvZiBndWVzdCBtZW1vcnkuIFNvIG1heWJlIHRoZSByYW0gY2FjaGUg
aXNuJ3Qgd29ya2luZyBwcm9wZXJseT8NCg0KUmVnYXJkcywNCkx1a2FzIFN0cmF1Yg0K


Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817A1C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9515C22272
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 09:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9515C22272
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=h3c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZVnH-0000OO-EP
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 04:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1kZVmI-0008Cu-LT; Mon, 02 Nov 2020 04:05:26 -0500
Received: from smtp.h3c.com ([60.191.123.56]:9764 helo=h3cspam01-ex.h3c.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tu.guoyi@h3c.com>)
 id 1kZVmE-0007OD-O9; Mon, 02 Nov 2020 04:05:25 -0500
Received: from DAG2EX02-BASE.srv.huawei-3com.com ([10.8.0.65])
 by h3cspam01-ex.h3c.com with ESMTPS id 0A294sHu037680
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Nov 2020 17:04:54 +0800 (GMT-8)
 (envelope-from tu.guoyi@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX02-BASE.srv.huawei-3com.com (10.8.0.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 2 Nov 2020 17:04:57 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7])
 with mapi id 15.01.2106.002; Mon, 2 Nov 2020 17:04:57 +0800
From: Tuguoyi <tu.guoyi@h3c.com>
To: "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: [PATCH] qemu-img: Make sure @sn_opts can be deleted in all error cases
Thread-Topic: [PATCH] qemu-img: Make sure @sn_opts can be deleted in all error
 cases
Thread-Index: Adaw9yiaXCeh3bnoRzW4v9HKxcO/5A==
Date: Mon, 2 Nov 2020 09:04:57 +0000
Message-ID: <6ff1c5d372944494be3932274f75485d@h3c.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.125.108.131]
x-sender-location: DAG2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0A294sHu037680
Received-SPF: pass client-ip=60.191.123.56; envelope-from=tu.guoyi@h3c.com;
 helo=h3cspam01-ex.h3c.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 04:05:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QHNuX29wdHMgaXMgaW5pdGlhbGl6ZWQgYXQgdGhlIGJlZ2lubmluZywgc28gaXQgc2hvdWxkIGJl
IGRlbGV0ZWQNCmFmdGVyIGp1bXBpbmcgdG8gdGhlIGxhYmxlICdmYWlsX2dldG9wdCcNCg0KU2ln
bmVkLW9mZi1ieTogR3VveWkgVHUgPHR1Lmd1b3lpQGgzYy5jb20+DQotLS0NCiBxZW11LWltZy5j
IHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
DQpkaWZmIC0tZ2l0IGEvcWVtdS1pbWcuYyBiL3FlbXUtaW1nLmMNCmluZGV4IDIxMDM1MDcuLjIy
OWNkZjkgMTAwNjQ0DQotLS0gYS9xZW11LWltZy5jDQorKysgYi9xZW11LWltZy5jDQpAQCAtMjcx
OSw3ICsyNzE5LDYgQEAgb3V0Og0KICAgICBxZW11X3Byb2dyZXNzX2VuZCgpOw0KICAgICBxZW11
X29wdHNfZGVsKG9wdHMpOw0KICAgICBxZW11X29wdHNfZnJlZShjcmVhdGVfb3B0cyk7DQotICAg
IHFlbXVfb3B0c19kZWwoc25fb3B0cyk7DQogICAgIHFvYmplY3RfdW5yZWYob3Blbl9vcHRzKTsN
CiAgICAgYmxrX3VucmVmKHMudGFyZ2V0KTsNCiAgICAgaWYgKHMuc3JjKSB7DQpAQCAtMjczMSw2
ICsyNzMwLDcgQEAgb3V0Og0KICAgICBnX2ZyZWUocy5zcmNfc2VjdG9ycyk7DQogICAgIGdfZnJl
ZShzLnNyY19hbGlnbm1lbnQpOw0KIGZhaWxfZ2V0b3B0Og0KKyAgICBxZW11X29wdHNfZGVsKHNu
X29wdHMpOw0KICAgICBnX2ZyZWUob3B0aW9ucyk7DQogDQogICAgIHJldHVybiAhIXJldDsNCi0t
IA0KMi43LjQNCg0KDQotLQ0KQmVzdCByZWdhcmRzLA0KR3VveWkNCg0K


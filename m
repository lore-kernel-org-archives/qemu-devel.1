Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7C4C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B199C2189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B199C2189E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj1G0-0004kG-Qr
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 08:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44776)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <zhang.lei@jp.fujitsu.com>) id 1hiyrR-0003bO-EB
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.lei@jp.fujitsu.com>) id 1hiyrQ-0005Ab-Ke
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:21:05 -0400
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:22741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.lei@jp.fujitsu.com>)
 id 1hiyrQ-000545-6z
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 06:21:04 -0400
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [192.168.231.130]) by
 mgwkm03.jp.fujitsu.com with smtp
 id 7eee_76f4_1801cc77_d74d_44e3_87d2_38dc8eecba75;
 Thu, 04 Jul 2019 19:20:54 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 98702AC0071
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 19:20:53 +0900 (JST)
Received: from G01JPEXCHKW17.g01.fujitsu.local
 (G01JPEXCHKW17.g01.fujitsu.local [10.0.194.56])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id CDF55BD6845;
 Thu,  4 Jul 2019 19:20:17 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw17 ([10.0.194.56]) with mapi id 14.03.0439.000; Thu, 4 Jul 2019
 19:20:15 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: "'drjones@redhat.com'" <drjones@redhat.com>, "'qemu-devel@nongnu.org'"
 <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH v2 00/14] target/arm/kvm: enable SVE in
 guests
Thread-Index: AdUyUIJX95Pq/vyrTJWcUgcHWRhmbw==
Date: Thu, 4 Jul 2019 10:20:16 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A78BAAEAF@G01JPEXMBKW03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.18.70.226]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.219.69.170
X-Mailman-Approved-At: Thu, 04 Jul 2019 08:53:26 -0400
Subject: [Qemu-devel] [PATCH v2 00/14] target/arm/kvm: enable SVE in guests
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
Cc: "Mizuma, Masayoshi" <masayoshi.mizuma@fujitsu.com>, "Okamoto,
 Takayuki" <tokamoto@jp.fujitsu.com>, "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQW5kcmV3LA0KDQpUaGlzIHBhdGNoIHNlcmllcyB3b3JrcyBmaW5lIGZv
ciBteSB1c2UgY2FzZXMuDQpQbGVhc2UgZmVlbCBmcmVlIHRvIGFkZC4NCg0K
ICAgVGVzdGVkLWJ5OiBaaGFuZywgTGVpIDx6aGFuZy5sZWlAanAuZnVqaXRz
dS5jb20+DQoNCkkgc3VwcG9zZSB2MyBwYXRjaGVzIHdpbGwgYmUgcmVsZWFz
ZWQuIEknbSBsb29raW5nIGZvcndhcmQgdG8gdGhlIHYzIHBhdGNoZXMuDQoN
CkJlc3QgUmVnYXJkcywNCkxlaSBaaGFuZw0K


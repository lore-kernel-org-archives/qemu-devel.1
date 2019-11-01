Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC52BCA9ECB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 01:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB3942086D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 01:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3942086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQLrl-0004sR-VN
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 21:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.lei@jp.fujitsu.com>) id 1iQLr7-0004AN-57
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 21:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.lei@jp.fujitsu.com>) id 1iQLr5-00075a-Ga
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 21:36:00 -0400
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:23710)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.lei@jp.fujitsu.com>)
 id 1iQLr4-0006fH-Vy
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 21:35:59 -0400
Received: from kw-mxoi2.gw.nic.fujitsu.com (unknown [192.168.231.133]) by
 mgwkm03.jp.fujitsu.com with smtp
 id 5ebd_044a_2a088fc6_61c9_481e_bdb4_b059ccc9dc10;
 Fri, 01 Nov 2019 10:35:46 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by kw-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id AE08BAC0051
 for <qemu-devel@nongnu.org>; Fri,  1 Nov 2019 10:35:45 +0900 (JST)
Received: from G01JPEXCHKW17.g01.fujitsu.local
 (G01JPEXCHKW17.g01.fujitsu.local [10.0.194.56])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id 2B585BD6483;
 Fri,  1 Nov 2019 10:35:25 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw17 ([10.0.194.56]) with mapi id 14.03.0439.000; Fri, 1 Nov 2019
 10:35:25 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: "'drjones@redhat.com'" <drjones@redhat.com>, "'qemu-devel@nongnu.org'"
 <qemu-devel@nongnu.org>, "Mizuma, Masayoshi" <masayoshi.mizuma@fujitsu.com>
Subject: [PATCH v7 0/9] target/arm/kvm: enable SVE in guests
Thread-Topic: [PATCH v7 0/9] target/arm/kvm: enable SVE in guests
Thread-Index: AdWQU2Zox3NBvQn0T3C124093TAd3w==
Date: Fri, 1 Nov 2019 01:35:24 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A89711051@G01JPEXMBKW03>
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
Cc: "Okamoto, Takayuki" <tokamoto@jp.fujitsu.com>, "Zhang,
 Lei" <zhang.lei@jp.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgSm9uZXMsDQoNClRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCg0KSSBoYXZl
IHRlc3RlZCB0aGUgdjcgcGF0Y2guDQoNCkFsbCB0aGUgdGVzdCBpcyBwYXNz
ZWQuDQpQbGVhc2UgYWRkIA0KVGVzdGVkLWJ5OiBaaGFuZyBMZWkgPHpoYW5n
LmxlaUBqcC5mdWppdHN1LmNvbT4NCg0KTXkgdGVzdCBlbnZpcm9ubWVudCBp
cyBiZWxvdy4NCg0KKlFFTVUNCmJhc2UgKyB2NyBwYXRoYw0KDQpiYXNlIGlz
IA0KNTg1NjBhZDI1NCAob3JpZ2luL21hc3Rlciwgb3JpZ2luL0hFQUQsIG1h
c3RlcikgTWVyZ2UgcmVtb3RlLXRyYWNraW5nIGJyYW5jaCAncmVtb3Rlcy9k
Z2lic29uL3RhZ3MvcHBjLWZvci00LjItMjAxOTEwMjQnIGludG8gc3RhZ2lu
Zw0KDQoqbGlidmlydA0KaHR0cHM6Ly9naXRsYWIuY29tL2Fib2xvZ25hL2xp
YnZpcnQuZ2l0DQoNCgljb21taXQgZmU2OTg1YzcwOThiZjQ4ZmQ3YmFkZTgz
ZWY0MmE5OGE0NDU3Y2U4NA0KCUF1dGhvcjogQW5kcmVhIEJvbG9nbmFuaSA8
YWJvbG9nbmFAcmVkaGF0LmNvbT4NCglEYXRlOiAgIFRodSBKdWwgMjUgMTU6
Mzg6MzggMjAxOSArMDIwMA0KDQoJICAgIG5ld3M6IFVwZGF0ZSBmb3IgQVJN
IENQVSBmZWF0dXJlcw0KDQoqS2VybmVsDQpsaW51eC01LjMuNw0KDQpCZXN0
IFJlZ2FyZHMsDQpMZWkgWmhhbmcNCg0K


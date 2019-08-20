Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.9 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C4BC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B6720C01
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 10:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="b/yYcEaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B6720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i018D-0005Ls-2U
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 06:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhlb29@foxmail.com>) id 1i017V-0004eL-17
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:12:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhlb29@foxmail.com>) id 1i017T-0004Mj-Oe
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:12:04 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:42357)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhlb29@foxmail.com>) id 1i017R-0004GC-NS
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 06:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1566295898;
 bh=kLLQig42EvtUsyg93MdRfOksqz7s7VnEYgMR9IOBtHc=;
 h=From:To:Subject:Mime-Version:Date:Message-ID;
 b=b/yYcEaGbMNa4X6/5Ju4rl0/U/h1jhWoPgVeLOemKSkK620Djx2FPFUP5WTebZJVe
 sp9JiZs3mm1xKlYZ2hAF05Lk/Fav2gizqy07cxT9NfAdcWkMuAHPcGA7S23yAgB/P/
 I87bvYJgX6ag0jj4ct4116+AUJBTvI2lIUgBxpoM=
X-QQ-FEAT: PQzrsoBMnqoGMTk4z+uc2BJ768PBECowUN2uUEay250/B4M9KHtAIq9igzWcH
 OtZYPvGEAKbOSqkR5lDVUsc6AXykSN0pcyT9TWzTTUfto+ugldYmoVYFFbyE3qtmPHV5Uxl
 NAXll+KH4DjaN35sOiFyhzNhn4v5G+S0xRoaDZtkcVakFGS3os8T2CNKM857N95RtaBwos5
 p6DZZDAy9/bm4DlKobrMNepk4HPu1QOUr5FK1DAa2WcCVQiI8mNrDc4Rwt54tytcoCIYiLF
 izo5YboE4ZnART
X-QQ-SSF: 000000000000004000000000000000G
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 124.200.70.7
X-QQ-STYLE: 
X-QQ-mid: webmail190t1566295897t8209666
From: "=?gb18030?B?waI=?=" <zhlb29@foxmail.com>
To: "=?gb18030?B?cWVtdS1kZXZlbA==?=" <qemu-devel@nongnu.org>
Mime-Version: 1.0
Date: Tue, 20 Aug 2019 18:11:36 +0800
X-Priority: 3
Message-ID: <tencent_A4D270EBF3CC4134E8EB55BB9B541724780A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Tue, 20 Aug 2019 18:11:37 +0800 (CST)
Feedback-ID: webmail:foxmail.com:bgforeign:bgforeign2
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 52.59.177.22
Content-Type: text/plain;
	charset="gb18030"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] QEMU as ISS (Instruction Set Simulator)
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SSBhbSB3b3JraW5nIG9uIGEgcHJvamVjdCB0aGF0IHJlcXVpcmVzIG1lIHRvIG1vZGlmeSB0
aGUgSVNBIG9mIHRoZSBNSVBTIHRhcmdldC4gSSBoYXZlIGJlZW4gc3RhcmluZyBhdCB0aGUg
c291cmNlIGNvZGUgZm9yIGFib3V0IGEgd2VlaywgYnV0IGZvdW5kIGl0IHJlYWxseSBkaWZm
aWN1bHQgZHVlIHRvIG1lIGJlaW5nIGEgeW91bmcgcm9va2llIGFuZCB0aGUgc3BhcnNlIGNv
bW1lbnRzLg0KU3BlY2lmaWNhbGx5LCBJIG5lZWQgdG8gZXh0ZW5kIE1JUFMsIGJ5IGFkZGlu
ZyBzb21lIG5ldyBpbnN0cnVjdGlvbnMgYW5kIG5ldyBDUFUgcmVnaXN0ZXJzIHRvIHRoZSBj
dXJyZW50IGFyY2hpdGVjdHVyZSwgYW5kIHRoYXQgc291bmRzIHJlYWxseSBlYXN5LiBJIHRo
aW5rIHRoZSBwbGFjZSBmb3IgbWUgdG8gbG9vayBhdCBzaG91bGQgYmUgYXQgdGhlIGRpcmVj
dG9yeSAke3FlbXVfcm9vdH0vdGFyZ2V0L21pcHMvLiBXaXRoIGEgTUlQUyBJbnN0cnVjdGlv
biBTZXQgTWFudWFsIFJlbGVhc2UgNiBoYW5keSwgSSBoYXZlIGRpZmZpY3VsdHkgZmluZGlu
ZyB0aGUgc291cmNlIGNvZGUgd2hlcmUgdGhlIElTQSByZXNpZGVzLiBJcyBpdCBpbiBvcF9o
ZWxwZXIuYz8gT3IgdHJhbnNsYXRlLmM/IEFueSBndWlkYW5jZSB3b3VsZCBiZSByZWFsbHkg
YXBwcmVjaWF0ZWQuIFRoYW5rIHlvdSB2ZXJ5IG11Y2ggaW4gYWR2YW5jZS4NCg0KDQpDaGVl
cnMsDQpMLg==

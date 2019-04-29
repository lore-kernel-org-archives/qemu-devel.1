Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C5EC43218
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 00:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2CD620656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 00:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="e2QDdsON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CD620656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50193 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKuWT-0000za-3q
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 20:51:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hKuUu-0007yY-Sm
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:50:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hKuUt-0003Q6-DS
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:50:20 -0400
Received: from smtpbg444.qq.com ([183.3.255.70]:53817 helo=qq.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hKuUs-0003OX-PW
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 20:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1556499011;
	bh=dqvlNrFHF0QzJ9M/Wv6KFcc8KkDVEUdemKH5UxHNPkg=;
	h=From:To:Subject:Date:Message-Id;
	b=e2QDdsONAnJccJZ45g12j7Pi/sD6r7o+aHkGNPC5ZI26h9iH1CEgU6kMLAG0oW9wi
	bwqbPLnDyf3kCYB/WhUrAsSj43F1qrgcM29Qka7knSgaptUXBJAFZ9JjiSY+HjxqUz
	wWr4ER2QApM8cMnCxXcM21XPESGuPkeHA/3GTZIE=
X-QQ-mid: esmtp7t1556498004tpl5bojps
Received: from localhost (unknown [183.63.119.27])
	by esmtp4.qq.com (ESMTP) with 
	id ; Mon, 29 Apr 2019 08:33:23 +0800 (CST)
X-QQ-SSF: B100000000000030F7F00F00000000O
X-QQ-FEAT: 6ugjij1k5i9hVwgfwgz5ACZ6LpJ71RRgvOgafeJq5MsTn2uqeQQ4ZBl5/UASU
	yF4W4AHt803cFe9BVc7RTelwTGtIVlkVsotR+mAHGUgWARUKIcWk4MuqWIs1/qUv19R6TZS
	+APvePOfPG+n49DFmgqqPfupzk2swAWbPHkgyhUzX70wnGnZdMyiQwAbOPYJC8GXXyTyCrK
	vJPzrUUrDIkUJb2MNbC/pjym+iUB1Wo2go7XrZlMouVkC0V9UFwc6RwwBo2ZBcxWt4Z7e95
	lfU3usJmMk1vjnb5ZLJjqvTRfITZhh0DgU2w==
X-QQ-GoodBg: 0
From: driver1998 <driver1998@foxmail.com>
To: qemu-devel@nongnu.org
Date: Mon, 29 Apr 2019 00:33:22 +0000
Message-Id: <20190429003322.22908-1-driver1998@foxmail.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:foxmail.com:bgweb:bgweb117
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 183.3.255.70
Subject: [Qemu-devel] [PATCH 3/4] util/cacheinfo.c: Use uintptr_t instead of
 unsigned long in AArch64 arch_cache_info()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: driver1998 <driver1998@foxmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190429003322.6tt99nhSssqvQ-TMSePE4l_6_fsRWY3dkhPaeqv28fA@z>

Windows ARM64 uses LLP64 model, which breaks current assumptions.

Signed-off-by: driver1998 <driver1998@foxmail.com>
---
 util/cacheinfo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/cacheinfo.c b/util/cacheinfo.c
index 3cd080b83d..a815cb0722 100644
--- a/util/cacheinfo.c
+++ b/util/cacheinfo.c
@@ -107,7 +107,7 @@ static void sys_cache_info(int *isize, int *dsize)
 static void arch_cache_info(int *isize, int *dsize)
 {
     if (*isize == 0 || *dsize == 0) {
-        unsigned long ctr;
+        uintptr_t ctr;
 
         /* The real cache geometry is in CCSIDR_EL1/CLIDR_EL1/CSSELR_EL1,
            but (at least under Linux) these are marked protected by the
@@ -120,6 +120,8 @@ static void arch_cache_info(int *isize, int *dsize)
         if (*dsize == 0) {
             *dsize = 4 << ((ctr >> 16) & 0xf);
         }
+
+        printf("%d %d\n", *isize, *dsize);
     }
 }
 
-- 
2.17.1



Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B7DC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870862173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870862173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnlLk-0006jY-Q0
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hnlL8-0004Hp-Qw
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hnlL4-0000mB-Jf
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:55:30 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:32921)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hnlL4-0000hI-8o
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:55:26 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlfCk-1iDi8q3HQg-00ikdO; Wed, 17 Jul 2019 16:54:38 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 16:54:16 +0200
Message-Id: <20190717145418.23883-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717145418.23883-1-laurent@vivier.eu>
References: <20190717145418.23883-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/uU3Iw6FRkYlIr/YSJIBPhpggc9tLECLeDfacBj1X6GtMOXvI2J
 7uc6i/JqcxopF3YG9yby5J5R47On3cLqHSCEN8Xo5Puln7/apPCPdTJPe3nur2NZSqMMh0l
 OppuH2pS08gJoWH96+OaSHEebGR3w5Zwtefbo/ROw/Z9wuO0VM+MY5SJU7PYGmUAZILQ3vx
 xhZbqgpoCxaMYi76167Kg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tjIhIcauqoE=:xvlqiaOOeahjicl8gbn8eO
 i0bJrjnb3crBQiE46CtkgEuG1RC28lkLXsGw/ikntGMn8UX6qxiNsUCwW96CsNt/n6EL/mYHO
 0VNpw5Ape5J4QI5bBhse1pcMn+7LL4n2nmWqEDHIFtQiz6U6Wa7VX4LTc/RAxNYcQBnd72AbW
 SEvwLpV7+1fGY4LERJ0e94GSdHyPRxbVAJAi/Rj9Hu0hvycET+FidbsoFrbAvTbacq0HB/W7u
 BbCzgRJeNDVdgKhAkorNdWRdwOcvd0Z500xlDyPBkJtoG/HZy0l4VSCG3mbSiqfqqYBJfe44Z
 UUuzDZX4WtTdRb4PYlkaIeOassdH7oCeF9+nvexD+y9bpnrnGNFdQa5yiF8hu8wivYEC//5Pk
 1hzmF8oCdwIfRIE6dcbN0B9VqnEn67auDqmDZMYFDuifK3KGpabs8UTEiREOqBFq9D/PEyLjt
 mdHuCNka56tLgYJNCv++mNl/O1pYusVT01IMY2bSAGHMjSaG3RAOloIZWhOkp8qujSuKu1G/7
 wC/eGVQlrxOgAz/2ZYM7xsHhWSLaUamU5w2R29IJkDJo1tfZnv/2BTHlsv5n64mCVFFfyZuKf
 2pzf44XxNovU0EMV2CFpzLI5J5hQaKGbb1JUeLKnFinMf2ozoKdrS103lrHKbKPLvIrjbS883
 u9yNWkOXrXqPIGI5fdfZswb9nUvAGYIF3XQyQAJkoCLYbANlqqdWOVpg+NfVmnDZoHwuHYtLh
 60Orvy7cmUsHGxVIkMlyqy4a7+GK6FwgdFbr7g==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL 1/3] linux-user: Fix structure target_ucontext
 for MIPS
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
Cc: Dragan Mladjenovic <dmladjenovic@wavecomp.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Structure ucontext for MIPS is defined in the following way in
Linux kernel:

(arch/mips/include/uapi/asm/ucontext.h, lines 54-64)

struct ucontext {
    /* Historic fields matching asm-generic */
    unsigned long       uc_flags;
    struct ucontext     *uc_link;
    stack_t             uc_stack;
    struct sigcontext   uc_mcontext;
    sigset_t            uc_sigmask;

    /* Extended context structures may follow ucontext */
    unsigned long long	uc_extcontext[0];
};

Fix the structure target_ucontext for MIPS to reflect the definition
above, except the correction for field uc_extcontext, which will
follow at some later time.

Fixes: 94c5495d

Reported-by: Dragan Mladjenovic <dmladjenovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1562931470-3700-2-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/signal.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/linux-user/mips/signal.c b/linux-user/mips/signal.c
index 6aa303ec9c16..455a8a229a83 100644
--- a/linux-user/mips/signal.c
+++ b/linux-user/mips/signal.c
@@ -71,10 +71,9 @@ struct sigframe {
 };
 
 struct target_ucontext {
-    target_ulong tuc_flags;
-    target_ulong tuc_link;
+    abi_ulong tuc_flags;
+    abi_ulong tuc_link;
     target_stack_t tuc_stack;
-    target_ulong pad0;
     struct target_sigcontext tuc_mcontext;
     target_sigset_t tuc_sigmask;
 };
-- 
2.21.0



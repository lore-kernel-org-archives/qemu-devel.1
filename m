Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D97C76195
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:07:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F19A2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F19A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoNvG-000744-37
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 04:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44652)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hoNut-0005kA-01
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hoNuq-0004fE-Q9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:06:58 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59065)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hoNuq-0004eY-HR
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:06:56 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MIyiY-1i8eqQ3Xek-00KMeY; Fri, 19 Jul 2019 10:06:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 10:06:08 +0200
Message-Id: <20190719080610.1607-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719080610.1607-1-laurent@vivier.eu>
References: <20190719080610.1607-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dgqKW6Sk5FAX+oktD3tKuBxMmTxCzDZxjHuVtFqncFeX+B4aiq+
 IojO3Rs9hWGDAY/m39nIHgw1hD+YFnZM8gfA+a7qbC9m2Aoj1pgwZ9Ex14RLa0Sdo6C64rw
 ZSgP6IQ9p+6fQ3OhprukR3o/lQaByQ4F1nByIIlTSSQr30dfQWd8+B4H/3qyD0beZfnm1x7
 vxtQYCPqbZMZW+Hmo8YGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jVbdCNNlpwY=:y+Cb/4BYXugQsbWqNfiCM/
 mglNFxPLmJjqo9t6yWn7FLd+jaN7shR02kho/YCRXQqA27AeWCqP6V5QXNBWx4/rFPTnEVa1X
 YCiRKH+Y7GD+bN8Z6MtlQ7uUkxPSSoZOj7szgJvmUpa+QHTGA47IdWFXuMlg2H2x7fHGE5AiR
 +/1KBSnXRGaILk59IFdD3fEDgYFNzYPwS9O6PD5dgDXPJgWQg9KIa1yj/pq5a8vFzE8p8Iwfc
 Ntqu8OO9uijtsfEc0tVmpqPGUYo+5PO+sFVGo1gBJWLD78uwcdEjp9ot/YAAKYh+0UQhGsFcB
 qnx349puyVZ06SHXsNJvoL7583JVZYPDtUkOawRDVe87/13AXJN2jIJgBHRyj/6spy2atld62
 3pe/rc5uCA38cQNTjBj6Po77AKYUIuWUrL1Bgt+DGmglPA7cg3ZZriWOTO4Ja6Fvv9wvfsnA7
 AWC655wX+4rcMuqSfmhykFdwCLzhzT0hIJASwdaOzyvcaeB8z00plGuPKctlLUlCAxxxCe8BW
 MVE7y82yLPimvycdMZM2W95DqJSKhZX0260/g1SCVzqM8FFSDkWpXnC1KXPlC56NAduQ/xlvq
 eUG6Osmw5ZzIowYIiJOkWNfBg0w/hMhFu/VFqjRjkHwRy7Td5EYdXBOVQm4Z+a+UvT/5RJyjT
 ljigyDAedheAnlR3RI23VbXaGpL8XDih0c7VgWDJ83pjE5L5hNU6bVYSo68ipSTFE9cMROdBr
 oVbfuZXPQkWYL/zBfv9gHQsLLHWaw3KiRpKr2w==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL v2 1/3] linux-user: Fix structure
 target_ucontext for MIPS
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



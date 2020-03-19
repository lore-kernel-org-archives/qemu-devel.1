Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C425C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109BC20753
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 09:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109BC20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErSf-0006gu-0O
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 05:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jErRn-0005Cr-Qu
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jErRm-0003zC-QF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41479)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jErRm-0003uH-Hi
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:26:38 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MzkK9-1jRyUF2MV7-00vghs; Thu, 19 Mar 2020 10:26:34 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v3 04/16] linux-user: Add x86_64 vsyscall page to
 /proc/self/maps
Date: Thu, 19 Mar 2020 10:26:15 +0100
Message-Id: <20200319092627.51487-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200319092627.51487-1-laurent@vivier.eu>
References: <20200319092627.51487-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Sgje0iFrVPMb2dQMJ0RAnWbHBX/NKwa72+1hEXPBC8ZRpsF/lQz
 JJLjCn6KXzrrmrh5Cko64vSzRlCqZOh0n0NAlkViYBO9kErl5adXYgAoyhBHFZbpi2ddG5r
 UFQNEjAWhrcFmg/V1Hw1jG6CAmAYO6ErR+h6N6HeE5ZnkbCeEAV7au4ZUo8ssbmTrSQe3V4
 mgpK+5fhFMFCbr1bjd4Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/yUYey2NAI0=:qu1ieyKu6NOSvSU4dgJKDo
 KTQjX48b3F19iNScHWMHer67nlD6XUTXzlLoow6Gx1F/3DvYr8pMcZ3cwQK8aiNmM0JIfXm1w
 8CXA8/gvKPpDPc20Ti+voNvo0ip/02WFUKKwzhDshyk5nufBVYFF+RH4aQZMv/6mtJy5W2lvS
 hKCWC2w375FZW8HG2DbtzrYX5FUpkm8ieeu/Yt1rjkks1KFl+lMOCSfg5lyzbz/BG/rvtlaPQ
 82nVaj7gAHfzCrlm6yDY/fEqxW3Mv0NSiNP24isrPV0nOTTZHuZLQJTdUzQRzIUltijTcT2Nd
 Wy/02PzXUWy9g1ChSqOB/iXJ7AFZnCIWdKjTL/M2gP40B/71lygWlS8sA5EUXmmZ00vJtDWnD
 28Ppq/3zNbxmNxiGIfTLUx2MdBqlDim5vMP5G3OEfqOp6hAcWrRzCXpVtj5BTUiKfKAA2vdx/
 RuQMMOoAOvPHzE8OsFMh8Q1CUYtlNEZstj1lpq9Xc4rowWViCHPloqRd2/C+ciAhtMd0DLWJx
 iZOBN6Syovhh8Ge1ZStv3FmtKU3YjLQtgWy9dUCNAo6CVVfLER6eguCc3KOjjcvZyEztcfc2V
 LwGUXm98U7aLBeXwevXcEOmGV6vCkfTxydOgpgMzKge8Ly1Ym5gmOzayPZnNGX5c8C7SmtMGQ
 pQ24SWP0q7Qpi6OecPiieJfWiSg7DIHKE6rQfHCVtXYcrE/Xjapty5j6QL0NmKk3ewj4I3VI9
 g2hUxg6omzCrodLxCGwvjhuJk54wjtJF8hjS+mUWA5+PsVe2L5alBfU47DrseFJtZ9s53akN1
 UB7KEjEEQFxNrY8Y9r+eYk9TucU1KKNDSC1Io71fcKiXwOB/rMBwOv4W3iZi8dsV2K/Evbn
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The page isn't (necessarily) present in the host /proc/self/maps,
and even if it might be it isn't present in page_flags, and even
if it was it might not have the same set of page permissions.

The easiest thing to do, particularly when it comes to the
"[vsyscall]" note at the end of line, is to special case it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200213032223.14643-5-richard.henderson@linaro.org>
[lv: remove trailing whitespace]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 8d27d1080752..5479d67a10be 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7079,6 +7079,16 @@ static int open_self_maps(void *cpu_env, int fd)
         }
     }
 
+#ifdef TARGET_VSYSCALL_PAGE
+    /*
+     * We only support execution from the vsyscall page.
+     * This is as if CONFIG_LEGACY_VSYSCALL_XONLY=y from v5.3.
+     */
+    dprintf(fd, TARGET_FMT_lx "-" TARGET_FMT_lx
+            " --xp 00000000 00:00 0 [vsyscall]\n",
+            TARGET_VSYSCALL_PAGE, TARGET_VSYSCALL_PAGE + TARGET_PAGE_SIZE);
+#endif
+
     free(line);
     fclose(fp);
 
-- 
2.25.1



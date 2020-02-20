Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4521C11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8802D20801
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 09:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8802D20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4i4D-0000Ve-Oj
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 04:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51883)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4i1d-0004HU-Ll
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4i1c-0008Cc-55
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:41 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:40855)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j4i1b-0008CE-SA
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 04:21:40 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MwgOK-1jO26u3hYA-00y7XU; Thu, 20 Feb 2020 10:21:03 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/13] linux-user: remove gemu_log from the linux-user tree
Date: Thu, 20 Feb 2020 10:20:48 +0100
Message-Id: <20200220092053.1510215-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200220092053.1510215-1-laurent@vivier.eu>
References: <20200220092053.1510215-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jaXcrerx7Sf1J2/KAshvpJej0DPSRikz8QYveZdkx0RE7tkrj+h
 yP9BDC4x6hRStjBmBASgYcXE31RoL0wLG3uxKypWzO9br/1H/V5L/WcrisCFv30wc6OZI7I
 pk8FVjVBvK51sjH5utFpL2mniWZCjGJaXAe5+lQnrEzkAZ0t8pbmMr+i46kBkZIm+byZHr2
 yf+s9VNKu73PPPSaslqXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qS/B/DBv5nE=:CzV72reGOi9BJmymo6aidW
 e8SRuVLTuZQaeZ9AHviErZ+7AZgicJ5nCWTisO4CopukYsDpJ8nr8qx6mlVAsAy8zJV6xaend
 eUzUqU8FjDFKk/unxnoHc508J/yl6bTXRBEpdAfYfk+dBS+Q1tU0iicceAApdGQTIqXPxx+Gu
 Q7Hl60HRkgY5QjmBibBDFys/N90A2mbvfwHJMm7PjT7aIrI5IxNZGYC8vo0XJoUXBRCFivZg9
 r83BCnMUVFlY5EqPz6zAhdI7Wichryn5IjSXoGMoa5CeIESxuVRr8rYL7+vrf5uvtOaCWDyph
 TTRx2LXWm/Ayxh1UNrIz3r8BtsSduiGszf0lCB0fn4U3RzVFaLoenqmjrONXKpDliw0Mttc3b
 RduTtECXzp/qyIrtn+KG/2LzNdZZC+NcRAAMfzYGOInVfkBq5e8D0mtM2yQoAxjVPyT9uP5d+
 ImqQIbGqmpTyckzd8R4JmlhGvYzG6n2XMKLXFGIGcOg9e11nHpKaPspLxzx/AMKDVEJdbpVrm
 GhbZdPvAvp0LIoi5cyiIyABZZu6yeIKborVS4Xc4ubbnyaLDbQEcncyZeBHHegz/fJXFz9nMa
 NPycAF9DmqtSKFifMFBV3KCGPVMdPM0QwUMHaAu7YNcgkROS7XR+MNb7DSZFiuvfgTIHDKjzE
 GG1XNwt4DhHkCmvRfccip5NF7imeVYDcfGhXOtoLtwDASa8vOjcRZ/H2KiyhS9SlpjmUawtSk
 TUZQhuCwEuwmIlFlDIdv4y+VVbpexPBCC/dwQls+T8nzg+uKzmJ0ZgPr/IcFs9x5WIFIE5LmU
 I5VdUc6WnfFfgWZ/q769YKyD30KajeeWPD4cGbrLzT18t72BBKp4IxTOs2BQtZtYYlNWCzM
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Josh Kunz <jkz@google.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Josh Kunz <jkz@google.com>

Now that all uses have been migrated to `qemu_log' it is no longer
needed.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Josh Kunz <jkz@google.com>
Message-Id: <20200204025416.111409-4-jkz@google.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 9 ---------
 linux-user/qemu.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 8f1d07cdd6a7..22578b163364 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -112,15 +112,6 @@ const char *qemu_uname_release;
    by remapping the process stack directly at the right place */
 unsigned long guest_stack_size = 8 * 1024 * 1024UL;
 
-void gemu_log(const char *fmt, ...)
-{
-    va_list ap;
-
-    va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
-    va_end(ap);
-}
-
 #if defined(TARGET_I386)
 int cpu_get_pic_interrupt(CPUX86State *env)
 {
diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 2421dc7afd7a..792c74290f8d 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -211,7 +211,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                     abi_long arg2, abi_long arg3, abi_long arg4,
                     abi_long arg5, abi_long arg6, abi_long arg7,
                     abi_long arg8);
-void gemu_log(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 extern __thread CPUState *thread_cpu;
 void cpu_loop(CPUArchState *env);
 const char *target_strerror(int err);
-- 
2.24.1



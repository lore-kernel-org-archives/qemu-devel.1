Received: from eggs.gnu.org ([2001:4830:134:3::10]:42165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmjHH-0008M6-MK
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmjHF-0002qb-Qc
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:26:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47448 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fmjHF-0002nn-DS
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:26:41 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  6 Aug 2018 19:00:42 +0200
Message-Id: <1533574847-19294-76-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 75/80] linux-user: Amend support for
 sigaction() syscall for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Amend sigaction syscall support for nanoMIPS. This must be done
since nanoMIPS' signal handling is different than MIPS' signal
handling.

Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 3d57966..bced9b8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8825,7 +8825,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
                 old_act->sa_flags = oact.sa_flags;
                 unlock_user_struct(old_act, arg3, 1);
             }
-#elif defined(TARGET_MIPS)
+#elif defined(TARGET_MIPS) && !defined(TARGET_NANOMIPS)
 	    struct target_sigaction act, oact, *pact, *old_act;
 
 	    if (arg2) {
-- 
2.7.4

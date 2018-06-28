Received: from eggs.gnu.org ([2001:4830:134:3::10]:38363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB2-0007hV-MT
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB1-00013W-NT
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:00 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:44574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdB1-00012l-Gg
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:59 -0400
Received: by mail-wr0-x22d.google.com with SMTP id p12-v6so6676611wrn.11
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:59 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:55 +0200
Message-Id: <1530216310-52873-46-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 45/60] target-i386: Mark cpu_vmexit noreturn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

It calls cpu_loop_exit in system emulation mode (and should never be
called in user emulation mode).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-Id: <6f4d44ffde55d074cbceb48309c1678600abad2f.1522769774.git.jan.kiszka@web.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h        | 4 ++--
 target/i386/svm_helper.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 89c82be..16c59b7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1840,8 +1840,8 @@ void helper_lock_init(void);
 /* svm_helper.c */
 void cpu_svm_check_intercept_param(CPUX86State *env1, uint32_t type,
                                    uint64_t param, uintptr_t retaddr);
-void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
-                uintptr_t retaddr);
+void QEMU_NORETURN cpu_vmexit(CPUX86State *nenv, uint32_t exit_code,
+                              uint64_t exit_info_1, uintptr_t retaddr);
 void do_vmexit(CPUX86State *env, uint32_t exit_code, uint64_t exit_info_1);
 
 /* seg_helper.c */
diff --git a/target/i386/svm_helper.c b/target/i386/svm_helper.c
index 3504923..f245aec 100644
--- a/target/i386/svm_helper.c
+++ b/target/i386/svm_helper.c
@@ -62,6 +62,7 @@ void helper_invlpga(CPUX86State *env, int aflag)
 void cpu_vmexit(CPUX86State *nenv, uint32_t exit_code, uint64_t exit_info_1,
                 uintptr_t retaddr)
 {
+    assert(0);
 }
 
 void helper_svm_check_intercept_param(CPUX86State *env, uint32_t type,
-- 
1.8.3.1

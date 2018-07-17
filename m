Received: from eggs.gnu.org ([2001:4830:134:3::10]:48439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZE-000575-OI
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ffRZ9-0007BO-29
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54068 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ffRZ8-0007B7-TM
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:07:03 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Jul 2018 17:06:44 +0200
Message-Id: <1531840015-28804-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
References: <1531840015-28804-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/13] accel: Fix typo and grammar in comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>

From: Stefan Weil <sw@weilnetz.de>

The typo was found by codespell.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Message-Id: <20180712194454.26765-1-sw@weilnetz.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 49d77fa..1571987 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1795,7 +1795,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->jmp_dest[0] = (uintptr_t)NULL;
     tb->jmp_dest[1] = (uintptr_t)NULL;
 
-    /* init original jump addresses wich has been set during tcg_gen_code() */
+    /* init original jump addresses which have been set during tcg_gen_code() */
     if (tb->jmp_reset_offset[0] != TB_JMP_RESET_OFFSET_INVALID) {
         tb_reset_jump(tb, 0);
     }
-- 
1.8.3.1

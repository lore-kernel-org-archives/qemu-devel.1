Received: from eggs.gnu.org ([2001:4830:134:3::10]:44959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ea3GQ-0002bN-AN
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:37:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1ea3GP-0000Y6-Jq
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:37:10 -0500
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:46728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1ea3GP-0000V7-8K
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:37:09 -0500
Received: by mail-lf0-x241.google.com with SMTP id a12so6730289lfe.13
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 09:37:09 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 12 Jan 2018 09:36:50 -0800
Message-Id: <1515778610-18894-1-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <27e44c5d-b04c-df08-bd7f-fc4089d91dcd@redhat.com>
References: <27e44c5d-b04c-df08-bd7f-fc4089d91dcd@redhat.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: don't typedef DisasContext twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

This fixes build on Centos 6.

Fixes: 168c12b02470 ("target/xtensa: extract core opcode translators").
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4bdfcd24d09b..bec9efc4d86a 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -50,7 +50,7 @@
 /* is_jmp field values */
 #define DISAS_UPDATE  DISAS_TARGET_0 /* cpu state was modified dynamically */
 
-typedef struct DisasContext {
+struct DisasContext {
     const XtensaConfig *config;
     TranslationBlock *tb;
     uint32_t pc;
@@ -78,7 +78,7 @@ typedef struct DisasContext {
     uint32_t *raw_arg;
     xtensa_insnbuf insnbuf;
     xtensa_insnbuf slotbuf;
-} DisasContext;
+};
 
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_R[16];
-- 
2.1.4

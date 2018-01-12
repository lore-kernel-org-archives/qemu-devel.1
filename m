Received: from eggs.gnu.org ([2001:4830:134:3::10]:53441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZz4q-0005PH-KF
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:08:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZz4m-00056X-AW
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:08:56 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZz4m-00054K-3j
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:08:52 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 13:08:48 +0000
Message-Id: <1515762528-22818-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/xtensa: Remove duplicate typedef of
 DisasContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>

Some older versions of gcc complain if a typedef is defined twice:

target/xtensa/translate.c:81: error: redefinition of typedef 'DisasContext'
target/xtensa/cpu.h:339: note: previous declaration of 'DisasContext' was here

Remove the now-redundant typedef from the definition of the struct in
translate.c.

Reported-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/xtensa/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 4bdfcd2..bec9efc 100644
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
2.7.4

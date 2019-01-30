Received: from eggs.gnu.org ([209.51.188.92]:44384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mathew1800@gmail.com>) id 1gowNu-0004KO-G1
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mathew1800@gmail.com>) id 1gowNr-0008MW-DI
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:22:57 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:35437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mathew1800@gmail.com>)
	id 1gowNq-0008LP-5g
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:22:55 -0500
Received: by mail-io1-xd43.google.com with SMTP id f4so716800ion.2
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 12:22:52 -0800 (PST)
From: Mathew Maidment <mathew1800@gmail.com>
Date: Wed, 30 Jan 2019 15:22:43 -0500
Message-Id: <20190130202243.79545-2-mathew1800@gmail.com>
In-Reply-To: <20190130202243.79545-1-mathew1800@gmail.com>
References: <20190130202243.79545-1-mathew1800@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] target/arm: Amend erroneous BRAA/BLRAA
 opcode check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Amends a small logical mistake that would always result in the branch to
do_unallocated being taken.

Signed-off-by: Mathew Maidment <mathew1800@gmail.com>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4d28a27c3b..350deae32b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2036,7 +2036,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         if (!dc_isar_feature(aa64_pauth, s)) {
             goto do_unallocated;
         }
-        if (op3 != 2 || op3 != 3) {
+        if (op3 != 2 && op3 != 3) {
             goto do_unallocated;
         }
         if (s->pauth_active) {
-- 
2.17.2 (Apple Git-113)

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7r-0003E3-AJ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY7q-0004jr-Ew
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:51 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51982)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gDY7q-0002Jh-4l
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:59:50 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gDY67-0006lQ-N4
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 17:58:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:57:16 +0100
Message-Id: <20181019165735.22511-27-peter.maydell@linaro.org>
In-Reply-To: <20181019165735.22511-1-peter.maydell@linaro.org>
References: <20181019165735.22511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 26/45] target/arm: Mark some arrays const
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20181011205206.3552-6-richard.henderson@linaro.org
[PMM: drop change to now-deleted cpu_mode_names array]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7d7a48e5b93..869dadbe8db 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -72,7 +72,7 @@ static TCGv_i64 cpu_F0d, cpu_F1d;
 
 #include "exec/gen-icount.h"
 
-static const char *regnames[] =
+static const char * const regnames[] =
     { "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
       "r8", "r9", "r10", "r11", "r12", "r13", "r14", "pc" };
 
@@ -4907,7 +4907,7 @@ static struct {
     int nregs;
     int interleave;
     int spacing;
-} neon_ls_element_type[11] = {
+} const neon_ls_element_type[11] = {
     {4, 4, 1},
     {4, 4, 2},
     {4, 1, 1},
-- 
2.19.1

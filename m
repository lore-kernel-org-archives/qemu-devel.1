Received: from eggs.gnu.org ([2001:4830:134:3::10]:34287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4wPX-0000St-EY
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e4wPU-0003p0-D0
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 18:01:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 18 Oct 2017 18:01:42 -0400
Message-Id: <1508364103-16131-4-git-send-email-cota@braap.org>
In-Reply-To: <1508364103-16131-1-git-send-email-cota@braap.org>
References: <1508364103-16131-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/4] translate-all: fix 'consisits' typo in
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c5ce99d..70942be 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -255,7 +255,7 @@ static target_long decode_sleb128(uint8_t **pp)
 /* Encode the data collected about the instructions while compiling TB.
    Place the data at BLOCK, and return the number of bytes consumed.
 
-   The logical table consisits of TARGET_INSN_START_WORDS target_ulong's,
+   The logical table consists of TARGET_INSN_START_WORDS target_ulong's,
    which come from the target's insn_start data, followed by a uintptr_t
    which comes from the host pc of the end of the code implementing the insn.
 
-- 
2.7.4

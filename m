Received: from eggs.gnu.org ([2001:4830:134:3::10]:44304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgjz-0004mW-Bv
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eQgjw-0006Dj-5D
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:44:59 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 18 Dec 2017 00:27:09 +0300
Message-Id: <42a84e4acda1d86645a1a9362e4495a4d5524326.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
References: <cover.1513545944.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 04/61] translate-all: fix 'consisits' typo in
 comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 accel/tcg/translate-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index e7f0329a52..02dfa361bb 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -257,7 +257,7 @@ static target_long decode_sleb128(uint8_t **pp)
 /* Encode the data collected about the instructions while compiling TB.
    Place the data at BLOCK, and return the number of bytes consumed.
 
-   The logical table consisits of TARGET_INSN_START_WORDS target_ulong's,
+   The logical table consists of TARGET_INSN_START_WORDS target_ulong's,
    which come from the target's insn_start data, followed by a uintptr_t
    which comes from the host pc of the end of the code implementing the insn.
 
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxem-00021H-JU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cVxei-0002cb-Ix
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:44:52 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 24 Jan 2017 12:39:21 +0300
Message-Id: <7d628e2c05e0fd2da04f618ba41068a7c11b2a7d.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
References: <cover.1485250702.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 17/31] hw/i386/kvmvapic: Remove dead code in
 patch_hypercalls()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Peter Maydell <peter.maydell@linaro.org>

The patch_hypercalls() function sets up a 'patches'
variable and checks it at the end of the function, but
never modifies it in the middle. Remove this dead code,
which seems to have been present since the function was
added in commit e5ad936b0fd7 in 2012.

(Spotted by Coverity: CID 1005581.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/i386/kvmvapic.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 2f767b6..702e281 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -535,7 +535,6 @@ static int patch_hypercalls(VAPICROMState *s)
     uint8_t alternates[2];
     const uint8_t *pattern;
     const uint8_t *patch;
-    int patches = 0;
     off_t pos;
     uint8_t *rom;
 
@@ -566,11 +565,6 @@ static int patch_hypercalls(VAPICROMState *s)
     }
 
     g_free(rom);
-
-    if (patches != 0 && patches != 2) {
-        return -1;
-    }
-
     return 0;
 }
 
-- 
2.1.4

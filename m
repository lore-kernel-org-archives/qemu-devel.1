Received: from eggs.gnu.org ([2001:4830:134:3::10]:42206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmjHI-0008NG-Mz
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmjHG-0002sA-Iu
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:26:44 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47471 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fmjHG-0002pM-5O
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:26:42 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  6 Aug 2018 19:00:46 +0200
Message-Id: <1533574847-19294-80-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 79/80] qemu-doc: Amend MIPS-related items
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

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Amend MIPS-related items in qemu-doc.texi

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 qemu-doc.texi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index abfd2db..8ea6bfa 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2693,8 +2693,17 @@ The binary format is detected automatically.
 @command{qemu-microblaze} TODO.
 
 @cindex user mode (MIPS)
-@command{qemu-mips} TODO.
-@command{qemu-mipsel} TODO.
+@command{qemu-mips} executes 32-bit big endian MIPS binaries (MIPS O32 ABI).
+
+@command{qemu-mipsel} executes 32-bit little endian MIPS binaries (MIPS O32 ABI).
+
+@command{qemu-mips64} executes 64-bit big endian MIPS binaries (MIPS O64 ABI).
+
+@command{qemu-mips64el} executes 64-bit little endian MIPS binaries (MIPS O64 ABI).
+
+@command{qemu-mipsn32} executes 32-bit big endian MIPS binaries (MIPS N32 ABI).
+
+@command{qemu-mipsn32el} executes 32-bit little endian MIPS binaries (MIPS N32 ABI).
 
 @cindex user mode (NiosII)
 @command{qemu-nios2} TODO.
-- 
2.7.4

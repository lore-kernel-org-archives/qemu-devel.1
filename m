Received: from eggs.gnu.org ([2001:4830:134:3::10]:60571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLss-00024Y-Jn
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXLsr-0001H7-UA
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:21:26 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 03:09:55 -0300
Message-Id: <20170718061005.29518-20-f4bug@amsat.org>
In-Reply-To: <20170718061005.29518-1-f4bug@amsat.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 19/29] disas: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Applied using the Coccinelle semantic patch scripts/coccinelle/use_osdep.cocci

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---

There is no entry for this file in MAINTAINERS, should it go under TCG/Overall?

 disas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas.c b/disas.c
index d335c55bbf..8b59448286 100644
--- a/disas.c
+++ b/disas.c
@@ -151,7 +151,7 @@ static int print_insn_objdump(bfd_vma pc, disassemble_info *info,
     info->read_memory_func(pc, buf, n, info);
 
     for (i = 0; i < n; ++i) {
-        if (i % 32 == 0) {
+        if (QEMU_IS_ALIGNED(i, 32)) {
             info->fprintf_func(info->stream, "\n%s: ", prefix);
         }
         info->fprintf_func(info->stream, "%02x", buf[i]);
-- 
2.13.2

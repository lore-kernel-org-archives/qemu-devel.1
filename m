Received: from eggs.gnu.org ([2001:4830:134:3::10]:49016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6bgZ-0004A6-0k
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1f6bgV-0005mQ-W8
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:43 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:59593)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1f6bgV-0005lg-I0
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 08:50:39 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 12 Apr 2018 14:50:34 +0200
Message-Id: <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
In-Reply-To: <20180412124834.GA2025@ruderich.org>
References: <20180412124834.GA2025@ruderich.org>
Subject: [Qemu-devel] [PATCH v2 1/5] cpus: correct coding style in
 qmp_memsave/qmp_pmemsave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 cpus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 38eba8bff3..c78f430532 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2263,8 +2263,9 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
 
     while (size != 0) {
         l = sizeof(buf);
-        if (l > size)
+        if (l > size) {
             l = size;
+        }
         if (cpu_memory_rw_debug(cpu, addr, buf, l, 0) != 0) {
             error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId64
                              " specified", orig_addr, orig_size);
@@ -2297,8 +2298,9 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
 
     while (size != 0) {
         l = sizeof(buf);
-        if (l > size)
+        if (l > size) {
             l = size;
+        }
         cpu_physical_memory_read(addr, buf, l);
         if (fwrite(buf, 1, l, f) != l) {
             error_setg(errp, QERR_IO_ERROR);
-- 
2.15.0

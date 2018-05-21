Received: from eggs.gnu.org ([2001:4830:134:3::10]:34554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fKmrj-0001rI-0F
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fKmrf-0005K7-Ti
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:51 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:55995)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fKmrf-0005J7-NH
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:47 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Mon, 21 May 2018 17:36:40 +0200
Message-Id: <1155d843cc79afa957f4365acccc00fc9a82e05a.1526916378.git.simon@ruderich.org>
In-Reply-To: <cover.1526916378.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1526916378.git.simon@ruderich.org>
In-Reply-To: <cover.1526916378.git.simon@ruderich.org>
References: <cover.1526916378.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v3 1/5] cpus: correct coding style in
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 cpus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index d1f16296de..4b1609fe90 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2316,8 +2316,9 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
 
     while (size != 0) {
         l = sizeof(buf);
-        if (l > size)
+        if (l > size) {
             l = size;
+        }
         if (cpu_memory_rw_debug(cpu, addr, buf, l, 0) != 0) {
             error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId64
                              " specified", orig_addr, orig_size);
@@ -2350,8 +2351,9 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
 
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

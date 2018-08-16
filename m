Received: from eggs.gnu.org ([2001:4830:134:3::10]:56455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqEAP-00056S-7x
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqEAK-0002Oa-Np
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:05 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:45177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fqEAI-0002ND-LT
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:00 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 16 Aug 2018 11:01:49 +0200
Message-Id: <4d2e5b229067980165bd2ff9cb84cffdb9949119.1534409363.git.simon@ruderich.org>
In-Reply-To: <cover.1534409363.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1534409363.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v4 1/7] cpus: correct coding style in
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
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 cpus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index b5844b7103..125adc4da4 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2318,8 +2318,9 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
 
     while (size != 0) {
         l = sizeof(buf);
-        if (l > size)
+        if (l > size) {
             l = size;
+        }
         if (cpu_memory_rw_debug(cpu, addr, buf, l, 0) != 0) {
             error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId64
                              " specified", orig_addr, orig_size);
@@ -2352,8 +2353,9 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
 
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
2.17.1

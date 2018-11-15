Received: from eggs.gnu.org ([2001:4830:134:3::10]:53575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNIIv-00071V-HK
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:07:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNIIu-0005MK-HU
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:07:33 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:35965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1gNIIq-0005H7-Jg
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:07:30 -0500
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 15 Nov 2018 15:07:12 +0100
Message-Id: <d727eb5f2ee9b5470588fa85b01940b1814b0dc9.1542290622.git.simon@ruderich.org>
In-Reply-To: <cover.1542290622.git.simon@ruderich.org>
References: <cover.1542290622.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v8 1/7] cpus: correct coding style in
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 cpus.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index a2b33ccb29..e67efbb58b 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2394,8 +2394,9 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
 
     while (size != 0) {
         l = sizeof(buf);
-        if (l > size)
+        if (l > size) {
             l = size;
+        }
         if (cpu_memory_rw_debug(cpu, addr, buf, l, 0) != 0) {
             error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId64
                              " specified", orig_addr, orig_size);
@@ -2428,8 +2429,9 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
 
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
2.19.1

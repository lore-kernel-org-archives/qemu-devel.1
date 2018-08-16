Received: from eggs.gnu.org ([2001:4830:134:3::10]:56460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqEAP-00056W-97
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fqEAK-0002OV-Nn
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:05 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:36975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fqEAI-0002Nf-NU
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:02:00 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 16 Aug 2018 11:01:51 +0200
Message-Id: <59bfffafb6935baaf4212f9b02597e984695e2c4.1534409363.git.simon@ruderich.org>
In-Reply-To: <cover.1534409363.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1534409363.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v4 3/7] cpus: use size_t in
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

It's the natural type for object sizes and matches the return value of
sizeof(buf).

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 cpus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index dd8ba36d2f..243f2c0d2e 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2294,7 +2294,7 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
                  bool has_cpu, int64_t cpu_index, Error **errp)
 {
     int fd;
-    uint32_t l;
+    size_t l;
     CPUState *cpu;
     uint8_t buf[1024];
     int64_t orig_addr = addr, orig_size = size;
@@ -2342,7 +2342,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
                   Error **errp)
 {
     int fd;
-    uint32_t l;
+    size_t l;
     uint8_t buf[1024];
 
     fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0600);
-- 
2.17.1

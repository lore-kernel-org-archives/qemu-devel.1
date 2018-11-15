Received: from eggs.gnu.org ([2001:4830:134:3::10]:35956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHHH-000793-UQ
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1gNHH6-0003bh-3l
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:45 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:60841)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1gNHH5-0003WX-SO
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:01:36 -0500
From: Simon Ruderich <simon@ruderich.org>
Date: Thu, 15 Nov 2018 14:01:10 +0100
Message-Id: <5b05282f9c2a0e8bdf3269874668be0825bceced.1542285958.git.simon@ruderich.org>
In-Reply-To: <cover.1542285958.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1542285958.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v6 2/6] cpus: use size_t in
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
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 cpus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index c0d796f441..ee54595733 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2370,7 +2370,7 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
                  bool has_cpu, int64_t cpu_index, Error **errp)
 {
     int fd;
-    uint32_t l;
+    size_t l;
     CPUState *cpu;
     uint8_t buf[1024];
     int64_t orig_addr = addr, orig_size = size;
@@ -2418,7 +2418,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
                   Error **errp)
 {
     int fd;
-    uint32_t l;
+    size_t l;
     uint8_t buf[1024];
 
     fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0600);
-- 
2.19.1

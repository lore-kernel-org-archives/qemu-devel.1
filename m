Received: from eggs.gnu.org ([2001:4830:134:3::10]:34561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fKmrj-0001rM-1l
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fKmrf-0005Jz-Tq
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:51 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:41627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fKmrf-0005JC-NC
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:47 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Mon, 21 May 2018 17:36:42 +0200
Message-Id: <723d4fd2e9cd69ba6653322e0d2c18a2b0717b0a.1526916378.git.simon@ruderich.org>
In-Reply-To: <cover.1526916378.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1526916378.git.simon@ruderich.org>
In-Reply-To: <cover.1526916378.git.simon@ruderich.org>
References: <cover.1526916378.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v3 3/5] cpus: use size_t in
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

It's the natural type for object sizes and matches the return value of
sizeof(buf).

Signed-off-by: Simon Ruderich <simon@ruderich.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 cpus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 7fd8d3c32e..49d4d44916 100644
--- a/cpus.c
+++ b/cpus.c
@@ -2292,7 +2292,7 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
                  bool has_cpu, int64_t cpu_index, Error **errp)
 {
     int fd;
-    uint32_t l;
+    size_t l;
     CPUState *cpu;
     uint8_t buf[1024];
     int64_t orig_addr = addr, orig_size = size;
@@ -2340,7 +2340,7 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
                   Error **errp)
 {
     int fd;
-    uint32_t l;
+    size_t l;
     uint8_t buf[1024];
 
     fd = qemu_open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0600);
-- 
2.15.0

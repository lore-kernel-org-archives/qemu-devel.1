Received: from eggs.gnu.org ([2001:4830:134:3::10]:56219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyL-0000e6-KQ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuyJ-0007qU-1n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:25 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:33998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuyI-0007oo-Ee
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 16:05:22 -0400
Received: by mail-wm0-x234.google.com with SMTP id l15-v6so7862826wmc.1
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 13:05:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:24 +0100
Message-Id: <20180615194705.28019-14-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 13/54] tests/tcg/multiarch: move most output
 to stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The default test run outputs to stdout so it can be re-directed.
Errors are still reported to stderr.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v4
  - remove space in fprintf () to keep checkpatch happy
---
 tests/tcg/multiarch/test-mmap.c | 40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tests/tcg/multiarch/test-mmap.c b/tests/tcg/multiarch/test-mmap.c
index cdefadfa4c..5c0afe6e49 100644
--- a/tests/tcg/multiarch/test-mmap.c
+++ b/tests/tcg/multiarch/test-mmap.c
@@ -36,7 +36,7 @@
 do                                                             \
 {                                                              \
   if (!(x)) {                                                  \
-    fprintf (stderr, "FAILED at %s:%d\n", __FILE__, __LINE__); \
+    fprintf(stderr, "FAILED at %s:%d\n", __FILE__, __LINE__); \
     exit (EXIT_FAILURE);                                       \
   }                                                            \
 } while (0)
@@ -57,7 +57,7 @@ void check_aligned_anonymous_unfixed_mmaps(void)
 	uintptr_t p;
 	int i;
 
-	fprintf (stderr, "%s", __func__);
+	fprintf(stdout, "%s", __func__);
 	for (i = 0; i < 0x1fff; i++)
 	{
 		size_t len;
@@ -106,7 +106,7 @@ void check_aligned_anonymous_unfixed_mmaps(void)
 		munmap (p4, len);
 		munmap (p5, len);
 	}
-	fprintf (stderr, " passed\n");
+	fprintf(stdout, " passed\n");
 }
 
 void check_large_anonymous_unfixed_mmap(void)
@@ -115,7 +115,7 @@ void check_large_anonymous_unfixed_mmap(void)
 	uintptr_t p;
 	size_t len;
 
-	fprintf (stderr, "%s", __func__);
+	fprintf(stdout, "%s", __func__);
 
 	len = 0x02000000;
 	p1 = mmap(NULL, len, PROT_READ, 
@@ -130,7 +130,7 @@ void check_large_anonymous_unfixed_mmap(void)
 	/* Make sure we can read from the entire area.  */
 	memcpy (dummybuf, p1, pagesize);
 	munmap (p1, len);
-	fprintf (stderr, " passed\n");
+	fprintf(stdout, " passed\n");
 }
 
 void check_aligned_anonymous_unfixed_colliding_mmaps(void)
@@ -141,7 +141,7 @@ void check_aligned_anonymous_unfixed_colliding_mmaps(void)
 	uintptr_t p;
 	int i;
 
-	fprintf (stderr, "%s", __func__);
+	fprintf(stdout, "%s", __func__);
 	for (i = 0; i < 0x2fff; i++)
 	{
 		int nlen;
@@ -180,7 +180,7 @@ void check_aligned_anonymous_unfixed_colliding_mmaps(void)
 		munmap (p2, pagesize);
 		munmap (p3, nlen);
 	}
-	fprintf (stderr, " passed\n");
+	fprintf(stdout, " passed\n");
 }
 
 void check_aligned_anonymous_fixed_mmaps(void)
@@ -194,7 +194,7 @@ void check_aligned_anonymous_fixed_mmaps(void)
 	addr = mmap(NULL, pagesize * 40, PROT_READ | PROT_WRITE, 
 		    MAP_PRIVATE | MAP_ANONYMOUS,
 		    -1, 0);
-	fprintf (stderr, "%s addr=%p", __func__, addr);
+	fprintf(stdout, "%s addr=%p", __func__, addr);
 	fail_unless (addr != MAP_FAILED);
 
 	for (i = 0; i < 40; i++)
@@ -212,7 +212,7 @@ void check_aligned_anonymous_fixed_mmaps(void)
 		munmap (p1, pagesize);
 		addr += pagesize;
 	}
-	fprintf (stderr, " passed\n");
+	fprintf(stdout, " passed\n");
 }
 
 void check_aligned_anonymous_fixed_mmaps_collide_with_host(void)
@@ -225,8 +225,8 @@ void check_aligned_anonymous_fixed_mmaps_collide_with_host(void)
 	/* Find a suitable address to start with.  Right were the x86 hosts
 	 stack is.  */
 	addr = ((void *)0x80000000);
-	fprintf (stderr, "%s addr=%p", __func__, addr);
-	fprintf (stderr, "FIXME: QEMU fails to track pages used by the host.");
+	fprintf(stdout, "%s addr=%p", __func__, addr);
+	fprintf(stdout, "FIXME: QEMU fails to track pages used by the host.");
 
 	for (i = 0; i < 20; i++)
 	{
@@ -243,7 +243,7 @@ void check_aligned_anonymous_fixed_mmaps_collide_with_host(void)
 		munmap (p1, pagesize);
 		addr += pagesize;
 	}
-	fprintf (stderr, " passed\n");
+	fprintf(stdout, " passed\n");
 }
 
 void check_file_unfixed_mmaps(void)
@@ -252,7 +252,7 @@ void check_file_unfixed_mmaps(void)
 	uintptr_t p;
 	int i;
 
-	fprintf (stderr, "%s", __func__);
+	fprintf(stdout, "%s", __func__);
 	for (i = 0; i < 0x10; i++)
 	{
 		size_t len;
@@ -294,7 +294,7 @@ void check_file_unfixed_mmaps(void)
 		munmap (p2, len);
 		munmap (p3, len);
 	}
-	fprintf (stderr, " passed\n");
+	fprintf(stdout, " passed\n");
 }
 
 void check_file_unfixed_eof_mmaps(void)
@@ -304,7 +304,7 @@ void check_file_unfixed_eof_mmaps(void)
 	uintptr_t p;
 	int i;
 
-	fprintf (stderr, "%s", __func__);
+	fprintf(stdout, "%s", __func__);
 	for (i = 0; i < 0x10; i++)
 	{
 		p1 = mmap(NULL, pagesize, PROT_READ, 
@@ -327,7 +327,7 @@ void check_file_unfixed_eof_mmaps(void)
 		fail_unless (cp[pagesize - 4] == 0);
 		munmap (p1, pagesize);
 	}
-	fprintf (stderr, " passed\n");
+	fprintf(stdout, " passed\n");
 }
 
 void check_file_fixed_eof_mmaps(void)
@@ -343,7 +343,7 @@ void check_file_fixed_eof_mmaps(void)
 		    MAP_PRIVATE | MAP_ANONYMOUS,
 		    -1, 0);
 
-	fprintf (stderr, "%s addr=%p", __func__, (void *)addr);
+	fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
 	fail_unless (addr != MAP_FAILED);
 
 	for (i = 0; i < 0x10; i++)
@@ -371,7 +371,7 @@ void check_file_fixed_eof_mmaps(void)
 		munmap (p1, pagesize);
 		addr += pagesize;
 	}
-	fprintf (stderr, " passed\n");
+	fprintf(stdout, " passed\n");
 }
 
 void check_file_fixed_mmaps(void)
@@ -384,7 +384,7 @@ void check_file_fixed_mmaps(void)
 	addr = mmap(NULL, pagesize * 40 * 4, PROT_READ, 
 		    MAP_PRIVATE | MAP_ANONYMOUS,
 		    -1, 0);
-	fprintf (stderr, "%s addr=%p", __func__, (void *)addr);
+	fprintf(stdout, "%s addr=%p", __func__, (void *)addr);
 	fail_unless (addr != MAP_FAILED);
 
 	for (i = 0; i < 40; i++)
@@ -426,7 +426,7 @@ void check_file_fixed_mmaps(void)
 		munmap (p4, pagesize);
 		addr += pagesize * 4;
 	}
-	fprintf (stderr, " passed\n");
+	fprintf(stdout, " passed\n");
 }
 
 void checked_write(int fd, const void *buf, size_t count)
-- 
2.17.1

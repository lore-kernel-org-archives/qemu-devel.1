Received: from eggs.gnu.org ([2001:4830:134:3::10]:52448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNhlm-0006D4-Pd
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNhli-0002pe-FP
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:14 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNhli-0002pQ-9D
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:10 -0400
Received: by mail-wr0-x233.google.com with SMTP id r103so140130537wrb.0
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 08:42:10 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 16:42:37 +0100
Message-Id: <20170621154244.28309-4-alex.bennee@linaro.org>
In-Reply-To: <20170621154244.28309-1-alex.bennee@linaro.org>
References: <20170621154244.28309-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v6 03/10] risu: a bit more verbosity when
 starting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

When debugging faults it is useful to know where the generated
instructions are living.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v6
  - removed stray/stale declarations
v5
  - dropped all the status update due to signal handler contraints
v3
  - use portable fmt string for image_start_address
  - include arm dumping position
---
 risu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/risu.c b/risu.c
index 2cd6d22..a10422a 100644
--- a/risu.c
+++ b/risu.c
@@ -124,6 +124,8 @@ int master(int sock)
     }
     master_socket = sock;
     set_sigill_handler(&master_sigill);
+    fprintf(stderr, "starting master image at 0x%"PRIxPTR"\n",
+            image_start_address);
     fprintf(stderr, "starting image\n");
     image_start();
     fprintf(stderr, "image returned unexpectedly\n");
@@ -134,6 +136,8 @@ int apprentice(int sock)
 {
     apprentice_socket = sock;
     set_sigill_handler(&apprentice_sigill);
+    fprintf(stderr, "starting apprentice image at 0x%"PRIxPTR"\n",
+            image_start_address);
     fprintf(stderr, "starting image\n");
     image_start();
     fprintf(stderr, "image returned unexpectedly\n");
-- 
2.13.0

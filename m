Received: from eggs.gnu.org ([2001:4830:134:3::10]:45110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeL-0007dN-ST
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fRAeJ-0004Ie-1K
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:25 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:53408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fRAeI-0004IH-Rd
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 02:13:22 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri,  8 Jun 2018 09:13:16 +0300
Message-Id: <20180608061316.4909-6-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
References: <20180608061316.4909-1-samuel.thibault@ens-lyon.org>
Subject: [Qemu-devel] [PULL 5/5] slirp: reformat m_inc routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Coding style changes to the m_inc routine and minor refactoring.

Reported-by: ZDI Disclosures <zdi-disclosures@trendmicro.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/mbuf.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/slirp/mbuf.c b/slirp/mbuf.c
index 18cbf759a7..0c189e1a7b 100644
--- a/slirp/mbuf.c
+++ b/slirp/mbuf.c
@@ -151,27 +151,25 @@ m_cat(struct mbuf *m, struct mbuf *n)
 void
 m_inc(struct mbuf *m, int size)
 {
-	int datasize;
+    int datasize;
 
-	/* some compiles throw up on gotos.  This one we can fake. */
-        if(m->m_size>size) return;
+    /* some compilers throw up on gotos.  This one we can fake. */
+    if (m->m_size > size) {
+        return;
+    }
 
-        if (m->m_flags & M_EXT) {
-	  datasize = m->m_data - m->m_ext;
-	  m->m_ext = g_realloc(m->m_ext, size + datasize);
-	  m->m_data = m->m_ext + datasize;
-        } else {
-	  char *dat;
-	  datasize = m->m_data - m->m_dat;
-	  dat = g_malloc(size + datasize);
-	  memcpy(dat, m->m_dat, m->m_size);
-
-	  m->m_ext = dat;
-	  m->m_data = m->m_ext + datasize;
-	  m->m_flags |= M_EXT;
-        }
+    if (m->m_flags & M_EXT) {
+        datasize = m->m_data - m->m_ext;
+        m->m_ext = g_realloc(m->m_ext, size + datasize);
+    } else {
+        datasize = m->m_data - m->m_dat;
+        m->m_ext = g_malloc(size + datasize);
+        memcpy(m->m_ext, m->m_dat, m->m_size);
+        m->m_flags |= M_EXT;
+    }
 
-        m->m_size = size + datasize;
+    m->m_data = m->m_ext + datasize;
+    m->m_size = size + datasize;
 }
 
 
-- 
2.17.1

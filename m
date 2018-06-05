Received: from eggs.gnu.org ([2001:4830:134:3::10]:59374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1fQGO4-0006pL-8z
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1fQGO3-0000bh-CN
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:08:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48666 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1fQGO3-0000bU-6M
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 14:08:51 -0400
From: P J P <ppandit@redhat.com>
Date: Tue,  5 Jun 2018 23:38:36 +0530
Message-Id: <20180605180836.21485-3-ppandit@redhat.com>
In-Reply-To: <20180605180836.21485-1-ppandit@redhat.com>
References: <20180605180836.21485-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] slirp: reformat m_cat routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Coding style changes to the m_cat routine and minor refactoring.

Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 slirp/mbuf.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/slirp/mbuf.c b/slirp/mbuf.c
index 0f45abd917..30e3b2719d 100644
--- a/slirp/mbuf.c
+++ b/slirp/mbuf.c
@@ -151,32 +151,28 @@ m_cat(struct mbuf *m, struct mbuf *n)
 void
 m_inc(struct mbuf *m, int size)
 {
-	int datasize;
+    int datasize;
 
-	/* some compiles throw up on gotos.  This one we can fake. */
-        if(m->m_size>size) return;
+    /* some compiles throw up on gotos. This one we can fake. */
+    if (m->m_size > size) {
+        return;
+    }
 
-        if (m->m_flags & M_EXT) {
-	  datasize = m->m_data - m->m_ext;
-          m->m_ext = g_realloc(m->m_ext, size + datasize);
-	  m->m_data = m->m_ext + datasize;
-        } else {
-	  char *dat;
-	  datasize = m->m_data - m->m_dat;
-      dat = g_malloc(size + datasize);
-	  memcpy(dat, m->m_dat, m->m_size);
-
-	  m->m_ext = dat;
-	  m->m_data = m->m_ext + datasize;
-	  m->m_flags |= M_EXT;
-        }
-
-        m->m_size = size + datasize;
+    if (m->m_flags & M_EXT) {
+        datasize = m->m_data - m->m_ext;
+        m->m_ext = g_realloc(m->m_ext, size + datasize);
+    } else {
+        datasize = m->m_data - m->m_dat;
+        m->m_ext = g_malloc(size + datasize);
+        memcpy(m->m_ext, m->m_dat, m->m_size);
+        m->m_flags |= M_EXT;
+    }
 
+    m->m_data = m->m_ext + datasize;
+    m->m_size = size + datasize;
 }
 
 
-
 void
 m_adj(struct mbuf *m, int len)
 {
-- 
2.17.1

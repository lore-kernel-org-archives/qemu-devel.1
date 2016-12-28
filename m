Received: from eggs.gnu.org ([2001:4830:134:3::10]:38066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMGPR-0000Hm-VF
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 10:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMGPP-0004iT-At
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 10:44:57 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:60254)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cMGPO-0004hJ-VG
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 10:44:55 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 28 Dec 2016 16:44:48 +0100
Message-Id: <148293988867.31645.16079390011208688213.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148293987753.31645.8166717498506500137.stgit@fimbulvetr.bsc.es>
References: <148293987753.31645.8166717498506500137.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 2/6] queue: Add macro for incremental
 traversal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Adds macro QTAILQ_FOREACH_CONTINUE to support incremental list
traversal.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 include/qemu/queue.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 342073fb4d..ea6130f1c9 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -415,6 +415,18 @@ struct {                                            =
                    \
                 (var);                                                  =
\
                 (var) =3D ((var)->field.tqe_next))
=20
+/**
+ * QTAILQ_FOREACH_CONTINUE:
+ * @var: Variable to resume iteration from.
+ * @field: Field in @var holding a QTAILQ_ENTRY for this queue.
+ *
+ * Resumes iteration on a queue from the element in @var.
+ */
+#define QTAILQ_FOREACH_CONTINUE(var, field)                             =
\
+        for ((var) =3D ((var)->field.tqe_next);                         =
  \
+                (var);                                                  =
\
+                (var) =3D ((var)->field.tqe_next))
+
 #define QTAILQ_FOREACH_SAFE(var, head, field, next_var)                 =
\
         for ((var) =3D ((head)->tqh_first);                             =
  \
                 (var) && ((next_var) =3D ((var)->field.tqe_next), 1);   =
  \

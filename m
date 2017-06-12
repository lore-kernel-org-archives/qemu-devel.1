Received: from eggs.gnu.org ([2001:4830:134:3::10]:57836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dKQjP-00089Y-O4
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dKQjL-0000P5-Ny
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:54:15 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:43053 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dKQjL-0000Oj-Bo
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:54:11 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Mon, 12 Jun 2017 17:54:02 +0300
Message-Id: <149727924253.28532.2681638904562623104.stgit@frigg.lan>
In-Reply-To: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
References: <149727922719.28532.11985025310576184920.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 2/6] queue: Add macro for incremental
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Adds macro QTAILQ_FOREACH_CONTINUE to support incremental list
traversal.

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 include/qemu/queue.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 35292c3155..eb2bf9cb1c 100644
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

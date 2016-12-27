Received: from eggs.gnu.org ([2001:4830:134:3::10]:37554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLtod-0006TS-W4
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLtoa-00077a-Ub
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:37:28 -0500
Received: from roura.ac.upc.es ([147.83.33.10]:44892)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLtoa-00077C-GR
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:37:24 -0500
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Tue, 27 Dec 2016 16:37:22 +0100
Message-Id: <148285304262.12721.17599380934779528989.stgit@fimbulvetr.bsc.es>
In-Reply-To: <148285303159.12721.5833400768046299304.stgit@fimbulvetr.bsc.es>
References: <148285303159.12721.5833400768046299304.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/6] queue: Add macro for incremental
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
 include/qemu/queue.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 342073fb4d..0d709016f4 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -415,6 +415,11 @@ struct {                                            =
                    \
                 (var);                                                  =
\
                 (var) =3D ((var)->field.tqe_next))
=20
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

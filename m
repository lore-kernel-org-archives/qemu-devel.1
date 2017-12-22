Received: from eggs.gnu.org ([2001:4830:134:3::10]:57322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6k-0005ne-Nj
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6f-0002UI-MW
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:27 +0100
Message-Id: <20171222151846.28110-17-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 16/35] block: Mention -drive
 cyls/heads/secs/trans/serial/addr in deprecation chapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

Looks like we forgot to announce the deprecation of these options in
the corresponding chapter of the qemu-doc text, so let's do that now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-doc.texi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 96fda9c56e..2cc741e77e 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2680,6 +2680,21 @@ longer be directly supported in QEMU.
 The ``-drive if=scsi'' argument is replaced by the the
 ``-device BUS-TYPE'' argument combined with ``-drive if=none''.
 
+@subsection -drive cyls=...,heads=...,secs=...,trans=... (since 2.10.0)
+
+The drive geometry arguments are replaced by the the geometry arguments
+that can be specified with the ``-device'' parameter.
+
+@subsection -drive serial=... (since 2.10.0)
+
+The drive serial argument is replaced by the the serial argument
+that can be specified with the ``-device'' parameter.
+
+@subsection -drive addr=... (since 2.10.0)
+
+The drive addr argument is replaced by the the addr argument
+that can be specified with the ``-device'' parameter.
+
 @subsection -net dump (since 2.10.0)
 
 The ``--net dump'' argument is now replaced with the
-- 
2.13.6

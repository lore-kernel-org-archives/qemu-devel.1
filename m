Received: from eggs.gnu.org ([2001:4830:134:3::10]:33110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQz08-000636-Qw
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:14:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eQz04-0003p5-Ji
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:14:52 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 18 Dec 2017 18:14:33 +0100
Message-Id: <1513617273-7988-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1513617273-7988-1-git-send-email-thuth@redhat.com>
References: <1513617273-7988-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] block: Mention -drive
 cyls/heads/secs/trans/serial/addr in deprecation chapter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

Looks like we forgot to announce the deprecation of these options in
the corresponding chapter of the qemu-doc text, so let's do that now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index af495ad..f6afe01 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2469,6 +2469,21 @@ longer be directly supported in QEMU.
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
1.8.3.1

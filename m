Received: from eggs.gnu.org ([2001:4830:134:3::10]:40494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Ji-0005qf-Lr
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Jd-0004qH-4r
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:30 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:03:04 +0200
Message-Id: <20171002140307.5292-6-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-1-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 5/8] qemu-options: Add missing -iscsi Texinfo
 documentation
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-options.hx | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index c647fdde62..8568ee388c 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1180,6 +1180,12 @@ DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
     "                iSCSI session parameters\n", QEMU_ARCH_ALL)
 
 STEXI
+@item -iscsi
+@findex -iscsi
+Configure iSCSI session parameters.
+ETEXI
+
+STEXI
 @end table
 ETEXI
 DEFHEADING()
-- 
2.13.6

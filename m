Received: from eggs.gnu.org ([2001:4830:134:3::10]:45255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39W7-0003Ig-Gj
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39W4-0004Sv-Bj
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d39W4-0004SX-36
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:04 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PN4ZQ9133273
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 19:05:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2ebwaycp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 19:05:01 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 17:05:01 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 18:04:39 -0500
In-Reply-To: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1493161481-29595-7-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/8] qga: improve fsfreeze documentations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Some users find the fsfreeze behaviour confusing. Add some notes about
invalid mount points and Windows usage.

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1436976

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Vinzenz Feenstra <vfeenstr@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/qapi-schema.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 6307ae2..0f4cba5 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -426,7 +426,13 @@
 ##
 # @guest-fsfreeze-freeze:
 #
-# Sync and freeze all freezable, local guest filesystems
+# Sync and freeze all freezable, local guest filesystems. If this
+# command succeeded, you may call @guest-fsfreeze-thaw later to
+# unfreeze.
+#
+# Note: On Windows, the command is implemented with the help of a
+# Volume Shadow-copy Service DLL helper. The frozen state is limited
+# for up to 10 seconds by VSS.
 #
 # Returns: Number of file systems currently frozen. On error, all filesy=
stems
 # will be thawed.
@@ -439,10 +445,12 @@
 ##
 # @guest-fsfreeze-freeze-list:
 #
-# Sync and freeze specified guest filesystems
+# Sync and freeze specified guest filesystems.
+# See also @guest-fsfreeze-freeze.
 #
 # @mountpoints: an array of mountpoints of filesystems to be frozen.
 #               If omitted, every mounted filesystem is frozen.
+#               Invalid mount points are ignored.
 #
 # Returns: Number of file systems currently frozen. On error, all filesy=
stems
 # will be thawed.
--=20
2.7.4

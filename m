Received: from eggs.gnu.org ([2001:4830:134:3::10]:56796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18g-0005WY-Ly
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dX18g-0001W5-0M
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dX18f-0001VI-QB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:12:21 -0400
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 17 Jul 2017 10:11:52 +0200
Message-Id: <20170717081152.17153-10-lprosek@redhat.com>
In-Reply-To: <20170717081152.17153-1-lprosek@redhat.com>
References: <20170717081152.17153-1-lprosek@redhat.com>
Subject: [Qemu-devel] [PATCH v3 9/9] checkpatch: add virtio_error and
 virtqueue_error to error funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: casasfernando@hotmail.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, armbru@redhat.com, groug@kaod.org, arei.gonglei@huawei.com, aneesh.kumar@linux.vnet.ibm.com

Two more error functions that should not contain newlines.

Suggested-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 scripts/checkpatch.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4e91122..2cd2713 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2540,7 +2540,9 @@ sub process {
 				info_vreport|
 				error_report|
 				warn_report|
-				info_report}x;
+				info_report|
+				virtio_error|
+				virtqueue_error}x;
 
 	if ($rawline =~ /\b(?:$qemu_error_funcs)\s*\(.*\".*\\n/) {
 		ERROR("Error messages should not contain newlines\n" . $herecurr);
-- 
2.9.3

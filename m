Received: from eggs.gnu.org ([2001:4830:134:3::10]:40653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fSrdn-000070-KO
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fSrdk-0007TE-WC
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:19:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fSrdk-0007R2-N7
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 18:19:48 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5CMIx6d044322
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:19:46 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jjpc5rys3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:19:45 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 12 Jun 2018 16:19:45 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 12 Jun 2018 17:19:23 -0500
Message-Id: <20180612221923.24469-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] docs: add details regarding submitting
 stable-specific patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>

Also add a few more details regarding normal master->stable patch
flow.

Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 docs/devel/stable-process.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/docs/devel/stable-process.rst b/docs/devel/stable-process.rst
index 98736a9ea4..008fb4f9b4 100644
--- a/docs/devel/stable-process.rst
+++ b/docs/devel/stable-process.rst
@@ -56,6 +56,21 @@ There are various ways to get a patch into stable:
   appropriate other people (like the patch author or the relevant maintainer)
   on copy.
 
+Generally patches for a stable release/branch must first be included in the
+master QEMU branch, and from there the stable branch's maintainer will
+cherry-pick/backport the patch. However, occasionally there is a need to
+apply a stable-specific patch, such as a fix from master that isn't easily
+cherry-picked and has been reworked/backported specifically for a stable
+branch, or a fix that's only necessary in the context of a particular stable
+release. In such cases, the patch can be submitted to qemu-devel@nongnu.org
+using Cc: qemu-stable@nongnu.org just like a normal stable patch, but tagged
+with a "for-stable" or a "for-<stable-version>" in the subject line to
+indicate that's it's specifically for a stable branch and not master. For
+instance:
+
+  [PATCH for-2.11.2] spapr: make pseries-2.11 the default machine type
+
+
 Stable release process
 ----------------------
 
-- 
2.11.0

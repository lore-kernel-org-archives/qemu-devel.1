Received: from eggs.gnu.org ([2001:4830:134:3::10]:52466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eiZd5-0000vD-OZ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 00:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eiZd4-0006qV-MM
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 00:47:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eiZd4-0006qE-G1
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 00:47:46 -0500
From: Fam Zheng <famz@redhat.com>
Date: Mon,  5 Feb 2018 13:47:25 +0800
Message-Id: <20180205054725.25634-3-famz@redhat.com>
In-Reply-To: <20180205054725.25634-1-famz@redhat.com>
References: <20180205054725.25634-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/2] README: Document 'git-publish' workflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com, stefanha@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 README | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/README b/README
index b92a07a61a..d1a944ce20 100644
--- a/README
+++ b/README
@@ -56,7 +56,7 @@ The QEMU source code is maintained under the GIT version control system.
 
    git clone git://git.qemu.org/qemu.git
 
-When submitting patches, the preferred approach is to use 'git
+When submitting patches, one common approach is to use 'git
 format-patch' and/or 'git send-email' to format & send the mail to the
 qemu-devel@nongnu.org mailing list. All patches submitted must contain
 a 'Signed-off-by' line from the author. Patches should follow the
@@ -68,6 +68,34 @@ the QEMU website
   https://qemu.org/Contribute/SubmitAPatch
   https://qemu.org/Contribute/TrivialPatches
 
+A 'git-profile' utility was created to make above process less
+cumbersome, and is highly recommended for making regular contributions,
+or even just for sending consecutive patch series revisions. It also
+requires a working 'git send-email' setup, and by default doesn't
+automate everything, so you may want to go through the above steps
+manually for once.
+
+For installation instructions, please go to
+
+  https://github.com/stefanha/git-publish
+
+The workflow with 'git-publish' is:
+
+  $ git checkout master -b my-feature
+  $ # work on new commits, add your 'Signed-off-by' lines to each
+  $ git publish
+
+Your patch series will be sent and tagged as my-feature-v1 if you need to refer
+back to it in the future.
+
+Sending v2:
+
+  $ git checkout my-feature # same topic branch
+  $ # making changes to the commits (using 'git rebase', for example)
+  $ git publish
+
+Your patch series will be sent with 'v2' tag in the subject and the git tip
+will be tagged as my-feature-v2.
 
 Bug reporting
 =============
-- 
2.14.3

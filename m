Received: from eggs.gnu.org ([2001:4830:134:3::10]:45543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ehcfp-0006Xt-Ge
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ehcfg-0006sh-AO
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:50:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ehcfg-0006rx-0G
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:50:32 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri,  2 Feb 2018 14:34:12 +0800
Message-Id: <20180202063412.22466-3-famz@redhat.com>
In-Reply-To: <20180202063412.22466-1-famz@redhat.com>
References: <20180202063412.22466-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] README: Document 'git-publish' workflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, stefanha@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 .gitpublish |  1 +
 README      | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/.gitpublish b/.gitpublish
index 170bd2ed48..7542e878fc 100644
--- a/.gitpublish
+++ b/.gitpublish
@@ -26,6 +26,7 @@ cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallba
 base = master
 prefix = PATCH
 to = qemu-devel@nongnu.org
+cc = qemu-trivial@nongnu.org
 cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
 
 [gitpublishprofile "block"]
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

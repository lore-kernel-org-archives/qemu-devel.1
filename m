Received: from eggs.gnu.org ([2001:4830:134:3::10]:49117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1esmbj-0005je-GI
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1esmbi-000687-Fv
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 04:40:35 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon,  5 Mar 2018 09:40:06 +0000
Message-Id: <20180305094006.21446-7-stefanha@redhat.com>
In-Reply-To: <20180305094006.21446-1-stefanha@redhat.com>
References: <20180305094006.21446-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] README: Document 'git-publish' workflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20180226030326.20219-3-famz@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 README | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/README b/README
index 2c8e1c8cc4..7833b97365 100644
--- a/README
+++ b/README
@@ -56,7 +56,7 @@ The QEMU source code is maintained under the GIT version control system.
 
    git clone git://git.qemu.org/qemu.git
 
-When submitting patches, the preferred approach is to use 'git
+When submitting patches, one common approach is to use 'git
 format-patch' and/or 'git send-email' to format & send the mail to the
 qemu-devel@nongnu.org mailing list. All patches submitted must contain
 a 'Signed-off-by' line from the author. Patches should follow the
@@ -73,6 +73,35 @@ The QEMU website is also maintained under source control.
   git clone git://git.qemu.org/qemu-web.git
   https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/
 
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
+
 Bug reporting
 =============
 
-- 
2.14.3

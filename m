Received: from eggs.gnu.org ([2001:4830:134:3::10]:59337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daKDP-0001IA-Qn
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daKDM-00020S-Hx
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:10:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daKDM-000203-BQ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:10:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3524480477
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 11:10:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Jul 2017 13:10:49 +0200
Message-Id: <20170726111049.18030-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] move bug reporting instructions from
 wiki to www
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, eblake@redhat.com

The bug reporting instructions are pretty static, and it is nicer if bug
reporters stay within the familiar QEMU web site layout.  Move the page
to qemu.org.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 _includes/footer.html      |  2 +-
 contribute.md              |  2 +-
 contribute/report-a-bug.md | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)
 create mode 100644 contribute/report-a-bug.md

diff --git a/_includes/footer.html b/_includes/footer.html
index cd28480..7a3e8b1 100644
--- a/_includes/footer.html
+++ b/_includes/footer.html
@@ -7,9 +7,9 @@
 		</ul>
 		<ul class="style">
 			<li><a href="/contribute">Contribute</a></li>
+			<li><a href="/contribute/report-a-bug">Reporting a bug</a></li>
 			<li><a href="http://wiki.qemu-project.org/Documentation/GettingStartedDevelopers">New contributors</a></li>
 			<li><a href="http://wiki.qemu-project.org/Contribute/SubmitAPatch">Submitting a patch</a></li>
-			<li><a href="http://wiki.qemu-project.org/Contribute/ReportABug">Reporting a bug</a></li>
 			<li><a href="http://wiki.qemu-project.org/Contribute/FAQ">Contributor FAQ</a></li>
 		</ul>
 		<ul class="style">
diff --git a/contribute.md b/contribute.md
index fb2238d..e052654 100644
--- a/contribute.md
+++ b/contribute.md
@@ -3,7 +3,7 @@ title: Contribute to QEMU!
 permalink: /contribute/
 ---
 
-* Report a bug: https://bugs.launchpad.net/qemu/<br>[How to report a bug](http://wiki.qemu-project.org/Contribute/ReportABug)
+* Report a bug: https://bugs.launchpad.net/qemu/<br>[How to report a bug](report-a-bug/)
 
 * Clone the git repository: <br>`git clone git://git.qemu-project.org/qemu.git`
 
diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
new file mode 100644
index 0000000..f0fd67b
--- /dev/null
+++ b/contribute/report-a-bug.md
@@ -0,0 +1,19 @@
+---
+title: Reporting a bug
+permalink: /contribute/report-a-bug
+---
+
+Bugs can be filed at our [https://bugs.launchpad.net/qemu/ bug tracker].
+
+When submitting a bug report, please try to do the following:
+
+* Make sure you're reporting the bug against the [latest release](/download/#source).  If possible, please try to reproduce with the latest development tree too.
+
+* Include the full command line used to launch the QEMU guest.
+
+* Reproduce the problem directly with a QEMU command-line.  Avoid frontends and management stacks, to ensure that the bug is in QEMU itself and not in a frontend.
+
+* Include as information about the guest (operating system, version, 32/64-bit).
+
+* Do not contribute patches on the bug tracker; send patches to the mailing list. Follow QEMU's [guidelines about submitting patches](http://wiki.qemu.org/Contribute/SubmitAPatch).
+
-- 
2.13.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:50451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daKk9-00073l-F8
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daKk6-0005pA-6h
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:44:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47000)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daKk5-0005o8-TM
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:44:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D691561D15
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 11:44:40 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Jul 2017 13:44:37 +0200
Message-Id: <20170726114437.19624-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [qemu-web PATCH] add Thomas's bug reporting dos and
 don'ts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, thuth@redhat.com

We don't want the page to become too long, but these are good suggestions.

Also tone down the sentence about using the latest release or latest git
tree, though we do prefer those.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contribute.md              |  2 +-
 contribute/report-a-bug.md | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/contribute.md b/contribute.md
index e052654..b10ba7f 100644
--- a/contribute.md
+++ b/contribute.md
@@ -3,7 +3,7 @@ title: Contribute to QEMU!
 permalink: /contribute/
 ---
 
-* Report a bug: https://bugs.launchpad.net/qemu/<br>[How to report a bug](report-a-bug/)
+* Report a bug: [https://bugs.launchpad.net/qemu/](https://bugs.launchpad.net/qemu/)<br>[How to report a bug](report-a-bug/)
 
 * Clone the git repository: <br>`git clone git://git.qemu-project.org/qemu.git`
 
diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
index ce73d76..81eecf7 100644
--- a/contribute/report-a-bug.md
+++ b/contribute/report-a-bug.md
@@ -3,17 +3,24 @@ title: Reporting a bug
 permalink: /contribute/report-a-bug/
 ---
 
-Bugs can be filed at our [bug tracker](https://bugs.launchpad.net/qemu/), which is hosted on Launchpad.
+Bugs can be filed at our [bug tracker](https://bugs.launchpad.net/qemu/), which is hosted on Launchpad. If you've got a problem with how your Linux distribution packages QEMU, use the bug tracker from your distro instead.
 
 When submitting a bug report, please try to do the following:
 
-* Make sure you're reporting the bug against the [latest release](/download/#source).  If possible, please try to reproduce with the latest development tree too.
+* Include the QEMU release version or the git commit hash into the description, so that it is later still clear in which version you have found the bug.  Reports against the [latest release](/download/#source) or even the latest development tree are usually acted upon faster.
 
 * Include the full command line used to launch the QEMU guest.
 
 * Reproduce the problem directly with a QEMU command-line.  Avoid frontends and management stacks, to ensure that the bug is in QEMU itself and not in a frontend.
 
-* Include as information about the guest (operating system, version, 32/64-bit).
+* Include as information about the host and guest (operating system, version, 32/64-bit).
 
 * Do not contribute patches on the bug tracker; send patches to the mailing list. Follow QEMU's [guidelines about submitting patches](http://wiki.qemu.org/Contribute/SubmitAPatch).
 
+Do NOT report security issues (or other bugs, too) as
+"private" bugs in the bug tracker.  QEMU has a [security
+process](http://wiki.qemu.org/SecurityProcess) for issues that should
+be reported in a non-public way instead.
+
+For problems with KVM in the kernel, use the kernel bug tracker instead;
+the [KVM wiki](http://www.linux-kvm.org/page/Bugs) has the details.
-- 
2.13.3

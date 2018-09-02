Received: from [208.118.235.92] (port=42999 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwSjp-0005F3-FV
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 09:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1fwSU3-0005G8-DO
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 09:32:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43207 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1fwSU2-0005EK-T6
	for qemu-devel@nongnu.org; Sun, 02 Sep 2018 09:32:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE6BF4021704
	for <qemu-devel@nongnu.org>; Sun,  2 Sep 2018 12:36:21 +0000 (UTC)
From: Yoni Bettan <ybettan@redhat.com>
Date: Sun,  2 Sep 2018 15:36:05 +0300
Message-Id: <20180902123608.124586-2-ybettan@redhat.com>
In-Reply-To: <20180902123608.124586-1-ybettan@redhat.com>
References: <20180902123608.124586-1-ybettan@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] README.md : Reformatted to fit the
 Markdown (.md) format.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, Yoni Bettan <ybettan@redhat.com>

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
---
 README => README.md | 87 +++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 43 deletions(-)
 rename README => README.md (68%)

diff --git a/README b/README.md
similarity index 68%
rename from README
rename to README.md
index 49a9fd09cd..ac0e0528fb 100644
--- a/README
+++ b/README.md
@@ -1,5 +1,4 @@
-         QEMU README
-         ===========
+# Qemu
 
 QEMU is a generic and open source machine & userspace emulator and
 virtualizer.
@@ -30,86 +29,90 @@ QEMU as a whole is released under the GNU General Public License,
 version 2. For full licensing details, consult the LICENSE file.
 
 
-Building
-========
+## Building
 
 QEMU is multi-platform software intended to be buildable on all modern
 Linux platforms, OS-X, Win32 (via the Mingw64 toolchain) and a variety
 of other UNIX targets. The simple steps to build QEMU are:
 
-  mkdir build
-  cd build
-  ../configure
-  make
+```
+mkdir build
+cd build
+../configure
+make
+```
 
 Additional information can also be found online via the QEMU website:
 
-  https://qemu.org/Hosts/Linux
-  https://qemu.org/Hosts/Mac
-  https://qemu.org/Hosts/W32
+* https://qemu.org/Hosts/Linux
+* https://qemu.org/Hosts/Mac
+* https://qemu.org/Hosts/W32
 
 
-Submitting patches
-==================
+## Submitting patches
 
 The QEMU source code is maintained under the GIT version control system.
 
-   git clone git://git.qemu.org/qemu.git
+`git clone git://git.qemu.org/qemu.git`
 
-When submitting patches, one common approach is to use 'git
-format-patch' and/or 'git send-email' to format & send the mail to the
-qemu-devel@nongnu.org mailing list. All patches submitted must contain
-a 'Signed-off-by' line from the author. Patches should follow the
-guidelines set out in the HACKING and CODING_STYLE files.
+When submitting patches, one common approach is to use `git format-patch`
+and/or `git send-email` to format & send the mail to the
+[qemu-devel@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-devel)
+mailing list. All patches submitted must contain a 'Signed-off-by' line from
+the author. Patches should follow the guidelines set out in the
+[HACKING.md](HACKING.md) and [CODING_STYLE.md](CODING_STYLE.md) files.
 
 Additional information on submitting patches can be found online via
 the QEMU website
 
-  https://qemu.org/Contribute/SubmitAPatch
-  https://qemu.org/Contribute/TrivialPatches
+* https://qemu.org/Contribute/SubmitAPatch
+* https://qemu.org/Contribute/TrivialPatches
 
 The QEMU website is also maintained under source control.
 
-  git clone git://git.qemu.org/qemu-web.git
-  https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/
+`git clone git://git.qemu.org/qemu-web.git`
+* https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/
 
-A 'git-publish' utility was created to make above process less
+A `git-publish` utility was created to make above process less
 cumbersome, and is highly recommended for making regular contributions,
 or even just for sending consecutive patch series revisions. It also
-requires a working 'git send-email' setup, and by default doesn't
+requires a working `git send-email` setup, and by default doesn't
 automate everything, so you may want to go through the above steps
 manually for once.
 
 For installation instructions, please go to
 
-  https://github.com/stefanha/git-publish
+* https://github.com/stefanha/git-publish
 
 The workflow with 'git-publish' is:
 
-  $ git checkout master -b my-feature
-  $ # work on new commits, add your 'Signed-off-by' lines to each
-  $ git publish
+```
+git checkout master -b my-feature
+# work on new commits, add your 'Signed-off-by' lines to each
+git publish
+```
 
 Your patch series will be sent and tagged as my-feature-v1 if you need to refer
 back to it in the future.
 
 Sending v2:
 
-  $ git checkout my-feature # same topic branch
-  $ # making changes to the commits (using 'git rebase', for example)
-  $ git publish
+```
+git checkout my-feature # same topic branch
+# making changes to the commits (using 'git rebase', for example)
+git publish
+```
 
 Your patch series will be sent with 'v2' tag in the subject and the git tip
 will be tagged as my-feature-v2.
 
-Bug reporting
-=============
+## Bug reporting
 
 The QEMU project uses Launchpad as its primary upstream bug tracker. Bugs
 found when running code built from QEMU git or upstream released sources
 should be reported via:
 
-  https://bugs.launchpad.net/qemu/
+* https://bugs.launchpad.net/qemu/
 
 If using QEMU via an operating system vendor pre-built binary package, it
 is preferable to report bugs to the vendor's own bug tracker first. If
@@ -118,22 +121,20 @@ reported via launchpad.
 
 For additional information on bug reporting consult:
 
-  https://qemu.org/Contribute/ReportABug
+* https://qemu.org/Contribute/ReportABug
 
 
-Contact
-=======
+## Contact
 
 The QEMU community can be contacted in a number of ways, with the two
 main methods being email and IRC
 
- - qemu-devel@nongnu.org
-   https://lists.nongnu.org/mailman/listinfo/qemu-devel
- - #qemu on irc.oftc.net
+* [qemu-devel@nongnu.org](https://lists.nongnu.org/mailman/listinfo/qemu-devel)
+* #qemu on irc.oftc.net
 
 Information on additional methods of contacting the community can be
 found online via the QEMU website:
 
-  https://qemu.org/Contribute/StartHere
+* https://qemu.org/Contribute/StartHere
 
--- End
+## End
-- 
2.17.1

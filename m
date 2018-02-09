Received: from eggs.gnu.org ([2001:4830:134:3::10]:39353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek8Sp-0001Mz-Go
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek8Sm-0000CT-Ap
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:11:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44938 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ek8Sm-0000C2-68
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 08:11:36 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 14:11:12 +0100
Message-Id: <20180209131112.2068-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC/D] docs: document our stable process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Some pointers on how to get a patch into stable.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

This probably needs more love, but I'd like to have at least _some_
kind of documentation.

Maybe this should also go into the wiki?

---
 docs/stable-process.rst | 57 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 docs/stable-process.rst

diff --git a/docs/stable-process.rst b/docs/stable-process.rst
new file mode 100644
index 0000000000..2502823dc5
--- /dev/null
+++ b/docs/stable-process.rst
@@ -0,0 +1,57 @@
+QEMU and the stable process
+===========================
+
+QEMU stable releases
+--------------------
+
+QEMU stable releases are based upon the last released QEMU version
+and marked by an additional version number, e.g. 2.10.1. Occasionally,
+a four-number version is released, if a single urgent fix needs to go
+on top.
+
+Usually, a stable release is only done for the last released version.
+
+What should go into a stable release?
+-------------------------------------
+
+Generally, the following patches are considered stable material:
+- Patches that fix severe issues, like fixes for CVEs
+- Patches that fix regressions
+
+If you think the patch would be important for users of the current release
+(or for a distribution picking fixes), it is usually a good candidate
+for stable.
+
+
+How to get a patch into QEMU stable
+-----------------------------------
+
+There are various ways to get a patch into stable:
+
+* Preferred: Make sure that the stable maintainers are on copy when you send
+  the patch by adding
+
+  .. code::
+
+     Cc: qemu-stable@nongnu.org
+
+   to the patch description. This will make git add the stable maintainers
+   on copy when your patch is sent out.
+
+* If a maintainer judges the patch appropriate for stable later on (or you
+  notify them), they will add the same line to your patch, meaning that
+  the stable maintainers will be on copy on the maintainer's pull request.
+
+* If you judge an already merged patch suitable for stable, send a mail
+  to ``qemu-stable@nongnu.org`` with ``qemu-devel@nongnu.org`` and appropriate
+  other people (like the patch author or the relevant maintainer) on copy.
+
+Stable release process
+----------------------
+
+When the stable maintainers prepare a new stable release, they will prepare
+a git branch with a release candidate and send the patches out to
+``qemu-devel@nongnu.org`` for review. If any of your patches are included,
+please verify that they look fine. You may also nominate other patches that
+you think are suitable for inclusion. After review is complete (may involve
+more release candidates), a new stable release is made available.
-- 
2.13.6

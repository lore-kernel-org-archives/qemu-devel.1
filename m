Received: from eggs.gnu.org ([2001:4830:134:3::10]:48420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elDPJ-0005Ik-Fk
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elDPG-0005WZ-9R
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:40:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1elDPG-0005W0-4H
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:40:26 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 12 Feb 2018 13:40:08 +0100
Message-Id: <20180212124008.8960-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2] docs: document our stable process
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

[contains some suggestions by mdroth]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
RFC/D->v2: added mdroth's suggestions
---
 docs/stable-process.rst | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 docs/stable-process.rst

diff --git a/docs/stable-process.rst b/docs/stable-process.rst
new file mode 100644
index 0000000000..c571204c9f
--- /dev/null
+++ b/docs/stable-process.rst
@@ -0,0 +1,67 @@
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
+Usually, stable releases are only provided for the last major QEMU
+release. For example, when QEMU 2.11.0 is released, 2.11.x or 2.11.x.y
+stable releases are produced only until QEMU 2.12.0 is released, at
+which the stable process moves to producing 2.12.x/2.12.x.y releases.
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
+  to the patch description. By default, this will send a copy of the  patch
+  to ``qemu-stable@nongnu.org`` if you use git send-email, which is where
+  patches that are stable candidates are tracked by the maintainers.
+
+* You can also reply to a patch and put ``qemu-stable@nongnu.org`` on copy
+  directly in your mail client if you think a previously submitted patch
+  should be considered for a stable release.
+
+* If a maintainer judges the patch appropriate for stable later on (or you
+  notify them), they will add the same line to the patch, meaning that
+  the stable maintainers will be on copy on the maintainer's pull request.
+
+* If you judge an already merged patch suitable for stable, send a mail
+  (preferably as a reply to the most recent patch submission) to
+  ``qemu-stable@nongnu.org`` along with ``qemu-devel@nongnu.org`` and
+  appropriate other people (like the patch author or the relevant maintainer)
+  on copy.
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

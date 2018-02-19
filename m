Received: from eggs.gnu.org ([2001:4830:134:3::10]:45904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1enryl-0001fq-Hc
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 15:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1enryh-0003Ax-Ex
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 15:24:03 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Feb 2018 21:23:40 +0100
Message-Id: <1519071820-4062-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Remove the deprecated -tdf option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>

It's been marked as deprecated since a very long time already, and
the parameter is not doing anything useful anymore except for printing
a warning, so it's now time to finally get rid of this option.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi | 7 -------
 vl.c          | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 56388b5..eac8e8b 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2606,13 +2606,6 @@ which is the default.
 
 @section System emulator command line arguments
 
-@subsection -tdf (since 1.3.0)
-
-The ``-tdf'' argument is ignored. The behaviour implemented
-by this argument is now the default when using the KVM PIT,
-but can be requested explicitly using
-``-global kvm-pit.lost_tick_policy=slew''.
-
 @subsection -no-kvm-pit-reinjection (since 1.3.0)
 
 The ``-no-kvm-pit-reinjection'' argument is now a
diff --git a/vl.c b/vl.c
index 81724f5..3956e53 100644
--- a/vl.c
+++ b/vl.c
@@ -3849,9 +3849,6 @@ int main(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_tdf:
-                warn_report("ignoring deprecated option");
-                break;
             case QEMU_OPTION_name:
                 opts = qemu_opts_parse_noisily(qemu_find_opts("name"),
                                                optarg, true);
-- 
1.8.3.1

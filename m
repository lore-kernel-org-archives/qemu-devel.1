Received: from eggs.gnu.org ([2001:4830:134:3::10]:47918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVH-0004kW-D5
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1etCVF-00069f-Bb
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:39 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:54856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1etCVF-00069C-5A
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:19:37 -0500
Received: by mail-wm0-x242.google.com with SMTP id z81so22679557wmb.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:19:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 14:18:58 +0100
Message-Id: <1520342370-123606-3-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
References: <1520342370-123606-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/34] Remove the deprecated -tdf option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

It's been marked as deprecated since a very long time already, and
the parameter is not doing anything useful anymore except for printing
a warning, so it's now time to finally get rid of this option.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1519071820-4062-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi | 7 -------
 vl.c          | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 4fcc85a..76ca83f 100644
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
index 6120b88..a92f60c 100644
--- a/vl.c
+++ b/vl.c
@@ -3842,9 +3842,6 @@ int main(int argc, char **argv, char **envp)
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

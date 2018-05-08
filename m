Received: from eggs.gnu.org ([2001:4830:134:3::10]:41449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtB-0003Bk-2W
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtA-0001XG-4J
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:17 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAt9-0001Wo-U9
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:16 -0400
Received: by mail-wm0-x243.google.com with SMTP id x12-v6so20840838wmc.0
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:15 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:38 +0200
Message-Id: <1525817687-34620-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/30] qemu-options: Remove deprecated
 -no-kvm-irqchip
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

We've never documented this option in our qemu-doc, so apart from the users
that already used the old qemu-kvm fork before, most users should not be
aware of this option at all. It's been marked as deprecated in the source
code for a long time already, and officially marked as deprecated in the
documentation since QEMU v2.10, so it should be fine to remove this now.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1525453270-23074-5-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi   | 5 -----
 qemu-options.hx | 3 ---
 vl.c            | 5 -----
 3 files changed, 13 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 85a7a39..bde542b 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2786,11 +2786,6 @@ which is the default.
 
 @section System emulator command line arguments
 
-@subsection -no-kvm-irqchip (since 1.3.0)
-
-The ``-no-kvm-irqchip'' argument is now a synonym for
-setting ``-machine kernel_irqchip=off''.
-
 @subsection -no-kvm (since 1.3.0)
 
 The ``-no-kvm'' argument is now a synonym for setting
diff --git a/qemu-options.hx b/qemu-options.hx
index dfff698..b2fefd1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3914,9 +3914,6 @@ ETEXI
 HXCOMM Deprecated by -machine accel=tcg property
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
-HXCOMM Deprecated by -machine kernel_irqchip=on|off property
-DEF("no-kvm-irqchip", 0, QEMU_OPTION_no_kvm_irqchip, "", QEMU_ARCH_I386)
-
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
     "-msg timestamp[=on|off]\n"
     "                change the format of messages\n"
diff --git a/vl.c b/vl.c
index 23d55a4..b9f6b42 100644
--- a/vl.c
+++ b/vl.c
@@ -3138,11 +3138,6 @@ int main(int argc, char **argv, char **envp)
                 exit(1);
             }
             switch(popt->index) {
-            case QEMU_OPTION_no_kvm_irqchip: {
-                olist = qemu_find_opts("machine");
-                qemu_opts_parse_noisily(olist, "kernel_irqchip=off", false);
-                break;
-            }
             case QEMU_OPTION_cpu:
                 /* hw initialization will check this */
                 cpu_model = optarg;
-- 
1.8.3.1

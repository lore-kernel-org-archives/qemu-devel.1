Received: from eggs.gnu.org ([2001:4830:134:3::10]:47009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEe5E-00054Y-LT
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fEe5D-0003g0-T1
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:01:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fEe5D-0003fT-Of
	for qemu-devel@nongnu.org; Fri, 04 May 2018 13:01:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 49BDB406C776
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 17:01:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  4 May 2018 19:01:09 +0200
Message-Id: <1525453270-23074-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1525453270-23074-1-git-send-email-thuth@redhat.com>
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/5] qemu-options: Remove deprecated
 -no-kvm-irqchip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: berrange@redhat.com, Markus Armbruster <armbru@redhat.com>

We've never documented this option in our qemu-doc, so apart from the users
that already used the old qemu-kvm fork before, most users should not be
aware of this option at all. It's been marked as deprecated in the source
code for a long time already, and officially marked as deprecated in the
documentation since QEMU v2.10, so it should be fine to remove this now.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi   | 5 -----
 qemu-options.hx | 3 ---
 vl.c            | 5 -----
 3 files changed, 13 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 2047ba5..9db156b 100644
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
index 9c0d60d..870a363 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3917,9 +3917,6 @@ ETEXI
 HXCOMM Deprecated by -machine accel=tcg property
 DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
 
-HXCOMM Deprecated by -machine kernel_irqchip=on|off property
-DEF("no-kvm-irqchip", 0, QEMU_OPTION_no_kvm_irqchip, "", QEMU_ARCH_I386)
-
 DEF("msg", HAS_ARG, QEMU_OPTION_msg,
     "-msg timestamp[=on|off]\n"
     "                change the format of messages\n"
diff --git a/vl.c b/vl.c
index bbe94ba..d8c3b09 100644
--- a/vl.c
+++ b/vl.c
@@ -3149,11 +3149,6 @@ int main(int argc, char **argv, char **envp)
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

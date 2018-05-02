Received: from eggs.gnu.org ([2001:4830:134:3::10]:46004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDvUb-0002s9-0B
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDvUa-0002Ac-2H
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDvUZ-0002AS-Tv
	for qemu-devel@nongnu.org; Wed, 02 May 2018 13:24:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90C027D843
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 17:24:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  2 May 2018 19:24:27 +0200
Message-Id: <1525281868-24747-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1525281868-24747-1-git-send-email-thuth@redhat.com>
References: <1525281868-24747-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 3/4] qemu-options: Remove deprecated
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
Cc: Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

We've never documented this option in our qemu-doc, so unless the users
used qemu-kvm before, they never should never have been aware of this
option. It's been marked as deprecated in the source code since a long
time already, and officially marked as deprecated in the documentation
since QEMU v2.10, so it should be fine to remove this now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-doc.texi   | 5 -----
 qemu-options.hx | 3 ---
 vl.c            | 5 -----
 3 files changed, 13 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index dd39bac..f605557 100644
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
index 24478b1..0d77a48 100644
--- a/vl.c
+++ b/vl.c
@@ -3185,11 +3185,6 @@ int main(int argc, char **argv, char **envp)
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

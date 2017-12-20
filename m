Received: from eggs.gnu.org ([2001:4830:134:3::10]:56622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyc-0004uE-KM
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyX-0007L7-1l
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:18 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyW-0007Kg-Rm
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:12 -0500
Received: by mail-wr0-x242.google.com with SMTP id s66so22903733wrc.9
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:46 +0100
Message-Id: <1513790098-9815-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/46] Remove legacy -no-kvm-pit option
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

It's only printing a warning since QEMU v1.3.0, so nobody should use
this anymore today. Let's get rid of this now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1513619065-31722-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qemu-doc.texi   | 5 -----
 qemu-options.hx | 3 ---
 vl.c            | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 69e2953..90bea73 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2612,11 +2612,6 @@ synonym for setting ``-global kvm-pit.lost_tick_policy=discard''.
 The ``-no-kvm-irqchip'' argument is now a synonym for
 setting ``-machine kernel_irqchip=off''.
 
-@subsection -no-kvm-pit (since 1.3.0)
-
-The ``-no-kvm-pit'' argument is ignored. It is no longer
-possible to disable the KVM PIT directly.
-
 @subsection -no-kvm (since 1.3.0)
 
 The ``-no-kvm'' argument is now a synonym for setting
diff --git a/qemu-options.hx b/qemu-options.hx
index b1e5781..94647e2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3927,9 +3927,6 @@ HXCOMM Deprecated by kvm-pit driver properties
 DEF("no-kvm-pit-reinjection", 0, QEMU_OPTION_no_kvm_pit_reinjection,
     "", QEMU_ARCH_I386)
 
-HXCOMM Deprecated (ignored)
-DEF("no-kvm-pit", 0, QEMU_OPTION_no_kvm_pit, "", QEMU_ARCH_I386)
-
 HXCOMM Deprecated by -machine kernel_irqchip=on|off property
 DEF("no-kvm-irqchip", 0, QEMU_OPTION_no_kvm_irqchip, "", QEMU_ARCH_I386)
 
diff --git a/vl.c b/vl.c
index e9012bb..d3a5c5d 100644
--- a/vl.c
+++ b/vl.c
@@ -3817,10 +3817,6 @@ int main(int argc, char **argv, char **envp)
                 olist = qemu_find_opts("machine");
                 qemu_opts_parse_noisily(olist, "accel=tcg", false);
                 break;
-            case QEMU_OPTION_no_kvm_pit: {
-                warn_report("ignoring deprecated option");
-                break;
-            }
             case QEMU_OPTION_no_kvm_pit_reinjection: {
                 static GlobalProperty kvm_pit_lost_tick_policy = {
                     .driver   = "kvm-pit",
-- 
1.8.3.1

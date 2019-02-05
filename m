Received: from eggs.gnu.org ([209.51.188.92]:36253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GV-0002Vw-Ij
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5GM-0003ux-7c
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:07 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:37808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5GL-0003tB-QR
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id g67so4751341wmd.2
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:41 +0100
Message-Id: <1549390526-24246-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/76] configure: enable elf2dmp build for
 Windows hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>

After this patch contrib/elf2dmp can be built for Windows x86 and x86_64
hosts by mingw.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Message-Id: <20181220012441.13694-7-viktor.prutyanov@phystech.edu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 4 ++--
 configure | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 76f6ab4..3658310 100644
--- a/Makefile
+++ b/Makefile
@@ -570,8 +570,8 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-elf2dmp: LIBS = $(CURL_LIBS)
-elf2dmp: $(elf2dmp-obj-y)
+elf2dmp$(EXESUF): LIBS += $(CURL_LIBS)
+elf2dmp$(EXESUF): $(elf2dmp-obj-y)
 	$(call LINK, $^)
 
 ifdef CONFIG_IVSHMEM
diff --git a/configure b/configure
index f6a51e0..244bc7a 100755
--- a/configure
+++ b/configure
@@ -5790,8 +5790,8 @@ if test "$want_tools" = "yes" ; then
   if [ "$ivshmem" = "yes" ]; then
     tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
   fi
-  if [ "$posix" = "yes" ] && [ "$curl" = "yes" ]; then
-    tools="elf2dmp $tools"
+  if [ "$curl" = "yes" ]; then
+      tools="elf2dmp\$(EXESUF) $tools"
   fi
 fi
 if test "$softmmu" = yes ; then
-- 
1.8.3.1

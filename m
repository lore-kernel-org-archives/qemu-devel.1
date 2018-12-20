Received: from eggs.gnu.org ([2001:4830:134:3::10]:46542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5S-0005le-1G
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <viktor.prutyanov@phystech.edu>) id 1gZn5O-0002rU-IL
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:16 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <viktor.prutyanov@phystech.edu>)
	id 1gZn5M-0002nK-JV
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 20:25:14 -0500
Received: by mail-lf1-x141.google.com with SMTP id y11so65832lfj.4
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 17:25:12 -0800 (PST)
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Date: Thu, 20 Dec 2018 04:24:41 +0300
Message-Id: <20181220012441.13694-7-viktor.prutyanov@phystech.edu>
In-Reply-To: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
References: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
Subject: [Qemu-devel] [PATCH v2 6/6] configure: enable elf2dmp build for
 Windows hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkagan@virtuozzo.com
Cc: eblake@redhat.com, qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>

After this patch contrib/elf2dmp can be built for Windows x86 and x86_64
hosts by mingw.

Signed-off-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
---
 Makefile  | 4 ++--
 configure | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index c8b9efdad4..25acb94aa6 100644
--- a/Makefile
+++ b/Makefile
@@ -565,8 +565,8 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-elf2dmp: LIBS = $(CURL_LIBS)
-elf2dmp: $(elf2dmp-obj-y)
+elf2dmp$(EXESUF): LIBS += $(CURL_LIBS)
+elf2dmp$(EXESUF): $(elf2dmp-obj-y)
 	$(call LINK, $^)
 
 ifdef CONFIG_IVSHMEM
diff --git a/configure b/configure
index 224d3071ac..686ae2e093 100755
--- a/configure
+++ b/configure
@@ -5753,8 +5753,8 @@ if test "$want_tools" = "yes" ; then
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
2.17.2

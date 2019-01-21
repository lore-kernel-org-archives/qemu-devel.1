Received: from eggs.gnu.org ([209.51.188.92]:52054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyT-0004hn-Ov
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyT-0004aS-1t
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:05 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:34852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyS-0004Z8-QK
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:04 -0500
Received: by mail-wm1-x335.google.com with SMTP id t200so11807624wmt.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:07:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:06:12 +0100
Message-Id: <1548093980-43088-42-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 41/49] configure: enable elf2dmp build for
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
index 6de3a38..145a516 100644
--- a/Makefile
+++ b/Makefile
@@ -567,8 +567,8 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-elf2dmp: LIBS = $(CURL_LIBS)
-elf2dmp: $(elf2dmp-obj-y)
+elf2dmp$(EXESUF): LIBS += $(CURL_LIBS)
+elf2dmp$(EXESUF): $(elf2dmp-obj-y)
 	$(call LINK, $^)
 
 ifdef CONFIG_IVSHMEM
diff --git a/configure b/configure
index 6a4d23c..b723dca 100755
--- a/configure
+++ b/configure
@@ -5797,8 +5797,8 @@ if test "$want_tools" = "yes" ; then
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

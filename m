Received: from eggs.gnu.org ([2001:4830:134:3::10]:45664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkc-0008Dy-PC
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:41:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMka-0004qU-3d
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:51687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRMkZ-0004oc-Ri
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:55 -0500
Received: by mail-wm1-x331.google.com with SMTP id j207so12412606wmj.1
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:40:55 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Nov 2018 20:40:33 +0100
Message-Id: <1543261235-2834-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
References: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/15] configure: fix elf2dmp check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

elf2dmp is keyed on "$posix" = "yes", but "$posix" doesn't seem to be
set anywhere.

The original intent was presumably to skip building it on Windows, so
check for "$mingw32" = "no" instead.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20181123090058.6931-1-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 0a3c6a7..fc6ce00 100755
--- a/configure
+++ b/configure
@@ -5722,7 +5722,7 @@ if test "$want_tools" = "yes" ; then
   if [ "$ivshmem" = "yes" ]; then
     tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
   fi
-  if [ "$posix" = "yes" ] && [ "$curl" = "yes" ]; then
+  if [ "$mingw32" = "no" ] && [ "$curl" = "yes" ]; then
     tools="elf2dmp $tools"
   fi
 fi
-- 
1.8.3.1

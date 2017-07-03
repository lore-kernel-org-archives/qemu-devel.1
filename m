Received: from eggs.gnu.org ([2001:4830:134:3::10]:51861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4Kd-00015N-Cp
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dS4Kc-0008HZ-96
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:36:15 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:32838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dS4Kc-0008HE-2d
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:36:14 -0400
Received: by mail-wm0-x242.google.com with SMTP id j85so21516379wmj.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 09:36:13 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Jul 2017 18:34:53 +0200
Message-Id: <1499099693-22903-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 22/22] configure: warn on untested --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

--disable-tcg will almost certainly fail to compile on non-x86 platforms,
so issue a warning.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure b/configure
index cc8f5e3..a3a21d5 100755
--- a/configure
+++ b/configure
@@ -1766,6 +1766,13 @@ if test "$solaris" = "yes" ; then
   fi
 fi
 
+if test "$tcg" = no; then
+    case "$cpu" in
+        i386 | x86_64) ;;
+        *) echo "WARNING: --disable-tcg not supported on this host, compilation may fail" ;;
+    esac
+fi
+
 if test -z "${target_list+xxx}" ; then
     for target in $default_target_list; do
         supported_target $target 2>/dev/null && \
-- 
1.8.3.1

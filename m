Received: from eggs.gnu.org ([2001:4830:134:3::10]:35844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlR-00072X-Mq
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSLlN-00023i-KQ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:13:05 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSLlN-00022y-Df
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:13:01 -0400
Received: by mail-wm0-x244.google.com with SMTP id p204so25633069wmg.1
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 04:13:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  4 Jul 2017 13:12:15 +0200
Message-Id: <1499166735-39360-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure b/configure
index 806658c..3109836 100755
--- a/configure
+++ b/configure
@@ -1771,6 +1771,13 @@ if test "$solaris" = "yes" ; then
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

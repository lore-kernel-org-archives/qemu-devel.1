Received: from eggs.gnu.org ([2001:4830:134:3::10]:58768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpHC-0000f4-6T
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzpH8-0002g4-DM
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52141)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzpH7-0002Xz-Lq
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 16:28:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Sep 2018 16:28:23 -0400
Message-Id: <20180911202823.21657-14-cota@braap.org>
In-Reply-To: <20180911202823.21657-1-cota@braap.org>
References: <20180911202823.21657-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 13/13] configure: enable mttcg for i386 and
 x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index 58862d2ae8..f715252c9f 100755
--- a/configure
+++ b/configure
@@ -7025,12 +7025,14 @@ TARGET_ABI_DIR=""
 
 case "$target_name" in
   i386)
+    mttcg="yes"
     gdb_xml_files="i386-32bit.xml i386-32bit-core.xml i386-32bit-sse.xml"
     target_compiler=$cross_cc_i386
     target_compiler_cflags=$cross_cc_ccflags_i386
   ;;
   x86_64)
     TARGET_BASE_ARCH=i386
+    mttcg="yes"
     gdb_xml_files="i386-64bit.xml i386-64bit-core.xml i386-64bit-sse.xml"
     target_compiler=$cross_cc_x86_64
   ;;
-- 
2.17.1

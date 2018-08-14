Received: from eggs.gnu.org ([2001:4830:134:3::10]:33910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpOHm-0006H6-QW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpOHj-0002Gf-Og
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45481)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpOHj-0002G6-KW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 21:38:01 -0400
Message-Id: <20180814013801.26036-5-cota@braap.org>
In-Reply-To: <20180814013801.26036-1-cota@braap.org>
References: <20180814013801.26036-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 4/4] configure: enable mttcg for x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 2a7796ea80..db216bafb1 100755
--- a/configure
+++ b/configure
@@ -6935,6 +6935,7 @@ case "$target_name" in
     TARGET_BASE_ARCH=i386
     gdb_xml_files="i386-64bit.xml i386-64bit-core.xml i386-64bit-sse.xml"
     target_compiler=$cross_cc_x86_64
+    mttcg="yes"
   ;;
   alpha)
     mttcg="yes"
-- 
2.17.1

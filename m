Received: from eggs.gnu.org ([2001:4830:134:3::10]:34031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1ds3cM-0001Vg-Vh
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1ds3cL-0007Va-SH
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:05:58 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:35037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1ds3cL-0007VJ-OU
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:05:57 -0400
Received: by mail-vk0-x242.google.com with SMTP id t10so3326448vke.2
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 02:05:57 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Wed, 13 Sep 2017 04:05:16 -0500
Message-Id: <20170913090522.4022-9-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170913090522.4022-1-Sergio.G.DelReal@gmail.com>
References: <20170913090522.4022-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH v4 08/14] hvf: add compilation rules to
 Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@gmail.com, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

This patch adds to target/i386/Makefile.objs the necessary rules so
that the new files for hvf are compiled by the build system.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 target/i386/Makefile.objs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 6a26e9d9f0..0bef89c099 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -12,4 +12,5 @@ obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-windows.o
 endif
 ifdef CONFIG_DARWIN
 obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-darwin.o
+obj-$(CONFIG_HVF) += hvf-utils/ hvf-all.o
 endif
-- 
2.14.1

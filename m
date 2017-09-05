Received: from eggs.gnu.org ([2001:4830:134:3::10]:41532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dp4xr-0001pD-2n
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1dp4xm-00081I-KO
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:55:51 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:37985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1dp4xm-00080l-FE
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 23:55:46 -0400
Received: by mail-vk0-x243.google.com with SMTP id o22so714500vke.5
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 20:55:46 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Mon,  4 Sep 2017 22:54:51 -0500
Message-Id: <20170905035457.3753-9-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170905035457.3753-1-Sergio.G.DelReal@gmail.com>
References: <20170905035457.3753-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH v3 08/14] hvf: add compilation rules to
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

This commit adds to target/i386/Makefile.objs the necessary rules so
that the new files for hvf are compiled by the build system.
It also adds handling of the -enable-hvf argument in the main function
in vl.c.

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

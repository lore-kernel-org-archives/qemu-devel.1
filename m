Received: from eggs.gnu.org ([2001:4830:134:3::10]:55580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZBKe-0003Xw-4o
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 04:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fZBKc-0001Pz-W4
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 04:34:12 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1fZBKc-0001Ou-PG
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 04:34:10 -0400
Received: by mail-wr0-f193.google.com with SMTP id w16-v6so3123183wrn.5
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 01:34:10 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
Date: Sat, 30 Jun 2018 10:33:57 +0200
Message-Id: <20180630083357.23489-5-huth@tuxfamily.org>
In-Reply-To: <20180630083357.23489-1-huth@tuxfamily.org>
References: <20180630083357.23489-1-huth@tuxfamily.org>
Subject: [Qemu-devel] [PATCH v1 4/4] m68k: Add an entry for the NeXTcube
 machine to the MAINTAINERS file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Bryce Lanham <blanham@gmail.com>, Natalia Portillo <claunia@claunia.com>

I don't have much clue about the NeXT hardware, but at least I know now
the source files a little bit, so I volunteer to pick up patches and send
PULL requests for them until someone else with more knowledge steps up
to do this job instead.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42a1892d6a..7b8c0511a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -693,6 +693,13 @@ F: hw/char/mcf_uart.c
 F: hw/net/mcf_fec.c
 F: include/hw/m68k/mcf*.h
 
+NeXTcube
+M: Thomas Huth <huth@tuxfamily.org>
+S: Odd Fixes
+F: hw/m68k/next-*.c
+F: hw/display/next-fb.c
+F: include/hw/m68k/next-cube.h
+
 MicroBlaze Machines
 -------------------
 petalogix_s3adsp1800
-- 
2.17.1

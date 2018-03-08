Received: from eggs.gnu.org ([2001:4830:134:3::10]:56284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4Ci-0006kZ-Gs
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4Ch-0003sG-Ge
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:04 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:54865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eu4Ch-0003rr-9l
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 17:40:03 -0500
Received: by mail-wm0-x244.google.com with SMTP id z81so689600wmb.4
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 14:40:03 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu,  8 Mar 2018 23:39:25 +0100
Message-Id: <20180308223946.26784-5-f4bug@amsat.org>
In-Reply-To: <20180308223946.26784-1-f4bug@amsat.org>
References: <20180308223946.26784-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 04/25] MAINTAINERS: Fix the PC87312 include path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>

Missed while moving it in 0d09e41a51aa.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6622efc1da..212eaa836a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -765,9 +765,10 @@ F: hw/ppc/prep_systemio.c
 F: hw/ppc/rs6000_mc.c
 F: hw/pci-host/prep.[hc]
 F: hw/isa/i82378.c
-F: hw/isa/pc87312.[hc]
+F: hw/isa/pc87312.c
 F: hw/dma/i82374.c
 F: hw/timer/m48t59-isa.c
+F: include/hw/isa/pc87312.h
 F: include/hw/timer/m48t59.h
 F: pc-bios/ppc_rom.bin
 
-- 
2.16.2

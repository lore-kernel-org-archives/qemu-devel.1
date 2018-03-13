Received: from eggs.gnu.org ([2001:4830:134:3::10]:58158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsiA-0005qS-19
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evsi8-0003UK-Nz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:02 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42349)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evsi8-0003T1-GC
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:48:00 -0400
Received: by mail-wr0-x242.google.com with SMTP id s18so2506167wrg.9
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:48:00 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:40 +0100
Message-Id: <20180313224719.4954-31-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 30/69] MAINTAINERS: Fix the PC87312 include path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Missed while moving it in 0d09e41a51aa.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180308223946.26784-5-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6703ac8c89..1ff22ce610 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -776,9 +776,10 @@ F: hw/ppc/prep_systemio.c
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
2.14.3

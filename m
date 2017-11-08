Received: from eggs.gnu.org ([2001:4830:134:3::10]:51433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG7D-0008VP-KY
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG7C-0005Lg-TS
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:19 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:51970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG7C-0005LX-Ow
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:18 -0500
Received: by mail-qt0-x243.google.com with SMTP id h4so1612812qtk.8
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 18:29:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  7 Nov 2017 23:28:28 -0300
Message-Id: <20171108022828.7242-7-f4bug@amsat.org>
In-Reply-To: <20171108022828.7242-1-f4bug@amsat.org>
References: <20171108022828.7242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 6/6] hw/i386: deprecate the "isapc" machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Deprecated since 2.9.0, guests should be able to use "pc" instead.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/i386/pc_piix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c462b702ff..df4669c6d3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -1114,6 +1114,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->smbios_legacy_mode = true;
     pcmc->has_reserved_memory = false;
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->deprecated_reason = "Use the \"pc\" machine instead";
 }
 
 DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-- 
2.15.0

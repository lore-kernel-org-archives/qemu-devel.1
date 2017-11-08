Received: from eggs.gnu.org ([2001:4830:134:3::10]:51374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG75-0008Qf-IL
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCG74-0005JI-UZ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 21:29:11 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  7 Nov 2017 23:28:26 -0300
Message-Id: <20171108022828.7242-5-f4bug@amsat.org>
In-Reply-To: <20171108022828.7242-1-f4bug@amsat.org>
References: <20171108022828.7242-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 4/6] hw/ppc: deprecate the PReP machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

It is obsoleted by the "40p" machine.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/ppc/prep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 6f8accc397..c032ec3af1 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -682,6 +682,7 @@ static void prep_machine_init(MachineClass *mc)
     mc->max_cpus = MAX_CPUS;
     mc->default_boot_order = "cad";
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("602");
+    mc->deprecated_reason = "Obsoleted by the \"40p\" machine";
 }
 
 static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
-- 
2.15.0

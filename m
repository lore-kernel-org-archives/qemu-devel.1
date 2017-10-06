Received: from eggs.gnu.org ([2001:4830:134:3::10]:41417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPT-00081H-7M
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cPQ-0005VL-4Q
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:52:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:20 -0300
Message-Id: <20171006235023.11952-26-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 25/88] OpenRISC: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: squashed openrisc_sim.c]
---
 hw/openrisc/openrisc_sim.c | 2 +-
 target/openrisc/mmu.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 86bf2849c4..1eb381549c 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -114,7 +114,7 @@ static void openrisc_sim_init(MachineState *machine)
         main_cpu_reset(cpu);
     }
 
-    ram = g_malloc(sizeof(*ram));
+    ram = g_new(MemoryRegion, 1);
     memory_region_init_ram(ram, NULL, "openrisc.ram", ram_size, &error_fatal);
     memory_region_add_subregion(get_system_memory(), 0, ram);
 
diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index ce2a29dd1a..4789a35b67 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -247,7 +247,7 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
 void cpu_openrisc_mmu_init(OpenRISCCPU *cpu)
 {
-    cpu->env.tlb = g_malloc0(sizeof(CPUOpenRISCTLBContext));
+    cpu->env.tlb = g_new0(CPUOpenRISCTLBContext, 1);
 
     cpu->env.tlb->cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
     cpu->env.tlb->cpu_openrisc_map_address_data = &cpu_openrisc_get_phys_nommu;
-- 
2.14.2

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOR-0006wS-2Y
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOO-0004nI-0n
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:50:59 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:01 -0300
Message-Id: <20171006235023.11952-7-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/88] ARM: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: added hw/arm/virt-acpi-build.c and target/arm/helper.c]
---
 hw/arm/virt-acpi-build.c | 2 +-
 hw/timer/arm_timer.c     | 2 +-
 target/arm/helper.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3d78ff68e6..812c3c3f5b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -869,7 +869,7 @@ void virt_acpi_setup(VirtMachineState *vms)
         return;
     }
 
-    build_state = g_malloc0(sizeof *build_state);
+    build_state = g_new0(AcpiBuildState, 1);
 
     acpi_build_tables_init(&tables);
     virt_acpi_build(vms, &tables);
diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 98fddd7ac1..75affcb8a6 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -166,7 +166,7 @@ static arm_timer_state *arm_timer_init(uint32_t freq)
     arm_timer_state *s;
     QEMUBH *bh;
 
-    s = (arm_timer_state *)g_malloc0(sizeof(arm_timer_state));
+    s = g_new0(arm_timer_state, 1);
     s->freq = freq;
     s->control = TIMER_CTRL_IE;
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1d689f00b3..b320772cc6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5333,12 +5333,12 @@ static void arm_cpu_add_definition(gpointer data, gpointer user_data)
     const char *typename;
 
     typename = object_class_get_name(oc);
-    info = g_malloc0(sizeof(*info));
+    info = g_new0(CpuDefinitionInfo, 1);
     info->name = g_strndup(typename,
                            strlen(typename) - strlen("-" TYPE_ARM_CPU));
     info->q_typename = g_strdup(typename);
 
-    entry = g_malloc0(sizeof(*entry));
+    entry = g_new0(CpuDefinitionInfoList, 1);
     entry->value = info;
     entry->next = *cpu_list;
     *cpu_list = entry;
-- 
2.14.2

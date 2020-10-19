Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11672C43457
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E062222C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E062222C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpXh-0006aY-EU
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQx-00067S-LH; Tue, 20 Oct 2020 07:04:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38960 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ganqixin@huawei.com>)
 id 1kUpQv-0006oj-FT; Tue, 20 Oct 2020 07:04:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id ACACA193F93C4181BED7;
 Tue, 20 Oct 2020 19:03:49 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 19:03:39 +0800
From: Gan Qixin <ganqixin@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH 02/10] hw/core/:split some lines containing more than 80
 characters
Date: Tue, 20 Oct 2020 04:30:15 +0800
Message-ID: <20201019203023.658555-3-ganqixin@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201019203023.658555-1-ganqixin@huawei.com>
References: <20201019203023.658555-1-ganqixin@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=ganqixin@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:03:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, f4bug@amsat.org,
 alistair.francis@wdc.com, Gan Qixin <ganqixin@huawei.com>,
 kuhn.chenqun@huawei.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

By using scripts/checkpatch.pl, it is found that many files in hw/core/
contain lines with more than 80 characters.

Signed-off-by: Gan Qixin <ganqixin@huawei.com>
---
 hw/core/bus.c                    |  3 ++-
 hw/core/loader.c                 | 17 +++++++++++------
 hw/core/machine-hmp-cmds.c       |  6 ++++--
 hw/core/machine.c                |  3 ++-
 hw/core/qdev-properties-system.c |  4 ++--
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index a0483859ae..9b2dc7e25c 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -158,7 +158,8 @@ void qbus_create_inplace(void *bus, size_t size, const char *typename,
     qbus_init(bus, parent, name);
 }
 
-BusState *qbus_create(const char *typename, DeviceState *parent, const char *name)
+BusState *qbus_create(const char *typename, DeviceState *parent,
+                      const char *name)
 {
     BusState *bus;
 
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 8bbb1797a4..50839d93e3 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -211,14 +211,18 @@ static void bswap_ahdr(struct exec *e)
 #define N_TXTOFF(x)							\
     (N_MAGIC(x) == ZMAGIC ? _N_HDROFF((x)) + sizeof (struct exec) :	\
      (N_MAGIC(x) == QMAGIC ? 0 : sizeof (struct exec)))
-#define N_TXTADDR(x, target_page_size) (N_MAGIC(x) == QMAGIC ? target_page_size : 0)
-#define _N_SEGMENT_ROUND(x, target_page_size) (((x) + target_page_size - 1) & ~(target_page_size - 1))
+#define N_TXTADDR(x, target_page_size) \
+    (N_MAGIC(x) == QMAGIC ? target_page_size : 0)
+#define _N_SEGMENT_ROUND(x, target_page_size) \
+    (((x) + target_page_size - 1) & ~(target_page_size - 1))
 
-#define _N_TXTENDADDR(x, target_page_size) (N_TXTADDR(x, target_page_size)+(x).a_text)
+#define _N_TXTENDADDR(x, target_page_size) \
+    (N_TXTADDR(x, target_page_size) + (x).a_text)
 
 #define N_DATADDR(x, target_page_size) \
-    (N_MAGIC(x)==OMAGIC? (_N_TXTENDADDR(x, target_page_size)) \
-     : (_N_SEGMENT_ROUND (_N_TXTENDADDR(x, target_page_size), target_page_size)))
+    (N_MAGIC(x) == OMAGIC ? (_N_TXTENDADDR(x, target_page_size)) \
+     : (_N_SEGMENT_ROUND(_N_TXTENDADDR(x, target_page_size), \
+    target_page_size)))
 
 
 int load_aout(const char *filename, hwaddr addr, int max_sz,
@@ -1190,7 +1194,8 @@ int rom_check_and_register_reset(void)
         }
         section = memory_region_find(rom->mr ? rom->mr : get_system_memory(),
                                      rom->addr, 1);
-        rom->isrom = int128_nz(section.size) && memory_region_is_rom(section.mr);
+        rom->isrom = int128_nz(section.size)
+                     && memory_region_is_rom(section.mr);
         memory_region_unref(section.mr);
     }
     qemu_register_reset(rom_reset, NULL);
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 6357be9c6b..65280d53bc 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -73,7 +73,8 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "    node-id: \"%" PRIu64 "\"\n", c->node_id);
         }
         if (c->has_socket_id) {
-            monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c->socket_id);
+            monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n",
+                           c->socket_id);
         }
         if (c->has_die_id) {
             monitor_printf(mon, "    die-id: \"%" PRIu64 "\"\n", c->die_id);
@@ -82,7 +83,8 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->core_id);
         }
         if (c->has_thread_id) {
-            monitor_printf(mon, "    thread-id: \"%" PRIu64 "\"\n", c->thread_id);
+            monitor_printf(mon, "    thread-id: \"%" PRIu64 "\"\n",
+                           c->thread_id);
         }
 
         l = l->next;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7e2f4ec08e..055473c23a 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -317,7 +317,8 @@ static char *machine_get_dt_compatible(Object *obj, Error **errp)
     return g_strdup(ms->dt_compatible);
 }
 
-static void machine_set_dt_compatible(Object *obj, const char *value, Error **errp)
+static void machine_set_dt_compatible(Object *obj,
+                                      const char *value, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
 
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 49bdd12581..c4f7170a06 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -418,8 +418,8 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
     }
 
     if (queues > MAX_QUEUE_NUM) {
-        error_setg(errp, "queues of backend '%s'(%d) exceeds QEMU limitation(%d)",
-                   str, queues, MAX_QUEUE_NUM);
+        error_setg(errp, "queues of backend '%s'(%d) exceeds"
+                   "QEMU limitation(%d)", str, queues, MAX_QUEUE_NUM);
         goto out;
     }
 
-- 
2.23.0



Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C919AC388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 04:14:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25AB022245
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 04:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25AB022245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZnhu-0005hX-U0
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 23:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaihaoyu1@huawei.com>)
 id 1kZnh0-0004xo-M9
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 23:13:10 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:2069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaihaoyu1@huawei.com>)
 id 1kZngx-0000ZC-Sb
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 23:13:10 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CQGbc2qN7zhg5p;
 Tue,  3 Nov 2020 12:13:00 +0800 (CST)
Received: from [10.108.235.54] (10.108.235.54) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 12:12:50 +0800
Subject: [PATCH v2 3/3] softmmu: braces {} are necessary for all arms of this
 statement
References: <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com>
To: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>
From: chaihaoyu <chaihaoyu1@huawei.com>
X-Forwarded-Message-Id: <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com>
Message-ID: <194a5b5d-0d9d-21d6-6206-8588cc93282d@huawei.com>
Date: Tue, 3 Nov 2020 12:12:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <edcc3e56-2419-8645-8639-d9e50d710a1d@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.235.54]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=chaihaoyu1@huawei.com;
 helo=szxga06-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 22:10:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alex.chen@huawei.com, hunongda@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, recently I found some code style problems while using checkpatch.pl tool,please review.

Date: Tue, 3 Nov 2020 10:09:34 +0800
Subject: [PATCH] braces {} are necessary for all arms of this statement
signed-off-by: Haoyu Chai<chaihaoyu1@huawei.com>
---
---
 softmmu/cpus.c         |  6 ++++--
 softmmu/dma-helpers.c  |  3 ++-
 softmmu/memory.c       |  3 ++-
 softmmu/physmem.c      | 15 ++++++++-----
 softmmu/qdev-monitor.c | 15 +++++++------
 softmmu/vl.c           | 49 +++++++++++++++++++++++++++---------------
 6 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index e46ac68ad0..3e08a64d6b 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -743,8 +743,9 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,

     while (size != 0) {
         l = sizeof(buf);
-        if (l > size)
+        if (l > size) {
             l = size;
+        }
         if (cpu_memory_rw_debug(cpu, addr, buf, l, 0) != 0) {
             error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId64
                              " specified", orig_addr, orig_size);
@@ -777,8 +778,9 @@ void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,

     while (size != 0) {
         l = sizeof(buf);
-        if (l > size)
+        if (l > size) {
             l = size;
+        }
         cpu_physical_memory_read(addr, buf, l);
         if (fwrite(buf, 1, l, f) != l) {
             error_setg(errp, QERR_IO_ERROR);
diff --git a/softmmu/dma-helpers.c b/softmmu/dma-helpers.c
index 03c92e0cc6..9194ebf681 100644
--- a/softmmu/dma-helpers.c
+++ b/softmmu/dma-helpers.c
@@ -164,8 +164,9 @@ static void dma_blk_cb(void *opaque, int ret)
                 }
             }
         }
-        if (!mem)
+        if (!mem) {
             break;
+        }
         qemu_iovec_add(&dbs->iov, mem, cur_len);
         dbs->sg_cur_byte += cur_len;
         if (dbs->sg_cur_byte == dbs->sg->sg[dbs->sg_cur_index].len) {
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 550cffe8f6..107ce0a4f8 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -664,8 +664,9 @@ void flatview_for_each_range(FlatView *fv, flatview_cb cb , void *opaque)
     assert(cb);

     FOR_EACH_FLAT_RANGE(fr, fv) {
-        if (cb(fr->addr.start, fr->addr.size, fr->mr, opaque))
+        if (cb(fr->addr.start, fr->addr.size, fr->mr, opaque)) {
             break;
+        }
     }
 }

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index a9adedb9f8..44ffb60b5d 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -797,8 +797,9 @@ int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
         tlb_flush(cpu);
     }

-    if (watchpoint)
+    if (watchpoint) {
         *watchpoint = wp;
+    }
     return 0;
 }

@@ -1210,8 +1211,9 @@ void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)

 void qemu_flush_coalesced_mmio_buffer(void)
 {
-    if (kvm_enabled())
+    if (kvm_enabled()) {
         kvm_flush_coalesced_mmio_buffer();
+    }
 }

 void qemu_mutex_lock_ramlist(void)
@@ -2495,8 +2497,9 @@ static int subpage_register(subpage_t *mmio, uint32_t start, uint32_t end,
 {
     int idx, eidx;

-    if (start >= TARGET_PAGE_SIZE || end >= TARGET_PAGE_SIZE)
+    if (start >= TARGET_PAGE_SIZE || end >= TARGET_PAGE_SIZE) {
         return -1;
+    }
     idx = SUBPAGE_IDX(start);
     eidx = SUBPAGE_IDX(end);
 #if defined(DEBUG_SUBPAGE)
@@ -3408,11 +3411,13 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
         phys_addr = cpu_get_phys_page_attrs_debug(cpu, page, &attrs);
         asidx = cpu_asidx_from_attrs(cpu, attrs);
         /* if no physical page mapped, return an error */
-        if (phys_addr == -1)
+        if (phys_addr == -1) {
             return -1;
+        }
         l = (page + TARGET_PAGE_SIZE) - addr;
-        if (l > len)
+        if (l > len) {
             l = len;
+        }
         phys_addr += (addr & ~TARGET_PAGE_MASK);
         if (is_write) {
             res = address_space_write_rom(cpu->cpu_ases[asidx].as, phys_addr,
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index bcfb90a08f..e283d9c9c0 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -44,8 +44,7 @@
  * Aliases were a bad idea from the start.  Let's keep them
  * from spreading further.
  */
-typedef struct QDevAlias
-{
+typedef struct QDevAlias {
     const char *typename;
     const char *alias;
     uint32_t arch_mask;
@@ -180,10 +179,12 @@ static int set_property(void *opaque, const char *name, const char *value,
 {
     Object *obj = opaque;

-    if (strcmp(name, "driver") == 0)
+    if (strcmp(name, "driver") == 0) {
         return 0;
-    if (strcmp(name, "bus") == 0)
+    }
+    if (strcmp(name, "bus") == 0) {
         return 0;
+    }

     if (!object_property_parse(obj, name, value, errp)) {
         return -1;
@@ -694,8 +695,9 @@ static void qbus_print(Monitor *mon, BusState *bus, int indent);
 static void qdev_print_props(Monitor *mon, DeviceState *dev, Property *props,
                              int indent)
 {
-    if (!props)
+    if (!props) {
         return;
+    }
     for (; props->name; props++) {
         char *value;
         char *legacy_name = g_strdup_printf("legacy-%s", props->name);
@@ -780,8 +782,9 @@ static void qbus_print(Monitor *mon, BusState *bus, int indent)

 void hmp_info_qtree(Monitor *mon, const QDict *qdict)
 {
-    if (sysbus_get_default())
+    if (sysbus_get_default()) {
         qbus_print(mon, sysbus_get_default(), 0);
+    }
 }

 void hmp_info_qdm(Monitor *mon, const QDict *qdict)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 7c1c6d37ef..c4667d91fe 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -533,11 +533,13 @@ static int default_driver_check(void *opaque, QemuOpts *opts, Error **errp)
     const char *driver = qemu_opt_get(opts, "driver");
     int i;

-    if (!driver)
+    if (!driver) {
         return 0;
+    }
     for (i = 0; i < ARRAY_SIZE(default_list); i++) {
-        if (strcmp(default_list[i].driver, driver) != 0)
+        if (strcmp(default_list[i].driver, driver) != 0) {
             continue;
+        }
         *(default_list[i].flag) = 0;
     }
     return 0;
@@ -1138,9 +1140,9 @@ static int usb_device_add(const char *devname)
     }

     dev = usbdevice_create(devname);
-    if (!dev)
+    if (!dev) {
         return -1;
-
+    }
     return 0;
 }

@@ -1845,10 +1847,12 @@ static void select_vgahw(const MachineClass *machine_class, const char *p)

         if (strstart(opts, ",retrace=", &nextopt)) {
             opts = nextopt;
-            if (strstart(opts, "dumb", &nextopt))
+            if (strstart(opts, "dumb", &nextopt)) {
                 vga_retrace_method = VGA_RETRACE_DUMB;
-            else if (strstart(opts, "precise", &nextopt))
+            }
+            else if (strstart(opts, "precise", &nextopt)) {
                 vga_retrace_method = VGA_RETRACE_PRECISE;
+            }
             else goto invalid_vga;
         } else goto invalid_vga;
         opts = nextopt;
@@ -2201,8 +2205,9 @@ static int foreach_device_config(int type, int (*func)(const char *cmdline))
     int rc;

     QTAILQ_FOREACH(conf, &device_configs, next) {
-        if (conf->type != type)
+        if (conf->type != type) {
             continue;
+        }
         loc_push_restore(&conf->loc);
         rc = func(conf->cmdline);
         loc_pop(&conf->loc);
@@ -2218,8 +2223,9 @@ static int serial_parse(const char *devname)
     int index = num_serial_hds;
     char label[32];

-    if (strcmp(devname, "none") == 0)
+    if (strcmp(devname, "none") == 0) {
         return 0;
+    }
     snprintf(label, sizeof(label), "serial%d", index);
     serial_hds = g_renew(Chardev *, serial_hds, index + 1);

@@ -2252,8 +2258,9 @@ static int parallel_parse(const char *devname)
     static int index = 0;
     char label[32];

-    if (strcmp(devname, "none") == 0)
+    if (strcmp(devname, "none") == 0) {
         return 0;
+    }
     if (index == MAX_PARALLEL_PORTS) {
         error_report("too many parallel ports");
         exit(1);
@@ -2407,16 +2414,18 @@ static const QEMUOption *lookup_opt(int argc, char **argv,
     loc_set_cmdline(argv, optind, 1);
     optind++;
     /* Treat --foo the same as -foo.  */
-    if (r[1] == '-')
+    if (r[1] == '-') {
         r++;
+    }
     popt = qemu_options;
     for(;;) {
         if (!popt->name) {
             error_report("invalid option");
             exit(1);
         }
-        if (!strcmp(popt->name, r + 1))
+        if (!strcmp(popt->name, r + 1)) {
             break;
+        }
         popt++;
     }
     if (popt->flags & HAS_ARG) {
@@ -3000,8 +3009,9 @@ void qemu_init(int argc, char **argv, char **envp)
     /* second pass of option parsing */
     optind = 1;
     for(;;) {
-        if (optind >= argc)
+        if (optind >= argc) {
             break;
+        }
         if (argv[optind][0] != '-') {
             loc_set_cmdline(argv, optind, 1);
             drive_add(IF_DEFAULT, 0, argv[optind++], HD_OPTS);
@@ -3047,12 +3057,14 @@ void qemu_init(int argc, char **argv, char **envp)
                 }
                 break;
             case QEMU_OPTION_set:
-                if (qemu_set_option(optarg) != 0)
+                if (qemu_set_option(optarg) != 0) {
                     exit(1);
+                }
                 break;
             case QEMU_OPTION_global:
-                if (qemu_global_option(optarg) != 0)
+                if (qemu_global_option(optarg) != 0) {
                     exit(1);
+                }
                 break;
             case QEMU_OPTION_mtdblock:
                 drive_add(IF_MTD, -1, optarg, MTD_OPTS);
@@ -3258,12 +3270,14 @@ void qemu_init(int argc, char **argv, char **envp)
                         error_report("invalid resolution or depth");
                         exit(1);
                     }
-                    if (*p != 'x')
+                    if (*p != 'x') {
                         goto graphic_error;
+                    }
                     p++;
                     h = strtol(p, (char **)&p, 10);
-                    if (h <= 0)
+                    if (h <= 0) {
                         goto graphic_error;
+                    }
                     if (*p == 'x') {
                         p++;
                         depth = strtol(p, (char **)&p, 10);
@@ -3286,8 +3300,9 @@ void qemu_init(int argc, char **argv, char **envp)
                 {
                     char *r;
                     term_escape_char = strtol(optarg, &r, 0);
-                    if (r == optarg)
+                    if (r == optarg) {
                         printf("Bad argument to echr\n");
+                    }
                     break;
                 }
             case QEMU_OPTION_monitor:
-- 


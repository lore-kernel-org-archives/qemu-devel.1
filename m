Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6A8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074F220684
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lqqpJ81d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074F220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZaI-0008BL-Lj
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9b-0008Nt-Pi
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9Z-0004k4-05
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ9Y-0004jK-M1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94c9X095089;
 Thu, 24 Oct 2019 09:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=XK7s+/O+U8roh3eX64pnG1HxKvK+OEYT+3URSvPIhsE=;
 b=lqqpJ81dRYU4lUzOnKiq1oRS0Odvr8gvJR72dwEHzjUkXcqGkMNZ+vhmqsQcZobxb5r5
 sNpgjzv/OpownSwE7djnJHCBc9rHn3VPa2EJ11Jrt2cnFkgFjdQK3ILMFymOLSNJ3i+q
 iiMYAgolN0BwvDClW4K2ehSokFuYcXrkwOXown2hLLNDXXR7ZxybZ7Z1BO2lgBN4vmqX
 s1J/fYubcdQrguCOtw6vyY16ATkplMIuV8wbIdh4ce/5+ygTTo+ajJJ3a3jbpLeqiWI7
 DygMSRFmc5SWZQRu/QXkwa3aJY5UF72HL8HZQ4CzLJPpAIMLccG2EIrzMjcRKhkzzpOZ Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2vqu4r24ry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98mrj076119;
 Thu, 24 Oct 2019 09:11:27 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3030.oracle.com with ESMTP id 2vtjkj2yyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:27 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9BPHO002581;
 Thu, 24 Oct 2019 09:11:25 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:25 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 36/49] multi-process/mon: enable QMP module support in
 the remote process
Date: Thu, 24 Oct 2019 05:09:17 -0400
Message-Id: <bb38f7b4d7573c3ffc639170c348a8def35a6295.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Build system changes to enable QMP module in the remote process

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v3

 Makefile.objs              |  9 +++++
 Makefile.target            | 34 +++++++++++++++++--
 hmp-commands.hx            |  5 +--
 hw/core/Makefile.objs      |  1 +
 monitor/Makefile.objs      |  3 ++
 monitor/misc.c             | 84 +++++++++++++++++++++++++---------------------
 monitor/monitor-internal.h | 38 +++++++++++++++++++++
 qapi/Makefile.objs         |  2 ++
 qom/Makefile.objs          |  1 +
 ui/Makefile.objs           |  2 ++
 10 files changed, 137 insertions(+), 42 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index c23ccaa..c72db88 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -30,6 +30,7 @@ remote-pci-obj-$(CONFIG_MPQEMU) += backends/
 remote-pci-obj-$(CONFIG_MPQEMU) += block/
 remote-pci-obj-$(CONFIG_MPQEMU) += migration/
 remote-pci-obj-$(CONFIG_MPQEMU) += remote/
+remote-pci-obj-$(CONFIG_MPQEMU) += monitor/
 
 remote-pci-obj-$(CONFIG_MPQEMU) += cpus-common.o
 remote-pci-obj-$(CONFIG_MPQEMU) += dma-helpers.o
@@ -42,6 +43,9 @@ remote-pci-obj-$(CONFIG_MPQEMU) += iothread.o
 # remote-lsi-obj-y is code used to implement remote LSI device
 
 remote-lsi-obj-$(CONFIG_MPQEMU) += hw/
+remote-lsi-obj-$(CONFIG_MPQEMU) += ui/
+
+remote-lsi-obj-$(CONFIG_MPQEMU) += device-hotplug.o
 
 #######################################################################
 # crypto-obj-y is code used by both qemu system emulation and qemu-img
@@ -112,6 +116,11 @@ common-obj-y += vl-parse.o
 common-obj-y += qapi/
 endif
 
+remote-pci-obj-$(CONFIG_MPQEMU) += qapi/
+remote-pci-obj-$(CONFIG_MPQEMU) += blockdev-nbd.o
+remote-pci-obj-$(CONFIG_MPQEMU) += job-qmp.o
+remote-pci-obj-$(CONFIG_MPQEMU) += balloon.o
+
 #######################################################################
 # Target-independent parts used in system and user emulation
 common-obj-y += cpus-common.o
diff --git a/Makefile.target b/Makefile.target
index 0ca40f1..8010998 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -132,13 +132,31 @@ remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/hax-stub.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/whpx-stub.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/vl-stub.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/net-stub.o
-remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/monitor.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/replay.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/xen-mapcache.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/audio.o
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/monitor.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/migration.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/ui-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/gdbstub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/qapi-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/qapi-misc.o
 
 remote-pci-tgt-obj-$(CONFIG_MPQEMU) += remote/memory.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += arch_init.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += monitor/misc.o
+
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-introspect.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands-block-core.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands-block.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands-misc.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands-machine-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-commands-misc-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-visit-machine-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-visit-misc-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-types-machine-target.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += qapi/qapi-types-misc-target.o
 
 #########################################################
 # Linux user emulator target
@@ -191,6 +209,10 @@ endif
 generated-files-y += hmp-commands.h hmp-commands-info.h
 generated-files-y += config-devices.h
 
+ifdef CONFIG_MPQEMU
+generated-files-y += hmp-scsi-commands.h hmp-scsi-commands-info.h
+endif
+
 endif # CONFIG_SOFTMMU
 
 dummy := $(call unnest-vars,,obj-y)
@@ -275,10 +297,18 @@ hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
 hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
 	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
 
+ifdef CONFIG_MPQEMU
+hmp-scsi-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
+	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -tgt scsi < $< > $@)
+
+hmp-scsi-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
+	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -tgt scsi < $< > $@)
+endif
+
 clean: clean-target
 	rm -f *.a *~ $(PROGS)
 	rm -f $(shell find . -name '*.[od]')
-	rm -f hmp-commands.h gdbstub-xml.c
+	rm -f hmp-commands.h gdbstub-xml.c hmp-scsi-commands.h hmp-scsi-commands-info.h
 	rm -f trace/generated-helpers.c trace/generated-helpers.c-timestamp
 ifdef CONFIG_TRACE_SYSTEMTAP
 	rm -f *.stp
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 6d9674b..534f272 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -14,7 +14,8 @@ ETEXI
         .args_type  = "name:S?",
         .params     = "[cmd]",
         .help       = "show the help",
-        .cmd        = do_help_cmd,
+        .cmd        = hmp_do_help_cmd,
+        .targets    = "scsi",
         .flags      = "p",
     },
 
@@ -618,7 +619,7 @@ ETEXI
         .args_type  = "fmt:/,val:l",
         .params     = "/fmt expr",
         .help       = "print expression value (use $reg for CPU register access)",
-        .cmd        = do_print,
+        .cmd        = hmp_do_print,
     },
 
 STEXI
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 9ef6b42..721bc5f 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -44,3 +44,4 @@ remote-pci-obj-$(CONFIG_MPQEMU) += qdev-properties-system.o
 remote-pci-obj-$(CONFIG_MPQEMU) += qdev-fw.o
 remote-pci-obj-$(CONFIG_MPQEMU) += numa.o
 remote-pci-obj-$(CONFIG_MPQEMU) += cpu.o
+remote-pci-obj-$(CONFIG_MPQEMU) += machine-qmp-cmds.o
diff --git a/monitor/Makefile.objs b/monitor/Makefile.objs
index e91a858..11c42ec 100644
--- a/monitor/Makefile.objs
+++ b/monitor/Makefile.objs
@@ -1,3 +1,6 @@
 obj-y += misc.o
 common-obj-y += monitor.o qmp.o hmp.o
 common-obj-y += qmp-cmds.o hmp-cmds.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += monitor.o qmp.o hmp.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qmp-cmds.o hmp-cmds.o
diff --git a/monitor/misc.c b/monitor/misc.c
index aef16f6..400ba06 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -176,12 +176,12 @@ int hmp_compare_cmd(const char *name, const char *list)
     return 0;
 }
 
-static void do_help_cmd(Monitor *mon, const QDict *qdict)
+void hmp_do_help_cmd(Monitor *mon, const QDict *qdict)
 {
     help_cmd(mon, qdict_get_try_str(qdict, "name"));
 }
 
-static void hmp_trace_event(Monitor *mon, const QDict *qdict)
+void hmp_trace_event(Monitor *mon, const QDict *qdict)
 {
     const char *tp_name = qdict_get_str(qdict, "name");
     bool new_state = qdict_get_bool(qdict, "option");
@@ -225,7 +225,7 @@ static void hmp_trace_file(Monitor *mon, const QDict *qdict)
 }
 #endif
 
-static void hmp_info_help(Monitor *mon, const QDict *qdict)
+void hmp_info_help(Monitor *mon, const QDict *qdict)
 {
     help_cmd(mon, "info");
 }
@@ -436,7 +436,7 @@ int monitor_get_cpu_index(void)
     return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
 }
 
-static void hmp_info_registers(Monitor *mon, const QDict *qdict)
+void hmp_info_registers(Monitor *mon, const QDict *qdict)
 {
     bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all", false);
     CPUState *cs;
@@ -459,7 +459,7 @@ static void hmp_info_registers(Monitor *mon, const QDict *qdict)
 }
 
 #ifdef CONFIG_TCG
-static void hmp_info_jit(Monitor *mon, const QDict *qdict)
+void hmp_info_jit(Monitor *mon, const QDict *qdict)
 {
     if (!tcg_enabled()) {
         error_report("JIT information is only available with accel=tcg");
@@ -470,13 +470,13 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
     dump_drift_info();
 }
 
-static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
+void hmp_info_opcount(Monitor *mon, const QDict *qdict)
 {
     dump_opcount_info();
 }
 #endif
 
-static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
+void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
 {
     int64_t max = qdict_get_try_int(qdict, "max", 10);
     bool mean = qdict_get_try_bool(qdict, "mean", false);
@@ -487,7 +487,7 @@ static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
     qsp_report(max, sort_by, coalesce);
 }
 
-static void hmp_info_history(Monitor *mon, const QDict *qdict)
+void hmp_info_history(Monitor *mon, const QDict *qdict)
 {
     MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
     int i;
@@ -507,7 +507,7 @@ static void hmp_info_history(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
+void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
 {
     CPUState *cs = mon_get_cpu();
 
@@ -518,7 +518,7 @@ static void hmp_info_cpustats(Monitor *mon, const QDict *qdict)
     cpu_dump_statistics(cs, 0);
 }
 
-static void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
+void hmp_info_trace_events(Monitor *mon, const QDict *qdict)
 {
     const char *name = qdict_get_try_str(qdict, "name");
     bool has_vcpu = qdict_haskey(qdict, "vcpu");
@@ -578,7 +578,7 @@ void qmp_client_migrate_info(const char *protocol, const char *hostname,
     error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "protocol", "spice");
 }
 
-static void hmp_logfile(Monitor *mon, const QDict *qdict)
+void hmp_logfile(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
@@ -588,7 +588,7 @@ static void hmp_logfile(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_log(Monitor *mon, const QDict *qdict)
+void hmp_log(Monitor *mon, const QDict *qdict)
 {
     int mask;
     const char *items = qdict_get_str(qdict, "items");
@@ -605,7 +605,7 @@ static void hmp_log(Monitor *mon, const QDict *qdict)
     qemu_set_log(mask);
 }
 
-static void hmp_singlestep(Monitor *mon, const QDict *qdict)
+void hmp_singlestep(Monitor *mon, const QDict *qdict)
 {
     const char *option = qdict_get_try_str(qdict, "option");
     if (!option || !strcmp(option, "on")) {
@@ -617,7 +617,7 @@ static void hmp_singlestep(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_gdbserver(Monitor *mon, const QDict *qdict)
+void hmp_gdbserver(Monitor *mon, const QDict *qdict)
 {
     const char *device = qdict_get_try_str(qdict, "device");
     if (!device)
@@ -633,7 +633,7 @@ static void hmp_gdbserver(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
+void hmp_watchdog_action(Monitor *mon, const QDict *qdict)
 {
     const char *action = qdict_get_str(qdict, "action");
     if (select_watchdog_action(action) == -1) {
@@ -775,7 +775,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     }
 }
 
-static void hmp_memory_dump(Monitor *mon, const QDict *qdict)
+void hmp_memory_dump(Monitor *mon, const QDict *qdict)
 {
     int count = qdict_get_int(qdict, "count");
     int format = qdict_get_int(qdict, "format");
@@ -785,7 +785,7 @@ static void hmp_memory_dump(Monitor *mon, const QDict *qdict)
     memory_dump(mon, count, format, size, addr, 0);
 }
 
-static void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
+void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
 {
     int count = qdict_get_int(qdict, "count");
     int format = qdict_get_int(qdict, "format");
@@ -815,7 +815,7 @@ static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
     return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
 }
 
-static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
+void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
 {
     hwaddr addr = qdict_get_int(qdict, "addr");
     Error *local_err = NULL;
@@ -835,7 +835,7 @@ static void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
     memory_region_unref(mr);
 }
 
-static void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
+void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
 {
     target_ulong addr = qdict_get_int(qdict, "addr");
     MemTxAttrs attrs;
@@ -890,7 +890,7 @@ out:
     return ret;
 }
 
-static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
+void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
 {
     hwaddr addr = qdict_get_int(qdict, "addr");
     Error *local_err = NULL;
@@ -917,7 +917,7 @@ static void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
 }
 #endif
 
-static void do_print(Monitor *mon, const QDict *qdict)
+void hmp_do_print(Monitor *mon, const QDict *qdict)
 {
     int format = qdict_get_int(qdict, "format");
     hwaddr val = qdict_get_int(qdict, "val");
@@ -943,7 +943,7 @@ static void do_print(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "\n");
 }
 
-static void hmp_sum(Monitor *mon, const QDict *qdict)
+void hmp_sum(Monitor *mon, const QDict *qdict)
 {
     uint32_t addr;
     uint16_t sum;
@@ -963,7 +963,7 @@ static void hmp_sum(Monitor *mon, const QDict *qdict)
 
 static int mouse_button_state;
 
-static void hmp_mouse_move(Monitor *mon, const QDict *qdict)
+void hmp_mouse_move(Monitor *mon, const QDict *qdict)
 {
     int dx, dy, dz, button;
     const char *dx_str = qdict_get_str(qdict, "dx_str");
@@ -987,7 +987,7 @@ static void hmp_mouse_move(Monitor *mon, const QDict *qdict)
     qemu_input_event_sync();
 }
 
-static void hmp_mouse_button(Monitor *mon, const QDict *qdict)
+void hmp_mouse_button(Monitor *mon, const QDict *qdict)
 {
     static uint32_t bmap[INPUT_BUTTON__MAX] = {
         [INPUT_BUTTON_LEFT]       = MOUSE_EVENT_LBUTTON,
@@ -1004,7 +1004,7 @@ static void hmp_mouse_button(Monitor *mon, const QDict *qdict)
     mouse_button_state = button_state;
 }
 
-static void hmp_ioport_read(Monitor *mon, const QDict *qdict)
+void hmp_ioport_read(Monitor *mon, const QDict *qdict)
 {
     int size = qdict_get_int(qdict, "size");
     int addr = qdict_get_int(qdict, "addr");
@@ -1038,7 +1038,7 @@ static void hmp_ioport_read(Monitor *mon, const QDict *qdict)
                    suffix, addr, size * 2, val);
 }
 
-static void hmp_ioport_write(Monitor *mon, const QDict *qdict)
+void hmp_ioport_write(Monitor *mon, const QDict *qdict)
 {
     int size = qdict_get_int(qdict, "size");
     int addr = qdict_get_int(qdict, "addr");
@@ -1060,7 +1060,7 @@ static void hmp_ioport_write(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_boot_set(Monitor *mon, const QDict *qdict)
+void hmp_boot_set(Monitor *mon, const QDict *qdict)
 {
     Error *local_err = NULL;
     const char *bootdevice = qdict_get_str(qdict, "bootdevice");
@@ -1073,7 +1073,7 @@ static void hmp_boot_set(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
+void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 {
     bool flatview = qdict_get_try_bool(qdict, "flatview", false);
     bool dispatch_tree = qdict_get_try_bool(qdict, "dispatch_tree", false);
@@ -1086,7 +1086,7 @@ static void hmp_info_mtree(Monitor *mon, const QDict *qdict)
 
 int64_t dev_time;
 
-static void hmp_info_profile(Monitor *mon, const QDict *qdict)
+void hmp_info_profile(Monitor *mon, const QDict *qdict)
 {
     static int64_t last_cpu_exec_time;
     int64_t cpu_exec_time;
@@ -1103,7 +1103,7 @@ static void hmp_info_profile(Monitor *mon, const QDict *qdict)
     dev_time = 0;
 }
 #else
-static void hmp_info_profile(Monitor *mon, const QDict *qdict)
+void hmp_info_profile(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "Internal profiler not compiled\n");
 }
@@ -1112,7 +1112,7 @@ static void hmp_info_profile(Monitor *mon, const QDict *qdict)
 /* Capture support */
 static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
 
-static void hmp_info_capture(Monitor *mon, const QDict *qdict)
+void hmp_info_capture(Monitor *mon, const QDict *qdict)
 {
     int i;
     CaptureState *s;
@@ -1123,7 +1123,7 @@ static void hmp_info_capture(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_stopcapture(Monitor *mon, const QDict *qdict)
+void hmp_stopcapture(Monitor *mon, const QDict *qdict)
 {
     int i;
     int n = qdict_get_int(qdict, "n");
@@ -1139,7 +1139,7 @@ static void hmp_stopcapture(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_wavcapture(Monitor *mon, const QDict *qdict)
+void hmp_wavcapture(Monitor *mon, const QDict *qdict)
 {
     const char *path = qdict_get_str(qdict, "path");
     int freq = qdict_get_try_int(qdict, "freq", 44100);
@@ -1192,7 +1192,7 @@ static void hmp_warn_acl(void)
     warn_acl = true;
 }
 
-static void hmp_acl_show(Monitor *mon, const QDict *qdict)
+void hmp_acl_show(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     QAuthZList *auth = find_auth(mon, aclname);
@@ -1219,7 +1219,7 @@ static void hmp_acl_show(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_acl_reset(Monitor *mon, const QDict *qdict)
+void hmp_acl_reset(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     QAuthZList *auth = find_auth(mon, aclname);
@@ -1236,7 +1236,7 @@ static void hmp_acl_reset(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "acl: removed all rules\n");
 }
 
-static void hmp_acl_policy(Monitor *mon, const QDict *qdict)
+void hmp_acl_policy(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     const char *policy = qdict_get_str(qdict, "policy");
@@ -1277,7 +1277,7 @@ static QAuthZListFormat hmp_acl_get_format(const char *match)
     }
 }
 
-static void hmp_acl_add(Monitor *mon, const QDict *qdict)
+void hmp_acl_add(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     const char *match = qdict_get_str(qdict, "match");
@@ -1330,7 +1330,7 @@ static void hmp_acl_add(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void hmp_acl_remove(Monitor *mon, const QDict *qdict)
+void hmp_acl_remove(Monitor *mon, const QDict *qdict)
 {
     const char *aclname = qdict_get_str(qdict, "aclname");
     const char *match = qdict_get_str(qdict, "match");
@@ -1799,13 +1799,21 @@ int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
 
 /* Please update hmp-commands.hx when adding or changing commands */
 static HMPCommand hmp_info_cmds[] = {
+#if defined(SCSI_PROCESS)
+#include "hmp-scsi-commands-info.h"
+#else
 #include "hmp-commands-info.h"
+#endif
     { NULL, NULL, },
 };
 
 /* hmp_cmds and hmp_info_cmds would be sorted at runtime */
 HMPCommand hmp_cmds[] = {
+#if defined(SCSI_PROCESS)
+#include "hmp-scsi-commands.h"
+#else
 #include "hmp-commands.h"
+#endif
     { NULL, NULL, },
 };
 
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index d78f5ca..6ea7211 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -179,4 +179,42 @@ void help_cmd(Monitor *mon, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
 int hmp_compare_cmd(const char *name, const char *list);
 
+void hmp_do_help_cmd(Monitor *mon, const QDict *qdict);
+void hmp_trace_event(Monitor *mon, const QDict *qdict);
+void hmp_info_help(Monitor *mon, const QDict *qdict);
+void hmp_info_registers(Monitor *mon, const QDict *qdict);
+void hmp_info_jit(Monitor *mon, const QDict *qdict);
+void hmp_info_opcount(Monitor *mon, const QDict *qdict);
+void hmp_info_sync_profile(Monitor *mon, const QDict *qdict);
+void hmp_info_history(Monitor *mon, const QDict *qdict);
+void hmp_info_cpustats(Monitor *mon, const QDict *qdict);
+void hmp_info_trace_events(Monitor *mon, const QDict *qdict);
+void hmp_logfile(Monitor *mon, const QDict *qdict);
+void hmp_log(Monitor *mon, const QDict *qdict);
+void hmp_singlestep(Monitor *mon, const QDict *qdict);
+void hmp_gdbserver(Monitor *mon, const QDict *qdict);
+void hmp_watchdog_action(Monitor *mon, const QDict *qdict);
+void hmp_memory_dump(Monitor *mon, const QDict *qdict);
+void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
+void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
+void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
+void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
+void hmp_do_print(Monitor *mon, const QDict *qdict);
+void hmp_sum(Monitor *mon, const QDict *qdict);
+void hmp_mouse_move(Monitor *mon, const QDict *qdict);
+void hmp_mouse_button(Monitor *mon, const QDict *qdict);
+void hmp_ioport_read(Monitor *mon, const QDict *qdict);
+void hmp_ioport_write(Monitor *mon, const QDict *qdict);
+void hmp_boot_set(Monitor *mon, const QDict *qdict);
+void hmp_info_mtree(Monitor *mon, const QDict *qdict);
+void hmp_info_profile(Monitor *mon, const QDict *qdict);
+void hmp_info_capture(Monitor *mon, const QDict *qdict);
+void hmp_stopcapture(Monitor *mon, const QDict *qdict);
+void hmp_wavcapture(Monitor *mon, const QDict *qdict);
+void hmp_acl_show(Monitor *mon, const QDict *qdict);
+void hmp_acl_reset(Monitor *mon, const QDict *qdict);
+void hmp_acl_policy(Monitor *mon, const QDict *qdict);
+void hmp_acl_add(Monitor *mon, const QDict *qdict);
+void hmp_acl_remove(Monitor *mon, const QDict *qdict);
+
 #endif
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index dd3f5e6..059ad08 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -30,3 +30,5 @@ obj-y += $(QAPI_TARGET_MODULES:%=qapi-events-%.o)
 obj-y += qapi-events.o
 obj-y += $(QAPI_TARGET_MODULES:%=qapi-commands-%.o)
 obj-y += qapi-commands.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += $(QAPI_COMMON_MODULES:%=qapi-commands-%.o)
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index 07e50e5..16603d7 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -5,3 +5,4 @@ common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
 
 remote-pci-obj-$(CONFIG_MPQEMU) += object.o qom-qobject.o container.o
 remote-pci-obj-$(CONFIG_MPQEMU) += object_interfaces.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qom-qmp-cmds.o qom-hmp-cmds.o
diff --git a/ui/Makefile.objs b/ui/Makefile.objs
index e6da6ff..c3ac572 100644
--- a/ui/Makefile.objs
+++ b/ui/Makefile.objs
@@ -68,3 +68,5 @@ console-gl.o-libs += $(OPENGL_LIBS)
 egl-helpers.o-libs += $(OPENGL_LIBS)
 egl-context.o-libs += $(OPENGL_LIBS)
 egl-headless.o-libs += $(OPENGL_LIBS)
+
+remote-lsi-obj-$(CONFIG_MPQEMU) += vnc-stubs.o
-- 
1.8.3.1



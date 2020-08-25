Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2A8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B51AE20782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KwhyJxHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51AE20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAeB1-0005EO-UT
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9u-0003Vq-4B
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49978a6e9=alistair.francis@wdc.com>)
 id 1kAe9r-0002vn-PM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 14:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598381941; x=1629917941;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FvEtUFgro7zZZ3dn5o3TxYssqcFeLNDJRKdLKVfzOuw=;
 b=KwhyJxHXjzgzdbuuas2D7F7ijs3Y28fyS7Ro4G/eABW+SMXreQcjn0dm
 9M1oCtOegcxqS1AoTvxKaTyJBi72JNE8+dQS4Q+3c5D5Asg9CmCJFGdv5
 LC2W+nHnBW+Ewb32krQnYu/EXfRreIoQoBf1mNL2sklkgo+lklZCZVW4U
 /pSpi2DNth5KJXwR1e5xdtOEPmTxjsdmXb3j4vuPkknCfKUTZrlH9qmA1
 vGO2E9H8am62aT6UOL2xqHl0kPuDiNKYTSXQII1rhOYLBa5FcKBkHeJuw
 rq5HEFBfY8pRnKBGmaxo0mVx5m0d/TNFJGYc5yAOJuuKOJ4BoKZK/n0DR g==;
IronPort-SDR: ADh7rtBFORU0dCHTq9b+vJ6zdADN661U6pq8WiVa6AYmL/5ezkgY6PdnYQnHt6YKKnXN0yxgJy
 i7spQ7sFUcdkpc0WZmgpDeZ6DXSxoJ3F0SkY3eqBqRH7ovoJDBi8B8Ej86cZecjodsoI1mm8J4
 gRwYsEc96MiPVy7tJpfwwgwRnfWM9Y7nAGdqBjZkvGCxPwCSyeiCfXSVcr8URkC0g62XMjodSB
 TvnSutnyDlExwUTtazsQOljw/0T4rF+obTQtlkrJJHcJ+940+hr4ioiaStV9WhorOgPvE/aHL4
 pWI=
X-IronPort-AV: E=Sophos;i="5.76,353,1592841600"; d="scan'208";a="150145285"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2020 02:58:55 +0800
IronPort-SDR: gYhh53LLl68VtBK25L7bVhjdRBp9Dlx/PmTsxgIvy9cjQugrrTpycXujKA+xUodexh9sKw1VNP
 ul+KanGFGTIw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 11:46:30 -0700
IronPort-SDR: 2OtJGeI+/bcFUpmDvXmr/wwPrpWMFZ8PHhDylSOFX5O1AIjjsUZYBDOhYl4PhEqPZQs//owfJz
 vfjXT/jsFFIA==
WDCIronportException: Internal
Received: from ind003389.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.125])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Aug 2020 11:58:54 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/18] hw/riscv: Add helpers for RISC-V multi-socket NUMA
 machines
Date: Tue, 25 Aug 2020 11:48:21 -0700
Message-Id: <20200825184836.1282371-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=49978a6e9=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 14:58:53
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Anup Patel <anup.patel@wdc.com>,
 alistair.francis@wdc.com, Atish Patra <atish.patra@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <anup.patel@wdc.com>

We add common helper routines which can be shared by RISC-V
multi-socket NUMA machines.

We have two types of helpers:
1. riscv_socket_xyz() - These helper assist managing multiple
   sockets irrespective whether QEMU NUMA is enabled/disabled
2. riscv_numa_xyz() - These helpers assist in providing
   necessary QEMU machine callbacks for QEMU NUMA emulation

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Message-Id: <20200616032229.766089-4-anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/numa.h | 113 +++++++++++++++++++
 hw/riscv/numa.c         | 242 ++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build    |   1 +
 3 files changed, 356 insertions(+)
 create mode 100644 include/hw/riscv/numa.h
 create mode 100644 hw/riscv/numa.c

diff --git a/include/hw/riscv/numa.h b/include/hw/riscv/numa.h
new file mode 100644
index 0000000000..fcce942cee
--- /dev/null
+++ b/include/hw/riscv/numa.h
@@ -0,0 +1,113 @@
+/*
+ * QEMU RISC-V NUMA Helper
+ *
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef RISCV_NUMA_H
+#define RISCV_NUMA_H
+
+#include "hw/sysbus.h"
+#include "sysemu/numa.h"
+
+/**
+ * riscv_socket_count:
+ * @ms: pointer to machine state
+ *
+ * Returns: number of sockets for a numa system and 1 for a non-numa system
+ */
+int riscv_socket_count(const MachineState *ms);
+
+/**
+ * riscv_socket_first_hartid:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: first hartid for a valid socket and -1 for an invalid socket
+ */
+int riscv_socket_first_hartid(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_last_hartid:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: last hartid for a valid socket and -1 for an invalid socket
+ */
+int riscv_socket_last_hartid(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_hart_count:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: number of harts for a valid socket and -1 for an invalid socket
+ */
+int riscv_socket_hart_count(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_mem_offset:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: offset of ram belonging to given socket
+ */
+uint64_t riscv_socket_mem_offset(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_mem_size:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: size of ram belonging to given socket
+ */
+uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_check_hartids:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Returns: true if hardids belonging to given socket are contiguous else false
+ */
+bool riscv_socket_check_hartids(const MachineState *ms, int socket_id);
+
+/**
+ * riscv_socket_fdt_write_id:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Write NUMA node-id FDT property for given FDT node
+ */
+void riscv_socket_fdt_write_id(const MachineState *ms, void *fdt,
+                               const char *node_name, int socket_id);
+
+/**
+ * riscv_socket_fdt_write_distance_matrix:
+ * @ms: pointer to machine state
+ * @socket_id: socket index
+ *
+ * Write NUMA distance matrix in FDT for given machine
+ */
+void riscv_socket_fdt_write_distance_matrix(const MachineState *ms, void *fdt);
+
+CpuInstanceProperties
+riscv_numa_cpu_index_to_props(MachineState *ms, unsigned cpu_index);
+
+int64_t riscv_numa_get_default_cpu_node_id(const MachineState *ms, int idx);
+
+const CPUArchIdList *riscv_numa_possible_cpu_arch_ids(MachineState *ms);
+
+#endif /* RISCV_NUMA_H */
diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
new file mode 100644
index 0000000000..4f92307102
--- /dev/null
+++ b/hw/riscv/numa.c
@@ -0,0 +1,242 @@
+/*
+ * QEMU RISC-V NUMA Helper
+ *
+ * Copyright (c) 2020 Western Digital Corporation or its affiliates.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "hw/riscv/numa.h"
+#include "sysemu/device_tree.h"
+
+static bool numa_enabled(const MachineState *ms)
+{
+    return (ms->numa_state && ms->numa_state->num_nodes) ? true : false;
+}
+
+int riscv_socket_count(const MachineState *ms)
+{
+    return (numa_enabled(ms)) ? ms->numa_state->num_nodes : 1;
+}
+
+int riscv_socket_first_hartid(const MachineState *ms, int socket_id)
+{
+    int i, first_hartid = ms->smp.cpus;
+
+    if (!numa_enabled(ms)) {
+        return (!socket_id) ? 0 : -1;
+    }
+
+    for (i = 0; i < ms->smp.cpus; i++) {
+        if (ms->possible_cpus->cpus[i].props.node_id != socket_id) {
+            continue;
+        }
+        if (i < first_hartid) {
+            first_hartid = i;
+        }
+    }
+
+    return (first_hartid < ms->smp.cpus) ? first_hartid : -1;
+}
+
+int riscv_socket_last_hartid(const MachineState *ms, int socket_id)
+{
+    int i, last_hartid = -1;
+
+    if (!numa_enabled(ms)) {
+        return (!socket_id) ? ms->smp.cpus - 1 : -1;
+    }
+
+    for (i = 0; i < ms->smp.cpus; i++) {
+        if (ms->possible_cpus->cpus[i].props.node_id != socket_id) {
+            continue;
+        }
+        if (i > last_hartid) {
+            last_hartid = i;
+        }
+    }
+
+    return (last_hartid < ms->smp.cpus) ? last_hartid : -1;
+}
+
+int riscv_socket_hart_count(const MachineState *ms, int socket_id)
+{
+    int first_hartid, last_hartid;
+
+    if (!numa_enabled(ms)) {
+        return (!socket_id) ? ms->smp.cpus : -1;
+    }
+
+    first_hartid = riscv_socket_first_hartid(ms, socket_id);
+    if (first_hartid < 0) {
+        return -1;
+    }
+
+    last_hartid = riscv_socket_last_hartid(ms, socket_id);
+    if (last_hartid < 0) {
+        return -1;
+    }
+
+    if (first_hartid > last_hartid) {
+        return -1;
+    }
+
+    return last_hartid - first_hartid + 1;
+}
+
+bool riscv_socket_check_hartids(const MachineState *ms, int socket_id)
+{
+    int i, first_hartid, last_hartid;
+
+    if (!numa_enabled(ms)) {
+        return (!socket_id) ? true : false;
+    }
+
+    first_hartid = riscv_socket_first_hartid(ms, socket_id);
+    if (first_hartid < 0) {
+        return false;
+    }
+
+    last_hartid = riscv_socket_last_hartid(ms, socket_id);
+    if (last_hartid < 0) {
+        return false;
+    }
+
+    for (i = first_hartid; i <= last_hartid; i++) {
+        if (ms->possible_cpus->cpus[i].props.node_id != socket_id) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+uint64_t riscv_socket_mem_offset(const MachineState *ms, int socket_id)
+{
+    int i;
+    uint64_t mem_offset = 0;
+
+    if (!numa_enabled(ms)) {
+        return 0;
+    }
+
+    for (i = 0; i < ms->numa_state->num_nodes; i++) {
+        if (i == socket_id) {
+            break;
+        }
+        mem_offset += ms->numa_state->nodes[i].node_mem;
+    }
+
+    return (i == socket_id) ? mem_offset : 0;
+}
+
+uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id)
+{
+    if (!numa_enabled(ms)) {
+        return (!socket_id) ? ms->ram_size : 0;
+    }
+
+    return (socket_id < ms->numa_state->num_nodes) ?
+            ms->numa_state->nodes[socket_id].node_mem : 0;
+}
+
+void riscv_socket_fdt_write_id(const MachineState *ms, void *fdt,
+                               const char *node_name, int socket_id)
+{
+    if (numa_enabled(ms)) {
+        qemu_fdt_setprop_cell(fdt, node_name, "numa-node-id", socket_id);
+    }
+}
+
+void riscv_socket_fdt_write_distance_matrix(const MachineState *ms, void *fdt)
+{
+    int i, j, idx;
+    uint32_t *dist_matrix, dist_matrix_size;
+
+    if (numa_enabled(ms) && ms->numa_state->have_numa_distance) {
+        dist_matrix_size = riscv_socket_count(ms) * riscv_socket_count(ms);
+        dist_matrix_size *= (3 * sizeof(uint32_t));
+        dist_matrix = g_malloc0(dist_matrix_size);
+
+        for (i = 0; i < riscv_socket_count(ms); i++) {
+            for (j = 0; j < riscv_socket_count(ms); j++) {
+                idx = (i * riscv_socket_count(ms) + j) * 3;
+                dist_matrix[idx + 0] = cpu_to_be32(i);
+                dist_matrix[idx + 1] = cpu_to_be32(j);
+                dist_matrix[idx + 2] =
+                    cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
+            }
+        }
+
+        qemu_fdt_add_subnode(fdt, "/distance-map");
+        qemu_fdt_setprop_string(fdt, "/distance-map", "compatible",
+                                "numa-distance-map-v1");
+        qemu_fdt_setprop(fdt, "/distance-map", "distance-matrix",
+                         dist_matrix, dist_matrix_size);
+        g_free(dist_matrix);
+    }
+}
+
+CpuInstanceProperties
+riscv_numa_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
+
+    assert(cpu_index < possible_cpus->len);
+    return possible_cpus->cpus[cpu_index].props;
+}
+
+int64_t riscv_numa_get_default_cpu_node_id(const MachineState *ms, int idx)
+{
+    int64_t nidx = 0;
+
+    if (ms->numa_state->num_nodes) {
+        nidx = idx / (ms->smp.cpus / ms->numa_state->num_nodes);
+        if (ms->numa_state->num_nodes <= nidx) {
+            nidx = ms->numa_state->num_nodes - 1;
+        }
+    }
+
+    return nidx;
+}
+
+const CPUArchIdList *riscv_numa_possible_cpu_arch_ids(MachineState *ms)
+{
+    int n;
+    unsigned int max_cpus = ms->smp.max_cpus;
+
+    if (ms->possible_cpus) {
+        assert(ms->possible_cpus->len == max_cpus);
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * max_cpus);
+    ms->possible_cpus->len = max_cpus;
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        ms->possible_cpus->cpus[n].type = ms->cpu_type;
+        ms->possible_cpus->cpus[n].arch_id = n;
+        ms->possible_cpus->cpus[n].props.has_core_id = true;
+        ms->possible_cpus->cpus[n].props.core_id = n;
+    }
+
+    return ms->possible_cpus;
+}
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2de8e5a2fe..25af9db75e 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,5 +1,6 @@
 riscv_ss = ss.source_set()
 riscv_ss.add(files('boot.c'))
+riscv_ss.add(files('numa.c'))
 riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
-- 
2.28.0



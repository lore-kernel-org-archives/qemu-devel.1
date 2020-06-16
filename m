Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC2CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE40820739
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmQUG13Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE40820739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFjQ-0001Bg-48
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jlFiL-0000au-0J; Tue, 16 Jun 2020 13:49:37 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:32962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jlFiI-00071Q-LQ; Tue, 16 Jun 2020 13:49:36 -0400
Received: by mail-il1-x142.google.com with SMTP id z2so2107184ilq.0;
 Tue, 16 Jun 2020 10:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u2gbpPYkUL4lAcNKyeyQcBjORVc/q832ulogqkPN5NA=;
 b=EmQUG13YesW4vtSz5V9UusvidYp2cqhLJ1s9KI+U3Q9cCZlfVPs6KelDUmnTZ7KA/F
 0kOJo7DxS/kiStzqubZMLEBlgL1H16ftZHLi0vdZAEDUnzK9Pk0sjQTVjP7pFZwzUzkc
 TzFFoZyWuFUTg2SqOCFJnaHe8xhqLK1V5mA+eUyIOInnF6UaCF54L5clwBJYEvn+SmME
 SSS0j7DkKsEOAn6IEJxX+aoWvTMm9rZ7pUie0Fq2fTAXAvXcwBFlTZelD2XUMrzHlkdS
 QILwrNjlKcw1/WRhK4rj+PcK3ES770V9bENyxfsLrok0u2+RXOaqt4lyzweYwO0FX8+g
 lZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u2gbpPYkUL4lAcNKyeyQcBjORVc/q832ulogqkPN5NA=;
 b=HPAy1/F46Be7jGWoraWfcpEL3YzQXpeuURZT2FyKpJs/KHWCZbtlNNzT+tKNlsrNHN
 p4Hj07LCmCPRhrajueXkberf8dmeV277QhGloy/NN6VkgAz6lyc2No7YFgSpJFqgEvOP
 Sw9Yrw2ckrY/TKd9ISLB0xjYqTsJCBxmyBwHl7bCljelFjTnWH10nXzWPdioNx1ER7kq
 L3aYByEAUg1mqYg3J4xsIX2dRsqjJwFsnj8JjPciawpSZ38LaspS2FoYLpqsm0M2T7ty
 Lao8QRyKKvpbJ2ChPRTctdqqermTgEBUrmAKm3XmGRPYcmVMu2Z0SUGGmMfkCZITRg2q
 yqnQ==
X-Gm-Message-State: AOAM532n3xiMjMmCeP4pFf/2dj5jq5r0AxXEExkS+TXoT2hv5blotva9
 sS55fi3Frmtb8haZPaCaG4YJWUqFuR6O2wSKafk=
X-Google-Smtp-Source: ABdhPJywzmFY/xjhMi+Do633Dwnk+xrXCjJ8tja6l+MXEJrNYXT8Wk7PVZUcO3YVtKiM3iF4itxOOkbgzEcjXi1gcgo=
X-Received: by 2002:a92:bb45:: with SMTP id w66mr4461640ili.131.1592329773014; 
 Tue, 16 Jun 2020 10:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200616032229.766089-1-anup.patel@wdc.com>
 <20200616032229.766089-4-anup.patel@wdc.com>
In-Reply-To: <20200616032229.766089-4-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2020 10:40:08 -0700
Message-ID: <CAKmqyKOOA-ohB09x_z2M0RLsqb1Jy7FH2UFO+j5Uis8nAF0DmQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] hw/riscv: Add helpers for RISC-V multi-socket NUMA
 machines
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 15, 2020 at 8:25 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> We add common helper routines which can be shared by RISC-V
> multi-socket NUMA machines.
>
> We have two types of helpers:
> 1. riscv_socket_xyz() - These helper assist managing multiple
>    sockets irrespective whether QEMU NUMA is enabled/disabled
> 2. riscv_numa_xyz() - These helpers assist in providing
>    necessary QEMU machine callbacks for QEMU NUMA emulation
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/Makefile.objs  |   1 +
>  hw/riscv/numa.c         | 242 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/riscv/numa.h | 113 +++++++++++++++++++
>  3 files changed, 356 insertions(+)
>  create mode 100644 hw/riscv/numa.c
>  create mode 100644 include/hw/riscv/numa.h
>
> diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> index fc3c6dd7c8..4483e61879 100644
> --- a/hw/riscv/Makefile.objs
> +++ b/hw/riscv/Makefile.objs
> @@ -1,4 +1,5 @@
>  obj-y += boot.o
> +obj-y += numa.o
>  obj-$(CONFIG_SPIKE) += riscv_htif.o
>  obj-$(CONFIG_HART) += riscv_hart.o
>  obj-$(CONFIG_SIFIVE_E) += sifive_e.o
> diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
> new file mode 100644
> index 0000000000..4f92307102
> --- /dev/null
> +++ b/hw/riscv/numa.c
> @@ -0,0 +1,242 @@
> +/*
> + * QEMU RISC-V NUMA Helper
> + *
> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/log.h"
> +#include "qemu/error-report.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/riscv/numa.h"
> +#include "sysemu/device_tree.h"
> +
> +static bool numa_enabled(const MachineState *ms)
> +{
> +    return (ms->numa_state && ms->numa_state->num_nodes) ? true : false;
> +}
> +
> +int riscv_socket_count(const MachineState *ms)
> +{
> +    return (numa_enabled(ms)) ? ms->numa_state->num_nodes : 1;
> +}
> +
> +int riscv_socket_first_hartid(const MachineState *ms, int socket_id)
> +{
> +    int i, first_hartid = ms->smp.cpus;
> +
> +    if (!numa_enabled(ms)) {
> +        return (!socket_id) ? 0 : -1;
> +    }
> +
> +    for (i = 0; i < ms->smp.cpus; i++) {
> +        if (ms->possible_cpus->cpus[i].props.node_id != socket_id) {
> +            continue;
> +        }
> +        if (i < first_hartid) {
> +            first_hartid = i;
> +        }
> +    }
> +
> +    return (first_hartid < ms->smp.cpus) ? first_hartid : -1;
> +}
> +
> +int riscv_socket_last_hartid(const MachineState *ms, int socket_id)
> +{
> +    int i, last_hartid = -1;
> +
> +    if (!numa_enabled(ms)) {
> +        return (!socket_id) ? ms->smp.cpus - 1 : -1;
> +    }
> +
> +    for (i = 0; i < ms->smp.cpus; i++) {
> +        if (ms->possible_cpus->cpus[i].props.node_id != socket_id) {
> +            continue;
> +        }
> +        if (i > last_hartid) {
> +            last_hartid = i;
> +        }
> +    }
> +
> +    return (last_hartid < ms->smp.cpus) ? last_hartid : -1;
> +}
> +
> +int riscv_socket_hart_count(const MachineState *ms, int socket_id)
> +{
> +    int first_hartid, last_hartid;
> +
> +    if (!numa_enabled(ms)) {
> +        return (!socket_id) ? ms->smp.cpus : -1;
> +    }
> +
> +    first_hartid = riscv_socket_first_hartid(ms, socket_id);
> +    if (first_hartid < 0) {
> +        return -1;
> +    }
> +
> +    last_hartid = riscv_socket_last_hartid(ms, socket_id);
> +    if (last_hartid < 0) {
> +        return -1;
> +    }
> +
> +    if (first_hartid > last_hartid) {
> +        return -1;
> +    }
> +
> +    return last_hartid - first_hartid + 1;
> +}
> +
> +bool riscv_socket_check_hartids(const MachineState *ms, int socket_id)
> +{
> +    int i, first_hartid, last_hartid;
> +
> +    if (!numa_enabled(ms)) {
> +        return (!socket_id) ? true : false;
> +    }
> +
> +    first_hartid = riscv_socket_first_hartid(ms, socket_id);
> +    if (first_hartid < 0) {
> +        return false;
> +    }
> +
> +    last_hartid = riscv_socket_last_hartid(ms, socket_id);
> +    if (last_hartid < 0) {
> +        return false;
> +    }
> +
> +    for (i = first_hartid; i <= last_hartid; i++) {
> +        if (ms->possible_cpus->cpus[i].props.node_id != socket_id) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +uint64_t riscv_socket_mem_offset(const MachineState *ms, int socket_id)
> +{
> +    int i;
> +    uint64_t mem_offset = 0;
> +
> +    if (!numa_enabled(ms)) {
> +        return 0;
> +    }
> +
> +    for (i = 0; i < ms->numa_state->num_nodes; i++) {
> +        if (i == socket_id) {
> +            break;
> +        }
> +        mem_offset += ms->numa_state->nodes[i].node_mem;
> +    }
> +
> +    return (i == socket_id) ? mem_offset : 0;
> +}
> +
> +uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id)
> +{
> +    if (!numa_enabled(ms)) {
> +        return (!socket_id) ? ms->ram_size : 0;
> +    }
> +
> +    return (socket_id < ms->numa_state->num_nodes) ?
> +            ms->numa_state->nodes[socket_id].node_mem : 0;
> +}
> +
> +void riscv_socket_fdt_write_id(const MachineState *ms, void *fdt,
> +                               const char *node_name, int socket_id)
> +{
> +    if (numa_enabled(ms)) {
> +        qemu_fdt_setprop_cell(fdt, node_name, "numa-node-id", socket_id);
> +    }
> +}
> +
> +void riscv_socket_fdt_write_distance_matrix(const MachineState *ms, void *fdt)
> +{
> +    int i, j, idx;
> +    uint32_t *dist_matrix, dist_matrix_size;
> +
> +    if (numa_enabled(ms) && ms->numa_state->have_numa_distance) {
> +        dist_matrix_size = riscv_socket_count(ms) * riscv_socket_count(ms);
> +        dist_matrix_size *= (3 * sizeof(uint32_t));
> +        dist_matrix = g_malloc0(dist_matrix_size);
> +
> +        for (i = 0; i < riscv_socket_count(ms); i++) {
> +            for (j = 0; j < riscv_socket_count(ms); j++) {
> +                idx = (i * riscv_socket_count(ms) + j) * 3;
> +                dist_matrix[idx + 0] = cpu_to_be32(i);
> +                dist_matrix[idx + 1] = cpu_to_be32(j);
> +                dist_matrix[idx + 2] =
> +                    cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
> +            }
> +        }
> +
> +        qemu_fdt_add_subnode(fdt, "/distance-map");
> +        qemu_fdt_setprop_string(fdt, "/distance-map", "compatible",
> +                                "numa-distance-map-v1");
> +        qemu_fdt_setprop(fdt, "/distance-map", "distance-matrix",
> +                         dist_matrix, dist_matrix_size);
> +        g_free(dist_matrix);
> +    }
> +}
> +
> +CpuInstanceProperties
> +riscv_numa_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    const CPUArchIdList *possible_cpus = mc->possible_cpu_arch_ids(ms);
> +
> +    assert(cpu_index < possible_cpus->len);
> +    return possible_cpus->cpus[cpu_index].props;
> +}
> +
> +int64_t riscv_numa_get_default_cpu_node_id(const MachineState *ms, int idx)
> +{
> +    int64_t nidx = 0;
> +
> +    if (ms->numa_state->num_nodes) {
> +        nidx = idx / (ms->smp.cpus / ms->numa_state->num_nodes);
> +        if (ms->numa_state->num_nodes <= nidx) {
> +            nidx = ms->numa_state->num_nodes - 1;
> +        }
> +    }
> +
> +    return nidx;
> +}
> +
> +const CPUArchIdList *riscv_numa_possible_cpu_arch_ids(MachineState *ms)
> +{
> +    int n;
> +    unsigned int max_cpus = ms->smp.max_cpus;
> +
> +    if (ms->possible_cpus) {
> +        assert(ms->possible_cpus->len == max_cpus);
> +        return ms->possible_cpus;
> +    }
> +
> +    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
> +                                  sizeof(CPUArchId) * max_cpus);
> +    ms->possible_cpus->len = max_cpus;
> +    for (n = 0; n < ms->possible_cpus->len; n++) {
> +        ms->possible_cpus->cpus[n].type = ms->cpu_type;
> +        ms->possible_cpus->cpus[n].arch_id = n;
> +        ms->possible_cpus->cpus[n].props.has_core_id = true;
> +        ms->possible_cpus->cpus[n].props.core_id = n;
> +    }
> +
> +    return ms->possible_cpus;
> +}
> diff --git a/include/hw/riscv/numa.h b/include/hw/riscv/numa.h
> new file mode 100644
> index 0000000000..fcce942cee
> --- /dev/null
> +++ b/include/hw/riscv/numa.h
> @@ -0,0 +1,113 @@
> +/*
> + * QEMU RISC-V NUMA Helper
> + *
> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2 or later, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef RISCV_NUMA_H
> +#define RISCV_NUMA_H
> +
> +#include "hw/sysbus.h"
> +#include "sysemu/numa.h"
> +
> +/**
> + * riscv_socket_count:
> + * @ms: pointer to machine state
> + *
> + * Returns: number of sockets for a numa system and 1 for a non-numa system
> + */
> +int riscv_socket_count(const MachineState *ms);
> +
> +/**
> + * riscv_socket_first_hartid:
> + * @ms: pointer to machine state
> + * @socket_id: socket index
> + *
> + * Returns: first hartid for a valid socket and -1 for an invalid socket
> + */
> +int riscv_socket_first_hartid(const MachineState *ms, int socket_id);
> +
> +/**
> + * riscv_socket_last_hartid:
> + * @ms: pointer to machine state
> + * @socket_id: socket index
> + *
> + * Returns: last hartid for a valid socket and -1 for an invalid socket
> + */
> +int riscv_socket_last_hartid(const MachineState *ms, int socket_id);
> +
> +/**
> + * riscv_socket_hart_count:
> + * @ms: pointer to machine state
> + * @socket_id: socket index
> + *
> + * Returns: number of harts for a valid socket and -1 for an invalid socket
> + */
> +int riscv_socket_hart_count(const MachineState *ms, int socket_id);
> +
> +/**
> + * riscv_socket_mem_offset:
> + * @ms: pointer to machine state
> + * @socket_id: socket index
> + *
> + * Returns: offset of ram belonging to given socket
> + */
> +uint64_t riscv_socket_mem_offset(const MachineState *ms, int socket_id);
> +
> +/**
> + * riscv_socket_mem_size:
> + * @ms: pointer to machine state
> + * @socket_id: socket index
> + *
> + * Returns: size of ram belonging to given socket
> + */
> +uint64_t riscv_socket_mem_size(const MachineState *ms, int socket_id);
> +
> +/**
> + * riscv_socket_check_hartids:
> + * @ms: pointer to machine state
> + * @socket_id: socket index
> + *
> + * Returns: true if hardids belonging to given socket are contiguous else false
> + */
> +bool riscv_socket_check_hartids(const MachineState *ms, int socket_id);
> +
> +/**
> + * riscv_socket_fdt_write_id:
> + * @ms: pointer to machine state
> + * @socket_id: socket index
> + *
> + * Write NUMA node-id FDT property for given FDT node
> + */
> +void riscv_socket_fdt_write_id(const MachineState *ms, void *fdt,
> +                               const char *node_name, int socket_id);
> +
> +/**
> + * riscv_socket_fdt_write_distance_matrix:
> + * @ms: pointer to machine state
> + * @socket_id: socket index
> + *
> + * Write NUMA distance matrix in FDT for given machine
> + */
> +void riscv_socket_fdt_write_distance_matrix(const MachineState *ms, void *fdt);
> +
> +CpuInstanceProperties
> +riscv_numa_cpu_index_to_props(MachineState *ms, unsigned cpu_index);
> +
> +int64_t riscv_numa_get_default_cpu_node_id(const MachineState *ms, int idx);
> +
> +const CPUArchIdList *riscv_numa_possible_cpu_arch_ids(MachineState *ms);
> +
> +#endif /* RISCV_NUMA_H */
> --
> 2.25.1
>
>


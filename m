Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913B4C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9162072E
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="J09CSdcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9162072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJCz0-0003WP-Ix
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 05:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35167)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1jJCy3-000348-Cj
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:13:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1jJCy1-0005ME-GV
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:13:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1jJCxz-0005Jh-Nu
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 05:13:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id h9so24904344wrc.8
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 02:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3tq/6HeYUoF8j3n70MM+g+9+/xFe3z7G+cZK/eJ2q5g=;
 b=J09CSdcGSNl7cbS7uQxXgXgSJaxn23v2zoFmJzpEugAfNeviwpYjs8ZjappRbk/Lke
 tfa+Mbq/VAy2HRxIuAL+gge0D4x/HnkAlYlA4pCNa63LgrOViAUgMtPGn7OR5Y3wDCHk
 Ur7Ojcy0FTVcFJHOedTXJOBQFe3isJEjFu8JMn3SeIn5zfvuUgUS+RnAoSSn9cZJ+DnD
 NLC97szwXDCs90As/zojzDMEcKwWZLckxM36haxXlYAkWqJkwViddzdr0l2dd7tuVZEp
 7fXxCVx0xradVBaApRtFm2FJ7Q08LaSLXgYxHtSnjGf+aguawNLrazDhJTLK/pWiKWO3
 DuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3tq/6HeYUoF8j3n70MM+g+9+/xFe3z7G+cZK/eJ2q5g=;
 b=WZl3DngEo2J8gYqDmWGwfU720V8zh684T7wuXYmb4hHZwtcOkgETcmWaJfYmtKfphK
 KwwcMb24PlMm6g9DVBhT9lnhDi7RLWreoq97a7QAGCxK8iD+H31jhuOi88ObOV8EFUHP
 +vxBTRuP3eD+6CHxwhqa6o/sKZjt9mh1mP0lbhl/E10VJN5iExhXhb+dJ/kHemYM5eIY
 kszTcSXn/5BQUvewCvwv4ATLsoTp/s7oOD9H9faKsJtoglPNuyCEiGBCTNlnRSgqlVu6
 wvJUZVZBp2ONkWRE6XX+aeR/2dQSUcGjDg4VU4gyfYBespfCjGJldAJ27VjncU11s64W
 F7Og==
X-Gm-Message-State: ANhLgQ2y/qLfPULAMpD5bc6uCIQv2anDovEVoTqGgghlSK0HBaL1cyyr
 1ikwoGeywUiziTUYBKqkKLFDaN/MITVKsgz3Cz/REg==
X-Google-Smtp-Source: ADFU+vsxoSCtYI4z+f08EL/kUMqgiURTQebAI+G2f2MWF/iqLlYJy50TunhMefcjvO2kieLjtKbLd5/rDrnmmKmViSg=
X-Received: by 2002:a5d:4acd:: with SMTP id y13mr19367932wrs.61.1585646028592; 
 Tue, 31 Mar 2020 02:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200313034949.3028-1-jiangyifei@huawei.com>
 <20200313034949.3028-3-jiangyifei@huawei.com>
In-Reply-To: <20200313034949.3028-3-jiangyifei@huawei.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 31 Mar 2020 14:43:36 +0530
Message-ID: <CAAhSdy3_BO7pRwvLiS9qd3NLXUCj_MnsxT8JtD0833AnY1DOZQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/9] target/riscv: Add target/riscv/kvm.c to place the
 public kvm interface
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: victor.zhangxiaofeng@huawei.com, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 zhang.zhanghailiang@huawei.com, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anup Patel <anup.patel@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng1@huawei.com,
 Palmer Dabbelt <palmer@dabbelt.com>, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Mar 13, 2020 at 9:23 AM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> Add target/riscv/kvm.c to place kvm_arch_* function needed by kvm/kvm-all.c.
> Meanwhile, add riscv64 kvm support to configure.

This should be for both riscv64 and riscv32. The KVMTOOL compiles perfectly
fine for riscv32 (although not tested much) so there is no harm is supporting
both riscv64 and riscv32 from start itself.

Regards,
Anup


>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
> ---
>  configure                  |   1 +
>  target/riscv/Makefile.objs |   1 +
>  target/riscv/kvm.c         | 128 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 target/riscv/kvm.c
>
> diff --git a/configure b/configure
> index 3c7470096f..30024a8aef 100755
> --- a/configure
> +++ b/configure
> @@ -200,6 +200,7 @@ supported_kvm_target() {
>          x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
>          mips:mips | mipsel:mips | \
>          ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \
> +        riscv64:riscv64 | \
>          s390x:s390x)
>              return 0
>          ;;
> diff --git a/target/riscv/Makefile.objs b/target/riscv/Makefile.objs
> index ff651f69f6..7ea8f4c3da 100644
> --- a/target/riscv/Makefile.objs
> +++ b/target/riscv/Makefile.objs
> @@ -1,5 +1,6 @@
>  obj-y += translate.o op_helper.o cpu_helper.o cpu.o csr.o fpu_helper.o gdbstub.o
>  obj-$(CONFIG_SOFTMMU) += pmp.o
> +obj-$(CONFIG_KVM) += kvm.o
>
>  ifeq ($(CONFIG_SOFTMMU),y)
>  obj-y += monitor.o
> diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
> new file mode 100644
> index 0000000000..8c386d9acf
> --- /dev/null
> +++ b/target/riscv/kvm.c
> @@ -0,0 +1,128 @@
> +/*
> + * RISC-V implementation of KVM hooks
> + *
> + * Copyright (c) 2020 Huawei Technologies Co., Ltd
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
> +#include <sys/ioctl.h>
> +
> +#include <linux/kvm.h>
> +
> +#include "qemu-common.h"
> +#include "qemu/timer.h"
> +#include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
> +#include "sysemu/sysemu.h"
> +#include "sysemu/kvm.h"
> +#include "sysemu/kvm_int.h"
> +#include "cpu.h"
> +#include "trace.h"
> +#include "hw/pci/pci.h"
> +#include "exec/memattrs.h"
> +#include "exec/address-spaces.h"
> +#include "hw/boards.h"
> +#include "hw/irq.h"
> +#include "qemu/log.h"
> +#include "hw/loader.h"
> +
> +const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
> +    KVM_CAP_LAST_INFO
> +};
> +
> +int kvm_arch_get_registers(CPUState *cs)
> +{
> +    return 0;
> +}
> +
> +int kvm_arch_put_registers(CPUState *cs, int level)
> +{
> +    return 0;
> +}
> +
> +int kvm_arch_release_virq_post(int virq)
> +{
> +    return 0;
> +}
> +
> +int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
> +                             uint64_t address, uint32_t data, PCIDevice *dev)
> +{
> +    return 0;
> +}
> +
> +int kvm_arch_destroy_vcpu(CPUState *cs)
> +{
> +    return 0;
> +}
> +
> +unsigned long kvm_arch_vcpu_id(CPUState *cpu)
> +{
> +    return cpu->cpu_index;
> +}
> +
> +void kvm_arch_init_irq_routing(KVMState *s)
> +{
> +}
> +
> +int kvm_arch_init_vcpu(CPUState *cs)
> +{
> +    return 0;
> +}
> +
> +int kvm_arch_msi_data_to_gsi(uint32_t data)
> +{
> +    abort();
> +}
> +
> +int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
> +                                int vector, PCIDevice *dev)
> +{
> +    return 0;
> +}
> +
> +int kvm_arch_init(MachineState *ms, KVMState *s)
> +{
> +    return 0;
> +}
> +
> +int kvm_arch_irqchip_create(KVMState *s)
> +{
> +    return 0;
> +}
> +
> +int kvm_arch_process_async_events(CPUState *cs)
> +{
> +    return 0;
> +}
> +
> +void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
> +{
> +}
> +
> +MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
> +{
> +    return MEMTXATTRS_UNSPECIFIED;
> +}
> +
> +bool kvm_arch_stop_on_emulation_error(CPUState *cs)
> +{
> +    return true;
> +}
> +
> +int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> +{
> +    return 0;
> +}
> --
> 2.19.1
>
>
>


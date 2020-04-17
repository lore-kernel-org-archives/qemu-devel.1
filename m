Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC543C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E64E20732
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 22:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI9vE3Hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E64E20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPZiJ-00028C-Nn
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 18:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jPZhI-0001M4-Ox
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jPZhH-00063D-6W
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 18:42:56 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44229)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jPZhH-00060z-1V; Fri, 17 Apr 2020 18:42:55 -0400
Received: by mail-io1-xd44.google.com with SMTP id h6so4098092iok.11;
 Fri, 17 Apr 2020 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sy/88jthBUW9INdoLUgFavxhraz0ghOJNjOgNrh94Vw=;
 b=iI9vE3HpJKeDUJ988SlWt0u2595k6I2mb706viVZU6vqf2vDOFdqAz20oxLk0nHufj
 gN3EWtNzBnzcuCEaWHieNhvLFMcYhCKL8llK/y9fmYvm7LJH+9QX14mJX3vXUTThEnME
 CvGV7wDK5wPTK4d7CUQGaKHtQqrME/E9QvQg8odNHf8fImmJE3PJ2fmiWGJqBwwuWfh8
 /ldlJ9OFwYT8rHXCUJyiT6EmHUxsR7QUoDq0D/OZy9xMjmbu0Er0/6CIdSVr0JvN1abQ
 0dWqkXiDbkPiQNh3ctdbWmUZ6lyrQD9IeHSksoM9HT1gEyy0LFZlrC7/BVPubSYB7Mks
 S45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sy/88jthBUW9INdoLUgFavxhraz0ghOJNjOgNrh94Vw=;
 b=oWCSjctZ9tVLVZRj+yuC7sYKK9ZQdl4o7Zb+sMhoQ8QT7i6ATN1bP0Nmx6L5HvJiPs
 UAp1F1hK3M+1+aut0J65W3HTYjzABql9HKjo8CMKNMkxRVsJGV5r/+CfUBTZmWMmEane
 9YCNJtsyfDtz3k3w8wBgHfCL+nhnLozRfneU4r6qjNK8Lhc//SxmtCKrgVfIzDUFAyQQ
 wd3fzqJYEHaAB0Pj/9Z3o46VryS4azwdRpcJ7Sf4WsgyI5wbrfZGhleCtQYx2R2HrU93
 DIMxORootsG13QBG9WUZf905oUxf1laaRhGUSpYOZRA/vDE8oOTdq6u+60g8s0mW9xaL
 UZYg==
X-Gm-Message-State: AGi0Pua0U91RC/SuloT6ZvvHpxgFEwuMjA8aUGKtuTKrVsUMlxaYeIL3
 URe97lo9nWd9vZ1NsayIZz04HsVDC4luwwVXbQU=
X-Google-Smtp-Source: APiQypKmvyR+hOnLuLLZj9C1Mc8pC8nwwn19bomBcxzO8HBzXlQRng95uSbx68Smfafx6TnsuxP77hEk08opvmt7AE8=
X-Received: by 2002:a5e:880b:: with SMTP id l11mr5513871ioj.42.1587163374220; 
 Fri, 17 Apr 2020 15:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200411041427.14828-1-jiangyifei@huawei.com>
 <20200411041427.14828-3-jiangyifei@huawei.com>
In-Reply-To: <20200411041427.14828-3-jiangyifei@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Apr 2020 15:34:30 -0700
Message-ID: <CAKmqyKOJCDHNma9Wx3Vygwe7w+jwEo6U7Z_=TSnET_Nm3Lps3A@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/9] target/riscv: Add target/riscv/kvm.c to place
 the public kvm interface
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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
Cc: kvm-riscv@lists.infradead.org, Anup Patel <anup.patel@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, zhang.zhanghailiang@huawei.com,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 victor.zhangxiaofeng@huawei.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng1@huawei.com,
 Palmer Dabbelt <palmer@dabbelt.com>, "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 10, 2020 at 9:16 PM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> Add target/riscv/kvm.c to place kvm_arch_* function needed by kvm/kvm-all.c.
> Meanwhile, add kvm support in configure file.
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configure                  |   1 +
>  target/riscv/Makefile.objs |   1 +
>  target/riscv/kvm.c         | 128 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 130 insertions(+)
>  create mode 100644 target/riscv/kvm.c
>
> diff --git a/configure b/configure
> index 233c671aaa..7114a1c64d 100755
> --- a/configure
> +++ b/configure
> @@ -200,6 +200,7 @@ supported_kvm_target() {
>          x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
>          mips:mips | mipsel:mips | \
>          ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \
> +        riscv32:riscv32 | riscv64:riscv64 | \
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


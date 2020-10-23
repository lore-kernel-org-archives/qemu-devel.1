Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0425C55178
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:05:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D0C2098B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 00:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQLN/GGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D0C2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW73U-0002ZL-7V
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 20:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW72I-00022x-6i; Fri, 23 Oct 2020 20:03:54 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:47089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kW72G-0006Jx-4H; Fri, 23 Oct 2020 20:03:53 -0400
Received: by mail-io1-xd41.google.com with SMTP id b15so3976926iod.13;
 Fri, 23 Oct 2020 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GQx9hGiYD65CpSQdgsWAHvzKNzl4z2wiB6rN6LGOFmA=;
 b=VQLN/GGkw4SdY94BcHkp7xLb4s2a77ZFgIT2b8ggIKW4dfOfZI6jN6zgnwJvo1yrDW
 BzZoFuxKm10CYVf9CUtPJoWqRQcERoXioPKV6gs8CPi18tNpe1/hIiK9Z0R14g7qZZ/q
 efS2SK739GEhZF8cPdpE9BQuz+zofTBebsBWD2atE3JlLuUdETMoz9NfDYXXnsRckGJv
 Y0FrboMtx8c1TVls6/fnPTrclas7gFUcpgMgia8cabsooIfybRNU+FNTjx5DbUEswu87
 76mEvmwSSrwV6QIEfDqu0+4kFJxM9KSVD0ytxQpq/kNUlkqCQcpwkHMB32goWK2BplHZ
 uPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GQx9hGiYD65CpSQdgsWAHvzKNzl4z2wiB6rN6LGOFmA=;
 b=Sv8kNHaByWWXcHUVW1XCfgog63HEA6N3Gyz7uDjhnkLPFTq93SpFMwQaNUoNCBqMhr
 nq/NdOTa5M9PvLexoUQ4ypdhVK3Njy0zMj4iBetkj8LcNv9T7r5AUyCSm58OcDQyYye9
 xHb06uWqGFDzrdD5Us/sTEnWhdGSgJHucYluuiLe67IRPwV/jneHqJnR51Goj81K/6sv
 zVY3vQeyujz/vo4xyEYB6dZ0FfwY6eGdsCschpkpqG7I6lselEvT2QPlJk+0vLAXPzSV
 P2FJfWtN2CcfRHeXNzwl7WELY1Kd/329HgsXi3Udu+/+25/lqt+O9w9U/a8ni1WCpL2k
 R9wA==
X-Gm-Message-State: AOAM533teUwWif9qooQSt4a7F1b6GhJ1XSCoC6TfMZYnafDD81YPlImK
 tt/Q2//wcbfoCcT0keVrkq+feI0Or/d8LXddlyA=
X-Google-Smtp-Source: ABdhPJyuBYRByx8vdJRA5tM8kA0D2A0iHOs54jEIv3LUXjp3jUnklYsbpg683wCdGcJg38OGFcYscGk8u6+Z57yof+U=
X-Received: by 2002:a6b:8ec7:: with SMTP id q190mr3770156iod.42.1603497830635; 
 Fri, 23 Oct 2020 17:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201023091225.224-1-jiangyifei@huawei.com>
 <20201023091225.224-3-jiangyifei@huawei.com>
In-Reply-To: <20201023091225.224-3-jiangyifei@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Oct 2020 16:52:03 -0700
Message-ID: <CAKmqyKO+pW_3kU2pph3oUALbeHCZ1E890f+tfiyqsep3FEqyKA@mail.gmail.com>
Subject: Re: [PATCH V3 2/6] target/riscv: Add basic vmstate description of CPU
To: Yifei Jiang <jiangyifei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "Zhangxiaofeng \(F\)" <victor.zhangxiaofeng@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, yinyipeng <yinyipeng1@huawei.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, "Wubin \(H\)" <wu.wubin@huawei.com>,
 "dengkai \(A\)" <dengkai1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 2:13 AM Yifei Jiang <jiangyifei@huawei.com> wrote:
>
> Add basic CPU state description to the newly created machine.c
>
> Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
> Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c       |  8 +----
>  target/riscv/internals.h |  4 +++
>  target/riscv/machine.c   | 74 ++++++++++++++++++++++++++++++++++++++++
>  target/riscv/meson.build |  3 +-
>  4 files changed, 81 insertions(+), 8 deletions(-)
>  create mode 100644 target/riscv/machine.c
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index dd05a220c7..6a0264fc6b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -22,6 +22,7 @@
>  #include "qemu/ctype.h"
>  #include "qemu/log.h"
>  #include "cpu.h"
> +#include "internals.h"
>  #include "exec/exec-all.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> @@ -498,13 +499,6 @@ static void riscv_cpu_init(Object *obj)
>      cpu_set_cpustate_pointers(cpu);
>  }
>
> -#ifndef CONFIG_USER_ONLY
> -static const VMStateDescription vmstate_riscv_cpu = {
> -    .name = "cpu",
> -    .unmigratable = 1,
> -};
> -#endif
> -
>  static Property riscv_cpu_properties[] = {
>      DEFINE_PROP_BOOL("i", RISCVCPU, cfg.ext_i, true),
>      DEFINE_PROP_BOOL("e", RISCVCPU, cfg.ext_e, false),
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index f1a546dba6..b15ad394bb 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -38,6 +38,10 @@ target_ulong fclass_d(uint64_t frs1);
>  #define SEW32 2
>  #define SEW64 3
>
> +#ifndef CONFIG_USER_ONLY
> +extern const VMStateDescription vmstate_riscv_cpu;
> +#endif
> +
>  static inline uint64_t nanbox_s(float32 f)
>  {
>      return f | MAKE_64BIT_MASK(32, 32);
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> new file mode 100644
> index 0000000000..32edbcba7c
> --- /dev/null
> +++ b/target/riscv/machine.c
> @@ -0,0 +1,74 @@
> +/*
> + * RISC-V VMState Description
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
> +#include "cpu.h"
> +#include "qemu/error-report.h"
> +#include "sysemu/kvm.h"
> +#include "migration/cpu.h"
> +
> +const VMStateDescription vmstate_riscv_cpu = {
> +    .name = "cpu",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> +        VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
> +        VMSTATE_UINTTL(env.pc, RISCVCPU),
> +        VMSTATE_UINTTL(env.load_res, RISCVCPU),
> +        VMSTATE_UINTTL(env.load_val, RISCVCPU),
> +        VMSTATE_UINTTL(env.frm, RISCVCPU),
> +        VMSTATE_UINTTL(env.badaddr, RISCVCPU),
> +        VMSTATE_UINTTL(env.guest_phys_fault_addr, RISCVCPU),
> +        VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
> +        VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
> +        VMSTATE_UINTTL(env.misa, RISCVCPU),
> +        VMSTATE_UINTTL(env.misa_mask, RISCVCPU),
> +        VMSTATE_UINT32(env.features, RISCVCPU),
> +        VMSTATE_UINTTL(env.priv, RISCVCPU),
> +        VMSTATE_UINTTL(env.virt, RISCVCPU),
> +        VMSTATE_UINTTL(env.resetvec, RISCVCPU),
> +        VMSTATE_UINTTL(env.mhartid, RISCVCPU),
> +        VMSTATE_UINT64(env.mstatus, RISCVCPU),
> +        VMSTATE_UINTTL(env.mip, RISCVCPU),
> +        VMSTATE_UINT32(env.miclaim, RISCVCPU),
> +        VMSTATE_UINTTL(env.mie, RISCVCPU),
> +        VMSTATE_UINTTL(env.mideleg, RISCVCPU),
> +        VMSTATE_UINTTL(env.sptbr, RISCVCPU),
> +        VMSTATE_UINTTL(env.satp, RISCVCPU),
> +        VMSTATE_UINTTL(env.sbadaddr, RISCVCPU),
> +        VMSTATE_UINTTL(env.mbadaddr, RISCVCPU),
> +        VMSTATE_UINTTL(env.medeleg, RISCVCPU),
> +        VMSTATE_UINTTL(env.stvec, RISCVCPU),
> +        VMSTATE_UINTTL(env.sepc, RISCVCPU),
> +        VMSTATE_UINTTL(env.scause, RISCVCPU),
> +        VMSTATE_UINTTL(env.mtvec, RISCVCPU),
> +        VMSTATE_UINTTL(env.mepc, RISCVCPU),
> +        VMSTATE_UINTTL(env.mcause, RISCVCPU),
> +        VMSTATE_UINTTL(env.mtval, RISCVCPU),
> +        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
> +        VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
> +        VMSTATE_UINTTL(env.sscratch, RISCVCPU),
> +        VMSTATE_UINTTL(env.mscratch, RISCVCPU),
> +        VMSTATE_UINT64(env.mfromhost, RISCVCPU),
> +        VMSTATE_UINT64(env.mtohost, RISCVCPU),
> +        VMSTATE_UINT64(env.timecmp, RISCVCPU),
> +
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> diff --git a/target/riscv/meson.build b/target/riscv/meson.build
> index abd647fea1..14a5c62dac 100644
> --- a/target/riscv/meson.build
> +++ b/target/riscv/meson.build
> @@ -27,7 +27,8 @@ riscv_ss.add(files(
>  riscv_softmmu_ss = ss.source_set()
>  riscv_softmmu_ss.add(files(
>    'pmp.c',
> -  'monitor.c'
> +  'monitor.c',
> +  'machine.c'
>  ))
>
>  target_arch += {'riscv': riscv_ss}
> --
> 2.19.1
>
>


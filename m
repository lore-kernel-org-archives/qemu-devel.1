Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78B5C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8314E2087C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="C+TjgoAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8314E2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEAiP-00041e-OE
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kEAhS-0003Ti-Oe
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:20:14 -0400
Received: from mail-eopbgr680064.outbound.protection.outlook.com
 ([40.107.68.64]:21106 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kEAhP-00021q-OP
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:20:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUsAdiyLRqbr/m040zww6Spq8/kLlopoK50IuYNYqRtoXPxrD6jWCeP/D0byKKRT8luAqUp64Slv5sAiWaWa2HQOBfERZjHUzgUqPLoqEMm89Xh/5LGLK2Q4MuqpWEHV9EONHwu3MPOlWcwJsqQvw4qfcLTCl3sNfZlJCa8/urgaS2Eaulcwy3I2Us6gEP0Lxwp9ufdozsbeip4Qh1QTX6aDmFZGr0EvMRaU+5jbndBxBP4oqaylW4yGu83x/NykYicxHxc3AYC6Vl/AXSt2sjy4AZo7LojX/sp29YowuO3v/FLm0i1n73pMqbCH4c6mN9UhhvFO7eg/OtFsUW/Qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUnbA/GnoJf6N9fYNbkiUdGln6Pj26+7QggVKLjurn0=;
 b=U/K/KthctN1lUZ5vtelwfG5YfiJW37fF23eymZ/GLBU0bPyXhuoXsV59eD3Aoj2b9OqvJuqJs7b/BpfBz4d/bHX8HxKB+ByrbZ3BTH9BFGJotRU6w3WKIC3n42azlmMCQ/9P170xiqVIa7L8lrOYWZumQqilQhdiwzuSj5mCwkdUJwBsAcY0bc3oxChraGbCHIdptxJkT213r2OCkNQ3LV+qnMVr53UPH3rewHbwqUsjtqbPkj+a030aXptSYz6dVaZomX/V3TIXEBsqYAmTDuVCNkILWHVV8UCUBxxWf/zPJ524R5UCpu/1HfQdyTzRDnWCECQvTAO6W+c1BYMOzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUnbA/GnoJf6N9fYNbkiUdGln6Pj26+7QggVKLjurn0=;
 b=C+TjgoAk6mMlwtl/nLJBo6eIuaPykAoOCIJOjoFbFjbrTozkzz055UAsou9xEa5nUzwRbAgwSItRuYyHy+bNhxBo8AuwLU5hZgxFVJrMi37XWqNJ7/iootVy6YgJMjZVeqxN/I5cjrbozqEjFGZ2tpCUB5lZolCqCV+b1+VDEOY=
Received: from DM6PR14CA0069.namprd14.prod.outlook.com (2603:10b6:5:18f::46)
 by DM5PR02MB3322.namprd02.prod.outlook.com (2603:10b6:4:65::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 4 Sep
 2020 12:20:09 +0000
Received: from CY1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::13) by DM6PR14CA0069.outlook.office365.com
 (2603:10b6:5:18f::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Fri, 4 Sep 2020 12:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT050.mail.protection.outlook.com (10.152.75.65) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Fri, 4 Sep 2020 12:20:08
 +0000
Received: from [149.199.38.66] (port=35346 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kEAhF-00077r-9Z; Fri, 04 Sep 2020 05:20:01 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kEAhM-00040p-Kz; Fri, 04 Sep 2020 05:20:08 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kEAhM-0003z3-3Y; Fri, 04 Sep 2020 05:20:08 -0700
Date: Fri, 4 Sep 2020 14:20:03 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 05/12] target/microblaze: Fill in VMStateDescription
 for cpu
Message-ID: <20200904122003.GN14249@toto>
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
 <20200903072650.1360454-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903072650.1360454-6-richard.henderson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac4ca76-794b-4de9-6d7d-08d850ccdd4a
X-MS-TrafficTypeDiagnostic: DM5PR02MB3322:
X-Microsoft-Antispam-PRVS: <DM5PR02MB332212FAB6E9AEFE2EC192B8C22D0@DM5PR02MB3322.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJHm5xus3BeDPgaZB7+H0IHIo7QmXLtjarL6Q0WXas82gzxwkx8B5jwQNMtU1+aKQNV9tJKD4H1G2qqumnI/H2bCzAGzxyx2BjoWZMZOSJzwtqRAVIF7odcUR24iPWfKOxL9pG9ZERD85qIIU7i8EjslKt6WFzn0Ug3tqccSaAV05kMx37d4BYJe0F/qefGElNml8Li9GHIDFS3qOuFJ6hvxEQsu7aKiirqD5zAx2IUyZKtK3tR6Kn/XL2T2Dafq+aJKF2BS1/EnRh6rq+yJ28JeZbUhVMxcOqN8exnm1pOqruR/tTL4j5i/91jL5qRcJ7ly4wVLueuiYSBDPLg7HHNNKNVtMc47KRVpzj//iW/ZRTE1/bhW4bItTkCRHcbix1y2MpZyJsld7LGEz+DI/7ZFYlJGY9FFDMlhMLnimPfigAxUNuabclU0f1ot0EPhuvmB6aBIIqyonNEjSrFtf8aOfAsKLTOfC/BThYP3QhNLBlevcCzmOAabbIFYtDs1
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(39860400002)(136003)(376002)(396003)(346002)(46966005)(9786002)(70206006)(186003)(4326008)(8676002)(6916009)(426003)(83380400001)(356005)(8936002)(70586007)(82310400003)(33716001)(5660300002)(316002)(478600001)(1076003)(6666004)(2906002)(81166007)(336012)(26005)(82740400003)(47076004)(33656002)(9686003)(2004002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 12:20:08.9058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac4ca76-794b-4de9-6d7d-08d850ccdd4a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3322
Received-SPF: pass client-ip=40.107.68.64; envelope-from=edgar@xilinx.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 08:20:10
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 12:26:43AM -0700, Richard Henderson wrote:

Hi Richard,


> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/cpu.h       |   4 ++
>  target/microblaze/cpu.c       |   8 +--
>  target/microblaze/machine.c   | 112 ++++++++++++++++++++++++++++++++++
>  target/microblaze/meson.build |   5 +-
>  4 files changed, 121 insertions(+), 8 deletions(-)
>  create mode 100644 target/microblaze/machine.c
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 20c2979396..133ebaa4d4 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -419,4 +419,8 @@ static inline int cpu_mmu_index(CPUMBState *env, bool ifetch)
>      return MMU_KERNEL_IDX;
>  }
>  
> +#ifndef CONFIG_USER_ONLY
> +extern const VMStateDescription vmstate_mb_cpu;
> +#endif
> +
>  #endif
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 6392524135..388605ccca 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -26,7 +26,6 @@
>  #include "cpu.h"
>  #include "qemu/module.h"
>  #include "hw/qdev-properties.h"
> -#include "migration/vmstate.h"
>  #include "exec/exec-all.h"
>  #include "fpu/softfloat-helpers.h"
>  
> @@ -254,11 +253,6 @@ static void mb_cpu_initfn(Object *obj)
>  #endif
>  }
>  
> -static const VMStateDescription vmstate_mb_cpu = {
> -    .name = "cpu",
> -    .unmigratable = 1,
> -};
> -
>  static Property mb_properties[] = {
>      DEFINE_PROP_UINT32("base-vectors", MicroBlazeCPU, cfg.base_vectors, 0),
>      DEFINE_PROP_BOOL("use-stack-protection", MicroBlazeCPU, cfg.stackprot,
> @@ -338,8 +332,8 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
>  #ifndef CONFIG_USER_ONLY
>      cc->do_transaction_failed = mb_cpu_transaction_failed;
>      cc->get_phys_page_debug = mb_cpu_get_phys_page_debug;
> -#endif
>      dc->vmsd = &vmstate_mb_cpu;
> +#endif
>      device_class_set_props(dc, mb_properties);
>      cc->gdb_num_core_regs = 32 + 27;
>  
> diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
> new file mode 100644
> index 0000000000..aad3c5d1d3
> --- /dev/null
> +++ b/target/microblaze/machine.c
> @@ -0,0 +1,112 @@
> +/*
> + *  Microblaze VMState for qemu.
> + *
> + *  Copyright (c) 2020 Linaro, Ltd.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "migration/cpu.h"
> +
> +
> +static VMStateField vmstate_mmu_fields[] = {
> +    VMSTATE_UINT64_2DARRAY(rams, MicroBlazeMMU, 2, TLB_ENTRIES),
> +    VMSTATE_UINT8_ARRAY(tids, MicroBlazeMMU, TLB_ENTRIES),
> +    VMSTATE_UINT32_ARRAY(regs, MicroBlazeMMU, 3),
> +    VMSTATE_INT32(c_mmu, MicroBlazeMMU),
> +    VMSTATE_INT32(c_mmu_tlb_access, MicroBlazeMMU),
> +    VMSTATE_INT32(c_mmu_zones, MicroBlazeMMU),
> +    VMSTATE_UINT64(c_addr_mask, MicroBlazeMMU),

These last 4 entries are elaboration-time settings, i.e they will not
change during VM runtime. I don't think we need to transfer these since
we expect the peer to setup the same kind of microblaze?



> +    VMSTATE_END_OF_LIST()
> +};
> +
> +static const VMStateDescription vmstate_mmu = {
> +    .name = "mmu",
> +    .version_id = 0,
> +    .minimum_version_id = 0,
> +    .fields = vmstate_mmu_fields,
> +};
> +
> +static int get_msr(QEMUFile *f, void *opaque, size_t size,
> +                   const VMStateField *field)
> +{
> +    CPUMBState *env = container_of(opaque, CPUMBState, msr);
> +
> +    mb_cpu_write_msr(env, qemu_get_be32(f));
> +    return 0;
> +}
> +
> +static int put_msr(QEMUFile *f, void *opaque, size_t size,
> +                   const VMStateField *field, QJSON *vmdesc)
> +{
> +    CPUMBState *env = container_of(opaque, CPUMBState, msr);
> +
> +    qemu_put_be32(f, mb_cpu_read_msr(env));
> +    return 0;
> +}
> +
> +static const VMStateInfo vmstate_msr = {
> +    .name = "msr",
> +    .get = get_msr,
> +    .put = put_msr,
> +};
> +
> +static VMStateField vmstate_env_fields[] = {
> +    VMSTATE_UINT32_ARRAY(regs, CPUMBState, 32),
> +
> +    VMSTATE_UINT32(pc, CPUMBState),
> +    VMSTATE_SINGLE(msr, CPUMBState, 0, vmstate_msr, uint32_t),
> +    VMSTATE_UINT32(esr, CPUMBState),
> +    VMSTATE_UINT32(fsr, CPUMBState),
> +    VMSTATE_UINT32(btr, CPUMBState),
> +    VMSTATE_UINT32(edr, CPUMBState),
> +    VMSTATE_UINT32(slr, CPUMBState),
> +    VMSTATE_UINT32(shr, CPUMBState),
> +    VMSTATE_UINT64(ear, CPUMBState),
> +
> +    VMSTATE_UINT32(btarget, CPUMBState),
> +    VMSTATE_UINT32(imm, CPUMBState),
> +    VMSTATE_UINT32(iflags, CPUMBState),
> +
> +    VMSTATE_UINT32(res_val, CPUMBState),
> +    VMSTATE_UINTTL(res_addr, CPUMBState),
> +
> +    VMSTATE_UINT32_ARRAY(pvr.regs, CPUMBState, 13),

pvr.regs are also elaboration time setup and should be read-only during
the VM's lifetime.

If you fix those, this looks good to me.:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



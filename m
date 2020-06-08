Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B91C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 01:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3AAD2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 01:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3AAD2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji6Lg-00073M-5Z
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 21:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1ji6Ki-0006Dl-Rh; Sun, 07 Jun 2020 21:12:12 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3705 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1ji6Ke-0002WC-SE; Sun, 07 Jun 2020 21:12:09 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 138E2C99B5922EBBB578;
 Mon,  8 Jun 2020 09:11:57 +0800 (CST)
Received: from [10.173.222.233] (10.173.222.233) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 8 Jun 2020 09:11:49 +0800
Subject: Re: Forward migration broken down since virt-4.2 machine type
From: Ying Fang <fangying1@huawei.com>
To: <richard.henderson@linaro.org>
References: <36de6085-86e1-f240-38f6-6e8582c2c68b@huawei.com>
Message-ID: <21252780-616a-6ff3-1c80-33eb643e6e4d@huawei.com>
Date: Mon, 8 Jun 2020 09:11:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <36de6085-86e1-f240-38f6-6e8582c2c68b@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.233]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 21:11:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, wu.wubin@huawei.com,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping

On 6/4/2020 4:51 PM, Ying Fang wrote:
> Hi Richard,
> 
> Recently we are doing some tests on forward migration based on
> arm virt machine. And we found the patch below breaks forward
> migration compatibility from virt-4.2 to virt-5.0 above machine
> type. The patch which breaks this down given by git bisect is
> 
> commit f9506e162c33e87b609549157dd8431fcc732085
> target/arm: Remove ARM_FEATURE_VFP*
> 
> QEMU may get crashed on the destination host loading cpu state.
> Here goes my question since I am not familiar with the VFP feature.
> 1: Should we keep the forward migration compatibility here ?
> 2: If so how can we fixed it ?
> 
> Below is the crash stack:
> Thread 1 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
> [Switching to LWP 712330]
> armv7m_nvic_neg_prio_requested (opaque=0x0, secure=secure@entry=false) 
> at  qemu/hw/intc/armv7m_nvic.c:391
> 391        if (s->cpu->env.v7m.faultmask[secure]) {
> #0  armv7m_nvic_neg_prio_requested (opaque=0x0, 
> secure=secure@entry=false) at  qemu/hw/intc/armv7m_nvic.c:391
> #1  0x0000aaae6f766510 in arm_v7m_mmu_idx_for_secstate_and_priv 
> (env=0xaaae73456780, secstate=false, priv=true) at 
> qemu/target/arm/m_helper.c:2711
> #2  0x0000aaae6f7163f0 in arm_mmu_idx_el (env=env@entry=0xaaae73456780, 
> el=el@entry=1) at  qemu/target/arm/helper.c:12386
> #3  0x0000aaae6f717000 in rebuild_hflags_internal (env=0xaaae73456780) 
> at  qemu/target/arm/helper.c:12611
> #4  arm_rebuild_hflags (env=env@entry=0xaaae73456780) at 
> qemu/target/arm/helper.c:12624
> #5  0x0000aaae6f722940 in cpu_post_load (opaque=0xaaae7344ceb0, 
> version_id=<optimized out>) at  qemu/target/arm/machine.c:767
> #6  0x0000aaae6f9e0e78 in vmstate_load_state (f=f@entry=0xaaae73020260, 
> vmsd=0xaaae6fe93178 <vmstate_arm_cpu>, opaque=0xaaae7344ceb0, 
> version_id=22) at migration/vmstate.c:168
> #7  0x0000aaae6f9d9858 in vmstate_load (f=f@entry=0xaaae73020260, 
> se=se@entry=0xaaae7302f750) at migration/savevm.c:885
> #8  0x0000aaae6f9dab90 in qemu_loadvm_section_start_full 
> (f=f@entry=0xaaae73020260, mis=0xaaae72fb88a0) at migration/savevm.c:2302
> #9  0x0000aaae6f9dd248 in qemu_loadvm_state_main 
> (f=f@entry=0xaaae73020260, mis=mis@entry=0xaaae72fb88a0) at 
> migration/savevm.c:2486
> #10 0x0000aaae6f9de3bc in qemu_loadvm_state (f=0xaaae73020260) at 
> migration/savevm.c:2560
> #11 0x0000aaae6f9d489c in process_incoming_migration_co 
> (opaque=<optimized out>) at migration/migration.c:461
> #12 0x0000aaae6fb59850 in coroutine_trampoline (i0=<optimized out>, 
> i1=<optimized out>) at util/coroutine-ucontext.c:115
> #13 0x0000fffdd6c16030 in ?? () from target:/usr/lib64/libc.so.6
> 
> #0  armv7m_nvic_neg_prio_requested (opaque=0x0, 
> secure=secure@entry=false) at  qemu/hw/intc/armv7m_nvic.c:391
> (gdb) p    s
> $4 = (NVICState *) 0x0
> 
> Thanks.
> Ying


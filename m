Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553FDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1FC2078B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 10:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1FC2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdA7N-0001aG-4o
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 06:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdA5r-0007lz-GP
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:12:27 -0400
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:42728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdA5l-0004Xc-Qa
 for qemu-devel@nongnu.org; Mon, 25 May 2020 06:12:27 -0400
Received: from player796.ha.ovh.net (unknown [10.108.57.53])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 98E5F1C5701
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 12:12:18 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player796.ha.ovh.net (Postfix) with ESMTPSA id 6F2A0129D45ED;
 Mon, 25 May 2020 10:12:14 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005ac8d40a0-5a1a-47eb-a077-110d317e3207,26835B9205782E90874D777227A1F0DDBFD0E061)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 5/9] ppc/pnv: Add a XIVE2 controller to the POWER10 chip.
To: Greg Kurz <groug@kaod.org>
References: <20200513151109.453530-1-clg@kaod.org>
 <20200513151109.453530-6-clg@kaod.org> <20200519114808.181ed5bf@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <55b5d737-491d-fbfc-1524-5b77d2c8bd09@kaod.org>
Date: Mon, 25 May 2020 12:12:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519114808.181ed5bf@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11097432433613441856
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddvtddgvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.76.26; envelope-from=clg@kaod.org;
 helo=4.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 06:12:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 11:48 AM, Greg Kurz wrote:
> On Wed, 13 May 2020 17:11:05 +0200
> Cédric Le Goater <clg@kaod.org> wrote:
> 
>> The XIVE2 interrupt controller of the POWER10 processor follows the
>> same logic than on POWER9 but the HW interface has been largely
>> reviewed.  It has a new register interface, different BARs, extra
>> VSDs, new layout for the XIVE2 structures, and a set of new features
>> which are described below.
>>
>> This is a model of the POWER10 XIVE2 interrupt controller for the
>> PowerNV machine. It focuses primarily on the needs of the skiboot
>> firmware but some initial hypervisor support is implemented for KVM
>> use (escalation).
>>
>> Support for new features will be implemented in time and will require
>> new support from the OS.
>>
>> * XIVE2 BARS
>>
>> The interrupt controller BARs have a different layout outlined below.
>> Each sub-engine has now own its range and the indirect TIMA access was
>> replaced with a set of pages, one per CPU, under the IC BAR:
>>
>>   - IC BAR (Interrupt Controller)
>>     . 4 pages, one per sub-engine
>>     . 128 indirect TIMA pages
>>   - TM BAR (Thread Interrupt Management Area)
>>     . 4 pages
>>   - ESB BAR (ESB pages for IPIs)
>>     . up to 1TB
>>   - END BAR (ESB pages for ENDs)
>>     . up to 2TB
>>   - NVC BAR (Notification Virtual Crowd)
>>     . up to 128
>>   - NVPG BAR (Notification Virtual Process and Group)
>>     . up to 1TB
>>   - Direct mapped Thread Context Area (reads & writes)
>>
>> OPAL does not use the grouping and crowd capability.
>>
>> * Virtual Structure Tables
>>
>> XIVE2 adds new tables types and also changes the field layout of the END
>> and NVP Virtualization Structure Descriptors.
>>
>>   - EAS
>>   - END new layout
>>   - NVT was splitted in :
>>     . NVP (Processor), 32B
>>     . NVG (Group), 32B
>>     . NVC (Crowd == P9 block group) 32B
>>   - IC for remote configuration
>>   - SYNC for cache injection
>>   - ERQ for event input queue
>>
>> The setup is slighly different on XIVE2 because the indexing has changed
>> for some of the tables, block ID or the chip topology ID can be used.
>>
>> * XIVE2 features
>>
>> SCOM and MMIO registers have a new layout and XIVE2 adds a new global
>> capability and configuration registers.
>>
>> The lowlevel hardware offers a set of new features among which :
>>
>>   - a configurable number of priorities : 1 - 8
>>   - StoreEOI with load-after-store ordering is activated by default
>>   - Gen2 TIMA layout
>>   - A P9-compat mode, or Gen1, TIMA toggle bit for SW compatibility
>>   - increase to 24bit for VP number
>>
>> Other features will have some impact on the Hypervisor and guest OS
>> when activated, but this is not required for initial support of the
>> controller.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
> 
> Apart from plugging the XIVE2 on the main system bus, like Markus's
> fix for XIVE, I don't see any obvious things to change.

OK. Fixed. 

Thanks,

C.

> 
>>  hw/intc/pnv_xive2_regs.h   |  428 ++++++++
>>  include/hw/ppc/pnv.h       |   22 +
>>  include/hw/ppc/pnv_xive.h  |   71 ++
>>  include/hw/ppc/pnv_xscom.h |    3 +
>>  hw/intc/pnv_xive2.c        | 2026 ++++++++++++++++++++++++++++++++++++
>>  hw/ppc/pnv.c               |   89 +-
>>  hw/intc/Makefile.objs      |    2 +-
>>  7 files changed, 2637 insertions(+), 4 deletions(-)
>>  create mode 100644 hw/intc/pnv_xive2_regs.h
>>  create mode 100644 hw/intc/pnv_xive2.c
>>
>> diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
>> new file mode 100644
>> index 000000000000..6ad0eee824b1
>> --- /dev/null
>> +++ b/hw/intc/pnv_xive2_regs.h
>> @@ -0,0 +1,428 @@
>> +/*
>> + * QEMU PowerPC XIVE2 interrupt controller model  (POWER10)
>> + *
>> + * Copyright (c) 2019-2020, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef PPC_PNV_XIVE2_REGS_H
>> +#define PPC_PNV_XIVE2_REGS_H
>> +
>> +/*
>> + * CQ Common Queue (PowerBus bridge) Registers
>> + */
>> +
>> +/* XIVE2 Capabilities */
>> +#define X_CQ_XIVE_CAP                           0x02
>> +#define CQ_XIVE_CAP                             0x010
>> +#define    CQ_XIVE_CAP_VERSION                  PPC_BITMASK(0, 3)
>> +/* 4:6 reserved */
>> +#define    CQ_XIVE_CAP_USER_INT_PRIO            PPC_BITMASK(8, 9)
>> +#define       CQ_XIVE_CAP_USER_INT_PRIO_1       0
>> +#define       CQ_XIVE_CAP_USER_INT_PRIO_1_2     1
>> +#define       CQ_XIVE_CAP_USER_INT_PRIO_1_4     2
>> +#define       CQ_XIVE_CAP_USER_INT_PRIO_1_8     3
>> +#define    CQ_XIVE_CAP_VP_INT_PRIO              PPC_BITMASK(10, 11)
>> +#define       CQ_XIVE_CAP_VP_INT_PRIO_1_8       0
>> +#define       CQ_XIVE_CAP_VP_INT_PRIO_2_8       1
>> +#define       CQ_XIVE_CAP_VP_INT_PRIO_4_8       2
>> +#define       CQ_XIVE_CAP_VP_INT_PRIO_8         3
>> +#define    CQ_XIVE_CAP_BLOCK_ID_WIDTH           PPC_BITMASK(12, 13)
>> +
>> +/* XIVE2 Configuration */
>> +#define X_CQ_XIVE_CFG                           0x03
>> +#define CQ_XIVE_CFG                             0x018
>> +
>> +/* 0:7 reserved */
>> +#define    CQ_XIVE_CFG_USER_INT_PRIO            PPC_BITMASK(8, 9)
>> +#define    CQ_XIVE_CFG_VP_INT_PRIO              PPC_BITMASK(10, 11)
>> +#define       CQ_XIVE_CFG_INT_PRIO_1            0
>> +#define       CQ_XIVE_CFG_INT_PRIO_2            1
>> +#define       CQ_XIVE_CFG_INT_PRIO_4            2
>> +#define       CQ_XIVE_CFG_INT_PRIO_8            3
>> +#define    CQ_XIVE_CFG_BLOCK_ID_WIDTH           PPC_BITMASK(12, 13)
>> +#define       CQ_XIVE_CFG_BLOCK_ID_4BITS        0
>> +#define       CQ_XIVE_CFG_BLOCK_ID_5BITS        1
>> +#define       CQ_XIVE_CFG_BLOCK_ID_6BITS        2
>> +#define       CQ_XIVE_CFG_BLOCK_ID_7BITS        3
>> +#define    CQ_XIVE_CFG_HYP_HARD_RANGE           PPC_BITMASK(14, 15)
>> +#define       CQ_XIVE_CFG_THREADID_7BITS        0
>> +#define       CQ_XIVE_CFG_THREADID_8BITS        1
>> +#define       CQ_XIVE_CFG_THREADID_9BITS        2
>> +#define       CQ_XIVE_CFG_THREADID_10BITs       3
>> +#define    CQ_XIVE_CFG_HYP_HARD_BLKID_OVERRIDE  PPC_BIT(16)
>> +#define    CQ_XIVE_CFG_HYP_HARD_BLOCK_ID        PPC_BITMASK(17, 23)
>> +
>> +/* Interrupt Controller Base Address Register - 512 pages (32M) */
>> +#define X_CQ_IC_BAR                             0x08
>> +#define CQ_IC_BAR                               0x040
>> +#define    CQ_IC_BAR_VALID                      PPC_BIT(0)
>> +#define    CQ_IC_BAR_64K                        PPC_BIT(1)
>> +/* 2:7 reserved */
>> +#define    CQ_IC_BAR_ADDR                       PPC_BITMASK(8, 42)
>> +/* 43:63 reserved */
>> +
>> +/* Thread Management Base Address Register - 4 pages */
>> +#define X_CQ_TM_BAR                             0x09
>> +#define CQ_TM_BAR                               0x048
>> +#define    CQ_TM_BAR_VALID                      PPC_BIT(0)
>> +#define    CQ_TM_BAR_64K                        PPC_BIT(1)
>> +#define    CQ_TM_BAR_ADDR                       PPC_BITMASK(8, 49)
>> +
>> +/* ESB Base Address Register */
>> +#define X_CQ_ESB_BAR                            0x0A
>> +#define CQ_ESB_BAR                              0x050
>> +#define    CQ_BAR_VALID                         PPC_BIT(0)
>> +#define    CQ_BAR_64K                           PPC_BIT(1)
>> +/* 2:7 reserved */
>> +#define    CQ_BAR_ADDR                          PPC_BITMASK(8, 39)
>> +#define    CQ_BAR_SET_DIV                       PPC_BITMASK(56, 58)
>> +#define    CQ_BAR_RANGE                         PPC_BITMASK(59, 63)
>> +                                                /* 0 (16M) - 16 (16T) */
>> +
>> +/* END Base Address Register */
>> +#define X_CQ_END_BAR                            0x0B
>> +#define CQ_END_BAR                              0x058
>> +
>> +/* NVPG Base Address Register */
>> +#define X_CQ_NVPG_BAR                           0x0C
>> +#define CQ_NVPG_BAR                             0x060
>> +
>> +/* NVC Base Address Register */
>> +#define X_CQ_NVC_BAR                            0x0D
>> +#define CQ_NVC_BAR                              0x068
>> +
>> +/* Table Address Register */
>> +#define X_CQ_TAR                                0x0E
>> +#define CQ_TAR                                  0x070
>> +#define     CQ_TAR_AUTOINC                      PPC_BIT(0)
>> +#define     CQ_TAR_SELECT                       PPC_BITMASK(12, 15)
>> +#define     CQ_TAR_ESB                          0       /* 0 - 15 */
>> +#define     CQ_TAR_END                          2       /* 0 - 15 */
>> +#define     CQ_TAR_NVPG                         3       /* 0 - 15 */
>> +#define     CQ_TAR_NVC                          5       /* 0 - 15 */
>> +#define     CQ_TAR_ENTRY_SELECT                 PPC_BITMASK(28, 31)
>> +
>> +/* Table Data Register */
>> +#define X_CQ_TDR                                0x0F
>> +#define CQ_TDR                                  0x078
>> +/* for the NVPG, NVC, ESB, END Set Translation Tables */
>> +#define     CQ_TDR_VALID                        PPC_BIT(0)
>> +#define     CQ_TDR_BLOCK_ID                     PPC_BITMASK(60, 63)
>> +
>> +/*
>> + * Processor Cores Enabled for MsgSnd
>> + * Identifies which of the 32 possible core chiplets are enabled and
>> + * available to receive the MsgSnd command
>> + */
>> +#define X_CQ_MSGSND                             0x10
>> +#define CQ_MSGSND                               0x080
>> +
>> +/* Interrupt Unit Reset Control */
>> +#define X_CQ_RST_CTL                            0x12
>> +#define CQ_RST_CTL                              0x090
>> +#define     CQ_RST_SYNC_RESET                   PPC_BIT(0)      /* Write Only */
>> +#define     CQ_RST_QUIESCE_PB                   PPC_BIT(1)      /* RW */
>> +#define     CQ_RST_MASTER_IDLE                  PPC_BIT(2)      /* Read Only */
>> +#define     CQ_RST_SAVE_IDLE                    PPC_BIT(3)      /* Read Only */
>> +#define     CQ_RST_PB_BAR_RESET                 PPC_BIT(4)      /* Write Only */
>> +
>> +/* PowerBus General Configuration */
>> +#define X_CQ_CFG_PB_GEN                         0x14
>> +#define CQ_CFG_PB_GEN                           0x0A0
>> +#define    CQ_CFG_PB_GEN_PB_INIT                PPC_BIT(45)
>> +
>> +/*
>> + * FIR
>> + *     (And-Mask)
>> + *     (Or-Mask)
>> + */
>> +#define X_CQ_FIR                                0x30
>> +#define X_CQ_FIR_AND                            0x31
>> +#define X_CQ_FIR_OR                             0x32
>> +#define CQ_FIR                                  0x180
>> +#define CQ_FIR_AND                              0x188
>> +#define CQ_FIR_OR                               0x190
>> +#define  CQ_FIR_PB_RCMDX_CI_ERR1                PPC_BIT(19)
>> +#define  CQ_FIR_VC_INFO_ERROR_0_2               PPC_BITMASK(61, 63)
>> +
>> +/*
>> + * FIR Mask
>> + *     (And-Mask)
>> + *     (Or-Mask)
>> + */
>> +#define X_CQ_FIRMASK                            0x33
>> +#define X_CQ_FIRMASK_AND                        0x34
>> +#define X_CQ_FIRMASK_OR                         0x35
>> +#define CQ_FIRMASK                              0x198
>> +#define CQ_FIRMASK_AND                          0x1A0
>> +#define CQ_FIRMASK_OR                           0x1A8
>> +
>> +/*
>> + * VC0
>> + */
>> +
>> +/* VSD table address */
>> +#define X_VC_VSD_TABLE_ADDR                     0x100
>> +#define VC_VSD_TABLE_ADDR                       0x000
>> +#define   VC_VSD_TABLE_AUTOINC                  PPC_BIT(0)
>> +#define   VC_VSD_TABLE_SELECT                   PPC_BITMASK(12, 15)
>> +#define   VC_VSD_TABLE_ADDRESS                  PPC_BITMASK(28, 31)
>> +
>> +/* VSD table data */
>> +#define X_VC_VSD_TABLE_DATA                     0x101
>> +#define VC_VSD_TABLE_DATA                       0x008
>> +
>> +/* AIB AT macro indirect kill */
>> +#define X_VC_AT_MACRO_KILL                      0x102
>> +#define VC_AT_MACRO_KILL                        0x010
>> +#define  VC_AT_MACRO_KILL_VALID                 PPC_BIT(0)
>> +#define  VC_AT_MACRO_KILL_VSD                   PPC_BITMASK(12, 15)
>> +#define  VC_AT_MACRO_KILL_BLOCK_ID              PPC_BITMASK(28, 31)
>> +#define  VC_AT_MACRO_KILL_OFFSET                PPC_BITMASK(48, 60)
>> +
>> +/* AIB AT macro indirect kill mask (same bit definitions) */
>> +#define X_VC_AT_MACRO_KILL_MASK                 0x103
>> +#define VC_AT_MACRO_KILL_MASK                   0x018
>> +
>> +/* Remote IRQs and ERQs configuration [n] (n = 0:6) */
>> +#define X_VC_QUEUES_CFG_REM0                    0x117
>> +
>> +#define VC_QUEUES_CFG_REM0                      0x0B8
>> +#define VC_QUEUES_CFG_REM1                      0x0C0
>> +#define VC_QUEUES_CFG_REM2                      0x0C8
>> +#define VC_QUEUES_CFG_REM3                      0x0D0
>> +#define VC_QUEUES_CFG_REM4                      0x0D8
>> +#define VC_QUEUES_CFG_REM5                      0x0E0
>> +#define VC_QUEUES_CFG_REM6                      0x0E8
>> +#define  VC_QUEUES_CFG_MEMB_EN                  PPC_BIT(38)
>> +#define  VC_QUEUES_CFG_MEMB_SZ                  PPC_BITMASK(42, 47)
>> +
>> +/*
>> + * VC1
>> + */
>> +
>> +/* ESBC cache flush control trigger */
>> +#define X_VC_ESBC_FLUSH_CTRL                    0x140
>> +#define VC_ESBC_FLUSH_CTRL                      0x200
>> +#define  VC_ESBC_FLUSH_CTRL_POLL_VALID          PPC_BIT(0)
>> +#define  VC_ESBC_FLUSH_CTRL_WANT_CACHE_DISABLE  PPC_BIT(2)
>> +
>> +/* ESBC cache flush poll trigger */
>> +#define X_VC_ESBC_FLUSH_POLL                    0x141
>> +#define VC_ESBC_FLUSH_POLL                      0x208
>> +#define  VC_ESBC_FLUSH_POLL_BLOCK_ID            PPC_BITMASK(0, 3)
>> +#define  VC_ESBC_FLUSH_POLL_OFFSET              PPC_BITMASK(4, 31)  /* 28-bit */
>> +#define  VC_ESBC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(32, 35)
>> +#define  VC_ESBC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(36, 63) /* 28-bit */
>> +
>> +/* EASC flush control register */
>> +#define X_VC_EASC_FLUSH_CTRL                    0x160
>> +#define VC_EASC_FLUSH_CTRL                      0x300
>> +#define  VC_EASC_FLUSH_CTRL_POLL_VALID          PPC_BIT(0)
>> +#define  VC_EASC_FLUSH_CTRL_WANT_CACHE_DISABLE  PPC_BIT(2)
>> +
>> +/* EASC flush poll register */
>> +#define X_VC_EASC_FLUSH_POLL                    0x161
>> +#define VC_EASC_FLUSH_POLL                      0x308
>> +#define  VC_EASC_FLUSH_POLL_BLOCK_ID            PPC_BITMASK(0, 3)
>> +#define  VC_EASC_FLUSH_POLL_OFFSET              PPC_BITMASK(4, 31)  /* 28-bit */
>> +#define  VC_EASC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(32, 35)
>> +#define  VC_EASC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(36, 63) /* 28-bit */
>> +
>> +/*
>> + * VC2
>> + */
>> +
>> +/* ENDC flush control register */
>> +#define X_VC_ENDC_FLUSH_CTRL                    0x180
>> +#define VC_ENDC_FLUSH_CTRL                      0x400
>> +#define  VC_ENDC_FLUSH_CTRL_POLL_VALID          PPC_BIT(0)
>> +#define  VC_ENDC_FLUSH_CTRL_WANT_CACHE_DISABLE  PPC_BIT(2)
>> +#define  VC_ENDC_FLUSH_CTRL_WANT_INVALIDATE     PPC_BIT(3)
>> +#define  VC_ENDC_FLUSH_CTRL_INJECT_INVALIDATE   PPC_BIT(7)
>> +
>> +/* ENDC flush poll register */
>> +#define X_VC_ENDC_FLUSH_POLL                    0x181
>> +#define VC_ENDC_FLUSH_POLL                      0x408
>> +#define  VC_ENDC_FLUSH_POLL_BLOCK_ID            PPC_BITMASK(4, 7)
>> +#define  VC_ENDC_FLUSH_POLL_OFFSET              PPC_BITMASK(8, 31)  /* 24-bit */
>> +#define  VC_ENDC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(36, 39)
>> +#define  VC_ENDC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(40, 63) /* 24-bit */
>> +
>> +/* ENDC Sync done */
>> +#define X_VC_ENDC_SYNC_DONE                     0x184
>> +#define VC_ENDC_SYNC_DONE                       0x420
>> +#define   VC_ENDC_SYNC_POLL_DONE                PPC_BITMASK(0, 6)
>> +#define   VC_ENDC_SYNC_QUEUE_IPI                PPC_BIT(0)
>> +#define   VC_ENDC_SYNC_QUEUE_HWD                PPC_BIT(1)
>> +#define   VC_ENDC_SYNC_QUEUE_NXC                PPC_BIT(2)
>> +#define   VC_ENDC_SYNC_QUEUE_INT                PPC_BIT(3)
>> +#define   VC_ENDC_SYNC_QUEUE_OS                 PPC_BIT(4)
>> +#define   VC_ENDC_SYNC_QUEUE_POOL               PPC_BIT(5)
>> +#define   VC_ENDC_SYNC_QUEUE_HARD               PPC_BIT(6)
>> +#define   VC_QUEUE_COUNT                        7
>> +
>> +/* ENDC cache watch specification 0  */
>> +#define X_VC_ENDC_WATCH0_SPEC                   0x1A0
>> +#define VC_ENDC_WATCH0_SPEC                     0x500
>> +#define   VC_ENDC_WATCH_CONFLICT                PPC_BIT(0)
>> +#define   VC_ENDC_WATCH_FULL                    PPC_BIT(8)
>> +#define   VC_ENDC_WATCH_BLOCK_ID                PPC_BITMASK(28, 31)
>> +#define   VC_ENDC_WATCH_INDEX                   PPC_BITMASK(40, 63)
>> +
>> +/* ENDC cache watch data 0 */
>> +#define X_VC_ENDC_WATCH0_DATA0                  0x1A4
>> +#define X_VC_ENDC_WATCH0_DATA1                  0x1A5
>> +#define X_VC_ENDC_WATCH0_DATA2                  0x1A6
>> +#define X_VC_ENDC_WATCH0_DATA3                  0x1A7
>> +
>> +#define VC_ENDC_WATCH0_DATA0                    0x520
>> +#define VC_ENDC_WATCH0_DATA1                    0x528
>> +#define VC_ENDC_WATCH0_DATA2                    0x530
>> +#define VC_ENDC_WATCH0_DATA3                    0x538
>> +
>> +/*
>> + * PC LSB1
>> + */
>> +
>> +/* VSD table address register */
>> +#define X_PC_VSD_TABLE_ADDR                     0x200
>> +#define PC_VSD_TABLE_ADDR                       0x000
>> +#define   PC_VSD_TABLE_AUTOINC                  PPC_BIT(0)
>> +#define   PC_VSD_TABLE_SELECT                   PPC_BITMASK(12, 15)
>> +#define   PC_VSD_TABLE_ADDRESS                  PPC_BITMASK(28, 31)
>> +
>> +/* VSD table data register */
>> +#define X_PC_VSD_TABLE_DATA                     0x201
>> +#define PC_VSD_TABLE_DATA                       0x008
>> +
>> +/* AT indirect kill register */
>> +#define X_PC_AT_KILL                            0x202
>> +#define PC_AT_KILL                              0x010
>> +#define     PC_AT_KILL_VALID                    PPC_BIT(0)
>> +#define     PC_AT_KILL_VSD_TYPE                 PPC_BITMASK(24, 27)
>> +/* Only NVP, NVG, NVC */
>> +#define     PC_AT_KILL_BLOCK_ID                 PPC_BITMASK(28, 31)
>> +#define     PC_AT_KILL_OFFSET                   PPC_BITMASK(48, 60)
>> +
>> +/* AT indirect kill mask register */
>> +#define X_PC_AT_KILL_MASK                       0x203
>> +#define PC_AT_KILL_MASK                         0x018
>> +#define     PC_AT_KILL_MASK_VSD_TYPE            PPC_BITMASK(24, 27)
>> +#define     PC_AT_KILL_MASK_BLOCK_ID            PPC_BITMASK(28, 31)
>> +#define     PC_AT_KILL_MASK_OFFSET              PPC_BITMASK(48, 60)
>> +
>> +/*
>> + * PC LSB2
>> + */
>> +
>> +/* NxC Cache flush control */
>> +#define X_PC_NXC_FLUSH_CTRL                     0x280
>> +#define PC_NXC_FLUSH_CTRL                       0x400
>> +#define  PC_NXC_FLUSH_CTRL_POLL_VALID           PPC_BIT(0)
>> +#define  PC_NXC_FLUSH_CTRL_WANT_CACHE_DISABLE   PPC_BIT(2)
>> +#define  PC_NXC_FLUSH_CTRL_WANT_INVALIDATE      PPC_BIT(3)
>> +#define  PC_NXC_FLUSH_CTRL_INJECT_INVALIDATE    PPC_BIT(7)
>> +
>> +/* NxC Cache flush poll */
>> +#define X_PC_NXC_FLUSH_POLL                     0x281
>> +#define PC_NXC_FLUSH_POLL                       0x408
>> +#define  PC_NXC_FLUSH_POLL_NXC_TYPE             PPC_BITMASK(2, 3)
>> +#define    PC_NXC_FLUSH_POLL_NXC_TYPE_NVP       0
>> +#define    PC_NXC_FLUSH_POLL_NXC_TYPE_NVG       2
>> +#define    PC_NXC_FLUSH_POLL_NXC_TYPE_NVC       3
>> +#define  PC_NXC_FLUSH_POLL_BLOCK_ID             PPC_BITMASK(4, 7)
>> +#define  PC_NXC_FLUSH_POLL_OFFSET               PPC_BITMASK(8, 31)  /* 24-bit */
>> +#define  PC_NXC_FLUSH_POLL_NXC_TYPE_MASK        PPC_BITMASK(34, 35) /* 0: Ign */
>> +#define  PC_NXC_FLUSH_POLL_BLOCK_ID_MASK        PPC_BITMASK(36, 39)
>> +#define  PC_NXC_FLUSH_POLL_OFFSET_MASK          PPC_BITMASK(40, 63) /* 24-bit */
>> +
>> +/* NxC Cache Watch 0 Specification */
>> +#define X_PC_NXC_WATCH0_SPEC                    0x2A0
>> +#define PC_NXC_WATCH0_SPEC                      0x500
>> +#define   PC_NXC_WATCH_CONFLICT                 PPC_BIT(0)
>> +#define   PC_NXC_WATCH_FULL                     PPC_BIT(8)
>> +#define   PC_NXC_WATCH_NXC_TYPE                 PPC_BITMASK(26, 37)
>> +#define     PC_NXC_WATCH_NXC_NVP                0
>> +#define     PC_NXC_WATCH_NXC_NVG                2
>> +#define     PC_NXC_WATCH_NXC_NVC                3
>> +#define   PC_NXC_WATCH_BLOCK_ID                 PPC_BITMASK(28, 31)
>> +#define   PC_NXC_WATCH_INDEX                    PPC_BITMASK(40, 63)
>> +
>> +/* NxC Cache Watch 0 Data */
>> +#define X_PC_NXC_WATCH0_DATA0                   0x2A4
>> +#define X_PC_NXC_WATCH0_DATA1                   0x2A5
>> +#define X_PC_NXC_WATCH0_DATA2                   0x2A6
>> +#define X_PC_NXC_WATCH0_DATA3                   0x2A7
>> +
>> +#define PC_NXC_WATCH0_DATA0                     0x520
>> +#define PC_NXC_WATCH0_DATA1                     0x528
>> +#define PC_NXC_WATCH0_DATA2                     0x530
>> +#define PC_NXC_WATCH0_DATA3                     0x538
>> +
>> +/*
>> + * TCTXT Registers
>> + */
>> +
>> +/* Physical Thread Enable0 register */
>> +#define X_TCTXT_EN0                             0x300
>> +#define TCTXT_EN0                               0x000
>> +
>> +/* Physical Thread Enable0 Set register */
>> +#define X_TCTXT_EN0_SET                         0x302
>> +#define TCTXT_EN0_SET                           0x010
>> +
>> +/* Physical Thread Enable0 Reset register */
>> +#define X_TCTXT_EN0_RESET                       0x303
>> +#define TCTXT_EN0_RESET                         0x018
>> +
>> +/* Physical Thread Enable1 register */
>> +#define X_TCTXT_EN1                             0x304
>> +#define TCTXT_EN1                               0x020
>> +
>> +/* Physical Thread Enable1 Set register */
>> +#define X_TCTXT_EN1_SET                         0x306
>> +#define TCTXT_EN1_SET                           0x030
>> +
>> +/* Physical Thread Enable1 Reset register */
>> +#define X_TCTXT_EN1_RESET                       0x307
>> +#define TCTXT_EN1_RESET                         0x038
>> +
>> +/*
>> + * VSD Tables
>> + */
>> +#define VST_ESB                  0
>> +#define VST_EAS                  1 /* No used by PC */
>> +#define VST_END                  2
>> +#define VST_NVP                  3
>> +#define VST_NVG                  4
>> +#define VST_NVC                  5
>> +#define VST_IC                   6 /* No used by PC */
>> +#define VST_SYNC                 7
>> +#define VST_ERQ                  8 /* No used by PC */
>> +
>> +/*
>> + * Bits in a VSD entry.
>> + *
>> + * Note: the address is naturally aligned, we don't use a PPC_BITMASK,
>> + *       but just a mask to apply to the address before OR'ing it in.
>> + *
>> + * Note: VSD_FIRMWARE is a SW bit ! It hijacks an unused bit in the
>> + *       VSD and is only meant to be used in indirect mode !
>> + */
>> +#define VSD_MODE                PPC_BITMASK(0, 1)
>> +#define  VSD_MODE_SHARED        1
>> +#define  VSD_MODE_EXCLUSIVE     2
>> +#define  VSD_MODE_FORWARD       3
>> +#define VSD_FIRMWARE            PPC_BIT(2) /* Read warning */
>> +#define VSD_FIRMWARE2           PPC_BIT(3) /* unused */
>> +#define VSD_RESERVED            PPC_BITMASK(4, 7) /* P10 reserved */
>> +#define VSD_ADDRESS_MASK        0x00fffffffffff000ull
>> +#define VSD_MIGRATION_REG       PPC_BITMASK(52, 55)
>> +#define VSD_INDIRECT            PPC_BIT(56)
>> +#define VSD_TSIZE               PPC_BITMASK(59, 63)
>> +
>> +#endif /* PPC_PNV_XIVE2_REGS_H */
>> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
>> index d4b0b0e2ff71..f318bb10add4 100644
>> --- a/include/hw/ppc/pnv.h
>> +++ b/include/hw/ppc/pnv.h
>> @@ -119,10 +119,14 @@ typedef struct Pnv10Chip {
>>      PnvChip      parent_obj;
>>  
>>      /*< public >*/
>> +    PnvXive2     xive;
>>      Pnv9Psi      psi;
>>      PnvLpcController lpc;
>>  } Pnv10Chip;
>>  
>> +#define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
>> +#define PNV10_PIR2CHIP(pir)      (((pir) >> 8) & 0x7f)
>> +
>>  typedef struct PnvChipClass {
>>      /*< private >*/
>>      SysBusDeviceClass parent_class;
>> @@ -340,10 +344,28 @@ void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
>>  #define PNV10_LPCM_SIZE             0x0000000100000000ull
>>  #define PNV10_LPCM_BASE(chip)       PNV10_CHIP_BASE(chip, 0x0006030000000000ull)
>>  
>> +#define PNV10_XIVE2_IC_SIZE         0x0000000002000000ull
>> +#define PNV10_XIVE2_IC_BASE(chip)   PNV10_CHIP_BASE(chip, 0x0006030200000000ull)
>> +
>>  #define PNV10_PSIHB_ESB_SIZE        0x0000000000100000ull
>>  #define PNV10_PSIHB_ESB_BASE(chip)  PNV10_CHIP_BASE(chip, 0x0006030202000000ull)
>>  
>>  #define PNV10_PSIHB_SIZE            0x0000000000100000ull
>>  #define PNV10_PSIHB_BASE(chip)      PNV10_CHIP_BASE(chip, 0x0006030203000000ull)
>>  
>> +#define PNV10_XIVE2_TM_SIZE         0x0000000000040000ull
>> +#define PNV10_XIVE2_TM_BASE(chip)   PNV10_CHIP_BASE(chip, 0x0006030203180000ull)
>> +
>> +#define PNV10_XIVE2_NVC_SIZE        0x0000000008000000ull
>> +#define PNV10_XIVE2_NVC_BASE(chip)  PNV10_CHIP_BASE(chip, 0x0006030208000000ull)
>> +
>> +#define PNV10_XIVE2_NVPG_SIZE       0x0000010000000000ull
>> +#define PNV10_XIVE2_NVPG_BASE(chip) PNV10_CHIP_BASE(chip, 0x0006040000000000ull)
>> +
>> +#define PNV10_XIVE2_ESB_SIZE        0x0000010000000000ull
>> +#define PNV10_XIVE2_ESB_BASE(chip)  PNV10_CHIP_BASE(chip, 0x0006050000000000ull)
>> +
>> +#define PNV10_XIVE2_END_SIZE        0x0000020000000000ull
>> +#define PNV10_XIVE2_END_BASE(chip)  PNV10_CHIP_BASE(chip, 0x0006060000000000ull)
>> +
>>  #endif /* PPC_PNV_H */
>> diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
>> index 76cf16f64472..7d8630775786 100644
>> --- a/include/hw/ppc/pnv_xive.h
>> +++ b/include/hw/ppc/pnv_xive.h
>> @@ -11,6 +11,7 @@
>>  #define PPC_PNV_XIVE_H
>>  
>>  #include "hw/ppc/xive.h"
>> +#include "hw/ppc/xive2.h"
>>  
>>  struct PnvChip;
>>  
>> @@ -97,4 +98,74 @@ typedef struct PnvXiveClass {
>>  
>>  void pnv_xive_pic_print_info(PnvXive *xive, Monitor *mon);
>>  
>> +/*
>> + * XIVE2 interrupt controller (POWER10)
>> + */
>> +#define TYPE_PNV_XIVE2 TYPE_PNV_XIVE "2"
>> +#define PNV_XIVE2(obj) OBJECT_CHECK(PnvXive2, (obj), TYPE_PNV_XIVE2)
>> +#define PNV_XIVE2_CLASS(klass)                                   \
>> +    OBJECT_CLASS_CHECK(PnvXive2Class, (klass), TYPE_PNV_XIVE2)
>> +#define PNV_XIVE2_GET_CLASS(obj)                                 \
>> +    OBJECT_GET_CLASS(PnvXive2Class, (obj), TYPE_PNV_XIVE2)
>> +
>> +typedef struct PnvXive2 {
>> +    Xive2Router   parent_obj;
>> +
>> +    /* Owning chip */
>> +    struct PnvChip *chip;
>> +
>> +    /* XSCOM addresses giving access to the controller registers */
>> +    MemoryRegion  xscom_regs;
>> +
>> +    MemoryRegion  ic_mmio;
>> +    MemoryRegion  ic_mmios[8];
>> +    MemoryRegion  esb_mmio;
>> +    MemoryRegion  end_mmio;
>> +    MemoryRegion  nvc_mmio;
>> +    MemoryRegion  nvpg_mmio;
>> +    MemoryRegion  tm_mmio;
>> +
>> +    /* Shortcut values for the Main MMIO regions */
>> +    hwaddr        ic_base;
>> +    uint32_t      ic_shift;
>> +    hwaddr        esb_base;
>> +    uint32_t      esb_shift;
>> +    hwaddr        end_base;
>> +    uint32_t      end_shift;
>> +    hwaddr        nvc_base;
>> +    uint32_t      nvc_shift;
>> +    hwaddr        nvpg_base;
>> +    uint32_t      nvpg_shift;
>> +    hwaddr        tm_base;
>> +    uint32_t      tm_shift;
>> +
>> +    /* Interrupt controller registers */
>> +    uint64_t      cq_regs[0x40];
>> +    uint64_t      vc_regs[0x100];
>> +    uint64_t      pc_regs[0x100];
>> +    uint64_t      tctxt_regs[0x30];
>> +
>> +    /* Our XIVE source objects for IPIs and ENDs */
>> +    XiveSource    ipi_source;
>> +    Xive2EndSource end_source;
>> +
>> +    /*
>> +     * Virtual Structure Descriptor tables
>> +     * These are in a SRAM protected by ECC.
>> +     */
>> +    uint64_t      vsds[9][XIVE_BLOCK_MAX];
>> +
>> +    /* Translation tables */
>> +    uint64_t      tables[8][XIVE_BLOCK_MAX];
>> +
>> +} PnvXive2;
>> +
>> +typedef struct PnvXive2Class {
>> +    Xive2RouterClass parent_class;
>> +
>> +    DeviceRealize parent_realize;
>> +} PnvXive2Class;
>> +
>> +void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon);
>> +
>>  #endif /* PPC_PNV_XIVE_H */
>> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
>> index 09156a5a7a6f..1211add3e79c 100644
>> --- a/include/hw/ppc/pnv_xscom.h
>> +++ b/include/hw/ppc/pnv_xscom.h
>> @@ -133,6 +133,9 @@ typedef struct PnvXScomInterfaceClass {
>>  #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
>>  #define PNV10_XSCOM_PSIHB_SIZE     0x100
>>  
>> +#define PNV10_XSCOM_XIVE2_BASE     0x2010800
>> +#define PNV10_XSCOM_XIVE2_SIZE     0x400
>> +
>>  void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
>>  int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
>>                   uint64_t xscom_base, uint64_t xscom_size,
>> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>> new file mode 100644
>> index 000000000000..761e9406315a
>> --- /dev/null
>> +++ b/hw/intc/pnv_xive2.c
>> @@ -0,0 +1,2026 @@
>> +/*
>> + * QEMU PowerPC XIVE2 interrupt controller model  (POWER10)
>> + *
>> + * Copyright (c) 2019-2020, IBM Corporation.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "qapi/error.h"
>> +#include "target/ppc/cpu.h"
>> +#include "sysemu/cpus.h"
>> +#include "sysemu/dma.h"
>> +#include "monitor/monitor.h"
>> +#include "hw/ppc/fdt.h"
>> +#include "hw/ppc/pnv.h"
>> +#include "hw/ppc/pnv_core.h"
>> +#include "hw/ppc/pnv_xscom.h"
>> +#include "hw/ppc/xive2.h"
>> +#include "hw/ppc/pnv_xive.h"
>> +#include "hw/ppc/xive_regs.h"
>> +#include "hw/ppc/xive2_regs.h"
>> +#include "hw/ppc/ppc.h"
>> +#include "hw/qdev-properties.h"
>> +#include "sysemu/reset.h"
>> +
>> +#include <libfdt.h>
>> +
>> +#include "pnv_xive2_regs.h"
>> +
>> +#undef XIVE2_DEBUG
>> +
>> +/*
>> + * Virtual structures table (VST)
>> + */
>> +#define SBE_PER_BYTE   4
>> +
>> +typedef struct XiveVstInfo {
>> +    const char *name;
>> +    uint32_t    size;
>> +    uint32_t    max_blocks;
>> +} XiveVstInfo;
>> +
>> +static const XiveVstInfo vst_infos[] = {
>> +
>> +    [VST_EAS]  = { "EAT",  sizeof(Xive2Eas),  16 },
>> +    [VST_ESB]  = { "ESB",  1,                  16 },
>> +    [VST_END]  = { "ENDT", sizeof(Xive2End),  16 },
>> +
>> +    [VST_NVP]  = { "NVPT", sizeof(Xive2Nvp),  16 },
>> +    [VST_NVG]  = { "NVGT", sizeof(Xive2Nvgc), 16 },
>> +    [VST_NVC]  = { "NVCT", sizeof(Xive2Nvgc), 16 },
>> +
>> +    [VST_IC]  =  { "IC",   1 /* ? */         , 16 }, /* Topology # */
>> +    [VST_SYNC] = { "SYNC", 1 /* ? */         , 16 }, /* Topology # */
>> +
>> +    /*
>> +     * This table contains the backing store pages for the interrupt
>> +     * fifos of the VC sub-engine in case of overflow.
>> +     *
>> +     * 0 - IPI,
>> +     * 1 - HWD,
>> +     * 2 - NxC,
>> +     * 3 - INT,
>> +     * 4 - OS-Queue,
>> +     * 5 - Pool-Queue,
>> +     * 6 - Hard-Queue
>> +     */
>> +    [VST_ERQ]  = { "ERQ",  1,                   VC_QUEUE_COUNT },
>> +};
>> +
>> +#define xive2_error(xive, fmt, ...)                                      \
>> +    qemu_log_mask(LOG_GUEST_ERROR, "XIVE[%x] - " fmt "\n",              \
>> +                  (xive)->chip->chip_id, ## __VA_ARGS__);
>> +
>> +/*
>> + * QEMU version of the GETFIELD/SETFIELD macros
>> + *
>> + * TODO: It might be better to use the existing extract64() and
>> + * deposit64() but this means that all the register definitions will
>> + * change and become incompatible with the ones found in skiboot.
>> + *
>> + * Keep it as it is for now until we find a common ground.
>> + */
>> +static inline uint64_t GETFIELD(uint64_t mask, uint64_t word)
>> +{
>> +    return (word & mask) >> ctz64(mask);
>> +}
>> +
>> +static inline uint64_t SETFIELD(uint64_t mask, uint64_t word,
>> +                                uint64_t value)
>> +{
>> +    return (word & ~mask) | ((value << ctz64(mask)) & mask);
>> +}
>> +
>> +/*
>> + * TODO: Document block id override
>> + */
>> +static uint32_t pnv_xive2_block_id(PnvXive2 *xive)
>> +{
>> +    uint8_t blk = xive->chip->chip_id;
>> +    uint64_t cfg_val = xive->cq_regs[CQ_XIVE_CFG >> 3];
>> +
>> +    if (cfg_val & CQ_XIVE_CFG_HYP_HARD_BLKID_OVERRIDE) {
>> +        blk = GETFIELD(CQ_XIVE_CFG_HYP_HARD_BLOCK_ID, cfg_val);
>> +    }
>> +
>> +    return blk;
>> +}
>> +
>> +/*
>> + * Remote access to controllers. HW uses MMIOs. For now, a simple scan
>> + * of the chips is good enough.
>> + *
>> + * TODO: Block scope support
>> + */
>> +static PnvXive2 *pnv_xive2_get_remote(uint8_t blk)
>> +{
>> +    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
>> +    int i;
>> +
>> +    for (i = 0; i < pnv->num_chips; i++) {
>> +        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
>> +        PnvXive2 *xive = &chip10->xive;
>> +
>> +        if (pnv_xive2_block_id(xive) == blk) {
>> +            return xive;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>> +/*
>> + * VST accessors for ESB, EAT, ENDT, NVP
>> + *
>> + * Indirect VST tables are arrays of VSDs pointing to a page (of same
>> + * size). Each page is a direct VST table.
>> + */
>> +
>> +#define XIVE_VSD_SIZE 8
>> +
>> +/* Indirect page size can be 4K, 64K, 2M, 16M. */
>> +static uint64_t pnv_xive2_vst_page_size_allowed(uint32_t page_shift)
>> +{
>> +     return page_shift == 12 || page_shift == 16 ||
>> +         page_shift == 21 || page_shift == 24;
>> +}
>> +
>> +static uint64_t pnv_xive2_vst_addr_direct(PnvXive2 *xive, uint32_t type,
>> +                                         uint64_t vsd, uint32_t idx)
>> +{
>> +    const XiveVstInfo *info = &vst_infos[type];
>> +    uint64_t vst_addr = vsd & VSD_ADDRESS_MASK;
>> +    uint64_t vst_tsize = 1ull << (GETFIELD(VSD_TSIZE, vsd) + 12);
>> +    uint32_t idx_max;
>> +
>> +    idx_max = vst_tsize / info->size - 1;
>> +    if (idx > idx_max) {
>> +#ifdef XIVE2_DEBUG
>> +        xive2_error(xive, "VST: %s entry %x out of range [ 0 .. %x ] !?",
>> +                   info->name, idx, idx_max);
>> +#endif
>> +        return 0;
>> +    }
>> +
>> +    return vst_addr + idx * info->size;
>> +}
>> +
>> +static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
>> +                                           uint64_t vsd, uint32_t idx)
>> +{
>> +    const XiveVstInfo *info = &vst_infos[type];
>> +    uint64_t vsd_addr;
>> +    uint32_t vsd_idx;
>> +    uint32_t page_shift;
>> +    uint32_t vst_per_page;
>> +
>> +    /* Get the page size of the indirect table. */
>> +    vsd_addr = vsd & VSD_ADDRESS_MASK;
>> +    vsd = ldq_be_dma(&address_space_memory, vsd_addr);
>> +
>> +    if (!(vsd & VSD_ADDRESS_MASK)) {
>> +        xive2_error(xive, "VST: invalid %s entry %x !?", info->name, idx);
>> +        return 0;
>> +    }
>> +
>> +    page_shift = GETFIELD(VSD_TSIZE, vsd) + 12;
>> +
>> +    if (!pnv_xive2_vst_page_size_allowed(page_shift)) {
>> +        xive2_error(xive, "VST: invalid %s page shift %d", info->name,
>> +                   page_shift);
>> +        return 0;
>> +    }
>> +
>> +    vst_per_page = (1ull << page_shift) / info->size;
>> +    vsd_idx = idx / vst_per_page;
>> +
>> +    /* Load the VSD we are looking for, if not already done */
>> +    if (vsd_idx) {
>> +        vsd_addr = vsd_addr + vsd_idx * XIVE_VSD_SIZE;
>> +        vsd = ldq_be_dma(&address_space_memory, vsd_addr);
>> +
>> +        if (!(vsd & VSD_ADDRESS_MASK)) {
>> +            xive2_error(xive, "VST: invalid %s entry %x !?", info->name, idx);
>> +            return 0;
>> +        }
>> +
>> +        /*
>> +         * Check that the pages have a consistent size across the
>> +         * indirect table
>> +         */
>> +        if (page_shift != GETFIELD(VSD_TSIZE, vsd) + 12) {
>> +            xive2_error(xive, "VST: %s entry %x indirect page size differ !?",
>> +                       info->name, idx);
>> +            return 0;
>> +        }
>> +    }
>> +
>> +    return pnv_xive2_vst_addr_direct(xive, type, vsd, (idx % vst_per_page));
>> +}
>> +
>> +static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
>> +                                  uint32_t idx)
>> +{
>> +    const XiveVstInfo *info = &vst_infos[type];
>> +    uint64_t vsd;
>> +
>> +    if (blk >= info->max_blocks) {
>> +        xive2_error(xive, "VST: invalid block id %d for VST %s %d !?",
>> +                   blk, info->name, idx);
>> +        return 0;
>> +    }
>> +
>> +    vsd = xive->vsds[type][blk];
>> +
>> +    /* Remote VST access */
>> +    if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
>> +        xive = pnv_xive2_get_remote(blk);
>> +
>> +        return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
>> +    }
>> +
>> +    if (VSD_INDIRECT & vsd) {
>> +        return pnv_xive2_vst_addr_indirect(xive, type, vsd, idx);
>> +    }
>> +
>> +    return pnv_xive2_vst_addr_direct(xive, type, vsd, idx);
>> +}
>> +
>> +static int pnv_xive2_vst_read(PnvXive2 *xive, uint32_t type, uint8_t blk,
>> +                             uint32_t idx, void *data)
>> +{
>> +    const XiveVstInfo *info = &vst_infos[type];
>> +    uint64_t addr = pnv_xive2_vst_addr(xive, type, blk, idx);
>> +
>> +    if (!addr) {
>> +        return -1;
>> +    }
>> +
>> +    cpu_physical_memory_read(addr, data, info->size);
>> +    return 0;
>> +}
>> +
>> +#define XIVE_VST_WORD_ALL -1
>> +
>> +static int pnv_xive2_vst_write(PnvXive2 *xive, uint32_t type, uint8_t blk,
>> +                              uint32_t idx, void *data, uint32_t word_number)
>> +{
>> +    const XiveVstInfo *info = &vst_infos[type];
>> +    uint64_t addr = pnv_xive2_vst_addr(xive, type, blk, idx);
>> +
>> +    if (!addr) {
>> +        return -1;
>> +    }
>> +
>> +    if (word_number == XIVE_VST_WORD_ALL) {
>> +        cpu_physical_memory_write(addr, data, info->size);
>> +    } else {
>> +        cpu_physical_memory_write(addr + word_number * 4,
>> +                                  data + word_number * 4, 4);
>> +    }
>> +    return 0;
>> +}
>> +
>> +static int pnv_xive2_get_end(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
>> +                            Xive2End *end)
>> +{
>> +    return pnv_xive2_vst_read(PNV_XIVE2(xrtr), VST_END, blk, idx, end);
>> +}
>> +
>> +static int pnv_xive2_write_end(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
>> +                              Xive2End *end, uint8_t word_number)
>> +{
>> +    return pnv_xive2_vst_write(PNV_XIVE2(xrtr), VST_END, blk, idx, end,
>> +                              word_number);
>> +}
>> +
>> +static int pnv_xive2_end_update(PnvXive2 *xive)
>> +{
>> +    uint8_t  blk = GETFIELD(VC_ENDC_WATCH_BLOCK_ID,
>> +                           xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>> +    uint32_t idx = GETFIELD(VC_ENDC_WATCH_INDEX,
>> +                           xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>> +    int i;
>> +    uint64_t endc_watch[4];
>> +
>> +    for (i = 0; i < ARRAY_SIZE(endc_watch); i++) {
>> +        endc_watch[i] =
>> +            cpu_to_be64(xive->vc_regs[(VC_ENDC_WATCH0_DATA0 >> 3) + i]);
>> +    }
>> +
>> +    return pnv_xive2_vst_write(xive, VST_END, blk, idx, endc_watch,
>> +                              XIVE_VST_WORD_ALL);
>> +}
>> +
>> +static void pnv_xive2_end_cache_load(PnvXive2 *xive)
>> +{
>> +    uint8_t  blk = GETFIELD(VC_ENDC_WATCH_BLOCK_ID,
>> +                           xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>> +    uint32_t idx = GETFIELD(VC_ENDC_WATCH_INDEX,
>> +                           xive->vc_regs[(VC_ENDC_WATCH0_SPEC >> 3)]);
>> +    uint64_t endc_watch[4] = { 0 };
>> +    int i;
>> +
>> +    if (pnv_xive2_vst_read(xive, VST_END, blk, idx, endc_watch)) {
>> +        xive2_error(xive, "VST: no END entry %x/%x !?", blk, idx);
>> +    }
>> +
>> +    for (i = 0; i < ARRAY_SIZE(endc_watch); i++) {
>> +        xive->vc_regs[(VC_ENDC_WATCH0_DATA0 >> 3) + i] =
>> +            be64_to_cpu(endc_watch[i]);
>> +    }
>> +}
>> +
>> +static int pnv_xive2_get_nvp(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
>> +                            Xive2Nvp *nvp)
>> +{
>> +    return pnv_xive2_vst_read(PNV_XIVE2(xrtr), VST_NVP, blk, idx, nvp);
>> +}
>> +
>> +static int pnv_xive2_write_nvp(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
>> +                              Xive2Nvp *nvp, uint8_t word_number)
>> +{
>> +    return pnv_xive2_vst_write(PNV_XIVE2(xrtr), VST_NVP, blk, idx, nvp,
>> +                              word_number);
>> +}
>> +
>> +static int pnv_xive2_nvp_update(PnvXive2 *xive)
>> +{
>> +    uint8_t  blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID,
>> +                            xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>> +    uint32_t idx = GETFIELD(PC_NXC_WATCH_INDEX,
>> +                            xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>> +    int i;
>> +    uint64_t nxc_watch[4];
>> +
>> +    for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
>> +        nxc_watch[i] =
>> +            cpu_to_be64(xive->pc_regs[(PC_NXC_WATCH0_DATA0 >> 3) + i]);
>> +    }
>> +
>> +    return pnv_xive2_vst_write(xive, VST_NVP, blk, idx, nxc_watch,
>> +                              XIVE_VST_WORD_ALL);
>> +}
>> +
>> +static void pnv_xive2_nvp_cache_load(PnvXive2 *xive)
>> +{
>> +    uint8_t  blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID,
>> +                           xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>> +    uint32_t idx = GETFIELD(PC_NXC_WATCH_INDEX,
>> +                           xive->pc_regs[(PC_NXC_WATCH0_SPEC >> 3)]);
>> +    uint64_t nxc_watch[4] = { 0 };
>> +    int i;
>> +
>> +    if (pnv_xive2_vst_read(xive, VST_NVP, blk, idx, nxc_watch)) {
>> +        xive2_error(xive, "VST: no NVP entry %x/%x !?", blk, idx);
>> +    }
>> +
>> +    for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
>> +        xive->pc_regs[(PC_NXC_WATCH0_DATA0 >> 3) + i] =
>> +            be64_to_cpu(nxc_watch[i]);
>> +    }
>> +}
>> +
>> +static int pnv_xive2_get_eas(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
>> +                            Xive2Eas *eas)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(xrtr);
>> +
>> +    if (pnv_xive2_block_id(xive) != blk) {
>> +        xive2_error(xive, "VST: EAS %x is remote !?", XIVE_EAS(blk, idx));
>> +        return -1;
>> +    }
>> +
>> +    return pnv_xive2_vst_read(xive, VST_EAS, blk, idx, eas);
>> +}
>> +
>> +static bool pnv_xive2_is_cpu_enabled(PnvXive2 *xive, PowerPCCPU *cpu)
>> +{
>> +    int pir = ppc_cpu_pir(cpu);
>> +    uint32_t fc = PNV10_PIR2FUSEDCORE(pir);
>> +    uint64_t reg = fc < 8 ? TCTXT_EN0 : TCTXT_EN1;
>> +    uint32_t bit = pir & 0x3f;
>> +
>> +    return xive->tctxt_regs[reg >> 3] & PPC_BIT(bit);
>> +}
>> +
>> +static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>> +                                uint8_t nvt_blk, uint32_t nvt_idx,
>> +                                bool cam_ignore, uint8_t priority,
>> +                                uint32_t logic_serv, XiveTCTXMatch *match)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(xptr);
>> +    PnvChip *chip = xive->chip;
>> +    int count = 0;
>> +    int i, j;
>> +
>> +    for (i = 0; i < chip->nr_cores; i++) {
>> +        PnvCore *pc = chip->cores[i];
>> +        CPUCore *cc = CPU_CORE(pc);
>> +
>> +        for (j = 0; j < cc->nr_threads; j++) {
>> +            PowerPCCPU *cpu = pc->threads[j];
>> +            XiveTCTX *tctx;
>> +            int ring;
>> +
>> +            if (!pnv_xive2_is_cpu_enabled(xive, cpu)) {
>> +                continue;
>> +            }
>> +
>> +            tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>> +
>> +            ring = xive2_presenter_tctx_match(xptr, tctx, format, nvt_blk,
>> +                                              nvt_idx, cam_ignore,
>> +                                              logic_serv);
>> +
>> +            /*
>> +             * Save the context and follow on to catch duplicates,
>> +             * that we don't support yet.
>> +             */
>> +            if (ring != -1) {
>> +                if (match->tctx) {
>> +                    qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a "
>> +                                  "thread context NVT %x/%x\n",
>> +                                  nvt_blk, nvt_idx);
>> +                    return false;
>> +                }
>> +
>> +                match->ring = ring;
>> +                match->tctx = tctx;
>> +                count++;
>> +            }
>> +        }
>> +    }
>> +
>> +    return count;
>> +}
>> +
>> +static uint8_t pnv_xive2_get_block_id(Xive2Router *xrtr)
>> +{
>> +    return pnv_xive2_block_id(PNV_XIVE2(xrtr));
>> +}
>> +
>> +/*
>> + * The TIMA MMIO space is shared among the chips and to identify the
>> + * chip from which the access is being done, we extract the chip id
>> + * from the PIR.
>> + */
>> +static PnvXive2 *pnv_xive2_tm_get_xive(PowerPCCPU *cpu)
>> +{
>> +    int pir = ppc_cpu_pir(cpu);
>> +    XivePresenter *xptr = XIVE_TCTX(pnv_cpu_state(cpu)->intc)->xptr;
>> +    PnvXive2 *xive = PNV_XIVE2(xptr);
>> +
>> +    if (!pnv_xive2_is_cpu_enabled(xive, cpu)) {
>> +        xive2_error(xive, "IC: CPU %x is not enabled", pir);
>> +    }
>> +    return xive;
>> +}
>> +
>> +/*
>> + * The internal sources of the interrupt controller have no knowledge
>> + * of the XIVE2 chip on which they reside. Encode the block id in the
>> + * source interrupt number before forwarding the source event
>> + * notification to the Router. This is required on a multichip system.
>> + */
>> +static void pnv_xive2_notify(XiveNotifier *xn, uint32_t srcno)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(xn);
>> +    uint8_t blk = pnv_xive2_block_id(xive);
>> +
>> +    xive2_router_notify(xn, XIVE_EAS(blk, srcno));
>> +}
>> +
>> +/*
>> + * Set Translation Tables
>> + *
>> + * TODO add support for multiple sets
>> + */
>> +static int pnv_xive2_stt_set_data(PnvXive2 *xive, uint64_t val)
>> +{
>> +    uint8_t tsel = GETFIELD(CQ_TAR_SELECT, xive->cq_regs[CQ_TAR >> 3]);
>> +    uint8_t entry = GETFIELD(CQ_TAR_ENTRY_SELECT,
>> +                                  xive->cq_regs[CQ_TAR >> 3]);
>> +
>> +    switch (tsel) {
>> +    case CQ_TAR_NVPG:
>> +    case CQ_TAR_ESB:
>> +    case CQ_TAR_END:
>> +        xive->tables[tsel][entry] = val;
>> +        break;
>> +    default:
>> +        xive2_error(xive, "IC: unsupported table %d", tsel);
>> +        return -1;
>> +    }
>> +
>> +    if (xive->cq_regs[CQ_TAR >> 3] & CQ_TAR_AUTOINC) {
>> +        xive->cq_regs[CQ_TAR >> 3] = SETFIELD(CQ_TAR_ENTRY_SELECT,
>> +                     xive->cq_regs[CQ_TAR >> 3], ++entry);
>> +    }
>> +
>> +    return 0;
>> +}
>> +/*
>> + * Virtual Structure Tables (VST) configuration
>> + */
>> +static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive2, uint8_t type,
>> +                                       uint8_t blk, uint64_t vsd)
>> +{
>> +    Xive2EndSource *end_xsrc = &xive2->end_source;
>> +    XiveSource *xsrc = &xive2->ipi_source;
>> +    const XiveVstInfo *info = &vst_infos[type];
>> +    uint32_t page_shift = GETFIELD(VSD_TSIZE, vsd) + 12;
>> +    uint64_t vst_tsize = 1ull << page_shift;
>> +    uint64_t vst_addr = vsd & VSD_ADDRESS_MASK;
>> +
>> +    /* Basic checks */
>> +
>> +    if (VSD_INDIRECT & vsd) {
>> +        if (!pnv_xive2_vst_page_size_allowed(page_shift)) {
>> +            xive2_error(xive2, "VST: invalid %s page shift %d", info->name,
>> +                       page_shift);
>> +            return;
>> +        }
>> +    }
>> +
>> +    if (!QEMU_IS_ALIGNED(vst_addr, 1ull << page_shift)) {
>> +        xive2_error(xive2, "VST: %s table address 0x%"PRIx64
>> +                    " is not aligned with page shift %d",
>> +                    info->name, vst_addr, page_shift);
>> +        return;
>> +    }
>> +
>> +    /* Record the table configuration (in SRAM on HW) */
>> +    xive2->vsds[type][blk] = vsd;
>> +
>> +    /* Now tune the models with the configuration provided by the FW */
>> +
>> +    switch (type) {
>> +    case VST_ESB:
>> +        /*
>> +         * Backing store pages for the source PQ bits. The model does
>> +         * not use these PQ bits backed in RAM because the XiveSource
>> +         * model has its own.
>> +         *
>> +         * If the table is direct, we can compute the number of PQ
>> +         * entries provisioned by FW (such as skiboot) and resize the
>> +         * ESB window accordingly.
>> +         */
>> +        if (!(VSD_INDIRECT & vsd)) {
>> +            memory_region_set_size(&xsrc->esb_mmio, vst_tsize * SBE_PER_BYTE
>> +                                   * (1ull << xsrc->esb_shift));
>> +        }
>> +
>> +        memory_region_add_subregion(&xive2->esb_mmio, 0, &xsrc->esb_mmio);
>> +        break;
>> +
>> +    case VST_EAS:  /* Nothing to be done */
>> +        break;
>> +
>> +    case VST_END:
>> +        /*
>> +         * Backing store pages for the END.
>> +         */
>> +        if (!(VSD_INDIRECT & vsd)) {
>> +            memory_region_set_size(&end_xsrc->esb_mmio, (vst_tsize / info->size)
>> +                                   * (1ull << xsrc->esb_shift));
>> +        }
>> +        memory_region_add_subregion(&xive2->end_mmio, 0, &end_xsrc->esb_mmio);
>> +        break;
>> +
>> +    case VST_NVP:  /* Not modeled */
>> +    case VST_NVG:  /* Not modeled */
>> +    case VST_NVC:  /* Not modeled */
>> +    case VST_IC:   /* Not modeled */
>> +    case VST_SYNC: /* Not modeled */
>> +    case VST_ERQ:  /* Not modeled */
>> +        break;
>> +
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +}
>> +
>> +/*
>> + * Both PC and VC sub-engines are configured as each use the Virtual
>> + * Structure Tables
>> + */
>> +static void pnv_xive2_vst_set_data(PnvXive2 *xive2, uint64_t vsd)
>> +{
>> +    uint8_t mode = GETFIELD(VSD_MODE, vsd);
>> +    uint8_t type = GETFIELD(VC_VSD_TABLE_SELECT,
>> +                            xive2->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
>> +    uint8_t blk = GETFIELD(VC_VSD_TABLE_ADDRESS,
>> +                           xive2->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
>> +    uint64_t vst_addr = vsd & VSD_ADDRESS_MASK;
>> +
>> +    if (type > VST_ERQ) {
>> +        xive2_error(xive2, "VST: invalid table type %d", type);
>> +        return;
>> +    }
>> +
>> +    if (blk >= vst_infos[type].max_blocks) {
>> +        xive2_error(xive2, "VST: invalid block id %d for"
>> +                      " %s table", blk, vst_infos[type].name);
>> +        return;
>> +    }
>> +
>> +    if (!vst_addr) {
>> +        xive2_error(xive2, "VST: invalid %s table address",
>> +                   vst_infos[type].name);
>> +        return;
>> +    }
>> +
>> +    switch (mode) {
>> +    case VSD_MODE_FORWARD:
>> +        xive2->vsds[type][blk] = vsd;
>> +        break;
>> +
>> +    case VSD_MODE_EXCLUSIVE:
>> +        pnv_xive2_vst_set_exclusive(xive2, type, blk, vsd);
>> +        break;
>> +
>> +    default:
>> +        xive2_error(xive2, "VST: unsupported table mode %d", mode);
>> +        return;
>> +    }
>> +}
>> +
>> +/*
>> + * MMIO handlers
>> + */
>> +
>> +
>> +/*
>> + * IC BAR layout
>> + *
>> + * Page 0: Internal CQ register accesses (reads & writes)
>> + * Page 1: Internal PC register accesses (reads & writes)
>> + * Page 2: Internal VC register accesses (reads & writes)
>> + * Page 3: Internal TCTXT (TIMA) reg accesses (read & writes)
>> + * Page 4: Notify Port page (writes only, w/data),
>> + * Page 5: Reserved
>> + * Page 6: Sync Poll page (writes only, dataless)
>> + * Page 7: Sync Inject page (writes only, dataless)
>> + * Page 8: LSI Trigger page (writes only, dataless)
>> + * Page 9: LSI SB Management page (reads & writes dataless)
>> + * Pages 10-255: Reserved
>> + * Pages 256-383: Direct mapped Thread Context Area (reads & writes)
>> + *                covering the 128 threads in P10.
>> + * Pages 384-511: Reserved
>> + */
>> +typedef struct PnvXive2Region {
>> +    const char *name;
>> +    uint32_t pgoff;
>> +    uint32_t pgsize;
>> +    const MemoryRegionOps *ops;
>> +} PnvXive2Region;
>> +
>> +static const MemoryRegionOps pnv_xive2_ic_cq_ops;
>> +static const MemoryRegionOps pnv_xive2_ic_pc_ops;
>> +static const MemoryRegionOps pnv_xive2_ic_vc_ops;
>> +static const MemoryRegionOps pnv_xive2_ic_tctxt_ops;
>> +static const MemoryRegionOps pnv_xive2_ic_notify_ops;
>> +static const MemoryRegionOps pnv_xive2_ic_sync_ops;
>> +static const MemoryRegionOps pnv_xive2_ic_lsi_ops;
>> +static const MemoryRegionOps pnv_xive2_ic_tm_indirect_ops;
>> +
>> +/* 512 pages. 4K: 2M range, 64K: 32M range */
>> +static const PnvXive2Region pnv_xive2_ic_regions[] = {
>> +    { "xive-ic-cq",        0,   1,   &pnv_xive2_ic_cq_ops     },
>> +    { "xive-ic-vc",        1,   1,   &pnv_xive2_ic_vc_ops     },
>> +    { "xive-ic-pc",        2,   1,   &pnv_xive2_ic_pc_ops     },
>> +    { "xive-ic-tctxt",     3,   1,   &pnv_xive2_ic_tctxt_ops  },
>> +    { "xive-ic-notify",    4,   1,   &pnv_xive2_ic_notify_ops },
>> +    /* page 5 reserved */
>> +    { "xive-ic-sync",      6,   2,   &pnv_xive2_ic_sync_ops   },
>> +    { "xive-ic-lsi",       8,   2,   &pnv_xive2_ic_lsi_ops    },
>> +    /* pages 10-255 reserved */
>> +    { "xive-ic-tm-indirect", 256, 128, &pnv_xive2_ic_tm_indirect_ops  },
>> +    /* pages 384-511 reserved */
>> +};
>> +
>> +/*
>> + * CQ operations
>> + */
>> +
>> +static uint64_t pnv_xive2_ic_cq_read(void *opaque, hwaddr offset,
>> +                                        unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint32_t reg = offset >> 3;
>> +    uint64_t val = 0;
>> +
>> +    switch (offset) {
>> +    case CQ_XIVE_CAP: /* Set at reset */
>> +    case CQ_XIVE_CFG:
>> +        val = xive->cq_regs[reg];
>> +        break;
>> +    case CQ_MSGSND: /* TODO check the #cores of the machine */
>> +        val = 0xffffffff00000000;
>> +        break;
>> +    case CQ_CFG_PB_GEN:
>> +        val = CQ_CFG_PB_GEN_PB_INIT; /* TODO: fix CQ_CFG_PB_GEN default value */
>> +        break;
>> +    default:
>> +        xive2_error(xive, "CQ: invalid read @%"HWADDR_PRIx, offset);
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static uint64_t pnv_xive2_bar_size(uint64_t val)
>> +{
>> +    return 1ull << (GETFIELD(CQ_BAR_RANGE, val) + 24);
>> +}
>> +
>> +static void pnv_xive2_ic_cq_write(void *opaque, hwaddr offset,
>> +                                     uint64_t val, unsigned size)
>> +{
>> +    PnvXive2 *xive2 = PNV_XIVE2(opaque);
>> +    MemoryRegion *sysmem = get_system_memory();
>> +    uint32_t reg = offset >> 3;
>> +    int i;
>> +
>> +    switch (offset) {
>> +    case CQ_XIVE_CFG:
>> +    case CQ_RST_CTL: /* TODO: reset all BARs */
>> +        break;
>> +
>> +    case CQ_IC_BAR:
>> +        xive2->ic_shift = val & CQ_IC_BAR_64K ? 16 : 12;
>> +        if (!(val & CQ_IC_BAR_VALID)) {
>> +            xive2->ic_base = 0;
>> +            if (xive2->cq_regs[reg] & CQ_IC_BAR_VALID) {
>> +                for (i = 0; i < ARRAY_SIZE(xive2->ic_mmios); i++) {
>> +                    memory_region_del_subregion(&xive2->ic_mmio,
>> +                                                &xive2->ic_mmios[i]);
>> +                }
>> +                memory_region_del_subregion(sysmem, &xive2->ic_mmio);
>> +            }
>> +        } else {
>> +            xive2->ic_base = val & ~(CQ_IC_BAR_VALID | CQ_IC_BAR_64K);
>> +            if (!(xive2->cq_regs[reg] & CQ_IC_BAR_VALID)) {
>> +                for (i = 0; i < ARRAY_SIZE(xive2->ic_mmios); i++) {
>> +                    memory_region_add_subregion(&xive2->ic_mmio,
>> +                               pnv_xive2_ic_regions[i].pgoff << xive2->ic_shift,
>> +                               &xive2->ic_mmios[i]);
>> +                }
>> +                memory_region_add_subregion(sysmem, xive2->ic_base,
>> +                                            &xive2->ic_mmio);
>> +            }
>> +        }
>> +        break;
>> +
>> +    case CQ_TM_BAR:
>> +        xive2->tm_shift = val & CQ_TM_BAR_64K ? 16 : 12;
>> +        if (!(val & CQ_TM_BAR_VALID)) {
>> +            xive2->tm_base = 0;
>> +            if (xive2->cq_regs[reg] & CQ_TM_BAR_VALID) {
>> +                memory_region_del_subregion(sysmem, &xive2->tm_mmio);
>> +            }
>> +        } else {
>> +            xive2->tm_base = val & ~(CQ_TM_BAR_VALID | CQ_TM_BAR_64K);
>> +            if (!(xive2->cq_regs[reg] & CQ_TM_BAR_VALID)) {
>> +                memory_region_add_subregion(sysmem, xive2->tm_base,
>> +                                            &xive2->tm_mmio);
>> +            }
>> +        }
>> +        break;
>> +
>> +    case CQ_ESB_BAR:
>> +        xive2->esb_shift = val & CQ_BAR_64K ? 16 : 12;
>> +        if (!(val & CQ_BAR_VALID)) {
>> +            xive2->esb_base = 0;
>> +            if (xive2->cq_regs[reg] & CQ_BAR_VALID) {
>> +                memory_region_del_subregion(sysmem, &xive2->esb_mmio);
>> +            }
>> +        } else {
>> +            xive2->esb_base = val & CQ_BAR_ADDR;
>> +            if (!(xive2->cq_regs[reg] & CQ_BAR_VALID)) {
>> +                memory_region_set_size(&xive2->esb_mmio,
>> +                                       pnv_xive2_bar_size(val));
>> +                memory_region_add_subregion(sysmem, xive2->esb_base,
>> +                                            &xive2->esb_mmio);
>> +            }
>> +        }
>> +        break;
>> +
>> +    case CQ_END_BAR:
>> +        xive2->end_shift = val & CQ_BAR_64K ? 16 : 12;
>> +        if (!(val & CQ_BAR_VALID)) {
>> +            xive2->end_base = 0;
>> +            if (xive2->cq_regs[reg] & CQ_BAR_VALID) {
>> +                memory_region_del_subregion(sysmem, &xive2->end_mmio);
>> +            }
>> +        } else {
>> +            xive2->end_base = val & CQ_BAR_ADDR;
>> +            if (!(xive2->cq_regs[reg] & CQ_BAR_VALID)) {
>> +                memory_region_set_size(&xive2->end_mmio,
>> +                                       pnv_xive2_bar_size(val));
>> +                memory_region_add_subregion(sysmem, xive2->end_base,
>> +                                            &xive2->end_mmio);
>> +            }
>> +        }
>> +        break;
>> +
>> +    case CQ_NVC_BAR:
>> +        xive2->nvc_shift = val & CQ_BAR_64K ? 16 : 12;
>> +        if (!(val & CQ_BAR_VALID)) {
>> +            xive2->nvc_base = 0;
>> +            if (xive2->cq_regs[reg] & CQ_BAR_VALID) {
>> +                memory_region_del_subregion(sysmem, &xive2->nvc_mmio);
>> +            }
>> +        } else {
>> +            xive2->nvc_base = val & CQ_BAR_ADDR;
>> +            if (!(xive2->cq_regs[reg] & CQ_BAR_VALID)) {
>> +                memory_region_set_size(&xive2->nvc_mmio,
>> +                                       pnv_xive2_bar_size(val));
>> +                memory_region_add_subregion(sysmem, xive2->nvc_base,
>> +                                            &xive2->nvc_mmio);
>> +            }
>> +        }
>> +        break;
>> +
>> +    case CQ_NVPG_BAR:
>> +        xive2->nvpg_shift = val & CQ_BAR_64K ? 16 : 12;
>> +        if (!(val & CQ_BAR_VALID)) {
>> +            xive2->nvpg_base = 0;
>> +            if (xive2->cq_regs[reg] & CQ_BAR_VALID) {
>> +                memory_region_del_subregion(sysmem, &xive2->nvpg_mmio);
>> +            }
>> +        } else {
>> +            xive2->nvpg_base = val & CQ_BAR_ADDR;
>> +            if (!(xive2->cq_regs[reg] & CQ_BAR_VALID)) {
>> +                memory_region_set_size(&xive2->nvpg_mmio,
>> +                                       pnv_xive2_bar_size(val));
>> +                memory_region_add_subregion(sysmem, xive2->nvpg_base,
>> +                                            &xive2->nvpg_mmio);
>> +            }
>> +        }
>> +        break;
>> +
>> +    case CQ_TAR: /* Set Translation Table Address */
>> +        break;
>> +    case CQ_TDR: /* Set Translation Table Data */
>> +        pnv_xive2_stt_set_data(xive2, val);
>> +        break;
>> +    case CQ_FIRMASK_OR: /* FIR error reporting */
>> +        break;
>> +    default:
>> +        xive2_error(xive2, "CQ: invalid write 0x%"HWADDR_PRIx, offset);
>> +        return;
>> +    }
>> +
>> +    xive2->cq_regs[reg] = val;
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_ic_cq_ops = {
>> +    .read = pnv_xive2_ic_cq_read,
>> +    .write = pnv_xive2_ic_cq_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
>> +                                 unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint64_t val = 0;
>> +    uint32_t reg = offset >> 3;
>> +
>> +    switch (offset) {
>> +    /*
>> +     * VSD table settings.
>> +     */
>> +    case VC_VSD_TABLE_ADDR:
>> +    case VC_VSD_TABLE_DATA:
>> +        val = xive->vc_regs[reg];
>> +        break;
>> +
>> +    /*
>> +     * ESB cache updates (not modeled)
>> +     */
>> +    case VC_ESBC_FLUSH_CTRL:
>> +        xive->vc_regs[reg] &= ~VC_ESBC_FLUSH_CTRL_POLL_VALID;
>> +        val = xive->vc_regs[reg];
>> +        break;
>> +
>> +    /*
>> +     * EAS cache updates (not modeled)
>> +     */
>> +    case VC_EASC_FLUSH_CTRL:
>> +        xive->vc_regs[reg] &= ~VC_EASC_FLUSH_CTRL_POLL_VALID;
>> +        val = xive->vc_regs[reg];
>> +        break;
>> +
>> +    /*
>> +     * END cache updates
>> +     */
>> +    case VC_ENDC_WATCH0_SPEC:
>> +        xive->vc_regs[reg] &= ~(VC_ENDC_WATCH_FULL | VC_ENDC_WATCH_CONFLICT);
>> +        val = xive->vc_regs[reg];
>> +        break;
>> +
>> +    case VC_ENDC_WATCH0_DATA0:
>> +        /*
>> +         * Load DATA registers from cache with data requested by the
>> +         * SPEC register
>> +         */
>> +        pnv_xive2_end_cache_load(xive);
>> +        val = xive->vc_regs[reg];
>> +        break;
>> +
>> +    case VC_ENDC_WATCH0_DATA1 ... VC_ENDC_WATCH0_DATA3:
>> +        val = xive->vc_regs[reg];
>> +        break;
>> +
>> +    case VC_ENDC_FLUSH_CTRL:
>> +        xive->vc_regs[reg] &= ~VC_ENDC_FLUSH_CTRL_POLL_VALID;
>> +        val = xive->vc_regs[reg];
>> +        break;
>> +
>> +    /*
>> +     * Indirect invalidation
>> +     */
>> +    case VC_AT_MACRO_KILL_MASK:
>> +        val = xive->vc_regs[reg];
>> +        break;
>> +
>> +    case VC_AT_MACRO_KILL:
>> +        xive->vc_regs[reg] &= ~VC_AT_MACRO_KILL_VALID;
>> +        val = xive->vc_regs[reg];
>> +        break;
>> +
>> +    /*
>> +     * Interrupt fifo overflow in memory backing store (Not modeled)
>> +     */
>> +    case VC_QUEUES_CFG_REM0 ... VC_QUEUES_CFG_REM6:
>> +        val = xive->vc_regs[reg];
>> +        break;
>> +
>> +    /*
>> +     * Synchronisation
>> +     */
>> +    case VC_ENDC_SYNC_DONE:
>> +        val = VC_ENDC_SYNC_POLL_DONE;
>> +        break;
>> +    default:
>> +        xive2_error(xive, "VC: invalid read @%"HWADDR_PRIx, offset);
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>> +                              uint64_t val, unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint32_t reg = offset >> 3;
>> +
>> +    switch (offset) {
>> +    /*
>> +     * VSD table settings.
>> +     */
>> +    case VC_VSD_TABLE_ADDR:
>> +       break;
>> +    case VC_VSD_TABLE_DATA:
>> +        pnv_xive2_vst_set_data(xive, val);
>> +        break;
>> +
>> +    /*
>> +     * ESB cache updates (not modeled)
>> +     */
>> +    /* case VC_ESBC_FLUSH_CTRL: */
>> +    case VC_ESBC_FLUSH_POLL:
>> +        xive->vc_regs[VC_ESBC_FLUSH_CTRL >> 3] |= VC_ESBC_FLUSH_CTRL_POLL_VALID;
>> +        /* ESB update */
>> +        break;
>> +
>> +    /*
>> +     * EAS cache updates (not modeled)
>> +     */
>> +    /* case VC_EASC_FLUSH_CTRL: */
>> +    case VC_EASC_FLUSH_POLL:
>> +        xive->vc_regs[VC_EASC_FLUSH_CTRL >> 3] |= VC_EASC_FLUSH_CTRL_POLL_VALID;
>> +        /* EAS update */
>> +        break;
>> +
>> +    /*
>> +     * END cache updates
>> +     */
>> +    case VC_ENDC_WATCH0_SPEC:
>> +         val &= ~VC_ENDC_WATCH_CONFLICT; /* HW will set this bit */
>> +        break;
>> +
>> +    case VC_ENDC_WATCH0_DATA1 ... VC_ENDC_WATCH0_DATA3:
>> +        break;
>> +    case VC_ENDC_WATCH0_DATA0:
>> +        /* writing to DATA0 triggers the cache write */
>> +        xive->vc_regs[reg] = val;
>> +        pnv_xive2_end_update(xive);
>> +        break;
>> +
>> +
>> +    /* case VC_ENDC_FLUSH_CTRL: */
>> +    case VC_ENDC_FLUSH_POLL:
>> +        xive->vc_regs[VC_ENDC_FLUSH_CTRL >> 3] |= VC_ENDC_FLUSH_CTRL_POLL_VALID;
>> +        break;
>> +
>> +    /*
>> +     * Indirect invalidation
>> +     */
>> +    case VC_AT_MACRO_KILL:
>> +    case VC_AT_MACRO_KILL_MASK:
>> +        break;
>> +
>> +    /*
>> +     * Interrupt fifo overflow in memory backing store (Not modeled)
>> +     */
>> +    case VC_QUEUES_CFG_REM0 ... VC_QUEUES_CFG_REM6:
>> +        break;
>> +
>> +    /*
>> +     * Synchronisation
>> +     */
>> +    case VC_ENDC_SYNC_DONE:
>> +        break;
>> +
>> +    default:
>> +        xive2_error(xive, "VC: invalid write @%"HWADDR_PRIx, offset);
>> +        return;
>> +    }
>> +
>> +    xive->vc_regs[reg] = val;
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_ic_vc_ops = {
>> +    .read = pnv_xive2_ic_vc_read,
>> +    .write = pnv_xive2_ic_vc_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
>> +                                            unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint64_t val = -1;
>> +    uint32_t reg = offset >> 3;
>> +
>> +    switch (offset) {
>> +    /*
>> +     * VSD table settings.
>> +     */
>> +    case PC_VSD_TABLE_ADDR:
>> +    case PC_VSD_TABLE_DATA:
>> +        val = xive->pc_regs[reg];
>> +        break;
>> +
>> +    /*
>> +     * cache updates
>> +     */
>> +    case PC_NXC_WATCH0_SPEC:
>> +        xive->pc_regs[reg] &= ~(PC_NXC_WATCH_FULL | PC_NXC_WATCH_CONFLICT);
>> +        val = xive->pc_regs[reg];
>> +        break;
>> +
>> +    case PC_NXC_WATCH0_DATA0:
>> +       /*
>> +        * Load DATA registers from cache with data requested by the
>> +        * SPEC register
>> +        */
>> +        pnv_xive2_nvp_cache_load(xive);
>> +        val = xive->pc_regs[reg];
>> +        break;
>> +
>> +    case PC_NXC_WATCH0_DATA1 ... PC_NXC_WATCH0_DATA3:
>> +        val = xive->pc_regs[reg];
>> +        break;
>> +
>> +    case PC_NXC_FLUSH_CTRL:
>> +        xive->pc_regs[reg] &= ~PC_NXC_FLUSH_CTRL_POLL_VALID;
>> +        val = xive->pc_regs[reg];
>> +        break;
>> +
>> +    /*
>> +     * Indirect invalidation
>> +     */
>> +    case PC_AT_KILL:
>> +        xive->pc_regs[reg] &= ~PC_AT_KILL_VALID;
>> +        val = xive->pc_regs[reg];
>> +        break;
>> +
>> +    default:
>> +        xive2_error(xive, "PC: invalid read @%"HWADDR_PRIx, offset);
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
>> +                                         uint64_t val, unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint32_t reg = offset >> 3;
>> +
>> +    switch (offset) {
>> +
>> +    /*
>> +     * VSD table settings. Only taken into account in the VC
>> +     * sub-engine because the Xive2Router model combines both VC and PC
>> +     * sub-engines
>> +     */
>> +    case PC_VSD_TABLE_ADDR:
>> +    case PC_VSD_TABLE_DATA:
>> +        break;
>> +
>> +    /*
>> +     * cache updates
>> +     */
>> +    case PC_NXC_WATCH0_SPEC:
>> +        val &= ~PC_NXC_WATCH_CONFLICT; /* HW will set this bit */
>> +        break;
>> +
>> +    case PC_NXC_WATCH0_DATA1 ... PC_NXC_WATCH0_DATA3:
>> +        break;
>> +    case PC_NXC_WATCH0_DATA0:
>> +        /* writing to DATA0 triggers the cache write */
>> +        xive->pc_regs[reg] = val;
>> +        pnv_xive2_nvp_update(xive);
>> +        break;
>> +
>> +   /* case PC_NXC_FLUSH_CTRL: */
>> +    case PC_NXC_FLUSH_POLL:
>> +        xive->pc_regs[PC_NXC_FLUSH_CTRL >> 3] |= PC_NXC_FLUSH_CTRL_POLL_VALID;
>> +        break;
>> +
>> +    /*
>> +     * Indirect invalidation
>> +     */
>> +    case PC_AT_KILL:
>> +    case PC_AT_KILL_MASK:
>> +        break;
>> +
>> +    default:
>> +        xive2_error(xive, "PC: invalid write @%"HWADDR_PRIx, offset);
>> +        return;
>> +    }
>> +
>> +    xive->pc_regs[reg] = val;
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_ic_pc_ops = {
>> +    .read = pnv_xive2_ic_pc_read,
>> +    .write = pnv_xive2_ic_pc_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +
>> +static uint64_t pnv_xive2_ic_tctxt_read(void *opaque, hwaddr offset,
>> +                                         unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint64_t val = -1;
>> +    uint32_t reg = offset >> 3;
>> +
>> +    switch (offset) {
>> +    /*
>> +     * XIVE2 hardware thread enablement
>> +     */
>> +    case TCTXT_EN0:
>> +    case TCTXT_EN1:
>> +        val = xive->tctxt_regs[reg];
>> +        break;
>> +
>> +    case TCTXT_EN0_SET:
>> +    case TCTXT_EN0_RESET:
>> +        val = xive->tctxt_regs[TCTXT_EN0 >> 3];
>> +        break;
>> +    case TCTXT_EN1_SET:
>> +    case TCTXT_EN1_RESET:
>> +        val = xive->tctxt_regs[TCTXT_EN1 >> 3];
>> +        break;
>> +    default:
>> +        xive2_error(xive, "TCTXT: invalid read @%"HWADDR_PRIx, offset);
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
>> +                                            uint64_t val, unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint32_t reg = offset >> 3;
>> +
>> +    switch (offset) {
>> +    /*
>> +     * XIVE2 hardware thread enablement
>> +     */
>> +    case TCTXT_EN0: /* Physical Thread Enable */
>> +    case TCTXT_EN1: /* Physical Thread Enable (fused core) */
>> +        break;
>> +
>> +    case TCTXT_EN0_SET:
>> +        xive->tctxt_regs[TCTXT_EN0 >> 3] |= val;
>> +        break;
>> +    case TCTXT_EN1_SET:
>> +        xive->tctxt_regs[TCTXT_EN1 >> 3] |= val;
>> +        break;
>> +    case TCTXT_EN0_RESET:
>> +        xive->tctxt_regs[TCTXT_EN0 >> 3] &= ~val;
>> +        break;
>> +    case TCTXT_EN1_RESET:
>> +        xive->tctxt_regs[TCTXT_EN1 >> 3] &= ~val;
>> +        break;
>> +
>> +    default:
>> +        xive2_error(xive, "TCTXT: invalid write @%"HWADDR_PRIx, offset);
>> +        return;
>> +    }
>> +
>> +    xive->pc_regs[reg] = val;
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_ic_tctxt_ops = {
>> +    .read = pnv_xive2_ic_tctxt_read,
>> +    .write = pnv_xive2_ic_tctxt_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +/*
>> + * Redirect XSCOM to MMIO handlers
>> + */
>> +static uint64_t pnv_xive2_xscom_read(void *opaque, hwaddr offset,
>> +                                 unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint64_t val = -1;
>> +    uint32_t xscom_reg = offset >> 3;
>> +    uint32_t mmio_offset = (xscom_reg & 0xFF) << 3;
>> +
>> +    switch (xscom_reg) {
>> +    case 0x000 ... 0x0FF:
>> +        val = pnv_xive2_ic_cq_read(opaque, mmio_offset, size);
>> +        break;
>> +    case 0x100 ... 0x1FF:
>> +        val = pnv_xive2_ic_vc_read(opaque, mmio_offset, size);
>> +        break;
>> +    case 0x200 ... 0x2FF:
>> +        val = pnv_xive2_ic_pc_read(opaque, mmio_offset, size);
>> +        break;
>> +    case 0x300 ... 0x3FF:
>> +        val = pnv_xive2_ic_tctxt_read(opaque, mmio_offset, size);
>> +        break;
>> +    default:
>> +        xive2_error(xive, "XSCOM: invalid read @%"HWADDR_PRIx, offset);
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static void pnv_xive2_xscom_write(void *opaque, hwaddr offset,
>> +                                   uint64_t val, unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint32_t xscom_reg = offset >> 3;
>> +    uint32_t mmio_offset = (xscom_reg & 0xFF) << 3;
>> +
>> +    switch (xscom_reg) {
>> +    case 0x000 ... 0x0FF:
>> +        pnv_xive2_ic_cq_write(opaque, mmio_offset, val, size);
>> +        break;
>> +    case 0x100 ... 0x1FF:
>> +        pnv_xive2_ic_vc_write(opaque, mmio_offset, val, size);
>> +        break;
>> +    case 0x200 ... 0x2FF:
>> +        pnv_xive2_ic_pc_write(opaque, mmio_offset, val, size);
>> +        break;
>> +    case 0x300 ... 0x3FF:
>> +        pnv_xive2_ic_tctxt_write(opaque, mmio_offset, val, size);
>> +        break;
>> +    default:
>> +        xive2_error(xive, "XSCOM: invalid write @%"HWADDR_PRIx, offset);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_xscom_ops = {
>> +    .read = pnv_xive2_xscom_read,
>> +    .write = pnv_xive2_xscom_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +/*
>> + * Notify port page. The layout is compatible between 4K and 64K pages :
>> + *
>> + * Page 1           Notify page (writes only)
>> + *  0x000 - 0x7FF   IPI interrupt (NPU)
>> + *  0x800 - 0xFFF   HW interrupt triggers (PSI, PHB)
>> + */
>> +
>> +static void pnv_xive2_ic_hw_trigger(PnvXive2 *xive, hwaddr addr,
>> +                                     uint64_t val)
>> +{
>> +    uint8_t blk;
>> +    uint32_t idx;
>> +
>> +    if (val & XIVE_TRIGGER_END) {
>> +        xive2_error(xive, "IC: END trigger at @0x%"HWADDR_PRIx" data 0x%"PRIx64,
>> +                   addr, val);
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Forward the source event notification directly to the Router.
>> +     * The source interrupt number should already be correctly encoded
>> +     * with the chip block id by the sending device (PHB, PSI).
>> +     */
>> +    blk = XIVE_EAS_BLOCK(val);
>> +    idx = XIVE_EAS_INDEX(val);
>> +
>> +    xive2_router_notify(XIVE_NOTIFIER(xive), XIVE_EAS(blk, idx));
>> +}
>> +
>> +static void pnv_xive2_ic_notify_write(void *opaque, hwaddr offset,
>> +                                       uint64_t val, unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +
>> +    /* VC: IPI triggers */
>> +    switch (offset) {
>> +    case 0x000 ... 0x7FF:
>> +        /* TODO: check IPI notify sub-page routing */
>> +        pnv_xive2_ic_hw_trigger(opaque, offset, val);
>> +        break;
>> +
>> +    /* VC: HW triggers */
>> +    case 0x800 ... 0xFFF:
>> +        pnv_xive2_ic_hw_trigger(opaque, offset, val);
>> +        break;
>> +
>> +    default:
>> +        xive2_error(xive, "NOTIFY: invalid write @%"HWADDR_PRIx, offset);
>> +    }
>> +}
>> +
>> +static uint64_t pnv_xive2_ic_notify_read(void *opaque, hwaddr offset,
>> +                                                unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +
>> +   /* loads are invalid */
>> +    xive2_error(xive, "NOTIFY: invalid read @%"HWADDR_PRIx, offset);
>> +    return -1;
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_ic_notify_ops = {
>> +    .read = pnv_xive2_ic_notify_read,
>> +    .write = pnv_xive2_ic_notify_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +static uint64_t pnv_xive2_ic_lsi_read(void *opaque, hwaddr offset,
>> +                                             unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +
>> +    xive2_error(xive, "LSI: invalid read @%"HWADDR_PRIx, offset);
>> +    return -1;
>> +}
>> +
>> +static void pnv_xive2_ic_lsi_write(void *opaque, hwaddr offset,
>> +                                          uint64_t val, unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +
>> +    xive2_error(xive, "LSI: invalid write @%"HWADDR_PRIx, offset);
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_ic_lsi_ops = {
>> +    .read = pnv_xive2_ic_lsi_read,
>> +    .write = pnv_xive2_ic_lsi_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +/*
>> + * Sync MMIO page (write only)
>> + */
>> +#define PNV_XIVE2_SYNC_IPI      0x000
>> +#define PNV_XIVE2_SYNC_HW       0x080
>> +#define PNV_XIVE2_SYNC_NxC      0x100
>> +#define PNV_XIVE2_SYNC_INT      0x180
>> +#define PNV_XIVE2_SYNC_OS_ESC   0x200
>> +#define PNV_XIVE2_SYNC_POOL_ESC 0x280
>> +#define PNV_XIVE2_SYNC_HARD_ESC 0x300
>> +
>> +static uint64_t pnv_xive2_ic_sync_read(void *opaque, hwaddr offset,
>> +                                              unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +
>> +    /* loads are invalid */
>> +    xive2_error(xive, "SYNC: invalid read @%"HWADDR_PRIx, offset);
>> +    return -1;
>> +}
>> +
>> +static void pnv_xive2_ic_sync_write(void *opaque, hwaddr offset,
>> +                                           uint64_t val, unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +
>> +    switch (offset) {
>> +    case PNV_XIVE2_SYNC_IPI:
>> +    case PNV_XIVE2_SYNC_HW:
>> +    case PNV_XIVE2_SYNC_NxC:
>> +    case PNV_XIVE2_SYNC_INT:
>> +    case PNV_XIVE2_SYNC_OS_ESC:
>> +    case PNV_XIVE2_SYNC_POOL_ESC:
>> +    case PNV_XIVE2_SYNC_HARD_ESC:
>> +        break;
>> +    default:
>> +        xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx, offset);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_ic_sync_ops = {
>> +    .read = pnv_xive2_ic_sync_read,
>> +    .write = pnv_xive2_ic_sync_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +/*
>> + * When the TM direct pages of the IC controller are accessed, the
>> + * target HW thread is deduced from the page offset.
>> + */
>> +static XiveTCTX *pnv_xive2_get_indirect_tctx(PnvXive2 *xive, uint32_t pir)
>> +{
>> +    PnvChip *chip = xive->chip;
>> +    PowerPCCPU *cpu = NULL;
>> +
>> +    cpu = pnv_chip_find_cpu(chip, pir);
>> +    if (!cpu) {
>> +        xive2_error(xive, "IC: invalid PIR %x for indirect access", pir);
>> +        return NULL;
>> +    }
>> +
>> +    if (!pnv_xive2_is_cpu_enabled(xive, cpu)) {
>> +        xive2_error(xive, "IC: CPU %x is not enabled", pir);
>> +    }
>> +
>> +    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>> +}
>> +
>> +static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
>> +                                              unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint32_t pir = offset >> xive->ic_shift;
>> +    XiveTCTX *tctx = pnv_xive2_get_indirect_tctx(xive, pir);
>> +    uint64_t val = -1;
>> +
>> +    if (tctx) {
>> +        val = xive_tctx_tm_read(NULL, tctx, offset, size);
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
>> +                                           uint64_t val, unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint32_t pir = offset >> xive->ic_shift;
>> +    XiveTCTX *tctx = pnv_xive2_get_indirect_tctx(xive, pir);
>> +
>> +    if (tctx) {
>> +        xive_tctx_tm_write(NULL, tctx, offset, val, size);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_ic_tm_indirect_ops = {
>> +    .read = pnv_xive2_ic_tm_indirect_read,
>> +    .write = pnv_xive2_ic_tm_indirect_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +/*
>> + * TIMA ops
>> + */
>> +
>> +static void pnv_xive2_tm_write(void *opaque, hwaddr offset,
>> +                          uint64_t value, unsigned size)
>> +{
>> +    PowerPCCPU *cpu = POWERPC_CPU(current_cpu);
>> +    PnvXive2 *xive = pnv_xive2_tm_get_xive(cpu);
>> +    XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>> +
>> +    /* Other TM ops are the same as XIVE1 */
>> +    xive_tctx_tm_write(XIVE_PRESENTER(xive), tctx, offset, value, size);
>> +}
>> +
>> +static uint64_t pnv_xive2_tm_read(void *opaque, hwaddr offset, unsigned size)
>> +{
>> +    PowerPCCPU *cpu = POWERPC_CPU(current_cpu);
>> +    PnvXive2 *xive = pnv_xive2_tm_get_xive(cpu);
>> +    XiveTCTX *tctx = XIVE_TCTX(pnv_cpu_state(cpu)->intc);
>> +
>> +    /* Other TM ops are the same as XIVE1 */
>> +    return xive_tctx_tm_read(XIVE_PRESENTER(xive), tctx, offset, size);
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_tm_ops = {
>> +    .read = pnv_xive2_tm_read,
>> +    .write = pnv_xive2_tm_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 1,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +static uint64_t pnv_xive2_nvc_read(void *opaque, hwaddr offset,
>> +                                          unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +
>> +    xive2_error(xive, "NVC: invalid read @%"HWADDR_PRIx, offset);
>> +    return -1;
>> +}
>> +
>> +static void pnv_xive2_nvc_write(void *opaque, hwaddr offset,
>> +                                       uint64_t val, unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +
>> +    xive2_error(xive, "NVC: invalid write @%"HWADDR_PRIx, offset);
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_nvc_ops = {
>> +    .read = pnv_xive2_nvc_read,
>> +    .write = pnv_xive2_nvc_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +static uint64_t pnv_xive2_nvpg_read(void *opaque, hwaddr offset,
>> +                                           unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +
>> +    xive2_error(xive, "NVPG: invalid read @%"HWADDR_PRIx, offset);
>> +    return -1;
>> +}
>> +
>> +static void pnv_xive2_nvpg_write(void *opaque, hwaddr offset,
>> +                                        uint64_t val, unsigned size)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(opaque);
>> +
>> +    xive2_error(xive, "NVPG: invalid write @%"HWADDR_PRIx, offset);
>> +}
>> +
>> +static const MemoryRegionOps pnv_xive2_nvpg_ops = {
>> +    .read = pnv_xive2_nvpg_read,
>> +    .write = pnv_xive2_nvpg_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .valid = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +    .impl = {
>> +        .min_access_size = 8,
>> +        .max_access_size = 8,
>> +    },
>> +};
>> +
>> +/*
>> + * POWER10 default capabilities: 0x2000120076f00000
>> + */
>> +#define PNV_XIVE2_CAPABILITIES  0x2000120076f00000
>> +
>> +/*
>> + * POWER10 default configuration: 0x0030000033000000
>> + *
>> + * 8bits thread id was dropped for P10
>> + */
>> +#define PNV_XIVE2_CONFIGURATION 0x0030000033000000
>> +
>> +static void pnv_xive2_reset(void *dev)
>> +{
>> +    PnvXive2 *xive2 = PNV_XIVE2(dev);
>> +    XiveSource *xsrc = &xive2->ipi_source;
>> +    Xive2EndSource *end_xsrc = &xive2->end_source;
>> +
>> +    xive2->cq_regs[CQ_XIVE_CAP >> 3] = PNV_XIVE2_CAPABILITIES;
>> +    xive2->cq_regs[CQ_XIVE_CFG >> 3] = PNV_XIVE2_CONFIGURATION;
>> +
>> +    /* HW hardwires the #Topology of the chip in the block field */
>> +    xive2->cq_regs[CQ_XIVE_CFG >> 3] |=
>> +        SETFIELD(CQ_XIVE_CFG_HYP_HARD_BLOCK_ID, 0ull, xive2->chip->chip_id);
>> +
>> +    /* Set default page size to 64k */
>> +    xive2->ic_shift = xive2->esb_shift = xive2->end_shift = 16;
>> +    xive2->nvc_shift = xive2->nvpg_shift = xive2->tm_shift = 16;
>> +
>> +    /* Clear source MMIOs */
>> +    if (memory_region_is_mapped(&xsrc->esb_mmio)) {
>> +        memory_region_del_subregion(&xive2->esb_mmio, &xsrc->esb_mmio);
>> +    }
>> +
>> +    if (memory_region_is_mapped(&end_xsrc->esb_mmio)) {
>> +        memory_region_del_subregion(&xive2->end_mmio, &end_xsrc->esb_mmio);
>> +    }
>> +}
>> +
>> +/*
>> + *  Maximum number of IRQs and ENDs supported by HW. Will be tuned by
>> + *  software.
>> + */
>> +#define PNV_XIVE2_NR_IRQS (PNV10_XIVE2_ESB_SIZE / (1ull << XIVE_ESB_64K_2PAGE))
>> +#define PNV_XIVE2_NR_ENDS (PNV10_XIVE2_END_SIZE / (1ull << XIVE_ESB_64K_2PAGE))
>> +
>> +static void pnv_xive2_realize(DeviceState *dev, Error **errp)
>> +{
>> +    PnvXive2 *xive2 = PNV_XIVE2(dev);
>> +    PnvXive2Class *pxc = PNV_XIVE2_GET_CLASS(dev);
>> +    XiveSource *xsrc = &xive2->ipi_source;
>> +    Xive2EndSource *end_xsrc = &xive2->end_source;
>> +    Error *local_err = NULL;
>> +    int i;
>> +
>> +    pxc->parent_realize(dev, &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    assert(xive2->chip);
>> +
>> +    /*
>> +     * The XiveSource and Xive2EndSource objects are realized with the
>> +     * maximum allowed HW configuration. The ESB MMIO regions will be
>> +     * resized dynamically when the controller is configured by the FW
>> +     * to limit accesses to resources not provisioned.
>> +     */
>> +    object_property_set_int(OBJECT(xsrc), XIVE_SRC_STORE_EOI, "flags",
>> +                            &error_fatal);
>> +    object_property_set_int(OBJECT(xsrc), PNV_XIVE2_NR_IRQS, "nr-irqs",
>> +                            &error_fatal);
>> +    object_property_set_link(OBJECT(xsrc), OBJECT(xive2), "xive",
>> +                             &error_fatal);
>> +    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    object_property_set_int(OBJECT(end_xsrc), PNV_XIVE2_NR_ENDS, "nr-ends",
>> +                            &error_fatal);
>> +    object_property_set_link(OBJECT(end_xsrc), OBJECT(xive2), "xive",
>> +                             &error_abort);
>> +    object_property_set_bool(OBJECT(end_xsrc), true, "realized", &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    /* XSCOM region, used for initial configuration of the BARs */
>> +    memory_region_init_io(&xive2->xscom_regs, OBJECT(dev),
>> +                          &pnv_xive2_xscom_ops, xive2, "xscom-xive",
>> +                          PNV10_XSCOM_XIVE2_SIZE << 3);
>> +
>> +    /* Interrupt controller MMIO regions */
>> +    xive2->ic_shift = 16;
>> +    memory_region_init(&xive2->ic_mmio, OBJECT(dev), "xive-ic",
>> +                       PNV10_XIVE2_IC_SIZE);
>> +
>> +    for (i = 0; i < ARRAY_SIZE(xive2->ic_mmios); i++) {
>> +        memory_region_init_io(&xive2->ic_mmios[i], OBJECT(dev),
>> +                         pnv_xive2_ic_regions[i].ops, xive2,
>> +                         pnv_xive2_ic_regions[i].name,
>> +                         pnv_xive2_ic_regions[i].pgsize << xive2->ic_shift);
>> +    }
>> +
>> +    /*
>> +     * VC MMIO regions.
>> +     */
>> +    xive2->esb_shift = 16;
>> +    xive2->end_shift = 16;
>> +    memory_region_init(&xive2->esb_mmio, OBJECT(xive2), "xive-esb",
>> +                       PNV10_XIVE2_ESB_SIZE);
>> +    memory_region_init(&xive2->end_mmio, OBJECT(xive2), "xive-end",
>> +                       PNV10_XIVE2_END_SIZE);
>> +
>> +    /* Presenter Controller MMIO region (not modeled) */
>> +    xive2->nvc_shift = 16;
>> +    xive2->nvpg_shift = 16;
>> +    memory_region_init_io(&xive2->nvc_mmio, OBJECT(dev),
>> +                          &pnv_xive2_nvc_ops, xive2,
>> +                          "xive-nvc", PNV10_XIVE2_NVC_SIZE);
>> +
>> +    memory_region_init_io(&xive2->nvpg_mmio, OBJECT(dev),
>> +                          &pnv_xive2_nvpg_ops, xive2,
>> +                          "xive-nvpg", PNV10_XIVE2_NVPG_SIZE);
>> +
>> +    /* Thread Interrupt Management Area (Direct) */
>> +    xive2->tm_shift = 16;
>> +    memory_region_init_io(&xive2->tm_mmio, OBJECT(dev), &pnv_xive2_tm_ops,
>> +                          xive2, "xive-tima", PNV10_XIVE2_TM_SIZE);
>> +
>> +    qemu_register_reset(pnv_xive2_reset, dev);
>> +}
>> +
>> +static Property pnv_xive2_properties[] = {
>> +    DEFINE_PROP_UINT64("ic-bar", PnvXive2, ic_base, 0),
>> +    DEFINE_PROP_UINT64("esb-bar", PnvXive2, esb_base, 0),
>> +    DEFINE_PROP_UINT64("end-bar", PnvXive2, end_base, 0),
>> +    DEFINE_PROP_UINT64("nvc-bar", PnvXive2, nvc_base, 0),
>> +    DEFINE_PROP_UINT64("nvpg-bar", PnvXive2, nvpg_base, 0),
>> +    DEFINE_PROP_UINT64("tm-bar", PnvXive2, tm_base, 0),
>> +    DEFINE_PROP_LINK("chip", PnvXive2, chip, TYPE_PNV_CHIP, PnvChip *),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +static void pnv_xive2_instance_init(Object *obj)
>> +{
>> +    PnvXive2 *xive = PNV_XIVE2(obj);
>> +
>> +    object_initialize_child(obj, "ipi_source", &xive->ipi_source,
>> +                            sizeof(xive->ipi_source), TYPE_XIVE_SOURCE,
>> +                            &error_abort, NULL);
>> +    object_initialize_child(obj, "end_source", &xive->end_source,
>> +                            sizeof(xive->end_source), TYPE_XIVE2_END_SOURCE,
>> +                            &error_abort, NULL);
>> +}
>> +
>> +static int pnv_xive2_dt_xscom(PnvXScomInterface *dev, void *fdt,
>> +                             int xscom_offset)
>> +{
>> +    const char compat_p10[] = "ibm,power10-xive-x";
>> +    char *name;
>> +    int offset;
>> +    uint32_t reg[] = {
>> +        cpu_to_be32(PNV10_XSCOM_XIVE2_BASE),
>> +        cpu_to_be32(PNV10_XSCOM_XIVE2_SIZE)
>> +    };
>> +
>> +    name = g_strdup_printf("xive@%x", PNV10_XSCOM_XIVE2_BASE);
>> +    offset = fdt_add_subnode(fdt, xscom_offset, name);
>> +    _FDT(offset);
>> +    g_free(name);
>> +
>> +    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
>> +    _FDT(fdt_setprop(fdt, offset, "compatible", compat_p10,
>> +                     sizeof(compat_p10)));
>> +    return 0;
>> +}
>> +
>> +static void pnv_xive2_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    PnvXScomInterfaceClass *xdc = PNV_XSCOM_INTERFACE_CLASS(klass);
>> +    Xive2RouterClass *xrc = XIVE2_ROUTER_CLASS(klass);
>> +    XiveNotifierClass *xnc = XIVE_NOTIFIER_CLASS(klass);
>> +    XivePresenterClass *xpc = XIVE_PRESENTER_CLASS(klass);
>> +    PnvXive2Class *pxc = PNV_XIVE2_CLASS(klass);
>> +
>> +    xdc->dt_xscom  = pnv_xive2_dt_xscom;
>> +
>> +    dc->desc       = "PowerNV XIVE2 Interrupt Controller (POWER10)";
>> +    device_class_set_parent_realize(dc, pnv_xive2_realize,
>> +                                    &pxc->parent_realize);
>> +    device_class_set_props(dc, pnv_xive2_properties);
>> +
>> +    xrc->get_eas   = pnv_xive2_get_eas;
>> +    xrc->get_end   = pnv_xive2_get_end;
>> +    xrc->write_end = pnv_xive2_write_end;
>> +    xrc->get_nvp   = pnv_xive2_get_nvp;
>> +    xrc->write_nvp = pnv_xive2_write_nvp;
>> +    xrc->get_block_id = pnv_xive2_get_block_id;
>> +
>> +    xnc->notify    = pnv_xive2_notify;
>> +
>> +    xpc->match_nvt  = pnv_xive2_match_nvt;
>> +};
>> +
>> +static const TypeInfo pnv_xive2_info = {
>> +    .name          = TYPE_PNV_XIVE2,
>> +    .parent        = TYPE_XIVE2_ROUTER,
>> +    .instance_init = pnv_xive2_instance_init,
>> +    .instance_size = sizeof(PnvXive2),
>> +    .class_init    = pnv_xive2_class_init,
>> +    .class_size    = sizeof(PnvXive2Class),
>> +    .interfaces    = (InterfaceInfo[]) {
>> +        { TYPE_PNV_XSCOM_INTERFACE },
>> +        { }
>> +    }
>> +};
>> +
>> +static void pnv_xive2_register_types(void)
>> +{
>> +    type_register_static(&pnv_xive2_info);
>> +}
>> +
>> +type_init(pnv_xive2_register_types)
>> +
>> +static void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx,
>> +                                     Monitor *mon)
>> +{
>> +    uint8_t  eq_blk = xive_get_field32(NVP2_W5_VP_END_BLOCK, nvp->w5);
>> +    uint32_t eq_idx = xive_get_field32(NVP2_W5_VP_END_INDEX, nvp->w5);
>> +
>> +    if (!xive2_nvp_is_valid(nvp)) {
>> +        return;
>> +    }
>> +
>> +    monitor_printf(mon, "  %08x end:%02x/%04x CPPR:%02x IPB:%02x\n",
>> +                   nvp_idx, eq_blk, eq_idx,
>> +                   xive_get_field32(NVP2_W2_CPPR, nvp->w2),
>> +                   xive_get_field32(NVP2_W2_IPB, nvp->w2));
>> +}
>> +
>> +/*
>> + * If the table is direct, we can compute the number of PQ entries
>> + * provisioned by FW.
>> + */
>> +static uint32_t pnv_xive2_nr_esbs(PnvXive2 *xive)
>> +{
>> +    uint8_t blk = pnv_xive2_block_id(xive);
>> +    uint64_t vsd = xive->vsds[VST_ESB][blk];
>> +    uint64_t vst_tsize = 1ull << (GETFIELD(VSD_TSIZE, vsd) + 12);
>> +
>> +    return VSD_INDIRECT & vsd ? 0 : vst_tsize * SBE_PER_BYTE;
>> +}
>> +
>> +/*
>> + * Compute the number of entries per indirect subpage.
>> + */
>> +static uint64_t pnv_xive2_vst_per_subpage(PnvXive2 *xive, uint32_t type)
>> +{
>> +    uint8_t blk = pnv_xive2_block_id(xive);
>> +    uint64_t vsd = xive->vsds[type][blk];
>> +    const XiveVstInfo *info = &vst_infos[type];
>> +    uint64_t vsd_addr;
>> +    uint32_t page_shift;
>> +
>> +    /* For direct tables, fake a valid value */
>> +    if (!(VSD_INDIRECT & vsd)) {
>> +        return 1;
>> +    }
>> +
>> +    /* Get the page size of the indirect table. */
>> +    vsd_addr = vsd & VSD_ADDRESS_MASK;
>> +    vsd = ldq_be_dma(&address_space_memory, vsd_addr);
>> +
>> +    if (!(vsd & VSD_ADDRESS_MASK)) {
>> +#ifdef XIVE2_DEBUG
>> +        xive2_error(xive, "VST: invalid %s entry!?", info->name);
>> +#endif
>> +        return 0;
>> +    }
>> +
>> +    page_shift = GETFIELD(VSD_TSIZE, vsd) + 12;
>> +
>> +    if (!pnv_xive2_vst_page_size_allowed(page_shift)) {
>> +        xive2_error(xive, "VST: invalid %s page shift %d", info->name,
>> +                   page_shift);
>> +        return 0;
>> +    }
>> +
>> +    return (1ull << page_shift) / info->size;
>> +}
>> +
>> +void pnv_xive2_pic_print_info(PnvXive2 *xive, Monitor *mon)
>> +{
>> +    Xive2Router *xrtr = XIVE2_ROUTER(xive);
>> +    uint8_t blk = pnv_xive2_block_id(xive);
>> +    uint8_t chip_id = xive->chip->chip_id;
>> +    uint32_t srcno0 = XIVE_EAS(blk, 0);
>> +    uint32_t nr_esbs = pnv_xive2_nr_esbs(xive);
>> +    Xive2Eas eas;
>> +    Xive2End end;
>> +    Xive2Nvp nvp;
>> +    int i;
>> +    uint64_t xive_nvp_per_subpage;
>> +
>> +    monitor_printf(mon, "XIVE[%x] Source %08x .. %08x\n", blk, srcno0,
>> +                   srcno0 + nr_esbs - 1);
>> +    xive_source_pic_print_info(&xive->ipi_source, srcno0, mon);
>> +
>> +    monitor_printf(mon, "XIVE[%x] EAT %08x .. %08x\n", blk, srcno0,
>> +                   srcno0 + nr_esbs - 1);
>> +    for (i = 0; i < nr_esbs; i++) {
>> +        if (xive2_router_get_eas(xrtr, blk, i, &eas)) {
>> +            break;
>> +        }
>> +        if (!xive2_eas_is_masked(&eas)) {
>> +            xive2_eas_pic_print_info(&eas, i, mon);
>> +        }
>> +    }
>> +
>> +    monitor_printf(mon, "XIVE[%x] #%d END Escalation EAT\n", chip_id, blk);
>> +    i = 0;
>> +    while (!xive2_router_get_end(xrtr, blk, i, &end)) {
>> +        xive2_end_eas_pic_print_info(&end, i++, mon);
>> +    }
>> +
>> +    monitor_printf(mon, "XIVE[%x] #%d ENDT\n", chip_id, blk);
>> +    i = 0;
>> +    while (!xive2_router_get_end(xrtr, blk, i, &end)) {
>> +        xive2_end_pic_print_info(&end, i++, mon);
>> +    }
>> +
>> +    monitor_printf(mon, "XIVE[%x] #%d NVPT %08x .. %08x\n", chip_id, blk,
>> +                   0, XIVE2_NVP_COUNT - 1);
>> +    xive_nvp_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVP);
>> +    for (i = 0; i < XIVE2_NVP_COUNT; i += xive_nvp_per_subpage) {
>> +        while (!xive2_router_get_nvp(xrtr, blk, i, &nvp)) {
>> +            xive2_nvp_pic_print_info(&nvp, i++, mon);
>> +        }
>> +    }
>> +}
>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>> index 1b4748ce6dc3..73c40ce3209f 100644
>> --- a/hw/ppc/pnv.c
>> +++ b/hw/ppc/pnv.c
>> @@ -706,6 +706,7 @@ static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
>>  {
>>      Pnv10Chip *chip10 = PNV10_CHIP(chip);
>>  
>> +    pnv_xive2_pic_print_info(&chip10->xive, mon);
>>      pnv_psi_pic_print_info(&chip10->psi, mon);
>>  }
>>  
>> @@ -997,27 +998,45 @@ static void pnv_chip_power9_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
>>  static void pnv_chip_power10_intc_create(PnvChip *chip, PowerPCCPU *cpu,
>>                                          Error **errp)
>>  {
>> +    Pnv10Chip *chip10 = PNV10_CHIP(chip);
>> +    Error *local_err = NULL;
>> +    Object *obj;
>>      PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
>>  
>> -    /* Will be defined when the interrupt controller is */
>> -    pnv_cpu->intc = NULL;
>> +    /*
>> +     * The core creates its interrupt presenter but the XIVE2 interrupt
>> +     * controller object is initialized afterwards. Hopefully, it's
>> +     * only used at runtime.
>> +     */
>> +    obj = xive_tctx_create(OBJECT(cpu), XIVE_PRESENTER(&chip10->xive),
>> +                           &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +
>> +    pnv_cpu->intc = obj;
>>  }
>>  
>>  static void pnv_chip_power10_intc_reset(PnvChip *chip, PowerPCCPU *cpu)
>>  {
>> -    ;
>> +    PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
>> +
>> +    xive_tctx_reset(XIVE_TCTX(pnv_cpu->intc));
>>  }
>>  
>>  static void pnv_chip_power10_intc_destroy(PnvChip *chip, PowerPCCPU *cpu)
>>  {
>>      PnvCPUState *pnv_cpu = pnv_cpu_state(cpu);
>>  
>> +    xive_tctx_destroy(XIVE_TCTX(pnv_cpu->intc));
>>      pnv_cpu->intc = NULL;
>>  }
>>  
>>  static void pnv_chip_power10_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
>>                                               Monitor *mon)
>>  {
>> +    xive_tctx_pic_print_info(XIVE_TCTX(pnv_cpu_state(cpu)->intc), mon);
>>  }
>>  
>>  /*
>> @@ -1590,6 +1609,10 @@ static void pnv_chip_power10_instance_init(Object *obj)
>>  {
>>      Pnv10Chip *chip10 = PNV10_CHIP(obj);
>>  
>> +    object_initialize_child(obj, "xive", &chip10->xive, sizeof(chip10->xive),
>> +                            TYPE_PNV_XIVE2, &error_abort, NULL);
>> +    object_property_add_alias(obj, "xive-fabric", OBJECT(&chip10->xive),
>> +                              "xive-fabric", &error_abort);
>>      object_initialize_child(obj, "psi",  &chip10->psi, sizeof(chip10->psi),
>>                              TYPE_PNV10_PSI, &error_abort, NULL);
>>      object_initialize_child(obj, "lpc",  &chip10->lpc, sizeof(chip10->lpc),
>> @@ -1617,6 +1640,30 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>>          return;
>>      }
>>  
>> +    /* XIVE2 interrupt controller (POWER10) */
>> +    object_property_set_int(OBJECT(&chip10->xive), PNV10_XIVE2_IC_BASE(chip),
>> +                            "ic-bar", &error_fatal);
>> +    object_property_set_int(OBJECT(&chip10->xive), PNV10_XIVE2_ESB_BASE(chip),
>> +                            "esb-bar", &error_fatal);
>> +    object_property_set_int(OBJECT(&chip10->xive), PNV10_XIVE2_END_BASE(chip),
>> +                            "end-bar", &error_fatal);
>> +    object_property_set_int(OBJECT(&chip10->xive), PNV10_XIVE2_NVPG_BASE(chip),
>> +                            "nvpg-bar", &error_fatal);
>> +    object_property_set_int(OBJECT(&chip10->xive), PNV10_XIVE2_NVC_BASE(chip),
>> +                            "nvc-bar", &error_fatal);
>> +    object_property_set_int(OBJECT(&chip10->xive), PNV10_XIVE2_TM_BASE(chip),
>> +                            "tm-bar", &error_fatal);
>> +    object_property_set_link(OBJECT(&chip10->xive), OBJECT(chip), "chip",
>> +                             &error_abort);
>> +    object_property_set_bool(OBJECT(&chip10->xive), true, "realized",
>> +                             &local_err);
>> +    if (local_err) {
>> +        error_propagate(errp, local_err);
>> +        return;
>> +    }
>> +    pnv_xscom_add_subregion(chip, PNV10_XSCOM_XIVE2_BASE,
>> +                            &chip10->xive.xscom_regs);
>> +
>>      /* Processor Service Interface (PSI) Host Bridge */
>>      object_property_set_int(OBJECT(&chip10->psi), PNV10_PSIHB_BASE(chip),
>>                              "bar", &error_fatal);
>> @@ -1913,6 +1960,35 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t format,
>>      return total_count;
>>  }
>>  
>> +static int pnv10_xive_match_nvt(XiveFabric *xfb, uint8_t format,
>> +                                uint8_t nvt_blk, uint32_t nvt_idx,
>> +                                bool cam_ignore, uint8_t priority,
>> +                                uint32_t logic_serv,
>> +                                XiveTCTXMatch *match)
>> +{
>> +    PnvMachineState *pnv = PNV_MACHINE(xfb);
>> +    int total_count = 0;
>> +    int i;
>> +
>> +    for (i = 0; i < pnv->num_chips; i++) {
>> +        Pnv10Chip *chip10 = PNV10_CHIP(pnv->chips[i]);
>> +        XivePresenter *xptr = XIVE_PRESENTER(&chip10->xive);
>> +        XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
>> +        int count;
>> +
>> +        count = xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
>> +                               priority, logic_serv, match);
>> +
>> +        if (count < 0) {
>> +            return count;
>> +        }
>> +
>> +        total_count += count;
>> +    }
>> +
>> +    return total_count;
>> +}
>> +
>>  static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc = MACHINE_CLASS(oc);
>> @@ -1953,6 +2029,7 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>>  {
>>      MachineClass *mc = MACHINE_CLASS(oc);
>>      PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
>> +    XiveFabricClass *xfc = XIVE_FABRIC_CLASS(oc);
>>      static const char compat[] = "qemu,powernv10\0ibm,powernv";
>>  
>>      mc->desc = "IBM PowerNV (Non-Virtualized) POWER10";
>> @@ -1961,6 +2038,8 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>>      pmc->compat = compat;
>>      pmc->compat_size = sizeof(compat);
>>      pmc->dt_power_mgt = pnv_dt_power_mgt;
>> +
>> +    xfc->match_nvt = pnv10_xive_match_nvt;
>>  }
>>  
>>  static bool pnv_machine_get_hb(Object *obj, Error **errp)
>> @@ -2074,6 +2153,10 @@ static const TypeInfo types[] = {
>>          .name          = MACHINE_TYPE_NAME("powernv10"),
>>          .parent        = TYPE_PNV_MACHINE,
>>          .class_init    = pnv_machine_power10_class_init,
>> +        .interfaces = (InterfaceInfo[]) {
>> +            { TYPE_XIVE_FABRIC },
>> +            { },
>> +        },
>>      },
>>      {
>>          .name          = MACHINE_TYPE_NAME("powernv9"),
>> diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
>> index 3af575aeb87d..b879a6eb3c3a 100644
>> --- a/hw/intc/Makefile.objs
>> +++ b/hw/intc/Makefile.objs
>> @@ -40,7 +40,7 @@ obj-$(CONFIG_XICS_KVM) += xics_kvm.o
>>  obj-$(CONFIG_XIVE) += xive.o xive2.o
>>  obj-$(CONFIG_XIVE_SPAPR) += spapr_xive.o
>>  obj-$(CONFIG_XIVE_KVM) += spapr_xive_kvm.o
>> -obj-$(CONFIG_POWERNV) += xics_pnv.o pnv_xive.o
>> +obj-$(CONFIG_POWERNV) += xics_pnv.o pnv_xive.o pnv_xive2.o
>>  obj-$(CONFIG_ALLWINNER_A10_PIC) += allwinner-a10-pic.o
>>  obj-$(CONFIG_S390_FLIC) += s390_flic.o
>>  obj-$(CONFIG_S390_FLIC_KVM) += s390_flic_kvm.o
> 



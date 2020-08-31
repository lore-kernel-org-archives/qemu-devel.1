Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E1C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 14:15:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D705620693
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 14:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="C3gbVszj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D705620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCkbA-0007Au-OC
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 10:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kCka8-0006L4-2A
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 10:14:48 -0400
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com
 ([40.107.92.51]:38624 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kCka5-0006r4-Dy
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 10:14:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQaWt7bQs0XoytT/CeV5WhCp781hxhRKbdpB5iPdgmQlghAmJKgCcIyG3dqLJRUqD/A2rKwYaI+9TvJ7UDyBpqHcdc8F0RwyxnFJ7KI+ybOLMGdwuXiBzjgeFIfKSEO2BvwCvePI+LCAGGQ3/3n2b1aIg7EpAf7iPFR2Zs+ej8HsaoKJJTkYiHcDWSYPYFJAvQJdpcnyXoDIFLUcn4e7Q+nXtT1YO7SbVvhKtUj8nb/AdFhTtZzyRexP5z75ResOwnmuFF9qho2yq9rP3ovQKXUoJ7f14cVahzSuLZyh2ozrm/yWVXtuyDWtUtopBSp0xWaW1GqnhQDqkpDUSNojqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApwzKLTj/1Th0BHzLoI+bV5AExfvX+qtR7+/D9XxYrc=;
 b=BhrU5T1Qt3FUSQqTv9UFXjBc5mcAUDybu9kA+yBwRsudZ/kpE/mUyrAa1Btw2QtiXUDtcu/yn2eaX2QFTnGMFs0z9SW2RAgUVT9yUipngw/q86fmPDACBT6+GEs6zdxvC5H51DVfddy2bqesz7SB8mRtiYF2+Y0o+MMN0Sv8lJEf5l5lu04zfS5wodejnNU7WDVcDyHBknTTvzK+GYCKjj/souJgR0Z3rw35+PGP//tlc+pUOaP7kY+zZww2rdsBZtTTeayhFKCsXg/7hr0c8SzpyGbNonHExMRQgG7WwKCSShn2PHSlQEtdiGYktehinlg13R76Oc+uIvvk9Ugebw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=linaro.org
 smtp.mailfrom=xilinx.com; 
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApwzKLTj/1Th0BHzLoI+bV5AExfvX+qtR7+/D9XxYrc=;
 b=C3gbVszjSDDF1BQWmuYCP3Sijj+YPfjnnK58kwpfSUin7BYGllcSLnF0RQLTv/zkxyz19kJAc3Xy/uop5A5PyspTmd0bUSMXeW0QyWrDXnKxuOjuE8PuIn9Avf0LEPxgUNm9bON7m76OOvtkbdObvECu5ynF7dlIlHerGf7sNSU=
Received: from MN2PR10CA0028.namprd10.prod.outlook.com (2603:10b6:208:120::41)
 by DM6PR02MB6041.namprd02.prod.outlook.com (2603:10b6:5:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Mon, 31 Aug
 2020 14:14:42 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:120:cafe::19) by MN2PR10CA0028.outlook.office365.com
 (2603:10b6:208:120::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 14:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.60.83) smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not
 signed) header.d=none;linaro.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 14:14:40
 +0000
Received: from [149.199.38.66] (port=47588 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kCkZy-0003uf-Ib; Mon, 31 Aug 2020 07:14:38 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kCka0-0001kY-DZ; Mon, 31 Aug 2020 07:14:40 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kCkZz-0001kQ-Ny; Mon, 31 Aug 2020 07:14:40 -0700
Date: Mon, 31 Aug 2020 16:14:35 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 00/76] target/microblaze improvements
Message-ID: <20200831141435.GD14249@toto>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 821b80fd-cf40-474b-0532-08d84db8338f
X-MS-TrafficTypeDiagnostic: DM6PR02MB6041:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6041452B559F60ADDDF98245C2510@DM6PR02MB6041.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fshan7Y860A0gq0hPWHaShrZHWwMAQHkzKZrxH6LbEMYLuzrS44nk3ePqGsp3/oqKDkINw+LUyKSl9BuhebhqZza/FjwYNjQrUou9tdacN/719Wpg/qi9eGtbc3MJSWuwi9D4DJdASPyt+SgZhIpH4QvQGI7ENaoTkORJ2QDzfEmekIjaXskuIz/VAviVHshm7kJW7pQMGlDgZvhIufF3L4EmXpEvTxGEA1wfjkPb6koUjVQ95xUSLFtN86FEYLdhNQI5eatqf4pUHfKPpYI8jbcFrFcrJAwPFCk+6oliS5J/2oxAmmH5Y55Qfv48+ovHbLp2jwn4/oV95RTr8ftejn9NLy1O6U9kIRb0+KjN0SFK7GcMspqgh7s0MwgRWrRQ81USKTVO7o8M3r3BkOgOQ==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(346002)(39860400002)(396003)(376002)(136003)(46966005)(6916009)(336012)(186003)(6666004)(8936002)(2906002)(63350400001)(4326008)(9786002)(26005)(5660300002)(426003)(82740400003)(478600001)(9686003)(70586007)(70206006)(1076003)(83380400001)(33716001)(82310400002)(316002)(8676002)(47076004)(356005)(81166007)(33656002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 14:14:40.7217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821b80fd-cf40-474b-0532-08d84db8338f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6041
Received-SPF: pass client-ip=40.107.92.51; envelope-from=edgar@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 10:14:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 28, 2020 at 07:18:13AM -0700, Richard Henderson wrote:
> Thanks for all the testing and review, Edgar.
> 
> Changes in v2:
>   * Restored opcode_0_illegal handling.
>   * Dropped problematic imm/delay slot tb extension.
>   * Dropped tcg_gen_lookup_and_goto_ptr for now.
>   * Added fix for mb_cpu_transaction_failed.
>   * Removed microblaze-decode.h with old decoder.
>   * Removed abort_at_next_insn with old decoder.
>   * Fixed mbar.
>   * Fixed put.
> 
> 
> r~

I had one more comment on patch #27 but the rest of the series looks good to
me and it also passes my tests.

So once you fix #27 feel free to add my RB & TB tags on the entire series.
It's probably easiest if you send a pull-req via one of your trees.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Thanks again for working on this!
Cheers,
Edgar


> 
> 
> Richard Henderson (76):
>   tests/tcg: Add microblaze to arches filter
>   tests/tcg: Do not require FE_TOWARDZERO
>   tests/tcg: Do not require FE_* exception bits
>   target/microblaze: Tidy gdbstub
>   target/microblaze: Split out PC from env->sregs
>   target/microblaze: Split out MSR from env->sregs
>   target/microblaze: Split out EAR from env->sregs
>   target/microblaze: Split out ESR from env->sregs
>   target/microblaze: Split out FSR from env->sregs
>   target/microblaze: Split out BTR from env->sregs
>   target/microblaze: Split out EDR from env->sregs
>   target/microblaze: Split the cpu_SR array
>   target/microblaze: Fix width of PC and BTARGET
>   target/microblaze: Fix width of MSR
>   target/microblaze: Fix width of ESR
>   target/microblaze: Fix width of FSR
>   target/microblaze: Fix width of BTR
>   target/microblaze: Fix width of EDR
>   target/microblaze: Remove cpu_ear
>   target/microblaze: Tidy raising of exceptions
>   target/microblaze: Mark raise_exception as noreturn
>   target/microblaze: Remove helper_debug and env->debug
>   target/microblaze: Rename env_* tcg variables to cpu_*
>   target/microblaze: Tidy mb_tcg_init
>   target/microblaze: Split out MSR[C] to its own variable
>   target/microblaze: Use DISAS_NORETURN
>   target/microblaze: Check singlestep_enabled in gen_goto_tb
>   target/microblaze: Convert to DisasContextBase
>   target/microblaze: Convert to translator_loop
>   target/microblaze: Remove SIM_COMPAT
>   target/microblaze: Remove DISAS_GNU
>   target/microblaze: Remove empty D macros
>   target/microblaze: Remove LOG_DIS
>   target/microblaze: Ensure imm constant is always available
>   target/microblaze: Add decodetree infrastructure
>   target/microblaze: Convert dec_add to decodetree
>   target/microblaze: Convert dec_sub to decodetree
>   target/microblaze: Implement cmp and cmpu inline
>   target/microblaze: Convert dec_pattern to decodetree
>   target/microblaze: Convert dec_and, dec_or, dec_xor to decodetree
>   target/microblaze: Convert dec_mul to decodetree
>   target/microblaze: Convert dec_div to decodetree
>   target/microblaze: Unwind properly when raising divide-by-zero
>   target/microblaze: Convert dec_bit to decodetree
>   target/microblaze: Convert dec_barrel to decodetree
>   target/microblaze: Convert dec_imm to decodetree
>   target/microblaze: Convert dec_fpu to decodetree
>   target/microblaze: Fix cpu unwind for fpu exceptions
>   target/microblaze: Mark fpu helpers TCG_CALL_NO_WG
>   target/microblaze: Replace MSR_EE_FLAG with MSR_EE
>   target/microblaze: Cache mem_index in DisasContext
>   target/microblaze: Fix cpu unwind for stackprot
>   target/microblaze: Convert dec_load and dec_store to decodetree
>   target/microblaze: Assert no overlap in flags making up tb_flags
>   target/microblaze: Move bimm to BIMM_FLAG
>   target/microblaze: Fix no-op mb_cpu_transaction_failed
>   target/microblaze: Store "current" iflags in insn_start
>   tcg: Add tcg_get_insn_start_param
>   target/microblaze: Use cc->do_unaligned_access
>   target/microblaze: Replace clear_imm with tb_flags_to_set
>   target/microblaze: Replace delayed_branch with tb_flags_to_set
>   target/microblaze: Tidy mb_cpu_dump_state
>   target/microblaze: Convert brk and brki to decodetree
>   target/microblaze: Convert mbar to decodetree
>   target/microblaze: Reorganize branching
>   target/microblaze: Convert dec_br to decodetree
>   target/microblaze: Convert dec_bcc to decodetree
>   target/microblaze: Convert dec_rts to decodetree
>   target/microblaze: Tidy do_rti, do_rtb, do_rte
>   target/microblaze: Convert msrclr, msrset to decodetree
>   target/microblaze: Convert dec_msr to decodetree
>   target/microblaze: Convert dec_stream to decodetree
>   target/microblaze: Remove last of old decoder
>   target/microblaze: Remove cpu_R[0]
>   target/microblaze: Add flags markup to some helpers
>   target/microblaze: Reduce linux-user address space to 32-bit
> 
>  include/tcg/tcg.h                     |   15 +
>  target/microblaze/cpu-param.h         |   15 +
>  target/microblaze/cpu.h               |   67 +-
>  target/microblaze/helper.h            |   49 +-
>  target/microblaze/microblaze-decode.h |   59 -
>  tests/tcg/multiarch/float_helpers.h   |   17 +
>  target/microblaze/insns.decode        |  256 ++
>  linux-user/elfload.c                  |    9 +-
>  linux-user/microblaze/cpu_loop.c      |   26 +-
>  linux-user/microblaze/signal.c        |    8 +-
>  target/microblaze/cpu.c               |    9 +-
>  target/microblaze/gdbstub.c           |  193 +-
>  target/microblaze/helper.c            |  164 +-
>  target/microblaze/mmu.c               |    4 +-
>  target/microblaze/op_helper.c         |  194 +-
>  target/microblaze/translate.c         | 3223 +++++++++++++------------
>  tests/tcg/multiarch/float_convs.c     |    2 +
>  tests/tcg/multiarch/float_madds.c     |    2 +
>  target/microblaze/meson.build         |    3 +
>  tests/tcg/configure.sh                |    2 +-
>  20 files changed, 2292 insertions(+), 2025 deletions(-)
>  delete mode 100644 target/microblaze/microblaze-decode.h
>  create mode 100644 target/microblaze/insns.decode
> 
> -- 
> 2.25.1
> 


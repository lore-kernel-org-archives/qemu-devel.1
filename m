Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B14C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0B7205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="EQfACVZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0B7205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEHJ-00012k-8y
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jZEFs-0007ZG-Om
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:50:32 -0400
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com
 ([40.107.243.59]:6258 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jZEFq-0006eg-MC
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:50:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKph5VxkBqh9HQi8mDoOe3fda/jZyLiePIybKM2SEyvsW4sXLUyMcynKVCUoHhOJ0QIUJ+pb1J+XiOxAwotB3hYYgTm0b1qbz9ph0sTiuRnozCxZxVruO7uvgOlT4+8qWPZCaKYIXccE35hXbGgyg4Ly4rn7bYocvBrmSzpq8ylLA8dtauavNG6T+VpzZqLvCMWs35/kpQaPFTI5X2W6d8l6pQX/Eq0995e7hLvfzypK9cqtFTqvcxBfH2TF60WGQ5acZF1LoCzgZEjoCx3EU5y0My8vVldUPGuyoBPn/QrdfpYrbNhpUnxDNb6/aif7MWrS4LDhQKQt0AA9pgU9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9Ie226vnstf3UsThs9dzMKoaC4KGU8AxiuAK6ptexo=;
 b=UllcsSSkSTIGlvmRc06cJm9uW+3sCy1IyMUFh+nB2fkb670J48b0VNk2k5dmXnkauf23kbO2/A5WJ3eq9xig9ZjPX71ASj5pu9LCoYIfDthjaZViTaVWP4XosdRiKT4WkV3q6x63Bzba/hT6E0OhRVXbhrCahLnL7M+PyH3rSkLLByeoIc1MMT5KnIy0xAIa1IG9pb6lroG1jedjDHIaaQJHeNaWJQlR6mmh8gU92xMpTMKl6l5978/9mq4dcfHIZgmf6o4/wrbb9QrPm0wl0vvzLkeIxYmjDW+VwbTSfS/qLrpN+Am95fEtyPNLAI8nfxApew8NLv+KQXiCjLr9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9Ie226vnstf3UsThs9dzMKoaC4KGU8AxiuAK6ptexo=;
 b=EQfACVZeioEhsWDLd/Ktmg7MPqpBf75Xccq3tPn1KjK8A+xZWo+FgPGM7R2ti170BGnQFgJ2WxVE7HLk6F2M0J9YVX4XRrshCQp3vidOmAqHi8GO4Zp6K37AkGQAdJP7NX97rQ9jnIcYCEASJ7teKfIStkAvIgBSCvZCTfKfcLU=
Received: from MN2PR16CA0047.namprd16.prod.outlook.com (2603:10b6:208:234::16)
 by DM5PR02MB3164.namprd02.prod.outlook.com (2603:10b6:4:65::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Thu, 14 May
 2020 13:50:27 +0000
Received: from BL2NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::a1) by MN2PR16CA0047.outlook.office365.com
 (2603:10b6:208:234::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend
 Transport; Thu, 14 May 2020 13:50:27 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT064.mail.protection.outlook.com (10.152.77.119) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Thu, 14 May 2020 13:50:27
 +0000
Received: from [149.199.38.66] (port=55098 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>) id 1jZEFT-0005AJ-Vp
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:50:07 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>) id 1jZEFm-0002Ki-Tt
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:50:26 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04EDoObT022679; 
 Thu, 14 May 2020 06:50:25 -0700
Received: from [10.71.116.176] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jZEFk-0002Jm-OV; Thu, 14 May 2020 06:50:24 -0700
Date: Thu, 14 May 2020 15:50:07 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Joe Komlodi <joe.komlodi@xilinx.com>
Subject: Re: [PATCH V2 3/4] target/microblaze: gdb: Fix incorrect SReg
 reporting
Message-ID: <20200514135007.GS2945@toto>
References: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
 <1589393329-223076-3-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589393329-223076-3-git-send-email-komlodi@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(7916004)(346002)(396003)(136003)(39860400002)(376002)(46966005)(6862004)(81166007)(26005)(5660300002)(82310400002)(9786002)(9686003)(70206006)(8676002)(356005)(47076004)(6666004)(336012)(8936002)(478600001)(33716001)(1076003)(82740400003)(6636002)(33656002)(70586007)(2906002)(4326008)(316002)(186003)(426003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a61ce666-241e-450f-f72d-08d7f80dc235
X-MS-TrafficTypeDiagnostic: DM5PR02MB3164:
X-Microsoft-Antispam-PRVS: <DM5PR02MB31641A6BB6ED9DA874F1BB63C2BC0@DM5PR02MB3164.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aOYLSTTkvzQ64RRXbPqurv5bowOrolSwpP5tDUknWGYk75uepr1s9rDYZJvfUS4HHEpX6eXo3kBn0BIAjVYA7NKHSgMDY+ZYDP7xtoeUH86VNEVxOhJ1rKLDxQUgrw8FyrjQbKKLCMcIuyvYhyoZrN4mWJpBG1ahQGIE6J1gAS+WTWHdHjHjvvKbpN/DpTybQ7J7J2zNdM1x6KQYe4Z3/+HAdoMSBngWqkl0ytdP1gEXPXnVeE27cetqwVNGbKPrrT5mc1zwDT9AFY4fq+Bm/8ZlE0PNMGoHjOc4XQO5muL9exz0y/UamMaIBwYtLobQTDhhqlxsWjnOh+ebUXxR4F+Spl8vfB8Lxq9Y6O27KwUzFYFQ+SptyJuJ59IXyII9OuaInyyiPakF70C6frhvcJKO6pHLH0WFb9//dRIEm9p/pIsuuenssGqDjK3ibfSExr6a7x1ECwWkNXq759yeMNmYU8DNKKBI6wo5xM2lTx+Sve7JMyUGWsLJ7NmcYxxiRC7cHv9fOB4piOWo/AI6w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 13:50:27.2764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61ce666-241e-450f-f72d-08d7f80dc235
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3164
Received-SPF: pass client-ip=40.107.243.59; envelope-from=edgar@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 09:50:28
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 13, 2020 at 11:08:47AM -0700, Joe Komlodi wrote:
> SRegs used to be reported to GDB by iterating over the SRegs array,
> however we do not store them in an order that allows them to be
> reported to GDB in that way.
> 
> To fix this, a simple map is used to map the register GDB wants to its
> location in the SRegs array.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
> ---
>  target/microblaze/gdbstub.c | 59 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 49 insertions(+), 10 deletions(-)
> 
> diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
> index af29f00..485b717 100644
> --- a/target/microblaze/gdbstub.c
> +++ b/target/microblaze/gdbstub.c
> @@ -25,6 +25,21 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>  {
>      MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
>      CPUMBState *env = &cpu->env;
> +    /*
> +     * GDB expects SREGs in the following order:
> +     * PC, MSR, EAR, ESR, FSR, BTR, EDR, PID, ZPR, TLBX, TLBSX, TLBLO, TLBHI.
> +     * They aren't stored in this order, so make a map.
> +     * PID, ZPR, TLBx, TLBsx, TLBLO, and TLBHI aren't modeled, so we don't
> +     * map them to anything and return a value of 0 instead.
> +     */
> +    static const uint8_t sreg_map[6] = {
> +        SR_PC,
> +        SR_MSR,
> +        SR_EAR,
> +        SR_ESR,
> +        SR_FSR,
> +        SR_BTR
> +    };
>  
>      /*
>       * GDB expects registers to be reported in this order:
> @@ -40,15 +55,16 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>          n -= 32;
>          switch (n) {
>          case 0 ... 5:
> -            return gdb_get_reg32(mem_buf, env->sregs[n]);
> +            return gdb_get_reg32(mem_buf, env->sregs[sreg_map[n]]);
>          /* PVR12 is intentionally skipped */
>          case 6 ... 17:
>              n -= 6;
>              return gdb_get_reg32(mem_buf, env->pvr.regs[n]);
> -        case 18 ... 24:
> -            /* Add an offset of 6 to resume where we left off with SRegs */
> -            n = n - 18 + 6;
> -            return gdb_get_reg32(mem_buf, env->sregs[n]);
> +        case 18:
> +            return gdb_get_reg32(mem_buf, env->sregs[SR_EDR]);
> +        /* Other SRegs aren't modeled, so report a value of 0 */
> +        case 19 ... 24:
> +            return gdb_get_reg32(mem_buf, 0);
>          case 25:
>              return gdb_get_reg32(mem_buf, env->slr);
>          case 26:
> @@ -66,29 +82,52 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>      CPUMBState *env = &cpu->env;
>      uint32_t tmp;
>  
> +    /*
> +     * GDB expects SREGs in the following order:
> +     * PC, MSR, EAR, ESR, FSR, BTR, EDR, PID, ZPR, TLBX, TLBSX, TLBLO, TLBHI.
> +     * They aren't stored in this order, so make a map.
> +     * PID, ZPR, TLBx, TLBsx, TLBLO, and TLBHI aren't modeled, so we don't
> +     * map them to anything.
> +     */
> +    static const uint8_t sreg_map[6] = {
> +        SR_PC,
> +        SR_MSR,
> +        SR_EAR,
> +        SR_ESR,
> +        SR_FSR,
> +        SR_BTR
> +    };
> +
>      if (n > cc->gdb_num_core_regs) {
>          return 0;
>      }
>  
>      tmp = ldl_p(mem_buf);
>  
> +    /*
> +     * GDB expects registers to be reported in this order:
> +     * R0-R31
> +     * PC-BTR
> +     * PVR0-PVR11
> +     * EDR-TLBHI
> +     * SLR-SHR
> +     */
>      if (n < 32) {
>          env->regs[n] = tmp;
>      } else {
>          n -= 32;
>          switch (n) {
>          case 0 ... 5:
> -            env->sregs[n] = tmp;
> +            env->sregs[sreg_map[n]] = tmp;
>              break;
>          /* PVR12 is intentionally skipped */
>          case 6 ... 17:
>              n -= 6;
>              env->pvr.regs[n] = tmp;
>              break;
> -        case 18 ... 24:
> -            /* Add an offset of 6 to resume where we left off with SRegs */
> -            n = n - 18 + 6;
> -            env->sregs[n] = tmp;
> +        /* Only EDR is modeled in these indeces, so ignore the rest */
> +        case 18:
> +            env->sregs[SR_EDR] = tmp;
>              break;
>          case 25:
>              env->slr = tmp;
> -- 
> 2.7.4
> 


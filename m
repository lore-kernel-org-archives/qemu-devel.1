Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA18C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D292206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IiVbmqiO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D292206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVeaV-0008Iy-J1
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1jVeZ0-0005np-E7; Mon, 04 May 2020 13:07:30 -0400
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com
 ([40.107.243.51]:56443 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1jVeYy-0007DI-Bs; Mon, 04 May 2020 13:07:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbPxUInqkl2dy+jYtkn002IXeh6SECZ3qom7wi7GDm7+s1f2SdKpo5MmmAH1MScp+YF76AQER4GtbMfjxxfaoWb3gbI0BKBWR6+ase1b1aFPMojbPKVPKXI4lhXi+u6X3l4U5VOPVr927kwcQ/+HxLDjONPyAT2esPvcktcsAWshkEdRseTzxb02JFlDdaA64qBbaxvXAm6+3KEOQzJqK2GzuLVJABJ6PKx+YMgsgQPOITHl5nOD09QV+XCpL3ij2CW53utG6xTvSnDnuC3wwcpRTnZe/pxsIHxkK4u51NdvtJ7BoQj6wNs9bEeLe8imZZOQjwJ6xob5OBkjeH37AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+dJI79+49gXPv4D5pA/poLwgdT98YjCUTE9NUsnHlg=;
 b=nZTLPAVXqKRWz6Mrd3jVCRSGURty1RzkJUkpA5cobcWEJaE0StHDffeoulJVQgQnkogITAt/9pdMqUwOrFhpF7cQVwI3Fc1OR+ycVHcay2r9Dd+lVlUxdkZDyNDL2JP33UOY06cqD4WKkQkt0g6C/VtzPQ4Z7a8xP93SKDD5yk5TQpWzDSLsgZ5s3SbukE1tUHG5lI1V7zDFxfIR8YiGHUWAozzV5W0AlN8hNyhdAT+IclQXasrH3kE6lDx2d5laXXknholcjUAN7BjlE51PKATEB7zi0N6AjjDf7LAfI4NC5MBaX2OUDKDWtfvFk2pB2faS3H9D7wn41ERKeEy6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+dJI79+49gXPv4D5pA/poLwgdT98YjCUTE9NUsnHlg=;
 b=IiVbmqiO+a1FupTWN8nvKhLa051+2/aVeBc5mheocPLrJpaySVrs56k2qTyhCPfCr8VeaHJHskNm3vyYVA1Wb2wko8Z0B1f3p/QSTgC+7n4SgKESMakiZxx7MJt4H3BPdaZ82uZ8De5YZKaLFMdptTjuf8js53oQw6AEVNgvXYM=
Received: from SN1PR12CA0097.namprd12.prod.outlook.com (2603:10b6:802:21::32)
 by BL0PR02MB4787.namprd02.prod.outlook.com (2603:10b6:208:2a::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Mon, 4 May
 2020 17:07:24 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:21:cafe::85) by SN1PR12CA0097.outlook.office365.com
 (2603:10b6:802:21::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Mon, 4 May 2020 17:07:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 17:07:23 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 4 May 2020 18:07:21 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 4 May 2020 18:07:21 +0100
Received: from [10.71.116.176] (port=54645 helo=localhost)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1jVeYr-0004Px-Ew; Mon, 04 May 2020 18:07:21 +0100
Date: Mon, 4 May 2020 19:07:21 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v2 1/1] target/arm: Drop access_el3_aa32ns()
Message-ID: <20200504170721.GB2945@toto>
References: <20200504142125.31180-1-edgar.iglesias@gmail.com>
 <20200504142125.31180-2-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200504142125.31180-2-edgar.iglesias@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xir-pvapexch02.xlnx.xilinx.com;
 PTR:unknown-80-198.xilinx.com; CAT:NONE; SFTY:;
 SFS:(7916004)(376002)(39860400002)(396003)(346002)(136003)(46966005)(4326008)(478600001)(336012)(9786002)(426003)(26005)(186003)(47076004)(36906005)(8936002)(33656002)(2906002)(82740400003)(8676002)(54906003)(316002)(33716001)(5660300002)(7636003)(1076003)(82310400002)(356005)(70206006)(6916009)(9686003)(70586007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 124efbec-f850-4cb8-8c69-08d7f04d9d3a
X-MS-TrafficTypeDiagnostic: BL0PR02MB4787:
X-Microsoft-Antispam-PRVS: <BL0PR02MB47878CBAEC91A0130A3583B2C2A60@BL0PR02MB4787.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksfg3cjiPrB0JZn8r2/I5ZrOEQTjsqnBXUW/H3b6+u2UlOW4gWAAOBKqrXNy5QzQZKJINUsIli+p82Mn2v9Hjh3NlYYWQhBgHsEzRU42WFCV0uFFYSVY71rj0AzGIXVxjmPnf/hOfjzCmoes5d6TUY2kHz52vNESWCN5NbdKAmRcxyO20/R2H3zXGsfJR2sC2nTU+1h5A5Wdm1/IXnID8MYhW0ZXPAvXP+pHSf62gGpc99wQDfvMo0btz2CDOwvAnO+Ypt0cKDWmgL4pRpUi4uO+81OiZ6nOU9ua5ReiAepUIJNjBEOev02vN4BMkb4zaDRLOB6TQW97TGLvyMR2b79EqtC0lUHQw380rI4bTjm5asRNQ5zG3E8KPI1bdYVcx4X/dWWVdsD8y0b3HFEXGJMe9afPZuW7gEURw3XbMHrEnZtk0COEKSkHxnZQis18Pvs9Fpwe+ROgwzsq1M12xxK9aIlmUGW9/4H/5CHc/IBs09OZGc/BhHT1uC8d2EEX34CpVldlsIkJoCX8qW/IfQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 17:07:23.4513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 124efbec-f850-4cb8-8c69-08d7f04d9d3a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.80.198];
 Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4787
Received-SPF: pass client-ip=40.107.243.51; envelope-from=edgar@xilinx.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 13:07:26
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 04:21:25PM +0200, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Calling access_el3_aa32ns() works for AArch32 only cores
> but it does not handle 32-bit EL2 on top of 64-bit EL3
> for mixed 32/64-bit cores.
> 
> Merge access_el3_aa32ns_aa64any() into access_el3_aa32ns()
> and only use the latter.


Forgot to update the Subject/Summary to reflect that
access_el3_aa32ns_aa64any() is now being removed.

Will fix in v3...




> 
> Fixes: 68e9c2fe65 ("target-arm: Add VTCR_EL2")
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/arm/helper.c | 30 +++++++-----------------------
>  1 file changed, 7 insertions(+), 23 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index dfefb9b3d9..7d21bf1cc7 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -502,35 +502,19 @@ void init_cpreg_list(ARMCPU *cpu)
>  }
>  
>  /*
> - * Some registers are not accessible if EL3.NS=0 and EL3 is using AArch32 but
> - * they are accessible when EL3 is using AArch64 regardless of EL3.NS.
> - *
> - * access_el3_aa32ns: Used to check AArch32 register views.
> - * access_el3_aa32ns_aa64any: Used to check both AArch32/64 register views.
> + * Some registers are not accessible from AArch32 EL3 if SCR.NS == 0.
>   */
>  static CPAccessResult access_el3_aa32ns(CPUARMState *env,
>                                          const ARMCPRegInfo *ri,
>                                          bool isread)
>  {
> -    bool secure = arm_is_secure_below_el3(env);
> -
> -    assert(!arm_el_is_aa64(env, 3));
> -    if (secure) {
> +    if (!is_a64(env) && arm_current_el(env) == 3 &&
> +        arm_is_secure_below_el3(env)) {
>          return CP_ACCESS_TRAP_UNCATEGORIZED;
>      }
>      return CP_ACCESS_OK;
>  }
>  
> -static CPAccessResult access_el3_aa32ns_aa64any(CPUARMState *env,
> -                                                const ARMCPRegInfo *ri,
> -                                                bool isread)
> -{
> -    if (!arm_el_is_aa64(env, 3)) {
> -        return access_el3_aa32ns(env, ri, isread);
> -    }
> -    return CP_ACCESS_OK;
> -}
> -
>  /* Some secure-only AArch32 registers trap to EL3 if used from
>   * Secure EL1 (but are just ordinary UNDEF in other non-EL3 contexts).
>   * Note that an access from Secure EL1 can only happen if EL3 is AArch64.
> @@ -5236,7 +5220,7 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
>        .access = PL2_RW, .type = ARM_CP_CONST, .resetvalue = 0 },
>      { .name = "VTCR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 2, .crm = 1, .opc2 = 2,
> -      .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
> +      .access = PL2_RW, .accessfn = access_el3_aa32ns,
>        .type = ARM_CP_CONST, .resetvalue = 0 },
>      { .name = "VTTBR", .state = ARM_CP_STATE_AA32,
>        .cp = 15, .opc1 = 6, .crm = 2,
> @@ -5284,7 +5268,7 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
>        .type = ARM_CP_CONST, .resetvalue = 0 },
>      { .name = "HPFAR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 6, .crm = 0, .opc2 = 4,
> -      .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
> +      .access = PL2_RW, .accessfn = access_el3_aa32ns,
>        .type = ARM_CP_CONST, .resetvalue = 0 },
>      { .name = "HSTR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 3,
> @@ -7626,12 +7610,12 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              ARMCPRegInfo vpidr_regs[] = {
>                  { .name = "VPIDR_EL2", .state = ARM_CP_STATE_BOTH,
>                    .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 0,
> -                  .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
> +                  .access = PL2_RW, .accessfn = access_el3_aa32ns,
>                    .type = ARM_CP_CONST, .resetvalue = cpu->midr,
>                    .fieldoffset = offsetof(CPUARMState, cp15.vpidr_el2) },
>                  { .name = "VMPIDR_EL2", .state = ARM_CP_STATE_BOTH,
>                    .opc0 = 3, .opc1 = 4, .crn = 0, .crm = 0, .opc2 = 5,
> -                  .access = PL2_RW, .accessfn = access_el3_aa32ns_aa64any,
> +                  .access = PL2_RW, .accessfn = access_el3_aa32ns,
>                    .type = ARM_CP_NO_RAW,
>                    .writefn = arm_cp_write_ignore, .readfn = mpidr_read },
>                  REGINFO_SENTINEL
> -- 
> 2.20.1
> 


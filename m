Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F0DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8BA205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OMWPAiQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8BA205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEIc-00039I-H4
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jZEFs-0007ZH-P2
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:50:32 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com
 ([40.107.92.67]:6200 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jZEFq-0006ek-Ki
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:50:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUwphebeALN2EjjykiPYK5N+VqpJTIrwbQlrwtwTu9WT67IU3HD9b56PPA+3QCSjIZkpkJD6hIT8oESSPSJGRGzipPCXO2wKqzInDdHltgJXzP/haz68tmsW55T+AcuSVXXNe/egK3Std1RuqKP59LcVbLbX5xLguU4kD4u51dXwEz247OFnI+iXmLrLhlbRNg6QYuuhoe+sHJeJJ/p8qCqAP+5I8dGn9hgpAQdJWD8LtE560gzuiaXL+eC9zyNnXl0fEHYX2bbwsd7uh1UDgWJ+RzihGnjc31SL+eshQ+PGRqQ7ppAbCXwZddx6g4SVBVX9JThHEkn7Yj3fylF57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rTVTWh6D3M9ItIZ+88+WvdV03ZTCQ/KqiqHRzLs1Lc=;
 b=A7xrBPZ+DWdLOvVJqhSXfZkftw2EkF5IPig9tkBShIOPXDJa9947P5IBXBLuWDSatRQ2TTP/aLB/5VhGh/IXybVcUWxUsz9QalLXQk3vvS9IqBc08eegdkKOLo/SSu8EZ25wLSVn4N3MZ4ocJSmXEWds2M3EfGZ4N8QvpWp90JIxw8H5jy6h+G/KqmDK0xGeO82iV6D5yzCQ6PJwPzPBL0qAMyzF7lM0N/JFI9qE/xP/mdVMT0Fkqx07GKpranb8lMSZroDqBLWB+ARYNn4NPGJ0etYq91+iCJwSMFPJBNI8RIakCT8jYtcml+NdKSdktU37FVRNzQrNx1EmdKq2sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rTVTWh6D3M9ItIZ+88+WvdV03ZTCQ/KqiqHRzLs1Lc=;
 b=OMWPAiQxqyY1I9SGRx9AlsOAnD3UKSSsPQPGdHKRVWAuvDVUnOYcnKyMicEEA9bYyCj12opK+5XFsP6nzZdrxL0IGsVlRR+t6que0O6Nj3wVsyrBH+c1DjuSmMrXiBW3WRJhU6MdCDllpgsMwql4ZCftdYmew9kGkIjdshjxCDk=
Received: from MN2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:208:1a0::22)
 by MN2PR02MB5887.namprd02.prod.outlook.com (2603:10b6:208:116::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 14 May
 2020 13:50:27 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:1a0:cafe::10) by MN2PR07CA0012.outlook.office365.com
 (2603:10b6:208:1a0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Thu, 14 May 2020 13:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Thu, 14 May 2020 13:50:27
 +0000
Received: from [149.199.38.66] (port=55084 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>) id 1jZEFT-0005AF-RE
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:50:07 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>) id 1jZEFm-0002Ki-PN
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:50:26 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04EDoGTM023352; 
 Thu, 14 May 2020 06:50:16 -0700
Received: from [10.71.116.176] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jZEFc-0002Ac-5o; Thu, 14 May 2020 06:50:16 -0700
Date: Thu, 14 May 2020 15:49:59 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Joe Komlodi <joe.komlodi@xilinx.com>
Subject: Re: [PATCH V2 2/4] target/microblaze: gdb: Extend the number of
 registers presented to GDB
Message-ID: <20200514134959.GR2945@toto>
References: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
 <1589393329-223076-2-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589393329-223076-2-git-send-email-komlodi@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(7916004)(136003)(396003)(346002)(376002)(39860400002)(46966005)(356005)(26005)(81166007)(6666004)(82310400002)(186003)(47076004)(82740400003)(2906002)(33656002)(70206006)(70586007)(33716001)(6636002)(316002)(9686003)(8676002)(1076003)(6862004)(8936002)(5660300002)(426003)(9786002)(478600001)(4326008)(336012);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50bd9a50-5e09-48e3-0349-08d7f80dc21c
X-MS-TrafficTypeDiagnostic: MN2PR02MB5887:
X-Microsoft-Antispam-PRVS: <MN2PR02MB58875AC0D4E8C4D06F3CF1ADC2BC0@MN2PR02MB5887.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85d5KU3WP5We6wNjd05wX1EZmDFlaAr+thc9PCimsVA3FLS18wWz+MpMRziDfnuzRHu4okTCKtnN0kaBLC4aSSlahGPIFcbD98FY8kpy7WBKlC0gJJoHUjLxCxTdpCZlbyRj364qrlZYyPXGJl0D8XRxT2Dn64gbiRBg+lD5vmwEXJft5JxGy1aZ1w+y+jLsfusvtvOVV84L/u3YqGrScoOMeBj+4uBfBzFqn7QbmEcm2jRpD8dwQEDFyg32AmBRD1cnYLFmtxvduemwP01dQEAG/ORBZxT9tyQICC1G6Rqwlgz1q4e+EXXY8LudL2mG1HDrgJC5g3yIO6LAFvwLEWzB3Kiv3xAFffsD1Azqq/nQ6BfkmVeRQGWlx+Azu05yi9HikSYMCeK7PsxpF5+OAtkKizDROIFvh2Uh2PI1/YBh3YH8f844XyF8bFLjHzVBr2N+gGitAzrnG+dm5GpymV/xHiSEn0QJj11z8pNJObvMKKMdmMT0MAC4L6mRDSxaoLJUZLRoIc8lvMYY8gTQqg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 13:50:27.1073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bd9a50-5e09-48e3-0349-08d7f80dc21c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5887
Received-SPF: pass client-ip=40.107.92.67; envelope-from=edgar@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 09:50:29
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

On Wed, May 13, 2020 at 11:08:46AM -0700, Joe Komlodi wrote:
> Increase the number of Microblaze registers QEMU will report when
> talking to GDB.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
> ---
>  target/microblaze/cpu.c     |  2 +-
>  target/microblaze/gdbstub.c | 52 ++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 41cac1b..5b6ad5b 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -331,7 +331,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
>  #endif
>      dc->vmsd = &vmstate_mb_cpu;
>      device_class_set_props(dc, mb_properties);
> -    cc->gdb_num_core_regs = 32 + 5;
> +    cc->gdb_num_core_regs = 32 + 27;
>      cc->gdb_get_dynamic_xml = mb_gdb_get_dynamic_xml;
>      cc->gdb_core_xml_file = "microblaze-core.xml";
>  
> diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
> index cdca434..af29f00 100644
> --- a/target/microblaze/gdbstub.c
> +++ b/target/microblaze/gdbstub.c
> @@ -26,12 +26,37 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>      MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
>      CPUMBState *env = &cpu->env;
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
>          return gdb_get_reg32(mem_buf, env->regs[n]);
>      } else {
> -        return gdb_get_reg32(mem_buf, env->sregs[n - 32]);
> +        n -= 32;
> +        switch (n) {
> +        case 0 ... 5:
> +            return gdb_get_reg32(mem_buf, env->sregs[n]);
> +        /* PVR12 is intentionally skipped */
> +        case 6 ... 17:
> +            n -= 6;
> +            return gdb_get_reg32(mem_buf, env->pvr.regs[n]);
> +        case 18 ... 24:
> +            /* Add an offset of 6 to resume where we left off with SRegs */
> +            n = n - 18 + 6;
> +            return gdb_get_reg32(mem_buf, env->sregs[n]);
> +        case 25:
> +            return gdb_get_reg32(mem_buf, env->slr);
> +        case 26:
> +            return gdb_get_reg32(mem_buf, env->shr);
> +        default:
> +            return 0;
> +        }
>      }
> -    return 0;
>  }
>  
>  int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
> @@ -50,7 +75,28 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>      if (n < 32) {
>          env->regs[n] = tmp;
>      } else {
> -        env->sregs[n - 32] = tmp;
> +        n -= 32;
> +        switch (n) {
> +        case 0 ... 5:
> +            env->sregs[n] = tmp;
> +            break;
> +        /* PVR12 is intentionally skipped */
> +        case 6 ... 17:
> +            n -= 6;
> +            env->pvr.regs[n] = tmp;
> +            break;
> +        case 18 ... 24:
> +            /* Add an offset of 6 to resume where we left off with SRegs */
> +            n = n - 18 + 6;
> +            env->sregs[n] = tmp;
> +            break;
> +        case 25:
> +            env->slr = tmp;
> +            break;
> +        case 26:
> +            env->shr = tmp;
> +            break;
> +        }
>      }
>      return 4;
>  }
> -- 
> 2.7.4
> 


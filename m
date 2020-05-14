Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCCFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817CF205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mG4V/KeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817CF205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEK5-00055G-JY
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jZEG2-0007pp-Q4
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:50:44 -0400
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com
 ([40.107.92.55]:31390 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1jZEFz-0006k7-FR
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:50:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbupyeeH6nFm3XIUzU0zfngwlEEdS7riWLyWUDtSADMXs0AG+TcoA8aUC3VPzomBou7uamWQw0IpHuCpjGdvi678sGZ9xO823+hXMlqu3aWg9CEkfQYEvfRayp5n5lw7BM1dTL4d4YT3gXBbAPSjC6Ojpf3fdeIinupEtk5tMUmPu3R2hw4mQwLGS7OjXEU37kRWuE0IcmHPhYr89Xw9YAoKHHQ6NytbnVRjryi9UKNGGD5M7ec8xHz6RHZ3ykDKjh9LLVKoRSX1UtVjP2D+nG/JCGvLjc7psz0aFVdzV2T7jQw01SEvaKIExW3oAav5IStlMRq9gtLS109L5Tt8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqLnTeT8bO8wOqbWRJYTL39eqfjnFy52q5/R/2gFLRE=;
 b=GUDRg6WEtJlLSd+QwNg2NY7PaupUqTfYjFGJGuoooCSiiA9b7wA1Wsn+XYeKJwGWeYyuYuQ+XD0EsBDcP2XkoADrfdl7UTGdU5Ym07iPuUx2JRcIO2L+XXLDgxUmGleux/mgS+OOJuXsp6ok0YDlsk48DlRtbw2gqCUdjzSVJt2AHIC0HCvLIh0rNY8+RD83fZjS0fRQyLoCbsSO4oi/CK4IN7KbRJkU7TzFCYoaNUFYnssK0wxbRkDRME7a0rufg6hC36EylYw30g1z5IHjNeabqqOf+CH99am3dneUl5eIxtMs5GkTyjy9uEYxaNb4brL5KnCGUuAbCgGxF/UV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqLnTeT8bO8wOqbWRJYTL39eqfjnFy52q5/R/2gFLRE=;
 b=mG4V/KeBL/m4gu6JdvtZcOFi+L7G0R7atKqYtCB5ZxAvZ7Kv3h/K/J8rN/YzKVBofF2FNMrHCDH2zUfzm0vRSpoFAkgTNMXUGL2r2aHwWRXTywSMEgZKSWddsnwfZNvB1TIf8YLqOI0xlfJW19afFw6ZIdV4vLwJeETrpJz5biA=
Received: from CY4PR22CA0084.namprd22.prod.outlook.com (2603:10b6:903:ad::22)
 by CH2PR02MB7045.namprd02.prod.outlook.com (2603:10b6:610:8b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 13:50:37 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ad:cafe::78) by CY4PR22CA0084.outlook.office365.com
 (2603:10b6:903:ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Thu, 14 May 2020 13:50:37 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server id 15.20.3000.19 via Frontend Transport; Thu, 14 May 2020 13:50:37
 +0000
Received: from [149.199.38.66] (port=55342 helo=xsj-pvapsmtp01)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>) id 1jZEFe-0005By-2T
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:50:18 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>) id 1jZEFx-0002NV-0o
 for qemu-devel@nongnu.org; Thu, 14 May 2020 06:50:37 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 04EDoWes023590; 
 Thu, 14 May 2020 06:50:33 -0700
Received: from [10.71.116.176] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1jZEFs-0002Mn-Oa; Thu, 14 May 2020 06:50:32 -0700
Date: Thu, 14 May 2020 15:50:15 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Joe Komlodi <joe.komlodi@xilinx.com>
Subject: Re: [PATCH V2 4/4] target/microblaze: monitor: Increase the number
 of registers reported
Message-ID: <20200514135015.GT2945@toto>
References: <1589393329-223076-1-git-send-email-komlodi@xilinx.com>
 <1589393329-223076-4-git-send-email-komlodi@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589393329-223076-4-git-send-email-komlodi@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFTY:;
 SFS:(7916004)(39860400002)(136003)(396003)(346002)(376002)(46966005)(6862004)(9686003)(26005)(8936002)(478600001)(6666004)(4326008)(336012)(9786002)(82310400002)(356005)(81166007)(33656002)(1076003)(5660300002)(82740400003)(316002)(47076004)(2906002)(70206006)(70586007)(186003)(426003)(33716001)(6636002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d183c7e5-dcd3-4ad5-1ed4-08d7f80dc828
X-MS-TrafficTypeDiagnostic: CH2PR02MB7045:
X-Microsoft-Antispam-PRVS: <CH2PR02MB7045BC1872FEA1DC9141B17DC2BC0@CH2PR02MB7045.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:167;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azzHGBiHxYX0dica6rwuH75Wr3CuwvtPhwUTCFpxfp2mktt41AogTVsavTbkG/O/nUUQNT1rZu3EmfOiHaP7RhLqYmp2mWdGh/ToTq/Okdhpy9yrSowymhbqYUuhIbjcZkdZTyYtkzjyWzjZA0htCYxtZV+WG9y7pxRq0mO0xnQYMmkastM0fT6gcT5zswXuapTU9Z76DrIUqJceQbB5nhiNJOnn9UoykZ6xAELoLw5dGjMp2PAKtXnzENKa/KlOO2d9axXrIB2Bh4IXjB1lENdURp8Okk3Z9jPEJKXL1PiSqa+Ao25uuMglAOt3U+tNCwkwLva4MfuRNbtjNFiB0PRzvoFTVJ3pR0etGQea/idJKZO2HJJoN4t7aiOS0xsGQdEajla0HOm5Z43awQMp5cnV3zxYJNzTZQztqzVr9CXtOUzLrH2Pcoc6n2zTPZjFr3ZxsMBjfCs+Rn+b/RqkERvtzW3h/iBh3kD2J+GHl8HytMpq1TjF7zyXaXwBoBQgYrJMeqe8du/hp6VVIJMHIg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 13:50:37.2520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d183c7e5-dcd3-4ad5-1ed4-08d7f80dc828
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7045
Received-SPF: pass client-ip=40.107.92.55; envelope-from=edgar@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 09:50:38
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

On Wed, May 13, 2020 at 11:08:48AM -0700, Joe Komlodi wrote:
> Increase the number of registers reported to match GDB.
> 
> Registers that aren't modeled are reported as 0.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> 
> Signed-off-by: Joe Komlodi <komlodi@xilinx.com>
> ---
>  target/microblaze/translate.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 20b7427..4e7f903a 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1788,9 +1788,11 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>      qemu_fprintf(f, "IN: PC=%" PRIx64 " %s\n",
>                   env->sregs[SR_PC], lookup_symbol(env->sregs[SR_PC]));
>      qemu_fprintf(f, "rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
> -                 "debug=%x imm=%x iflags=%x fsr=%" PRIx64 "\n",
> +                 "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
> +                 "rbtr=%" PRIx64 "\n",
>                   env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
> -                 env->debug, env->imm, env->iflags, env->sregs[SR_FSR]);
> +                 env->debug, env->imm, env->iflags, env->sregs[SR_FSR],
> +                 env->sregs[SR_BTR]);
>      qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
>                   "eip=%d ie=%d\n",
>                   env->btaken, env->btarget,
> @@ -1798,7 +1800,17 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>                   (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
>                   (bool)(env->sregs[SR_MSR] & MSR_EIP),
>                   (bool)(env->sregs[SR_MSR] & MSR_IE));
> +    for (i = 0; i < 12; i++) {
> +        qemu_fprintf(f, "rpvr%2.2d=%8.8x ", i, env->pvr.regs[i]);
> +        if ((i + 1) % 4 == 0) {
> +            qemu_fprintf(f, "\n");
> +        }
> +    }
>  
> +    /* Registers that aren't modeled are reported as 0 */
> +    qemu_fprintf(f, "redr=%" PRIx64 " rpid=0 rzpr=0 rtlbx=0 rtlbsx=0 "
> +                    "rtlblo=0 rtlbhi=0\n", env->sregs[SR_EDR]);
> +    qemu_fprintf(f, "slr=%x shr=%x\n", env->slr, env->shr);
>      for (i = 0; i < 32; i++) {
>          qemu_fprintf(f, "r%2.2d=%8.8x ", i, env->regs[i]);
>          if ((i + 1) % 4 == 0)
> -- 
> 2.7.4
> 


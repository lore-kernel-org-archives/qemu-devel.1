Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A456C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECF82071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 07:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Mv3E2qkp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECF82071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD0Jy-0002aX-6M
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 03:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kD0JP-0002A4-RD
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 03:02:35 -0400
Received: from mail-eopbgr680047.outbound.protection.outlook.com
 ([40.107.68.47]:38912 helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kD0JL-0005s9-Sp
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 03:02:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyJ8oADSsBj5RC1MnNDEflsJNbJmy4L3uXSWRjsixPEXjjUjxMNHuihU2a4bz4J4fT5pHIZV5QX/vbdDsNxnzupW3qZd49w7CPr8s0ObOzQC31gCHbKGqFWCbNbn93EuyEiydxoYNeHzjTCZINiex0tk8ms7ujJUOmRc1nJxS6nBaeHXUos4lS8nDvGeXUMYeAw2d68dlfW4z93J7tNVfx0KvLnDJxswBD5oWhbNpl8NaNjtm79VXPZaJXth1NMcGQLGNwF5tc+8li7fUgjADLOQ4aAj56+NSC+8jzh3q40doa3ZjFMxCEMntYIlnQtBu0LMjCNkGmfEy4ljwMJQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfq5X1oNteo2ZAphtdCEMQtiJko00qzRuNQizyo9oLo=;
 b=fyHJ53TWE+ZNvHrVbXZOIyiObCe90t+lyCNhuI3hRVKGKokgtVXqDeHwrqaWn5+dsfmnT42C2CoKAZK3lVPtpZ7jD/o0FWK9k3Z73N+bsfxcoetE8JHxxyV/V+X2zmtx7PTsnyEvPdpvAmyoWQyqfzTiBO3YkswRb35nV/xf4b7Qdl4hfEOEwyqdMWE+g9iD9rkbD1gHZi9+r+gY675CXj6OZe4eNQiQpGMHOwYBeSzCTuVaZ9wluw7oNg6VzoFZS+Rd89nk/v2qxJukG2D0ZcjWlR+4QxtPCTrI+zVTq7qGwQIp3tW1DPMf+tyo9WR54zNlbwPTgoxjTL7oIz2nkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.60.83) smtp.rcpttodomain=linaro.org
 smtp.mailfrom=xilinx.com; 
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfq5X1oNteo2ZAphtdCEMQtiJko00qzRuNQizyo9oLo=;
 b=Mv3E2qkpOXMhBfWapyZsvWPC8ZTovaRmQJn2GPkujTLL5o8RgkLSTQyEALGGSq3humSH8VluYI3N3ofVMIsdfvFLg3P3i2v3BWMyTfsGBlz659vbg3JiQYGVl4u6Vhjuu2cuIBDt/zlbZNfD+sM1NNpTycxKpKvqSfrmLNNkxrY=
Received: from DM5PR1401CA0001.namprd14.prod.outlook.com (2603:10b6:4:4a::11)
 by CY4PR02MB2520.namprd02.prod.outlook.com (2603:10b6:903:6e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 07:02:29 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::4f) by DM5PR1401CA0001.outlook.office365.com
 (2603:10b6:4:4a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Tue, 1 Sep 2020 07:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.60.83) smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not
 signed) header.d=none;linaro.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 07:02:28
 +0000
Received: from [149.199.38.66] (port=33659 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kD0JF-0004he-FF; Tue, 01 Sep 2020 00:02:25 -0700
Received: from [127.0.0.1] (helo=xsj-pvapsmtp01)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kD0JI-0006bt-8z; Tue, 01 Sep 2020 00:02:28 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kD0JH-0006bN-PI; Tue, 01 Sep 2020 00:02:27 -0700
Date: Tue, 1 Sep 2020 09:02:23 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 4/6] target/microblaze: Handle DISAS_EXIT_NEXT in delay
 slot
Message-ID: <20200901070223.GJ14249@toto>
References: <20200831184018.839906-1-richard.henderson@linaro.org>
 <20200831184018.839906-5-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831184018.839906-5-richard.henderson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0db6fe2c-b1cc-4142-ef90-08d84e44fd27
X-MS-TrafficTypeDiagnostic: CY4PR02MB2520:
X-Microsoft-Antispam-PRVS: <CY4PR02MB25201702DA49D14B15D41783C22E0@CY4PR02MB2520.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eIymP+C7RtXmmC82Zn4gsNbd4/bLq4tTfG5q8zX7exu9yyVoBDpLNGCMWCy3YOfdE4RKJxQhQTHmNoeEe04cwfI40+CcvJMHBlV+FwNH+k5jnCFQIb9vfG8d2W/iSOuZfZdO89pTtlhDbTgPntuzTh3ZrXya5I77yKtqEehID6ukm1HMbKC7WM2X+0PQWjLGJwAvy+ymxP0hR4mutgkX/l2Tdk69FnocUbV7nOJ1yl+WjGMczPGFfyqRXUYtyeFB8b0WrgbZQM0+K8zIDA8ptbZGTsESnGtEWPuUp9AagfqdDimPDEE+7cZOh5BtiPvKbvdCMKQXIOYcY1xJn6AuFHP6f7SVcl/G2ykZQKEq9tShf1LDCOmeV+T6y8YVM2X1q5WDjhOflLiTeVEvb7DMMw==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(136003)(39860400002)(396003)(376002)(346002)(46966005)(82740400003)(33656002)(47076004)(356005)(33716001)(81166007)(1076003)(336012)(5660300002)(9786002)(8676002)(6916009)(186003)(63350400001)(426003)(478600001)(8936002)(316002)(2906002)(4744005)(70586007)(6666004)(83380400001)(26005)(4326008)(82310400003)(9686003)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 07:02:28.4890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db6fe2c-b1cc-4142-ef90-08d84e44fd27
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2520
Received-SPF: pass client-ip=40.107.68.47; envelope-from=edgar@xilinx.com;
 helo=NAM04-BN3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 03:02:30
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

On Mon, Aug 31, 2020 at 11:40:16AM -0700, Richard Henderson wrote:
> It is legal to put an mts instruction into a delay slot.
> We should continue to return to the main loop in that
> case so that we recognize any pending interrupts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/translate.c | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 9c52448c06..b116a0ce4f 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1696,6 +1696,10 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
>      dc->base.pc_next += 4;
>  
>      if (dc->jmp_cond != TCG_COND_NEVER && !(dc->tb_flags & D_FLAG)) {
> +        /*
> +         * Finish finish any return-from branch.

Typo, 2x finish.

With that fixed:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



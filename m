Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66F7C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 13:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C37E20719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 13:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BGmZamDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C37E20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCkH8-0008CL-Jl
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 09:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kCkGR-0007mO-94
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 09:54:27 -0400
Received: from mail-co1nam11on2046.outbound.protection.outlook.com
 ([40.107.220.46]:45471 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kCkGP-0004M6-9R
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 09:54:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAsMm7bGi8lf/5nFuKBaWt+9ZQmWKkYd7qnxsghYEzgVCdWxn/llybd0b1D+gu7WmR2p2E/Fpezv7YVhbccPYrjCbmCJZ3MduXI/CGwOITL4JwQQ/ClX7aTO4WR8XIJXOh3Ul7uFGZoPSfyGvRpJFI2DQXjaJweS7nHFOhA31b+FLQd/FuQ+flYV8kEa9so21BrvqqS7CQxqX1jjkCmiuOnZmN8hFDMEqS7o0bXkKIeYO5l6iM1oy2CSsDomh2Gwz9TaNRe5Zw+fT5LVSsfOVfQBGMb57utbkxgtmHa3cW0jkmv0Ykt7dWHKZ30Or+yN2Rrz3DTk/wbmcYu1zk8dDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJwUp4INkbzUJCre6J8EWghgA8I+k1UuDZZFs6qfMJ8=;
 b=gPAce1ZLisBDhrSo2ikxuX/2szoaQJr0A7SxgodjWLE6paO31IGns+E2vHak1R116jpIYYSettal0+cr9s1dEcbAGTOW+dq2OBp160UATFhVK+S6Ufzup5+8KoVYvqCo7XimTAfefDLoUOp98BNPwoPrl3gkgyz+N64mc00aGxLn12+jfYz/a6UNGzTWAD4CAmm/XZn1CsLsjvvVliJazFLZACHpvuQ1PHPkelERVE91X6F67c94XtfrS27Pup6LVJ0yJ0d9UA8EmS2U1O3pXDf3Y4BW8C41o0URKtJ3L1MpWvYthmrZOL6/z0gxHODZo/RKtECpZUNsbH+aKexIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJwUp4INkbzUJCre6J8EWghgA8I+k1UuDZZFs6qfMJ8=;
 b=BGmZamDDdcWiqX8ZPnosTuaMljdGMWoR9THUuVa0eazU5VAehn5KyzU9WHaRAOWTMd0l6lG5nloUs8YzRduB8sBp4vwGI28sijRKP9P+KIBcnlj8rdisXjEkDED/D4tAZP3HevupVF7SUX90UaRxsRp3qm/aN2fRYEzNjAq23wo=
Received: from SA0PR11CA0055.namprd11.prod.outlook.com (2603:10b6:806:d0::30)
 by DM6PR02MB5707.namprd02.prod.outlook.com (2603:10b6:5:7e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 13:54:21 +0000
Received: from SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d0:cafe::53) by SA0PR11CA0055.outlook.office365.com
 (2603:10b6:806:d0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 13:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT033.mail.protection.outlook.com (10.152.72.133) with Microsoft SMTP
 Server id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 13:54:21
 +0000
Received: from [149.199.38.66] (port=36400 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kCkGJ-0002Vj-8G; Mon, 31 Aug 2020 06:54:19 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kCkGL-00015y-2h; Mon, 31 Aug 2020 06:54:21 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 07VDsKfC010515; 
 Mon, 31 Aug 2020 06:54:20 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kCkGK-00015t-4q; Mon, 31 Aug 2020 06:54:20 -0700
Date: Mon, 31 Aug 2020 15:54:16 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 27/76] target/microblaze: Check singlestep_enabled in
 gen_goto_tb
Message-ID: <20200831135416.GC14249@toto>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
 <20200828141929.77854-28-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828141929.77854-28-richard.henderson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07210842-a865-4f8c-d994-08d84db55cbe
X-MS-TrafficTypeDiagnostic: DM6PR02MB5707:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5707D0820B422E128CD00B8CC2510@DM6PR02MB5707.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RR2kO80lthwVal6D+wBmfyOkiUxx/xMDD/w9TPXGmWiuH4XYuT6/pD3axfgtBitKCvPBQSfZPF42zThKFUJhbcPpEocqfwRGOloi0Zh183MBoS592hjfiIBXN57i1sfnyTRlofh763qz3aq05rlOverjSSuC0hSGJcAPtXLHXEK5H3fz6KOURFk+halq2e3KGw1W6Vw6OuDHB4HWaFWHDBcYsj1FvAXGB5ulAVqmixC06XRQwcLLzex89bxS27jC/nIcWGRdoh50yw9uP7jGMsktAxJ+rlRiVNVielnybC/L5qbi2rEh1zWO5+c928OXGMjdFJhL6ce8OHtv949tk82bmpoO9L3mc57bhBD5tpo6gVs2VlZjy3UX6KzdKzdeEaJUCTd5qjbzFjJdfgCz/g==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(396003)(136003)(39860400002)(346002)(376002)(46966005)(316002)(4326008)(478600001)(2906002)(6916009)(5660300002)(33716001)(426003)(8676002)(82310400002)(6666004)(1076003)(356005)(47076004)(9686003)(83380400001)(26005)(8936002)(186003)(336012)(70586007)(82740400003)(33656002)(81166007)(70206006)(9786002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 13:54:21.3166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07210842-a865-4f8c-d994-08d84db55cbe
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5707
Received-SPF: pass client-ip=40.107.220.46; envelope-from=edgar@xilinx.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 09:54:23
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

On Fri, Aug 28, 2020 at 07:18:40AM -0700, Richard Henderson wrote:
> Do not use goto_tb if we're single-stepping.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/translate.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 53ca0bfb38..7d5b96c38b 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -140,7 +140,12 @@ static inline bool use_goto_tb(DisasContext *dc, target_ulong dest)
>  
>  static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
>  {
> -    if (use_goto_tb(dc, dest)) {
> +    if (dc->singlestep_enabled) {
> +        TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
> +        tcg_gen_movi_i64(cpu_SR[SR_PC], dest);

This needs to be i32 cpu_pc to avoid breaking bisection. Looks like this
part slipped over to the next patch.

With that fixed:
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> +        gen_helper_raise_exception(cpu_env, tmp);
> +        tcg_temp_free_i32(tmp);
> +    } else if (use_goto_tb(dc, dest)) {
>          tcg_gen_goto_tb(n);
>          tcg_gen_movi_i32(cpu_pc, dest);
>          tcg_gen_exit_tb(dc->tb, n);
> -- 
> 2.25.1
> 


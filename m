Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76308C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:28:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196F02084D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Xy2opQvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196F02084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEApZ-0008NP-7b
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kEAoM-00074x-2K
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:27:22 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com
 ([40.107.93.49]:50145 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>) id 1kEAoJ-00036X-Oh
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:27:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b59BtbFqXfWBPeABV6p7scgriQoL/wL4qwiXV6E9mLgs9eHpOYZBdsoKwooUGJnKxZNQjgdZ4I1DLarbRqbujHajUYhuJ14IRnAP/6mlXM0Z+jY9+Tbj1cbbEv1DPsdXsL3H9jCMX30exHiYlHovRfzYtTFvNoWPcS52ME7DyQpr3YZ3MLJBcCjkQ+dZyX1JD/vy2K4CXQriRGFvPzBW5MAzbt26JUoJB0bV/CG13JhLmMthmZvS7HTWMa0o1hXGoI4RTe51yXuGPPzBV44Jo29S5uV4CQR7JBBl6+s5T3YGSiWXMjRgQJMqk/pidKxd9CqbL7MV69jREtZEm0HIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Did+tT8dxlEbGTDIGlzHgYOfUVHWxExRUclEkXfZpRo=;
 b=HbmA6oDAXL0B4MHcLQoAPgA/Qi3Kz/zgQ1SgGNfNvpODZA8VhfXcaMxWf51PRC0Nzwfd/t2q28gXQDgSj0g/hV+LUX9P+alLZu5ZJ2t8nsMllBLoIoxks03EF2YtNv1O285xQdI7YcYDCIgbtoFLJ9CxmOYOe2VZYeebA+Tu3jwtJ/Autxug4tlwHpx+9hlt6yqR65PFjy5+j8oD4lxe6fXWovzuK2eCJIruSmmaoFzp0a2m7xWD0N1GvxIFEAjBRFgCc+TNYCncd8wSkYoRQ3Fe1qvuFeqmIyHnrczQ3Stn9CV+sFY/MMWVApOwwjmhhzLLUXqL7yKAZygMRta9Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=amsat.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Did+tT8dxlEbGTDIGlzHgYOfUVHWxExRUclEkXfZpRo=;
 b=Xy2opQvH125+oXbAO3fBwx3IyFKHcSQIQGv4lJhuTXTJitXE5GHsoMtJCnhqC2akbvFuFtRXObUbw/mDy7yvBd5N1OrvwGqED/Gd2phMyI8WhD3/2HLe3XbKPjuzzvWqc0c7MVCBtk8QnroIvY+Wg3iNHXEeRAOo+WQCfueb9aw=
Received: from SN4PR0201CA0024.namprd02.prod.outlook.com
 (2603:10b6:803:2b::34) by DM6PR02MB4841.namprd02.prod.outlook.com
 (2603:10b6:5:fa::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 12:27:15 +0000
Received: from SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2b:cafe::9b) by SN4PR0201CA0024.outlook.office365.com
 (2603:10b6:803:2b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend
 Transport; Fri, 4 Sep 2020 12:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; amsat.org; dkim=none (message not signed)
 header.d=none;amsat.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT008.mail.protection.outlook.com (10.152.72.119) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Fri, 4 Sep 2020 12:27:15
 +0000
Received: from [149.199.38.66] (port=45680 helo=smtp.xilinx.com)
 by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1kEAo7-0007N7-N7; Fri, 04 Sep 2020 05:27:07 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
 by smtp.xilinx.com with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kEAoE-0006Tq-EX; Fri, 04 Sep 2020 05:27:14 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 084CRE7D026594; 
 Fri, 4 Sep 2020 05:27:14 -0700
Received: from [10.71.116.235] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1kEAoD-0006TV-HD; Fri, 04 Sep 2020 05:27:13 -0700
Date: Fri, 4 Sep 2020 14:27:09 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 12/12] target/microblaze: Diagnose invalid insns in
 delay slots
Message-ID: <20200904122709.GO14249@toto>
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
 <20200903072650.1360454-13-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200903072650.1360454-13-richard.henderson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bafb0a52-d24f-48ec-4c13-08d850cddb7b
X-MS-TrafficTypeDiagnostic: DM6PR02MB4841:
X-Microsoft-Antispam-PRVS: <DM6PR02MB484194C8C28BDF67D1717B2AC22D0@DM6PR02MB4841.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxRvZwJ1b2m86dmQOA+yt3jF0wbZgNaxb983pfAc6iesNsnwJ9IMQ5UzG8a9rcgkxWJFJr7zFFn6gF7HiklZGF/ggWSeVuULc+V33op8IkzfDp54kMknVi4ZmqAuRtUHcTJsgn2jRu3Oly73iCTC6hDE9Xy1nyfo0qZwrLrY9ZaW+C0e1LFTxIrL+udenwICT9J2CphttWFH613heSpqeISOPNL+6ERkmqCdbk3w3/J8J2rPHct0qz9TtXCI7IetwvDCkh4vByuLWGYQXEQhVtIkIpQtsIgxKobXSjOx07CAUe40qnFw81uOto65sBCYSJD38UYdeGCKfkElqvZs5i57X6y9geIpDeNJMpzIJA0A7TO0N+89xbUtNcqdmeDhRUwGMu382UC5Aqx2JIL3jA==
X-Forefront-Antispam-Report: CIP:149.199.60.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xsj-pvapsmtpgw01; PTR:unknown-60-83.xilinx.com; CAT:NONE;
 SFS:(7916004)(396003)(136003)(346002)(376002)(39860400002)(46966005)(26005)(70206006)(316002)(70586007)(9686003)(2906002)(6666004)(8676002)(8936002)(426003)(478600001)(1076003)(5660300002)(9786002)(186003)(6916009)(33716001)(4326008)(336012)(33656002)(83380400001)(47076004)(356005)(81166007)(82740400003)(82310400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 12:27:15.3673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bafb0a52-d24f-48ec-4c13-08d850cddb7b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.83];
 Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4841
Received-SPF: pass client-ip=40.107.93.49; envelope-from=edgar@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 08:27:18
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Sep 03, 2020 at 12:26:50AM -0700, Richard Henderson wrote:
> These cases result in undefined and undocumented behaviour but the
> behaviour is deterministic, i.e cores will not lock-up or expose
> security issues.  However, RTL will not raise exceptions either.
> 
> Therefore, log a GUEST_ERROR and treat these cases as nops, to
> avoid corner cases which could put qemu into an invalid state.
> 
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Log pc as well.
> ---
>  target/microblaze/translate.c | 48 ++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 7 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index d98572fab9..ff0cb7dbb6 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -179,6 +179,21 @@ static bool trap_userspace(DisasContext *dc, bool cond)
>      return cond_user;
>  }
>  
> +/*
> + * Return true, and log an error, if the current insn is
> + * within a delay slot.
> + */
> +static bool invalid_delay_slot(DisasContext *dc, const char *insn_type)
> +{
> +    if (dc->tb_flags & D_FLAG) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Invalid insn in delay slot: %s at %08x\n",
> +                      insn_type, (uint32_t)dc->base.pc_next);
> +        return true;
> +    }
> +    return false;
> +}
> +
>  static TCGv_i32 reg_for_read(DisasContext *dc, int reg)
>  {
>      if (likely(reg != 0)) {
> @@ -500,6 +515,9 @@ DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
>  
>  static bool trans_imm(DisasContext *dc, arg_imm *arg)
>  {
> +    if (invalid_delay_slot(dc, "imm")) {
> +        return true;
> +    }
>      dc->ext_imm = arg->imm << 16;
>      tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
>      dc->tb_flags_to_set = IMM_FLAG;
> @@ -1067,6 +1085,9 @@ static bool do_branch(DisasContext *dc, int dest_rb, int dest_imm,
>  {
>      uint32_t add_pc;
>  
> +    if (invalid_delay_slot(dc, "branch")) {
> +        return true;
> +    }
>      if (delay) {
>          setup_dslot(dc, dest_rb < 0);
>      }
> @@ -1106,6 +1127,9 @@ static bool do_bcc(DisasContext *dc, int dest_rb, int dest_imm,
>  {
>      TCGv_i32 zero, next;
>  
> +    if (invalid_delay_slot(dc, "bcc")) {
> +        return true;
> +    }
>      if (delay) {
>          setup_dslot(dc, dest_rb < 0);
>      }
> @@ -1158,6 +1182,10 @@ static bool trans_brk(DisasContext *dc, arg_typea_br *arg)
>      if (trap_userspace(dc, true)) {
>          return true;
>      }
> +    if (invalid_delay_slot(dc, "brk")) {
> +        return true;
> +    }
> +
>      tcg_gen_mov_i32(cpu_pc, reg_for_read(dc, arg->rb));
>      if (arg->rd) {
>          tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
> @@ -1176,6 +1204,10 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
>      if (trap_userspace(dc, imm != 0x8 && imm != 0x18)) {
>          return true;
>      }
> +    if (invalid_delay_slot(dc, "brki")) {
> +        return true;
> +    }
> +
>      tcg_gen_movi_i32(cpu_pc, imm);
>      if (arg->rd) {
>          tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
> @@ -1216,6 +1248,11 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
>  {
>      int mbar_imm = arg->imm;
>  
> +    /* Note that mbar is a specialized branch instruction. */
> +    if (invalid_delay_slot(dc, "mbar")) {
> +        return true;
> +    }
> +
>      /* Data access memory barrier.  */
>      if ((mbar_imm & 2) == 0) {
>          tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
> @@ -1263,6 +1300,10 @@ static bool do_rts(DisasContext *dc, arg_typeb_bc *arg, int to_set)
>      if (trap_userspace(dc, to_set)) {
>          return true;
>      }
> +    if (invalid_delay_slot(dc, "rts")) {
> +        return true;
> +    }
> +
>      dc->tb_flags_to_set |= to_set;
>      setup_dslot(dc, true);
>  
> @@ -1695,7 +1736,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
>      if (dc->jmp_cond != TCG_COND_NEVER && !(dc->tb_flags & D_FLAG)) {
>          /*
>           * Finish any return-from branch.
> -         * TODO: Diagnose rtXd in delay slot of rtYd earlier.
>           */
>          uint32_t rt_ibe = dc->tb_flags & (DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
>          if (unlikely(rt_ibe != 0)) {
> @@ -1717,12 +1757,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
>               * and will handle D_FLAG in mb_cpu_do_interrupt.
>               */
>              break;
> -        case DISAS_EXIT:
> -            /*
> -             * TODO: diagnose brk/brki in delay slot earlier.
> -             * This would then fold into the illegal insn case above.
> -             */
> -            break;
>          case DISAS_NEXT:
>              /*
>               * Normal insn a delay slot.
> -- 
> 2.25.1
> 


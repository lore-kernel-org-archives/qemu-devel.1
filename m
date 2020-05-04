Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD31C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE2F206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GawTDZ8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE2F206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVc16-0006rQ-SL
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1jVbvI-0005DV-DJ; Mon, 04 May 2020 10:18:20 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com
 ([40.107.244.43]:6247 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1jVbvH-0001NE-Co; Mon, 04 May 2020 10:18:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1LTFQu5sTFGp/6NpnPIJGsmEN2zPdLIzR0yJDiSYfVUVo26hts8j+44z5JnWEeb/B4thhWBfJ61dKoGVNtiouUeeNGu8aepNQ1/uZrzN+MMnmHRyQjafelJsSyNIZxCHAUiNRX0G9s+UMjDNV8ki5toOrtGUoJE4gvrMq7xevjgRPU/5IkXAUtEvJEkUNP0vJ5FqF8EJVB2CXSBNC8Sk69a7fuQpaDNnfi/vjALAY3+1W0ljJLlYMJ2Wu/uyvh789TVboN0BF5/U6jOG+Sn1dLJjX5t7SPYGGM03ZHQ9+4DhQj6o5m/nVoUMb3hvjF6DpmekwlKpstO05wYJLYg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlk6aGmk5mEYQckV/ZY2n4LZlRdEdTzo0S5tgH7LNiY=;
 b=FsmI8dx8v2riO4WB/yyPUPg0IwU9asL9lpIUQW51gIApgAXJdo6stwVL9hsdxm7RFeS5EsvQPhDvq2WpQgEAuXGGOX8Q+28vA9u0yGfu4x4u3u3K/GT8onQlaamufsQSyib7DE3GxrvrAXeG9h5eFoLkyznV7aLikO1v8Bk8iHHQSiES00kyQa8azDkbATj1eQkklq8Ugu2jTm2z1SBJi7O6OiZbJTQy8a5JB5r0F/C2Xg01RQ7R7XoKbMDZc1NNSMSa27bar5ZxQq5TyoKXEZ8o1Khloccm64MRBzQqiLmLvDEWZjVkaHKunpbhho4wyCVf9x5VKQecwbk4QuYnRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.80.198) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlk6aGmk5mEYQckV/ZY2n4LZlRdEdTzo0S5tgH7LNiY=;
 b=GawTDZ8rTTpbS6o+Uz9ZYH0mGeSYDqUPPES045MI4mnJLfHmRVKGT0GvVazoXeeLJZYCM+gvXamgRAzvIlu7skZtGSHfnrBT/yYT7e3F2I/XBlOGXY95NnsjNDfUM8k6LZsSEErg31hg1VyAkmk4TZr4NBjgtHV4BTUX05Ea+mU=
Received: from SN6PR16CA0047.namprd16.prod.outlook.com (2603:10b6:805:ca::24)
 by SN6PR02MB5038.namprd02.prod.outlook.com (2603:10b6:805:67::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 14:18:15 +0000
Received: from SN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::ef) by SN6PR16CA0047.outlook.office365.com
 (2603:10b6:805:ca::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Mon, 4 May 2020 14:18:15 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT040.mail.protection.outlook.com (10.152.72.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.27 via Frontend Transport; Mon, 4 May 2020 14:18:14 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 4 May 2020 15:18:13 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 4 May 2020 15:18:13 +0100
Received: from [10.71.116.176] (port=56606 helo=localhost)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1jVbvB-00029H-2I; Mon, 04 May 2020 15:18:13 +0100
Date: Mon, 4 May 2020 16:18:12 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 1/1] target/arm: Drop access_el3_aa32ns()
Message-ID: <20200504141812.GA2945@toto>
References: <20200428160350.10030-1-edgar.iglesias@gmail.com>
 <20200428160350.10030-2-edgar.iglesias@gmail.com>
 <CAFEAcA97vRE9yEPHFEBA8tw_K6Zzv0O9K=reHHP41T2GtKj44A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA97vRE9yEPHFEBA8tw_K6Zzv0O9K=reHHP41T2GtKj44A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xir-pvapexch01.xlnx.xilinx.com;
 PTR:unknown-80-198.xilinx.com; CAT:NONE; SFTY:;
 SFS:(7916004)(39860400002)(396003)(346002)(376002)(136003)(46966005)(70206006)(26005)(356005)(70586007)(316002)(9786002)(36906005)(8936002)(54906003)(8676002)(33656002)(1076003)(478600001)(7636003)(426003)(6916009)(336012)(33716001)(5660300002)(4326008)(82310400002)(186003)(47076004)(2906002)(82740400003)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2dadae4-ff56-4ae4-2092-08d7f035fc3a
X-MS-TrafficTypeDiagnostic: SN6PR02MB5038:
X-Microsoft-Antispam-PRVS: <SN6PR02MB50388169EB6E2000A4E15184C2A60@SN6PR02MB5038.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PiMCGdEayvnLYHklwXuyiu/H82DtRETawlfbEkBotELyaZweLX7X0o2xV03GMesHrqBxdMhou6TFmy+v8HGeekBPR3wNMUJkWoj6g9auCX9SPZmFAflRt6awam/ACb7IBxY4BNQky5BnGDNezI6rJ1vzQcWtDoN6JARjv30W5mxJID6Iy80pIiHfq/5XIDTI65HFXqZBNRTRmkK4SrsMEPTPj8jCPX8vzqvc5fUf/OmRXWWx/97k4Ur5xC7xk8AwhU7ImpipghsmKo5Y+L6c+5cPskEnOFvsPxs0eZLbaiBZZUN4ZxsIL/G5m29kfyV3h42fROjzBEZbqXOpHSIlG2oSm45BxT4B3tbhnu42f5lmhZ7MqSRNWvfQh3kINSjN7dMy19oTGsEf71JRgow34kwdOKZg3du7ycnkdrwWZUsXo/CcHpS11gvz0O8iRx/Wsq7cwMMOZ/KZEB2XNrnQtBh0gBUBZHqlxmx4BTf+moXjxS7wPoBfj9N8iOjfKXXn66IKVn9QDh+W9n2tJ/mmFA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 14:18:14.9106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2dadae4-ff56-4ae4-2092-08d7f035fc3a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.80.198];
 Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5038
Received-SPF: pass client-ip=40.107.244.43; envelope-from=edgar@xilinx.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 10:18:17
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 04, 2020 at 12:01:07PM +0100, Peter Maydell wrote:
> On Tue, 28 Apr 2020 at 17:03, Edgar E. Iglesias
> <edgar.iglesias@gmail.com> wrote:
> >
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > Calling access_el3_aa32ns() works for AArch32 only cores
> > but it does not handle 32-bit EL2 on top of 64-bit EL3
> > for mixed 32/64-bit cores.
> >
> > Fold access_el3_aa32ns() into access_el3_aa32ns_aa64any()
> > and replace all direct uses of the aa32 only version with
> > access_el3_aa32ns_aa64any().
> >
> > Fixes: 68e9c2fe65 ("target-arm: Add VTCR_EL2")
> > Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> 
> So, this is definitely a bug, but I think we could be
> clearer about what we're fixing.
> 
> For all these registers, the way the Arm ARM pseudocode phrases
> this access check is:
>  * for the AArch64 view of the register, no check
>  * for the AArch32 view of the register:
>       ...
>    elsif PSTATE.EL == EL2 then
>       return VTTBR;
>    elsif PSTATE.EL == EL3 then
>       if SCR.NS == '0' then
>           UNDEFINED;
>       else
>           return VTTBR;
> (similarly for the write path). We don't implement the HSTR.T2
> traps, so for us these registers are all .access = PL2_RW and
> we just UNDEF for all EL0/EL1 accesses.
> 
> So what we're really trying to check for is "current EL is EL3
> and we are AArch32 and SCR.NS == '0'". Because it's not possible
> to be in AArch32 Hyp with SCR.NS == 0, the check we make in
> your function is an equivalent test, but we could improve
> the comments:
> > ---
> >  target/arm/helper.c | 34 ++++++++++------------------------
> >  1 file changed, 10 insertions(+), 24 deletions(-)
> >
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 7e9ea5d20f..888f5f2314 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -504,29 +504,15 @@ void init_cpreg_list(ARMCPU *cpu)
> >  /*
> >   * Some registers are not accessible if EL3.NS=0 and EL3 is using AArch32 but
> >   * they are accessible when EL3 is using AArch64 regardless of EL3.NS.
> 
> This could be rewritten as:
>    Some registers are not accessible from AArch32 EL3 if SCR.NS == 0.


Done in v2.


> 
> > - *
> > - * access_el3_aa32ns: Used to check AArch32 register views.
> > - * access_el3_aa32ns_aa64any: Used to check both AArch32/64 register views.
> >   */
> > -static CPAccessResult access_el3_aa32ns(CPUARMState *env,
> > -                                        const ARMCPRegInfo *ri,
> > -                                        bool isread)
> > -{
> > -    bool secure = arm_is_secure_below_el3(env);
> > -
> > -    assert(!arm_el_is_aa64(env, 3));
> > -    if (secure) {
> > -        return CP_ACCESS_TRAP_UNCATEGORIZED;
> > -    }
> > -    return CP_ACCESS_OK;
> > -}
> > -
> >  static CPAccessResult access_el3_aa32ns_aa64any(CPUARMState *env,
> >                                                  const ARMCPRegInfo *ri,
> >                                                  bool isread)
> >  {
> > -    if (!arm_el_is_aa64(env, 3)) {
> > -        return access_el3_aa32ns(env, ri, isread);
> > +    bool secure = arm_is_secure_below_el3(env);
> > +
> > +    if (!arm_el_is_aa64(env, 3) && secure) {
> 
> We could either rephrase this as
>        if (!is_a64(env) && arm_current_el(env) == 3 &&
>            arm_is_secure_below_el3(env)) {

Went for this logic in v2.


> 
> or just have a comment
>        /*
>         * This access function is only used with .access = PL2_RW
>         * registers, so we are in AArch32 EL3 with SCR.NS == 0
>         * if and only if EL3 is AArch32 and SCR.NS == 0, because
>         * if SCR.NS == 0 we cannot be in EL2.
>         */
> 
> depending on how much you proritize a more efficient test
> over a more clearly correct test :-)
> 
> > +        return CP_ACCESS_TRAP_UNCATEGORIZED;
> >      }
> >      return CP_ACCESS_OK;
> >  }
> 
> Also, once we don't have a distinction between two different
> flavours of this access function we should use the simpler
> "access_el2_aa32ns", rather than ending up using the longer
> name for the one version of the function we're keeping.

Done in v2.

Thanks,
Edgar


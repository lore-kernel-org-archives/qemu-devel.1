Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F0CC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6CF2089F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="wnzyeKU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6CF2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhw9H-0000qS-DA
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37668)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <edgar@xilinx.com>) id 1hhw5Q-000792-NB
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar@xilinx.com>) id 1hhw5O-0003dB-S3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:11:12 -0400
Received: from mail-dm3nam05on0616.outbound.protection.outlook.com
 ([2a01:111:f400:fe51::616]:6001
 helo=NAM05-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <edgar@xilinx.com>) id 1hhw5O-0003ZZ-E9
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cynKbhuiZ424GnefsCEsJI46z1GBNYXzCXAtygf3xUw=;
 b=wnzyeKU5zOOJ14zA1xWlSMYTbdUQ0VwVZ1+ijTbVmdWVs59bct5d7mPEqqLIXpxquWWnwcjQxyVBKZSc2jI+njcMcrT6XR1mhulbTNbGdndtAjGkCsyyqTQsk1msbjIqyOsgnJcDQcNEdo7qp7ovVrIY2D43sAy67cYXhTFixwA=
Received: from BYAPR02CA0024.namprd02.prod.outlook.com (2603:10b6:a02:ee::37)
 by BY5PR02MB6321.namprd02.prod.outlook.com (2603:10b6:a03:1f9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.17; Mon, 1 Jul
 2019 13:11:07 +0000
Received: from CY1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BYAPR02CA0024.outlook.office365.com
 (2603:10b6:a02:ee::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.20 via Frontend
 Transport; Mon, 1 Jul 2019 13:11:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; greensocs.com; dkim=none (message not signed)
 header.d=none;greensocs.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT057.mail.protection.outlook.com (10.152.75.110) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Mon, 1 Jul 2019 13:11:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:48034
 helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1hhw5I-0003H5-KE; Mon, 01 Jul 2019 06:11:04 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1hhw5D-00021m-Gm; Mon, 01 Jul 2019 06:10:59 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x61DAqhP027357; 
 Mon, 1 Jul 2019 06:10:52 -0700
Received: from [10.71.119.209] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1hhw56-00020p-Dz; Mon, 01 Jul 2019 06:10:52 -0700
Date: Mon, 1 Jul 2019 15:19:33 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190701131933.GA2840@toto>
References: <20190628113917.15869-1-luc.michel@greensocs.com>
 <f9c429e1-4a1d-959a-04c4-e9b7e94637cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c429e1-4a1d-959a-04c4-e9b7e94637cf@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(7916004)(376002)(346002)(396003)(39850400004)(136003)(2980300002)(199004)(189003)(70586007)(70206006)(33656002)(14444005)(1076003)(53546011)(229853002)(76176011)(446003)(47776003)(305945005)(50466002)(33716001)(9686003)(478600001)(54906003)(2906002)(486006)(476003)(426003)(11346002)(126002)(76506005)(23726003)(336012)(63266004)(57986006)(77096007)(186003)(9786002)(8936002)(36386004)(26005)(81156014)(81166006)(8676002)(16586007)(58126008)(6246003)(4326008)(5660300002)(106002)(6916009)(316002)(356004)(6666004)(5001870100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR02MB6321; H:xsj-pvapsmtpgw02; FPR:;
 SPF:Pass; LANG:en; PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com; A:1; MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca6c371-24d5-46b8-5505-08d6fe25937b
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);
 SRVR:BY5PR02MB6321; 
X-MS-TrafficTypeDiagnostic: BY5PR02MB6321:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY5PR02MB63218992C3F77C8C803D156DC2F90@BY5PR02MB6321.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 00851CA28B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wsN/hfUTCNpjBQ1QnGnsbSDsAeY26T3JkcPPJJUfQg0KvcBV95/HQWjOez0ZlIUNsfuHw5hmHdhMK8JtbcvV84xG92e0lN4zcs5Juw+T9dNa+o5ss1yApx2YXUBXqN18bK0dR8ybIT4MdTNZ7YshCHFhTECkYrJsth1UcsNKbRsqC0l55tFgAIIak1k3lIAleRI3GerfY4FiM4Fp6NpqNSueHd/0q8F3fuGoRFMgNYja6koSCYfv80eY4dRUTMJtkC47RHNga+ZAdgfmN4jcXjHWC85YRHAv+pj9d3wy53O0bq9jNfQN3TOiBrTbW7g9yMdjrOgT8VMGiss013WWTr9vHPV6hL0iiiU3yaEA8aqdiGFxodFaYp1UxemimEOdZMLkMNM4HB2KvpQEep4C6e3hDECZtHSssbz91jTIaQk=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2019 13:11:05.0493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca6c371-24d5-46b8-5505-08d6fe25937b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.100];
 Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6321
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe51::616
Subject: Re: [Qemu-devel] [RFC PATCH] accel/tcg/translator: add tb_enter TCG
 trace
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
Cc: damien.hedde@greensocs.com, mark.burton@greensocs.com,
 qemu-devel@nongnu.org, sakisp@xilinx.com, edgari@xilinx.com,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 28, 2019 at 02:16:41PM +0200, Richard Henderson wrote:
> On 6/28/19 1:39 PM, Luc Michel wrote:
> > Add a TCG trace at the begining of a translation block recording the
> > first and last (past-the-end) PC values.
> > 
> > Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> > ---
> > This can be used to trace the execution of the guest quite efficiently.
> > It will report each time a TB is entered (using the tb_enter_exec
> > trace). The traces arguments give the PC start and past-the-end values.
> > It has very little to no performance impact since the trace is actually
> > emitted in the generated code only when it is enabled at run time.
> > 
> > It works already quite well on its own to trace guest execution. However
> > it does not handle the case where a TB is exited in the middle of
> > execution. I'm not sure how to properly trace that. A trace could be
> > added when `cpu_loop_exit()' is called to report the current PC, but in
> > most cases the interesting value (the PC of the instruction that
> > caused the exit) is already lost at this stage.
> > 
> > I'm not sure there is a generic (i.e. not target specific) way of
> > recovering the last PC executed when cpu_loop_exit() is called. Do you
> > think of a better way?
> > 
> > Thanks to the Xilinx's QEMU team who sponsored this work.
> > ---
> >  accel/tcg/translator.c | 24 ++++++++++++++++++++++++
> >  trace-events           |  3 +++
> >  2 files changed, 27 insertions(+)
> > 
> > diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> > index 9226a348a3..c55377aa18 100644
> > --- a/accel/tcg/translator.c
> > +++ b/accel/tcg/translator.c
> > @@ -14,10 +14,11 @@
> >  #include "tcg/tcg-op.h"
> >  #include "exec/exec-all.h"
> >  #include "exec/gen-icount.h"
> >  #include "exec/log.h"
> >  #include "exec/translator.h"
> > +#include "trace-tcg.h"
> >  
> >  /* Pairs with tcg_clear_temp_count.
> >     To be called by #TranslatorOps.{translate_insn,tb_stop} if
> >     (1) the target is sufficiently clean to support reporting,
> >     (2) as and when all temporaries are known to be consumed.
> > @@ -28,14 +29,31 @@ void translator_loop_temp_check(DisasContextBase *db)
> >          qemu_log("warning: TCG temporary leaks before "
> >                   TARGET_FMT_lx "\n", db->pc_next);
> >      }
> >  }
> >  
> > +static TCGOp *gen_trace_tb_enter(TranslationBlock *tb)
> > +{
> > +    TCGOp *last_pc_op;
> > +
> > +    TCGv pc_end = tcg_temp_new();
> > +
> > +    /* The last PC value is not known yet */
> > +    tcg_gen_movi_tl(pc_end, 0xdeadbeef);
> > +    last_pc_op = tcg_last_op();
> 
> TL is a target-specific type that does not necessarily correspond to uint64_t,
> as you assume in the print message.  More importantly, on a 32-bit host with a
> 64-bit guest, this movi will generate *two* ops...
> 
> > +    /* Fixup the last PC value in the tb_enter trace now that we know it */
> > +    tcg_set_insn_param(trace_pc_end, 1, db->pc_next);
> 
> ... which means that this operation does not do what you think it does.  It
> will only set one (unknown) half of the _i64 temporary.
> 
> Moreover, this isn't quite as zero overhead as I would like, because the pc_end
> temporary is always created, even if the trace_tb condition is not satisfied
> and so it (eventually) gets removed as unused.
> 
> I'm not quite sure what you're after with pc_end anyway.  As you note within
> the cover, you can't reliably use it for anything.  If you remove that, then
> you've also removed all of the other problems with this patch.
>

Hi,

One of the use cases is to be able to collect code-coverage from these traces.
In that case we're going to need a reliable pc_end. We may need to recover it
from outside of TCG in some cases though...

Cheers,
Edgar 


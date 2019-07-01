Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E15EC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD54F208CA
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 14:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="IPRI5HKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD54F208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhxKe-0000nO-55
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 10:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44272)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <edgar@xilinx.com>) id 1hhwWW-0005ca-Q5
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar@xilinx.com>) id 1hhwWT-0001wN-T1
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:39:12 -0400
Received: from mail-eopbgr770042.outbound.protection.outlook.com
 ([40.107.77.42]:18287 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <edgar@xilinx.com>) id 1hhwWR-0001si-Q0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3at3WpSpiOQMxPP3f5VFqSIesUUeKEw0ARO1/V7pWo=;
 b=IPRI5HKoicGcJ/y/z4UdT+K1Go4YkaC2D29z1x1NuYAV/ytMpzYaiZ6ASAuTHQVoYnBOswkH+ck0CYCGWNRdbDMLfGTkvel6TGB5VP4BVnr2l3VswwyVZ4eHyPXD72p9tJbX/iRjBe78yWICZTbwzq1UYxb6JLSfgH0DQDmHq5I=
Received: from BN7PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:20::23)
 by DM6PR02MB6329.namprd02.prod.outlook.com (2603:10b6:5:1d4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Mon, 1 Jul
 2019 13:39:05 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BN7PR02CA0010.outlook.office365.com
 (2603:10b6:408:20::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.17 via Frontend
 Transport; Mon, 1 Jul 2019 13:39:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; greensocs.com; dkim=none (message not signed)
 header.d=none;greensocs.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2032.15
 via Frontend Transport; Mon, 1 Jul 2019 13:39:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:42377
 helo=xsj-pvapsmtp01) by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1hhwWK-0003Vr-Mi; Mon, 01 Jul 2019 06:39:00 -0700
Received: from [127.0.0.1] (helo=localhost)
 by xsj-pvapsmtp01 with smtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1hhwWF-0003Ib-Jk; Mon, 01 Jul 2019 06:38:55 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
 by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x61Dcssx028059; 
 Mon, 1 Jul 2019 06:38:54 -0700
Received: from [10.71.119.209] (helo=localhost)
 by xsj-pvapsmtp01 with esmtp (Exim 4.63)
 (envelope-from <edgar@xilinx.com>)
 id 1hhwWE-0003IU-6k; Mon, 01 Jul 2019 06:38:54 -0700
Date: Mon, 1 Jul 2019 15:47:35 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Message-ID: <20190701134735.GC2840@toto>
References: <20190628113917.15869-1-luc.michel@greensocs.com>
 <f9c429e1-4a1d-959a-04c4-e9b7e94637cf@linaro.org>
 <20190701131933.GA2840@toto> <87blydswvc.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87blydswvc.fsf@zen.linaroharston>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100; IPV:NLI; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(7916004)(376002)(136003)(346002)(396003)(39860400002)(2980300002)(189003)(199004)(305945005)(14444005)(33656002)(106002)(356004)(70586007)(229853002)(316002)(70206006)(4326008)(81166006)(426003)(81156014)(2906002)(47776003)(9786002)(6666004)(6916009)(8936002)(33716001)(53546011)(8676002)(486006)(1076003)(50466002)(54906003)(76506005)(5660300002)(36386004)(23756003)(26005)(58126008)(63266004)(478600001)(76176011)(6246003)(66574012)(57986006)(186003)(336012)(11346002)(9686003)(126002)(476003)(2870700001)(446003)(77096007)(5001870100001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR02MB6329; H:xsj-pvapsmtpgw02; FPR:;
 SPF:Pass; LANG:en; PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com; MX:1; A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e7b1b6e-9810-481f-6309-08d6fe297af5
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);
 SRVR:DM6PR02MB6329; 
X-MS-TrafficTypeDiagnostic: DM6PR02MB6329:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB6329D0418ACD094DB0A9D10DC2F90@DM6PR02MB6329.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 00851CA28B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UuK1WKiyyVJuDpPbQqE3zSO2gpelDwF+dTSBdOplO2QjdG4OvI7XUkKQQNLoIayp42fe8ywu+Zo+wGH9fC7uXfJsKGic8fU/iljGAtxN5WZ5PMq4Dbl2tuIfc6qkH/YrhLlkpXOLcb8DRnMMFLGDLud9XNWnB4ISNHusg+7VMHVui4yaQOHK1B08UBRSiXP75r26i9jb/kvizVInEDBsJfT26CGft/NaGvzeafaJm/r0DoI37v444Q8t2Erg60EoLEMBLU4cEfyQj96tzPyz+x7AHHdoPS4x1cJ5bnyJ6C2ZCvR88AL3ZVMRyhC/Gba7Wq9WCHEEGkr2sBbnkhQJfPGJUld4IPnL1cRgG202Gr8uzqVJpWWhPp9kHM4I2VE+7EzooQx+seB7ixyaDOXSkPdODJ1mVfeFHUMHlRVGD98=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2019 13:39:01.1725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7b1b6e-9810-481f-6309-08d6fe297af5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.60.100];
 Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6329
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.77.42
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
Cc: damien.hedde@greensocs.com,
 Richard Henderson <richard.henderson@linaro.org>, mark.burton@greensocs.com,
 qemu-devel@nongnu.org, sakisp@xilinx.com, edgari@xilinx.com,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 01, 2019 at 02:33:11PM +0100, Alex Benn=E9e wrote:
>=20
> Edgar E. Iglesias <edgar.iglesias@xilinx.com> writes:
>=20
> > On Fri, Jun 28, 2019 at 02:16:41PM +0200, Richard Henderson wrote:
> >> On 6/28/19 1:39 PM, Luc Michel wrote:
> >> > Add a TCG trace at the begining of a translation block recording the
> >> > first and last (past-the-end) PC values.
> >> >
> >> > Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> >> > ---
> >> > This can be used to trace the execution of the guest quite efficient=
ly.
> >> > It will report each time a TB is entered (using the tb_enter_exec
> >> > trace). The traces arguments give the PC start and past-the-end valu=
es.
> >> > It has very little to no performance impact since the trace is actua=
lly
> >> > emitted in the generated code only when it is enabled at run time.
> >> >
> >> > It works already quite well on its own to trace guest execution. How=
ever
> >> > it does not handle the case where a TB is exited in the middle of
> >> > execution. I'm not sure how to properly trace that. A trace could be
> >> > added when `cpu_loop_exit()' is called to report the current PC, but=
 in
> >> > most cases the interesting value (the PC of the instruction that
> >> > caused the exit) is already lost at this stage.
> >> >
> >> > I'm not sure there is a generic (i.e. not target specific) way of
> >> > recovering the last PC executed when cpu_loop_exit() is called. Do y=
ou
> >> > think of a better way?
> >> >
> >> > Thanks to the Xilinx's QEMU team who sponsored this work.
> >> > ---
> >> >  accel/tcg/translator.c | 24 ++++++++++++++++++++++++
> >> >  trace-events           |  3 +++
> >> >  2 files changed, 27 insertions(+)
> >> >
> >> > diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
> >> > index 9226a348a3..c55377aa18 100644
> >> > --- a/accel/tcg/translator.c
> >> > +++ b/accel/tcg/translator.c
> >> > @@ -14,10 +14,11 @@
> >> >  #include "tcg/tcg-op.h"
> >> >  #include "exec/exec-all.h"
> >> >  #include "exec/gen-icount.h"
> >> >  #include "exec/log.h"
> >> >  #include "exec/translator.h"
> >> > +#include "trace-tcg.h"
> >> >
> >> >  /* Pairs with tcg_clear_temp_count.
> >> >     To be called by #TranslatorOps.{translate_insn,tb_stop} if
> >> >     (1) the target is sufficiently clean to support reporting,
> >> >     (2) as and when all temporaries are known to be consumed.
> >> > @@ -28,14 +29,31 @@ void translator_loop_temp_check(DisasContextBase=
 *db)
> >> >          qemu_log("warning: TCG temporary leaks before "
> >> >                   TARGET_FMT_lx "\n", db->pc_next);
> >> >      }
> >> >  }
> >> >
> >> > +static TCGOp *gen_trace_tb_enter(TranslationBlock *tb)
> >> > +{
> >> > +    TCGOp *last_pc_op;
> >> > +
> >> > +    TCGv pc_end =3D tcg_temp_new();
> >> > +
> >> > +    /* The last PC value is not known yet */
> >> > +    tcg_gen_movi_tl(pc_end, 0xdeadbeef);
> >> > +    last_pc_op =3D tcg_last_op();
> >>
> >> TL is a target-specific type that does not necessarily correspond to u=
int64_t,
> >> as you assume in the print message.  More importantly, on a 32-bit hos=
t with a
> >> 64-bit guest, this movi will generate *two* ops...
> >>
> >> > +    /* Fixup the last PC value in the tb_enter trace now that we kn=
ow it */
> >> > +    tcg_set_insn_param(trace_pc_end, 1, db->pc_next);
> >>
> >> ... which means that this operation does not do what you think it does=
.  It
> >> will only set one (unknown) half of the _i64 temporary.
> >>
> >> Moreover, this isn't quite as zero overhead as I would like, because t=
he pc_end
> >> temporary is always created, even if the trace_tb condition is not sat=
isfied
> >> and so it (eventually) gets removed as unused.
> >>
> >> I'm not quite sure what you're after with pc_end anyway.  As you note =
within
> >> the cover, you can't reliably use it for anything.  If you remove that=
, then
> >> you've also removed all of the other problems with this patch.
> >>
> >
> > Hi,
> >
> > One of the use cases is to be able to collect code-coverage from these =
traces.
> > In that case we're going to need a reliable pc_end. We may need to reco=
ver it
> > from outside of TCG in some cases though...
>=20
> Why?
>=20
> The only place you need to recover pc_end is when processing an
> exception and for that case the front end should be using
> cpu_loop_exit_restore() to ensure registers are valid before the
> exception is processed. Otherwise you know where you've been given the
> next block starts at pc_next (with -d nochain).

That's what I meant, that it may not be known to tcg generated code until a=
fter the fact.


>=20
> However I suspect if you want to build more sophisticated tools to track
> execution the plugin approach might be better. This seems like a bit of
> an arbitrary addition to the TCG core for a single use case where we
> already have logging facilities that will give you the same information.

Sure, if there are other better ways to do the tracing, it sounds good to m=
e.

Preferably it should be binary traces (otherwise it's to slow to generate a=
nd
process them plus the traces get huge). And better if we can optionally avo=
id
storing them in files (i.e stream and process them live via sockets) to sup=
port
large runs without storing huge intermediate files.

Cheers,
Edgar



>=20
> --
> Alex Benn=E9e


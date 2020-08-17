Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521FBC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165D520658
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 16:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="aUwu3Fh/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165D520658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hh6-0007Tm-VV
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 12:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1k7hXY-0003Zi-AH; Mon, 17 Aug 2020 11:59:16 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com
 ([40.107.92.74]:27006 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar@xilinx.com>)
 id 1k7hXV-0001ox-K1; Mon, 17 Aug 2020 11:59:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FivuklxainzcbViL7cUpbqExmCeobi5q+GqgBXV75ChLkTMuozQ+TPNEiiPYCSGJPI6OscVFym+kMfNRD87YwhehEaVzu3miaCwDzjhLkOgdiHYFSYXri6Q1F2YkMQfIbf2Wfni5XroDkG+dOxX2lLwOq7nJ0DOikvZpdkoxmRiOoHZmWyVOUea65e+thTulQ7UWo5Ah/s1QXw3p11/VK0rbstMgsAU4CSHVptTR+DifGjo4xDUsLBpFunuCZwMzrL78g7wCk4C2l/9wJHypPtgDtC/n4ux4cftYPDiUU3fAQn6FUp72wpk3cVZDhFONTB20QvwUQs2LPLhnOwmb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDRyOsSLLueB/yTDRoi5pZ7eGrTjrnmmLoTRXEwdDoM=;
 b=Uq6sqdoTO6kBbPH5G5AyE3hM11M2oHOpA66DH4NrCpWV8ntsu3lk5I3LXEBjinhzdJ6eE6nEiIUKggENjPt8YDLbbka0iLeQJiTz5fmXiqcCQapJeNKKnkFGjbzUsB9VhGcmoo9gxSOOjxVpG9nLKnKl/6fX+GqzqG96Z01Acmq/eCZN2trsuXGCVZvOwoP3z2NjkghsoNfPLXRMf0D5fflb+fUIYEhrFfTVPteynXH2hjr7/pe6BbtcKspwAg2cFYBmFQIQ/kcmjE/Tim439JqcYP5RMTNHE4cYhz1SN+cWMhMvCHV8L5I89FWBvJIkUHI+1ri9JsWVL9F9JDgMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 149.199.80.198) smtp.rcpttodomain=linaro.org
 smtp.mailfrom=xilinx.com; 
 dmarc=none action=none header.from=xilinx.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDRyOsSLLueB/yTDRoi5pZ7eGrTjrnmmLoTRXEwdDoM=;
 b=aUwu3Fh/S4IFfNYIp22KFoxr62qu/+1dmhLs0WvJSkUJCBNZjmzWvdmMUWAPFW/0rt6BCsYRZ/C4zWQw7dgf0UqtiVSunklj/xzThc4RBHyFWjdbUhz+592jKTF9+h1YGY/ddiuxYJiWyvt6NtxOwItsg4KTteQ01JjL8MnKkxw=
Received: from DM5PR18CA0095.namprd18.prod.outlook.com (2603:10b6:3:3::33) by
 BN8PR02MB5762.namprd02.prod.outlook.com (2603:10b6:408:b0::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.20; Mon, 17 Aug 2020 15:59:08 +0000
Received: from DM3NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::38) by DM5PR18CA0095.outlook.office365.com
 (2603:10b6:3:3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Mon, 17 Aug 2020 15:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 149.199.80.198) smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not
 signed) header.d=none;linaro.org; dmarc=none action=none
 header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 DM3NAM02FT041.mail.protection.outlook.com (10.13.5.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 15:59:07 +0000
Received: from xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 17 Aug 2020 16:59:06 +0100
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 17 Aug 2020 16:59:06 +0100
Received: from [10.71.119.128] (port=50575 helo=localhost)
 by smtp.xilinx.com with esmtp (Exim 4.90)
 (envelope-from <edgar@xilinx.com>)
 id 1k7hXO-0002sZ-Ce; Mon, 17 Aug 2020 16:59:06 +0100
Date: Mon, 17 Aug 2020 17:59:06 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 4/5] target/microblaze: swx: Use atomic_cmpxchg
Message-ID: <20200817155906.GL31713@toto>
References: <20200817140144.373403-1-edgar.iglesias@gmail.com>
 <20200817140144.373403-5-edgar.iglesias@gmail.com>
 <c6aebf82-8518-ed06-2b2e-1397f373bedf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c6aebf82-8518-ed06-2b2e-1397f373bedf@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e60d79d7-9ebe-4ad0-c7b8-08d842c6794c
X-MS-TrafficTypeDiagnostic: BN8PR02MB5762:
X-Microsoft-Antispam-PRVS: <BN8PR02MB5762C8F32455EE1D4F2A4BD0C25F0@BN8PR02MB5762.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eeQ77LHbudbP34WNfvLy3IBSKB8G/NV8vbVBGW8pYD92lqy/JT70mP8zCp1+FPss0ppSUTKV/s26P7SP+X1GTtrwf8+tC+B5uSvnDSYDnAQZhiweOtZlf1rOVnPDcu1tlkrkRN9Fx+jFv0FQb43tGsI/P32WNO150Bl5GyfU57JiDiGc9YRhvB6TmQJpEPDpMx1Eaf6dklK4JCqcYOOj6vynw63tEps+weU6K/tS+WdHNJXtv1KCHdUldvQ3YDOgUXaVUyMPAZ/PS4yGoYSYG8B292pY0jJuBDVRyKNr3wBPvHUhHFO1RnoYnf0GFBxNUB9WKNYRwhmDf64bU6dcIJIEUToR2D6w9Fp/8rg44v3Q1+FoB23ldG932cYnlwHhUw62Zlib+SoZaIDr8dvcGA==
X-Forefront-Antispam-Report: CIP:149.199.80.198; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:xir-pvapexch02.xlnx.xilinx.com;
 PTR:unknown-80-198.xilinx.com; CAT:NONE;
 SFS:(7916004)(346002)(376002)(39860400002)(396003)(136003)(46966005)(63350400001)(1076003)(33716001)(9786002)(8676002)(7416002)(186003)(6916009)(26005)(107886003)(478600001)(316002)(336012)(33656002)(47076004)(4326008)(8936002)(82740400003)(70206006)(9686003)(5660300002)(83380400001)(356005)(54906003)(2906002)(53546011)(82310400002)(7636003)(70586007)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 15:59:07.6858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e60d79d7-9ebe-4ad0-c7b8-08d842c6794c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c; Ip=[149.199.80.198];
 Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5762
Received-SPF: pass client-ip=40.107.92.74; envelope-from=edgar@xilinx.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 11:59:11
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me,
 qemu-devel@nongnu.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 08:52:16AM -0700, Richard Henderson wrote:
> On 8/17/20 7:01 AM, Edgar E. Iglesias wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> > 
> > Use atomic_cmpxchg to implement the atomic cmpxchg sequence.
> > 
> > Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> > ---
> >  target/microblaze/translate.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> > index c58f334a0f..530c15e5ad 100644
> > --- a/target/microblaze/translate.c
> > +++ b/target/microblaze/translate.c
> > @@ -1075,14 +1075,16 @@ static void dec_store(DisasContext *dc)
> >          swx_skip = gen_new_label();
> >          tcg_gen_brcond_tl(TCG_COND_NE, env_res_addr, addr, swx_skip);
> >  
> > -        /* Compare the value loaded at lwx with current contents of
> > -           the reserved location.
> > -           FIXME: This only works for system emulation where we can expect
> > -           this compare and the following write to be atomic. For user
> > -           emulation we need to add atomicity between threads.  */
> > +        /*
> > +         * Compare the value loaded at lwx with current contents of
> > +         * the reserved location.
> > +         */
> >          tval = tcg_temp_new_i32();
> > -        tcg_gen_qemu_ld_i32(tval, addr, cpu_mmu_index(&dc->cpu->env, false),
> > -                            MO_TEUL);
> > +
> > +        tcg_gen_atomic_cmpxchg_i32(tval, addr, env_res_val,
> > +                                   cpu_R[dc->rd], mem_index,
> > +                                   mop);
> > +
> >          tcg_gen_brcond_i32(TCG_COND_NE, env_res_val, tval, swx_skip);
> >          write_carryi(dc, 0);
> >          tcg_temp_free_i32(tval);
> > @@ -1108,7 +1110,10 @@ static void dec_store(DisasContext *dc)
> >                  break;
> >          }
> >      }
> > -    tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
> > +
> > +    if (!ex) {
> > +        tcg_gen_qemu_st_i32(cpu_R[dc->rd], addr, mem_index, mop);
> > +    }
> >  
> >      /* Verify alignment if needed.  */
> >      if (dc->cpu->cfg.unaligned_exceptions && size > 1) {
> > 
> 
> This is fine as far as the actual swx instruction goes, so
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> However, some notes for dec_store,
> 
> There seems to be a large under-decode here.  E.g. rev should never be set for
> swx.  But rev is accepted and partially implemented.  E.g. there is no sbx
> instruction, but the ex bit is accepted for any store instruction.
> 
> Microblaze has a relatively small instruction set.  Would you be open to a
> conversion to decodetree?  It should be fairly easy.
>

Thanks Richard,

Yes, I've got a conversion to decodetree on my TODO list (before adding 64bit support).
I'll probably bug you when I get to it!

Best regards,
Edgar


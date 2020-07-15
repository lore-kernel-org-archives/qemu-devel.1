Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ED5C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 02:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6841420663
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 02:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6841420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvXYa-00040U-LB
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 22:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jvXXe-0003WC-FF; Tue, 14 Jul 2020 22:53:06 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jvXXZ-0001zp-TL; Tue, 14 Jul 2020 22:53:06 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07516912|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.0747618-0.0105898-0.914648;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03306; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.I1rnTxH_1594781569; 
Received: from 30.225.208.24(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I1rnTxH_1594781569)
 by smtp.aliyun-inc.com(10.147.41.178);
 Wed, 15 Jul 2020 10:52:49 +0800
Subject: Re: [RFC 05/65] target/riscv: remove vsll.vi, vsrl.vi, vsra.vi insns
 from using gvec
To: Frank Chang <frank.chang@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-6-frank.chang@sifive.com>
 <452e8bc7-4622-77c2-ec81-9aa6f25705fc@linaro.org>
 <CAE_xrPjWr2KShiwaCZi1DXueFnRAz41D3j9_k2vBL2j7-d9WOQ@mail.gmail.com>
 <0ccc7311-02f4-821f-6272-73ab600a8cda@linaro.org>
 <CAE_xrPg9otd9tbpHL_1DmvZ=3nFNdgkse_nUe=fApTQt1hPCYA@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <5e56bedb-b404-19f9-4dbf-dfd675aee383@c-sky.com>
Date: Wed, 15 Jul 2020 10:52:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPg9otd9tbpHL_1DmvZ=3nFNdgkse_nUe=fApTQt1hPCYA@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------8C543CA8B571EB653508EBBC"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 22:52:51
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------8C543CA8B571EB653508EBBC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/7/14 21:59, Frank Chang wrote:
> On Tue, Jul 14, 2020 at 9:21 PM Richard Henderson 
> <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> 
> wrote:
>
>     On 7/13/20 7:59 PM, Frank Chang wrote:
>     > The latest spec specified:
>     >
>     > Only the low *lg2(SEW) bits* are read to obtain the shift amount
>     from a
>     > *register value*.
>     > The *immediate* is treated as an *unsigned shift amount*, with a
>     *maximum shift
>     > amount of 31*.
>
>     Which, I hope you will agree is underspecified, and should be
>     reported as a bug
>     in the manual.
>
>
> Yes, you're correct.
> I found out I missed the MASK part in GEN_VEXT_SHIFT_VV() macro,
> which this macro is shared between OPIVV and OPIVI format of instructions.
> So the same masking methodology should be applied to shift amounts 
> coming from both register and immediate value.
> Spike also does something like:
> /vs2 >> (zimm5 & (sew - 1) & 0x1f);/ for SEW = 8.
>
> I think spec is kind of misleading to the reader by the way it expresses.
>
>
>     > Looks like the shift amount in the immediate value is not
>     relevant with SEW
>     > setting.
>
>     How can it not be?  It is when the value comes from a register...
>
>     > If so, is it better to just use do_opivi_gvec() and implement
>     the logic by our
>     > own rather than using gvec IR?
>
>     No, it is not.  What is the logic you would apply on your own? 
>     There should be
>     a right answer.
>
>
> I was talking about just calling GEN_OPIVI_TRANS() to generate the 
> helper functions
> defined in vector_helper.c as what I'm doing in the original patch.
> But as long as the immediate value should also apply *lg2(SEW) bits* 
> truncating,
> I think I should update GEN_OPIVI_GVEC_TRANS() to utilize gvec IR.
>
>
>     If the answer is that out-of-range shift produces zero, which some
>     architectures use, then you can look at the immediate value, see
>     that you must
>     supply zero, and then fill the vector with zeros from translate. 
>     You need not
>     call a helper to perform N shifts when you know the result a-priori.
>
>     If the answer is that shift values are truncated, which riscv uses
>     *everywhere
>     else*, then you should truncate the immediate value during translate.
>
>
> I think vsll.vi <http://vsll.vi>, vsrl.vi <http://vsrl.vi> and vsra.vi 
> <http://vsra.vi> truncate the out-of-range shift as other riscv 
> instructions.
> I will double confirm that, thanks for the advice.
>
Perhaps the reason is that the assembler can't identify if an imm is 
legal according to log(SEW),
because the assembler can't get the SEW.

To make more compliance with assembler directly users'  intuition, just 
let the imm encoding to insn as itself(truncate to 31)
and work as itself.

Zhiwei
> Frank Chang
>
>
>
>     r~
>


--------------8C543CA8B571EB653508EBBC
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/7/14 21:59, Frank Chang wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAE_xrPg9otd9tbpHL_1DmvZ=3nFNdgkse_nUe=fApTQt1hPCYA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">On Tue, Jul 14, 2020 at 9:21 PM Richard Henderson
          &lt;<a href="mailto:richard.henderson@linaro.org"
            moz-do-not-send="true">richard.henderson@linaro.org</a>&gt;
          wrote:<br>
        </div>
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">On 7/13/20 7:59 PM, Frank
            Chang wrote:<br>
            &gt; The latest spec specified:<br>
            &gt; <br>
            &gt; Only the low *lg2(SEW) bits* are read to obtain the
            shift amount from a<br>
            &gt; *register value*.<br>
            &gt; The *immediate* is treated as an *unsigned shift
            amount*, with a *maximum shift<br>
            &gt; amount of 31*.<br>
            <br>
            Which, I hope you will agree is underspecified, and should
            be reported as a bug<br>
            in the manual.<br>
          </blockquote>
          <div><br>
          </div>
          <div>Yes, you're correct.</div>
          <div>I found out I missed the MASK part in GEN_VEXT_SHIFT_VV()
            macro,</div>
          <div>which this macro is shared between OPIVV and OPIVI format
            of instructions.</div>
          <div>So the same masking methodology should be applied to
            shift amounts coming from both register and immediate value.</div>
          <div>Spike also does something like:</div>
          <div><i>vs2 &gt;&gt; (zimm5 &amp; (sew - 1) &amp; 0x1f);</i>
            for SEW = 8.</div>
          <div><br>
          </div>
          <div>I think spec is kind of misleading to the reader by the
            way it expresses.</div>
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            &gt; Looks like the shift amount in the immediate value is
            not relevant with SEW<br>
            &gt; setting.<br>
            <br>
            How can it not be?  It is when the value comes from a
            register...<br>
            <br>
            &gt; If so, is it better to just use do_opivi_gvec() and
            implement the logic by our<br>
            &gt; own rather than using gvec IR?<br>
            <br>
            No, it is not.  What is the logic you would apply on your
            own?  There should be<br>
            a right answer.<br>
          </blockquote>
          <div><br>
          </div>
          <div>I was talking about just calling GEN_OPIVI_TRANS() to
            generate the helper functions</div>
          <div>defined in vector_helper.c as what I'm doing in the
            original patch.</div>
          <div>But as long as the immediate value should also
            apply *lg2(SEW) bits* truncating,</div>
          <div>I think I should update GEN_OPIVI_GVEC_TRANS() to utilize
            gvec IR.</div>
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            If the answer is that out-of-range shift produces zero,
            which some<br>
            architectures use, then you can look at the immediate value,
            see that you must<br>
            supply zero, and then fill the vector with zeros from
            translate.  You need not<br>
            call a helper to perform N shifts when you know the result
            a-priori.<br>
            <br>
            If the answer is that shift values are truncated, which
            riscv uses *everywhere<br>
            else*, then you should truncate the immediate value during
            translate.<br>
          </blockquote>
          <div><br>
          </div>
          <div>I think <a href="http://vsll.vi" moz-do-not-send="true">vsll.vi</a>,
            <a href="http://vsrl.vi" moz-do-not-send="true">vsrl.vi</a>
            and <a href="http://vsra.vi" moz-do-not-send="true">vsra.vi</a>
            truncate the out-of-range shift as other riscv instructions.</div>
          <div>I will double confirm that, thanks for the advice.</div>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
    Perhaps the reason is that the assembler can't identify if an imm is
    legal according to log(SEW),<br>
    because the assembler can't get the SEW.<br>
    <br>
    To make more compliance with assembler directly users'  intuition,
    just let the imm encoding to insn as itself(truncate to 31)<br>
    and work as itself.<br>
    <br>
    Zhiwei<br>
    <blockquote type="cite"
cite="mid:CAE_xrPg9otd9tbpHL_1DmvZ=3nFNdgkse_nUe=fApTQt1hPCYA@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div>Frank Chang</div>
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            <br>
            r~<br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------8C543CA8B571EB653508EBBC--


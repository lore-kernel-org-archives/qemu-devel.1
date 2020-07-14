Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA308C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11632193E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 03:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11632193E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvBk3-0004nD-V3
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 23:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jvBjU-0004N3-6h; Mon, 13 Jul 2020 23:35:52 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jvBjQ-0001u8-Va; Mon, 13 Jul 2020 23:35:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07578062|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.108965-0.0422159-0.848819;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03275; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=8; RT=8; SR=0; TI=SMTPD_---.I1Nahlc_1594697733; 
Received: from 30.225.208.64(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I1Nahlc_1594697733)
 by smtp.aliyun-inc.com(10.147.41.138);
 Tue, 14 Jul 2020 11:35:33 +0800
Subject: Re: [RFC 05/65] target/riscv: remove vsll.vi, vsrl.vi, vsra.vi insns
 from using gvec
To: Frank Chang <frank.chang@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-6-frank.chang@sifive.com>
 <452e8bc7-4622-77c2-ec81-9aa6f25705fc@linaro.org>
 <CAE_xrPjWr2KShiwaCZi1DXueFnRAz41D3j9_k2vBL2j7-d9WOQ@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <407ef5d5-d9d9-9619-b6e3-456f8a5b4bfb@c-sky.com>
Date: Tue, 14 Jul 2020 11:35:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPjWr2KShiwaCZi1DXueFnRAz41D3j9_k2vBL2j7-d9WOQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------81764C5E5A682BD8AF0E482C"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 23:35:37
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
--------------81764C5E5A682BD8AF0E482C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/7/14 10:59, Frank Chang wrote:
> On Sat, Jul 11, 2020 at 12:27 AM Richard Henderson 
> <richard.henderson@linaro.org <mailto:richard.henderson@linaro.org>> 
> wrote:
>
>     On 7/10/20 3:48 AM, frank.chang@sifive.com
>     <mailto:frank.chang@sifive.com> wrote:
>     > From: Frank Chang <frank.chang@sifive.com
>     <mailto:frank.chang@sifive.com>>
>     >
>     > vsll.vi <http://vsll.vi>, vsrl.vi <http://vsrl.vi>, vsra.vi
>     <http://vsra.vi> cannot use shli gvec as it requires the
>     > shift immediate value to be within the range: [0.. SEW bits].
>     > Otherwise, it will hit the assertion:
>     > tcg_debug_assert(shift >= 0 && shift < (8 << vece));
>     >
>     > However, RVV spec does not have such constraint, therefore we
>     have to
>     > use helper functions instead.
>
>     Why do you say that?  It does have such a constraint:
>
>     # Only the low lg2(SEW) bits are read to obtain the shift amount
>     from a
>     register value.
>
>     While that only talks about the register value, I sincerely doubt
>     that the same
>     truncation does not actually apply to immediates.
>
>     And if the entire immediate value does apply, the manual should
>     certainly
>     specify what should happen in that case.  And at present it doesn't.
>
>     It seems to me the bug is the bare use of GEN_OPIVI_GVEC_TRANS and
>     thence
>     do_opivi_gvec.  The ZX parameter should be extended to more than
>     just "zero vs
>     sign-extend", it should have an option for truncating the
>     immediate to s->sew.
>
>
>     r~
>
>
> The latest spec specified:
>
> Only the low *lg2(SEW) bits* are read to obtain the shift amount from 
> a *register value*.
> The *immediate* is treated as an *unsigned shift amount*, with a 
> *maximum shift amount of 31*.
>
> Looks like the shift amount in the immediate value is not relevant 
> with SEW setting.
> If so, is it better to just use do_opivi_gvec() and implement the 
> logic by our own rather than using gvec IR?

In my opinion, it doesn't matter to truncate the immediate to s->sew 
before calling the gvec IR,
whether the constraint of immediate exits or not.

Zhiwei
>
> Frank Chang


--------------81764C5E5A682BD8AF0E482C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/7/14 10:59, Frank Chang wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAE_xrPjWr2KShiwaCZi1DXueFnRAz41D3j9_k2vBL2j7-d9WOQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">On Sat, Jul 11, 2020 at 12:27 AM Richard
          Henderson &lt;<a href="mailto:richard.henderson@linaro.org"
            moz-do-not-send="true">richard.henderson@linaro.org</a>&gt;
          wrote:<br>
        </div>
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">On 7/10/20 3:48 AM, <a
              href="mailto:frank.chang@sifive.com" target="_blank"
              moz-do-not-send="true">frank.chang@sifive.com</a> wrote:<br>
            &gt; From: Frank Chang &lt;<a
              href="mailto:frank.chang@sifive.com" target="_blank"
              moz-do-not-send="true">frank.chang@sifive.com</a>&gt;<br>
            &gt; <br>
            &gt; <a href="http://vsll.vi" rel="noreferrer"
              target="_blank" moz-do-not-send="true">vsll.vi</a>, <a
              href="http://vsrl.vi" rel="noreferrer" target="_blank"
              moz-do-not-send="true">vsrl.vi</a>, <a
              href="http://vsra.vi" rel="noreferrer" target="_blank"
              moz-do-not-send="true">vsra.vi</a> cannot use shli gvec as
            it requires the<br>
            &gt; shift immediate value to be within the range: [0.. SEW
            bits].<br>
            &gt; Otherwise, it will hit the assertion:<br>
            &gt; tcg_debug_assert(shift &gt;= 0 &amp;&amp; shift &lt; (8
            &lt;&lt; vece));<br>
            &gt; <br>
            &gt; However, RVV spec does not have such constraint,
            therefore we have to<br>
            &gt; use helper functions instead.<br>
            <br>
            Why do you say that?  It does have such a constraint:<br>
            <br>
            # Only the low lg2(SEW) bits are read to obtain the shift
            amount from a<br>
            register value.<br>
            <br>
            While that only talks about the register value, I sincerely
            doubt that the same<br>
            truncation does not actually apply to immediates.<br>
            <br>
            And if the entire immediate value does apply, the manual
            should certainly<br>
            specify what should happen in that case.  And at present it
            doesn't.<br>
            <br>
            It seems to me the bug is the bare use of
            GEN_OPIVI_GVEC_TRANS and thence<br>
            do_opivi_gvec.  The ZX parameter should be extended to more
            than just "zero vs<br>
            sign-extend", it should have an option for truncating the
            immediate to s-&gt;sew.<br>
            <br>
            <br>
            r~<br>
          </blockquote>
          <div><br>
          </div>
          <div>The latest spec specified:</div>
          <div><br>
          </div>
          Only the low <b>lg2(SEW) bits</b> are read to obtain the
          shift amount from a <b>register value</b>.<br>
          <div>The <b>immediate</b> is treated as an <b>unsigned shift
              amount</b>, with a <b>maximum shift amount of 31</b>.</div>
          <div><br>
          </div>
          <div>Looks like the shift amount in the immediate value is not
            relevant with SEW setting.</div>
          <div>If so, is it better to just use do_opivi_gvec() and
            implement the logic by our own rather than using gvec IR?</div>
        </div>
      </div>
    </blockquote>
    <br>
    In my opinion, it doesn't matter to truncate the immediate to
    s-&gt;sew before calling the gvec IR, <br>
    whether the constraint of immediate exits or not. <br>
    <br>
    Zhiwei<br>
    <blockquote type="cite"
cite="mid:CAE_xrPjWr2KShiwaCZi1DXueFnRAz41D3j9_k2vBL2j7-d9WOQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>Frank Chang</div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------81764C5E5A682BD8AF0E482C--


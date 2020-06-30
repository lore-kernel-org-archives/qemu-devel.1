Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992B9C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD1C20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 07:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD1C20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqAln-0005tX-N4
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 03:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqAjg-0003jx-7A; Tue, 30 Jun 2020 03:31:20 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqAjb-0005Ju-Jd; Tue, 30 Jun 2020 03:31:19 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09593058|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0168163-0.00683792-0.976346;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03301; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.Hv39IgI_1593502266; 
Received: from 30.225.208.21(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Hv39IgI_1593502266)
 by smtp.aliyun-inc.com(10.147.44.129);
 Tue, 30 Jun 2020 15:31:07 +0800
Subject: Re: [PATCH 3/6] target/riscv: Check for LEGAL NaN-boxing
To: Chih-Min Chao <chihmin.chao@sifive.com>
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
 <20200626205917.4545-4-zhiwei_liu@c-sky.com>
 <CAEiOBXWCVWhZ4oopTvmhU5yfSW+pdyJPDvqDfnvHD2DesXdAhQ@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <1c4c9bff-7f77-6d8d-2950-7cc030175c05@c-sky.com>
Date: Tue, 30 Jun 2020 15:31:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAEiOBXWCVWhZ4oopTvmhU5yfSW+pdyJPDvqDfnvHD2DesXdAhQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------3B7E139C1DF6F854F1510999"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:56:46
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, wenmeng_zhang@c-sky.com,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Ian Jiang <ianjiang.ict@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------3B7E139C1DF6F854F1510999
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/6/30 15:20, Chih-Min Chao wrote:
>
>
> On Sat, Jun 27, 2020 at 5:05 AM LIU Zhiwei <zhiwei_liu@c-sky.com 
> <mailto:zhiwei_liu@c-sky.com>> wrote:
>
>     A narrow n-bit operation, where n < FLEN, checks that input operands
>     are correctly NaN-boxed, i.e., all upper FLEN - n bits are 1.
>     If so, the n least-significant bits of the input are used as the
>     input value,
>     otherwise the input value is treated as an n-bit canonical NaN.
>
>     Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com
>     <mailto:zhiwei_liu@c-sky.com>>
>     ---
>      target/riscv/translate.c | 29 +++++++++++++++++++++++++++++
>      1 file changed, 29 insertions(+)
>
>     diff --git a/target/riscv/translate.c b/target/riscv/translate.c
>     index 4b1534c9a6..1c9b809d4a 100644
>     --- a/target/riscv/translate.c
>     +++ b/target/riscv/translate.c
>     @@ -104,6 +104,35 @@ static void gen_nanbox_fpr(DisasContext *ctx,
>     int regno)
>          }
>      }
>
>     +/*
>     + * A narrow n-bit operation, where n < FLEN, checks that input
>     operands
>     + * are correctly NaN-boxed, i.e., all upper FLEN - n bits are 1.
>     + * If so, the n least-signicant bits of the input are used as the
>     input value,
>     + * otherwise the input value is treated as an n-bit canonical NaN.
>     + * (riscv-spec-v2.2 Section 9.2).
>     + */
>     +static void check_nanboxed(DisasContext *ctx, int num, ...)
>     +{
>     +    if (has_ext(ctx, RVD)) {
>     +        int i;
>     +        TCGv_i64 cond1 = tcg_temp_new_i64();
>
> forget to remove ?
Oops!  Once I wanted to use tcg_gen_setcond_i64.

Thanks for pointing it out. I will fixed it next patch set.

Zhiwei

>     +        TCGv_i64 t_nan = tcg_const_i64(0x7fc00000);
>     +        TCGv_i64 t_max = tcg_const_i64(MAKE_64BIT_MASK(32, 32));
>     +        va_list valist;
>     +        va_start(valist, num);
>     +
>     +        for (i = 0; i < num; i++) {
>     +            TCGv_i64 t = va_arg(valist, TCGv_i64);
>     +            tcg_gen_movcond_i64(TCG_COND_GEU, t, t, t_max, t, t_nan);
>     +        }
>     +
>     +        va_end(valist);
>     +        tcg_temp_free_i64(cond1);
>
> forget to remove ?
>
>     +        tcg_temp_free_i64(t_nan);
>     +        tcg_temp_free_i64(t_max);
>     +    }
>     +}
>     +
>      static void generate_exception(DisasContext *ctx, int excp)
>      {
>          tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
>     -- 
>     2.23.0
>
>
>  Chih-Min Chao


--------------3B7E139C1DF6F854F1510999
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/6/30 15:20, Chih-Min Chao
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAEiOBXWCVWhZ4oopTvmhU5yfSW+pdyJPDvqDfnvHD2DesXdAhQ@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br clear="all">
          <div>
            <div dir="ltr" class="gmail_signature"
              data-smartmail="gmail_signature">
              <div dir="ltr"><span style="color:rgb(136,136,136)"></span>
                <div style="color:rgb(136,136,136)"><br>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Sat, Jun 27, 2020 at 5:05
            AM LIU Zhiwei &lt;<a href="mailto:zhiwei_liu@c-sky.com"
              moz-do-not-send="true">zhiwei_liu@c-sky.com</a>&gt; wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">A narrow n-bit operation,
            where n &lt; FLEN, checks that input operands<br>
            are correctly NaN-boxed, i.e., all upper FLEN - n bits are
            1.<br>
            If so, the n least-significant bits of the input are used as
            the input value,<br>
            otherwise the input value is treated as an n-bit canonical
            NaN.<br>
            <br>
            Signed-off-by: LIU Zhiwei &lt;<a
              href="mailto:zhiwei_liu@c-sky.com" target="_blank"
              moz-do-not-send="true">zhiwei_liu@c-sky.com</a>&gt;<br>
            ---<br>
             target/riscv/translate.c | 29 +++++++++++++++++++++++++++++<br>
             1 file changed, 29 insertions(+)<br>
            <br>
            diff --git a/target/riscv/translate.c
            b/target/riscv/translate.c<br>
            index 4b1534c9a6..1c9b809d4a 100644<br>
            --- a/target/riscv/translate.c<br>
            +++ b/target/riscv/translate.c<br>
            @@ -104,6 +104,35 @@ static void gen_nanbox_fpr(DisasContext
            *ctx, int regno)<br>
                 }<br>
             }<br>
            <br>
            +/*<br>
            + * A narrow n-bit operation, where n &lt; FLEN, checks that
            input operands<br>
            + * are correctly NaN-boxed, i.e., all upper FLEN - n bits
            are 1.<br>
            + * If so, the n least-signicant bits of the input are used
            as the input value,<br>
            + * otherwise the input value is treated as an n-bit
            canonical NaN.<br>
            + * (riscv-spec-v2.2 Section 9.2).<br>
            + */<br>
            +static void check_nanboxed(DisasContext *ctx, int num, ...)<br>
            +{<br>
            +    if (has_ext(ctx, RVD)) {<br>
            +        int i;<br>
            +        TCGv_i64 cond1 = tcg_temp_new_i64();<br>
          </blockquote>
          <div>forget to remove ? <br>
          </div>
        </div>
      </div>
    </blockquote>
    Oops!  Once I wanted to use tcg_gen_setcond_i64. <br>
    <br>
    Thanks for pointing it out. I will fixed it next patch set.<br>
    <br>
    Zhiwei<br>
    <br>
    <blockquote type="cite"
cite="mid:CAEiOBXWCVWhZ4oopTvmhU5yfSW+pdyJPDvqDfnvHD2DesXdAhQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            +        TCGv_i64 t_nan = tcg_const_i64(0x7fc00000);<br>
            +        TCGv_i64 t_max = tcg_const_i64(MAKE_64BIT_MASK(32,
            32));<br>
            +        va_list valist;<br>
            +        va_start(valist, num);<br>
            +<br>
            +        for (i = 0; i &lt; num; i++) {<br>
            +            TCGv_i64 t = va_arg(valist, TCGv_i64);<br>
            +            tcg_gen_movcond_i64(TCG_COND_GEU, t, t, t_max,
            t, t_nan);<br>
            +        }<br>
            +<br>
            +        va_end(valist);<br>
            +        tcg_temp_free_i64(cond1);<br>
          </blockquote>
          <div>forget to remove ?  </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            +        tcg_temp_free_i64(t_nan);<br>
            +        tcg_temp_free_i64(t_max);<br>
            +    }<br>
            +}<br>
            +<br>
             static void generate_exception(DisasContext *ctx, int excp)<br>
             {<br>
                 tcg_gen_movi_tl(cpu_pc, ctx-&gt;base.pc_next);<br>
            -- <br>
            2.23.0<br>
            <br>
          </blockquote>
          <div><br>
          </div>
          <div> </div>
          <div> Chih-Min Chao</div>
          <div> </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------3B7E139C1DF6F854F1510999--


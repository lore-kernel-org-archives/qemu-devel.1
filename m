Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13688C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB037204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB037204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3Zz9-0004hb-50
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 03:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1k3ZyX-0004DJ-2A; Thu, 06 Aug 2020 03:06:05 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1k3ZyR-0006zj-GS; Thu, 06 Aug 2020 03:06:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07735255|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.025566-0.000491407-0.973943;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01a16378; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=6; RT=6; SR=0; TI=SMTPD_---.IDGOXO8_1596697544; 
Received: from 30.225.208.44(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.IDGOXO8_1596697544)
 by smtp.aliyun-inc.com(10.147.42.22); Thu, 06 Aug 2020 15:05:45 +0800
Subject: Re: [PATCH v2 1/7] target/riscv: Generate nanboxed results from fp
 helpers
To: Chih-Min Chao <chihmin.chao@sifive.com>
References: <20200724002807.441147-1-richard.henderson@linaro.org>
 <20200724002807.441147-2-richard.henderson@linaro.org>
 <1aa6cb56-2f41-45c1-2d32-ec8b3b10780b@c-sky.com>
 <9e10c17c-7a9e-5f7f-b1e3-c195d4e30b32@linaro.org>
 <ccc72223-d98e-6dd4-6c44-ca30f4e687d5@c-sky.com>
 <CAEiOBXXmz2APpmtwPrvikXUt5j_Q=k5ZqK9g2Fe4bdjeAbg_6g@mail.gmail.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <4183e2c5-9a9b-2416-301d-95e62ac53a6c@c-sky.com>
Date: Thu, 6 Aug 2020 15:05:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAEiOBXXmz2APpmtwPrvikXUt5j_Q=k5ZqK9g2Fe4bdjeAbg_6g@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------4A744EF9BA97243CD4F85E41"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:05:47
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair23@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------4A744EF9BA97243CD4F85E41
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/8/6 14:09, Chih-Min Chao wrote:
> On Fri, Jul 24, 2020 at 2:06 PM LIU Zhiwei <zhiwei_liu@c-sky.com 
> <mailto:zhiwei_liu@c-sky.com>> wrote:
>
>
>
>     On 2020/7/24 11:55, Richard Henderson wrote:
>     > On 7/23/20 7:35 PM, LIU Zhiwei wrote:
>     >>
>     >> On 2020/7/24 8:28, Richard Henderson wrote:
>     >>> Make sure that all results from single-precision scalar helpers
>     >>> are properly nan-boxed to 64-bits.
>     >>>
>     >>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
>     >>> ---
>     >>>    target/riscv/internals.h  |  5 +++++
>     >>>    target/riscv/fpu_helper.c | 42
>     +++++++++++++++++++++------------------
>     >>>    2 files changed, 28 insertions(+), 19 deletions(-)
>     >>>
>     >>> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
>     >>> index 37d33820ad..9f4ba7d617 100644
>     >>> --- a/target/riscv/internals.h
>     >>> +++ b/target/riscv/internals.h
>     >>> @@ -38,4 +38,9 @@ target_ulong fclass_d(uint64_t frs1);
>     >>>    #define SEW32 2
>     >>>    #define SEW64 3
>     >>>    +static inline uint64_t nanbox_s(float32 f)
>     >>> +{
>     >>> +    return f | MAKE_64BIT_MASK(32, 32);
>     >>> +}
>     >>> +
>     >> If define it here,  we can also define a more general  function
>     with flen.
>     >>
>     >> +static inline uint64_t nanbox_s(float32 f, uint32_t flen)
>     >> +{
>     >> +    return f | MAKE_64BIT_MASK(flen, 64 - flen);
>     >> +}
>     >> +
>     >>
>     >> So we can reuse it in fp16 or bf16 scalar instruction and in
>     vector instructions.
>     > While we could do that, we will not encounter all possible
>     lengths.  In the
>     > cover letter, I mentioned defining a second function,
>     >
>     > static inline uint64_t nanbox_h(float16 f)
>     > {
>     >     return f | MAKE_64BIT_MASK(16, 48);
>     > }
>     >
>     > Having two separate functions will, I believe, be easier to use
>     in practice.
>     >
>     Get  it. Thanks.
>
>     Zhiwei
>     >
>     > r~
>
>
>
> That is what has been implemented in spike.  It fills up the Nan-Box 
> when value is stored back internal structure and
> unbox the value with difference floating type (half/single/double/quad).
Hi Chih-Min,

Has half-precision been a part of RVV? Or do you know the ISA 
abbreviation of half-precision?

Thanks very much.

Best Regards,
Zhiwei
>
> By the way,  I prefer to keeping the suffix to tell different floating 
> type rather than pass arbitrary
> since each floating type belong to each extension.
>
> Reviewed-by: Chih-Min Chao <chihmin.chao@sifive.com 
> <mailto:chihmin.chao@sifive.com>>


--------------4A744EF9BA97243CD4F85E41
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/8/6 14:09, Chih-Min Chao wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAEiOBXXmz2APpmtwPrvikXUt5j_Q=k5ZqK9g2Fe4bdjeAbg_6g@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr">
          <div>
            <div dir="ltr" class="gmail_signature"
              data-smartmail="gmail_signature">
              <div dir="ltr">On Fri, Jul 24, 2020 at 2:06 PM LIU Zhiwei
                &lt;<a href="mailto:zhiwei_liu@c-sky.com"
                  moz-do-not-send="true">zhiwei_liu@c-sky.com</a>&gt;
                wrote:<br>
              </div>
            </div>
          </div>
        </div>
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex"><br>
            <br>
            On 2020/7/24 11:55, Richard Henderson wrote:<br>
            &gt; On 7/23/20 7:35 PM, LIU Zhiwei wrote:<br>
            &gt;&gt;<br>
            &gt;&gt; On 2020/7/24 8:28, Richard Henderson wrote:<br>
            &gt;&gt;&gt; Make sure that all results from
            single-precision scalar helpers<br>
            &gt;&gt;&gt; are properly nan-boxed to 64-bits.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; Signed-off-by: Richard Henderson &lt;<a
              href="mailto:richard.henderson@linaro.org" target="_blank"
              moz-do-not-send="true">richard.henderson@linaro.org</a>&gt;<br>
            &gt;&gt;&gt; ---<br>
            &gt;&gt;&gt;    target/riscv/internals.h  |  5 +++++<br>
            &gt;&gt;&gt;    target/riscv/fpu_helper.c | 42
            +++++++++++++++++++++------------------<br>
            &gt;&gt;&gt;    2 files changed, 28 insertions(+), 19
            deletions(-)<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; diff --git a/target/riscv/internals.h
            b/target/riscv/internals.h<br>
            &gt;&gt;&gt; index 37d33820ad..9f4ba7d617 100644<br>
            &gt;&gt;&gt; --- a/target/riscv/internals.h<br>
            &gt;&gt;&gt; +++ b/target/riscv/internals.h<br>
            &gt;&gt;&gt; @@ -38,4 +38,9 @@ target_ulong
            fclass_d(uint64_t frs1);<br>
            &gt;&gt;&gt;    #define SEW32 2<br>
            &gt;&gt;&gt;    #define SEW64 3<br>
            &gt;&gt;&gt;    +static inline uint64_t nanbox_s(float32 f)<br>
            &gt;&gt;&gt; +{<br>
            &gt;&gt;&gt; +    return f | MAKE_64BIT_MASK(32, 32);<br>
            &gt;&gt;&gt; +}<br>
            &gt;&gt;&gt; +<br>
            &gt;&gt; If define it here,  we can also define a more
            general  function with flen.<br>
            &gt;&gt;<br>
            &gt;&gt; +static inline uint64_t nanbox_s(float32 f,
            uint32_t flen)<br>
            &gt;&gt; +{<br>
            &gt;&gt; +    return f | MAKE_64BIT_MASK(flen, 64 - flen);<br>
            &gt;&gt; +}<br>
            &gt;&gt; +<br>
            &gt;&gt;<br>
            &gt;&gt; So we can reuse it in fp16 or bf16 scalar
            instruction and in vector instructions.<br>
            &gt; While we could do that, we will not encounter all
            possible lengths.  In the<br>
            &gt; cover letter, I mentioned defining a second function,<br>
            &gt;<br>
            &gt; static inline uint64_t nanbox_h(float16 f)<br>
            &gt; {<br>
            &gt;     return f | MAKE_64BIT_MASK(16, 48);<br>
            &gt; }<br>
            &gt;<br>
            &gt; Having two separate functions will, I believe, be
            easier to use in practice.<br>
            &gt;<br>
            Get  it. Thanks.<br>
            <br>
            Zhiwei<br>
            &gt;<br>
            &gt; r~<br>
            <br>
            <br>
          </blockquote>
          <div><br>
          </div>
          <div>That is what has been implemented in spike.  It fills up
            the Nan-Box when value is stored back internal structure
            and </div>
          <div>unbox the value with difference floating type
            (half/single/double/quad).<br>
          </div>
        </div>
      </div>
    </blockquote>
    Hi Chih-Min,<br>
    <br>
    Has half-precision been a part of RVV? Or do you know the ISA
    abbreviation of half-precision?<br>
    <br>
    Thanks very much.<br>
    <br>
    Best Regards,<br>
    Zhiwei <br>
    <blockquote type="cite"
cite="mid:CAEiOBXXmz2APpmtwPrvikXUt5j_Q=k5ZqK9g2Fe4bdjeAbg_6g@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>By the way,  I prefer to keeping the suffix to tell
            different floating type rather than pass arbitrary </div>
          <div>since each floating type belong to each extension.<br>
            <br>
            Reviewed-by: Chih-Min Chao &lt;<a
              href="mailto:chihmin.chao@sifive.com"
              moz-do-not-send="true">chihmin.chao@sifive.com</a>&gt;<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------4A744EF9BA97243CD4F85E41--


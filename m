Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B56C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986F120675
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 15:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986F120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqILy-0004iJ-RZ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 11:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqIL9-0003kZ-2X; Tue, 30 Jun 2020 11:38:31 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jqIL5-0003EK-UO; Tue, 30 Jun 2020 11:38:30 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1418731|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0673276-0.00216099-0.930511;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03309; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=7; RT=7; SR=0; TI=SMTPD_---.HvHyjGP_1593531491; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HvHyjGP_1593531491)
 by smtp.aliyun-inc.com(10.147.40.233);
 Tue, 30 Jun 2020 23:38:11 +0800
Subject: Re: [PATCH 2/2] target/riscv: Do amo*.w insns operate with 32 bits
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200629130731.1080-1-zhiwei_liu@c-sky.com>
 <20200629130731.1080-3-zhiwei_liu@c-sky.com>
 <dcac30bb-4d01-48fa-ee48-0feed464b180@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <1f8bc9cb-0abd-e2c4-b605-087fb1b405dc@c-sky.com>
Date: Tue, 30 Jun 2020 23:38:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <dcac30bb-4d01-48fa-ee48-0feed464b180@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------58651BF83AACA4C6412A4E9A"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 11:23:01
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com,
 wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------58651BF83AACA4C6412A4E9A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/6/30 23:00, Richard Henderson wrote:
> On 6/29/20 6:07 AM, LIU Zhiwei wrote:
>> +static bool
>> +gen_amo_w(DisasContext *ctx, arg_atomic *a,
>> +          void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
>> +          MemOp mop, bool sign)
>>   {
>>       TCGv src1 = tcg_temp_new();
>>       TCGv src2 = tcg_temp_new();
>>   
>>       gen_get_gpr(src1, a->rs1);
>>       gen_get_gpr(src2, a->rs2);
>> +    if (sign) {
>> +        tcg_gen_ext32s_tl(src2, src2);
>> +    } else {
>> +        tcg_gen_ext32u_tl(src2, src2);
>> +    }
>>   
>>       (*func)(src2, src1, src2, ctx->mem_idx, mop);
>> -
>> +    tcg_gen_ext32s_tl(src2, src2);
>>       gen_set_gpr(a->rd, src2);
>> +
>>       tcg_temp_free(src1);
>>       tcg_temp_free(src2);
>>       return true;
> With the fix to tcg, there should be no change required here, since you're
> already passing MO_TESL for signed input.
>
> Note that unsigned comparisions work as expected with sign-extended inputs.
> That's what the risc-v isa does, after all.
>
Although some confusing,  it is right for unsigned comparisons. Thus the 
amominu.w will still
be calculated by

gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl,/(MO_ALIGN |//MO_TESL//)/);

In this way, the only fix is in tcg and this patch will be dropped.

Zhiwei

> r~


--------------58651BF83AACA4C6412A4E9A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/6/30 23:00, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:dcac30bb-4d01-48fa-ee48-0feed464b180@linaro.org">
      <pre class="moz-quote-pre" wrap="">On 6/29/20 6:07 AM, LIU Zhiwei wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+static bool
+gen_amo_w(DisasContext *ctx, arg_atomic *a,
+          void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
+          MemOp mop, bool sign)
 {
     TCGv src1 = tcg_temp_new();
     TCGv src2 = tcg_temp_new();
 
     gen_get_gpr(src1, a-&gt;rs1);
     gen_get_gpr(src2, a-&gt;rs2);
+    if (sign) {
+        tcg_gen_ext32s_tl(src2, src2);
+    } else {
+        tcg_gen_ext32u_tl(src2, src2);
+    }
 
     (*func)(src2, src1, src2, ctx-&gt;mem_idx, mop);
-
+    tcg_gen_ext32s_tl(src2, src2);
     gen_set_gpr(a-&gt;rd, src2);
+
     tcg_temp_free(src1);
     tcg_temp_free(src2);
     return true;
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
With the fix to tcg, there should be no change required here, since you're
already passing MO_TESL for signed input.

Note that unsigned comparisions work as expected with sign-extended inputs.
That's what the risc-v isa does, after all.

</pre>
    </blockquote>
    Although some confusing,  it is right for unsigned comparisons. Thus
    the amominu.w will still<br>
    be calculated by<br>
    <pre>gen_amo(ctx, a, &amp;tcg_gen_atomic_fetch_umin_tl, <i>(MO_ALIGN |</i><i> MO_TESL</i><i>)</i>);

</pre>
    <p>In this way, the only fix is in tcg and this patch will be
      dropped.</p>
    <p>Zhiwei</p>
    <blockquote type="cite"
      cite="mid:dcac30bb-4d01-48fa-ee48-0feed464b180@linaro.org">
      <pre class="moz-quote-pre" wrap="">
r~
</pre>
    </blockquote>
    <blockquote type="cite"
      cite="mid:dcac30bb-4d01-48fa-ee48-0feed464b180@linaro.org">
    </blockquote>
    <br>
  </body>
</html>

--------------58651BF83AACA4C6412A4E9A--


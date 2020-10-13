Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06727C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 02:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE1E208FE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 02:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE1E208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSA8y-0004S1-S9
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 22:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kSA80-00041d-KR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 22:33:28 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kSA7x-000267-AO
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 22:33:28 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08248018|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.00223872-0.000249513-0.997512;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047199; MF=zhiwei_liu@c-sky.com; NM=1;
 PH=DS; RN=4; RT=4; SR=0; TI=SMTPD_---.IiOpxD5_1602556392; 
Received: from 30.225.208.85(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.IiOpxD5_1602556392)
 by smtp.aliyun-inc.com(10.147.44.118);
 Tue, 13 Oct 2020 10:33:14 +0800
Subject: Re: [PATCH v3 34/81] target/arm: Implement SVE2 WHILERW, WHILEWR
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
 <20200918183751.2787647-35-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <29cce0a5-11f1-b433-021f-12b2e5ada005@c-sky.com>
Date: Tue, 13 Oct 2020 10:33:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918183751.2787647-35-richard.henderson@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------5E405CD05CF4A1CA4EFAEDAA"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 22:33:14
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------5E405CD05CF4A1CA4EFAEDAA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/9/19 2:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Fix decodetree typo
> ---
>   target/arm/sve.decode      |  3 ++
>   target/arm/translate-sve.c | 62 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 65 insertions(+)
>
> diff --git a/target/arm/sve.decode b/target/arm/sve.decode
> index b7038f9f57..19d503e2f4 100644
> --- a/target/arm/sve.decode
> +++ b/target/arm/sve.decode
> @@ -702,6 +702,9 @@ CTERM           00100101 1 sf:1 1 rm:5 001000 rn:5 ne:1 0000
>   # SVE integer compare scalar count and limit
>   WHILE           00100101 esz:2 1 rm:5 000 sf:1 u:1 lt:1 rn:5 eq:1 rd:4
>   
> +# SVE2 pointer conflict compare
> +WHILE_ptr       00100101 esz:2 1 rm:5 001 100 rn:5 rw:1 rd:4
> +
>   ### SVE Integer Wide Immediate - Unpredicated Group
>   
>   # SVE broadcast floating-point immediate (unpredicated)
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index f1bc4c63e6..d3241ce167 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -3227,6 +3227,68 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
>       return true;
>   }
>   
> +static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
> +{
> +    TCGv_i64 op0, op1, diff, t1, tmax;
> +    TCGv_i32 t2, t3;
> +    TCGv_ptr ptr;
> +    unsigned desc, vsz = vec_full_reg_size(s);
> +
> +    if (!dc_isar_feature(aa64_sve2, s)) {
> +        return false;
> +    }
> +    if (!sve_access_check(s)) {
> +        return true;
> +    }
> +
> +    op0 = read_cpu_reg(s, a->rn, 1);
> +    op1 = read_cpu_reg(s, a->rm, 1);
> +
> +    tmax = tcg_const_i64(vsz);
> +    diff = tcg_temp_new_i64();
> +
> +    if (a->rw) {
> +        /* WHILERW */
> +        /* diff = abs(op1 - op0), noting that op0/1 are unsigned. */
> +        t1 = tcg_temp_new_i64();
> +        tcg_gen_sub_i64(diff, op0, op1);
> +        tcg_gen_sub_i64(t1, op1, op0);
> +        tcg_gen_movcond_i64(TCG_COND_LTU, diff, op0, op1, diff, t1);
It should be:

tcg_gen_movcond_i64(TCG_COND_GTU, diff, op0, op1, diff, t1);

> +        tcg_temp_free_i64(t1);
> +        /* If op1 == op0, diff == 0, and the condition is always true. */
> +        tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
> +    } else {
> +        /* WHILEWR */
> +        tcg_gen_sub_i64(diff, op1, op0);
> +        /* If op0 >= op1, diff <= 0, the condition is always true. */
> +        tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
> +    }
> +
> +    /* Bound to the maximum.  */
> +    tcg_gen_umin_i64(diff, diff, tmax);
> +    tcg_temp_free_i64(tmax);
> +
> +    /* Since we're bounded, pass as a 32-bit type.  */
> +    t2 = tcg_temp_new_i32();
> +    tcg_gen_extrl_i64_i32(t2, diff);
We should align count down to (1 << esz),

tcg_gen_andi_i32(t2，~MAKE_64BIT_MASK(0, esz));

Best Regards,
Zhiwei
> +    tcg_temp_free_i64(diff);
> +
> +    desc = (vsz / 8) - 2;
> +    desc = deposit32(desc, SIMD_DATA_SHIFT, 2, a->esz);
> +    t3 = tcg_const_i32(desc);
> +
> +    ptr = tcg_temp_new_ptr();
> +    tcg_gen_addi_ptr(ptr, cpu_env, pred_full_reg_offset(s, a->rd));
> +
> +    gen_helper_sve_whilel(t2, ptr, t2, t3);
> +    do_pred_flags(t2);
> +
> +    tcg_temp_free_ptr(ptr);
> +    tcg_temp_free_i32(t2);
> +    tcg_temp_free_i32(t3);
> +    return true;
> +}
> +
>   /*
>    *** SVE Integer Wide Immediate - Unpredicated Group
>    */


--------------5E405CD05CF4A1CA4EFAEDAA
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/9/19 2:37, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20200918183751.2787647-35-richard.henderson@linaro.org">
      <pre class="moz-quote-pre" wrap="">Signed-off-by: Richard Henderson <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a>
---
v2: Fix decodetree typo
---
 target/arm/sve.decode      |  3 ++
 target/arm/translate-sve.c | 62 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index b7038f9f57..19d503e2f4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -702,6 +702,9 @@ CTERM           00100101 1 sf:1 1 rm:5 001000 rn:5 ne:1 0000
 # SVE integer compare scalar count and limit
 WHILE           00100101 esz:2 1 rm:5 000 sf:1 u:1 lt:1 rn:5 eq:1 rd:4
 
+# SVE2 pointer conflict compare
+WHILE_ptr       00100101 esz:2 1 rm:5 001 100 rn:5 rw:1 rd:4
+
 ### SVE Integer Wide Immediate - Unpredicated Group
 
 # SVE broadcast floating-point immediate (unpredicated)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f1bc4c63e6..d3241ce167 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3227,6 +3227,68 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     return true;
 }
 
+static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
+{
+    TCGv_i64 op0, op1, diff, t1, tmax;
+    TCGv_i32 t2, t3;
+    TCGv_ptr ptr;
+    unsigned desc, vsz = vec_full_reg_size(s);
+
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    op0 = read_cpu_reg(s, a-&gt;rn, 1);
+    op1 = read_cpu_reg(s, a-&gt;rm, 1);
+
+    tmax = tcg_const_i64(vsz);
+    diff = tcg_temp_new_i64();
+
+    if (a-&gt;rw) {
+        /* WHILERW */
+        /* diff = abs(op1 - op0), noting that op0/1 are unsigned. */
+        t1 = tcg_temp_new_i64();
+        tcg_gen_sub_i64(diff, op0, op1);
+        tcg_gen_sub_i64(t1, op1, op0);
+        tcg_gen_movcond_i64(TCG_COND_LTU, diff, op0, op1, diff, t1);</pre>
    </blockquote>
    It should be:<br>
    <pre>tcg_gen_movcond_i64(TCG_COND_GTU, diff, op0, op1, diff, t1);</pre>
    <blockquote type="cite"
      cite="mid:20200918183751.2787647-35-richard.henderson@linaro.org">
      <pre class="moz-quote-pre" wrap="">
+        tcg_temp_free_i64(t1);
+        /* If op1 == op0, diff == 0, and the condition is always true. */
+        tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
+    } else {
+        /* WHILEWR */
+        tcg_gen_sub_i64(diff, op1, op0);
+        /* If op0 &gt;= op1, diff &lt;= 0, the condition is always true. */
+        tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
+    }
+
+    /* Bound to the maximum.  */
+    tcg_gen_umin_i64(diff, diff, tmax);
+    tcg_temp_free_i64(tmax);
+
+    /* Since we're bounded, pass as a 32-bit type.  */
+    t2 = tcg_temp_new_i32();
+    tcg_gen_extrl_i64_i32(t2, diff);</pre>
    </blockquote>
    We should align count down to (1 &lt;&lt; esz), <br>
    <pre>tcg_gen_andi_i32(t2，~MAKE_64BIT_MASK(0, esz));

</pre>
    Best Regards,<br>
    Zhiwei<br>
    <blockquote type="cite"
      cite="mid:20200918183751.2787647-35-richard.henderson@linaro.org">
      <pre class="moz-quote-pre" wrap="">
+    tcg_temp_free_i64(diff);
+
+    desc = (vsz / 8) - 2;
+    desc = deposit32(desc, SIMD_DATA_SHIFT, 2, a-&gt;esz);
+    t3 = tcg_const_i32(desc);
+
+    ptr = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(ptr, cpu_env, pred_full_reg_offset(s, a-&gt;rd));
+
+    gen_helper_sve_whilel(t2, ptr, t2, t3);</pre>
    </blockquote>
    <blockquote type="cite"
      cite="mid:20200918183751.2787647-35-richard.henderson@linaro.org">
      <pre class="moz-quote-pre" wrap="">
+    do_pred_flags(t2);
+
+    tcg_temp_free_ptr(ptr);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t3);
+    return true;
+}
+
 /*
  *** SVE Integer Wide Immediate - Unpredicated Group
  */
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------5E405CD05CF4A1CA4EFAEDAA--


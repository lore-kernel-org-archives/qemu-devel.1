Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86EDC433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4FF207DA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4FF207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2Ql-00076G-Nr
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kC2QE-0006eg-Bn
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:05:38 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kC2Q7-0003ci-1c
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 11:05:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06561751|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0702077-0.000130234-0.929662;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03306; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=2; RT=2; SR=0; TI=SMTPD_---.IPmSxL4_1598713511; 
Received: from 192.168.3.36(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.IPmSxL4_1598713511) by smtp.aliyun-inc.com(10.147.40.7);
 Sat, 29 Aug 2020 23:05:11 +0800
Subject: Re: [PATCH] softfloat: Define comparison operations for bfloat16
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200828175351.435119-1-richard.henderson@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <595aa258-dc1c-2c21-7081-41cfccb449a3@c-sky.com>
Date: Sat, 29 Aug 2020 23:05:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200828175351.435119-1-richard.henderson@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------75460598582B99A98EF02006"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/29 11:05:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.809, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------75460598582B99A98EF02006
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/8/29 1:53, Richard Henderson wrote:
> These operations were missed in Zhiwei's bfloat16 implementation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat.h | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
>
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 1233f98014..78ad5ca738 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -479,6 +479,47 @@ static inline bfloat16 bfloat16_set_sign(bfloat16 a, int sign)
>       return (a & 0x7fff) | (sign << 15);
>   }
>   
> +static inline bool bfloat16_eq(bfloat16 a, bfloat16 b, float_status *s)
> +{
> +    return bfloat16_compare(a, b, s) == float_relation_equal;
> +}
> +
> +static inline bool bfloat16_le(bfloat16 a, bfloat16 b, float_status *s)
> +{
> +    return bfloat16_compare(a, b, s) <= float_relation_equal;
> +}
> +
> +static inline bool bfloat16_lt(bfloat16 a, bfloat16 b, float_status *s)
> +{
> +    return bfloat16_compare(a, b, s) < float_relation_equal;
> +}
> +
> +static inline bool bfloat16_unordered(bfloat16 a, bfloat16 b, float_status *s)
> +{
> +    return bfloat16_compare(a, b, s) == float_relation_unordered;
> +}
> +
> +static inline bool bfloat16_eq_quiet(bfloat16 a, bfloat16 b, float_status *s)
> +{
> +    return bfloat16_compare_quiet(a, b, s) == float_relation_equal;
> +}
> +
> +static inline bool bfloat16_le_quiet(bfloat16 a, bfloat16 b, float_status *s)
> +{
> +    return bfloat16_compare_quiet(a, b, s) <= float_relation_equal;
> +}
> +
> +static inline bool bfloat16_lt_quiet(bfloat16 a, bfloat16 b, float_status *s)
> +{
> +    return bfloat16_compare_quiet(a, b, s) < float_relation_equal;
> +}
> +
> +static inline bool bfloat16_unordered_quiet(bfloat16 a, bfloat16 b,
> +                                           float_status *s)
Indentation.
> +{
> +    return bfloat16_compare_quiet(a, b, s) == float_relation_unordered;
> +}
> +
Hi Richard,

If you have already applied the bfloat16 patch set,   I am afraid you 
have to remove these lines.

-int bfloat16_unordered_quiet(bfloat16, bfloat16, float_status *status);
-int bfloat16_le(bfloat16, bfloat16, float_status *status);
-int bfloat16_lt(bfloat16, bfloat16, float_status *status);
-int bfloat16_eq_quiet(bfloat16, bfloat16, float_status *status);

The corresponding float16 interfaces have been removed in the master 
branch when I sent the bfloat16 patch set.
So I deleted the implementations. But I forgot to remove the declarations.

I see you have applied float16 comparison interfaces from Kito, and the 
corresponding bfloat16
interfaces have all been defined here. After remove the redundant 
declarations,

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>

>   #define bfloat16_zero 0
>   #define bfloat16_half 0x3f00
>   #define bfloat16_one 0x3f80


--------------75460598582B99A98EF02006
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/8/29 1:53, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20200828175351.435119-1-richard.henderson@linaro.org">
      <pre class="moz-quote-pre" wrap="">These operations were missed in Zhiwei's bfloat16 implementation.

Signed-off-by: Richard Henderson <a class="moz-txt-link-rfc2396E" href="mailto:richard.henderson@linaro.org">&lt;richard.henderson@linaro.org&gt;</a>
---
 include/fpu/softfloat.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 1233f98014..78ad5ca738 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -479,6 +479,47 @@ static inline bfloat16 bfloat16_set_sign(bfloat16 a, int sign)
     return (a &amp; 0x7fff) | (sign &lt;&lt; 15);
 }
 
+static inline bool bfloat16_eq(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) == float_relation_equal;
+}
+
+static inline bool bfloat16_le(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) &lt;= float_relation_equal;
+}
+
+static inline bool bfloat16_lt(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) &lt; float_relation_equal;
+}
+
+static inline bool bfloat16_unordered(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) == float_relation_unordered;
+}
+
+static inline bool bfloat16_eq_quiet(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare_quiet(a, b, s) == float_relation_equal;
+}
+
+static inline bool bfloat16_le_quiet(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare_quiet(a, b, s) &lt;= float_relation_equal;
+}
+
+static inline bool bfloat16_lt_quiet(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare_quiet(a, b, s) &lt; float_relation_equal;
+}
+
+static inline bool bfloat16_unordered_quiet(bfloat16 a, bfloat16 b,
+                                           float_status *s)</pre>
    </blockquote>
    Indentation.<br>
    <blockquote type="cite"
      cite="mid:20200828175351.435119-1-richard.henderson@linaro.org">
      <pre class="moz-quote-pre" wrap="">
+{
+    return bfloat16_compare_quiet(a, b, s) == float_relation_unordered;
+}
+</pre>
    </blockquote>
    Hi Richard,<br>
    <br>
    If you have already applied the bfloat16 patch set,   I am afraid
    you have to remove these lines.<br>
    <pre>-int bfloat16_unordered_quiet(bfloat16, bfloat16, float_status *status);
-int bfloat16_le(bfloat16, bfloat16, float_status *status);
-int bfloat16_lt(bfloat16, bfloat16, float_status *status);
-int bfloat16_eq_quiet(bfloat16, bfloat16, float_status *status);

</pre>
    The corresponding float16 interfaces have been removed in the master
    branch when I sent the bfloat16 patch set.<br>
    So I deleted the implementations. But I forgot to remove the
    declarations.<br>
    <br>
    I see you have applied float16 comparison interfaces from Kito, and
    the corresponding bfloat16<br>
    interfaces have all been defined here. After remove the redundant
    declarations,<br>
    <br>
    Reviewed-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@c-sky.com">&lt;zhiwei_liu@c-sky.com&gt;</a><br>
    <br>
    <blockquote type="cite"
      cite="mid:20200828175351.435119-1-richard.henderson@linaro.org">
      <pre class="moz-quote-pre" wrap="">
 #define bfloat16_zero 0
 #define bfloat16_half 0x3f00
 #define bfloat16_one 0x3f80
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------75460598582B99A98EF02006--


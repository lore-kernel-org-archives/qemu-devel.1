Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BBDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9084320674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9084320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4sf-0005U3-TJ
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jv4rz-0004m9-GU
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:16:11 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jv4rv-0008Rz-Ku
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:16:11 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09523118|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.289673-0.00181386-0.708513;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07447; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.I1F2QrG_1594671357; 
Received: from 192.168.3.36(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I1F2QrG_1594671357)
 by smtp.aliyun-inc.com(10.147.40.26); Tue, 14 Jul 2020 04:15:59 +0800
Subject: Re: [RFC PATCH 2/8] fpu/softfloat: use the similiar logic to
 recognize sNaN and qNaN
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
 <20200712234521.3972-3-zhiwei_liu@c-sky.com>
 <9a213775-58f4-a4d3-a61e-469d0f33913d@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <c0855a9a-2137-4d5e-424e-7d13fa348946@c-sky.com>
Date: Tue, 14 Jul 2020 04:15:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9a213775-58f4-a4d3-a61e-469d0f33913d@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------2171984D8789A62D2E4C35BD"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 16:16:00
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
Cc: wenmeng_zhang@c-sky.com, alex.bennee@linaro.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------2171984D8789A62D2E4C35BD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/7/14 3:17, Richard Henderson wrote:
> On 7/12/20 4:45 PM, LIU Zhiwei wrote:
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>>   fpu/softfloat-specialize.inc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
>> index 034d18199c..6b778a7830 100644
>> --- a/fpu/softfloat-specialize.inc.c
>> +++ b/fpu/softfloat-specialize.inc.c
>> @@ -292,7 +292,7 @@ bool float32_is_quiet_nan(float32 a_, float_status *status)
>>       if (snan_bit_is_one(status)) {
>>           return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
>>       } else {
>> -        return ((uint32_t)(a << 1) >= 0xFF800000);
>> +        return ((a >> 22) & 0x1FF) == 0x1FF;
>>       }
>>   #endif
>>   }
> I don't see a reason for this.  The previous was a bug, but this isn't.
It's not a bug,  just a clean up.

As you can see, we have already recognized a quiet nan by

  if (snan_bit_is_one(status)) {
          return (((a >> 22) & 0x1FF) == 0x1FE) && (a & 0x003FFFFF);
  }

We need not to give another method to recognize it again.

Zhiwei
>
> r~


--------------2171984D8789A62D2E4C35BD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/7/14 3:17, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:9a213775-58f4-a4d3-a61e-469d0f33913d@linaro.org">
      <pre class="moz-quote-pre" wrap="">On 7/12/20 4:45 PM, LIU Zhiwei wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@c-sky.com">&lt;zhiwei_liu@c-sky.com&gt;</a>
---
 fpu/softfloat-specialize.inc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
index 034d18199c..6b778a7830 100644
--- a/fpu/softfloat-specialize.inc.c
+++ b/fpu/softfloat-specialize.inc.c
@@ -292,7 +292,7 @@ bool float32_is_quiet_nan(float32 a_, float_status *status)
     if (snan_bit_is_one(status)) {
         return (((a &gt;&gt; 22) &amp; 0x1FF) == 0x1FE) &amp;&amp; (a &amp; 0x003FFFFF);
     } else {
-        return ((uint32_t)(a &lt;&lt; 1) &gt;= 0xFF800000);
+        return ((a &gt;&gt; 22) &amp; 0x1FF) == 0x1FF;
     }
 #endif
 }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I don't see a reason for this.  The previous was a bug, but this isn't.
</pre>
    </blockquote>
    It's not a bug,  just a clean up.   <br>
    <br>
    As you can see, we have already recognized a quiet nan by <br>
    <pre> if (snan_bit_is_one(status)) {
         return (((a &gt;&gt; 22) &amp; 0x1FF) == 0x1FE) &amp;&amp; (a &amp; 0x003FFFFF);
 }

</pre>
    We need not to give another method to recognize it again.<br>
    <br>
    Zhiwei<br>
    <blockquote type="cite"
      cite="mid:9a213775-58f4-a4d3-a61e-469d0f33913d@linaro.org">
      <pre class="moz-quote-pre" wrap="">

r~
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------2171984D8789A62D2E4C35BD--


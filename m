Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D343BC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 01:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72B36206F6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 01:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72B36206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHzxk-0002EQ-IU
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 21:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jHzwq-0001aH-Vt
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 21:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jHzwo-0005Bz-BQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 21:07:39 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:52507)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jHzwn-0004wt-UZ; Fri, 27 Mar 2020 21:07:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.09653191|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.317416-0.000351267-0.682232;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03293; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H6R90oC_1585357647; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H6R90oC_1585357647)
 by smtp.aliyun-inc.com(10.147.41.187);
 Sat, 28 Mar 2020 09:07:28 +0800
Subject: Re: [PATCH v6 25/61] target/riscv: vector single-width averaging add
 and subtract
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200317150653.9008-1-zhiwei_liu@c-sky.com>
 <20200317150653.9008-26-zhiwei_liu@c-sky.com>
 <0cdf21fd-b1f1-36bf-f156-5a673199fa1f@c-sky.com>
 <5c2f0b77-32fa-76bd-0b0e-4ca91d87f3b6@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <f50a4a63-c5cf-4322-9663-98fb15dde715@c-sky.com>
Date: Sat, 28 Mar 2020 09:07:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5c2f0b77-32fa-76bd-0b0e-4ca91d87f3b6@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------5A83C80D56DB97055FCF7B27"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------5A83C80D56DB97055FCF7B27
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/3/28 8:32, Richard Henderson wrote:
> On 3/18/20 8:46 PM, LIU Zhiwei wrote:
>> +static inline int32_t asub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
>> +{
>> +    int64_t res = (int64_t)a - b;
>> +    uint8_t round = get_round(vxrm, res, 1);
>> +
>> +    return (res >> 1) + round;
>> +}
>> +
>>
>> I find a corner case here.  As the spec said in Section 13.2
>>
>>    "There can be no overflow in the result".
>>
>> If the a is 0x7fffffff,  b is 0x80000000, and the round mode is round to up(rnu),
>> then the result is (0x7fffffff - 0x80000000 + 1) >> 1, equals 0x80000000,
>> according the v0.7.1
> That's why we used int64_t as the intermediate type:
>
>    0x000000007fffffff - 0xffffffff80000000 + 1
> = 0x000000007fffffff + 0x0000000080000000 + 1
> = 0x00000000ffffffff + 1
> = 0x0000000100000000
>
> Shift that right by 1 and you do indeed get 0x80000000.
> There's no saturation involved.

The minuend 0x7fffffff is INT32_MAX, and the subtrahend 0x80000000 is 
INT32_MIN.

The difference between the minuendand the subtrahend should be a 
positive number. But the result here is 0x80000000.

So it is overflow.  However, according to the spec, it should not overflow.

I think a special process for (INT*_MAX -  INT*_MIN)  is needed.

Zhiwei

> For int64_t we computed signed overflow to do the same thing.
>
> r~


--------------5A83C80D56DB97055FCF7B27
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/3/28 8:32, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:5c2f0b77-32fa-76bd-0b0e-4ca91d87f3b6@linaro.org">
      <pre class="moz-quote-pre" wrap="">On 3/18/20 8:46 PM, LIU Zhiwei wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">+static inline int32_t asub32(CPURISCVState *env, int vxrm, int32_t a, int32_t b)
+{
+    int64_t res = (int64_t)a - b;
+    uint8_t round = get_round(vxrm, res, 1);
+
+    return (res &gt;&gt; 1) + round;
+}
+

I find a corner case here.  As the spec said in Section 13.2

  "There can be no overflow in the result".

If the a is 0x7fffffff,  b is 0x80000000, and the round mode is round to up(rnu),
then the result is (0x7fffffff - 0x80000000 + 1) &gt;&gt; 1, equals 0x80000000,
according the v0.7.1
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
That's why we used int64_t as the intermediate type:

  0x000000007fffffff - 0xffffffff80000000 + 1
= 0x000000007fffffff + 0x0000000080000000 + 1
= 0x00000000ffffffff + 1
= 0x0000000100000000

Shift that right by 1 and you do indeed get 0x80000000.
There's no saturation involved.
</pre>
    </blockquote>
    <br>
    The minuend 0x7fffffff is INT32_MAX, and the subtrahend 0x80000000
    is INT32_MIN. <span style="color: rgb(51, 51, 51); font-family:
      arial; font-size: 18px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
      0px; background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"><br>
      <br>
      The difference between the </span><span style="color: rgb(51, 51,
      51); font-family: arial; font-size: 18px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
      0px; background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"><span style="color: rgb(51, 51, 51);
        font-family: &quot;PingFang SC&quot;, &quot;Lantinghei SC&quot;,
        &quot;Microsoft YaHei&quot;, arial, 宋体, sans-serif, tahoma;
        font-size: 16px; font-style: normal; font-variant-ligatures:
        normal; font-variant-caps: normal; font-weight: 400;
        letter-spacing: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">minuend<span> </span></span> and </span><span
      style="color: rgb(51, 51, 51); font-family: arial; font-size:
      18px; font-style: normal; font-variant-ligatures: normal;
      font-variant-caps: normal; font-weight: 400; letter-spacing:
      normal; orphans: 2; text-align: start; text-indent: 0px;
      text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-style:
      initial; text-decoration-color: initial; display: inline
      !important; float: none;"><span style="color: rgb(51, 51, 51);
        font-family: &quot;PingFang SC&quot;, &quot;Lantinghei SC&quot;,
        &quot;Microsoft YaHei&quot;, arial, 宋体, sans-serif, tahoma;
        font-size: 16px; font-style: normal; font-variant-ligatures:
        normal; font-variant-caps: normal; font-weight: 400;
        letter-spacing: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">the subtrahend should be a positive
        number. But the result here is 0x80000000.<br>
        <br>
        So it is overflow.  However, according to the spec, it should
        not overflow.<br>
        <br>
        I think a special process for (INT*_MAX -  INT*_MIN)  is needed.
        <br>
        <br>
        Zhiwei<br>
        <br>
      </span></span>
    <blockquote type="cite"
      cite="mid:5c2f0b77-32fa-76bd-0b0e-4ca91d87f3b6@linaro.org">
      <pre class="moz-quote-pre" wrap="">
For int64_t we computed signed overflow to do the same thing.
</pre>
    </blockquote>
    <blockquote type="cite"
      cite="mid:5c2f0b77-32fa-76bd-0b0e-4ca91d87f3b6@linaro.org">
      <pre class="moz-quote-pre" wrap="">

r~
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------5A83C80D56DB97055FCF7B27--


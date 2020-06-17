Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B8F206D8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B8F206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSDK-0005HY-O6
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jlSCd-0004qb-3w
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:09:43 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jlSCZ-00007u-Sv
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 03:09:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1074027|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_news_journal|0.0370519-0.000419114-0.962529;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07447; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---.HnyaGjT_1592377766; 
Received: from 30.225.208.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HnyaGjT_1592377766) by smtp.aliyun-inc.com(10.147.40.7);
 Wed, 17 Jun 2020 15:09:26 +0800
Subject: Re: fpu/softfloat: a question on BFloat 16 support on QEMU
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <ea06c0c3-465e-34a5-5427-41ae6bf583dc@c-sky.com>
 <87img15zfv.fsf@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <29d37daf-ced3-8555-7d25-00baacbb4449@c-sky.com>
Date: Wed, 17 Jun 2020 15:09:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87img15zfv.fsf@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------D5E18534FF4669470FEAD224"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 03:09:28
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------D5E18534FF4669470FEAD224
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/6/8 23:50, Alex Bennée wrote:
> LIU Zhiwei <zhiwei_liu@c-sky.com> writes:
>
>> Hi Richard,
>>
>> I am doing bfloat16 support on QEMU.
>>
>> Once I tried to reuse float32 interface, but I couldn't properly process
>> rounding in some insns like fadd.
> What do you mean by re-use the float32 interface? Isn't bfloat16 going
> to be pretty much the same as float16 but with some slightly different
> float parameters for the different encoding?
>
> Like the float16 code it won't have to deal with any of the hardfloat
> wrappers so it should look pretty similar.
>
>> What's your opinion about it? Should I expand the fpu/softfloat?
> bfloat16 is certainly going to become more common that we should have
> common softfloat code to handle it. It would be nice is TestFloat could
> exercise it as well.
Hi Alex,

I have add the bfloat16 interfaces in QEMU softfloat.  Now I moved 
forward to test the bfloat16 interfaces.

When I looked into the fp-test.c and the berkeley-testfloat-3, I found 
it's some difficult to add bfloat16 interfaces test cases.

There are no corresponding bfloat16 slow_X interlaces in slowfloat.c. 
Nor there is bfloat16 test_X interfaces in berkeley-testfloat-3.

case F16_MULADD:

  test_abcz_f16(slow_f16_mulAdd, qemu_f16_mulAdd);

  break;


If I want to test bfloat16 interfaces, could you give some advice? 
Should I need to modify berkeley-testfloat-3 to support the bfloat16 test.

Best Regards,
Zhiwei

>> Best Regards,
>> Zhiwei
>


--------------D5E18534FF4669470FEAD224
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/6/8 23:50, Alex Bennée wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87img15zfv.fsf@linaro.org">
      <pre class="moz-quote-pre" wrap="">
LIU Zhiwei <a class="moz-txt-link-rfc2396E" href="mailto:zhiwei_liu@c-sky.com">&lt;zhiwei_liu@c-sky.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Hi Richard,

I am doing bfloat16 support on QEMU.

Once I tried to reuse float32 interface, but I couldn't properly process 
rounding in some insns like fadd.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
What do you mean by re-use the float32 interface? Isn't bfloat16 going
to be pretty much the same as float16 but with some slightly different
float parameters for the different encoding?

Like the float16 code it won't have to deal with any of the hardfloat
wrappers so it should look pretty similar.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
What's your opinion about it? Should I expand the fpu/softfloat?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
bfloat16 is certainly going to become more common that we should have
common softfloat code to handle it. It would be nice is TestFloat could
exercise it as well.
</pre>
    </blockquote>
    Hi Alex,<br>
    <br>
    I have add the bfloat16 interfaces in QEMU softfloat.  Now I moved
    forward to test the bfloat16 interfaces.<br>
    <br>
    When I looked into the fp-test.c and the berkeley-testfloat-3, I
    found it's some difficult to add bfloat16 interfaces test cases.<br>
    <br>
    There are no corresponding bfloat16 slow_X interlaces in
    slowfloat.c. Nor there is bfloat16 test_X interfaces in
    berkeley-testfloat-3.<br>
     <br>
    <pre>case F16_MULADD:</pre>
    <pre> test_abcz_f16(slow_f16_mulAdd, qemu_f16_mulAdd);</pre>
    <pre> break;</pre>
    <br>
    If I want to test bfloat16 interfaces, could you give some advice?
    Should I need to modify berkeley-testfloat-3 to support the bfloat16
    test.<br>
    <br>
    Best Regards, <br>
    Zhiwei<br>
    <br>
    <blockquote type="cite" cite="mid:87img15zfv.fsf@linaro.org">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Best Regards,
Zhiwei
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------D5E18534FF4669470FEAD224--


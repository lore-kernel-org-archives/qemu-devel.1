Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDA5C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:33:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03786208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03786208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLG8E-0006RN-3k
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 21:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kLG5D-0003gl-DA
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:30:03 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:46040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1kLG59-0006H4-D5
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:30:03 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1384951|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_enroll_verification|0.0138665-0.00101466-0.985119;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03300; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=4; RT=4; SR=0; TI=SMTPD_---.IbPUWyb_1600910991; 
Received: from 30.225.208.89(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.IbPUWyb_1600910991)
 by smtp.aliyun-inc.com(10.147.42.241);
 Thu, 24 Sep 2020 09:29:52 +0800
Subject: Re: [PATCH v3 51/81] target/arm: Pass separate addend to {U, S}DOT
 helpers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
 <20200918183751.2787647-52-richard.henderson@linaro.org>
 <a0ad74b1-8445-710a-3d87-0310011e9163@c-sky.com>
 <300c780c-0167-0a87-58b9-2fff8ab91190@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <f8108b5d-1ba2-0616-6a37-344abebe3741@c-sky.com>
Date: Thu, 24 Sep 2020 09:29:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <300c780c-0167-0a87-58b9-2fff8ab91190@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------0D8B22ED35641CFA4D1203D0"
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 21:29:53
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
--------------0D8B22ED35641CFA4D1203D0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2020/9/23 22:46, Richard Henderson wrote:
> On 9/23/20 3:01 AM, LIU Zhiwei wrote:
>>
>> On 2020/9/19 2:37, Richard Henderson wrote:
>>> For SVE, we potentially have a 4th argument coming from the
>>> movprfx instruction.  Currently we do not optimize movprfx,
>>> so the problem is not visible.
>> Hi Richard,
>>
>> I am a little confused.  If it is not immediately preceded by a MOVPRFX
>> instruction, the addend will
>> still be used.
>>
>> Is it right?
> If movprfx is not used, then the addend register will be the same as the
> destination register.
Get it.

Could you see again the definition of HELPER(gvec_udot_idx_h) or the 
HELPER(gvec_sdot_idx_h)?

I think it is wrong there, it code sequence is like this:

d0 = a[i+0]
//dot calculation
d[i+0] += d0

Because when addend is the destination register, it has no reason to add 
destination register twice.

Best Regards,
Zhiwei
>
> r~


--------------0D8B22ED35641CFA4D1203D0
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">On 2020/9/23 22:46, Richard Henderson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:300c780c-0167-0a87-58b9-2fff8ab91190@linaro.org">
      <pre class="moz-quote-pre" wrap="">On 9/23/20 3:01 AM, LIU Zhiwei wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">

On 2020/9/19 2:37, Richard Henderson wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">For SVE, we potentially have a 4th argument coming from the
movprfx instruction.  Currently we do not optimize movprfx,
so the problem is not visible.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Hi Richard,

I am a little confused.  If it is not immediately preceded by a MOVPRFX
instruction, the addend will
still be used.

Is it right?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
If movprfx is not used, then the addend register will be the same as the
destination register.</pre>
    </blockquote>
    Get it.<br>
    <br>
    Could you see again the definition of HELPER(gvec_udot_idx_h) or the
    HELPER(gvec_sdot_idx_h)?<br>
    <br>
    I think it is wrong there, it code sequence is like this:<br>
    <pre>d0 = a[i+0]
//dot calculation
d[i+0] += d0</pre>
    Because when addend is the destination register, it has no reason to
    add destination register twice.<br>
    <br>
    Best Regards,<br>
    Zhiwei<br>
    <blockquote type="cite"
      cite="mid:300c780c-0167-0a87-58b9-2fff8ab91190@linaro.org">
      <pre class="moz-quote-pre" wrap="">

r~
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------0D8B22ED35641CFA4D1203D0--


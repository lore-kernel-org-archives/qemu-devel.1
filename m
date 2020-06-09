Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F61C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 03:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C552078C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 03:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C552078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiUeC-00069Z-7R
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 23:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jiUdW-0005kU-5w
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 23:09:14 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jiUdV-0006m9-6a
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 23:09:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1616704|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.26648-0.00173423-0.731786;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03311; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=3; RT=3; SR=0; TI=SMTPD_---.HjvK6Xj_1591672147; 
Received: from 30.225.208.60(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HjvK6Xj_1591672147)
 by smtp.aliyun-inc.com(10.147.41.231);
 Tue, 09 Jun 2020 11:09:07 +0800
Subject: Re: fpu/softfloat: a question on BFloat 16 support on QEMU
To: Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
References: <ea06c0c3-465e-34a5-5427-41ae6bf583dc@c-sky.com>
 <cbaf8623-daee-a8b1-3637-3afce26e5004@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <4e3514e1-796d-b687-04f6-0ed5a8d88cf8@c-sky.com>
Date: Tue, 9 Jun 2020 11:09:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <cbaf8623-daee-a8b1-3637-3afce26e5004@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 23:02:46
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/6/9 3:34, Richard Henderson wrote:
> On 6/8/20 5:53 AM, LIU Zhiwei wrote:
>> Hi Richard,
>>
>> I am doing bfloat16 support on QEMU.
>>
>> Once I tried to reuse float32 interface, but I couldn't properly process
>> rounding in some insns like fadd.
>>
>> What's your opinion about it? Should I expand the fpu/softfloat?
> Yes, we need to expand fpu/softfloat.
>
> You'll want something like
>
> static const FloatFmt bfloat16_params = {
>      FLOAT_PARAMS(8, 7)
> };
>
> (This would be the Arm and x86 definition, anyway; hopefully risc-v is the same.)
Yes. It's the same for me.
> And then add all of the other interface functions that you need to use that
> parameter.
>
> FWIW, it appears that Arm only requires:
>
>    float32_to_bfloat16
>    bfloat16_mul
>    bfloat16_add
>
> and I could even get away with only float32_to_bfloat16, since technically
> Arm's BFAdd and BFMul psuedo-code are implemented in terms of single-precision
> arithmetic, followed by a round-to-odd into BFloat16.
Some different here.

It's directly implemented in half-precision unit. So I'm afraid I have 
to implement as many as interfaces like float16.

Best Regards,
Zhiwei

>
>
> r~



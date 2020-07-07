Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F5DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 22:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAA52064C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 22:46:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAA52064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jswM5-0006Az-CA
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 18:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jswLX-0005lW-8V
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 18:45:51 -0400
Received: from mail142-34.mail.alibaba.com ([198.11.142.34]:18319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jswLU-0006Rn-6M
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 18:45:50 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08250222|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.136279-0.0124588-0.851263;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03279; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=4; RT=4; SR=0; TI=SMTPD_---.HzsTO5e_1594158325; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.HzsTO5e_1594158325)
 by smtp.aliyun-inc.com(10.147.42.16); Wed, 08 Jul 2020 05:45:25 +0800
Subject: Re: [PATCH 0/6] target/riscv: NaN-boxing for multiple precison
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
 <6d2e6876-18a8-b32a-0879-565693b6d446@linaro.org>
 <3c139607-9cac-a28a-c296-b0e147b3b20f@c-sky.com>
Message-ID: <53a00d93-be8b-6cc2-e091-215c71661453@c-sky.com>
Date: Wed, 8 Jul 2020 05:45:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3c139607-9cac-a28a-c296-b0e147b3b20f@c-sky.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=198.11.142.34; envelope-from=zhiwei_liu@c-sky.com;
 helo=mail142-34.mail.alibaba.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 18:45:42
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

Ping for other patches in this patch set.

I may not get you ideas. Could you give more information?

Zhiwei

On 2020/7/3 20:33, LIU Zhiwei wrote:
>
>
> On 2020/7/3 1:37, Richard Henderson wrote:
>> On 6/26/20 1:59 PM, LIU Zhiwei wrote:
>>> Multiple precison shoule be supported by NaN-boxing. That means, we 
>>> should
>>> flush not valid NaN-boxing input to canonical NaN before effective
>>> calculation and we should NaN-boxing the result after the effective
>>> calculation.
>>>
>>> In this patch set, split the implementation to three steps for compute,
>>> sign-injection, and some covert insns, which are check_nanboxed,
>>> effective calculation and gen_nanbox_fpr.
>>>
>>> Check_nanboxed checks the inputs and flushes not valid inputs to 
>>> cancical NaN.
>>> Effective calculation is direct calculation on fp32 values.
>>> Gen_nanbox_fpr does the NaN-boxing, writing the 1s to upper 32 bits.
>> I know I just reviewed a couple of these, but then I got to thinking 
>> about
>> patch 3 more closely.
>>
>> I think it would be better to do all of the nan-boxing work inside of 
>> the
>> helpers, including the return values.
> Do you mean a helper function just for nan-boxing work?
>
> I don't think so.
>
> The inputs are flushed to canonical NAN only when they are
> not legal nan-boxed values.
>
> The result is nan-boxed before writing  to  destination register.
>
> Both of them have some relations to nan-boxing, but they are not the 
> same.
>> Since we must have a helper call for the actual fp arithmetic, we 
>> might as well
>> put the rest of the logic in there too.  That way the JIT code is 
>> smaller.
> Yes, we can. But I think it is clearer just let helper do calculation.
>
>  By the way, is there some advantages of  smaller JIT code？
>> If, for RVF && !RVD, we always maintain the invariant that the values 
>> are
>> nanboxed anyway, then we do not even have to check for RVD at runtime.
> Do you mean if FMV.X.S and FLW are nan-boxed, then we will not get the 
> invalid values？
>
> I don't think so.
>
> First, FMV.X.D can transfer any 64 bits value to float register.
> Second, users may set  invalid values  to float register by GDB.
>
> I think it's necessary to do the inputs check and result nan-boxing.
>
>
> Zhiwei
>> Thoughts?
>>
>>
>> r~
>



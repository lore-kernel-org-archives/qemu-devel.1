Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9CFC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:11:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B057F206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B057F206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbKlH-0005WX-Us
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 05:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jbKge-0000QW-GV; Wed, 20 May 2020 05:06:52 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jbKgc-0003Gx-8u; Wed, 20 May 2020 05:06:51 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0767612|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.551534-0.00035049-0.448116;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l07447; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.Hb5n1.8_1589965600; 
Received: from 30.225.208.54(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.Hb5n1.8_1589965600)
 by smtp.aliyun-inc.com(10.147.41.158);
 Wed, 20 May 2020 17:06:40 +0800
Subject: Re: [RFC PATCH 2/8] riscv: Generate payload scripts
To: Richard Henderson <richard.henderson@linaro.org>, peter.maydell@linaro.org
References: <20200430072139.4602-1-zhiwei_liu@c-sky.com>
 <20200430072139.4602-3-zhiwei_liu@c-sky.com>
 <70ed74b9-83bb-c3ae-667a-bd74826acdd4@linaro.org>
 <047f591b-3c70-7ae8-8c2b-2a8ce2e41309@c-sky.com>
 <865aaf91-59da-09a3-438a-3230ff69d093@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <04f42926-1b47-b433-3f52-23cda14ad478@c-sky.com>
Date: Wed, 20 May 2020 17:06:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <865aaf91-59da-09a3-438a-3230ff69d093@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 05:06:41
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com,
 wenmeng_zhang@c-sky.com, palmer@dabbelt.com, alistair23@gmail.com,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/5/20 13:41, Richard Henderson wrote:
> On 5/19/20 7:37 PM, LIU Zhiwei wrote:
>> On 2020/5/12 1:40, Richard Henderson wrote:
>>> On 4/30/20 12:21 AM, LIU Zhiwei wrote:
>>>> +    # sequence of li rd, 0x1234567887654321
>>>> +    #
>>>> +    #  0:   002471b7                lui     rd,0x247
>>>> +    #  4:   8ad1819b                addiw   rd,rd,-1875
>>>> +    #  8:   00c19193                slli    rd,rd,0xc
>>>> +    #  c:   f1118193                addi    rd,rd,-239 # 0x246f11
>>>> +    # 10:   00d19193                slli    rd,rd,0xd
>>>> +    # 14:   d9518193                addi    rd,rd,-619
>>>> +    # 18:   00e19193                slli    rd,rd,0xe
>>>> +    # 1c:   32118193                addi    rd,rd,801
>>> You don't really need to use addiw.  Removing that special case would really
>>> simplify this.
>> I think I don't get it. Do you mean that the immediate will not be 64 bit?
> Well, mostly the immediate will be small, actually.  But the interface must
> support 64-bit immediates.
>
> I'm saying that for this computation,
>
> 	lui
> 	addi
> 	slli
> 	addi
> 	...
>
> is the same.  You don't *have* to use addiw.
I see addiw is not good, as it is a RV64 only instruction. I think addi 
is right and better.

But I'm afraid I don't get

"Removing that special case would really
simplify this."

Do you mean I need not the decode_li function if I use addi instead of 
addiw?

Zhiwei
>
> r~



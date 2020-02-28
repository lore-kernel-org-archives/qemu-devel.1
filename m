Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380B7C3F2D0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 06:20:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C22D205C9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 06:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C22D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Z0M-0005mu-95
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 01:20:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j7Yzh-0005Ia-3p
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 01:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j7Yzf-0005AM-Gy
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 01:19:29 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34647)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j7Yzf-00059Q-0y; Fri, 28 Feb 2020 01:19:27 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1877446|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.466779-0.0217452-0.511476;
 DS=CONTINUE|ham_regular_dialog|0.423602-0.000318491-0.57608;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03293; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GtZudvR_1582870761; 
Received: from 192.168.43.249(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GtZudvR_1582870761)
 by smtp.aliyun-inc.com(10.147.41.120);
 Fri, 28 Feb 2020 14:19:22 +0800
Subject: Re: [PATCH v3 1/1] target/riscv: add vector integer operations
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200226024352.7719-1-zhiwei_liu@c-sky.com>
 <d47523ad-52e3-b0a8-a47d-c91442fbe48d@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <e25d6bea-65ae-2cfc-906e-f149f4c200b7@c-sky.com>
Date: Fri, 28 Feb 2020 14:19:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <d47523ad-52e3-b0a8-a47d-c91442fbe48d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, linux-csky@vger.kernel.org,
 wxy194768@alibaba-inc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/28 13:46, Richard Henderson wrote:
> On 2/25/20 6:43 PM, LIU Zhiwei wrote:
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>>   target/riscv/helper.h                   |  395 +++++++
>>   target/riscv/insn32.decode              |  127 +++
>>   target/riscv/insn_trans/trans_rvv.inc.c |  671 +++++++++++-
>>   target/riscv/vector_helper.c            | 1308 ++++++++++++++++++++++-
>>   4 files changed, 2462 insertions(+), 39 deletions(-)
> This patch is too large and needs splitting.
OK.
>> -static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm)
>> +static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm,
>> +    bool widen)
>>   {
>> -    return !(s->lmul > 1 && vm == 0 && vd == 0);
>> +    return (vm != 0 || vd != 0) ? true : (!widen && (s->lmul == 0));
>>   }
>>   
> Best to move the addition of widen back to the patch that introduced this function.
>
> The "? true :" is a funny way to write ||.
Oh yes. I did not notice it.
>
> r~



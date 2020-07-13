Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02556C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:24:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD1620720
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:24:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD1620720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4zt-00006l-2R
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jv4zM-00087j-Ez
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:23:48 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58819)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jv4yb-0001D2-52
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:23:48 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1576805|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0487655-0.000576633-0.950658;
 FP=0|0|0|0|0|-1|-1|-1; HT=e01l04362; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=5; RT=5; SR=0; TI=SMTPD_---.I1FPu0k_1594671773; 
Received: from 192.168.3.36(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.I1FPu0k_1594671773)
 by smtp.aliyun-inc.com(10.147.41.178);
 Tue, 14 Jul 2020 04:22:54 +0800
Subject: Re: [RFC PATCH 5/8] fpu/softfloat: define brain floating-point types
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
 <20200712234521.3972-6-zhiwei_liu@c-sky.com>
 <1c090feb-0101-ce1a-af8e-2f7e45fd5053@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <710a32d0-9289-a3b1-9dd2-59a09125c162@c-sky.com>
Date: Tue, 14 Jul 2020 04:22:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1c090feb-0101-ce1a-af8e-2f7e45fd5053@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 16:16:00
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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



On 2020/7/14 3:26, Richard Henderson wrote:
> On 7/12/20 4:45 PM, LIU Zhiwei wrote:
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>>   include/fpu/softfloat-types.h | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
>> index 7680193ebc..8f8fdfeecf 100644
>> --- a/include/fpu/softfloat-types.h
>> +++ b/include/fpu/softfloat-types.h
>> @@ -112,6 +112,14 @@ typedef struct {
>>   #define make_float128(high_, low_) ((float128) { .high = high_, .low = low_ })
>>   #define make_float128_init(high_, low_) { .high = high_, .low = low_ }
>>   
>> +/*
>> + * Software brain floating-point types
>> + */
>> +typedef uint16_t bfloat16;
>> +#define bfloat16_val(x) (x)
>> +#define make_bfloat16(x) (x)
>> +#define const_bfloat16(x) (x)
> I do not like the val/make/const macros.  I've been meaning to get them everywhere.
Yes, but they have been spread to everywhere.

Should we just make bfloat16 different or remove all other references?
> The word "brain" is better translated as "neural-network" in english.
Do you mean the comment here should be

+/*
+ * Software neural-network floating-point types
+ */

Zhiwei
>
> r~



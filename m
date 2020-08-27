Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47224C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18DA122CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 13:03:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18DA122CB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHYy-000796-8w
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 09:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tianjia.zhang@linux.alibaba.com>)
 id 1kBHXS-0005gT-T2
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:01:58 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tianjia.zhang@linux.alibaba.com>)
 id 1kBHXH-00013f-Ay
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 09:01:54 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e07425;
 MF=tianjia.zhang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0U7.lQO1_1598533237; 
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com
 fp:SMTPD_---0U7.lQO1_1598533237) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 27 Aug 2020 21:00:37 +0800
Subject: Re: [PATCH] qemu-options.hx: Fix typo for netdev documentation
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200727045925.29375-1-tianjia.zhang@linux.alibaba.com>
 <20200727054335-mutt-send-email-mst@kernel.org>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <cb08fa85-e7d3-09af-d702-036fd165a46d@linux.alibaba.com>
Date: Thu, 27 Aug 2020 21:00:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200727054335-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=tianjia.zhang@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 09:00:38
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -116
X-Spam_score: -11.7
X-Spam_bar: -----------
X-Spam_report: (-11.7 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, thuth@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kraxel@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Other opinions needed?


Thanks,

Tianjia

On 7/27/20 5:44 PM, Michael S. Tsirkin wrote:
> On Mon, Jul 27, 2020 at 12:59:25PM +0800, Tianjia Zhang wrote:
>> This patch fixes the netdev document description typo in qemu-option.hx.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> Trivial tree? Jason's ?
>
>> ---
>>   qemu-options.hx | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 708583b4ce..92556ed96d 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -2684,7 +2684,7 @@ SRST
>>       disable script execution.
>>   
>>       If running QEMU as an unprivileged user, use the network helper
>> -    helper to configure the TAP interface and attach it to the bridge.
>> +    to configure the TAP interface and attach it to the bridge.
>>       The default network helper executable is
>>       ``/path/to/qemu-bridge-helper`` and the default bridge device is
>>       ``br0``.
>> -- 
>> 2.17.1


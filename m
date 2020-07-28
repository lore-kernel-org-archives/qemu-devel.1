Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CFEC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94AA7206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 12:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AA7206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Ojg-00025k-Tf
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 08:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tianjia.zhang@linux.alibaba.com>)
 id 1k0Oj9-0001ew-J7
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:29:03 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:38692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tianjia.zhang@linux.alibaba.com>)
 id 1k0Oj3-00010p-2R
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 08:28:59 -0400
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01419;
 MF=tianjia.zhang@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0U43fAmn_1595939323; 
Received: from 30.27.116.241(mailfrom:tianjia.zhang@linux.alibaba.com
 fp:SMTPD_---0U43fAmn_1595939323) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 28 Jul 2020 20:28:43 +0800
Subject: Re: [PATCH] qemu-options.hx: Fix typo for netdev documentation
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200727045925.29375-1-tianjia.zhang@linux.alibaba.com>
 <20200727054335-mutt-send-email-mst@kernel.org>
From: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <041e2c0f-736b-51d2-5708-e553ad569292@linux.alibaba.com>
Date: Tue, 28 Jul 2020 20:28:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727054335-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.54;
 envelope-from=tianjia.zhang@linux.alibaba.com;
 helo=out30-54.freemail.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 08:28:46
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -98
X-Spam_score: -9.9
X-Spam_bar: ---------
X-Spam_report: (-9.9 / 5.0 requ) BAYES_00=-1.9, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001,
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



On 2020/7/27 17:44, Michael S. Tsirkin wrote:
> On Mon, Jul 27, 2020 at 12:59:25PM +0800, Tianjia Zhang wrote:
>> This patch fixes the netdev document description typo in qemu-option.hx.
>>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Trivial tree? Jason's ?
> 

It's for mainline tree.

Thanks
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


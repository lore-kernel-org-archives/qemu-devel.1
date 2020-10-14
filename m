Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11131C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 01:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85CC021D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 01:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CC021D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSVdQ-0003sB-Lz
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 21:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kSVcF-0002w2-08; Tue, 13 Oct 2020 21:30:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5179 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kSVcC-00027N-Bl; Tue, 13 Oct 2020 21:30:06 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 2EF2FD7ED8481D1D300A;
 Wed, 14 Oct 2020 09:29:53 +0800 (CST)
Received: from [10.174.186.51] (10.174.186.51) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 14 Oct 2020 09:29:43 +0800
Subject: Re: [PATCH v2 1/8] migration: Do not use C99 // comments
To: Bihong Yu <yubihong@huawei.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>
References: <1602508140-11372-1-git-send-email-yubihong@huawei.com>
 <1602508140-11372-2-git-send-email-yubihong@huawei.com>
 <20201013093905.GB2920@work-vm>
 <ae6666c0-e68e-3541-274e-de25d4bd3a22@huawei.com>
From: Zheng Chuan <zhengchuan@huawei.com>
Message-ID: <f764ce51-60ee-0b84-a357-fb2cffc9d197@huawei.com>
Date: Wed, 14 Oct 2020 09:29:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ae6666c0-e68e-3541-274e-de25d4bd3a22@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.51]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 21:29:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, alex.chen@huawei.com, wanghao232@huawei.com,
 qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Also DEBUG_CACHE in migration/page_cache.c is need to rebase on trace_calls.

On 2020/10/13 21:20, Bihong Yu wrote:
> Thank you for your review. OK, I will try to rewrite the DPRINTF to use trace_ instead.
> 
> On 2020/10/13 17:39, Dr. David Alan Gilbert wrote:
>> * Bihong Yu (yubihong@huawei.com) wrote:
>>> Signed-off-by: Bihong Yu <yubihong@huawei.com>
>>> Reviewed-by: Chuan Zheng <zhengchuan@huawei.com>
>>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>
>> another task at some point would be to rewrite the DPRINTF's in
>> migration/block.c to use trace_ instead.
>>
>>> ---
>>>  migration/block.c | 2 +-
>>>  migration/rdma.c  | 2 +-
>>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/migration/block.c b/migration/block.c
>>> index 737b649..4b8576b 100644
>>> --- a/migration/block.c
>>> +++ b/migration/block.c
>>> @@ -40,7 +40,7 @@
>>>  #define MAX_IO_BUFFERS 512
>>>  #define MAX_PARALLEL_IO 16
>>>  
>>> -//#define DEBUG_BLK_MIGRATION
>>> +/* #define DEBUG_BLK_MIGRATION */
>>>  
>>>  #ifdef DEBUG_BLK_MIGRATION
>>>  #define DPRINTF(fmt, ...) \
>>> diff --git a/migration/rdma.c b/migration/rdma.c
>>> index 0340841..0eb42b7 100644
>>> --- a/migration/rdma.c
>>> +++ b/migration/rdma.c
>>> @@ -1288,7 +1288,7 @@ const char *print_wrid(int wrid)
>>>   * workload information or LRU information is available, do not attempt to use
>>>   * this feature except for basic testing.
>>>   */
>>> -//#define RDMA_UNREGISTRATION_EXAMPLE
>>> +/* #define RDMA_UNREGISTRATION_EXAMPLE */
>>>  
>>>  /*
>>>   * Perform a non-optimized memory unregistration after every transfer
>>> -- 
>>> 1.8.3.1
>>>
> .
> 

-- 
Thanks, Chuan


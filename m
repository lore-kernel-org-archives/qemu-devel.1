Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422E6C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 06:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD2EA21D43
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 06:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2EA21D43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKy73-0007V9-VY
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 02:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@cn.fujitsu.com>)
 id 1kKy6I-0006cm-18
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 02:17:58 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45438
 helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lizhijian@cn.fujitsu.com>) id 1kKy6E-0005xR-Tq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 02:17:57 -0400
X-IronPort-AV: E=Sophos;i="5.77,293,1596470400"; d="scan'208";a="99529569"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
 by heian.cn.fujitsu.com with ESMTP; 23 Sep 2020 14:17:44 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
 by cn.fujitsu.com (Postfix) with ESMTP id AA5C648990D2;
 Wed, 23 Sep 2020 14:17:40 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 23 Sep 2020 14:17:39 +0800
Subject: Re: [PATCH 1/3] colo-compare: return -1 if no packet is queued
To: "Zhang, Chen" <chen.zhang@intel.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
References: <20200922095525.4081603-1-lizhijian@cn.fujitsu.com>
 <20200922095525.4081603-2-lizhijian@cn.fujitsu.com>
 <e1841d5119ff4d82ad01586d08ea45ec@intel.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <5019ad5f-439e-ff9e-f67e-41e2ea76b615@cn.fujitsu.com>
Date: Wed, 23 Sep 2020 14:17:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e1841d5119ff4d82ad01586d08ea45ec@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: AA5C648990D2.AB27A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
Received-SPF: none client-ip=183.91.158.132;
 envelope-from=lizhijian@cn.fujitsu.com; helo=heian.cn.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 02:17:47
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/23/20 9:41 AM, Zhang, Chen wrote:
>
>> -----Original Message-----
>> From: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Sent: Tuesday, September 22, 2020 5:55 PM
>> To: Zhang, Chen <chen.zhang@intel.com>; jasowang@redhat.com
>> Cc: qemu-devel@nongnu.org; Li Zhijian <lizhijian@cn.fujitsu.com>
>> Subject: [PATCH 1/3] colo-compare: return -1 if no packet is queued
>>
>> Return 0 will trigger a packet comparison
>>
> Yes, we need active trigger a checkpoint to flush all the queued packets here.
Previously, no new checkpoint will be triggered since no new packet is queued though colo_compare_connection() is called.
actually we should send a notify to colo frame immediately, no need to compare them any more in order to less latency.

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 3a45d64175..23092e4496 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -285,10 +285,13 @@ static int packet_enqueue(CompareState *s, int mode, Connection **con)
      }

      if (!ret) {
+        /* queue is too long, do a checkpoint to release all queued packets */
+        colo_compare_inconsistency_notify(s);
          trace_colo_compare_drop_packet(colo_mode[mode],
              "queue size too big, drop packet");
          packet_destroy(pkt, NULL);
          pkt = NULL;
+        return -1;
      }

      *con = conn;


> Otherwise, we should drop all the packet after this time still next checkpoint.
> So, I think original logic is a better choice.
>
> Thanks
> Zhang Chen
>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>>   net/colo-compare.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c index
>> 3a45d64175..039b515611 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -289,6 +289,7 @@ static int packet_enqueue(CompareState *s, int
>> mode, Connection **con)
>>               "queue size too big, drop packet");
>>           packet_destroy(pkt, NULL);
>>           pkt = NULL;
>> +        return -1;
>>       }
>>
>>       *con = conn;
>> --
>> 2.28.0
>>
>>
>
>





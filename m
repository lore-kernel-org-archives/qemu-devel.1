Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2D8CA9EA0
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:29:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7C7207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7C7207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN6P3-0002oK-6m
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 22:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yezhenyu2@huawei.com>) id 1iN6OL-0002Mt-9v
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yezhenyu2@huawei.com>) id 1iN6OK-0000YT-2q
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:28:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2253 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yezhenyu2@huawei.com>)
 id 1iN6OJ-0000WS-OF
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:28:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id F35C1B0A3C5B7AF09CC4;
 Wed, 23 Oct 2019 10:28:46 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.212) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0;
 Wed, 23 Oct 2019 10:28:39 +0800
Subject: Re: [RFC PATCH] iothread: add set_iothread_poll_* commands
To: Eric Blake <eblake@redhat.com>
References: <5DAEB9D3.3080503@huawei.com>
 <95fde68e-9730-ce22-b59d-c5e20f86d0c1@redhat.com>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <5DAFBAD5.9040409@huawei.com>
Date: Wed, 23 Oct 2019 10:28:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <95fde68e-9730-ce22-b59d-c5e20f86d0c1@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.223.212]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: dgilbert@redhat.com, xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 jiangyiwen <jiangyiwen@huawei.com>, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2019/10/23 4:40, Eric Blake wrote:
> On 10/22/19 3:12 AM, yezhenyu (A) wrote:
>> Since qemu2.9, QEMU added three AioContext poll parameters to struct
>> IOThread: poll_max_ns, poll_grow and poll_shrink. These properties are
>> used to control iothread polling time.
>>
>> However, there isn't properly hmp commands to adjust them when the VM is
>> alive. It's useful to adjust them online when observing the impact of
>> different property value on performance.
>>
>> This patch add three hmp commands to adjust iothread poll-* properties
>> for special iothread:
>>
>> set_iothread_poll_max_ns: set the maximum polling time in ns;
>> set_iothread_poll_grow: set how many ns will be added to polling time;
>> set_iothread_poll_shrink: set how many ns will be removed from polling
>> time.
>>
>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
>> ---
>> hmp-commands.hx | 42 ++++++++++++++++++++
>> hmp.c | 30 +++++++++++++++
>> hmp.h | 3 ++
>> include/sysemu/iothread.h | 6 +++
>> iothread.c | 80 +++++++++++++++++++++++++++++++++++++++
>> qapi/misc.json | 23 +++++++++++
>> 6 files changed, 184 insertions(+)
> 
> Looking at just the QMP...
> 

Thanks for your review. I will split this patch to QMP and HMP.

>> +++ b/qapi/misc.json
>> @@ -675,6 +675,29 @@
>> { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'],
>> 'allow-preconfig': true }
>>
>> +##
>> +# @set-iothread-poll-param:
>> +#
>> +# Set poll-* properties for a special iothread.
>> +# The poll-* name can be poll_max_ns/poll_grow/poll_shrink.
> 
> This should be an enum.

I will change the name argument to ENUM, such as,

    { 'enum': 'IothreadPollProperty',
      'data': [ 'max-ns', 'grow', 'shrink' ] }

>> +#
>> +# Notes: can not set the QEMU main loop thread, which is not declared
>> +# using the -object iothread command-line option. The poll_ns property can not
>> +# be set manually, which is auto-adjust.
> 
> You failed to document the parameters (iothread_id, name, value).
> 

I will add these documents.

>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "set-iothread-poll-param",
>> +# "arguments": { "iothread_id": "1",
>> +# "name": "poll_max_ns",
>> +# "value": 1000 } }
>> +# <- { "return": {} }
>> +#
>> +# Since 3.0
> 
> 4.2 is the earliest this can make it in.
> 

OK, I will change this to 4.2.

>> +##
>> +{ 'command': 'set-iothread-poll-param',
>> + 'data': {'iothread_id': 'str', 'name': 'str', 'value': 'int'} }
> 
> Our naming convention prefers 'iothread-id'.
> 

ok, I will correct it, such as,

    { 'command': 'set-iothread-poll-param',
    'data': {'iothread-id': 'str', 'name': 'IothreadPollProperty', 'value': 'int'} }



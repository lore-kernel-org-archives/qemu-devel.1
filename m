Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94841C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DD012074A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:10:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DD012074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHrYw-00083y-Jh
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 12:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jHrYB-0007dK-BB
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jHrY9-0000N1-UI
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:09:38 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:4508)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1jHrY8-0008IM-8B
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 12:09:37 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by
 rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95e7e2523d18-deb2d;
 Sat, 28 Mar 2020 00:09:08 +0800 (CST)
X-RM-TRANSID: 2ee95e7e2523d18-deb2d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.43.82] (unknown[117.136.46.213])
 by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45e7e25223c2-cc6a8;
 Sat, 28 Mar 2020 00:09:08 +0800 (CST)
X-RM-TRANSID: 2ee45e7e25223c2-cc6a8
Subject: Re: [PATCH] monitor/hmp-cmds: add units for mirate_parameters.
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20200327073210.198080-1-maozhongyi@cmss.chinamobile.com>
 <20200327092951.bu4ju7rh53ig5t3l@steredhat> <20200327112814.GD2786@work-vm>
 <20200327131253.3axcri54an4pmuzf@steredhat> <20200327132136.GH2786@work-vm>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <aa647c52-09e9-b2bc-72f9-9d1d7d5b57e6@cmss.chinamobile.com>
Date: Sat, 28 Mar 2020 00:09:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20200327132136.GH2786@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 221.176.66.81
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/27/20 9:21 PM, Dr. David Alan Gilbert wrote:
> * Stefano Garzarella (sgarzare@redhat.com) wrote:
>> On Fri, Mar 27, 2020 at 11:28:14AM +0000, Dr. David Alan Gilbert wrote:
>>> * Stefano Garzarella (sgarzare@redhat.com) wrote:
>>>> Hi Mao,
>>>>
>>>> On Fri, Mar 27, 2020 at 03:32:10PM +0800, Mao Zhongyi wrote:
>>>>> When running:
>>>>> (qemu) info migrate_parameters
>>>>> announce-initial: 50 ms
>>>>> announce-max: 550 ms
>>>>> announce-step: 100 ms
>>>>> compress-wait-thread: on
>>>>> ...
>>>>> max-bandwidth: 33554432 bytes/second
>>>>> downtime-limit: 300 milliseconds
>>>>> x-checkpoint-delay: 20000
>>>>> ...
>>>>> xbzrle-cache-size: 67108864
>>>>>
>>>>> add units for the parameters 'x-checkpoint-delay' and
>>>>> 'xbzrle-cache-size', it's easier to read.
>>>>>
>>>>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>>>>> ---
>>>>>   monitor/hmp-cmds.c | 4 ++--
>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
>>>>> index 2a900a528a..8d22f96e57 100644
>>>>> --- a/monitor/hmp-cmds.c
>>>>> +++ b/monitor/hmp-cmds.c
>>>>> @@ -440,7 +440,7 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
>>>>>               MigrationParameter_str(MIGRATION_PARAMETER_DOWNTIME_LIMIT),
>>>>>               params->downtime_limit);
>>>>>           assert(params->has_x_checkpoint_delay);
>>>>> -        monitor_printf(mon, "%s: %u\n",
>>>>> +        monitor_printf(mon, "%s: %u" " milliseconds\n",
>>>>                                         ^
>>>> here we can remove the space and use a single string "%s: %u milliseconds\n"
>>>
>>> Yes.
>>>
>>>> I've noticed that we use both ms or milliseconds, if you want to clean up in a
>>>> separate patch, maybe we could use one of these everywhere. (I vote for 'ms')
>>>
>>> I do prefer 'ms', however we do seem to just use milliseconds in
>>> info migrate
>>
>> IIUC, currently with 'info migrate_parameters' we have:
>> - announce-initial, announce-max, and announce-step with 'ms'
>> - downtime-limit with 'milliseconds'
> 
> You're right, so we do - in that case I agree, lets just move them all
> to 'ms'.
> 
thanks for your explanation, I got it, will fix it.

Thanks
Mao
> Dave
> 
>> Stefano
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 




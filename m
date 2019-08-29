Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A800C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A15E2339E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 13:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A15E2339E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3KRC-0000O7-CS
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 09:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1i3KQ5-00085G-Mz
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1i3KQ3-0005GX-GS
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:24:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1184)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1i3KQ3-0005G9-Ac
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 09:24:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 12DD03091761;
 Thu, 29 Aug 2019 13:24:54 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5D56608C1;
 Thu, 29 Aug 2019 13:24:43 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <f307829a5e64121b5cb8ad1aefff09f41cac9699.1567070002.git.mprivozn@redhat.com>
 <87v9ugrx2k.fsf@dusky.pond.sub.org>
 <f6ae646f-620d-964a-dd36-e6f636fc08da@redhat.com>
 <a519150a-bf44-1144-e738-9d8c6cdf5dda@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <fb78b4ad-9cd5-4a25-8d55-c398bb508587@redhat.com>
Date: Thu, 29 Aug 2019 15:24:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a519150a-bf44-1144-e738-9d8c6cdf5dda@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 29 Aug 2019 13:24:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qapi: Reintroduce CommandDisabled error
 class
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
Cc: lcapitulino@redhat.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 3:12 PM, Eric Blake wrote:
> On 8/29/19 8:04 AM, Michal Privoznik wrote:
> 
>>>> A bit of background: up until very recently libvirt used qemu-ga
>>>> in all or nothing way. It didn't care why a qemu-ga command
>>>> failed. But very recently a new API was introduced which
>>>> implements 'best effort' approach (in some cases) and thus
>>>> libvirt must differentiate between: {CommandNotFound,
>>>> CommandDisabled} and some generic error. While the former classes
>>>> mean the API can issue some other commands the latter raises a
>>>> red flag causing the API to fail.
>>>
>>> Why do you need to distinguish CommandNotFound from CommandDisabled?
>>
>> I don't. That's why I've put them both in curly braces. Perhaps this
>> says its better:
>>
>> switch (klass) {
>>    case CommandNotFound:
>>    case CommandDisabled:
>>          /* okay */
>>          break;
>>
> 
> So the obvious counter-question - why not use class CommandNotFound for
> a command that was disabled, rather than readding another class that has
> no distinctive purpose?
> 
> 

Because disabling a command is not the same as nonexistent command. 
While a command can be disabled by user/sysadmin, they are disabled at 
runtime by qemu-ga itself for a short period of time (e.g. on FS freeze 
some commands are disabled - typically those which require write disk 
access). And I guess reporting CommandNotFound for a command that does 
exist only is disabled temporarily doesn't reflect the reality, does it?

On the other hand, CommandNotFound would fix the issue for libvirt, so 
if you don't want to invent a new error class, then that's the way to go.

Michal


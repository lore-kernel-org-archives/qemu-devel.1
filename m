Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA77AC3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDCF21726
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 13:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDCF21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3h5n-0004Ni-Ls
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 09:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mprivozn@redhat.com>) id 1i3gym-0007Ib-0H
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mprivozn@redhat.com>) id 1i3gyi-0004gi-CO
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:30:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1i3gye-0004cQ-B0
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 09:30:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 907BCC05AA6A;
 Fri, 30 Aug 2019 13:30:04 +0000 (UTC)
Received: from [10.43.2.30] (unknown [10.43.2.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1E9B5D9CA;
 Fri, 30 Aug 2019 13:30:00 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>
References: <f307829a5e64121b5cb8ad1aefff09f41cac9699.1567070002.git.mprivozn@redhat.com>
 <87v9ugrx2k.fsf@dusky.pond.sub.org>
 <f6ae646f-620d-964a-dd36-e6f636fc08da@redhat.com>
 <a519150a-bf44-1144-e738-9d8c6cdf5dda@redhat.com>
 <fb78b4ad-9cd5-4a25-8d55-c398bb508587@redhat.com>
 <8736hiq394.fsf@dusky.pond.sub.org>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <cdecc879-8ef7-d795-ccd4-58b98e4a5df8@redhat.com>
Date: Fri, 30 Aug 2019 15:29:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8736hiq394.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 30 Aug 2019 13:30:04 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, lcapitulino@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/19 1:52 PM, Markus Armbruster wrote:
> Michal Privoznik <mprivozn@redhat.com> writes:
> 
>> On 8/29/19 3:12 PM, Eric Blake wrote:
>>> On 8/29/19 8:04 AM, Michal Privoznik wrote:
>>>
>>>>>> A bit of background: up until very recently libvirt used qemu-ga
>>>>>> in all or nothing way. It didn't care why a qemu-ga command
>>>>>> failed. But very recently a new API was introduced which
>>>>>> implements 'best effort' approach (in some cases) and thus
>>>>>> libvirt must differentiate between: {CommandNotFound,
>>>>>> CommandDisabled} and some generic error. While the former classes
>>>>>> mean the API can issue some other commands the latter raises a
>>>>>> red flag causing the API to fail.
>>>>>
>>>>> Why do you need to distinguish CommandNotFound from CommandDisabled?
>>>>
>>>> I don't. That's why I've put them both in curly braces. Perhaps this
>>>> says its better:
>>>>
>>>> switch (klass) {
>>>>     case CommandNotFound:
>>>>     case CommandDisabled:
>>>>           /* okay */
>>>>           break;
>>>>
>>>
>>> So the obvious counter-question - why not use class CommandNotFound for
>>> a command that was disabled, rather than readding another class that has
>>> no distinctive purpose?
>>>
>>>
>>
>> Because disabling a command is not the same as nonexistent
>> command. While a command can be disabled by user/sysadmin, they are
>> disabled at runtime by qemu-ga itself for a short period of time
>> (e.g. on FS freeze some commands are disabled - typically those which
>> require write disk access). And I guess reporting CommandNotFound for
>> a command that does exist only is disabled temporarily doesn't reflect
>> the reality, does it?
>>
>> On the other hand, CommandNotFound would fix the issue for libvirt, so
>> if you don't want to invent a new error class, then that's the way to
>> go.
> 
> I'm fine with changing the error to CommandNotFound.
> 
> I'm reluctant to add back CommandDisabled.  I doubt it's necessary.
> 
> To arrive at an informed opinion, I had to figure out how this command
> disablement stuff works.  I can just as well send it out, so here goes.
> 
> Let's review our command disable feature.
> 
> Commands are enabled on registration, see qmp_register_command().
> 
> To disable, call qmp_disable_command().  Only qga/main.c does, in two
> places:
> 
> * ga_disable_non_whitelisted(): disable all commands except for
>    ga_freeze_whitelist[], which is documented as /* commands that are
>    safe to issue while filesystems are frozen */
> 
> * initialize_agent(): disable blacklisted commands.  I figure these are
>    the ones blacklisted with -b, plus commands blacklisted due to build
>    configuration.  The latter feels inappropriate; we should use QAPI
>    schema conditionals to compile them out instead (QAPI conditionals
>    didn't exist when the blacklisting code was written).
> 
> Disabled commands can be re-enabled with qmp_enable_command().  Only
> qga/main.c does, in ga_enable_non_blacklisted().  I figure it re-enables
> the commands ga_disable_non_whitelisted() disables.  Gets called when
> guest-fsfreeze-freeze freezes nothing[1], and when guest-fsfreeze-thaw
> succeeds[2].
> 
> Command dispatch fails when the command is disabled, in
> do_qmp_dispatch().  The proposed patch changes the error reply.
> 
> QGA's guest-info shows whether a command is disabled
> (GuestAgentCommandInfo member @enabled, set in qmp_command_info()).
> 
> QMP's query-commands skips disabled commands, in query_commands_cb().
> Dead, as nothing ever disables QMP commands.  Skipping feels like a bad
> idea anyway.
> 
> Analysis:
> 
> There are three kinds of disabled commands: compile-time (should be
> compiled out instead), permanently blacklisted with -b, temporarily
> disabled while filesystems are frozen.
> 
> There are two states: thawed (first two kinds disabled) and frozen (all
> three kinds disabled).
> 
> Command guest-fsfreeze-freeze[3] goes to state frozen or else fails.
> 
> Command guest-fsfreeze-thaw goes to state thawed or else fails.
> 
> guest-fsfreeze-status reports the state.
> 
> Note that the transition to frozen (and thus the temporary command
> disablement) is under the control of the QGA client.  There is no
> TOCTTOU between guest-info telling you which commands are disabled and
> executing the next command.  My point is: the client can figure out
> whether a command is disabled before executing it.

Alright then, I'll respin with CommandNotFound. Both work for libvirt.

Michal


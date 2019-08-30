Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE56C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E2F23429
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 18:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E2F23429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3lPp-0005Pn-3i
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 14:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i3lN3-0004Bo-Og
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:11:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i3lN0-0001Mz-Qd
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 14:11:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i3lMt-00012H-6q; Fri, 30 Aug 2019 14:11:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B75CF51EF1;
 Fri, 30 Aug 2019 18:11:22 +0000 (UTC)
Received: from [10.18.17.85] (dhcp-17-85.bos.redhat.com [10.18.17.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1E2719C7F;
 Fri, 30 Aug 2019 18:11:14 +0000 (UTC)
To: Christophe de Dinechin <dinechin@redhat.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
 <20190815114553.GQ300@andariel.pipo.sk> <87d0h6zfrt.fsf@dusky.pond.sub.org>
 <m1lfvbex92.fsf@redhat.com> <eba518d8-0104-fb41-8ed5-d59ebdb211c9@redhat.com>
 <m1k1avdkzu.fsf@redhat.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1b7887f1-41e9-8de3-8e92-fc6d6815f20f@redhat.com>
Date: Fri, 30 Aug 2019 14:11:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <m1k1avdkzu.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 30 Aug 2019 18:11:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/2] qapi: deprecate implicit
 filters
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/30/19 6:07 AM, Christophe de Dinechin wrote:
> 
> John Snow writes:
> 
>> On 8/29/19 12:45 PM, Christophe de Dinechin wrote:
>>>
> [...]
> 
>>> Sorry for catching up late, this mail thread happened during my PTO.
>>>
>>> I remember bringing up at the time [1] that the correct solution needs
>>> to take into account usage models that vary from
>>>
>>> - a workstation case, where displaying an error box is easy and
>>>   convenient,
>>>
>>> - to local headless VMs where system-level notification would do the job
>>>   better, allowing us to leverage things like system-wide email notifications
>>>
>>> - to large-scale collections of VMs managed by some layered product,
>>>   where the correct reporting would be through something like Insights,
>>>   i.e. you don't scan individual logs, you want something like "913 VMs
>>>   are using deprecated X"
>>>
>>> To me, that implies that we need to have a clear division of roles, with
>>> a standard way to
>>>
>>> a) produce the errors,
>>> b) propagate them,
>>
>> I started replying to this thread to the other mail you sent; I think
>> this is going to be fairly involved. I wouldn't mind being proven wrong
>> though.
> 
> Yes, I think it does look involved, but mostly for historical reasons.
> In other words, what is complicated is preserving the historical
> behaviors so as to not break existing consumers.
> 
>>
>>> c) consume them (at least up to libvirt)
>>>
>>> Notice that this work has already been done for "real" errors,
>>> i.e. there is a real QAPI notion of "errors". AFAICT, warn_report does
>>> not connect to it, though, it goes through error_vprintf which is really
>>> just basic logging.
>>>
>>> So would it make sense to:
>>>
>>> 1. Add a deprecation_report() alongside warn_report()?
>>>
>>
>> Where's that get routed to? just an error_vprintf style situation?
> 
> Yes, but see below.
> 
>>
>>> 2. Connect warn_report() and all the error_vprintf output to QAPI,
>>>    e.g. using John's suggestion of adding the messages using some
>>>    "warning" or "deprecated" tag?
>>>
>>
>> How do you correlate them?
> 
> Without having looked at the code much, I think I would
> 
> 1. extend the existing QAPI error to support warnings, deprecations and
>    info messages. The first problem I see is that there is no error, so
>    we may sometimes need to create one when there was none before. And
>    of course make sure that this does not ultimately show as an error,
>    but as a success with additional annotations.
> 

I assume this might be a chance to consolidate all of the methodologies
we use for actually checking if there was an error or not. There have
been many and I am sure Markus can give us a history lesson if it's
warranted.

Generally, there's a few paradigms I see a lot:

1. Rely on an error return code being produced by the called function.
The caller trusts that errp was set. This is one of my favorite methods,
because it has the least scaffolding.

2. Pass errp directly to the called function, and check for null after
return. I don't like this method very much, because of confusion with:

3. Create a local error object; check THAT for null, and propagate the
error to the common error object. I think Markus has explained why we
have this code 50 times, and I forget again minutes later.


If we want to expand the concept of the error object into something that
encompasses hints, warnings and deprecations*, checking for null is no
longer appropriate. It might be a good chance to make our error
propagation story more consistent, too.

We could unify with a helper like this, I think, if I'm not forgetting
some crucial usage detail:

subroutine(foo, bar, errp);
if (failure(errp)) {
    error_append_hint(errp, "Lorem ipsum, ...");
    cleanup();
    return;
}

We would then always use this pattern that operates directly on the
caller's errp instead of creating local error objects to allow hints and
warnings to accumulate.



(* I'm not proposing all three in a concrete way, but just referencing
the general class of semantic non-error information we may want to
propagate, however we end up deciding to model it.)

> 2. replace the current "link + if" switching for error_vprintf with some
>    actual notification mechanism, with one option routine to
>    monitor_vprintf, one to stderr, one to log file, and then an
>    additional path that would post a newly minted qapi warning.
> 
>>
>>> 3. Teach libvirt how to consume that new tag and pass it along?
>>>
>>
>> I think it's not libvirt's job to pass it along, exactly -- libvirt made
>> the decision for which features to engage in QEMU, not the end user.
> 
> First, by "pass along", I meant to possible layered products or
> management software. We don't necessarily need a new virErrorLevel,
> deprecation could be a warning with some special domain,
> e.g. VIR_FROM_DEPRECATION.
> 

SHOULD it pass it along? Libvirt knows what QMP is invoking, that should
be opaque to upper layers. a "DEPRECATION" log stream might give the
wrong idea -- that it's not the libvirt feature that's deprecated, but
something in one of the many drivers it has.

I think it's fine to relay this information via generic logging to the
higher levels (so that debugging can be facilitated from that level) but
I don't think it needs special access to these notices because they're
not useful to RHV developers or RHV users.

> There may be a need to add some API here. Looking at the code, it's not
> obvious to me that libvirt has any notion of error priority. In other
> words, if you raise an error then a warning, you get the warning as the
> last error, right?
> 

(Don't know.)

> 
> Second, why not report the use of deprecated features? I don't fully buy
> the rationale that libvirt engages the features, because it does not do
> it on its own, it does it because the user made some specific request.

Because the user didn't request those specific QMP features, they asked
for the VM to start, or to stop, or they asked for a backup, or a snapshot.

On my desktop, I am not really too interested in knowing if XFCE is
using deprecated features of xorg or wayland. I didn't tell it to use
them and I have no real power or control over that. It's nice if I'm a
developer, but as a user, it's noise.

So a development log seems right for these, but not user-visible
interruptions.

> This point of view also seems to require that libvirt or the user should
> know ahead of time it's about to engage a deprecated feature. To me, the
> problem is precisely that neither libvirt nor the user knows, which is
> why we are discussing how to best make it known.

Yeah, sure. I'm still a fan of the end result of having QMP return
messages including that information. I just don't think it makes sense
for libvirt to then relay it to the user or up the stack. I don't think
that's the same as proposing that it hides it, either.

> 
>>
>> If the user upgrades QEMU but not libvirt, it's not really anything they
>> have control over and they shouldn't be pestered with such things.
>>
>> However, if libvirt accidentally released a version that engages
>> deprecated behavior (and were unaware of it), it'd be nice to get user
>> reports, surely?
>>
>> Logging messages for libvirt might be the best that can be done there in
>> that case.
> 
> I personally would treat that like any warning.
> 
>>
>>
>> In contrast, power user tools like QMP libraries, qmp-shell and others
>> allow more direct and meaningful access to QMP, so those should report
>> deprecation messages to the user.
> 
> Agreed.
> 
>>
>>>
>>> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06131.html
>>>
> 
> --
> Thanks,
> Christophe de Dinechin (IRC c3d)
> 


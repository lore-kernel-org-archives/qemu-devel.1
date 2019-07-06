Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D87C5B578
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 06:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09B52089C
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 06:10:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09B52089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjduO-0007nX-MJ
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 02:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42298)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hjdtT-0007JJ-Mq
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 02:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hjdtR-0002mH-CW
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 02:09:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34030)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hjdtR-0002k6-4S
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 02:09:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C6EC0C0467E4;
 Sat,  6 Jul 2019 06:09:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44DB18D668;
 Sat,  6 Jul 2019 06:09:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC9251132ABF; Sat,  6 Jul 2019 08:09:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
 <20190702210017.4275-5-vandersonmr2@gmail.com>
 <877e8wk2nm.fsf@dusky.pond.sub.org> <87tvc0v99m.fsf@zen.linaroharston>
Date: Sat, 06 Jul 2019 08:09:46 +0200
In-Reply-To: <87tvc0v99m.fsf@zen.linaroharston> ("Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e=22's?= message of
 "Fri, 05 Jul 2019 15:36:05 +0100")
Message-ID: <87lfxbelsl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Sat, 06 Jul 2019 06:09:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/6] monitor: adding info tb and tbs to
 monitor
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 vandersonmr <vandersonmr2@gmail.com>, qemu-devel@nongnu.org, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: Marc-Andr=C3=A9, who has patches that might be useful here.

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> vandersonmr <vandersonmr2@gmail.com> writes:
>>
> <snip>
>
> I'll leave Vanderson to address your other comments.
>
>>
>> Debugging commands are kind of borderline.  Debugging is commonly a
>> human activity, where HMP is just fine.  However, humans create tools to
>> assist with their activities, and then QMP is useful.  While I wouldn't
>> encourage HMP-only for the debugging use case, I wouldn't veto it.
>>
>> Your (overly terse!) commit message and help texts make me guess the
>> commands are for gathering statistics.  Statistics can have debugging
>> uses.  But they often have non-debugging uses as well.  What use cases
>> can you imagine for these commands?
>
> So this is all really aimed at making TCG go faster - but before we can
> make it go faster we need better tools for seeing where the time is
> being spent and examining the code that we generate. So I expect the
> main users of this functionality will be QEMU developers.
>
> That said I can see a good rationale for supporting QMP because it is
> more amenable to automation. However this is early days so I would
> caution about exposing this stuff too early least we bake in a woolly
> API.

Development tools should exempt themselves from QMP's interface
stability promise: prefix the command names with 'x-'.

> The other wrinkle is we do have to take control of the emulator to
> safely calculate some of the numbers we output. This essentially means
> the HMP commands are asynchronous - we kick of safe work which waits
> until all vCPU threads are stopped before we go through the records and
> add up numbers. This is fine for the HMP because we just output to the
> monitor FD when we are ready. I assume for QMP commands there is more
> housekeeping to do? Can QMP commands wait for a response to be
> calculated by another thread? Are there any existing commands that have
> to support this sort of pattern?

Let me clarify "synchronous" to avoid confusion.

Both QMP and HMP commands are synchronous protocols in the sense that
commands are executed one after the other, without overlap.  When a
client sends multiple commands, it can assume that each one starts only
after the previous one completed.

Both HMP and QMP commands execute synchronously in the sense that the
command runs to completion without ever yielding the thread.  Any
blocking operations put the thread to sleep (but see below).

HMP runs in the main thread.  Putting the main thread to sleep is
generally undesirable.

QMP used to run in the main thread, too.  Nowadays, the QMP core runs in
an I/O thread shared by all monitors, and dispatches commands to the
main thread.  Moving command execution out of the main thread as well
requires careful review of the command's code for hidden assumptions.
Major project.

Fine print: OOB commands are a special case, but I doubt you want to
know more.

Fine print: certain character devices can't support use of an I/O
thread; QMP runs in the main thread then.  The ones you want to use with
QMP all support I/O threads.

You wrote "we kick of safe work which waits until all vCPU threads are
stopped before we go through the records and add up numbers [...] we
just output to the monitor FD".  Does this mean the HMP command kicks
off the work, terminates, and some time later something else prints
results to the monitor?  How much later?

If "later" is actually "soon", for a suitable value of "soon",
Marc-Andr=C3=A9's work on "asynchronous" QMP might be pertinent.  I put
"asynchronous" in scare quotes, because of the confusion it has caused.
My current understanding (Marc-Andr=C3=A9, please correct me if wrong): it
lets QMP commands to block without putting their thread to sleep.  It
does not make QMP an asynchronous protocol.

If "later" need not be "soon", read on.

In QMP, there are two established ways to do potentially long-running
work.  Both ways use a command that kicks off the work, then terminates
without waiting for it to complete.

The first way is traditional: pair the kick off command with a query
command and optionally an event.

When the work completes, it fires off the event.  The event is broadcast
to all QMP monitors (we could implement unicast if we have a compelling
use case).

The query command reports whether the work has completed, and if yes,
the work's results, if any.

You need the event if you want to avoid polling.

Even with an event, you still need a query command.  If your management
application loses its QMP connection temporarily, you can miss the
event.  You want to poll on reconnect, with the query command.

If more than one instance of the work can be pending at any one time,
event and query need to identify the instance somehow.  This is
completely ad hoc.

The second way is a full-blown "job".  This provides more control: you
can cancel, pause, resume, ...  It also provides a job ID.  More
featureful and more structured.

Jobs have grown out of block jobs.  I'd love to see some uses outside
the block subsystem.

Hope this helps!


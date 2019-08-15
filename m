Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40024C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1555620644
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 14:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1555620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyGO7-0004As-7M
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 10:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1hyGNQ-0003jj-26
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hyGNK-0004ft-3j
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 10:05:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hyGND-0004dn-As; Thu, 15 Aug 2019 10:05:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ECD99315C020;
 Thu, 15 Aug 2019 14:05:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 84CEA7D3F5;
 Thu, 15 Aug 2019 14:04:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3DE21D5D004; Thu, 15 Aug 2019 16:04:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
 <20190815114553.GQ300@andariel.pipo.sk>
>To: Peter Krempa <pkrempa@redhat.com>
Date: Thu, 15 Aug 2019 16:04:22 +0200
In-Reply-To: <20190815114553.GQ300@andariel.pipo.sk> (Peter Krempa's message
 of "Thu, 15 Aug 2019 13:45:53 +0200")
Message-ID: <87d0h6zfrt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 15 Aug 2019 14:05:02 +0000 (UTC)
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
 den@openvz.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Krempa <pkrempa@redhat.com> writes:

> On Thu, Aug 15, 2019 at 12:49:28 +0200, Kevin Wolf wrote:
>> Am 14.08.2019 um 21:27 hat John Snow geschrieben:
>
> [...]
>
>> > example:
>> > 
>> > { "return": {},
>> >   "deprecated": True,
>> >   "warning": "Omitting filter-node-name parameter is deprecated, it will
>> > be required in the future"
>> > }
>> > 
>> > There's no "error" key, so this should be recognized as success by
>> > compatible clients, but they'll definitely see the extra information.
>> > 
>> > Part of my motivation is to facilitate a more aggressive deprecation of
>> > legacy features by ensuring that we are able to rigorously notify users
>> > through any means that they need to adjust their scripts.
>> 
>> Who would read this, though? In the best case it ends up deep in a
>> libvirt log that nobody will look at because there was no error. In the
>> more common case, the debug level is configured so that QMP traffic
>> isn't even logged.
>
> The best we could do here is to log a warning. Thankfully we have one
> central function which always checks the returned JSON from qemu so we
> could do that universally.
>
> The would end up in the system log and alternatively also in the VM
> log file. I agree with Kevin that the possibility of it being noticed
> is rather small.
>
> From my experience users report non-fatal messages mostly only if it is
> spamming the system log. One of instances are very unlikely to be
> noticed.
>
> In my experience it's better to notify us in libvirt of such change and
> we will try our best to fix it.

How to best alert the layers above QEMU was one of the topic of the KVM
Forum 2018 BoF on deprecating stuff.  Minutes:

    Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>
    https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html

Relevant part:

* We need to communicate "you're using something that is deprecated".
  How?  Right now, we print a deprecation message.  Okay when humans use
  QEMU directly in a shell.  However, when QEMU sits at the bottom of a
  software stack, the message will likely end up in a log file that is
  effectively write-only.
 
  - The one way to get people read log files is crashing their
    application.  A command line option --future could make QEMU crash
    right after printing a deprecation message.  This could help with
    finding use of deprecated features in a testing environment.

  - A less destructive way to grab people's attention is to make things
    run really, really slow: have QEMU go to sleep for a while after
    printing a deprecation message.
    
  - We can also pass the buck to the next layer up: emit a QMP event.

    Sadly, by the time the next layer connects to QMP, plenty of stuff
    already happened.  We'd have to buffer deprecation events somehow.

    What would libvirt do with such an event?  Log it, taint the domain,
    emit a (libvirt) event to pass it on to the next layer up.

  - A completely different idea is to have a configuratin linter.  To
    support doing this at the libvirt level, QEMU could expose "is
    deprecated" in interface introspection.  Feels feasible for QMP,
    where we already have sufficiently expressive introspection.  For
    CLI, we'd first have to provide that (but we want that anyway).

  - We might also want to dispay deprecation messages in QEMU's GUI
    somehow, or on serial consoles.


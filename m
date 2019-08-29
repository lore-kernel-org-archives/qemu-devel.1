Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9445C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4C72070B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4C72070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3NZl-0005OO-Jm
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45358)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1i3NYR-0004kk-W2
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1i3NYQ-0004jw-KI
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:45:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52866)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>)
 id 1i3NYN-0004hs-Cd; Thu, 29 Aug 2019 12:45:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D582B8980E7;
 Thu, 29 Aug 2019 16:45:40 +0000 (UTC)
Received: from ptitpuce (ovpn-116-165.ams2.redhat.com [10.36.116.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE7F160C80;
 Thu, 29 Aug 2019 16:45:32 +0000 (UTC)
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
 <20190815114553.GQ300@andariel.pipo.sk> <87d0h6zfrt.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
In-reply-to: <87d0h6zfrt.fsf@dusky.pond.sub.org>
Date: Thu, 29 Aug 2019 18:45:29 +0200
Message-ID: <m1lfvbex92.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 29 Aug 2019 16:45:41 +0000 (UTC)
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
 libvir-list@redhat.com, mreitz@redhat.com, den@openvz.org,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster writes:

> Peter Krempa <pkrempa@redhat.com> writes:
>
[...]
>> From my experience users report non-fatal messages mostly only if it is
>> spamming the system log. One of instances are very unlikely to be
>> noticed.
>>
>> In my experience it's better to notify us in libvirt of such change and
>> we will try our best to fix it.
>
> How to best alert the layers above QEMU was one of the topic of the KVM
> Forum 2018 BoF on deprecating stuff.  Minutes:
>
>     Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>
>     https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html
>
> Relevant part:
>
> * We need to communicate "you're using something that is deprecated".
>   How?  Right now, we print a deprecation message.  Okay when humans use
>   QEMU directly in a shell.  However, when QEMU sits at the bottom of a
>   software stack, the message will likely end up in a log file that is
>   effectively write-only.
>
>   - The one way to get people read log files is crashing their
>     application.  A command line option --future could make QEMU crash
>     right after printing a deprecation message.  This could help with
>     finding use of deprecated features in a testing environment.
>
>   - A less destructive way to grab people's attention is to make things
>     run really, really slow: have QEMU go to sleep for a while after
>     printing a deprecation message.
>
>   - We can also pass the buck to the next layer up: emit a QMP event.
>
>     Sadly, by the time the next layer connects to QMP, plenty of stuff
>     already happened.  We'd have to buffer deprecation events somehow.
>
>     What would libvirt do with such an event?  Log it, taint the domain,
>     emit a (libvirt) event to pass it on to the next layer up.
>
>   - A completely different idea is to have a configuratin linter.  To
>     support doing this at the libvirt level, QEMU could expose "is
>     deprecated" in interface introspection.  Feels feasible for QMP,
>     where we already have sufficiently expressive introspection.  For
>     CLI, we'd first have to provide that (but we want that anyway).
>
>   - We might also want to dispay deprecation messages in QEMU's GUI
>     somehow, or on serial consoles.

Sorry for catching up late, this mail thread happened during my PTO.

I remember bringing up at the time [1] that the correct solution needs
to take into account usage models that vary from

- a workstation case, where displaying an error box is easy and
  convenient,

- to local headless VMs where system-level notification would do the job
  better, allowing us to leverage things like system-wide email notifications

- to large-scale collections of VMs managed by some layered product,
  where the correct reporting would be through something like Insights,
  i.e. you don't scan individual logs, you want something like "913 VMs
  are using deprecated X"

To me, that implies that we need to have a clear division of roles, with
a standard way to

a) produce the errors,
b) propagate them,
c) consume them (at least up to libvirt)

Notice that this work has already been done for "real" errors,
i.e. there is a real QAPI notion of "errors". AFAICT, warn_report does
not connect to it, though, it goes through error_vprintf which is really
just basic logging.

So would it make sense to:

1. Add a deprecation_report() alongside warn_report()?

2. Connect warn_report() and all the error_vprintf output to QAPI,
   e.g. using John's suggestion of adding the messages using some
   "warning" or "deprecated" tag?

3. Teach libvirt how to consume that new tag and pass it along?


[1] https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06131.html


--
Cheers,
Christophe de Dinechin (IRC c3d)


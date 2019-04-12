Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA4C10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76F7420651
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 08:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76F7420651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hErBr-00053B-Pe
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 04:05:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hErAs-0004X3-20
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hErAq-0008NV-12
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:04:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hErAg-0008FZ-C4; Fri, 12 Apr 2019 04:04:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 774C73088B80;
	Fri, 12 Apr 2019 08:04:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D5105D70E;
	Fri, 12 Apr 2019 08:04:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D89C51138648; Fri, 12 Apr 2019 10:04:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190410012413.31569-1-jsnow@redhat.com>
	<20190410012413.31569-3-jsnow@redhat.com>
	<87sguq2yn1.fsf@dusky.pond.sub.org>
	<004289a6-9df9-ae99-53e6-56e555709434@redhat.com>
	<87a7gxukmj.fsf@dusky.pond.sub.org>
	<01d9a861-cc2a-38a0-c471-cfefa9dbbf3b@redhat.com>
Date: Fri, 12 Apr 2019 10:04:18 +0200
In-Reply-To: <01d9a861-cc2a-38a0-c471-cfefa9dbbf3b@redhat.com> (John Snow's
	message of "Thu, 11 Apr 2019 16:02:24 -0400")
Message-ID: <8736mnr6nx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 08:04:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 2/3] pxtool: Add new qemu-img command
 info generation tool
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412080418.BRZ45ZC_c1eBy0dcjn1hbdTajwRJZNqI1RRsBWIMpH0@z>

John Snow <jsnow@redhat.com> writes:

> On 4/11/19 2:22 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
[...]
>>> I suspect that work *IS* something that might brush up against / should
>>> use (or extend) QAPI code.
>> 
>> Seems likely.
>> 
>>> Then, I'd like to find a way to split qemu-img.texi into sub-command
>>> files and find a way to source the same "informative text" for both:
>>>
>>> (1) The texi output, as per usual, and
>>> (2) qemu-img subcommand --help
>>>
>>> such that --help, when passed as an argument to the subcommand, prints
>>> out help only relevant to the subcommand instead, e.g.
>>>
>>> `qemu-img check --help`
>>>
>>> might print the "common options" section only as it relates to commands
>>> actually used by the check command, then prints the check section of the
>>> texi as formatted for terminals.
>>>
>>> This way, we can have manpages, html pages, and interactive help text
>>> all derived from the same semi-automated sources, always up to date and
>>> much easier to read/discover/parse by human eyeballs.
>>>
>>> That's what I'd like to accomplish, ultimately.
>>>
>>> For now, I think this RFC set is not harmful and won't bother anybody.
>>> It's definitely not worse than what we have now, fragility of removing
>>> @var{} tokens and all.
>> 
>> Makes sense.  I just hope we can avoid duplicating work.
>> 
>
> I'm not going to proceed any further than this RFC without us having a
> meeting to discuss the work. I'm willing to learn QAPI and do it a bit,
> it's a thread I'd rather like to pull, but I don't want to duplicate any
> work, no.

I think the path forward depends on just how itchy the thing is for you.

I do want to resume the work on CLI QAPIfication.  Whenever I think my
queue is about to reach a state where I can ignore y'all for the
uninterrupted time the CLI project needs, something else lands in my
queue.  Right now, Kevin wants the next QAPI project to be "features
flags", and he has v1 patches to back this up[*].  I have additional
uses for feature flags in mind, which I expect to require more patches.

> If that involves me reviewing patches when the tree opens, please CC me,
> and let's have a chat!

Yes, let's talk.

> In the meantime, what are your thoughts on patches 2-3 here?

I'll try to have a closer look.


[*] Which I still have to review, but when my queue goes out of control,
I enter batch mode for better throughput, sacrificing latency.


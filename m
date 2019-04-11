Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28214C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 06:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC2882082E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 06:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC2882082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hET7D-0007U3-5a
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 02:23:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hET6M-00073Q-TV
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hET6L-0004yd-Mj
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 02:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hET6I-0004xZ-Qv; Thu, 11 Apr 2019 02:22:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3E0230832CD;
	Thu, 11 Apr 2019 06:22:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D3795D9CD;
	Thu, 11 Apr 2019 06:22:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 050D41138648; Thu, 11 Apr 2019 08:22:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190410012413.31569-1-jsnow@redhat.com>
	<20190410012413.31569-3-jsnow@redhat.com>
	<87sguq2yn1.fsf@dusky.pond.sub.org>
	<004289a6-9df9-ae99-53e6-56e555709434@redhat.com>
Date: Thu, 11 Apr 2019 08:22:12 +0200
In-Reply-To: <004289a6-9df9-ae99-53e6-56e555709434@redhat.com> (John Snow's
	message of "Wed, 10 Apr 2019 13:55:33 -0400")
Message-ID: <87a7gxukmj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Thu, 11 Apr 2019 06:22:16 +0000 (UTC)
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
Message-ID: <20190411062212.NWg9ii3IeFaOa4vNY9Bq83GpJlvvxypQfFkmIu_SlyM@z>

John Snow <jsnow@redhat.com> writes:

> On 4/10/19 1:54 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> Presently we use hxtool and a .hx format to generate a few things like
>>> the qemu_img subcommand dispatch table, the qemu_img help() display output,
>>> and a help output in qemu-img.texi.
>>>
>>> Unfortunately, this means that this information is duplicated in at least
>>> three places:
>>>
>>> (1) in qemu-img-cmds.hx as a human readable string
>>> (2) in qemu-img-cmds.hx as a texi string
>>> (3) in qemu-img.texi again, as a texi string
>>>
>>> We can do a little better, though: all of these sources can be generated
>>> from a single json file. Add a new small tool ("pxtool") that can do this.
>>>
>>> This tool can at least handle generating (1) and (2) from the same source
>>> without needing to reduplicate that information. Deduplicating (3) happens
>>> in the next patch.
>>>
>>> Notes:
>>>  - The json format was chosen to be very "stupid", and the command line
>>>    documentation is being kept one-per-line to make future diffs easier
>>>    to read.
>>>  - It's easy enough to generate the human-readable output from the texi
>>>    output by removing '@var{foo}' with 'foo'.
>>>  - The qemu-img command dispatch always calls img_cmdname, so we don't
>>>    need to store this information separately, either.
>>>  - The need for DEF() macros could be removed as well, but I left it in
>>>    to create a minimally disruptive patch.
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>> 
>> We got just five .hx:
>> 
>>     qemu-img.cmds.hx            killed off by this patch
>>     qemu-options.hx             CLI QAPIfication should kill this off
>>     hw/audio/pl041.hx           misnamed, not actually food for hxtool
>>     hmp-commands.hx             no exit strategy
>>     hmp-commands-info.hx            for these two, yet
>> 
>> CLI QAPIfication got stuck in the back-burner, and as long as that's the
>> case, it's not an alternative to your patches.
>> 
>
> Good to know. I figure that at least while we wait on something more
> comprehensive there's no real short term harm in tidying up.
>
> Something I'd really like to do is define a python/json-esque
> configuration file that allows you to specify some "common options" that
> are shared between all of the sub-commands, and then define each command
> in terms of both which common options it possesses, and then any local
> command-specific options it has.
>
> (Why the common options design? So that argument names and command
> options can be encouraged to be identical and identically documented
> between all subcommands that use them.)

In QAPI, you'd define a common base type.

> Then, from the configuration file, generate all of the necessary C
> parsers (I have a protoype for this, it's not difficult to do in at
> least the basic case) that can return boxed command arguments, and then
> also generate the help strings from that metadata.

With QAPI, we generate reference documentation from the doc comments.

My RFC patches for command line QAPIfication generate a CLI parser using
getopt_long_only().

They keep help texts in the QAPI schema.  Generating their formal part
from the type definition should be feasible.  Generating it without
regressing readability might turn out to be non-trivial.

My patches generate *one* CLI parser.  We have many, and some of them
want to share types.  There's more than one way to skin this cat, but
it'll have to be skinned.

> I suspect that work *IS* something that might brush up against / should
> use (or extend) QAPI code.

Seems likely.

> Then, I'd like to find a way to split qemu-img.texi into sub-command
> files and find a way to source the same "informative text" for both:
>
> (1) The texi output, as per usual, and
> (2) qemu-img subcommand --help
>
> such that --help, when passed as an argument to the subcommand, prints
> out help only relevant to the subcommand instead, e.g.
>
> `qemu-img check --help`
>
> might print the "common options" section only as it relates to commands
> actually used by the check command, then prints the check section of the
> texi as formatted for terminals.
>
> This way, we can have manpages, html pages, and interactive help text
> all derived from the same semi-automated sources, always up to date and
> much easier to read/discover/parse by human eyeballs.
>
> That's what I'd like to accomplish, ultimately.
>
> For now, I think this RFC set is not harmful and won't bother anybody.
> It's definitely not worse than what we have now, fragility of removing
> @var{} tokens and all.

Makes sense.  I just hope we can avoid duplicating work.


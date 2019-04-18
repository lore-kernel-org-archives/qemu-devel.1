Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A21C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9362214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 11:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9362214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39556 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH54y-0001dZ-7g
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 07:19:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hH52h-0008Mr-NL
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hH4oj-0002zZ-L7
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:03:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hH4oj-0002zG-Cc
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:02:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6A7A811A9;
	Thu, 18 Apr 2019 11:02:56 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-179.rdu2.redhat.com
	[10.10.120.179])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8EEB25D9C5;
	Thu, 18 Apr 2019 11:02:55 +0000 (UTC)
To: Joachim Durchholz <jo@durchholz.org>, qemu-devel@nongnu.org
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
	<dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
	<20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
	<00f0ada2-a68b-2264-ab72-f49fe7d654e7@durchholz.org>
	<20190417071012.fxedabu3makmoyuz@sirius.home.kraxel.org>
	<993002d4-28dd-00f0-e8c1-7b0d9ab2de12@durchholz.org>
	<4ce336d0-6651-286f-07ee-3a5b3236309a@redhat.com>
	<55326d4f-d7a9-cf38-20ff-846d7d3d64fd@durchholz.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <388b90ee-cb50-0a2d-3675-e7e8b37adcd4@redhat.com>
Date: Thu, 18 Apr 2019 13:02:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <55326d4f-d7a9-cf38-20ff-846d7d3d64fd@durchholz.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 18 Apr 2019 11:02:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] curses.c: "We need a terminal output" ?
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418110254.XDgrRxa5u5J9b_wuUMoHX07mfRRxFPJ0qW4TRNQVpJE@z>

On 04/18/19 07:02, Joachim Durchholz wrote:
> Am 17.04.19 um 20:27 schrieb Laszlo Ersek:
>> So, let's look at your original question again (which was not a problem
>> statement):
> 
> So you need an explicit problem statement to know that somebody might
> have a problem?

You're on a technical mailing list. An explicit problem statement is
instrumental for subscribers to understand the particulars of the
problem. "Somebody might have a problem" is a yes/no question and is
basically devoid of information.

>>> what's the reasoning behind "We need a terminal output" in curses.c?
>>
>> The reasoning is that "curses.c" is a QEMU display backend written in
>> terms of the Curses [XCURSES] interface specification, and that
>> interface specification is inherently based on terminals, as defined by
>> the General Terminal Interface of the Single Unix Specification.
> 
> Sure.
> 
>> If you tell us what you want to achieve in the end (i.e. you state the
>> problem),
> 
> I described three use cases. I mentioned which of them was mine.
> Problem statement: my use case doesn't work. D'oh.

I've now re-read your original post again. I certainly wouldn't call it
"d'oh".

Protip: it's always best to insult the people that try to help you. The
more abrasive you are the more willingly they will spend their
nonexistent free time to help you. This is how a development mailing
list works. /s

>> Let me speculate a bit. You mentioned wanting to connect "ui/curses.c"
>> to a pipe, possibly to transfer the output elsewhere. This is a common
>> use case -- it's what terminal emulators such as "xterm" do, also what
>> "ssh" does (when you log in interactively with it). "screen" and "tmux"
>> are other programs in this class.
>>
>> The way they all work is, they set up a pseudo-terminal (pty). The pty
>> has a master end and a slave end.
> 
> I know expect, and yeah it works. It's just that TCL is too old-school
> to cleanly handle all edge cases, and I don't have the time budget to
> really learn all the ins and outs of TCL.
> pexpect doesn't work, because it would insist on line buffering (try
> doing a login or responding to a prompt).

https://pexpect.readthedocs.io/en/stable/FAQ.html

> Q: Can I do screen scraping with this thing?
>
> A: That depends. If your application just does line-oriented output
> then this is easy. If a program emits many terminal sequences, from
> video attributes to screen addressing, such as programs using curses,
> then it may become very difficult to ascertain what text is displayed
> on a screen.
>
> We suggest using the pyte library to screen-scrape. The module
> pexpect.ANSI released with previous versions of pexpect is now marked
> deprecated and may be removed in the future.

Have you tried pyte <https://pyte.readthedocs.io/en/latest/>?

On 04/18/19 07:02, Joachim Durchholz wrote:
> expectit doesn't work, because it simply opens a pipe. It's otherwise
> the best-maintained, best-structured API. Being Java, it's a bit
> difficult to interface to C, besides opening ptys is pretty nonportable
> so it would have been a biggish project to give the maintainer a patch
> that is useful to him.
> 
> So the workaround is to use expect anyway. So happy :-(
> 
>> (pexpect)
>> Then you can read the master-end (pexpect should let you do that as
>> well) -- the master-end will indeed read similarly to pipe.
> 
> Sure, it fails due to line buffering. Can't wait for the login prompt
> because it isn't sending an eoln.
> 
>> Just be
>> aware that all the terminal output goo, such as cursor positioning,
>> color change sequences, beeps, screen resolution changes, etc, will show
>> up as binary garbage in the stream.
> 
> It's just escape sequences, and while they're a bit of a pain, they can
> be filtered out.
> If TCL were a sane language, I could do that with a bit of code, but it
> isn't, so I'm doing that mentally - it's a pain, but it works.
> 
> 
> I'm still wondering why there's such a stiff opposition to giving that
> with qemu.

Because "ui/curses.c" is a display backend written on top of the Curses
API, and that API was *designed* (and so QEMU's display backend was
*designed*) for use on a terminal. That's why the isatty() call is
there, and has been there ever since the introduction of the curses
display backend (commit 4d3b6f6e1265, "Add an ncurses UI.", 2008-02-10).

> Note that I do agree that it's not what qemu should do by default,
> switching that check off should be an option.

Yes, it's also an "option" to ride a bycicle on a busy street at dusk,
without a visibility vest, a helmet, and bike lights. The bike will
still roll, steer and brake.

> I just never got around to making that suggestion because Gerd was so
> insistent on brushing the use cases aside.

Removing the isatty() check, conditionally or unconditionally, is a
suggestion that is counter to the design & purpose of "ui/curses.c", in
my opinion. To me it's a suggestion that is definitely inferior to using
a terminal emulator that works for your purpose.

Adding a different display backend to QEMU, such that it isn't based on
Curses but on a pipe, might make sense. I'm not sure.

Thanks
Laszlo


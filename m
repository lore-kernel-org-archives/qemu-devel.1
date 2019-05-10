Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59CFC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F8020881
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:53:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79F8020881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45479 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7q7-0004Ds-Nh
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:53:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP7oc-0003HY-KG
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hP7oX-0007H8-63
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:52:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hP7oW-0007Fb-UW
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:52:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1059181F19;
	Fri, 10 May 2019 15:52:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A07E61001DF3;
	Fri, 10 May 2019 15:51:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 2648A11385E4; Fri, 10 May 2019 17:51:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Ernest Esene <eroken1@gmail.com>
References: <20190504181119.GA3317@erokenlabserver>
	<87ftpqb25m.fsf@dusky.pond.sub.org>
	<20190510141945.GA1927@erokenlabserver>
Date: Fri, 10 May 2019 17:51:53 +0200
In-Reply-To: <20190510141945.GA1927@erokenlabserver> (Ernest Esene's message
	of "Fri, 10 May 2019 15:19:45 +0100")
Message-ID: <875zqil33a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 10 May 2019 15:52:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] chardev/char-i2c: Implement Linux I2C
 character device
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
	qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ernest Esene <eroken1@gmail.com> writes:

> On Tue, May 07, 2019 at 07:33:09PM +0200, Markus Armbruster wrote:
>> Ernest Esene <eroken1@gmail.com> writes:
>> 
>> > Add support for Linux I2C character device for I2C device passthrough
>> > For example:
>> > -chardev linux-i2c,address=0x46,path=/dev/i2c-N,id=i2c-chardev
>> >
>> > Signed-off-by: Ernest Esene <eroken1@gmail.com>
>> 
>> Could you explain briefly how passing through a host's I2C device can be
>> useful?
> QEMU supports emulation of I2C devices in software but currently can't
> passthrough to real I2C devices. This feature is needed by developers
> using QEMU for writing and testing software for I2C devices.

Please work that into your commit message.  Remember, you commit message
is also your patch's sales pitch.

>> Any particular reason not to use GPLv2+?
> No, I used the wrong script. I'll update the licence.

Thanks!

>> > +
>> > +        if (addr > CHR_I2C_ADDR_7BIT_MAX) {
>> > +            /*
>> > +             * TODO: check if adapter support 10-bit addr
>> > +             * I2C_FUNC_10BIT_ADDR
>> > +             */
>> 
>> What's the impact of not having done this TODO?
> Not all I2C adapters supports 10-bit address.
>> Should it be mentioned in the commit message?
> I have handled it already.

Cool.

>> > +        return;
>> > +    }
>> > +    qemu_set_block(fd);
>> 
>> Sure we want *blocking* I/O?  No other character device does.
> No, it is a mistake.
>> 
>> > +    qemu_chr_open_fd(chr, fd, fd);
>> > +    addr = (void *) (long) i2c->address;
>> 
>> 
>> Why not make option "addr" QEMU_OPT_NUMBER and use
>> qemu_opt_get_number()?
> I never knew QEMU_OPT_NUMBER can handle inputs such: "0x08 and 8",
> appropriately.
>> 
>> Missing: documentation update for qemu-options.hx.
> I don't know much about this format (.hx), I'll be happy to have any
> useful documentation on this.

I don't think we have any documentation on it, let alone useful
documentation.

Here's what you need to do there for your new chardev backend type,
using your voodoo coding skills.

Find this line:
DEFHEADING(Character device options:)

This is where option -chardev is defined and documented.

Now pick an existing chardev backend.  Picking one that's vaguely
similar to yours is best.  Let's pick "serial", because it also passes
through a host device.

First occurence is this:

    #ifdef _WIN32
        "-chardev console,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
        "-chardev serial,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
    #else
        "-chardev pty,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
        "-chardev stdio,id=id[,mux=on|off][,signal=on|off][,logfile=PATH][,logappend=on|off]\n"
    #endif

You see _WIN32, and immediately skip to the next one:

    #if defined(__linux__) || defined(__sun__) || defined(__FreeBSD__) \
            || defined(__NetBSD__) || defined(__OpenBSD__) || defined(__DragonFly__)
        "-chardev serial,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
        "-chardev tty,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
    #endif


Using your vodoo coding skills, you add

    #ifdef CONFIG_POSIX
        "-chardev i2c,id=id,path=path,address=address[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
    #endif

CONFIG_POSIX, because that's what you used in Makefile.objs.  Your
commit message says "Linux I2C character device", so maybe you should
use CONFIG_LINUX instead of CONFIG_POSIX throughout, but what do I know.

The next occurence is

    The general form of a character device option is:
    @table @option
    @item -chardev @var{backend},id=@var{id}[,mux=on|off][,@var{options}]
    @findex -chardev
    Backend is one of:
    @option{null},
    @option{socket},
    @option{udp},
    @option{msmouse},
    @option{vc},
    @option{ringbuf},
    @option{file},
    @option{pipe},
    @option{console},
    @option{serial},

So you add

    @option{i2c},

I think you get the idea.  If not, the time-honored way to get more help
is to post a patch that's not quite right ;)


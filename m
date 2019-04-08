Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7BAC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CC12084C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CC12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56917 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDYn6-0001Dz-Ko
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 14:14:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1hDYmI-0000tH-Dm
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:13:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1hDYmG-0007LN-Ci
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:13:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>)
	id 1hDYmC-0007Hz-LE; Mon, 08 Apr 2019 14:13:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C85DFC13070F;
	Mon,  8 Apr 2019 18:13:46 +0000 (UTC)
Received: from localhost (ovpn-116-243.ams2.redhat.com [10.36.116.243])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 48216608A4;
	Mon,  8 Apr 2019 18:13:45 +0000 (UTC)
Date: Mon, 8 Apr 2019 19:13:45 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190408181345.GJ3926@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-3-armbru@redhat.com>
	<20190408172202.GH3926@redhat.com>
	<87mul0jrqz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <87mul0jrqz.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Mon, 08 Apr 2019 18:13:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Whither qemu's ssh driver?
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, ptoscano@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408181345.cAEsyntHxN7fGIobVnYOe5VBK4624-7Kx21IQGhMmTY@z>

On Mon, Apr 08, 2019 at 08:07:00PM +0200, Markus Armbruster wrote:
> "Richard W.M. Jones" <rjones@redhat.com> writes:
> 
> > I don't know much about this patch which looks like internal qemu
> > rearrangements so I guess fine.  However I do have a few things to say
> > about the ssh driver ...
> >
> > As you know I wrote this a few years ago, and it uses libssh2.
> > libssh2 has not evolved as quickly as we'd like and it may be better
> > to use libssh instead -- despite the names, these are two separate and
> > unrelated libraries.  libssh supports a wider range of SSH encryption
> > and has more features.  It's generally more likely to work against a
> > random SSH server.  It has also been through the FIPS process.  Indeed
> > Red Hat made the decision to switch exclusively to libssh in RHEL 8,
> > if that carries any weight.
> >
> > Pino posted a libssh2 -> libssh conversion patch a while back, but it
> > has been somewhat stuck in review.  If I recall the latest concern was
> > whether it performs as well as the libssh2 version.
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07267.html
> 
> I doubt we'd need "as well as" for this driver.  But Max observed a
> factor of five with v4.  Pino reported improvements with v5 ("no more
> than 200%"), and some more with libssh master instead of 0.7, but didn't
> quantify those.  To make progress, we need a rebased patch with actual
> performance numbers, I think.
> 
> > In the meantime I added libssh support to nbdkit.  nbdkit can be used
> > as a complete replacement for qemu's ssh driver.
> >
> >   nbdkit ssh host=foo.example.com disk.img -U tmpdirXXXXXX/sock
> >   qemu -hda nbd:unix:tmpdirXXXXXX/sock
> >
> > In fact it's somewhat superior (IMHO) because all of the tricky code
> > handling libssh runs outside qemu in a separate process, improving
> > isolation and potentially allowing separate, restrictive security
> > policies to be applied.  For example it would no longer be necessary
> > to give qemu permission to connect to remote SSH servers.
> 
> Good point.
> 
> > Could we make this really smooth somehow?  nbdkit has a concept
> > [https://www.mankier.com/1/nbdkit-captive] where we make it easy to
> > manage external commands owned by nbdkit.  Is there an equivalent
> > feature of qemu where:
> >
> >   qemu -object exec,id=nbd1,cmd='nbdkit -f -U $sock ssh ...' \
> >        -drive file.driver=nbd,file.socket=nbd1
> >
> > would run the command but also allocate a socket and kill the
> > subcommand on exit (of qemu)?
> 
> I'm not aware of general infrastructure to run helper processes.  But
> I'm sure we could come up with something.
> 
> > Basically I'm trying to think about how to make this a reality:
> >
> >   https://rwmj.files.wordpress.com/2018/10/drawing2-svg.png
> 
> Looks like you're also targeting curl.c's drivers.  Any others?

As you know I wrote a read-only version of vvfat so it could be
deprecated in qemu.  It doesn't do the vvfat write madness however.

While there are other interesting plugins for nbdkit, we are steering
clear of needlessly duplicating qemu block functionality.  There would
have to be a reason to do it, and I think the reasons are clear enough
for ssh, curl and vvfat.

> Got a backward compatibility story other than "let's deprecate these
> drivers"?

That's if we do deprecate them in qemu at all.  We can have both if
people would prefer that.  If not I suppose we could have a
replacement stub driver which would run nbdkit.  It adds a dependency,
but nbdkit is intended to have very minimal deps.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-df lists disk usage of guests without needing to install any
software inside the virtual machine.  Supports Linux and Windows.
http://people.redhat.com/~rjones/virt-df/


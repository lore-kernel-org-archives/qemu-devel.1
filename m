Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BFBC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CD02187F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 12:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAw6XPCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CD02187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSgXG-000846-Pb
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 07:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iSgVb-0006x4-Vq
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iSgVY-0005ar-To
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:03:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48296
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iSgVX-0005YN-Nm
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 07:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573128201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+xMetsqLqc0P8I0vTNNyoLFwb2dFt9wDRoBbpxx0Nk=;
 b=XAw6XPCkTsbvGlXDFN7XSzmjcbnlEN2bdFNrM7Ge0OLUNILxREZjscz5RFbPVWHt+TeHcO
 zYxZmmHOasVONEfVkCAhEwUuiSCux0DM1bvx0++sPAg4FInmL1Ubkreym+IWx5gtIml6z/
 J6DnqhtLDfXuoNN3+/EnRI5tJK7UYZ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-qBu75D1XNJOALN8s2Z0dyw-1; Thu, 07 Nov 2019 07:03:19 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C650F800C61;
 Thu,  7 Nov 2019 12:03:18 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DF9F19C6A;
 Thu,  7 Nov 2019 12:03:17 +0000 (UTC)
Date: Thu, 7 Nov 2019 13:03:15 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 00/18] Add qemu-storage-daemon
Message-ID: <20191107120315.GC5007@linux.fritz.box>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191107103357.GB120292@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191107103357.GB120292@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: qBu75D1XNJOALN8s2Z0dyw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: mreitz@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.11.2019 um 11:33 hat Daniel P. Berrang=E9 geschrieben:
> On Thu, Oct 17, 2019 at 03:01:46PM +0200, Kevin Wolf wrote:
> > 2. I'm not completely sure if the command line syntax is the final
> >    version that we want to support long-term. Many options directly use
> >    QAPI visitors (--blockdev, --export, --nbd-server) and should be
> >    fine. However, others use QemuOpts (--chardev, --monitor, --object).
> >=20
> >    This is the same as in the system emulator, so we wouldn't be adding
> >    a new problem, but as there was talk about QAPIfying the command
> >    line, and I wouldn't want later syntax changes or adding lots of
> >    compatibility code to a new tool, I thought we should probably
> >    discuss whether QAPIfying from the start would be an option.
>=20
> I think that following what the QEMU emulators currently do for
> CLI args should be an explicit anti-goal, because we know that it is
> a long standing source of pain.  Fixing it in the emulator binaries
> is hard due to backward compatibility, but for this new binary we
> have a clean slate.
>=20
> This feels like a good opportunity to implement & demonstrate what
> we think QEMU configuration ought to look like. Work done for this
> in the qemu-storage-daemon may well help us understand how we'll
> be able to move the QEMU emulators into a new scheme later.

It might be, which is why I'm asking. Now that the storage daemon has
missed 4.2, we have a little more time to decide what the command line
should look like in detail.

However, I don't think this is something that should delay the storage
daemon until after 5.0.

> My personal wish would be to have no use of QemuOpts at all.
>=20
> Use GOptionContext *only* for parsing command line arguments
> related to execution of the daemon - ie things like --help,
> --version, --daemon, --pid-file.

I really don't believe that the solution for having too much variety in
option parsing is adding in yet another type. GOptionContext is not
something I'm considering at the moment.

But it's a getopt() replacement, not something that could actually parse
the more complex options, so it's a separate question anyway. If we ever
want to use it, we can replace getopt() in all binaries at once.

> The use a "--config /path/to/json/file" arg to point to the config
> file for everything else using QAPI schema to describe it fully.

If this implies that the storage daemon can only do useful things if you
specify a config file, I disagree.

I agree that it's not really nice if you can't use a config file to
specify a lengthy configuration and that supporting one would be good.

But it is at least equally unfriendly to require a config file for
simple configurations where using command line arguments is easily
possible.

> When loading the config file, things should be created in order
> in which they are specified. ie don't try and group things,
> otherwise we end up back with the horrific hacks for objects
> where some are created early & some late.

Yes. This is how the storage daemon command line works, too.

I think Markus already had some patches for command line QAPIfication
that were incomplete at least for the system emulator. It might be
easier to make it feature complete for the storage daemon because it
supports much less problematic options. Maybe he can post a useful
subset (if it's too much work to clean up the full thing right now) and
we can work from there.

The one that I expect to be a bit tricky to be QAPIfied is --object.

> For an ambitious stretch goal, I think we should seriously consider
> whether our use of chardevs is appropriate in all cases that exist,
> and whether we can avoid the trap of over-using chardev in the new
> storage daemon since it is a clean slate in terms of user facing
> CLI config.
>=20
> chardevs are designed for & reasonably well suited to attaching to
> devices like serial ports, parallel ports, etc. You have a 1:1
> remote:local peer relationship. The transport is a dumb byte
> stream, nothing special needed on top & the user can cope with
> any type of chardev.
>=20
> Many cases where we've used chardevs as a backend in QEMU are a
> poor fit. We just used chardevs as an "easy" way to configure a
> UNIX or TCP socket from the CLI, and don't care about, nor work
> with, any othuer chardev backends. As a result of this misuse
> we've had to put in an increasing number of hacks in the chardev
> code to deal with fact that callers want to know about  & use
> socket semantics. eg FD passing, the chardev reconnection polling
> code.
>=20
> The monitor is a prime example of a bad fit - it would be better
> suited by simply referencing a SocketAddress QAPI type, instead
> of having the chardev indirection. It would then directly use
> the QIOChannelSocket APIs and avoid the inconvenient chardev
> abstractions which are a source of complexity & instability for
> no net gain.  vhostuser is another prime example, responsible
> for much of the complexity & bugs recently added to chardevs
> to expose socket semantics
>=20
>=20
> This is a long winded way of saying that we should consider what
> syntax we expose for the monitor socket configuration with the
> new daemon. Even if the internal code still uses a chardev for
> the forseeable future, we have the option to hide this from the
> user facing configuration. Let the user specify a SocketAddress,
> which we use to secretly instantiate a chardev. Eventually we can
> convert the monitor code to stop using a chardev internally too,
> with a suitable deprecation period for main QEMU binarijes.

The monitor is actually the prime example for chardev backends like
stdio or vc. I'm using them all the time and they aren't covered by
SocketAddress, so I'm afraid SocketAddress alone is not an option.

In any case, the goal of the storage daemon code is to be as boring as
possible. It should just be a thin wrapper around existing code that
glues the command line, monitor and various backends together.

So any change to the usage of chardevs (that is more than a few lines of
wrapper code) would probably have to be made in the system emulator
first, otherwise we'd end up duplicating a lot of code for the storage
daemon instead of just reusing it. I guess using SocketAddress for the
storage daemon and internall creating a chardev-socket would be possible
with a few lines if that covered stdio - but it doesn't.

Kevin



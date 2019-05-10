Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDCCC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 12:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD3120850
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 12:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD3120850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP4Nm-0005yR-5y
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 08:12:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP4My-00058I-KE
	for qemu-devel@nongnu.org; Fri, 10 May 2019 08:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hP4Mx-0003sj-Dx
	for qemu-devel@nongnu.org; Fri, 10 May 2019 08:11:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hP4Mx-0003s5-3I
	for qemu-devel@nongnu.org; Fri, 10 May 2019 08:11:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C921307D852;
	Fri, 10 May 2019 12:11:17 +0000 (UTC)
Received: from redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 54DF65D6A9;
	Fri, 10 May 2019 12:11:13 +0000 (UTC)
Date: Fri, 10 May 2019 13:11:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190510121110.GJ7671@redhat.com>
References: <20190510081526.15507-1-kchamart@redhat.com>
	<874l62sei2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874l62sei2.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Fri, 10 May 2019 12:11:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] VirtIO-RNG: Update default entropy
 source to `/dev/urandom`
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, amit@kernel.org, rjones@redhat.com,
	stefanha@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 10, 2019 at 02:03:33PM +0200, Markus Armbruster wrote:
> Kashyap Chamarthy <kchamart@redhat.com> writes:
> 
> > When QEMU exposes a VirtIO-RNG device to the guest, that device needs a
> > source of entropy, and that source needs to be "non-blocking", like
> > `/dev/urandom`.  However, currently QEMU defaults to the problematic
> > `/dev/random`, which is "blocking" (as in, it waits until sufficient
> > entropy is available).
> >
> > Why prefer `/dev/urandom` over `/dev/random`?
> > ---------------------------------------------
> >
> > The man pages of urandom(4) and random(4) state:
> >     "The /dev/random device is a legacy interface which dates back to a
> >     time where the cryptographic primitives used in the implementation
> >     of /dev/urandom were not widely trusted.  It will return random
> >     bytes only within the estimated number of bits of fresh noise in the
> >     entropy pool, blocking if necessary.  /dev/random is suitable for
> >     applications that need high quality randomness, and can afford
> >     indeterminate delays."
> >
> > Further, the "Usage" section of the said man pages state:
> >
> >     "The /dev/random interface is considered a legacy interface, and
> >     /dev/urandom is preferred and sufficient in all use cases, with the
> >     exception of applications which require randomness during early boot
> >     time; for these applications, getrandom(2) must be used instead,
> >     because it will block until the entropy pool is initialized.
> >
> >     "If a seed file is saved across reboots as recommended below (all
> >     major Linux distributions have done this since 2000 at least), the
> >     output is cryptographically secure against attackers without local
> >     root access as soon as it is reloaded in the boot sequence, and
> >     perfectly adequate for network encryption session keys.  Since reads
> >     from /dev/random may block, users will usually want to open it in
> >     nonblocking mode (or perform a read with timeout), and provide some
> >     sort of user notification if the desired entropy is not immediately
> >     available."
> >
> > And refer to random(7) for a comparison of `/dev/random` and
> > `/dev/urandom`.
> 
> This is Linux.  What about other supported POSIX[*] hosts?  If any such
> host has /dev/random that works here, but not /dev/urandom, we regress.

It exists on OS-X, FreeBSD, DragonFlyBSD, NetBSD and OpenBSD, which covers
all the non-Linux platforms we explicitly support, aside from Windows.

On Windows /dev/random doesn't work either so we don't regress. This is
actually another argument in favour of using the newly proposed rng-builtin
by default, as that will work on Windows.

> *If* there's an actual regression risk: a simple & stupid way to reduce
> it risk could be falling back to /dev/random when opening /dev/urandom
> fails.  Perhaps only when it fails with ENOENT.

Unless I missed something, I think we'll be ok without the fallback
though I wouldn't object to having a fallback as you describe.

> Possible implementation: instead of setting a default filename in
> rng_random_init(), change rng_random_opened() to try /dev/urandom, then
> /dev/random when filename is still null.
> 
> Aside: "opened" sounds like a predicate.  Goes back to commit
> a9b7b2ad7b0.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


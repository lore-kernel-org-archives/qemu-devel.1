Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AD7C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 16:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F6620773
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 16:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rffJvgFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F6620773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUBMf-0005jZ-TG
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 12:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luto@kernel.org>) id 1kUBK6-0003Ha-Ig
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 12:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luto@kernel.org>) id 1kUBK4-000694-IY
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 12:14:18 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B06492223F
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603037655;
 bh=QkAuJOFzVf0Wwxo6H++VdX8xdeoi48QFNUPVWESxEeY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rffJvgFw8irrIGZAcek+x0zg/gt4Gi/MwUN3UHhn0YsqDBUlTjD/VMQRp4txU3C+R
 9evpOGeEmginVuSv16P6vdFf9xqJoNVP8Pi/M625Nhhn3oq9KVeHXUUkp59uv/Qj1A
 1hXbIGy2bo1vH3hofY0qSAhRGjG62+Ze93DId1hg=
Received: by mail-wm1-f49.google.com with SMTP id f21so7959923wml.3
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 09:14:14 -0700 (PDT)
X-Gm-Message-State: AOAM530YQAWsGUFXWaD0Qu0l3XT/phdstyJ/J07mdGAGTVwGrKR823GZ
 tNFJ31wrVsmgyXKDxC2KEPk6JKEyAZzFwkaJGqERWw==
X-Google-Smtp-Source: ABdhPJzAXECqLOcgtU/8DSPTTXSAjc3cG+qUKXcQQZ/UMNZ2TU+94ycOvtKGPaT5rUWM66K+feNpmT6EZJqfh4RkIck=
X-Received: by 2002:a05:600c:2256:: with SMTP id
 a22mr13760040wmm.138.1603037652395; 
 Sun, 18 Oct 2020 09:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
 <20201018114625-mutt-send-email-mst@kernel.org>
 <CALCETrXBJZnKXo2QLKVWSgAhSMdwEVHeut6pRw4P92CR_5A-fQ@mail.gmail.com>
 <20201018115524-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201018115524-mutt-send-email-mst@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 18 Oct 2020 09:14:00 -0700
X-Gmail-Original-Message-ID: <CALCETrUeRAhmEFR6EFXz8HzDYd2doZ2TMyZmu1pU_-yAPA6KDw@mail.gmail.com>
Message-ID: <CALCETrUeRAhmEFR6EFXz8HzDYd2doZ2TMyZmu1pU_-yAPA6KDw@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=198.145.29.99; envelope-from=luto@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/18 11:54:50
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, KVM list <kvm@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 "Singh, Balbir" <sblbir@amazon.com>, bonzini@gnu.org, "Graf \(AWS\),
 Alexander" <graf@amazon.de>, Michal Hocko <mhocko@kernel.org>,
 Jann Horn <jannh@google.com>, oridgar@gmail.com, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>,
 Colm MacCarthaigh <colmmacc@amazon.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, Willy Tarreau <w@1wt.eu>, "Woodhouse,
 David" <dwmw@amazon.co.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 18, 2020 at 8:59 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Oct 18, 2020 at 08:54:36AM -0700, Andy Lutomirski wrote:
> > On Sun, Oct 18, 2020 at 8:52 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Sat, Oct 17, 2020 at 03:24:08PM +0200, Jason A. Donenfeld wrote:
> > > > 4c. The guest kernel maintains an array of physical addresses that are
> > > > MADV_WIPEONFORK. The hypervisor knows about this array and its
> > > > location through whatever protocol, and before resuming a
> > > > moved/snapshotted/duplicated VM, it takes the responsibility for
> > > > memzeroing this memory. The huge pro here would be that this
> > > > eliminates all races, and reduces complexity quite a bit, because the
> > > > hypervisor can perfectly synchronize its bringup (and SMP bringup)
> > > > with this, and it can even optimize things like on-disk memory
> > > > snapshots to simply not write out those pages to disk.
> > > >
> > > > A 4c-like approach seems like it'd be a lot of bang for the buck -- we
> > > > reuse the existing mechanism (MADV_WIPEONFORK), so there's no new
> > > > userspace API to deal with, and it'd be race free, and eliminate a lot
> > > > of kernel complexity.
> > >
> > > Clearly this has a chance to break applications, right?
> > > If there's an app that uses this as a non-system-calls way
> > > to find out whether there was a fork, it will break
> > > when wipe triggers without a fork ...
> > > For example, imagine:
> > >
> > > MADV_WIPEONFORK
> > > copy secret data to MADV_DONTFORK
> > > fork
> > >
> > >
> > > used to work, with this change it gets 0s instead of the secret data.
> > >
> > >
> > > I am also not sure it's wise to expose each guest process
> > > to the hypervisor like this. E.g. each process needs a
> > > guest physical address of its own then. This is a finite resource.
> > >
> > >
> > > The mmap interface proposed here is somewhat baroque, but it is
> > > certainly simple to implement ...
> >
> > Wipe of fork/vmgenid/whatever could end up being much more problematic
> > than it naively appears -- it could be wiped in the middle of a read.
> > Either the API needs to handle this cleanly, or we need something more
> > aggressive like signal-on-fork.
> >
> > --Andy
>
>
> Right, it's not on fork, it's actually when process is snapshotted.
>
> If we assume it's CRIU we care about, then I
> wonder what's wrong with something like
> MADV_CHANGEONPTRACE_SEIZE
> and basically say it's X bytes which change the value...

I feel like we may be approaching this from the wrong end.  Rather
than saying "what data structure can the kernel expose that might
plausibly be useful", how about we try identifying some specific
userspace needs and see what a good solution could look like.  I can
identify two major cryptographic use cases:

1. A userspace RNG.  The API exposed by the userspace end is a
function that generates random numbers.  The userspace code in turn
wants to know some things from the kernel: it wants some
best-quality-available random seed data from the kernel (and possibly
an indication of how good it is) as well as an indication of whether
the userspace memory may have been cloned or rolled back, or, failing
that, an indication of whether a reseed is needed.  Userspace could
implement a wide variety of algorithms on top depending on its goals
and compliance requirements, but the end goal is for the userspace
part to be very, very fast.

2. A userspace crypto stack that wants to avoid shooting itself in the
foot due to inadvertently doing the same thing twice.  For example, an
AES-GCM stack does not want to reuse an IV, *expecially* if there is
even the slightest chance that it might reuse the IV for different
data.  This use case doesn't necessarily involve random numbers, but,
if anything, it needs to be even faster than #1.

The threats here are not really the same.  For #1, a userspace RNG
should be able to recover from a scenario in which an adversary clones
the entire process *and gets to own the clone*.  For example, in
Android, an adversary can often gain complete control of a fork of the
zygote -- this shouldn't adversely affect the security properties of
other forks.  Similarly, a server farm could operate by having one
booted server that is cloned to create more workers.  Those clones
could be provisioned with secrets and permissions post-clone, and at
attacker gaining control of a fresh clone could be considered
acceptable.  For #2, in contrast, if an adversary gains control of a
clone of an AES-GCM session, they learn the key outright -- the
relevant attack scenario is that the adversary gets to interact with
two clones without compromising either clone per se.

It's worth noting that, in both cases, there could possibly be more
than one instance of an RNG or an AES-GCM session in the same process.
This means that using signals is awkward but not necessarily
impossibly.  (This is an area in which Linux, and POSIX in general, is
much weaker than Windows.)


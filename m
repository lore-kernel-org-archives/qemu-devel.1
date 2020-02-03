Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837ACC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:56:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 502202087E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ae+fyIRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 502202087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd9M-0007TJ-FA
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:56:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyd3N-0003J1-Hf
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:50:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyd3L-0006LR-Vo
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:50:21 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyd3L-0006L0-Pd
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:50:19 -0500
Received: by mail-ot1-x344.google.com with SMTP id r27so13835377otc.8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t52a5N3+/XBDoiU/bexptK/ps1HC6ekaFTVDp92o+IY=;
 b=ae+fyIRKnNV7OPLA36I/GnQrfZcx989llTH7VDKFwPYhTHAOeI9o9Rzw4yrFcmjPrL
 GpNeM7CHbqc81r++c/zA40KpU+BUsrwBCr8JGFcGC5Fk607KHTmNsMT4KNXrPTCHVZ0P
 NY0B7LmTVLzZm6J+i50VByy0oVXCWtQWAD09N/L/Z/wBIKgNpRtHRezO38xd/BNSpj/C
 UtQ733kfkdZQIA9CPbdEitD80Mdc2RLaRbWhRMKmWhoI0bwPxxcY5Y2IfPZe62DWKic4
 q1Exe410YjQidsBCiTu2VQp4dX+qZNDB2T78i9vbb2lXakfOHlHEh+TDJ/TllnYC2SZv
 68uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t52a5N3+/XBDoiU/bexptK/ps1HC6ekaFTVDp92o+IY=;
 b=kwOWE5CjB2rHk8RDYTYzP9igFPBKycuYtcd0oksv9kv1uHqMpdEL7Mpo0Rc2LSwfXs
 +YHv8Gj4gJoItTEDSjMfY6XeeVUqenD5R1ZrpqxpAbyDA0Jj89ugcW5qEfq2zoc6nuld
 2H1r1hw1NsNOf0iPHBhNTG3BTNtjmLZKyQKZKZogua9k3CNf5THiC6LlYShLGt+TlG4R
 9i+xdeLtEQvbPAEhkNLhsWte775teO0qy6EVUh3J+Hzv9QD1sRK9ethXlCPnEoY6POBY
 gB47Im4hMT3/95Xr//pqNVE43qhiEaJemKudAgP0880z+J8vhuxq5s74LWozgPdt+dcm
 f9Rw==
X-Gm-Message-State: APjAAAVBLEzdcsfInipXqTFZC288/4TXZID0suUjkB5jwU9RwI9T9jx6
 JdC01UQIOKJ6i7TrPbCimrtW9mZCXy4Goj0yHfGdrg==
X-Google-Smtp-Source: APXvYqwjwCCE1aCZHNC5zXb4m+fp+FtNSA8WOyTX8UrHrPn+R7RbwxIR6bQzKT9BVjHzv9Iqf2Hh4Phh4KhzYIf0hv4=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr17351484otq.221.1580741418713; 
 Mon, 03 Feb 2020 06:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20200203123811.8651-1-thuth@redhat.com>
 <CAFEAcA_1KYRA=87k34zCRLqCf1tWHrULGZPcHeKwJZhDUx0=kw@mail.gmail.com>
 <2fd63018-b9f9-ab88-2d65-009c54bb6cf2@redhat.com>
In-Reply-To: <2fd63018-b9f9-ab88-2d65-009c54bb6cf2@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 14:50:07 +0000
Message-ID: <CAFEAcA_XKAeT10p+XNRjQeOjoGYX1Q-D+kj9E0kFx2AxtktACg@mail.gmail.com>
Subject: Re: [PULL 00/13] qtests, kconfig and misc patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 14:30, Thomas Huth <thuth@redhat.com> wrote:
>
> On 03/02/2020 15.04, Peter Maydell wrote:
> > On Mon, 3 Feb 2020 at 12:38, Thomas Huth <thuth@redhat.com> wrote:
> >>
> >>  Hi Peter,
> >>
> >> the following changes since commit 28db64fce555a03b4ca256d5b6f4290abdfbd9e8:
> >>
> >>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2020-01-31 17:37:00 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-02-03
> >>
> >> for you to fetch changes up to 585c138628bbf22ea8e740b2f4f1a3ed0274ebe8:
> >>
> >>   trivial: Remove xenfb_enabled from sysemu.h (2020-02-03 10:33:57 +0100)
> >>
> >> ----------------------------------------------------------------
> >> * Current qtests queue
> >> * Some Kconfig updates
> >> * Some trivial clean-ups here and there
> >> ----------------------------------------------------------------
> >
> > All the incremental rebuilds failed:
> >
> > Linux cam-vm-266 4.15.0-70-generic x86_64
> > From git://git-us.linaro.org/people/pmaydell/qemu-arm
> >    f31160c7d1..f9e931a1d9  staging    -> pmaydell/staging
> > make: Entering directory '/home/petmay01/qemu-for-merges/build/w64'
> > make[1]: Entering directory '/home/petmay01/qemu-for-merges/slirp'
> > make[1]: Nothing to be done for 'all'.
> > make[1]: Leaving directory '/home/petmay01/qemu-for-merges/slirp'
> >   CC      qga/main.o
> >   CC      stubs/machine-init-done.o
> >   CC      stubs/replay-user.o
> >   CC      stubs/semihost.o
> >   CC      qemu-img.o
> >   CC      qemu-io.o
> >   CC      chardev/char.o
> > make: *** No rule to make target
> > '/home/petmay01/qemu-for-merges/hw/bt/Kconfig', needed by
> > 'aarch64-softmmu/config-devices.mak'.  Stop.
> > make: *** Waiting for unfinished jobs....
> >   CC      chardev/char-mux.o
> > make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'
>
> Oh, they are still failing??? Why are there still references to
> hw/bt/Kconfig in these config-devices.mak files, I'd expect that they
> would have been regenerated at least once during the past week?

build/all/aarch64-softmmu/config-devices.mak.d was most recently
touched this morning, and it still includes hw/bt/Kconfig in its
dependency list. I think this is because minikconf will still put
a Kconfig file into the .d file it generates even if the Kconfig
file happens to be empty.

And make doesn't have any rules that tell it that config-devices.mak.d
need to be updated either:
$ make -C build/all -n aarch64-softmmu/config-devices.mak.d
make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all'
make[1]: Entering directory '/home/petmay01/linaro/qemu-for-merges/slirp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/petmay01/linaro/qemu-for-merges/slirp'
make: Nothing to be done for 'aarch64-softmmu/config-devices.mak.d'.
make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/all'

or that it needs to rerun minikconf, which would update the .mak.d.

An extremely cheesy workaround would be if the commit which
removes the hw/bt/Kconfig also touches configure; then Make
will know it needs to rerun configure, which will (among
other things) blow away all the config-devices.mak.d and
force rerunning of minikconf.

I don't know what the correct additional makefile magic
would be that would cause us to automatically get deletion
of a Kconfig file right; maybe Paolo does?

thanks
-- PMM


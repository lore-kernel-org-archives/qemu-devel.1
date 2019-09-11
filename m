Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54ACDECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:23:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BE4206CD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0RYwMe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BE4206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wxx-000052-BI
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7wx2-0007qV-1m
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7wwz-0003tE-Ql
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:22:03 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i7wwz-0003so-LY
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:22:01 -0400
Received: by mail-oi1-x244.google.com with SMTP id v7so13327537oib.4
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 00:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=XK8vtOXPgLtzd+3B76eR332u9q2SrO4oMqLV7RFTmoY=;
 b=Q0RYwMe3+9OWLnlqo3kI9Sw9hMhmYe4f60GoAdQUpOO9vfZI9w4DKGXbJUnDOgH9h1
 dvoJUiJAWd0keF89uFRZcgNz/W/W5rCotbc1MD66sMdxDJz7VtwlDREUs54FP8xrbW/v
 o1xl2F1E71qXXxJP+YUMxFw2Nml6rdoobl3sZZ6s3YBMqJoj8X4kR+WmuR9U4ImoDFFb
 /imV/Um7y9RlJ4YLYte344l+pr8gqhjeepAJbE2vrHxDLeW/KJ3IBsAJHDEDpncf+nkA
 cFYKUGrcPufdaKDHJfWbQtuUpuuZlS5DIG5fjKWyKV7H/xJpGgBI1/zA4MOqQULHFTvr
 QKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=XK8vtOXPgLtzd+3B76eR332u9q2SrO4oMqLV7RFTmoY=;
 b=b8AIM517RZBkWNIAJOvwD3kJlcGWKqwJbZTMpP2qZ9im8VV4IMaMF0MNP5xTH/fwgE
 2qpyzoHNT++tuSBtzhhG6iN3EekFtC5aTgUbiyBenJBPvt3bZGHDceB03egGzZUo9wSg
 +KCzNBLVyQMGwIbG33TK4A64eOJwOtbkoUJoUSslnGoItQ99KSktjTOcge6qdiiQsTEx
 ZL9eMMucu6MeaL93hppsDZPxXtwgWqiM0BrKAvfGRdrkiGrA8NAA42R+p+BBfFLsXjUd
 NbIswL+iqqHhnjGF/+bnAHEueF8gHOmJniGtem6VKSlRg8GK4mezSIUGOpJgyvbFZxih
 i3hw==
X-Gm-Message-State: APjAAAWEvakB4hPrP+rUvXAh41Fii8VzLxJZPbp9QlJWK+9xrpKJFVqv
 E7qyx6KZy+E2VSlWQVE+C+RBTR7TDPG4yyRGZRw=
X-Google-Smtp-Source: APXvYqwEufYESHKpg/Z/68DdL946OPxmx7dRwbW9UpyBm1/t7+7AWe8gp1HMr4MkydcfFNEJKzAa29sL425N6wCwMqc=
X-Received: by 2002:aca:c505:: with SMTP id v5mr2722035oif.79.1568186520611;
 Wed, 11 Sep 2019 00:22:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Wed, 11 Sep 2019 00:22:00
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Wed, 11 Sep 2019 00:22:00
 -0700 (PDT)
In-Reply-To: <565ed74a-5c6b-c1eb-035e-3eb981487de5@redhat.com>
References: <20190802160458.25681-1-peter.maydell@linaro.org>
 <565ed74a-5c6b-c1eb-035e-3eb981487de5@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 11 Sep 2019 09:22:00 +0200
Message-ID: <CAL1e-=h95f0ozY1AqEUX0rPKBjrcWARB=KtX8xO-nm6f6fYRsQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/3] target/mips: Convert to
 do_transaction_failed hook
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 James Hogan <jhogan@kernel.org>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 "Maciej W. Rozycki" <macro@linux-mips.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

02.08.2019. 18.29, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Cc'ing broader MIPS audience.
>
> On 8/2/19 6:04 PM, Peter Maydell wrote:
> > This patchset converts the MIPS target away from the
> > old broken do_unassigned_access hook to the new (added in
> > 2017...) do_transaction_failed hook.
> >

Since Herve now tested this series, unless somebody objects, I am going to
include it in the next Mips queue, scheduled in next few days.

Thanks to all involved!

Aleksandar

> > The motivation here is:
> >  * do_unassigned_access is broken because:
> >     + it will be called for any kind of access to physical addresses
> >       where there is no assigned device, whether that access is by the
> >       CPU or by something else (like a DMA controller!), so it can
> >       result in spurious guest CPU exceptions.
> >     + It will also get called even when using KVM, when there's nothing
> >       useful it can do.
> >     + It isn't passed in the return-address within the TCG generated
> >       code, so it isn't able to correctly restore the CPU state
> >       before generating the exception, and so the exception will
> >       often be generated with the wrong faulting guest PC value
> >  * there are now only a few targets still using the old hook,
> >    so if we can convert them we can delete all the old code
> >    and complete this API transation. (Patches for SPARC are on
> >    the list; the other user is RISCV, which accidentally
> >    implemented the old hook rather than the new one recently.)
> >
> > The general approach to the conversion is to check the target for
> > load/store-by-physical-address operations which were previously
> > implicitly causing exceptions, to see if they now need to explicitly
> > check for and handle memory access failures. (The 'git grep' regexes
> > in docs/devel/loads-stores.rst are useful here: the API families to
> > look for are ld*_phys/st*_phys, address_space_ld/st*, and
> > cpu_physical_memory*.)
> >
> > For MIPS, there are none of these (the usual place where targets do
> > this is hardware page table walks where the page table entries are
> > loaded by physical address, and MIPS doesn't seem to have those).
> >
> > Code audit out of the way, the actual hook changeover is pretty
> > simple.
> >
> > The complication here is the MIPS Jazz board, which has some rather
> > dubious code that intercepts the do_unassigned_access hook to suppress
> > generation of exceptions for invalid accesses due to data accesses,
> > while leaving exceptions for invalid instruction fetches in place. I'm
> > a bit dubious about whether the behaviour we have implemented here is
> > really what the hardware does -- it seems pretty odd to me to not
> > generate exceptions for d-side accesses but to generate them for
> > i-side accesses, and looking back through git and mailing list history
> > this code is here mainly as "put back the behaviour we had before a
> > previous commit broke it", and that older behaviour in turn I think is
> > more historical-accident than because anybody deliberately checked the
> > hardware behaviour and made QEMU work that way. However, I don't have
> > any real hardware to do comparative tests on, so this series retains
> > the same behaviour we had before on this board, by making it intercept
> > the new hook in the same way it did the old one. I've beefed up the
> > comment somewhat to indicate what we're doing, why, and why it might
> > not be right.
> >
> > The patch series is structured in three parts:
> >  * make the Jazz board code support CPUs regardless of which
> >    of the two hooks they implement
> >  * switch the MIPS CPUs over to implementing the new hook
> >  * remove the no-longer-needed Jazz board code for the old
> >    hook
> > (This seemed cleaner to me than squashing the whole thing into
> > a single patch that touched core mips code and the jazz board
> > at the same time.)
> >
> > I have tested this with:
> >  * the ARC Multiboot BIOS linked to from the bug
> >    https://bugs.launchpad.net/qemu/+bug/1245924 (and which
> >    was the test case for needing the hook intercept)
> >  * a Linux kernel for the 'mips' mips r4k machine
> >  * 'make check'
> > Obviously more extensive testing would be useful, but I
> > don't have any other test images. I also don't have
> > a KVM MIPS host, which would be worth testing to confirm
> > that it also still works.
> >
> > If anybody happens by some chance to still have a working
> > real-hardware Magnum or PICA61 board, we could perhaps test
> > how it handles accesses to invalid memory, but I suspect that
> > nobody does any more :-)
> >
> > thanks
> > -- PMM
> >
> >
> > Peter Maydell (3):
> >   hw/mips/mips_jazz: Override do_transaction_failed hook
> >   target/mips: Switch to do_transaction_failed() hook
> >   hw/mips/mips_jazz: Remove no-longer-necessary override of
> >     do_unassigned_access
> >
> >  target/mips/internal.h  |  8 ++++---
> >  hw/mips/mips_jazz.c     | 47 +++++++++++++++++++++++++++++------------
> >  target/mips/cpu.c       |  2 +-
> >  target/mips/op_helper.c | 24 +++++++--------------
> >  4 files changed, 47 insertions(+), 34 deletions(-)
> >
>

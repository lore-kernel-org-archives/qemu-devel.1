Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613E6C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3378B206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 18:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIEa/OcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3378B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he2HB-0002vO-WD
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 14:59:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48758)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.abdurachmanov@gmail.com>) id 1he22Y-0002Wa-0n
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.abdurachmanov@gmail.com>) id 1he22W-0006ju-B7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 14:44:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <david.abdurachmanov@gmail.com>)
 id 1he22R-0006Ya-12; Thu, 20 Jun 2019 14:44:00 -0400
Received: by mail-wm1-x342.google.com with SMTP id s15so4132351wmj.3;
 Thu, 20 Jun 2019 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4LHMsPVDcn9PlAIhAnE2zQdJYzMjOMz4tYmhiXFGkXU=;
 b=DIEa/OcKePFVd0woY+rfgOf+DVEAU02v/1ofyB8ArOPL2tuoI7qBoWvDFGW/T7uR5C
 qf/GiPopO+HFpxduf2zY0O1wofg2/Hlr1GnGwE7iJRNOfJcvLP9mmbSyg9lxGeRkeSkw
 qAiLipIBAnX6nE/UlMg+zPjy5X92l8hKfVbN2YDeycADI4o3xPeiRQAssBvC3ip6hgff
 amYh7LYAGwct5ZSYKtTvuUtZWUFutSRwkQhEZjMS320rvIMzfGxg04waE6wmvuZAUTnr
 YCiNJZNG3rxMxCfqUBZCyKakA5fvjbhqp741gKmz1V8695fbMSr5qzc1ezHaBdPc4OsJ
 Ntnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4LHMsPVDcn9PlAIhAnE2zQdJYzMjOMz4tYmhiXFGkXU=;
 b=M8Fyik/Qc3kERXfXRwAEYrD1kyUw/McnxJMM6DnTwbI4jMQzI18YEuo+FQaAV5dHTD
 1OfuzOEbbnxNGLCVNPJgnkZ62hRrCKb7UXq3Xx4bWiDLvQC+DBAMuM14dML7mQS//uuW
 QS1gorFX/1KQzfKQcs0Bu7QeIxRhG8BBon6MIZqnUVj3xgKl8ok7xqLhdJZrUcUfYFse
 LKG2Ibge0dCKHTR3WEokk8R/FndYRv3BFgqz7XsigVjgxJOWDl8eoxlMMdHhsxcpqFZh
 aPeEGRyQfP3qvRpHarmGV8KK7lP4NfT9+WmRUaOnwrIywOGX8VkoS6rdaZlcQkCVFND9
 fxbg==
X-Gm-Message-State: APjAAAW2ruWbRQ/HYxfESkW08R/gAUqw5KFuqXN72oR/2klCPCgYxuUn
 oSHT0j605f7HaKLWCXScQTMzf/ZTjzeGssFzb4o=
X-Google-Smtp-Source: APXvYqz5RaK0zsv/ikbd+49AyZojYpd17FQZ7/cyo6rHKai9DlU1fLYhT64Uf2moixj9RkBTSRhJvCIvvTlN7w7s/QI=
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr682472wml.90.1561056227519;
 Thu, 20 Jun 2019 11:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <CAEUhbmViJpKtiNXm7CYdF7SPRkOPkvpXJ5+We2m9tZSK_BWi-g@mail.gmail.com>
 <CAKmqyKM4UU+CPKu07AK65bNofbbxxaRkSACqoV_vfFEaH-195A@mail.gmail.com>
 <CAEUhbmUwAVLXY9SSoryWBDeNL8gUfBCE+xweSSmuE9KwzWeX=w@mail.gmail.com>
 <CAKmqyKMmm-38DijX_wL=pAbvxzLQ+KSOtd1xg_GrT4Az70GKsw@mail.gmail.com>
 <11f4e4ff6037427f52824ba586f8a330c12d8dfd.camel@redhat.com>
 <CAKmqyKOh3J07yg3dbaNcOaSzfbDZJJ-kjN3pBh+KqAKq05hzTA@mail.gmail.com>
In-Reply-To: <CAKmqyKOh3J07yg3dbaNcOaSzfbDZJJ-kjN3pBh+KqAKq05hzTA@mail.gmail.com>
From: David Abdurachmanov <david.abdurachmanov@gmail.com>
Date: Thu, 20 Jun 2019 21:43:36 +0300
Message-ID: <CAEn-LTo_e-Owk3hKGGsfSDkWLVEK2reO3ZU=y_hNDOtYVKgusw@mail.gmail.com>
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [Qemu-riscv] [RFC v1 0/5] RISC-V: Add firmware
 loading support and default
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>, Andrea Bolognani <abologna@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 20, 2019 at 9:18 PM Alistair Francis <alistair23@gmail.com> wrote:
>
> On Thu, Jun 20, 2019 at 1:16 AM Andrea Bolognani <abologna@redhat.com> wrote:
> >
> > On Wed, 2019-06-19 at 11:23 -0700, Alistair Francis wrote:
> > > On Wed, Jun 19, 2019 at 7:42 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > On Wed, Jun 19, 2019 at 10:30 PM Alistair Francis <alistair23@gmail.com> wrote:
> > > > > On Wed, Jun 19, 2019 at 7:26 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > > > >  pc-bios/opensbi-riscv32-fw_jump.elf | Bin 0 -> 197988 bytes
> > > > > > >  pc-bios/opensbi-riscv64-fw_jump.elf | Bin 0 -> 200192 bytes
> > > > > >
> > > > > > Since we are considering adding "bios" images, I prefer to add the
> > > > > > pure binary images instead of ELF images here.
> > > > >
> > > > > I didn't think about that. Can we just boot them in QEMU like we do
> > > > > with the ELFs?
> > > >
> > > > Yes, use load_image_targphys() instead of load_elf().
> > >
> > > Ah, that is obvious. I'll update it to use the bin files then.
> >
> > I'm unclear on the advantages of using one format over the other,
>
> The main one that I see is that everyone else is already using .bin
> and no one else is using .elf.
>
> > but one question comes to mind: once this is in, we will probably
> > want to have OpenSBI packaged separately in distributions, the same
> > way it already happens for SeaBIOS, SLOF and edk2-based firmwares.
> >
> > Will using either of the formats prevent that from happening?
>
> Both options allow this.
>
> OE-Core already packages OpenSBI by default, Fedora and Debian are
> moving to OpenSBI for RISC-V targets as well.

Fedora uses OpenSBI for the last 2 or 3 months now. I don't plan to update
BBL builds. OpenSBI packages in Fedora/RISCV isn't finalized, but it does
ship *.elf and *.bin files.
>
> Any distro that supports the RISC-V toolchain (which is all
> upstreamed) can build OpenSBI.
>
> Alistair
>
> >
> > --
> > Andrea Bolognani / Red Hat / Virtualization
> >
>


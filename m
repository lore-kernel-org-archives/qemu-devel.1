Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16025C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D8321655
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 21:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMsK1/v7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D8321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDyEK-0004Cm-Kb
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 17:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38044)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iDyC1-0002D1-TX
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iDyC0-00043r-Oh
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 17:54:25 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:34517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iDyBy-0003yu-B1; Fri, 27 Sep 2019 17:54:22 -0400
Received: by mail-lf1-x143.google.com with SMTP id r22so2998830lfm.1;
 Fri, 27 Sep 2019 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jkOir/wyT+RF7Mh1S6xJDDGBy1VpXPxRvS0hvYj7V5w=;
 b=JMsK1/v701qjYU6XisrkwCJohmdg9dDyxlO2OJTAzzw9ap2h+Ul4YZw0lBqF15+8cB
 4hNJIry/NZg+djA+pUkZD4clhiLefhv2n09xL/Fq4s50UeEZuQa8oDrFUu6NSlo4oqdf
 OxDBbMyVNL8K8DCMWMVXMNlM4u1ULePg51JJg4qeWveHlvlalwkRIM+YDaGy+a6bN6Na
 Tuj/+yl0CLU5S3cCD8Rxhhz/6NX2srPojj5Dpxe1/6oToinQlPPQfbbMZtVJLMuEYTbd
 +x5nwP4WFloymh35MLiZy97MxZ6eyeNpB8x3WpH5Rja5sBHxttsPkT5zTPLHpbhQ9fVa
 L+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jkOir/wyT+RF7Mh1S6xJDDGBy1VpXPxRvS0hvYj7V5w=;
 b=R9kqdLrY7fUPftD21bbz+f/zvSaj981c89+oycXkNuQ75pLanNWBAKnnUiGyjeeblu
 EZXpZBTVijV5C1xIQVHLurGOKDNBduCXeTiiTUzf4eWqqGBL/AzP/OFdgHnzHTlviZl7
 xcMHHRHvWe/isgRE3Ur/uVfA5N/+T6IfAeKXqkeFj3I6Nw+rRyZgrSoZe/eBBkdwEO3J
 yDbr87/u35/ijzGiICYVUSD1dbAkLu5FsOr/IgbD2q1SeTwViCGxjq/iMHLRguWsRweR
 q/a3BSSSorEW7FeTHPFFi1uiui6m3bq+qmnR8Ol07IpA117PF8GCYS3NgaoxnRuGGK2I
 pfWQ==
X-Gm-Message-State: APjAAAVKvmMPdbylBUZ0SqUBCnU3gh1ARqkft0D3/XaiSuKTAWis5NGe
 bpqf4UONmoiKIWq/6/mxU9VyZQ7Y25VA2eghZYg=
X-Google-Smtp-Source: APXvYqwizPplLTwwerFLg9f5p8Wwjc9EHKz1KaMYJd1LpuPSvctc5I/Q6xzNkDhzu0JkXWDu6CQp2bcDrkJ+Vb+LEms=
X-Received: by 2002:ac2:5e9e:: with SMTP id b30mr4235200lfq.5.1569621261054;
 Fri, 27 Sep 2019 14:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568931866.git.alistair.francis@wdc.com>
 <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
 <CAEUhbmVvDKQqQYE-riq=cvSrCe_NMoW_KDsLjh8CVHRUhJvk9A@mail.gmail.com>
 <CAKmqyKOofA3U+8kjMkzQ0sNd1=uwJHq3c9eaLZdoNCb7=e-PAw@mail.gmail.com>
 <CAFEAcA-uFPGf4BiDXH=Om3Df-xXrt7QwjzVF7E3kY4aMWMP4YQ@mail.gmail.com>
 <CAKmqyKP3T79qVUXftO=0hmhYbD9MKccdvsAcs=_4CQFoNmfucw@mail.gmail.com>
 <87a7aszr5p.fsf@dusky.pond.sub.org>
In-Reply-To: <87a7aszr5p.fsf@dusky.pond.sub.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Sep 2019 14:49:33 -0700
Message-ID: <CAKmqyKNdE5C2eKeLWi7vUU=_GVp0+9stNHcNV=6UyZ+LoZnhBg@mail.gmail.com>
Subject: Re: [PATCH v1 5/6] riscv/virt: Add the PFlash CFI01 device
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 25, 2019 at 2:00 AM Markus Armbruster <armbru@redhat.com> wrote:
>
> Alistair Francis <alistair23@gmail.com> writes:
>
> > On Mon, Sep 23, 2019 at 2:46 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> >>
> >> On Fri, 20 Sep 2019 at 23:23, Alistair Francis <alistair23@gmail.com> wrote:
> >> > On Thu, Sep 19, 2019 at 10:15 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> >> > > I don't think we should mirror what is used on ARM virt board to
> >> > > create 2 flash for sifive_u. For ARM virt, there are 2 flashes because
> >> > > they need distinguish secure and non-secure. For sifive_u, only one is
> >> > > enough.
> >> >
> >> > I went back and forward about 1 or 2. Two seems more usable as maybe
> >> > someone wants to include two pflash files? The Xilinx machine also has
> >> > two so I'm kind of used to 2, but I'm not really fussed.
> >>
> >> One of the reasons for having 2 on the Arm board (we do this
> >> even if we're not supporting secure vs non-secure) is that
> >> then you can use one for a fixed read-only BIOS image (backed
> >> by a file on the host filesystem shared between all VMs), and
> >> one backed by a read-write per-VM file providing permanent
> >> storage for BIOS environment variables. Notably UEFI likes to
> >> work this way, but the idea applies in theory to other
> >> boot loader or BIOSes I guess.
> >
> > This seems like a good reason to have two and there isn't really a
> > disadvantage so I have kept it with two.
>
> Good.
>
> Implementing sector locking would be even better.  I'm not asking you to
> do that work.
>
> >> I would suggest also checking with Markus that your code
> >> for instantiating the flash devices follows the current
> >> recommendations so the backing storage can be configured
> >> via -blockdev. (This is a fairly recent change from June or
> >> so; current-in-master virt and sbsa boards provide an example
> >> of doing the right thing, I think.)
> >
> > I have updated the code to more closely match the ARM virt machine, so
> > I think I'm doing it correctly.
>
> You might want to consider omitting legacy configuration options -drive
> if=pflash and -bios for a simpler interface.

We just moved to -bios and it's been really helpful.

Doesn't -pflash use -drive if=pflash? How else should these be attached?

Alistair


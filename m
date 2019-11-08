Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0623FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 18:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76BE4214DB
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 18:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t6geXBix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BE4214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT8do-0008Oq-Lo
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 13:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT8d3-0007ug-6R
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 13:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT8d1-0007hH-RE
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 13:05:00 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40325)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT8d1-0007gw-Ku
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 13:04:59 -0500
Received: by mail-oi1-x243.google.com with SMTP id 22so6022872oip.7
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 10:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+btYeezsgOnOT7C71hvkNCIKMyaN8hXI9UchP5S6TrE=;
 b=t6geXBixrM1+hz6a0SiRfQHXdKVJz9ZmT1MMRjw8ORk7cMxO7zFp0DKwMPJt3JEu09
 pSOC/COObEVOeiUy5jhiD3ijc+Tza9ApkWfwWq8nznCjygHae/pfnCviiiP8rpP3all6
 UzHN90hg0ialoJpmn9CrD3XWfbZsU/iJZHycEl0/oSZgHF96V4MhGPNsEQqTI4+TdnXf
 2VlxRx77ccibDIYsmd/FrsRprLeDPjFnppIazq2rK7HUSo4G98nq7Gz+/ZOXaCf8DcCK
 J9C1Z2GmA3KwmqHATDxSErxo5Mu1+ksp/CETrunFwMSlOq5Vz2w9jD64iXo3prmplEaU
 LEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+btYeezsgOnOT7C71hvkNCIKMyaN8hXI9UchP5S6TrE=;
 b=lI8f6qKWMPt+oWex/6IsoKnAaUJsaJI51om2b//XZWJds3M8MhG6UIKDe6xphZesbf
 nOOTsI15X/rDeNd4Wwde4ZBlrQbkEBiIpTf0Sy+4snd17Md6XGDdU8DV0ogxbrbPLjfk
 hFgIU1vW7kC/Rkeft83ScpM8U+S6f5v/72ZKG5yJq+5R56pnKo5q5TYtvG1yYE73sRy3
 4v1iGCAUS3RTgs0r4Lk05rtSn2BSSPYUomf+m1OTugX/zeb4k7Mo33vipI2avSlP/rs8
 iBxilUSLN6fVZ+6QLAs8XZ6LLnFBQ7WGCVl1HUadINgipyuWbnV47O1+fY+c1UqZ1i07
 rhYQ==
X-Gm-Message-State: APjAAAXc4BJWnzoZe3jDJAAwT3KMnv7I+a/vb2XuNe+ZRlndllxNqt9w
 rdi2QLJey/klbYJw+f9zpJIqkzUKcYXaEeb2Ro71fg==
X-Google-Smtp-Source: APXvYqyqbLgpcGi3STe0bKGYeLaylt5z7R9OwK8yWbmWHqIDjoAoZv9xzAz7awXGUJE6KMK+qkdRCCgNsr9wzctjdSs=
X-Received: by 2002:a05:6808:7d1:: with SMTP id
 f17mr11186584oij.163.1573236298435; 
 Fri, 08 Nov 2019 10:04:58 -0800 (PST)
MIME-Version: 1.0
References: <20191107222500.8018-1-palmer@sifive.com>
 <CAKmqyKOodh3tPUGBM92ZRWFLoeo9E=kcaqO9F9dHz1wBMP9ywA@mail.gmail.com>
In-Reply-To: <CAKmqyKOodh3tPUGBM92ZRWFLoeo9E=kcaqO9F9dHz1wBMP9ywA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 18:04:47 +0000
Message-ID: <CAFEAcA8k+t2qKCSvMjENitvCXyc-qwiG2qbg6gQFKR_+v_zihg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: virt: This is a "sifive,test1" test finisher
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Christoph Hellwig <hch@infradead.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 17:15, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Fri, Nov 8, 2019 at 9:05 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > The test finisher implements the reset command, which means it's a
> > "sifive,test1" device.  This is a backwards compatible change, so it's
> > also a "sifive,test0" device.  I copied the odd idiom for adding a
> > two-string compatible field from the ARM virt board.
> >
> > Fixes: 9a2551ed6f ("riscv: sifive_test: Add reset functionality")
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> >  hw/riscv/virt.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index 23f340df19..74f2dce81c 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -359,7 +359,10 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
> >      nodename = g_strdup_printf("/test@%lx",
> >          (long)memmap[VIRT_TEST].base);
> >      qemu_fdt_add_subnode(fdt, nodename);
> > -    qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,test0");
> > +    {
> > +        const char compat[] = "sifive,test1\0sifive,test0";
>
> Does this really work? Why not use qemu_fdt_setprop_cells()?
>
> Alistair
>
> > +        qemu_fdt_setprop(fdt, nodename, "compatible", compat, sizeof(compat));
> > +    }

qemu_fdt_setprop_cells() is for "set this property to
contain this list of 32-bit integers" (and it does a byteswap
of each 32-bit value from host to BE). That's not what
you want for a string (or a string list, which is what
we have here).

Cc'ing David Gibson who's our device tree expert to see if there's
a nicer way to write this. Oddly, given that it's used in the
ubiquitous 'compatible' prop, the dtc Documentation/manual.txt
doesn't say anything about properties being able to be
'string lists', only 'strings', '32 bit numbers', 'lists of
32-bit numbers' and 'byte sequences'. You have to dig through
the header file comments to deduce that a string list is
represented by a string with embedded NULs separating
each list item.

thanks
-- PMM


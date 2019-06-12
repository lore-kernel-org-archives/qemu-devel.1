Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17726C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D888E2063F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YokWIRe3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D888E2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hazKu-0006TR-1E
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 05:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37527)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hazJ3-00059H-9X
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hazJ1-0004Sp-Le
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:12:33 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hazJ1-0004S9-EG
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:12:31 -0400
Received: by mail-ot1-x344.google.com with SMTP id b7so14684539otl.11
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=cRwMbRuAdQsvxb5M1evV/Mg13HwO504YDuXD/MXWqi4=;
 b=YokWIRe35bkMqlOFHfpP3iX4+VcMyieqWgAsjURYmAbM7MdnwlZxZd6T4rNloDW8HI
 5douVp2J4hsLrOdRVCIcGu3daQzarvynqIlwxSQhb8ADNpQcA1SvqBROBi0PejnZ7SQD
 HoZIeCZOgf7IZHsWhJ8bok/KkAfEKcW1Sjm/srdqooxw6HAr6qsHvY1YSSDCUSBl/rF4
 UHO/ghfPgStQrG3UgDNvcosNYKx0Hy3BP5GXzn4Hff+d5e+xrT84QvLw2e9WIXkLk5WT
 e3+mCqdHeiD6KOL+BKpYny4f/7hwMrlmALhpjFh+GSAUk4IHtpycJAiUY4CZUFxSVHnp
 B9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=cRwMbRuAdQsvxb5M1evV/Mg13HwO504YDuXD/MXWqi4=;
 b=ZYEE7s6+n0xgRqjnUF7sY/MhPBWD4PETiRd7m2COhzDX1k4wZE6KWDarqQzDHgvkg/
 bwk82fSt/kz/imNIXk7ZFq2KNYEQ8cTHdIudX9Ct85wFbY4QojyyiIVS2S5/WU/yuEsW
 2YwssyJbJBT9pdjK30lLAmWZ69SZNqQwIZCoD0A/VthmPzIqawc3XHM69mVpNoe9n8Ia
 NyWCDdRBwrffxcHazGva25N9+dsBj7w5NjSZnyIX2w8Ys8AgKNf9JKH4h3UFWZy//gOo
 a8GS1PRvQqBTXdlUrgdrfTL3Hj4a7a4FH22SXf7O4R7r9CX3/RkHMNTWNtOB4BQWLGen
 diag==
X-Gm-Message-State: APjAAAVwpQFaJvP6J9Mo2jDiIKDmhIT2Ty2vtkmrMJe/3rC8W4vPFDK7
 R4T3TdJK9k0o3jir/PWjvvRIeokLiHWiUsgjmyE=
X-Google-Smtp-Source: APXvYqxoGmkL4rb6SmshKgEcakiySHRsRM0otzVnJlT+EE2PJslFvbCmrQw/aURMHotm+WgG5nPSxeJAat3/lS6O9yI=
X-Received: by 2002:a9d:6e8a:: with SMTP id a10mr20308728otr.295.1560330749662; 
 Wed, 12 Jun 2019 02:12:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Wed, 12 Jun 2019 02:12:29
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Wed, 12 Jun 2019 02:12:29
 -0700 (PDT)
In-Reply-To: <CAL1e-=jKcPK1ig3eHtRfTA0PDV0Z2Y1gXP6YhJ7jdbSA06B=fw@mail.gmail.com>
References: <20190610152444.20859-1-peter.maydell@linaro.org>
 <20190610152444.20859-2-peter.maydell@linaro.org>
 <CAL1e-=hSY4uWQ9QmebdzkkV4WTZ82JFSW2fRafHBtvdJv1tm5A@mail.gmail.com>
 <CAFEAcA_TAQvXbjP1h9SS6TiCxwwDf5oAUDAWDn0FRX3G0PBzaA@mail.gmail.com>
 <CAL1e-=jKcPK1ig3eHtRfTA0PDV0Z2Y1gXP6YhJ7jdbSA06B=fw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 12 Jun 2019 11:12:29 +0200
Message-ID: <CAL1e-=guBWdaYzG5q_g9eB3tn68hnT+r1WnQR5qzNfF2KnhR5w@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 1/2] docs/specs/index.rst: Fix minor syntax
 issues
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
 David Gibson <david@gibson.dropbear.id.au>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 11, 2019 4:18 PM, "Aleksandar Markovic" <aleksandar.m.mail@gmail.com=
>
wrote:
>
>
> On Jun 11, 2019 11:51 AM, "Peter Maydell" <peter.maydell@linaro.org>
wrote:
> >
> > On Mon, 10 Jun 2019 at 22:41, Aleksandar Markovic
> > <aleksandar.m.mail@gmail.com> wrote:
> > >
> > >
> > > On Jun 10, 2019 5:25 PM, "Peter Maydell" <peter.maydell@linaro.org>
wrote:
> > > >
> > > > The docs/specs/index.rst has a couple of minor issues which
> > > > we didn't notice because we weren't building the manual:
> > > >  * the ToC entry for the new PPC XIVE docs points to
> > > >    a nonexistent file
> > > >  * the initial comment needs to be marked by '..', not '.',
> > > >    or it will appear in the output
> > > >  * the title doesn't match the capitialization used by
> > > >    the existing interop or devel manuals, and uses
> > > >    'full-system emulation' rather than the 'system emulation'
> > > >    that the interop manual title uses
> > > >
> > > > Fix these minor issues before we start trying to build the manual.
> > > >
> > > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > > ---
> > >
> > > Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Hi Aleksandar; I'm just wondering what you were meaning
> > with this acked-by tag. Generally acked-by means  (to me,
> > and I think usually with qemu) "this patch touches an
> > area that I maintain, I haven't reviewed it but I'm OK with
> > it". But this series isn't mips-related, so maybe you
> > meant reviewed-by instead ?
> >
> > (Acked-by is a bit of an odd tag because it's less
> > clear what it means than reviewed-by or signed-off-by,
> > so it's not very surprising if you've picked up a
> > different opinion on what it's for.)
> >
>
> Hello, Peter.
>
> My intented meaning (of my Acked-by) is:
>
> =E2=80=9CI agree that this patch is valuable in general, I took a look at=
 the
code changes and they look good to me implementation-wise, but I am not a
reviewer nor an expert in rst and related areas, so I am not comfortable
=E2=80=9Creviewing-it-by=E2=80=9D - however as a potential user/writer of r=
st files, I want
to acknowledge the significance and the rightness of the patch by
=E2=80=9Cacking-it-by=E2=80=9D.=E2=80=9D
>
> I am not sure how it fits in other definitions, but I am comfortable with
your changing my =E2=80=9CAcked-by=E2=80=9D to =E2=80=9CReviewed-by=E2=80=
=9D, leaving it as is, or changing
it to nothing- whatever you deem being suitable.
>
> The same applies to the other patch of this series, of course.
>
> Yours,
> Aleksandar
>
> > thanks
> > -- PMM

Peter, hi again.

While the content of this patch seems definitely unrelated to mips, we in
mips are very interested in QEMU documention framework extended and
improved, since we plan (in a mid-term) a major overhaul of both external
and internal mips-related QEMU documentation.

That is why I am closely observing activities in that area, and most
probably the missing context that left you wandering why I participate in
the discussions on these patches at all. Hopefully this explanations
removes some of your dilemmas.

Best regards,
Aleksandar

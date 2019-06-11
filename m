Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCB3C4321B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4F920896
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZetTy6Hg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4F920896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59572 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahpS-0003Jy-Ps
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38301)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hahff-0003xi-Qo
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hahbz-0006Wn-KC
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:18:56 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hahbz-0006S8-CN
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 10:18:55 -0400
Received: by mail-oi1-x243.google.com with SMTP id w196so9067147oie.7
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ROx3rIg+A7AiZ012ArdEhajj/bigiTMMqDBWharZ6+k=;
 b=ZetTy6HghfpIychrUFA/yfrQPqZMWb865jJDznd1IyjRyABG2uCgzl/07qf6V3H7V2
 cgneYUDvan0469FHSOGsfCI2O8jK+uHxZWOD6amPNOJ3e9M2vgw0zBnpI8Yf+KJvtTmE
 g+LmBduQ+Is7c9s/j9Zfmtxkwn2RhbqgABP0nv/Vtfg5FcABr8HSTAbt0qxVKAm14+K7
 k7FQCPV+BjPjOJlYeHg4ERretcrVmOs4dVjQKxC+PIc19fWnuzYksRKI8mBghkAJE/3H
 rsaM3ahfPZNPucZ0DpQ0D9fb4WS4OgUzoMElX/XyI1Zr81iBAQ2w4MYDNdbfDKQ5Azr7
 i9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ROx3rIg+A7AiZ012ArdEhajj/bigiTMMqDBWharZ6+k=;
 b=cujgL6BSO3/4kIQ5N5wY7MwOhVafZeQm3y7WMZKI3Io2W39Chg1a0OgfunuwEKpgsh
 veCrhJKWvpuRmnFhnzHruXaE98qSSz3EcqDB2xRPfIke1rLwMckbHlCq4HcoACEo9+0s
 JG+Iv1HNwiEOHMqh95uQpq0JP0tqtgLXWBU8xzX3x5jNOQ1bSiBTchg7Gr3EgGzu4HAQ
 IvtsCB1sY9R2Tx0WhnIFvtySyeCvU5Lkk0UcQQhBoGGC+zzNRrn2yCwazIRixnK44Cl6
 dGMfAZQ3vweP1zmSrSHVjcjSnFoU/mPyl/gR4C/bBPmrG1IsNZVTqUwhoscwOCvvZ9tV
 8G0A==
X-Gm-Message-State: APjAAAVoRhta6Qx/MESZ38Bb62lJtoNSdXaJauCU0gb+QV5qWyqN+tKu
 b3qdLS7zQhQNnN0W0vXvkUqCVXxHJcQWoVY+ZtY=
X-Google-Smtp-Source: APXvYqz0zeiNkTrjqxFe0a1FSrMHjVKR4ODauwLjPUyO96nIkpdxzKVWFblITFiXOUxboSNc4uDjm5U1YE1auwPG/Zo=
X-Received: by 2002:aca:c2c3:: with SMTP id s186mr14768841oif.79.1560262733025; 
 Tue, 11 Jun 2019 07:18:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Tue, 11 Jun 2019 07:18:52
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Tue, 11 Jun 2019 07:18:52
 -0700 (PDT)
In-Reply-To: <CAFEAcA_TAQvXbjP1h9SS6TiCxwwDf5oAUDAWDn0FRX3G0PBzaA@mail.gmail.com>
References: <20190610152444.20859-1-peter.maydell@linaro.org>
 <20190610152444.20859-2-peter.maydell@linaro.org>
 <CAL1e-=hSY4uWQ9QmebdzkkV4WTZ82JFSW2fRafHBtvdJv1tm5A@mail.gmail.com>
 <CAFEAcA_TAQvXbjP1h9SS6TiCxwwDf5oAUDAWDn0FRX3G0PBzaA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 11 Jun 2019 16:18:52 +0200
Message-ID: <CAL1e-=jKcPK1ig3eHtRfTA0PDV0Z2Y1gXP6YhJ7jdbSA06B=fw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Jun 11, 2019 11:51 AM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>
> On Mon, 10 Jun 2019 at 22:41, Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> >
> > On Jun 10, 2019 5:25 PM, "Peter Maydell" <peter.maydell@linaro.org>
wrote:
> > >
> > > The docs/specs/index.rst has a couple of minor issues which
> > > we didn't notice because we weren't building the manual:
> > >  * the ToC entry for the new PPC XIVE docs points to
> > >    a nonexistent file
> > >  * the initial comment needs to be marked by '..', not '.',
> > >    or it will appear in the output
> > >  * the title doesn't match the capitialization used by
> > >    the existing interop or devel manuals, and uses
> > >    'full-system emulation' rather than the 'system emulation'
> > >    that the interop manual title uses
> > >
> > > Fix these minor issues before we start trying to build the manual.
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> >
> > Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Hi Aleksandar; I'm just wondering what you were meaning
> with this acked-by tag. Generally acked-by means  (to me,
> and I think usually with qemu) "this patch touches an
> area that I maintain, I haven't reviewed it but I'm OK with
> it". But this series isn't mips-related, so maybe you
> meant reviewed-by instead ?
>
> (Acked-by is a bit of an odd tag because it's less
> clear what it means than reviewed-by or signed-off-by,
> so it's not very surprising if you've picked up a
> different opinion on what it's for.)
>

Hello, Peter.

My intented meaning (of my Acked-by) is:

=E2=80=9CI agree that this patch is valuable in general, I took a look at t=
he code
changes and they look good to me implementation-wise, but I am not a
reviewer nor an expert in rst and related areas, so I am not comfortable
=E2=80=9Creviewing-it-by=E2=80=9D - however as a potential user/writer of r=
st files, I want
to acknowledge the significance and the rightness of the patch by
=E2=80=9Cacking-it-by=E2=80=9D.=E2=80=9D

I am not sure how it fits in other definitions, but I am comfortable with
your changing my =E2=80=9CAcked-by=E2=80=9D to =E2=80=9CReviewed-by=E2=80=
=9D, leaving it as is, or changing
it to nothing- whatever you deem being suitable.

The same applies to the other patch of this series, of course.

Yours,
Aleksandar

> thanks
> -- PMM

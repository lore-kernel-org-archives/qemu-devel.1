Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D611206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoVvFSmp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D611206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYBQ-0006OJ-2N
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZYAB-0005cz-Es
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:05:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZYA7-0006tF-0z
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:05:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id i15so3002219wrx.10
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 04:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C1QUgEw0vXcILjCz6T+Iq0CFUd1xEraNtKuR2B4X+B8=;
 b=YoVvFSmp10siILMHZW55yl7BK1cG7ewvAW1O2tnqaK7MdQi8IanytzHVdmZ63dc5ED
 vvNjW48mz9Ge7IagKNPWQTCQF7HIEsjhpctIpEbAZhOJ+JvKUPSB31Drb7IY2vhyfYP4
 RRxMkHszixfOCgMTbfec3TjVRhWO0pA68/3uct9PYV6WMk5ENZeRmTKbcImZGTgTwzoC
 HwUwfF4CDQ4YWsFZN1Y3tebfCoS0bRCc1OBQugB21itTCotNp+lZpDn1Ipxt7JyXc7c0
 Z+zCMuyt4PbjCDNSrZKcMAmBe3p0XnFDsWwnQDx+kRObmA10mVNRyUHGMSqT+Oli9u2X
 fomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C1QUgEw0vXcILjCz6T+Iq0CFUd1xEraNtKuR2B4X+B8=;
 b=adsI3UN937z4kh1AherZOW92MnAbhUszuZ02xkeTdCneyjLnREimZE6sB+46/pLFwU
 kAxjw2cCeuclCOZZhy3mkkbkgs3uhVBUZ5VML04bA9haHMA/GpMWcd84ukSu3IzfHnzl
 tIp8MZ1N+CDLK41ibgOPOWA3461OJTKaEbNoFCLdqemHKddz9JfkFX/SgTIoZjItG7fx
 bXinSZM2THxQBPukTjw7wA2supTRJS44urSvspTL2BO5dQjhZDV6o9lYmieO8NPWQ+am
 r29/1CGSBAnHeFC11eTr55YF7dzmwQR0KkH+ED41JabDB9zQzMo3FhnRbaJ3oHy9cuY5
 /w/Q==
X-Gm-Message-State: AOAM5302UHorvLbhrySB99T4QIdJn3vldrnhPcM3QMizMEZGR6q1ZO8b
 U800ceacm8QOMy1SAdhiiiUGBn/vH0xKfPDB32M=
X-Google-Smtp-Source: ABdhPJzIZG88oibDzojNYwlwX02xhOedUy6T2VZN3DMudJpO9F3nm0fFHDKnhEHVlY1I21x8AcxCu6Dq0hUn8JEVqTk=
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr3675269wrw.402.1589540753719; 
 Fri, 15 May 2020 04:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
 <20200514192047.5297-18-aleksandar.qemu.devel@gmail.com>
 <87lfltr5vk.fsf@dusky.pond.sub.org>
In-Reply-To: <87lfltr5vk.fsf@dusky.pond.sub.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 15 May 2020 13:05:39 +0200
Message-ID: <CAHiYmc6qZQz8c3mmuvdDWP0uPtBi5K5ie06JOTEo-sy7tbJojg@mail.gmail.com>
Subject: Re: [PATCH v2 17/17] hw/mips: Convert Malta "ifdef 0"-ed code to
 comments
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=B5=D1=82, 15. =D0=BC=D0=B0=D1=98 2020. =D1=83 09:53 Markus Armbru=
ster <armbru@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:
>
> Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:
>
> > The checkpatch complain about "#ifdef 0". Convert corresponding
> > dead code to comments. In future, these cases could be converted
> > to some no-nonsense logging/tracing.
> >
> > Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  hw/mips/mips_malta.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> > index e4c4de1b4e..f91fa34b06 100644
> > --- a/hw/mips/mips_malta.c
> > +++ b/hw/mips/mips_malta.c
> > @@ -427,10 +427,12 @@ static uint64_t malta_fpga_read(void *opaque, hwa=
ddr addr,
> >          break;
> >
> >      default:
> > -#if 0
> > -        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx=
 "\n",
> > -               addr);
> > -#endif
> > +/*
> > + * Possible logging:
> > + *
> > + *        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_=
lx "\n",
> > + *               addr);
> > + */
> >          break;
> >      }
> >      return val;
> > @@ -515,10 +517,12 @@ static void malta_fpga_write(void *opaque, hwaddr=
 addr,
> >          break;
> >
> >      default:
> > -#if 0
> > -        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_l=
x "\n",
> > -               addr);
> > -#endif
> > +/*
> > + * Possible logging:
> > + *
> > + *        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT=
_lx "\n",
> > + *               addr);
> > + */
> >          break;
> >      }
> >  }
>
> Please don't.
>
> Checkpatch warns "if this code is redundant consider removing it\n".
>
> If it is redundant, do remove it.
>
> If it is not redundant, do ignore checkpatch's warning, do not abuse
> comments to hide from checkpatch.  We'd rather not have to code up a
> warning for that :)
>
> These two look like they want to be tracepoints.
>

Hi, Markus.

I understood your points. They make sense to me. In hindsight, in
general, we shouldn't try just to silence checkpatch warnings (or, for
that matter, compiler warnings as well), but try to resolve the root
cause, the underlying issue, of the warning. In this case, creating
tracepoints seems to be the right thing to do.

In hindsight too, this was my "quick and dirty" way of getting rid of
two checkpatch warnings.

Thanks for your remarks!

Aleksandar

P. S. The ultimate reason for this patch is that we plan renaming this
file in near future, and want to do it in "checkpatch-warning-free"
manner.


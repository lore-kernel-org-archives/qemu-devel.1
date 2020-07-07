Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9291206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FyNBxCpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9291206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqUr-0005jN-6k
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsq7o-0003mB-Ow
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:07:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsq7g-00072E-Kb
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:07:16 -0400
Received: by mail-ot1-x344.google.com with SMTP id 5so32681104oty.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ep8LyljtrMKYTuWDUSwqSXR98Qjwd+oZ0BDQsItGX10=;
 b=FyNBxCpnnbQvy+PGPjTafuhQ8Cc/xBvIrJyVPEXjcUaSZpWiOQYfLbn4wKIBUFHOyx
 WZT8VWreJPfEBnAnPVTeOLtZ6xAdb+o0O23tPRm3LE146Ul/g4EC3sAKCD6flCiv0zJs
 GKwYR8yGF5bRci7+9v4Ekz4IgM2rITGqHVCycEiLLAc5UvtrMY5nPMimeqQvOFhrt+f3
 mUnMvVQ7fSQjf2Pcw5Hr+1gjySXzeIv43gbQBC+esNacJ050vg99skS9JWtiwbHHnk3q
 FI9tZvbu0aFSnvZi07GopKqo0u9+2tMxnosVvLcBAcbM51I92swe6uyb2JIXaw95cLXp
 HXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ep8LyljtrMKYTuWDUSwqSXR98Qjwd+oZ0BDQsItGX10=;
 b=iViKKEasSdA1/oeYtYPTjGKBKtGQ5cggPJrbNjwXp1rpuSXmpm+hrtSBS/xrFot589
 QbSM6JhEaYknsq8AYQxdKIrMAcLXdq5jkaibUTDQtI9VEBL3zpeEb/9Tmxj6kREqQeHB
 3kFSL5SWZRNiQQgmEKynoObMtNFOsJskH7LdexoncmIVCa2hxONcYhgStiP3Bj1I8Gx3
 bo8x0oCB8u7Xq3p0iDxEutQc8e4I/d2RlKS+w80YUSdczCgmqZhh/YcHU+dbDL2aAjVW
 NCuq7RRzJIMPtEuUDTzb3yi0l5AC5ZOqwkS7As43f36Ac7DiG61kkgXdiXTsTz06LmLl
 Vx8Q==
X-Gm-Message-State: AOAM530iyRxpG0C2cMxImlXKyI5PrkF4HFD9QYGQaRnJcEEstF/o0I0q
 A1uaC4orebwyVEfkleCgZ76tO6RFtoEisPxsbvbzCw==
X-Google-Smtp-Source: ABdhPJzW3/abgZCl3roacKlkSXYpwrYlG2UqJHCC5UkTTegNXvu2cm7qlcKCxNHol3b2o7LwcKgPgxHRaNAtlhlSRLo=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr38991116oto.135.1594138027060; 
 Tue, 07 Jul 2020 09:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
In-Reply-To: <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2020 17:06:54 +0100
Message-ID: <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: Alistair Francis <alistair23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 17:04, Alistair Francis <alistair23@gmail.com> wrote:
>
> On Tue, Jul 7, 2020 at 6:22 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> >
> > QEMU allows to create SD card with unrealistic sizes. This could work,
> > but some guests (at least Linux) consider sizes that are not a power
> > of 2 as a firmware bug and fix the card size to the next power of 2.
> >
> > Before CVE-2020-13253 fix, this would allow OOB read/write accesses
> > past the image size end.
> >
> > CVE-2020-13253 has been fixed as:
> >
> >     Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
> >     occurred and no data transfer is performed.
> >
> >     Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
> >     occurred and no data transfer is performed.
> >
> >     WP_VIOLATION errors are not modified: the error bit is set, we
> >     stay in receive-data state, wait for a stop command. All further
> >     data transfer is ignored. See the check on sd->card_status at the
> >     beginning of sd_read_data() and sd_write_data().
> >
> > While this is the correct behavior, in case QEMU create smaller SD
> > cards, guests still try to access past the image size end, and QEMU
> > considers this is an invalid address, thus "all further data transfer
> > is ignored". This is wrong and make the guest looping until
> > eventually timeouts.
> >
> > Fix by not allowing invalid SD card sizes.  Suggesting the expected
> > size as a hint:
> >
> >   $ qemu-system-arm -M orangepi-pc -drive file=3Drootfs.ext2,if=3Dsd,fo=
rmat=3Draw
> >   qemu-system-arm: Invalid SD card size: 60 MiB (expecting at least 64 =
MiB)
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  hw/sd/sd.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index cb81487e5c..c45106b78e 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -32,6 +32,7 @@
> >
> >  #include "qemu/osdep.h"
> >  #include "qemu/units.h"
> > +#include "qemu/cutils.h"
> >  #include "hw/irq.h"
> >  #include "hw/registerfields.h"
> >  #include "sysemu/block-backend.h"
> > @@ -2130,11 +2131,26 @@ static void sd_realize(DeviceState *dev, Error =
**errp)
> >      }
> >
> >      if (sd->blk) {
> > +        int64_t blk_size;
> > +
> >          if (blk_is_read_only(sd->blk)) {
> >              error_setg(errp, "Cannot use read-only drive as SD card");
> >              return;
> >          }
> >
> > +        blk_size =3D blk_getlength(sd->blk);
> > +        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> > +            int64_t blk_size_aligned =3D pow2ceil(blk_size);
> > +            char *blk_size_str =3D size_to_str(blk_size);
> > +            char *blk_size_aligned_str =3D size_to_str(blk_size_aligne=
d);
> > +
> > +            error_setg(errp, "Invalid SD card size: %s (expecting at l=
east %s)",
> > +                       blk_size_str, blk_size_aligned_str);
>
> Should we print that we expect a power of 2? This isn't always obvious
> from the message.

Mmm, I was thinking that. Perhaps
 "expecting a power of 2, e.g. %s"
?

thanks
-- PMM


Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C87CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:06:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E37205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o23sY8aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E37205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYK5-000289-SK
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMYIL-0000M9-PZ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMYIK-0001Tw-AO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:04:25 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMYIK-0001TW-4j
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:04:24 -0400
Received: by mail-ot1-x342.google.com with SMTP id g13so11056029otp.8
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 07:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qqxI4t9USoPXl/JeHuyCe4X2D/XmhhmC7h27Axw+udQ=;
 b=o23sY8aJNwQHkKw0xxxs+ejPMiYWNoiKAiNdVrvd+aNE0cw1SVjrEncfNwtbM0yQ2s
 2L78NOBuOrgoqBdzvgjiHtetQU6YBH0eXDA1VJVVktzgG9lHv2Q7Cb44boNbrKg8ZBq/
 4fDJyMgfmKeZO0GyUq8hjXe3D74w5QLxsTCFWkpl0+jNFzp/L+AqFTfAK19UmeHpt3ez
 ylRKIPHiMOX1Zqi2qjbb7TyrmON+9UHWhcH4UKSiqQa/W/K4rf/ibMa3hQKLrj8LfO5P
 Ja7xWg4yMeuJc2cLeo+nQcAQFEVrYL9EoYpXjsrpIN5zKB5rPAScXLGz3/4GTaO8K8kH
 O57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qqxI4t9USoPXl/JeHuyCe4X2D/XmhhmC7h27Axw+udQ=;
 b=K/G2hAsSq50f3H8HiHdhENxvqBTIX6ySorVjaYj2DRGGWo7vkBLQTJYfQNSlHlBj+2
 iryKqKx3ABa9phhYKulfcDv8CBepvyNcxVCGkwtRgqeY5JwAldUd2mdoMJwUNSIXQUh8
 pN/0Vk+J/aEy9PlIeHTn0hKGuM2b5XgXHL/WAV/eqovmWSwZ2CMvPI9iKcqcCaXtaVTe
 MoHW2eatYludqmRD7VaWkxxzPCooiNtnnCuBJyRLgrhO0hKUnw14bD1mXmX+vfULaNK2
 Sj+KrP6o3T1ZO0THx3wQfQ5JTyQ9kxpm7bvESiHeP31a0qoGDiq5VuDGuyWbZ46A0HJU
 Ieyg==
X-Gm-Message-State: APjAAAW1A04LSRfD4MXkJYogVXAtgU1EsTQpefMmw+1+xOcuWbVJRobj
 tubrtaekplZ4DRk+aNCbhO2pCg8lAgSk4uBBpVC0Vg==
X-Google-Smtp-Source: APXvYqyNOCrySGod8QA3BC5EBBZqk9MeXy2YqV0GnibpdtzqRWbeStOOOVeQ9r/mLSqJJyRqgi4C/DnC+TWWQH3ENdU=
X-Received: by 2002:a9d:398a:: with SMTP id y10mr17897600otb.97.1571666662819; 
 Mon, 21 Oct 2019 07:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190910193408.28917-1-alex.bennee@linaro.org>
 <20190910193408.28917-3-alex.bennee@linaro.org>
 <5be164f7-6a8a-07b8-8d16-18300638f9b5@vivier.eu>
In-Reply-To: <5be164f7-6a8a-07b8-8d16-18300638f9b5@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 15:04:11 +0100
Message-ID: <CAFEAcA9oCNT9t_WT8uMzit12J7=vDt4+W6UTqAbZZd3J8UytGg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/4] elf: move elf.h to elf/elf.h and
 split out types
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Cornelia Huck <cohuck@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Marek Vasut <marex@denx.de>,
 Jia Liu <proljc@gmail.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>, Fabien Chouteau <chouteau@adacore.com>,
 "open list:S390-ccw boot" <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Michael Walle <michael@walle.cc>,
 "open list:PReP" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 14:54, Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 10/09/2019 =C3=A0 21:34, Alex Benn=C3=A9e a =C3=A9crit :
> > Most of the users of elf.h just want the standard Elf definitions. The
> > couple that want more than that want an expansion based on ELF_CLASS
> > which can be used for size agnostic code. The later is moved into
> > elf/elf-types.inc.h to make it clearer what it is for. While doing
> > that I also removed the whitespace damage.
> >

> The patch looks good, but why did you call the file "elf-types.inc.h"
> and not "elf-types.h"?

This is our usual convention for files (well, that or .inc.c)
which get included multiple times with different preprocessor
defines to specify how they behave, i.e. which aren't standard
"simple header with multiple-inclusion protection guards".

thanks
-- PMM


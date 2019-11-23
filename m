Return-Path: <SRS0=9vyd=ZP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236BEC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 16:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AE32070E
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2019 16:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHiZd+KU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AE32070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYXpJ-0006cF-Tz
	for qemu-devel@archiver.kernel.org; Sat, 23 Nov 2019 11:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iYXoS-00065g-01
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 10:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iYXoQ-0000cn-Lt
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 10:59:07 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:41430)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iYXoQ-0000cQ-Hu
 for qemu-devel@nongnu.org; Sat, 23 Nov 2019 10:59:06 -0500
Received: by mail-qv1-xf43.google.com with SMTP id g18so4101534qvp.8
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2019 07:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=92+Pqlm4l7fvVj5OKxE6vnsj72BstZHnWnuso/Fh0n4=;
 b=PHiZd+KU4C8KW7WrHj31bTOkJVlaSzpWAfU2ea/XKLgz4SYM/UEXYjpUOm5ROJVb1Y
 WBP15skgOfjE+RvwttbmiEbuUTY1HTWbroPgXvrgrsWFfM4hiOVoGV5YMtA5ibuOtT5g
 vJtdESKSiPK/Vf6Rlguf9YLApWvFsETkwDRClF1I2wLDFa9MMzXsHepSya9x2M2Z8KGF
 sT9xJbBAoEQe0tJve/B0vpK9vPboUEnvkKjYZrxE9FFlZ+SuEW2hZ1b9uOK4VRnYdAD5
 FDQ+MYJT+HsTPD83uE3YTOVxpS0Ln+W9B4nsrAn+a8MMraAzPwbNMFk6XUIyXdNtB2NR
 wpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=92+Pqlm4l7fvVj5OKxE6vnsj72BstZHnWnuso/Fh0n4=;
 b=eJpZErCJWMc+F4rHXI+nZU7BdrRb49RruSd3h5G/71ijzU/0lupeDaw59fPaW+Stf7
 TBWwtF6zhtFEVfXzO+BJnnec5OdkPYi5iTe0hhU7IFBje+kMPZsCxrnogXIzCWex88k+
 acOy9t5TA9n8wueYsqXPFQYqnlGj4Npz4d/ReYNdlfWoyB+BcNCAajrOemHWXIYTWxp1
 POpbmiFAstDxffubaX6cI3hayPVeIT1z5ig+o8U+RnwNxoOePJ8LMVaWzA77j1T/w8uM
 bQhHG2TgsWgMOoLB+GMARqPPbGjq+32x+9xSmQ/5W0GTvMxDC/1PfPpjPHdO/+YITGBI
 bWVg==
X-Gm-Message-State: APjAAAUNGS7C0UeRHv74LuGfkiWKADZ2wdM4nUHJt0jp8qOE4/ibclmc
 jL3q45SwNUfbvzNmFf9Uu9/3ye76HE0EbFx8Sis=
X-Google-Smtp-Source: APXvYqyMPon1GvoCl8uRDfXKVRAilYw7zZDnuo2QVFxbuljfyLRkw65k59hMr2cdMwjFZ1GCYlMuooJfF6cNF75jkvs=
X-Received: by 2002:ad4:4cc4:: with SMTP id i4mr14565829qvz.137.1574524745533; 
 Sat, 23 Nov 2019 07:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <CAL1e-=ivdac0gi3bJvmm7knSPHx5fDPXpAHOuck3CJt+yX9Vgg@mail.gmail.com>
In-Reply-To: <CAL1e-=ivdac0gi3bJvmm7knSPHx5fDPXpAHOuck3CJt+yX9Vgg@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sat, 23 Nov 2019 17:58:07 +0200
Message-ID: <CAK4993gqJCW6u7A6dD7aaV6bYXh3Gm73n_AFtPk7WqFky2tVyg@mail.gmail.com>
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I believe I got this number from this spec
https://ww1.microchip.com/downloads/en/devicedoc/atmel-2549-8-bit-avr-microcontroller-atmega640-1280-1281-2560-2561_datasheet.pdf
on page 101

On Fri, Nov 22, 2019 at 7:28 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> > +#ifndef CONFIG_USER_ONLY
> > +    /* Set the number of interrupts supported by the CPU. */
> > +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 57);
> > +#endif
>
> Can you please, Michael, explain to me the origin of number "57" here?
>
> Thanks, Aleksandar



-- 
Best Regards,
Michael Rolnik


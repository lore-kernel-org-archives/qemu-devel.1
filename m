Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB5EC32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 23:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCE724655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 23:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCE724655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuPWt-0005Ya-3e
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 18:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iuPWH-000557-Pr
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 18:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iuPWG-0004fv-5j
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 18:34:45 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33709)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iuPWG-0004ed-1s
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 18:34:44 -0500
Received: by mail-yb1-f196.google.com with SMTP id n66so779455ybg.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 15:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=p3JtQI9ySBfm7oH4AM/PW2JBaje9ixT0EgEvYO6zcf4=;
 b=YvQpCePWyeVJdK8q6U2W/IT/JUNhOvJcG9t2ZSfAcRaq75FbuUba1TGbJCQEvRgBe/
 m9AkjAdEOV6mB9vKbwdgZEh00zhvN7ncacWXdi8aFn1iruv3XniBu3K1AwtMqqjw1RIt
 iPwiTiOAl9xv8DfK8CcD6C0HPVal/wEJRpb58CGeLGpAMbANFTd1DJjzjlPuOPWw7Kla
 1sQAznPUdrzGJOFUDdjmix8R1lAJpqeN5q7zXHEFXmGCVgfY6HRx81tUQdmsaZXVa8kq
 eKuGGyPdgmo7u5vRAEmAmoyGcUwehxV/3LpCdG/L3AcoB1bS9ZmMnkyYxtQ04ahmv+x4
 WW7A==
X-Gm-Message-State: APjAAAXDMCY8wYx+kBD79zoIizJ1yTxtp5bif0ZR/dRKSRY4Xe7f9chp
 q9cGL+g32c/2CxG98RTBYNZ9XCTtiUgZWbPyUBU=
X-Google-Smtp-Source: APXvYqzJHA9Q+qRyM2PA0dO5D6M+QzGM74QCmb6uAGmP1Go5CfA8DNbfux6DIEiGpBmQCzN27yzIKni5akhvGAt24Gs=
X-Received: by 2002:a25:e696:: with SMTP id d144mr9465761ybh.316.1579736081894; 
 Wed, 22 Jan 2020 15:34:41 -0800 (PST)
MIME-Version: 1.0
References: <20200122023256.27556-1-richard.henderson@linaro.org>
 <b7c91905-f1bb-a3ea-e39c-08a27b2ff36e@linaro.org>
 <da98d952-80e6-750a-3324-32723037b94f@redhat.com>
In-Reply-To: <da98d952-80e6-750a-3324-32723037b94f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 23 Jan 2020 00:34:30 +0100
Message-ID: <CAAdtpL6TYgkNP9Zd-E4Ar1HKfC8conSx74ozA+jObkOdoueUnw@mail.gmail.com>
Subject: Re: [PULL 00/11] target/hppa patch queue
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.196
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
Cc: Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 12:28 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 1/22/20 3:47 AM, Richard Henderson wrote:
> > On 1/21/20 4:32 PM, Richard Henderson wrote:
> >> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde=
0dd40:
> >>
> >>    Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-=
20200121' into staging (2020-01-21 15:29:25 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>    https://github.com/rth7680/qemu.git tags/pull-pa-20200121
> >>
> >> for you to fetch changes up to a66cfb7306b7cf7a023e11536fdd942f3f9276b=
9:
> >>
> >>    target/hppa: Allow, but diagnose, LDCW aligned only mod 4 (2020-01-=
21 15:51:54 -1000)
> >>
> >> ----------------------------------------------------------------
> >> Improve LASI emulation
> >> Add Artist graphics
> >> Fix main memory allocation
> >> Improve LDCW emulation wrt real hw
> >
> > Ho hum.  Cancel this.  It breaks the hppa boot-serial test.
>
> This is due to patch #7 "Add emulation of Artist graphics":
>
> 130     /* Graphics setup. */
> 131     if (machine->enable_graphics && vga_interface_type !=3D VGA_NONE)=
 {
> 132         dev =3D qdev_create(NULL, "artist");
> 133         qdev_init_nofail(dev);
> 134         s =3D SYS_BUS_DEVICE(dev);
> 135         sysbus_mmio_map(s, 0, LASI_GFX_HPA);
> 136         sysbus_mmio_map(s, 1, ARTIST_FB_ADDR);
> 137     }
>
> The hppa boot-serial test use the default options, so the Artist chipset
> is mapped, and the firmware test/use it.

Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Btw ;)

> We can test like the 40p, using VGA_NONE:
>
> -- >8 --
> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-tes=
t.c
> index 05c7f44457..971254ae62 100644
> --- a/tests/qtest/boot-serial-test.c
> +++ b/tests/qtest/boot-serial-test.c
> @@ -135,7 +135,7 @@ static testdef_t tests[] =3D {
>         sizeof(kernel_plml605), kernel_plml605 },
>       { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0,
> bios_moxiesim },
>       { "arm", "raspi2", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
> -    { "hppa", "hppa", "", "SeaBIOS wants SYSTEM HALT" },
> +    { "hppa", "hppa", "-vga none", "SeaBIOS wants SYSTEM HALT" },
>       { "aarch64", "virt", "-cpu cortex-a57", "TT", sizeof(kernel_aarch64=
),
>         kernel_aarch64 },
>       { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
> ---
>
> You should squash this change in patch #7 (because it belongs there) but
> please add a comment, because it is not obvious.
>
> Thanks,
>
> Phil.


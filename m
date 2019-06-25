Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB0AC4646C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0B320663
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 00:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeluVHmU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0B320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55674 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfZFV-0006XG-J1
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 20:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZEd-0005fh-1a
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hfZEb-0001oV-5E
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:22:54 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hfZEa-0001m0-Um
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 20:22:53 -0400
Received: by mail-oi1-x244.google.com with SMTP id f80so11205258oib.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=YlFB5FAa9b1uJIZ4pR4FNSYyOefBleji0707Gy7J4uo=;
 b=DeluVHmU0e/MXFWG8yfM3hPzSIwV0d8AvgrxZx0CxlzhIfQOT/3y2VygJQOMuHIBju
 GbJfFYlMD81Y75TSds1YhAmjUF096Q6DXnvrG2jRf3Cwpxpdpwol8qj5MuLGlcuGiBq4
 v42StoUjDvJ74EMaNb7BrIlRD0hV+R8gvMxQ13lBTTBMLU2keTtr5QuSwIH0bG1TfQV2
 y9/uOPhUrSJv4isHShjPWwyrE5ICE31yUNAKy7rveDa1FJsyEK7yx0qSoydG64KBI8lz
 lFvC6+FgRCqit0fcK6QO7qgntbwBgMWqUtAdXnYaQyjXl7Dl6gYg5Ixm0xtjKcVrfQuv
 DdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=YlFB5FAa9b1uJIZ4pR4FNSYyOefBleji0707Gy7J4uo=;
 b=PF3YezuG3+pQeM5TTTcJ0nhJFteyk5zZiWerOA4zmR1M1XHgcMbma1y+F7IAj9SBuX
 PVMFI55Lx1sm/xKk0OfwBf69r55+EA+basuNHjr6wP/NgpxkT2JMqvfXQKp/5HaZX7xl
 E5ULQ0ZFUnvY2SZQ0BYiJ4wcof2CPnbV7IREpI5nOsLwpzIlqzyi2aBArRiydaV3qFon
 X9OnF1nfs9nZ09khYDeTt7Sz1XrYtCDGiBFdYHCNf8f97poWxk2PJ4D/6DcPN++X9m7S
 PydFzamOvU8wTW6DcQQ5/Ue5rWwIlHdleqqK7eJ4PdyFqGjiKeN1YZ4vS2gXqyHnQB3e
 C82g==
X-Gm-Message-State: APjAAAXxcxySvmTQMm01KlyNiuimySSpLi/idKGq/t0WgtMaQXKAlKt6
 jaBefcP+felSz88G/RK7y0astmk96R4c6Cd46Nw=
X-Google-Smtp-Source: APXvYqxnJamzqgDuAGekT+6K2hRRA2sAprCzfuNc9drAKWpJ4L2lbEIIqjqH6bGozeKYFychOYSYvg7Ow+nU2ElAT4g=
X-Received: by 2002:aca:b254:: with SMTP id b81mr7962486oif.53.1561422172047; 
 Mon, 24 Jun 2019 17:22:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:22:51
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 24 Jun 2019 17:22:51
 -0700 (PDT)
In-Reply-To: <20190624222844.26584-4-f4bug@amsat.org>
References: <20190624222844.26584-1-f4bug@amsat.org>
 <20190624222844.26584-4-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 25 Jun 2019 02:22:51 +0200
Message-ID: <CAL1e-=g_LjNOpGmua=FnmXASHQG2HOJUmXDOFTJfkdKKmRJhjg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 03/10] hw/mips/gt64xxx_pci: Fix 'braces'
 coding style issues
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 25, 2019 12:38 AM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> w=
rote:
>
> Since we'll move this code around, fix its style first:
>
>   ERROR: braces {} are necessary for all arms of this statement
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  hw/mips/gt64xxx_pci.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
> index bbd719f091..cfd497960c 100644
> --- a/hw/mips/gt64xxx_pci.c
> +++ b/hw/mips/gt64xxx_pci.c
> @@ -257,19 +257,25 @@ static void check_reserved_space(hwaddr *start,
hwaddr *length)
>      hwaddr begin =3D *start;
>      hwaddr end =3D *start + *length;
>
> -    if (end >=3D 0x1e000000LL && end < 0x1f100000LL)
> +    if (end >=3D 0x1e000000LL && end < 0x1f100000LL) {
>          end =3D 0x1e000000LL;
> -    if (begin >=3D 0x1e000000LL && begin < 0x1f100000LL)
> +    }
> +    if (begin >=3D 0x1e000000LL && begin < 0x1f100000LL) {
>          begin =3D 0x1f100000LL;
> -    if (end >=3D 0x1fc00000LL && end < 0x1fd00000LL)
> +    }
> +    if (end >=3D 0x1fc00000LL && end < 0x1fd00000LL) {
>          end =3D 0x1fc00000LL;
> -    if (begin >=3D 0x1fc00000LL && begin < 0x1fd00000LL)
> +    }
> +    if (begin >=3D 0x1fc00000LL && begin < 0x1fd00000LL) {
>          begin =3D 0x1fd00000LL;
> +    }
>      /* XXX: This is broken when a reserved range splits the requested
range */
> -    if (end >=3D 0x1f100000LL && begin < 0x1e000000LL)
> +    if (end >=3D 0x1f100000LL && begin < 0x1e000000LL) {
>          end =3D 0x1e000000LL;
> -    if (end >=3D 0x1fd00000LL && begin < 0x1fc00000LL)
> +    }
> +    if (end >=3D 0x1fd00000LL && begin < 0x1fc00000LL) {
>          end =3D 0x1fc00000LL;
> +    }
>
>      *start =3D begin;
>      *length =3D end - begin;
> @@ -385,8 +391,9 @@ static void gt64120_writel (void *opaque, hwaddr addr=
,
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
>      uint32_t saddr;
>
> -    if (!(s->regs[GT_CPU] & 0x00001000))
> +    if (!(s->regs[GT_CPU] & 0x00001000)) {
>          val =3D bswap32(val);
> +    }
>
>      saddr =3D (addr & 0xfff) >> 2;
>      switch (saddr) {
> @@ -937,8 +944,9 @@ static uint64_t gt64120_readl (void *opaque,
>          break;
>      }
>
> -    if (!(s->regs[GT_CPU] & 0x00001000))
> +    if (!(s->regs[GT_CPU] & 0x00001000)) {
>          val =3D bswap32(val);
> +    }
>
>      return val;
>  }
> @@ -990,8 +998,9 @@ static void gt64120_pci_set_irq(void *opaque, int
irq_num, int level)
>          /* The pic level is the logical OR of all the PCI irqs mapped to
it. */
>          pic_level =3D 0;
>          for (i =3D 0; i < 4; i++) {
> -            if (pic_irq =3D=3D piix4_dev->config[0x60 + i])
> +            if (pic_irq =3D=3D piix4_dev->config[0x60 + i]) {
>                  pic_level |=3D pci_irq_levels[i];
> +            }
>          }
>          qemu_set_irq(pic[pic_irq], pic_level);
>      }
> --
> 2.19.1
>
>

Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35194C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25C720578
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 08:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="c3IBFCqW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25C720578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOHPi-0002UV-0R
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 04:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1jOHN7-0000hN-IY
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:56:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1jOHN6-0006as-9e
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:56:45 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:34362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>) id 1jOHN6-0006af-0K
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 04:56:44 -0400
Received: by mail-qv1-xf44.google.com with SMTP id s18so5816506qvn.1
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=oXVl7JGM5FgUXAZLpn1J+Gitv8HOpvr8xnI60hThb24=;
 b=c3IBFCqWX+4FDOOQylp75S/WkCp7GPH8BN/pA+EtElvMU8+3Cfey1tbFc9oW+syE5P
 HbGGlt03GHnqMdLvxt66bEmunnkvswfWsAlgJbYmwhJbEPiIgG2P0otqv3ddQwhDn5Ix
 M/ZX8NplU1nDNyGmAbEvuvMaPlW9QQlExmyDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=oXVl7JGM5FgUXAZLpn1J+Gitv8HOpvr8xnI60hThb24=;
 b=diZZRGow05N5Oum9FCST+RWP1R9CjCZ1r1zUzhKOYxK0sLTaQj9vNi0iJwD6SBDVk8
 2gC5NifwuZnqNQbcq0cswFAZ7r9K68tcZz/lapuESsCBJ+ltsTnBVA6fcB6sURyoqEjo
 7cAlS4QpXecVOHBe7jUBmsQ9ycETK4O4x/lkqVVyg+uTyvg2nqBcB04+DMr0OPTILzrl
 OyyvXUvZtizqJcwBC99U+jn4rJYz+5I8pmZzNhWP6TPap6kW6mU3bDayT1RjVb5eawD4
 qlavTnejdDNmXMN/bDNwm4ECOlc+QF3s31CWkEkJjPORkS0xNumK4xBUS6Sd8q1UoWn/
 mj0w==
X-Gm-Message-State: AGi0Pua6mgeuNZ1+Rcn+9Cl1jGqm8HLdaDULEBENmLCDxbMVCp3rdJtQ
 2pwXQB9SSNPrT3dQJIEYDSUcm9pEiuO96kRpeKg=
X-Google-Smtp-Source: APiQypK/iyzXFSoqyVxxI9voiamveWjN5YwFTcgziCRcFDSL36dyuUQnmi6JbN6P+8YAKXiO4GQaXJlBclDZT8UiVkY=
X-Received: by 2002:a05:6214:40f:: with SMTP id
 z15mr8627296qvx.210.1586854602750; 
 Tue, 14 Apr 2020 01:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <0b02fe788de99120894f87f6d5c60e15d6a75d85.1586213450.git.dirty@apple.com>
 <6aac0d31-d0a4-d103-e3b5-89feef27c018@redhat.com>
 <BFA58F3C-CA4F-4ADF-854F-2658134D3888@apple.com>
In-Reply-To: <BFA58F3C-CA4F-4ADF-854F-2658134D3888@apple.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 14 Apr 2020 08:56:31 +0000
Message-ID: <CACPK8XfsjYhXPBdUj4=BfKpfRk-na1aetUksSdOZzqpunJaGEQ@mail.gmail.com>
Subject: Re: [PATCH v1] nrf51: Fix last GPIO CNF address
To: Cameron Esfahani <dirty@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 10:09, Cameron Esfahani <dirty@apple.com> wrote:
>
> I'm not burying anything.  This patch is stand alone and all the tests do=
 work.  They work with or without Cedric's nee Andrew's patch.  But, if som=
e derivative of that patch is eventually implemented, something needs to be=
 done for this NRF51 gpio qtest to work.
>
> There are two possibilities for the following qtest in microbit-test.c:
>
> >     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_EN=
D) & 0x01;
> >     g_assert_cmpuint(actual, =3D=3D, 0x01);
>
>
> 1 - The code is purposefully reading 32-bits from an unaligned address wh=
ich only partially refers to a documented register.  And the only reason th=
is code works is because that 32-bit value is turned into a 8-bit read.  An=
d if that's the case, then someone should update a comment in the test to i=
ndicate that this is being done purposefully.
> 2 - NRF51_GPIO_REG_CNF_END is incorrectly set to be 0x77F.  Looking at th=
e documentation for this chip, the last defined CNF register starts at 0x77=
C.
>
> The NRF51 doesn't support unaligned accesses, so I assume that possibilit=
y 1 isn't true.
>
> So, is NRF51_GPIO_REG_CNF_END supposed to refer to a valid register, or t=
he end of the implementation space?
>
> If it's the former, then it should be adjusted to 0x77c and possibly upda=
te the below code in nrf51_gpio.c (line 156):
>
> >     case NRF51_GPIO_REG_CNF_START ... NRF51_GPIO_REG_CNF_END:
>
>
> to become
>
> >     case NRF51_GPIO_REG_CNF_START ... NRF51_GPIO_REG_CNF_END + 3:
>
> if unaligned access are expected to work.  But, considering the NRF51 doe=
sn't support unaligned accesses, I don't think this appropriate.
>
> If it's the latter, then the test cases in microbit-test.c should be upda=
ted to something like the following:
>
> >     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_EN=
D - 3) & 0x01;
> >     g_assert_cmpuint(actual, =3D=3D, 0x01);


Your reasoning is sound, thanks for writing it out. I would be happy
to see your patch land.

Reviewed-by: Joel Stanley <joel@jms.id.au>


>
>
> Cameron Esfahani
> dirty@apple.com
>
> "Americans are very skilled at creating a custom meaning from something t=
hat's mass-produced."
>
> Ann Powers
>
>
> > On Apr 7, 2020, at 1:44 AM, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
> >
> >> Considering NRF51 doesn't support unaligned accesses, the simplest fix
> >> is to actually set NRF51_GPIO_REG_CNF_END to the start of the last val=
id
> >> CNF register: 0x77c.
> >
> > NAck. You are burying bugs deeper. This test has to work.
> >
> > What would be helpful is qtests with unaligned accesses (expected to wo=
rk) such your USB XHCI VERSION example.
>


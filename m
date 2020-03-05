Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E1DC3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C977820716
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 18:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0je2bOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C977820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9veg-00011I-04
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 13:55:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j9vdr-0008L9-4l
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 13:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j9vdq-00031b-5j
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 13:54:43 -0500
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:36069)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j9vdq-00030U-1k; Thu, 05 Mar 2020 13:54:42 -0500
Received: by mail-ua1-x941.google.com with SMTP id 8so1633456uar.3;
 Thu, 05 Mar 2020 10:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4ccAzLE5mOex00atH+3ibjDE0M2w31Q1GeIWisoI3V8=;
 b=M0je2bOREpJY9kDPQeRAiRVwI/6L5vd4zRRSQ8EG7q77YROj6qcj9EtnxcLU6BqeDC
 HXEKmEERNeM2IYqHZ1n87gN08mwgVbAzYZdVj0pJWSIXGqME1anhjZ8gUQTb/cFLNX2q
 TDw8DnQeTSpj5WgVQmC5I1yaYo+hlh3E43fcgfYZrZG1KlA6+vgTLvEktWrgaLItFPV6
 n5E1e/0hzGA2Q1bb9WEujDqQvupHoY0tV2lkO8HaWJCf6sjNyZKtApRO5HJnuVJawNYk
 /ewaP3um5bveMh+MTxqZhOrLC64JsC9BnzTwDELTLDv+nQ6zZKm48ZQ3J/kicw3IuZAa
 glew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4ccAzLE5mOex00atH+3ibjDE0M2w31Q1GeIWisoI3V8=;
 b=shZmqJ/+vBxZhuCM1SYPVl1RoY80DydGJ0LxxPZcD2otMSkwu6vlWHSLvrPTquU6Nj
 mzWxBFh/ghfPOYm0I0oewTBlhubt+nTkXRrB0UGuSI88jRs3oxrlAzJuNTXuHaqOygYM
 0apkkV+YN+LmMfzqhxgy//juQ+HQQCRMxafrswOvvVAlWuUYufFYlyKvoxO2HoTFnHtn
 yq5+xDtT+hwPpwGXaMHvKkuRS74hw745gdzkx2yOMV2FDPXRr6HY5fF9VmWj28xoEvzA
 aAHSL9/FeCaazUeXnZhhVRy/p1hAyLuo1dBhIhbAZo+zrQDS0xkAAbb1H9qg2Sn9u43R
 nHtQ==
X-Gm-Message-State: ANhLgQ3Cr2RBUg+0vUvKWEIelhIc9O6w6tsug0zdHtXviWlb/ZjmKup9
 /VQMiJKQDd2ajXsO6QFWQ3W/EaJH4SvChQCdK4Y=
X-Google-Smtp-Source: ADFU+vuL6GMuIOjCawEGirbjL3YloDRp4DSxlPEA2bXWaKFxyjsemJvpflyLrUogAxibFSmoO8bLx1QSk3I8MUxblIE=
X-Received: by 2002:ab0:143:: with SMTP id 61mr5554738uak.85.1583434481347;
 Thu, 05 Mar 2020 10:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20200305175651.4563-1-philmd@redhat.com>
 <20200305175651.4563-3-philmd@redhat.com>
In-Reply-To: <20200305175651.4563-3-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2020 10:46:59 -0800
Message-ID: <CAKmqyKPmBZatnDW248EJ2YrDaW3+6Q1R9n1so9_j_zfy2KtW1g@mail.gmail.com>
Subject: Re: [PATCH 2/6] hw/net/smc91c111: Let smc91c111_can_receive() return
 a boolean
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::941
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
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, "open list:New World" <qemu-ppc@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 5, 2020 at 9:57 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> The smc91c111_can_receive() function simply returns a boolean value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/net/smc91c111.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
> index e9eb6f6c05..02be60c955 100644
> --- a/hw/net/smc91c111.c
> +++ b/hw/net/smc91c111.c
> @@ -130,16 +130,16 @@ static void smc91c111_update(smc91c111_state *s)
>      qemu_set_irq(s->irq, level);
>  }
>
> -static int smc91c111_can_receive(smc91c111_state *s)
> +static bool smc91c111_can_receive(smc91c111_state *s)
>  {
>      if ((s->rcr & RCR_RXEN) =3D=3D 0 || (s->rcr & RCR_SOFT_RST)) {
> -        return 1;
> +        return true;
>      }
>      if (s->allocated =3D=3D (1 << NUM_PACKETS) - 1 ||
>          s->rx_fifo_len =3D=3D NUM_PACKETS) {
> -        return 0;
> +        return false;
>      }
> -    return 1;
> +    return true;
>  }
>
>  static inline void smc91c111_flush_queued_packets(smc91c111_state *s)
> --
> 2.21.1
>
>


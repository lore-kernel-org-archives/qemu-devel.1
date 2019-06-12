Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB28C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 04:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C4920874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 04:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adurxUCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C4920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haust-0001BW-4C
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 00:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47623)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rfried.dev@gmail.com>) id 1haur8-0000CY-MI
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 00:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rfried.dev@gmail.com>) id 1haur5-0000DU-Bq
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 00:27:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rfried.dev@gmail.com>)
 id 1haur2-0000BU-P1; Wed, 12 Jun 2019 00:27:21 -0400
Received: by mail-wm1-x343.google.com with SMTP id c6so5005291wml.0;
 Tue, 11 Jun 2019 21:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6UxwC0ymJP8ogQd9UCjvoNCmzs0LP9ZM8oQ4bYoDNg4=;
 b=adurxUCRImfJjgzh5IJtAqnsOOXkGqEDkPKNAJWiCOoTXattqHnMZivN//bQ0lRW4X
 o5qjY79iNjMEoMD+0fBYvAt2FKvVyDo5jCDVSnQIuqK2Sc09oNigwjjuwOYwdc0ddraL
 h0zviyWRiTn+maRB54nohp9UKMQgclbnCzKSmBKxVByUM0lQ66SLbM6cVW1aCLDp8SZX
 otBIGNdGMOP/VUdqfj1McLtUVOUWzFa6GtHzzdZu1qdyUHtpmodGVudNKXUiiAoBwfm8
 dCEizCZCkK/iUNOdJDVm4hziky6SWMEAFY4dR0kPdJ9e/qz2ubk1Kb6pH6wW8X+8UWMH
 te6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6UxwC0ymJP8ogQd9UCjvoNCmzs0LP9ZM8oQ4bYoDNg4=;
 b=RUp59wlaIuqwrRysBf0FkGOaH9TWn71pf2DuM9iazj632feuXhwQVbG62JxeLXrRNv
 IDG7VP+Sy+NgmNn66XJExn3zSzvTWGpi18m7J1c6tl/G4UowDRptTDsPun8B7rB5d2B6
 p+SGk/ALQHyh6njDShwnF3wrQC3r6ofwxH1FWryZUMjFb2fJTzlf42mFvgsl4VdqC5L3
 aHuD594CKQozZbXwe/PSy1hvzhX7c5rC2rrl6k1uDrEI49Yyxstkvq1UbX9kXPDH+O7n
 /phIpxqsEZSQyeiWHF070etU+oHH5TFBwpagXw5cR40TgsgviLv5T7melkoWhsU/S5J8
 t1XA==
X-Gm-Message-State: APjAAAWqssWuuJxqxcT3X6AS1MGxho/uahHdJzgT2Og5gMON4yDVljaW
 /qNpMQwHoiTxdfNVd2RPoExTGePi9slm3Ae55Jc=
X-Google-Smtp-Source: APXvYqxckT5d6UTcR0oJzqr9QZbIRLyz+40WFuEO7YxnDwJYpWzQQAs1RUmRTxiYpQyx/Rq5ivjTjKptuuYsyjyR7b0=
X-Received: by 2002:a1c:b782:: with SMTP id h124mr20102797wmf.20.1560313639025; 
 Tue, 11 Jun 2019 21:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190611145556.12940-1-rfried.dev@gmail.com>
 <f826d073-da60-96f0-9a37-c33761844cc2@vivier.eu>
In-Reply-To: <f826d073-da60-96f0-9a37-c33761844cc2@vivier.eu>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Wed, 12 Jun 2019 07:27:08 +0300
Message-ID: <CAGi-RUL2QThfiYPeZOE6iuryxT7Daj-y-Q=SSgUBRFcDsWP+zw@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2] net: cadence_gem: fix compilation error
 when debug is on
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 11, 2019 at 7:21 PM Laurent Vivier <laurent@vivier.eu> wrote:

> Le 11/06/2019 =C3=A0 16:55, Ramon Fried a =C3=A9crit :
> > defining CADENCE_GEM_ERR_DEBUG causes compilation
> > errors, fix that.
> >
> > Signed-off-by: Ramon Fried <rfried.dev@gmail.com>
> > ---
> > v2: change %lx to HWADDR_PRIx and %lx to %zdx
>
> HWADDR_PRIx is to use with hwaddr type (packet_desc_addr).
> rx_desc_get_buffer() is uint64_t, you must use PRIx64.
> It may be better to remove also the cast to unsigned.
>
Other places in the code also use HWADDR_PRIx with  rx_desc_get_buffer().
Should I change them also ?

>
> Thanks,
> Laurent
> >
> >  hw/net/cadence_gem.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index 7f63411430..e9b1b1e2eb 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -982,8 +982,8 @@ static ssize_t gem_receive(NetClientState *nc, cons=
t
> uint8_t *buf, size_t size)
> >              return -1;
> >          }
> >
> > -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy,
> rxbufsize),
> > -                rx_desc_get_buffer(s->rx_desc[q]));
> > +        DB_PRINT("copy %d bytes to 0x%" HWADDR_PRIx "\n",
> MIN(bytes_to_copy, rxbufsize),
> > +                rx_desc_get_buffer(s, s->rx_desc[q]));
> >
> >          /* Copy packet data to emulated DMA buffer */
> >          address_space_write(&s->dma_as, rx_desc_get_buffer(s,
> s->rx_desc[q]) +
> > @@ -1156,7 +1156,7 @@ static void gem_transmit(CadenceGEMState *s)
> >              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
> >                                                 (p - tx_packet)) {
> >                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x
> space " \
> > -                         "0x%x\n", (unsigned)packet_desc_addr,
> > +                         "0x%zdx\n", (unsigned)packet_desc_addr,
> >                           (unsigned)tx_desc_get_length(desc),
> >                           sizeof(tx_packet) - (p - tx_packet));
> >                  break;
> >
>
>

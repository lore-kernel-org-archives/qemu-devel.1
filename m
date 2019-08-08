Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F75C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 04:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FF4217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 04:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t3BHiiqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FF4217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvaJW-0002u6-45
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 00:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52092)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvaIy-0001sn-2z
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvaIx-00059z-58
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:45:36 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:38581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvaIv-000599-3h; Thu, 08 Aug 2019 00:45:33 -0400
Received: by mail-ed1-x544.google.com with SMTP id r12so54128743edo.5;
 Wed, 07 Aug 2019 21:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qCY9EiUe/9gn3nO08CIKw8D1hOmiv1y+XsfoedLw25w=;
 b=t3BHiiqXe1M351XyysHIBGaMnBbhRX5ZdeIdumG10v15Cce17zb+ciSowuoNuQkFjT
 pLWgETo/dCoSN++fLpjxw7G18aIRDJxYcFWa7KREj9d5u7I4nCh28rxkntCF31GHlCqZ
 AOn5R9RDkfpM5YQ7Gg9wzlMrh0U/BARnYevT46mns8NtVWB1DqtSkmblqDKtMz6HBax+
 1MOJEWGL4TwlWMyV76wGICbgdEmdbXPuubo4Yu2ZhuJZIBdSjgPlMb8xIdRxRyEI6hJG
 aLnRZTzcNJ9pr6cb4MJ6QoV9uhYq+63o1gpjoEQ6ilrVKfqwtsc1y8Aw9oq79Cujcq2f
 Dybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qCY9EiUe/9gn3nO08CIKw8D1hOmiv1y+XsfoedLw25w=;
 b=C5KCWj9VUUokUv1dCFFfOZvCIfs9fxYO4VV6go34eweZ0FNzjDp5qLAkd1u7ae3h3I
 K1igEXWWetICDudTJ2w8nigKYWKxnGX2wNEnGzvMMZ6chzxoUKo6jLLodavPDPL+xUuP
 cyLeNDyb7GKNJlWhxeZyb4fvJZ8oiX2WVo5gq0bHU/TtH6yyOJ1q+iS+HeiEMFBWAEEQ
 /vJmyGUOeuzS+ffTdaMFeuYla+6a7RKiAkBi/UXi9Gai2k679FQJISvLJVJgZADSgKx9
 8bN5LweumZo6l6d0PlbW4Wt2GlwhJElPz67BJZy+Tk2h02T23EFC54LgWuG0DMf7fAu7
 yT7A==
X-Gm-Message-State: APjAAAWnO14TUmnhIP7HaH1O5TYCXKrLpDWW8cJp6NH+CnArhrF9ZUbD
 BcErd73wJruShUdXkW1L4Fr6X0X6xneYE0jWNl8=
X-Google-Smtp-Source: APXvYqyfLG59RE8ItdqYwL53QZB697GSltJefdFjjG2mdPBD5MF/lL9kEVUvznKe6XAkjoIXmWg8LrxmSK+7AtiZGII=
X-Received: by 2002:a50:886a:: with SMTP id c39mr13681566edc.214.1565239531883; 
 Wed, 07 Aug 2019 21:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <1565020374-23888-1-git-send-email-bmeng.cn@gmail.com>
 <20190806105739.ypoa545l4vigsscg@steredhat>
In-Reply-To: <20190806105739.ypoa545l4vigsscg@steredhat>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 8 Aug 2019 12:45:21 +0800
Message-ID: <CAEUhbmV10=Diih7Cy7c1GweA8FeMhLaKUa6PXpSj8wy2Yn_Rww@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH] hw: net: cadence_gem: Fix build errors in
 DB_PRINT()
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 6, 2019 at 6:57 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Mon, Aug 05, 2019 at 08:52:54AM -0700, Bin Meng wrote:
> > When CADENCE_GEM_ERR_DEBUG is turned on, there are several
> > compilation errors in DB_PRINT(). Fix them.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >
> >  hw/net/cadence_gem.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> > index d412085..7516e8f 100644
> > --- a/hw/net/cadence_gem.c
> > +++ b/hw/net/cadence_gem.c
> > @@ -983,8 +983,9 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
> >              return -1;
> >          }
> >
> > -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbufsize),
> > -                rx_desc_get_buffer(s->rx_desc[q]));
> > +        DB_PRINT("copy %d bytes to " TARGET_FMT_plx "\n",
> > +                 MIN(bytes_to_copy, rxbufsize),
> > +                 rx_desc_get_buffer(s, s->rx_desc[q]));
> >
> >          /* Copy packet data to emulated DMA buffer */
> >          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
> > @@ -1157,7 +1158,7 @@ static void gem_transmit(CadenceGEMState *s)
> >              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
> >                                                 (p - tx_packet)) {
> >                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x space " \
> > -                         "0x%x\n", (unsigned)packet_desc_addr,
> > +                         "0x%lx\n", (unsigned)packet_desc_addr,
>
> What about using 'z' modifier? I mean "0x%zx" to print sizeof(..).

Yes, good idea. Will do in v2. Thanks!

Regards,
Bin


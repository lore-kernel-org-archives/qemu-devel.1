Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C9FC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 07:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23EC12173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 07:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhbBijbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EC12173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvchG-0008P2-Et
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 03:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53865)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvcgs-0007yA-18
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hvcgq-0004u5-QC
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:18:25 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:38230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hvcgq-0004tU-FM; Thu, 08 Aug 2019 03:18:24 -0400
Received: by mail-ed1-x543.google.com with SMTP id r12so54703130edo.5;
 Thu, 08 Aug 2019 00:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZcGDwA8WEMKjLeZ88L4frOeRmu3KrKH/8jsIm4GocKY=;
 b=fhbBijbllxNcSWdBOGcJeePJLzixVIM9BKioQ3bcHoyRTN5cEnyJcWDfO6vzJeMLZt
 0ls6ZKuWfE7sPg4Did+IEt+Bh8gHlNWgLj4P0qksAE6wdV3dTcHnYP2qbpFJP2ZKtjr1
 WKHwfXGwebYNKyLd3ITF5r/THTEJ2cGK31K7MKwCFG0ACpzhqIpZ7YM/lN64TCIy5IwZ
 obdUEiXE6FtYZ4hy86ZE0U0MsEcPf3LlV9966fB6bQJDx1rqIKEy2v5/T9jLBfbok4D6
 qzv7QgLcxZO2LOAwu+ljwRetV8eiYzqj45vn3ZaxokwlRGHkoNUDbYlIwWNHC3EYUTMc
 yApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZcGDwA8WEMKjLeZ88L4frOeRmu3KrKH/8jsIm4GocKY=;
 b=LaWcBQNgE2I/jdQVrRJtFiNtZrojqOwzT95YY9/f2/e0RF3MKTp0BylFHoPC5I7eY8
 FrH8c3/j/fp9sy71UeYsaoHgp7CsJhKUbRhWiYtQ7iTI135t/Wq786UlVLpLM8crlGtb
 OCtb+YstDUgf2s457JP9YugGDbSEcaDnKyomz81jJMAT79zhPnBjLEta0WkVlsRrJ4Vy
 YV+Lblox5CjiTKXyLYyKxwHFpljXlpu+PgZDpy+x0y4qXOYDF0WKzfrdiVku3VxtX5Rb
 wafVMqfiZ96qbgyLDzvM2ESnW6tRsiB197NSnjr6Zi7MIerZleCp3aAVLpUQkr/sFRFj
 9QSA==
X-Gm-Message-State: APjAAAXRDE6NvDRCv1HtNFmHf+W+XG72vklGaOkbs8bvp6HbeTu89L/E
 tCA2v5zu9zFT3TNFVS1gm+YxGJZfYV0XdTx3jMY=
X-Google-Smtp-Source: APXvYqzbDMVDwJ5VOYpZ95oSlwuzAf3cw/8FeO3NWmZzFsZKgQIJ+ZX1jlpOuhZDV73yFWQnS8oBtUsVF/7xJF5epBo=
X-Received: by 2002:a17:906:fc5:: with SMTP id
 c5mr12029089ejk.129.1565248703116; 
 Thu, 08 Aug 2019 00:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <1565020374-23888-1-git-send-email-bmeng.cn@gmail.com>
 <1565239479-2130-1-git-send-email-bmeng.cn@gmail.com>
 <d0ca78ec-c5d4-bc80-6f2e-3e933013b5f4@redhat.com>
 <CAEUhbmVKnUkJ66A-mULpkqZppb=2c8NVAFJhZhOMpOdyRRxSQQ@mail.gmail.com>
 <1070f952-68d2-8849-bac8-4b58ab10ed9b@redhat.com>
In-Reply-To: <1070f952-68d2-8849-bac8-4b58ab10ed9b@redhat.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 8 Aug 2019 15:18:12 +0800
Message-ID: <CAEUhbmWadx1W66F1g8OWJK6mrB-0F7iWQO0hN9tw2eg1w+JDTg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v2] hw: net: cadence_gem: Fix build errors
 in DB_PRINT()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 8, 2019 at 3:01 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> On 8/8/19 8:36 AM, Bin Meng wrote:
> > On Thu, Aug 8, 2019 at 1:21 PM Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com> wrote:
> >>
> >> Hi,
> >>
> >> On 8/8/19 6:44 AM, Bin Meng wrote:
> >>> When CADENCE_GEM_ERR_DEBUG is turned on, there are several
> >>> compilation errors in DB_PRINT(). Fix them.
> >>>
> >>> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >>>
> >>> ---
> >>>
> >>> Changes in v2:
> >>
> >> Please don't reply to previous version, post as a new thread (it is
> >> harder to notice your new versions in a emails threaded view).
> >>
> >
> > OK.
> >
> >>> - use HWADDR_PRIx instead of TARGET_FMT_plx for consistency
> >>> - use 'z' modifier to print sizeof(..)
> >>>
> >>>  hw/net/cadence_gem.c | 7 ++++---
> >>>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> >>> index d412085..b6ff2c1 100644
> >>> --- a/hw/net/cadence_gem.c
> >>> +++ b/hw/net/cadence_gem.c
> >>> @@ -983,8 +983,9 @@ static ssize_t gem_receive(NetClientState *nc, co=
nst uint8_t *buf, size_t size)
> >>>              return -1;
> >>>          }
> >>>
> >>> -        DB_PRINT("copy %d bytes to 0x%x\n", MIN(bytes_to_copy, rxbuf=
size),
> >>> -                rx_desc_get_buffer(s->rx_desc[q]));
> >>> +        DB_PRINT("copy %d bytes to 0x%" HWADDR_PRIx "\n",
> >>
> >> rx_desc_get_buffer() returns a uint64_t, shouldn't you use a PRIx64
> >> format here?
> >
> > HWADDR_PRIx expands to PRIx64. I got your point that since it does not
> > return hwaddr, so we should use PRIx64 directly. Correct?
> >
> >>
> >>> +                 MIN(bytes_to_copy, rxbufsize),
> >>
> >> Nitpick #1: since you are cleaning this file up, bytes_to_copy and
> >> rxbufsize are both unsigned, so the first format should be %u instead =
of %d.
> >
> > Sure, will do in v3.
> >
> >>
> >>> +                 rx_desc_get_buffer(s, s->rx_desc[q]));
> >>>
> >>>          /* Copy packet data to emulated DMA buffer */
> >>>          address_space_write(&s->dma_as, rx_desc_get_buffer(s, s->rx_=
desc[q]) +
> >>> @@ -1157,7 +1158,7 @@ static void gem_transmit(CadenceGEMState *s)
> >>>              if (tx_desc_get_length(desc) > sizeof(tx_packet) -
> >>>                                                 (p - tx_packet)) {
> >>>                  DB_PRINT("TX descriptor @ 0x%x too large: size 0x%x =
space " \
> >>> -                         "0x%x\n", (unsigned)packet_desc_addr,
> >>> +                         "0x%zx\n", (unsigned)packet_desc_addr,
> >>
> >> Nitpick #2: packet_desc_addr is of type hwaddr, so removing the cast t=
he
> >> 1st format is HWADDR_PRIx, also removing the 2nd cast the 2nd format i=
s
> >> PRIx64.
> >
> > packet_desc_addr() return unsigned, so %x should be OK.
>
> 'packet_desc_addr' is of type hwaddr,

Ah, a typo! I meant to say: tx_desc_get_length() returns unsigned, so
just removing the 2nd cast is correct. But you wanted to change to
PRIx64 which I don't understand.

> '(unsigned)packet_desc_addr' is casted to type unsigned.
>
> Anyhow I now remember I already reviewed this patch:
> https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg03263.html
>

OK, looks the same issue was discovered by someone else :)

Regards,
Bin


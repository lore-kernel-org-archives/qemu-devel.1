Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AEAC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 14:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFE221655
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 14:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFE221655
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kU9EC-00085b-52
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 10:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kU9Cu-0007Qp-5A
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 09:58:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:33088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kU9Cr-0007PG-52
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 09:58:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8E994747625;
 Sun, 18 Oct 2020 15:58:27 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E99B2747605; Sun, 18 Oct 2020 15:58:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E8217747620;
 Sun, 18 Oct 2020 15:58:26 +0200 (CEST)
Date: Sun, 18 Oct 2020 15:58:26 +0200 (CEST)
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] ati: mask x y display parameter values
In-Reply-To: <20201018120852.1415440-1-ppandit@redhat.com>
Message-ID: <607d183b-8885-583f-de2a-ee693e641a50@eik.bme.hu>
References: <20201018120852.1415440-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Gaoning Pan <pgn@zju.edu.cn>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Sun, 18 Oct 2020, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> The source and destination x,y display parameters in ati_2d_blt()
> may run off the vga limits if either of s->regs.[src|dst]_[xy] is
> zero. Mask the register values to avoid potential crash.
>
> Reported-by: Gaoning Pan <pgn@zju.edu.cn>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
> hw/display/ati_2d.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 23a8ae0cd8..524bc03a83 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -53,10 +53,10 @@ void ati_2d_blt(ATIVGAState *s)
>             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
>             surface_bits_per_pixel(ds),
>             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
> -    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
> -    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
> +    unsigned dst_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ? s->regs.dst_x
> +                        : (s->regs.dst_x + 1 - s->regs.dst_width) & 0x3fff);
> +    unsigned dst_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ? s->regs.dst_y
> +                        : (s->regs.dst_y + 1 - s->regs.dst_height) & 0x3fff);

I don't think that's the correct fix. VRAM size is settable via a property 
so we should check if the resulting values are inside VRAM for which a 
simple mask may not be enough. Rather, check the calculation in the if 
with the error that says "blt outside vram not implemented".

The s->regs.[src|dst]_[xy] values should not be over 0x3fff because we 
mask them on register write in ati.c and here [src|dst]_[x|y] local 
variables are declared unsigned so negative values come out as large 
integers that should be caught by the checks below as being over VRAM end 
but those checks may have an off by one error or some other mistake. Do 
you have a reproducer and did you test if this fixes the crash or more 
info on how this overflows?

Regards,
BALATON Zoltan

>     int bpp = ati_bpp_from_datatype(s);
>     if (!bpp) {
>         qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
> @@ -91,9 +91,9 @@ void ati_2d_blt(ATIVGAState *s)
>     case ROP3_SRCCOPY:
>     {
>         unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> -                       s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
> +           s->regs.src_x : (s->regs.src_x + 1 - s->regs.dst_width) & 0x3fff);
>         unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> -                       s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_height);
> +           s->regs.src_y : (s->regs.src_y + 1 - s->regs.dst_height) & 0x3fff);
>         int src_stride = DEFAULT_CNTL ?
>                          s->regs.src_pitch : s->regs.default_pitch;
>         if (!src_stride) {
>


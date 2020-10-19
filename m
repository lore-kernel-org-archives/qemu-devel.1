Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F92C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 18:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7610322365
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 18:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7610322365
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUZsy-0005A2-Ey
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 14:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUZs5-0004eR-G3
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 14:27:01 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:42485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUZs1-0004Sv-4Q
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 14:26:59 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 45EB1746383;
 Mon, 19 Oct 2020 20:26:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1FA9A745953; Mon, 19 Oct 2020 20:26:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1E41E74594E;
 Mon, 19 Oct 2020 20:26:52 +0200 (CEST)
Date: Mon, 19 Oct 2020 20:26:52 +0200 (CEST)
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] ati: mask x y display parameter values
In-Reply-To: <nycvar.YSQ.7.78.906.2010191056550.1472930@xnncv>
Message-ID: <1e94cbca-121f-52f2-b1e3-6d2fdb59ee42@eik.bme.hu>
References: <20201018120852.1415440-1-ppandit@redhat.com>
 <607d183b-8885-583f-de2a-ee693e641a50@eik.bme.hu>
 <nycvar.YSQ.7.78.906.2010191056550.1472930@xnncv>
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
Cc: Gaoning Pan <pgn@zju.edu.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Mon, 19 Oct 2020, P J P wrote:
> +-- On Sun, 18 Oct 2020, BALATON Zoltan wrote --+
> | The s->regs.[src|dst]_[xy] values should not be over 0x3fff because we mask
> | them on register write in ati.c
>
>  Yes, those register values are set to zero(0).
>
> | and here [src|dst]_[x|y] local variables are declared unsigned so negative
> | values come out as large integers that should be caught by the checks below
> | as being over VRAM end
>
>  As above register values are zero(0), following expression(s)
>
>    dst_x = ... (s->regs.dst_x(=0) + 1 - s->regs.dst_width(=16383))
>    dst_y = ... (s->regs.dst_y(=0) + 1 - s->regs.dst_height(=16383))
>
> result in large unsigned values:

So far so good, this should result in dst_bits or dst_bits + the changed 
region being way over vram end which the check below should catch or 
otherwise it should not crash even if results are wrong.

>  ati_2d_blt
>    pixman_blt(0x7f03cbe00000, 0x7f03cbe00000, 131064, 131064, 32, 32,
>       src_x=0, src_y=-16382, dst_x=0, dst_y=-16382, 16383, 16383)
>
> Shown as negative values due to signed '%d' conversion.

Checking the docs again I see that the allowed range of at least 
s->regs.[src|dst]_[xy] can actually be negative (-8192:8191) so we 
probably misintrepret these and I'll have to look at this again to see how 
to do this properly but not sure when can I get to that. If this is urgent 
to fix now we could add some more checks but I don't like masking because 
that can lead to wrong results truncating parameters that should be 
rejected.

> | but those checks may have an off by one error or some other mistake.
>
>    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
>    if (dst_bits >= end || dst_bits + dst_x + (dst_y + s->regs.dst_height) * dst_stride >= end) {
>        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>        return;
>    }
>
> * Above check does not seem to catch it.

And that's the real problem. Could it be it overflows? If not then there's 
some other problem with interpreting the values later or with this check.

> * Does a check below look okay?
> ===
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 524bc03a83..b75acc7fda 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -54,9 +54,13 @@ void ati_2d_blt(ATIVGAState *s)
> ...
> +    if (dst_x > 0x3fff || dst_y > 0x3fff) {
> +        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
> +        return;
> +    }
> ...
> +        if (src_x > 0x3fff || src_y > 0x3fff) {
> +            qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
> +            return;
> +        }
> ===

This seems redundant, maybe rather add additional term for src|dst_x|y to 
the already existing checks if their condition cannot be fixed to detect 
it properly.

> * ati_2d_blt() routine looks complex. Maybe it can be divided in two halves.

Yes, as noted in a comment at the beginning this may need to be rewritten 
when it gets even more complex adding more of the features the card has. 
Maybe splitting off bounds checking to separate functions that can be 
reused for both dst and src values could be done to make it a bit better. 
I hoped the checks are simple enough for now but seems they are not. I'm 
not sure I can finish this before the freeze so unless it's OK to patch 
this during soft freeze or leave it for onther release I'd be OK with a 
patch that enhances the existing checks for now to also check src|dst_x|y 
instead of truncating their value. That may break it anyway but it's 
already broken and at least the checks are at the same place that way.

Regards,
BALATON Zoltan


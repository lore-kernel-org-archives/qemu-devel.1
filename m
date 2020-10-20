Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E720C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDAA2224A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDAA2224A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpsG-0007sx-7I
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUpqB-0006cY-Is
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:30:07 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:59771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kUpq6-0001nS-6S
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:30:05 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A3D8074760B;
 Tue, 20 Oct 2020 13:29:59 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 28DCB747604; Tue, 20 Oct 2020 13:29:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 27900747602;
 Tue, 20 Oct 2020 13:29:59 +0200 (CEST)
Date: Tue, 20 Oct 2020 13:29:59 +0200 (CEST)
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH] ati: mask x y display parameter values
In-Reply-To: <nycvar.YSQ.7.78.906.2010201220140.1506567@xnncv>
Message-ID: <d43d9494-72c3-eb52-4588-d324f2857c45@eik.bme.hu>
References: <20201018120852.1415440-1-ppandit@redhat.com>
 <607d183b-8885-583f-de2a-ee693e641a50@eik.bme.hu>
 <nycvar.YSQ.7.78.906.2010191056550.1472930@xnncv>
 <1e94cbca-121f-52f2-b1e3-6d2fdb59ee42@eik.bme.hu>
 <nycvar.YSQ.7.78.906.2010201220140.1506567@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 07:29:59
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

On Tue, 20 Oct 2020, P J P wrote:
> +-- On Mon, 19 Oct 2020, BALATON Zoltan wrote --+
> | On Mon, 19 Oct 2020, P J P wrote:
> | >    dst_x = ... (s->regs.dst_x(=0) + 1 - s->regs.dst_width(=16383))
> | >    dst_y = ... (s->regs.dst_y(=0) + 1 - s->regs.dst_height(=16383))
> | >
> | >  ati_2d_blt
> | >    pixman_blt(0x7f03cbe00000, 0x7f03cbe00000, 131064, 131064, 32, 32,
> | >       src_x=0, src_y=-16382, dst_x=0, dst_y=-16382, 16383, 16383)
> | >
> | > Shown as negative values due to signed '%d' conversion.
> |
> | Checking the docs again I see that the allowed range of at least
> | s->regs.[src|dst]_[xy] can actually be negative (-8192:8191)
>
> * But 'struct ATIVGARegs' declares these fields as 'uint32_t' type. Ie. no
>  negativeve values.

The card has 32 bit registers with values in them interpreted differently 
for different regs. For dst_x|y lower 14 bits can be set and value should 
be interpreted as -8192:8191 according to docs. I've got this wrong 
because all guests I've tried did not actually use negative values. The 
Solaris driver I was recently shown not to work may use that so I plan to 
look at it and fix it when I'll have time.

> * I guess that range applies to src->regs.dst_[width|height] too? Considering
>  it being subtracted from s->regs.dst_[xy] values above.

Docs aren't very clear on that but I think these cannot be negative so 
0:8191 is valid range because it mentions that also bits 0-13 (or maybe 
0-15, the docs have a lot of copy&paste errors) are valid but only 0-12 
are used for rectangles, 13-15 used only for trapezoids (which we don't 
emulate). The docs are really bad so we have to guess and see what guest 
drivers do most of the time.

> | >    uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
> | >    if (dst_bits >= end || dst_bits + dst_x + (dst_y + s->regs.dst_height) *
> | >    dst_stride >= end) {
> | >        qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
> | >        return;
> |
> | ... Could it be it overflows?
>
> * Yes, following expression
>
>  dst_y(=4294950914(=-16382)) + s->regs.dst_height(=16383)) overflows to => 1
>
> Ie. (dst_bits + dst_x(=0) + (1) * dst_stride >= end) returns false.

So maybe we should cast something (like dst_stride) to uint64_t here to 
promote everything to 64 bit and prevent it overflowing which then should 
catch this as well?

> | maybe rather add additional term for src|dst_x|y to the already existing
> | checks if their condition cannot be fixed to detect it properly.
> ===
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 524bc03a83..5fa7362305 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -54,9 +54,9 @@ void ati_2d_blt(ATIVGAState *s)
> ...
> -    if (dst_bits >= end || dst_bits + dst_x + (dst_y + s->regs.dst_height) *
> -        dst_stride >= end) {
> +    if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
> +        || dst_bits + dst_x + (dst_y + s->regs.dst_height)
> +         * dst_stride >= end) {
>         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>         return;
>     }
> ...
> -        if (src_bits >= end || src_bits + src_x +
> -            (src_y + s->regs.dst_height) * src_stride >= end) {
> +        if (src_x > 0x3fff || src_y > 0x3ff || src_bits >= end
> +            || src_bits + src_x + (src_y + s->regs.dst_height)
> +             * src_stride >= end) {
>             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
>             return;
>         }
> ===
>
> * Does it look okay?

I can live with that until I have a chance to rewrite it but are you sure 
this will catch all possible overflows with all vram sizes that can be set 
with vgamem_mb property?

Regards,
BALATON Zoltan


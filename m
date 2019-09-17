Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD16C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6B62171F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6B62171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADup-0004Kt-L0
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iADqX-0001HO-CU
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iADqV-0002dM-Je
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:48:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:42058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1iADqV-0002Ye-73
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:48:43 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1DBFA7456E3;
 Tue, 17 Sep 2019 15:48:34 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 012397456D5; Tue, 17 Sep 2019 15:48:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EA28E7456CC;
 Tue, 17 Sep 2019 15:48:33 +0200 (CEST)
Date: Tue, 17 Sep 2019 15:48:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <20190917111441.27405-3-kraxel@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1909171547160.64192@zero.eik.bme.hu>
References: <20190917111441.27405-1-kraxel@redhat.com>
 <20190917111441.27405-3-kraxel@redhat.com>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: Re: [Qemu-devel] [PATCH v3 2/2] ati: use vga_read_byte in
 ati_cursor_define
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
Cc: qemu-devel@nongnu.org, flier_m@outlook.com,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019, Gerd Hoffmann wrote:
> This makes sure reads are confined to vga video memory.
>
> v3: use uint32_t, fix cut+paste bug.
> v2: fix ati_cursor_draw_line too.
>
> Reported-by: xu hang <flier_m@outlook.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Thank you,
BALATON Zoltan

> ---
> hw/display/ati.c | 19 ++++++++++---------
> 1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 8f940eee221a..db3b2543163f 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -19,6 +19,7 @@
> #include "qemu/osdep.h"
> #include "ati_int.h"
> #include "ati_regs.h"
> +#include "vga-access.h"
> #include "hw/qdev-properties.h"
> #include "vga_regs.h"
> #include "qemu/log.h"
> @@ -135,19 +136,19 @@ static void ati_vga_switch_mode(ATIVGAState *s)
> static void ati_cursor_define(ATIVGAState *s)
> {
>     uint8_t data[1024];
> -    uint8_t *src;
> +    uint32_t srcoff;
>     int i, j, idx = 0;
>
>     if ((s->regs.cur_offset & BIT(31)) || s->cursor_guest_mode) {
>         return; /* Do not update cursor if locked or rendered by guest */
>     }
>     /* FIXME handle cur_hv_offs correctly */
> -    src = s->vga.vram_ptr + s->regs.cur_offset -
> -          (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) * 16;
> +    srcoff = s->regs.cur_offset -
> +        (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) * 16;
>     for (i = 0; i < 64; i++) {
>         for (j = 0; j < 8; j++, idx++) {
> -            data[idx] = src[i * 16 + j];
> -            data[512 + idx] = src[i * 16 + j + 8];
> +            data[idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j);
> +            data[512 + idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j + 8);
>         }
>     }
>     if (!s->cursor) {
> @@ -189,7 +190,7 @@ static void ati_cursor_invalidate(VGACommonState *vga)
> static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
> {
>     ATIVGAState *s = container_of(vga, ATIVGAState, vga);
> -    uint8_t *src;
> +    uint32_t srcoff;
>     uint32_t *dp = (uint32_t *)d;
>     int i, j, h;
>
> @@ -199,13 +200,13 @@ static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int scr_y)
>         return;
>     }
>     /* FIXME handle cur_hv_offs correctly */
> -    src = s->vga.vram_ptr + s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
> +    srcoff = s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
>     dp = &dp[vga->hw_cursor_x];
>     h = ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
>     for (i = 0; i < 8; i++) {
>         uint32_t color;
> -        uint8_t abits = src[i];
> -        uint8_t xbits = src[i + 8];
> +        uint8_t abits = vga_read_byte(vga, srcoff + i);
> +        uint8_t xbits = vga_read_byte(vga, srcoff + i + 8);
>         for (j = 0; j < 8; j++, abits <<= 1, xbits <<= 1) {
>             if (abits & BIT(7)) {
>                 if (xbits & BIT(7)) {
>


Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0204C4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 21:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5ADB20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 21:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5ADB20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8WMF-0002kF-PD
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 17:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56903)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1i8WLQ-0002IT-4u
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 17:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1i8WLO-00089R-KJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 17:09:35 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:33958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1i8WLO-00087Z-Ed
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 17:09:34 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B1A0474AB63;
 Thu, 12 Sep 2019 23:09:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 78F15749EDE; Thu, 12 Sep 2019 23:09:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 705F67456CA;
 Thu, 12 Sep 2019 23:09:22 +0200 (CEST)
Date: Thu, 12 Sep 2019 23:09:22 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <20190912121835.18362-3-kraxel@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1909122307380.70054@zero.eik.bme.hu>
References: <20190912121835.18362-1-kraxel@redhat.com>
 <20190912121835.18362-3-kraxel@redhat.com>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: Re: [Qemu-devel] [PATCH 2/2] ati: use vga_read_byte in
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

On Thu, 12 Sep 2019, Gerd Hoffmann wrote:
> This makes sure reads are confined to vga video memory.
>
> Reported-by: xu hang <flier_m@outlook.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> hw/display/ati.c | 11 ++++++-----
> 1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 8f940eee221a..6d77c40b8287 100644
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
> +    unsigned srcoff;
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

Do we need similar fix in ati_cursor_draw_line() as well which also 
accesses cursor data when guest_hwcursor property is true?

Regards,
BALATON Zoltan

>     for (i = 0; i < 64; i++) {
>         for (j = 0; j < 8; j++, idx++) {
> -            data[idx] = src[i * 16 + j];
> -            data[512 + idx] = src[i * 16 + j + 8];
> +            data[idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j);
> +            data[512 + idx] = vga_read_byte(&s->vga, srcoff + i * 16 + j + 8);
>         }
>     }
>     if (!s->cursor) {
>


Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19736C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:38:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C5920665
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C5920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAGV6-0007V9-29
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAGU6-0006gK-MN
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAGU5-0003Ik-Fs
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:37:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAGU5-0003I9-8E
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 12:37:45 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D70244ACDF
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 16:37:43 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id k67so1086202wmf.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 09:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LuTLtNCbbrg699JDR0yX3Kr9ncm96sTAC+16TmsIx9I=;
 b=s2jSYkpMhIgDoDYm29jxvTdToRhsrkwSxL7+SFYl8T8vRPIER196Va5eBPfsoyVfJi
 dBko2vH8JjH4fQWFVRXh7i6MRptf1nyNOxvi7C2siP00tmC2wbjWhGpMpaQDTo7hLlcj
 Pz3V4wpA4MYFOacuPfNL391rgoiAaT7BbH5xUBgEejZ8ii/TztuJ/o5mgk++tPa+1uwg
 icQ19cmsyNtsr/mAByn4w0Fn4SX6oqod4RELVvH2aSliK3IfrZ5r/oY9AQ+mE2Y5PfZN
 O7d+2jhaoDJGXaPawJCPUFhzUn/snnLVjs1AnW9TfAaV/0kOvv5QaFVdDJdgF818VFzX
 FbNQ==
X-Gm-Message-State: APjAAAUvv1FSMANhcjlyKWIbXxeWwCeriaaVCBV7iZelzNVyxo3oeW8E
 EW/4Xq4h0QYThwVSm4CRfMP3ikdYQ7EFsgyf6jV3fEljI4ItNUvy/mVAjnMENtpS5gXKAKnL1zy
 VUFy+pKnry5OzPTA=
X-Received: by 2002:adf:e410:: with SMTP id g16mr3895733wrm.297.1568738262635; 
 Tue, 17 Sep 2019 09:37:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzpVo8Vr2w3htwj2Gp0FhwenFR7VNTfsKjCp+7D0gIBbk7tdZiFNUvYWuufLnAu8K65NY67cw==
X-Received: by 2002:adf:e410:: with SMTP id g16mr3895719wrm.297.1568738262458; 
 Tue, 17 Sep 2019 09:37:42 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id f18sm3084129wrv.38.2019.09.17.09.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2019 09:37:41 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190917111441.27405-1-kraxel@redhat.com>
 <20190917111441.27405-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <302ba165-6ef3-3d4f-3295-b016c0b9da30@redhat.com>
Date: Tue, 17 Sep 2019 18:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190917111441.27405-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: flier_m@outlook.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 1:14 PM, Gerd Hoffmann wrote:
> This makes sure reads are confined to vga video memory.
>=20
> v3: use uint32_t, fix cut+paste bug.
> v2: fix ati_cursor_draw_line too.
>=20
> Reported-by: xu hang <flier_m@outlook.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/ati.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 8f940eee221a..db3b2543163f 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -19,6 +19,7 @@
>  #include "qemu/osdep.h"
>  #include "ati_int.h"
>  #include "ati_regs.h"
> +#include "vga-access.h"
>  #include "hw/qdev-properties.h"
>  #include "vga_regs.h"
>  #include "qemu/log.h"
> @@ -135,19 +136,19 @@ static void ati_vga_switch_mode(ATIVGAState *s)
>  static void ati_cursor_define(ATIVGAState *s)
>  {
>      uint8_t data[1024];
> -    uint8_t *src;
> +    uint32_t srcoff;
>      int i, j, idx =3D 0;
> =20
>      if ((s->regs.cur_offset & BIT(31)) || s->cursor_guest_mode) {
>          return; /* Do not update cursor if locked or rendered by guest=
 */
>      }
>      /* FIXME handle cur_hv_offs correctly */
> -    src =3D s->vga.vram_ptr + s->regs.cur_offset -
> -          (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff)=
 * 16;
> +    srcoff =3D s->regs.cur_offset -
> +        (s->regs.cur_hv_offs >> 16) - (s->regs.cur_hv_offs & 0xffff) *=
 16;
>      for (i =3D 0; i < 64; i++) {
>          for (j =3D 0; j < 8; j++, idx++) {
> -            data[idx] =3D src[i * 16 + j];
> -            data[512 + idx] =3D src[i * 16 + j + 8];
> +            data[idx] =3D vga_read_byte(&s->vga, srcoff + i * 16 + j);
> +            data[512 + idx] =3D vga_read_byte(&s->vga, srcoff + i * 16=
 + j + 8);
>          }
>      }
>      if (!s->cursor) {
> @@ -189,7 +190,7 @@ static void ati_cursor_invalidate(VGACommonState *v=
ga)
>  static void ati_cursor_draw_line(VGACommonState *vga, uint8_t *d, int =
scr_y)
>  {
>      ATIVGAState *s =3D container_of(vga, ATIVGAState, vga);
> -    uint8_t *src;
> +    uint32_t srcoff;
>      uint32_t *dp =3D (uint32_t *)d;
>      int i, j, h;
> =20
> @@ -199,13 +200,13 @@ static void ati_cursor_draw_line(VGACommonState *=
vga, uint8_t *d, int scr_y)
>          return;
>      }
>      /* FIXME handle cur_hv_offs correctly */
> -    src =3D s->vga.vram_ptr + s->cursor_offset + (scr_y - vga->hw_curs=
or_y) * 16;
> +    srcoff =3D s->cursor_offset + (scr_y - vga->hw_cursor_y) * 16;
>      dp =3D &dp[vga->hw_cursor_x];
>      h =3D ((s->regs.crtc_h_total_disp >> 16) + 1) * 8;
>      for (i =3D 0; i < 8; i++) {
>          uint32_t color;
> -        uint8_t abits =3D src[i];
> -        uint8_t xbits =3D src[i + 8];
> +        uint8_t abits =3D vga_read_byte(vga, srcoff + i);
> +        uint8_t xbits =3D vga_read_byte(vga, srcoff + i + 8);
>          for (j =3D 0; j < 8; j++, abits <<=3D 1, xbits <<=3D 1) {
>              if (abits & BIT(7)) {
>                  if (xbits & BIT(7)) {
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


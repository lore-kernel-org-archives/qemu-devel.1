Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A00BC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 09:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045E82084E
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 09:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="CHmG3Pyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045E82084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2tYR-00048Y-V0
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 04:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1j2tV2-0005YZ-4i
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1j2tV0-0008KD-VX
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:12:31 -0500
Received: from propper.duncanthrax.net ([91.207.61.48]:53434
 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1j2tV0-0008JH-Mn
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r33xP1EqWzmTK5vB9LAYQTixB/E5gfdUEM5rWfgDt0c=; b=CHmG3PybYFhzsBDPGzOOr7vRQn
 jOVyW+SbFJNJJ9U9qKqUIRMUYK8UaBPXpQ9wvPKiBRaEIwRV9d0ZENtePKYE5naN7rdcuxHZKT6BY
 zte6DLaWdiGMPGaVGqqrTzWXXXuBEzjcwps/YaFqQPUUedd2XywuVkMi36OThlfuxays=;
Received: from [134.3.47.90] (helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1j2tUw-0003qb-PW; Sat, 15 Feb 2020 10:12:26 +0100
Date: Sat, 15 Feb 2020 10:12:26 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 2/5] hw/display/artist: Remove pointless initialization
Message-ID: <20200215091226.GC18657@t470p.stackframe.org>
References: <20200214001303.12873-1-f4bug@amsat.org>
 <20200214001303.12873-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200214001303.12873-3-f4bug@amsat.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.207.61.48
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
Cc: Helge Deller <deller@gmx.de>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 14, 2020 at 01:12:59AM +0100, Philippe Mathieu-Daudé wrote:
> We are initializating incy inconditionally:
> 
>     if (y1 <= y2) {
>         incy = 1;
>     } else {
>         incy = -1;
>     }
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/display/artist.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index abacb0e27d..47f0e9f0bc 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -557,91 +557,90 @@ static void fill_window(ARTISTState *s, int startx, int starty,
>  static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
>                        bool update_start, int skip_pix, int max_pix)
>  {
>      struct vram_buffer *buf;
>      uint8_t color = artist_get_color(s);
>      int dx, dy, t, e, x, y, incy, diago, horiz;
>      bool c1;
>      uint8_t *p;
>  
>      trace_artist_draw_line(x1, y1, x2, y2);
>  
>      if (update_start) {
>          s->vram_start = (x2 << 16) | y2;
>      }
>  
>      buf = &s->vram_buffer[ARTIST_BUFFER_AP];
>  
>      c1 = false;
> -    incy = 1;
>  
>      if (x2 > x1) {
>          dx = x2 - x1;
>      } else {
>          dx = x1 - x2;
>      }
>      if (y2 > y1) {
>          dy = y2 - y1;
>      } else {
>          dy = y1 - y2;
>      }
>      if (dy > dx) {
>          t = y2;
>          y2 = x2;
>          x2 = t;
>  
>          t = y1;
>          y1 = x1;
>          x1 = t;
>  
>          t = dx;
>          dx = dy;
>          dy = t;
>  
>          c1 = true;
>      }
>  
>      if (x1 > x2) {
>          t = y2;
>          y2 = y1;
>          y1 = t;
>  
>          t = x1;
>          x1 = x2;
>          x2 = t;
>      }
>  
>      horiz = dy << 1;
>      diago = (dy - dx) << 1;
>      e = (dy << 1) - dx;
>  
>      if (y1 <= y2) {
>          incy = 1;
>      } else {
>          incy = -1;
>      }
>      x = x1;
>      y = y1;
>  
>      do {
>          if (c1) {
>              p = buf->data + x * s->width + y;
>          } else {
>              p = buf->data + y * s->width + x;
>          }
>  
>          if (skip_pix > 0) {
>              skip_pix--;
>          } else {
>              artist_rop8(s, p, color);
>          }
>  
>          if (e > 0) {
>              artist_invalidate_lines(buf, y, 1);
>              y  += incy;
>              e  += diago;
>          } else {
>              e += horiz;
>          }
>          x++;
>      } while (x <= x2 && (max_pix == -1 || --max_pix > 0));
>  }
> -- 
> 2.21.1
> 

Acked-by: Sven Schnelle <svens@stackframe.org>


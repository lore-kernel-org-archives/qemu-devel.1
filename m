Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D392EC2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 09:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A00042083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 09:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="KxYs/89Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00042083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2tde-0001um-Ib
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 04:21:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1j2tVI-0006HA-Ds
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1j2tVG-0008VO-VA
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:12:48 -0500
Received: from propper.duncanthrax.net ([91.207.61.48]:53462
 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1j2tVG-0008UX-MB
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZpKAaQkeCand/G/KJaqsD/1u59GwucErF8sdeX3tCdc=; b=KxYs/89ZKES9Gsvs95EFZexbuP
 FNOXMwr2pILBWHI8atJS6Vs9FYAujEB6R3LAkhZKdEW4kc/XWzM0VEMu9IqjzPu1IC26+fcTnVJfd
 b6O/a4NuaRdV6TCoqG4J0vgabhCQyNKrpki5ZvZlmA8p1fJrBU7OEqeHNE5lpG5o5BSE=;
Received: from [134.3.47.90] (helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1j2tVB-0003qu-5r; Sat, 15 Feb 2020 10:12:41 +0100
Date: Sat, 15 Feb 2020 10:12:40 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 1/5] hw/display/artist: Move trace event to draw_line()
Message-ID: <20200215091240.GD18657@t470p.stackframe.org>
References: <20200214001303.12873-1-f4bug@amsat.org>
 <20200214001303.12873-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200214001303.12873-2-f4bug@amsat.org>
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

On Fri, Feb 14, 2020 at 01:12:58AM +0100, Philippe Mathieu-Daudé wrote:
> Instead of emitting the trace event before each call to
> draw_line(), call it once at draw_line() entrance.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/display/artist.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index 65be9e3554..abacb0e27d 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -557,90 +557,91 @@ static void fill_window(ARTISTState *s, int startx, int starty,
>  static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
>                        bool update_start, int skip_pix, int max_pix)
>  {
>      struct vram_buffer *buf;
>      uint8_t color = artist_get_color(s);
>      int dx, dy, t, e, x, y, incy, diago, horiz;
>      bool c1;
>      uint8_t *p;
>  
> +    trace_artist_draw_line(x1, y1, x2, y2);
>  
>      if (update_start) {
>          s->vram_start = (x2 << 16) | y2;
>      }
>  
>      buf = &s->vram_buffer[ARTIST_BUFFER_AP];
>  
>      c1 = false;
>      incy = 1;
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
> @@ -648,13 +649,12 @@ static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
>  static void draw_line_pattern_start(ARTISTState *s)
>  {
>  
>      int startx = artist_get_x(s->vram_start);
>      int starty = artist_get_y(s->vram_start);
>      int endx = artist_get_x(s->blockmove_size);
>      int endy = artist_get_y(s->blockmove_size);
>      int pstart = s->line_pattern_start >> 16;
>  
> -    trace_artist_draw_line(startx, starty, endx, endy);
>      draw_line(s, startx, starty, endx, endy, false, -1, pstart);
>      s->line_pattern_skip = pstart;
>  }
> @@ -662,15 +662,14 @@ static void draw_line_pattern_start(ARTISTState *s)
>  static void draw_line_pattern_next(ARTISTState *s)
>  {
>  
>      int startx = artist_get_x(s->vram_start);
>      int starty = artist_get_y(s->vram_start);
>      int endx = artist_get_x(s->blockmove_size);
>      int endy = artist_get_y(s->blockmove_size);
>      int line_xy = s->line_xy >> 16;
>  
> -    trace_artist_draw_line(startx, starty, endx, endy);
>      draw_line(s, startx, starty, endx, endy, false, s->line_pattern_skip,
>                s->line_pattern_skip + line_xy);
>      s->line_pattern_skip += line_xy;
>      s->image_bitmap_op ^= 2;
>  }
> @@ -678,84 +677,81 @@ static void draw_line_pattern_next(ARTISTState *s)
>  static void draw_line_size(ARTISTState *s, bool update_start)
>  {
>  
>      int startx = artist_get_x(s->vram_start);
>      int starty = artist_get_y(s->vram_start);
>      int endx = artist_get_x(s->line_size);
>      int endy = artist_get_y(s->line_size);
>  
> -    trace_artist_draw_line(startx, starty, endx, endy);
>      draw_line(s, startx, starty, endx, endy, update_start, -1, -1);
>  }
>  
>  static void draw_line_xy(ARTISTState *s, bool update_start)
>  {
>  
>      int startx = artist_get_x(s->vram_start);
>      int starty = artist_get_y(s->vram_start);
>      int sizex = artist_get_x(s->blockmove_size);
>      int sizey = artist_get_y(s->blockmove_size);
>      int linexy = s->line_xy >> 16;
>      int endx, endy;
>  
>      endx = startx;
>      endy = starty;
>  
>      if (sizex > 0) {
>          endx = startx + linexy;
>      }
>  
>      if (sizex < 0) {
>          endx = startx;
>          startx -= linexy;
>      }
>  
>      if (sizey > 0) {
>          endy = starty + linexy;
>      }
>  
>      if (sizey < 0) {
>          endy = starty;
>          starty -= linexy;
>      }
>  
>      if (startx < 0) {
>          startx = 0;
>      }
>  
>      if (endx < 0) {
>          endx = 0;
>      }
>  
>      if (starty < 0) {
>          starty = 0;
>      }
>  
>      if (endy < 0) {
>          endy = 0;
>      }
>  
>  
>      if (endx < 0) {
>          return;
>      }
>  
>      if (endy < 0) {
>          return;
>      }
>  
> -    trace_artist_draw_line(startx, starty, endx, endy);
>      draw_line(s, startx, starty, endx, endy, false, -1, -1);
>  }
>  
>  static void draw_line_end(ARTISTState *s, bool update_start)
>  {
>  
>      int startx = artist_get_x(s->vram_start);
>      int starty = artist_get_y(s->vram_start);
>      int endx = artist_get_x(s->line_end);
>      int endy = artist_get_y(s->line_end);
>  
> -    trace_artist_draw_line(startx, starty, endx, endy);
>      draw_line(s, startx, starty, endx, endy, update_start, -1, -1);
>  }
>  
> -- 
> 2.21.1
> 

Acked-by: Sven Schnelle <svens@stackframe.org>


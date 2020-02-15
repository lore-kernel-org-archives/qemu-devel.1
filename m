Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389C3C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 09:15:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14F62083B
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 09:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="JnCP5aJO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14F62083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2tXr-0003GH-U3
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 04:15:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1j2tUh-0004fY-2k
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1j2tUf-000890-LR
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:12:10 -0500
Received: from propper.duncanthrax.net ([91.207.61.48]:53388
 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1j2tUf-00080x-08
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 04:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a+7vE+r0I1Uwq5zZECjOozecYEhtPmHZIcFdH0laaAc=; b=JnCP5aJOm+260yX66XbP42LBMn
 6VjH+fcL+gbQqlOPh/Mx4RKX8FO/VMeMg2WTVoNVFuU0XeH4AUoVDLf04ixV728rqMWVHZMgYq/ST
 ixcC3NNZH3pvF2m4WLBR3DSFzQtuRirGH1x9l4EyRBC2FiTFWZYp2dQh4D4r54so09s4=;
Received: from [134.3.47.90] (helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1j2tUU-0003q5-Ve; Sat, 15 Feb 2020 10:11:59 +0100
Date: Sat, 15 Feb 2020 10:11:58 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 5/5] hw/display/artist: Remove dead code (CID 1419388 &
 1419389)
Message-ID: <20200215091158.GA18657@t470p.stackframe.org>
References: <20200214001303.12873-1-f4bug@amsat.org>
 <20200214001303.12873-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200214001303.12873-6-f4bug@amsat.org>
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

On Fri, Feb 14, 2020 at 01:13:02AM +0100, Philippe Mathieu-Daudé wrote:
> Coverity reports:
> 
>   *** CID 1419388:  Control flow issues  (DEADCODE)
>   /hw/display/artist.c: 739 in draw_line_xy()
>   733         if (endy < 0) {
>   734             endy = 0;
>   735         }
>   736
>   737
>   738         if (endx < 0) {
>   >>>     CID 1419388:  Control flow issues  (DEADCODE)
>   >>>     Execution cannot reach this statement: "return;".
>   739             return;
>   740         }
>   741
>   742         if (endy < 0) {
>   743             return;
>   744         }
> 
>   *** CID 1419389:  Control flow issues  (DEADCODE)
>   /hw/display/artist.c: 743 in draw_line_xy()
>   737
>   738         if (endx < 0) {
>   739             return;
>   740         }
>   741
>   742         if (endy < 0) {
>   >>>     CID 1419389:  Control flow issues  (DEADCODE)
>   >>>     Execution cannot reach this statement: "return;".
>   743             return;
>   744         }
>   745
>   746         trace_artist_draw_line(startx, starty, endx, endy);
>   747         draw_line(s, startx, starty, endx, endy, false, -1, -1);
>   748     }
> 
> Fixes: Covertiy CID 1419388 and 1419389 (commit 4765384ce33)
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/display/artist.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/hw/display/artist.c b/hw/display/artist.c
> index 5492079116..753dbb9a77 100644
> --- a/hw/display/artist.c
> +++ b/hw/display/artist.c
> @@ -690,59 +690,50 @@ static void draw_line_size(ARTISTState *s, bool update_start)
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
> -
> -    if (endx < 0) {
> -        return;
> -    }
> -
> -    if (endy < 0) {
> -        return;
> -    }
> -
>      draw_line(s, startx, starty, endx, endy, false, -1, -1);
>  }
>  
> -- 
> 2.21.1
> 

Acked-by: Sven Schnelle <svens@stackframe.org>


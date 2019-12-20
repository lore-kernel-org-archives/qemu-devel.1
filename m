Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB9CC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B424206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="K3ns4gVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B424206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stackframe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLm9-0008Ma-2S
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>) id 1iiLh8-0004Do-39
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:04:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <svens@stackframe.org>) id 1iiLh6-0002mq-2U
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:04:05 -0500
Received: from shroom.duncanthrax.net ([2a01:4f8:121:41fa::169]:40571
 helo=smtp.duncanthrax.net)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <svens@stackframe.org>)
 id 1iiLh3-0002ig-Lf
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
 :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sGp+99S+kUq+lR8QZ830jUWqwgQnW0U0IhXosH4PDj4=; b=K3ns4gVMZayuiWD/wXqid8VB68
 lcREmWGOHYCqz0a5dGFuPGbB59MeXJrCSzzZopLdOoa3R3vAqI+BwqAy/ZAi8HAuDTt4x8uDcGoyY
 QSy21nstNUEEbP1FJllR3uMuhnpklLPTCduOTB1szbchr2wKD1iIm7GDNmK4anFy4vCE=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de
 ([46.5.233.221] helo=t470p.stackframe.org)
 by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
 (envelope-from <svens@stackframe.org>)
 id 1iiLgx-0006zY-9j; Fri, 20 Dec 2019 18:03:55 +0100
Date: Fri, 20 Dec 2019 18:03:54 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v4 5/6] hppa: Add emulation of Artist graphics
Message-ID: <20191220170354.GA2762@t470p.stackframe.org>
References: <20191103205607.6590-1-svens@stackframe.org>
 <20191103205607.6590-6-svens@stackframe.org>
 <8a34a5a3-eb8f-c600-b17e-f9b448ea0925@linaro.org>
 <e8efe083-eed1-d7e8-8513-b26d2878bfdd@gmx.de>
 <237c693d-944c-8641-87d9-6bbd52736e5a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <237c693d-944c-8641-87d9-6bbd52736e5a@gmx.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:121:41fa::169
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Fri, Dec 20, 2019 at 05:36:36PM +0100, Helge Deller wrote:
> On 20.12.19 08:26, Helge Deller wrote:
> > On 19.12.19 01:28, Richard Henderson wrote:
> >> On 11/3/19 10:56 AM, Sven Schnelle wrote:
> >>> This adds emulation of Artist graphics good enough
> >>> to get a Text console on both Linux and HP-UX. The
> >>> X11 server from HP-UX also works.
> >>>
> >>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> >>> ---
> >>>  hw/display/Kconfig       |    4 +
> >>>  hw/display/Makefile.objs |    1 +
> >>>  hw/display/artist.c      | 1449 ++++++++++++++++++++++++++++++++++++++
> >>>  hw/display/trace-events  |    9 +
> >>>  hw/hppa/Kconfig          |    1 +
> >>>  hw/hppa/hppa_hardware.h  |    1 +
> >>>  hw/hppa/machine.c        |    9 +
> >>>  7 files changed, 1474 insertions(+)
> >>>  create mode 100644 hw/display/artist.c
> >>
> >> Seems to have some problems rebased upon master:
> >>
> >> ...
> >
> > Richard, the attached patch (for seabios-hppa) fixes it for me.
> > Can you test as well?
> > It fixes the sti text column to go out-of-range and thus outside the framebuffer memory.
> 
> The attached patch is even better.
> It always wraps to the next line (or scrolls the screen if necessary) if
> the end of the line has been reached.
> 
> Helge

> diff --git a/src/parisc/sti.c b/src/parisc/sti.c
> index 7935770..61e7002 100644
> --- a/src/parisc/sti.c
> +++ b/src/parisc/sti.c
> @@ -168,5 +168,10 @@ void sti_putc(const char c)
>          }
>          return;
>      }
> +
> +    /* wrap to next line or scroll screen if EOL reached */
> +    if (col >= ((sti_glob_cfg.onscreen_x / font->width) - 1))
> +	sti_putc('\n');
> +
>      sti_putchar(rom, row, col++, c);
>  }

Besides this, the root cause is the out-of-bounds check in vram_bit_write():
This fixes the crash for me. I'll resend an updated version later. Thanks for
helping debugging this issue!

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 1d6c7d5d76..13c770e795 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -360,7 +360,7 @@ static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_x,
         return;
     }

-    if (posy * width + posx > buf->size) {
+    if (posy * width + posx >= buf->size) {
         qemu_log("write outside bounds: wants %dx%d, max size %dx%d\n",
                 posx, posy, width, height);
         return;

Regards
Sven


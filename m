Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E6C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 10:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9B220723
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 10:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9B220723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWdiH-0007pA-GV
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 06:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWdgn-0007MI-5q
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 06:55:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:45972
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWdgf-0002Uu-FD
 for qemu-devel@nongnu.org; Sun, 25 Oct 2020 06:55:52 -0400
Received: from host86-148-246-80.range86-148.btcentralplus.com
 ([86.148.246.80] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kWdga-0001cC-4h; Sun, 25 Oct 2020 10:55:45 +0000
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201024205100.3623006-1-f4bug@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <8744a7c0-4fb8-65ce-cecf-0013468eeb10@ilande.co.uk>
Date: Sun, 25 Oct 2020 10:55:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201024205100.3623006-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.148.246.80
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3] hw/display/tcx: Allow 64-bit accesses to framebuffer
 stippler and blitter
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
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
Cc: Michael Lorenz <macallan@NetBSD.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Andreas Gustafsson <gson@gson.org>,
 1892540@bugs.launchpad.net, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/10/2020 21:51, Philippe Mathieu-Daudé wrote:

> The S24/TCX datasheet is listed as "Unable to locate" on [1].
> 
> However the NetBSD revision 1.32 of the driver introduced
> 64-bit accesses to the stippler and blitter [2]. It is safe
> to assume these memory regions are 64-bit accessible.
> QEMU implementation is 32-bit, so fill the 'impl' fields.
> 
> Michael Lorenz (author of the NetBSD code [2]) provided us with more
> information in [3]:
> 
>> IIRC the real hardware *requires* 64bit accesses for stipple and
>> blitter operations to work. For stipples you write a 64bit word into
>> STIP space, the address defines where in the framebuffer you want to
>> draw, the data contain a 32bit bitmask, foreground colour and a ROP.
>> BLIT space works similarly, the 64bit word contains an offset were to
>> read pixels from, and how many you want to copy.
>>
>> One more thing since there seems to be some confusion - 64bit accesses
>> on the framebuffer are fine as well. TCX/S24 is *not* an SBus device,
>> even though its node says it is.
>> S24 is a card that plugs into a special slot on the SS5 mainboard,
>> which is shared with an SBus slot and looks a lot like a horizontal
>> UPA slot. Both S24 and TCX are accessed through the Micro/TurboSPARC's
>> AFX bus which is 64bit wide and intended for graphics.
>> Early FFB docs even mentioned connecting to both AFX and UPA,
>> no idea if that was ever realized in hardware though.
> 
> [1] http://web.archive.org/web/20111209011516/http://wikis.sun.com/display/FOSSdocs/Home
> [2] http://cvsweb.netbsd.org/bsdweb.cgi/src/sys/dev/sbus/tcx.c.diff?r1=1.31&r2=1.32
> [3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg734928.html
> 
> Reported-by: Andreas Gustafsson <gson@gson.org>
> Buglink: https://bugs.launchpad.net/bugs/1892540
> Fixes: 55d7bfe2293 ("tcx: Implement hardware acceleration")
> Tested-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Tested-by: Andreas Gustafsson <gson@gson.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Since v2:
> - added Michael's memories
> - added R-b/T-b tags
> 
> Since v1:
> - added missing uncommitted staged changes... (tcx_blit_ops)
> ---
>   hw/display/tcx.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index c9d5e45cd1f..878ecc8c506 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -549,20 +549,28 @@ static const MemoryRegionOps tcx_stip_ops = {
>       .read = tcx_stip_readl,
>       .write = tcx_stip_writel,
>       .endianness = DEVICE_NATIVE_ENDIAN,
> -    .valid = {
> +    .impl = {
>           .min_access_size = 4,
>           .max_access_size = 4,
>       },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
>   };
>   
>   static const MemoryRegionOps tcx_rstip_ops = {
>       .read = tcx_stip_readl,
>       .write = tcx_rstip_writel,
>       .endianness = DEVICE_NATIVE_ENDIAN,
> -    .valid = {
> +    .impl = {
>           .min_access_size = 4,
>           .max_access_size = 4,
>       },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
>   };
>   
>   static uint64_t tcx_blit_readl(void *opaque, hwaddr addr,
> @@ -651,10 +659,14 @@ static const MemoryRegionOps tcx_rblit_ops = {
>       .read = tcx_blit_readl,
>       .write = tcx_rblit_writel,
>       .endianness = DEVICE_NATIVE_ENDIAN,
> -    .valid = {
> +    .impl = {
>           .min_access_size = 4,
>           .max_access_size = 4,
>       },
> +    .valid = {
> +        .min_access_size = 4,
> +        .max_access_size = 8,
> +    },
>   };
>   
>   static void tcx_invalidate_cursor_position(TCXState *s)

I'd already queued v2 of this patch (see my earlier email) with the intent to send a 
PR today, however I'll replace it with this v3 instead.


ATB,

Mark.


Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A3C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9965E218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9965E218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiy1k-0002dp-Vm
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 05:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35401)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiy13-0001pO-W8
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiy12-0006cd-Pu
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:26:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiy12-0006bh-Jo
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:26:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so5011014wms.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 02:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pT2I37Dxf/gfQvnoHHpfem5+6ntsHRbZ8sxz2fUpUiY=;
 b=ebdQ86DICAD6qv9wJr54mf0sYDFF1QLdyT+PmNnrY84V2fnmYfk+iWdFDv1IlfSkaZ
 lH6XDXYa6tsHl5rubviLbX2O4nH5JHNfn9Nt2ODg+XtKRVFiKt2RzMMziNGrdQSV2f+2
 fts0s5wEHWrxWjBroP763WFADCx9GDN/7u48acrOgnXZgCDD0WIwKz/xpg5Uy8K1RnIm
 7eA0Qc3Bc5UreOcEcQWYv3J9Vcz6RZ2RM2VSPjQUxpwHH2GmohSJMjclwAnVTELv1I4I
 7+8sP7NGKMny84KMfrY3RG8SSyfa6MerICIS7WIbdMgiB8xj/U4qhCuaRoSdIkPU0E5p
 Ch/w==
X-Gm-Message-State: APjAAAVmrO3UjJ6SM/hv+uQuytymtQbkd/XkgcT83ca48F0YGhbwILE6
 2+0JUAribAj0+FHVZsN4GfXOK7bxq6o=
X-Google-Smtp-Source: APXvYqz/U+HnX94FZrUkGO4NuFR7ilCL3Q1l+nOhNXygPt0kROaZwPDnhTsVacoaxz8VRshOxd9sjA==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr12353319wmc.62.1562232415599; 
 Thu, 04 Jul 2019 02:26:55 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id c1sm7609690wrh.1.2019.07.04.02.26.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 02:26:54 -0700 (PDT)
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190704055150.4899-1-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cd1f8a48-27cb-5cc5-1fd2-46f1597a7094@redhat.com>
Date: Thu, 4 Jul 2019 11:26:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704055150.4899-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH for 4.1] aspeed/timer: Provide
 back-pressure information for short periods
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CC'ing Stefan & Paolo for a non-ARM view on this...

On 7/4/19 7:51 AM, Cédric Le Goater wrote:
> From: Andrew Jeffery <andrew@aj.id.au>
> 
> First up: This is not the way the hardware behaves.
> 
> However, it helps resolve real-world problems with short periods being
> used under Linux. Commit 4451d3f59f2a ("clocksource/drivers/fttmr010:
> Fix set_next_event handler") in Linux fixed the timer driver to
> correctly schedule the next event for the Aspeed controller, and in
> combination with 5daa8212c08e ("ARM: dts: aspeed: Describe random number
> device") Linux will now set a timer with a period as low as 1us.
> 
> Configuring a qemu timer with such a short period results in spending
> time handling the interrupt in the model rather than executing guest
> code, leading to noticeable "sticky" behaviour in the guest.
> 
> The behaviour of Linux is correct with respect to the hardware, so we
> need to improve our handling under emulation. The approach chosen is to
> provide back-pressure information by calculating an acceptable minimum
> number of ticks to be set on the model. Under Linux an additional read
> is added in the timer configuration path to detect back-pressure, which
> will never occur on hardware. However if back-pressure is observed, the
> driver alerts the clock event subsystem, which then performs its own
> next event dilation via a config option - d1748302f70b ("clockevents:
> Make minimum delay adjustments configurable")
> 
> A minimum period of 5us was experimentally determined on a Lenovo
> T480s, which I've increased to 20us for "safety".
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> [clg: - changed the computation of min_ticks to be done each time the
>         timer value is reloaded. It removes the ordering issue of the
>         timer and scu reset handlers but is slightly slower ]
>       - introduced TIMER_MIN_NS
>       - introduced calculate_min_ticks() ]
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
> 
>  This is fixing a serious slowdown issue with recent Linux. 
> 
>  hw/timer/aspeed_timer.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
> index 29cc5e807081..217d59fa7885 100644
> --- a/hw/timer/aspeed_timer.c
> +++ b/hw/timer/aspeed_timer.c
> @@ -42,6 +42,13 @@ enum timer_ctrl_op {
>      op_pulse_enable
>  };
>  
> +/*
> + * Minimum value of the reload register to filter out short period
> + * timers which have a noticeable impact in emulation. 5us should be
> + * enough, use 20us for "safety".
> + */
> +#define TIMER_MIN_NS (20 * SCALE_US)
> +
>  /**
>   * Avoid mutual references between AspeedTimerCtrlState and AspeedTimer
>   * structs, as it's a waste of memory. The ptimer BH callback needs to know
> @@ -96,6 +103,14 @@ static inline uint32_t calculate_ticks(struct AspeedTimer *t, uint64_t now_ns)
>      return t->reload - MIN(t->reload, ticks);
>  }
>  
> +static uint32_t calculate_min_ticks(AspeedTimer *t, uint32_t value)
> +{
> +    uint32_t rate = calculate_rate(t);
> +    uint32_t min_ticks = muldiv64(TIMER_MIN_NS, rate, NANOSECONDS_PER_SECOND);
> +
> +    return  value < min_ticks ? min_ticks : value;
> +}
> +
>  static inline uint64_t calculate_time(struct AspeedTimer *t, uint32_t ticks)
>  {
>      uint64_t delta_ns;
> @@ -259,7 +274,7 @@ static void aspeed_timer_set_value(AspeedTimerCtrlState *s, int timer, int reg,
>      switch (reg) {
>      case TIMER_REG_RELOAD:
>          old_reload = t->reload;
> -        t->reload = value;
> +        t->reload = calculate_min_ticks(t, value);
>  
>          /* If the reload value was not previously set, or zero, and
>           * the current value is valid, try to start the timer if it is
> 


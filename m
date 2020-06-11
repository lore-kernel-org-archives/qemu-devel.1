Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F54C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 07:35:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AFE2072F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 07:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWd7IsPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AFE2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjHkF-0007xD-9V
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 03:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjHiq-0006F2-Ce
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 03:34:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39046)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjHip-0005eo-Fn
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 03:34:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id k26so4004153wmi.4
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 00:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G5lXivT62i1580UvMBwVMD3q6hah6T/ddCJhlrWqJ7A=;
 b=lWd7IsPe1yG/lDhYBRbQpVU/wc5n/OvzvKPUxOj7hGq3NNg4kr7lAvOnDb5CR6GW+b
 te6V55qFUE6sMIEdHoR0JHc4lLl7JQ9079Zmz8YdBSPtP78lkOpa7cUTNybs4dQkUhBv
 HmlP7arax0TInrtGvYBVEaFvpiCiXoKIzD3Qu5RX394VdcEnIHU/HDPX2anG844KuKPk
 EUnTFqLhWGwzIy0w/jp9jqTB2qlr+g3VmQMwTUYCzjhGBmNUZuSfEAv4EXaNFsh1+h93
 Mm+eG3/rgb4EnQzblObXni8PXTWYC2EJotTCTFIWVIpazCmAT8bzY7jRK1lfAr1vdPHS
 5w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G5lXivT62i1580UvMBwVMD3q6hah6T/ddCJhlrWqJ7A=;
 b=V0z/BEMR3atZxBPnc6sSTb48hlVBa5fe7AYSUhx1Xrt9OEk56EAoDxyRwuG3qhInJI
 tR0CargXlCkOEE9RIGQLQOiniHZWUOSD8IMd5ChK/b+/e+FtZTVFmUFLAgQal35sCn3V
 6TIVohv2MiOWhBZfrs3WBv5IgmQMuaS7UJJ8h7N31sCCPNXKQil5nNGz8pn3dqZyDkZK
 MHywulijDXawwaNDELl4Bvjhf/UCPQ785+9LrpTaxMPBm0Xk6ouBhgWPNHRQdYzl9TbI
 jza7JrwO2mPmYIwmv6rey4lIHDs8FiOks30bPFMMdzshX57vjxBvPktSlV49lyYKcKpa
 LiBA==
X-Gm-Message-State: AOAM5332dIdCR4cTiaDC+alD8yA6ODp89cTsa+iYkfXFZ6VsTbvlkYNf
 h/8UMBnLyN7RLNneP4uP8X0=
X-Google-Smtp-Source: ABdhPJz4Yv87PePgMQwkYXpl7X9ukh7wYXU77sXG4wnig61wD6xU2CVEoRJt+mJjLlrDoEFIf9IhYA==
X-Received: by 2002:a1c:3bc2:: with SMTP id i185mr6923025wma.33.1591860832733; 
 Thu, 11 Jun 2020 00:33:52 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id b81sm2993605wmc.5.2020.06.11.00.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 00:33:52 -0700 (PDT)
Subject: Re: [PATCH] hw/m68k/mcf5206: Replace remaining hw_error()s by
 qemu_log_mask()
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
References: <20200611055807.15921-1-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b221aaa3-280b-7c9d-c2d8-2b1991def4ac@amsat.org>
Date: Thu, 11 Jun 2020 09:33:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200611055807.15921-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 7:58 AM, Thomas Huth wrote:
> hw_error() dumps the CPU state and exits QEMU. This is ok during initial
> code development (to see where the guest code is currently executing),
> but it is certainly not the desired behavior that we want to present to
> normal users, and it can also cause trouble when e.g. fuzzing devices.
> Thus let's replace these hw_error()s by qemu_log_mask()s instead.
> 
> Signed-off-by: Thomas Huth <thuth@tuxfamily.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/m68k/mcf5206.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
> index a2fef04f8e..94a37a1a46 100644
> --- a/hw/m68k/mcf5206.c
> +++ b/hw/m68k/mcf5206.c
> @@ -10,7 +10,6 @@
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "cpu.h"
> -#include "hw/hw.h"
>  #include "hw/irq.h"
>  #include "hw/m68k/mcf.h"
>  #include "qemu/timer.h"
> @@ -69,10 +68,16 @@ static void m5206_timer_recalibrate(m5206_timer_state *s)
>      if (mode == 2)
>          prescale *= 16;
>  
> -    if (mode == 3 || mode == 0)
> -        hw_error("m5206_timer: mode %d not implemented\n", mode);
> -    if ((s->tmr & TMR_FRR) == 0)
> -        hw_error("m5206_timer: free running mode not implemented\n");
> +    if (mode == 3 || mode == 0) {
> +        qemu_log_mask(LOG_UNIMP, "m5206_timer: mode %d not implemented\n",
> +                      mode);
> +        goto exit;
> +    }
> +    if ((s->tmr & TMR_FRR) == 0) {
> +        qemu_log_mask(LOG_UNIMP,
> +                      "m5206_timer: free running mode not implemented\n");
> +        goto exit;
> +    }
>  
>      /* Assume 66MHz system clock.  */
>      ptimer_set_freq(s->timer, 66000000 / prescale);
> @@ -391,7 +396,9 @@ static uint32_t m5206_mbar_readb(void *opaque, hwaddr offset)
>      m5206_mbar_state *s = (m5206_mbar_state *)opaque;
>      offset &= 0x3ff;
>      if (offset >= 0x200) {
> -        hw_error("Bad MBAR read offset 0x%x", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR read offset 0x%" HWADDR_PRIX,
> +                      offset);
> +        return 0;
>      }
>      if (m5206_mbar_width[offset >> 2] > 1) {
>          uint16_t val;
> @@ -410,7 +417,9 @@ static uint32_t m5206_mbar_readw(void *opaque, hwaddr offset)
>      int width;
>      offset &= 0x3ff;
>      if (offset >= 0x200) {
> -        hw_error("Bad MBAR read offset 0x%x", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR read offset 0x%" HWADDR_PRIX,
> +                      offset);
> +        return 0;
>      }
>      width = m5206_mbar_width[offset >> 2];
>      if (width > 2) {
> @@ -434,7 +443,9 @@ static uint32_t m5206_mbar_readl(void *opaque, hwaddr offset)
>      int width;
>      offset &= 0x3ff;
>      if (offset >= 0x200) {
> -        hw_error("Bad MBAR read offset 0x%x", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR read offset 0x%" HWADDR_PRIX,
> +                      offset);
> +        return 0;
>      }
>      width = m5206_mbar_width[offset >> 2];
>      if (width < 4) {
> @@ -458,7 +469,9 @@ static void m5206_mbar_writeb(void *opaque, hwaddr offset,
>      int width;
>      offset &= 0x3ff;
>      if (offset >= 0x200) {
> -        hw_error("Bad MBAR write offset 0x%x", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR write offset 0x%" HWADDR_PRIX,
> +                      offset);
> +        return;
>      }
>      width = m5206_mbar_width[offset >> 2];
>      if (width > 1) {
> @@ -482,7 +495,9 @@ static void m5206_mbar_writew(void *opaque, hwaddr offset,
>      int width;
>      offset &= 0x3ff;
>      if (offset >= 0x200) {
> -        hw_error("Bad MBAR write offset 0x%x", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR write offset 0x%" HWADDR_PRIX,
> +                      offset);
> +        return;
>      }
>      width = m5206_mbar_width[offset >> 2];
>      if (width > 2) {
> @@ -510,7 +525,9 @@ static void m5206_mbar_writel(void *opaque, hwaddr offset,
>      int width;
>      offset &= 0x3ff;
>      if (offset >= 0x200) {
> -        hw_error("Bad MBAR write offset 0x%x", (int)offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "Bad MBAR write offset 0x%" HWADDR_PRIX,
> +                      offset);
> +        return;
>      }
>      width = m5206_mbar_width[offset >> 2];
>      if (width < 4) {
> 


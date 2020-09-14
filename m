Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18AEC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C5392076C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wwm1cGyy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5392076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHlkK-0000N1-5a
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHljf-0008O2-6f
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:29:23 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44668)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kHljd-00012l-Nb
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:29:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so18086789wrw.11
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fL8WxlYYCcQRa1GaC6JDjJNvG3OwiaTq3tUP+O/K0oc=;
 b=Wwm1cGyy6VHXT0UPIGKz7sKtcs4OhkNoylkXmI6XVmnTytFw4FsNiLppIItwjOPD0c
 L3T/1pO+n++bNh1mYPfgge/4kWBek7r1aOcbwhiJw2bWfc/2rHt+kxa0/+a+roAbm9Ro
 RP7UK7Bw/pvhMcSfxGJWlTXSxWdPEpqQZYukh5HGavigDYcwwIjDuBQzZyuj1/r/uoU6
 cTmrDFfljIESlv6UXyxt+asJrTDI/XOwm7SjdOvqlZ1Kieqb0MGS5YibMILOOcN0fzpi
 jW3QyIpoZcL/Qi2/VBgVi8n7kdoeP/DVALahyhNf7aShoeKBbamk/7IDT9jWB8SEAU4e
 9jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fL8WxlYYCcQRa1GaC6JDjJNvG3OwiaTq3tUP+O/K0oc=;
 b=QvRZnZ7CvfW67t7crus9gVpBY1JQ8oNQJk+vGxY+L6Z5zFPdsfr7CgMs7QYPa61Rjr
 uGaRoXe0Dfy+1yzfOK5myW8FAqQez5a0V1FfIqyTQGpLbJ4NmFkH9ZvfPUziPZm5yoC1
 ImNZDP5tFsLEX0GPG4ufElu0uiXlCd40RrdZu6rZXbgUq0haPTUeZv1fqHlMkjrqFDt5
 9keU/3NB5YhYYDidp+V6FRR8E5v5Z4fLGvO96+qMP8KRr1JQcX1e+ZINUDUS/rexY7+z
 BS1vBZEfesa0rhDwdZG5K9FeeJaytmFFNEOtwSm5KTsq2pR6K53oYwBHwmHb/6cxzJGv
 ph+Q==
X-Gm-Message-State: AOAM530Uh3N1zWK6PU7OnobwKn0udpylJ+6aaQFziMpeHHn1w6MhoAgX
 LVeD1q3s4qAJYFoI90PigLQ=
X-Google-Smtp-Source: ABdhPJyUdcCbKdHL2Bw1anvmfHoV89NJ7y8K2voalcSQOX3Jvph5QeKCUnqH7m/FcLR0DtkWsV/cuQ==
X-Received: by 2002:a05:6000:11c5:: with SMTP id
 i5mr15462641wrx.18.1600079360484; 
 Mon, 14 Sep 2020 03:29:20 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id k6sm17180539wmi.1.2020.09.14.03.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 03:29:19 -0700 (PDT)
Subject: Re: [PATCH] ui: Fix default window_id value
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200914100637.eeommoflirxrgaeh@function>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d73fd906-8bd7-36a6-5fdb-eb33fc19901f@amsat.org>
Date: Mon, 14 Sep 2020 12:29:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914100637.eeommoflirxrgaeh@function>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 12:06 PM, Samuel Thibault wrote:
> ./chardev/baum.c expects the default window_id value to be -1, and not 0
> which could be confused with a proper window id (when numbered from 0 by
> the ui backend).
> 
> This fixes getting Braille output with the curses and gtk frontends.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Fixes: f29b3431f62 ("console: move window ID code from baum to sdl")
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> ---
> It would be useful to backport this to stable trees.
> 
> diff --git a/ui/console.c b/ui/console.c
> index f8d7643fe4..beb733c833 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -1310,6 +1310,7 @@ static QemuConsole *new_console(DisplayState *ds, console_type_t console_type,
>      }
>      s->ds = ds;
>      s->console_type = console_type;
> +    s->window_id = -1;
>  
>      if (QTAILQ_EMPTY(&consoles)) {
>          s->index = 0;
> 



Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8218AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 05:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC7A207F9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 05:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9PiRYWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC7A207F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiWb9-0002gi-GL
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 01:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiWaF-0002Ep-U6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 01:13:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36879)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiWaF-0001hX-3d
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 01:13:59 -0400
Received: by mail-wm1-x342.google.com with SMTP id y20so1717883wmi.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 22:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7r6Fu/4xAQnkABgqB82qx95ftnu/021paPN/zh1xp6g=;
 b=Q9PiRYWNmGMw57EhtDoOOqRqbzzYQbqbpuf9szOiPR6qVXalEYuBCTR31rN6Q7g8vo
 Rzo6/yUQ0BLabZ6jFnoYr1DMBzXxJEOehng12cd4q2MTu1Qf3OAae7P0RHyZ0+70BxUh
 1EAWL3nqLCWoc732jBhWdYrvTwW0z6ggBAi5pMWKnIgjfyN8XiiYWXwUS7+Y4UIhFMMM
 aUwv3ME7qnroKaY9PkZqO4ooxL0xU12EX2mP2LnX4+WkqBP4CSjy8Naxd3854hEM+UyO
 b7qwsdSeQpV4YQbdfMoLAh6MWzH3u7igAL2SEkJB6OytrVC1djDK07YaJ7lokLi2SaJl
 IKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7r6Fu/4xAQnkABgqB82qx95ftnu/021paPN/zh1xp6g=;
 b=P58Qw2ddlAE15uLXbSfkI8NKCJikIao+QcJsjG9IjeEh3AiGeaqLncdmZgUvvrDCw0
 rvsI+PvVMU1ElbRdfqrwCzBLTd+vv+AaEB82u01BrtJ25IniZoDKZLqdsfFnMeKCpP4T
 yjw+wvt5udvKVYBqWGdnscZJESbPpPhKqFbN43eYdhS/30lAHfsytZoKZLr+X4yBB1M1
 09yY6qqzTEdxBlNrOwFtTqkIRh4ZRFmPn7C/KQBf0Ln8NaTIDNa8i7nFKlQPlwRnXYg7
 Qk31/41k7QrNTuuesGRJisW+IohNswN89C/TQXWkKPJd6m3Rw3Qn0ArhGNpKRLLn1LUn
 4GCg==
X-Gm-Message-State: AOAM532Rzeh00Y7LiQzH41bKyDpEU5kKLzmjL6On51S71YBvmIFxrnj7
 px/C7+M6OHHtKZDtPvAKEYo=
X-Google-Smtp-Source: ABdhPJyFzWdwkyVvyNiQv3pVJ+3Ch1iHC31aVlih/PhRiaKmPXpvk7/Z5fJGL2LdnXkVSzUrAqq3pQ==
X-Received: by 2002:a1c:a444:: with SMTP id n65mr1981835wme.99.1591679636821; 
 Mon, 08 Jun 2020 22:13:56 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id l2sm1908961wru.58.2020.06.08.22.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 22:13:55 -0700 (PDT)
Subject: Re: [PATCH 0/7] hw/misc/empty_slot: Spring cleaning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200510152840.13558-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <80705ec9-312d-cd4d-f357-72ab4a323f0b@amsat.org>
Date: Tue, 9 Jun 2020 07:13:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200510152840.13558-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/10/20 5:28 PM, Philippe Mathieu-Daudé wrote:
> New Spring, new opportunity to clean this device :)
> (v1 was in 2018, v2 in 2019).
> 
> - lower device priority
> - follow qdev model and use properties
> - convert to trace events
> - describe with slot name
> - move under hw/misc/ and cover in MAINTAINERS
> 
> Peter, I hope you are OK adding it wit UNIMP device,
> as both are very similar, and don't have much activity.
> 
> Only MIPS/SPARC32 targets use this device.
> 
> v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg626498.html
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg564060.html
> 
> Philippe Mathieu-Daudé (7):
>   hw/sparc/sun4m: Use UnimplementedDevice for I/O devices
>   hw/misc/empty_slot: Lower address space priority
>   hw/misc/empty_slot: Convert 'size' field as qdev property
>   hw/misc/empty_slot: Add a 'name' qdev property
>   hw/misc/empty_slot: Convert debug printf() to trace event
>   hw/misc/empty_slot: Move the 'hw/misc' and cover in MAINTAINERS
>   hw/misc/empty_slot: Name the slots when created
> 
>  include/hw/empty_slot.h        |  9 -------
>  include/hw/misc/empty_slot.h   | 19 ++++++++++++++
>  hw/mips/mips_malta.c           |  4 +--
>  hw/{core => misc}/empty_slot.c | 47 +++++++++++++++++++---------------
>  hw/sparc/sun4m.c               | 23 +++++++++++------
>  MAINTAINERS                    |  4 ++-
>  hw/core/Makefile.objs          |  1 -
>  hw/misc/Makefile.objs          |  1 +
>  hw/misc/trace-events           |  4 +++
>  9 files changed, 70 insertions(+), 42 deletions(-)
>  delete mode 100644 include/hw/empty_slot.h
>  create mode 100644 include/hw/misc/empty_slot.h
>  rename hw/{core => misc}/empty_slot.c (66%)
> 

Thanks - except the MAINTAINERS change (merging empty_slot with
unimp device) which Peter did not ack - series applied to for
the next (temporary) sparc-next pull request.


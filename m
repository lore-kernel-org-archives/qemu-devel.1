Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCF5C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:56:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9DDA2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtTIbCsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DDA2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfRGP-00030G-7e
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfR5q-0003cW-UM
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:45:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41334)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfR5q-0001Lk-3S
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:45:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id j10so9065981wrw.8
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rcRt5hRKYsOCngwFksCi7aIsGDFquSF0YGSBXyIu96E=;
 b=XtTIbCsEugHvb4M5iVBxMjvBH5J6lD2lJOhs0nyDpgqOQ/ISz5vFEWbKoM+ALdxWV2
 x7DCGUYIujlA4vUHcpiTz+3e4rJbjzt03BMXLNJjdTmjbC3J/73HPw5Q6/EeaeorTraf
 TGLOke4ZHMQ9t0S0ANhmGi9Gw7bPrQV6XgAkDNcP+jOIxZhLh6m58ReiPmHWQnOMkx/9
 +kcfu9jrDq0nbJVvIxEDdx4uRLRmmo5zeWEFGMBslVPHPyH6ukm1NRoUy4Ifo0InR1tv
 hR6PnYcr+uXrlKoJugJmKK2RXJQznTm4Hl1uAK1OfueA6zel8DyAFPl7GaDBNw7wy9qo
 47Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rcRt5hRKYsOCngwFksCi7aIsGDFquSF0YGSBXyIu96E=;
 b=mMKtnDXhbMsvZSS/xQ7uqj/3ZCJXaaeRrYSKByXaYFUqTHLrr2DkqgNz8ywLb9mNJK
 UE7QHIjpOSH6/xuHjHRnX2EwOTlEEfB7xC9ugNwAIzFGmoH2f3LwHuqid7ATMz41IX3V
 TB5TyUmRvEW65EfKuiCHi+Rpfpcl9zP4GXS3KEjzMD6o8I4tdz7dwitPT8tU0Y1076op
 DAz0M6VENObOjMl6tWGzBaYHs2VPmasZ5LqVjl2oUQFASCwvJYuofQPO39K0IAXsoUiP
 mN+UvtWhbRmNieggNUVhaXNmqaD/9LoRiImYrrvHo+S5qdvtyTqPD1OR+tStXVgjP8Pf
 N51Q==
X-Gm-Message-State: AOAM532LDyZViP6m84h5//92WKd4MuQXt57DKONb8T7odrMLOB1aC5W4
 OM4on2gL+oDOCN5eyTvpH6AorkSI
X-Google-Smtp-Source: ABdhPJypbDyrB4limgqD157g8NGrz9XvGMgcXFYdiC2UQkRKPj65XffaiXF8V8s5o6veTfbL5JvBbw==
X-Received: by 2002:a05:6000:12c8:: with SMTP id
 l8mr18641744wrx.148.1590943548190; 
 Sun, 31 May 2020 09:45:48 -0700 (PDT)
Received: from [192.168.1.34] (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id m24sm8788098wmi.14.2020.05.31.09.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2020 09:45:47 -0700 (PDT)
Subject: Re: [PATCH 00/10] Add RX hardware emulation
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200531162427.57410-1-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d7fc8b59-5a22-8383-b939-1cc73f8c2e66@amsat.org>
Date: Sun, 31 May 2020 18:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200531162427.57410-1-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/20 6:24 PM, Yoshinori Sato wrote:
> Hello.
> 
> This series add to hardware emulation module for RX target.
> 
> Details below.
> Interrupt controller, 8bit timer, 16bit comapare match timer and
> SCI is RX62N integrated peripheral.
> rx-virt - RX62N MCU and external RAM. It like gdb simulator.
> 
> The compare match timer has a CPU interface similar to the SH4 timer.
> sh_timer will be deprecated and integrated into this module.
> SCI is also implemented in sh_serial, but the functionality is omitted.
> I implemented the complete one as renesas_sci.
> 
> git repository here.
> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git tags/hw-rx-20200601

Sigh. It is a bit unfortunate and demotivating that we can not
coordinate this. I was going to send a pre-merge for this today.

What is positive is you unified some SH4/RX peripherals.

I'll try to merge both series. If it takes too long, I might send my
current queue for you to review, then go back to this one you just sent.

Regards,

Phil.


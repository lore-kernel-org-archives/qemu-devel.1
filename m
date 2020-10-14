Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03115C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35734214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oEp4onOW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35734214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmdK-000146-JF
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSmSk-0000Cy-GN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:29:26 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSmSi-0002fH-NE
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:29:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id b127so724209wmb.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pa+S4A6urV8tQPVOdMA1sX31T61m/1jvFMOS2zcjyXI=;
 b=oEp4onOWtsIAgrjn9rY4xO/fQ3GZhJa3TPygeRq4H+btrdNU+pSIjG8zFVJSkfT4Az
 eIxSBT258krVtcEnhMlKg7Z90/KIKtNT94u5w8kxJqtT7Vh3ZG5c9e9l+yrT8YWlG14s
 JLVGOPHEP6pMhDWZRnIm0fmM1P8VgXqxNwoG1psz+TGlIO+fH0ceUrN55QrQ5+40oUTV
 6ABb8gnj9oZF8RjytMtXG9KgSDm/LULbB8FRHlXJOTUoHVyQSCtJdkH9nNB81J1Yjl6u
 tt0Tz2muWgVKNzzFUenNAAxn4B5GuuJQloaVLFl0yqvjBAkK/dUSRBD5osvYle1r6rtZ
 mIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pa+S4A6urV8tQPVOdMA1sX31T61m/1jvFMOS2zcjyXI=;
 b=bRbhntiryazSDijeNyblW278q0uBsXkBTGaV2VW7veBacSFl8dJxcjDxeZ3Qzqqux4
 yuCruJUgH+FxhUn18/RUqdg6chl1aUaZgL9ieOLXQgZ3jfMGjgsrcNpUx7hN/+2Foiiv
 mFt7XUM+yMsUcxi+8u03arHf4TpnKmezSyXl8VW9DCOqZRRol23QRNX7N3gh/46RhzIO
 HiB0LWoftw8axytDRIVhCO+SrC8F+3ScF+kg6CqyJ9QkwCSiJJFXP+1NtDGSrk+J92Xv
 7q/xyUvlLkH3+Emlv8XNSW86A29V9PcC7VMPBq+akYQxQUpgYQSGR9885NT7/wmDBXMW
 yV6w==
X-Gm-Message-State: AOAM530jUQ2/dup0DmLdIEg8lpDQHy2O4LyFw+HSSsDh37T3achdSxXX
 E931tw5E1VvbCE1RZgIwPPZpaJPVjK8=
X-Google-Smtp-Source: ABdhPJzi2Rx6TIPXZrhVgZhGDVcohsQ6hwgZ0aovaKwUgVFjTHLpMXqPa+e9yjjkB8lhZgSS/dovsA==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr344621wme.115.1602703761976; 
 Wed, 14 Oct 2020 12:29:21 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id h3sm425492wrw.78.2020.10.14.12.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 12:29:21 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] accel/tcg: rename tcg-cpus functions to match
 module name
To: Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20201014192324.6390-1-cfontana@suse.de>
 <20201014192324.6390-4-cfontana@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eead5581-a1a7-4ee0-75c2-e6aecefb5646@amsat.org>
Date: Wed, 14 Oct 2020 21:29:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014192324.6390-4-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 9:23 PM, Claudio Fontana wrote:
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>   accel/tcg/tcg-cpus-icount.c | 24 ++++++------
>   accel/tcg/tcg-cpus-icount.h |  6 +--
>   accel/tcg/tcg-cpus-mttcg.c  | 10 ++---
>   accel/tcg/tcg-cpus-rr.c     | 74 ++++++++++++++++++-------------------
>   accel/tcg/tcg-cpus-rr.h     |  2 +-
>   accel/tcg/tcg-cpus.c        |  6 +--
>   accel/tcg/tcg-cpus.h        |  6 +--
>   7 files changed, 64 insertions(+), 64 deletions(-)

Maybe squash earlier, regardless:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


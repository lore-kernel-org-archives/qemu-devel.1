Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49BBC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF372084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 13:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hISbBm5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF372084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyy8A-0002NN-Lv
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 08:20:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iyy5K-0007X7-EI
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iyy5I-0003Fa-Ue
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:17:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22544
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iyy5I-0003Ak-NV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 08:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580822263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JDKQ9bqFuB/A3jANSkTwjFW4W1/ohoMgBfpIFxy+hIY=;
 b=hISbBm5YrDXElhNmThYkbmLHLZB0QEBZWEZQVNkN6GWMZWYIW/Hx3bxh5CIV7ulsXYOhuV
 6zsQiGU/V2oQCw1Y5dQcxl03LiSPDQcae9jyKnLCSLlvRDvFyi/DrXpqeahNsZ29jqzDmW
 NPiJN9vYpfETDHAxPlSE7xFgKtTC1RA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-i9Orl8TwN0-1znu_ssgxIw-1; Tue, 04 Feb 2020 08:17:42 -0500
Received: by mail-wr1-f70.google.com with SMTP id t3so10076196wrm.23
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 05:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JDKQ9bqFuB/A3jANSkTwjFW4W1/ohoMgBfpIFxy+hIY=;
 b=AnbS/k4VmgmlngvKJ3bZv+FQXegKBbzeugkjP6AXZdIyhrqbaBfDJqxbluDbLS6B/m
 YuBc3dRnij08v8KCi9zJkjDz8FXYj69/n58qoefFhFThnavDbzVmjITZvvgw/dwwm45X
 s6hTTgBTrZeWdijeT4F1UYuksCxw9BkLg5EdoP9niHNTyrOQIZLrK80x0lFBWzohORZ8
 20aMVFJSqM+3SeZahZOaQIsaAiLUxumybL/UT8ZukZqLliJx8QeD1E8f18mGeIvwnYqa
 gXp9K3/5hMm7ljk9OoNkkdZh/Xn20Mq927h0VWNL5ZciIfLNLeGO/6cg6bdHPQ1PgKRD
 6b0Q==
X-Gm-Message-State: APjAAAWEwVU/EEkNmuL+ComgiOFCX3FZ1G7PywUzlBRxxhr+YIbZ2M6z
 OlmP551yc0VX5T9blrclxVj83aH+9hHSJmU9JxSZV6y+ukY2X/1RtV2jUrz9LKxK1q3kM8lR+DP
 tSHzDHYlUnEKBK48=
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr5866786wmk.49.1580822260914; 
 Tue, 04 Feb 2020 05:17:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxib8cElt42EBJipAFlLZODxuMcvWtHy6wL2EPKm6Nn/hbACUAmZr+sTcS3JQJRPzJIl0beeQ==
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr5866763wmk.49.1580822260545; 
 Tue, 04 Feb 2020 05:17:40 -0800 (PST)
Received: from [192.168.178.40] ([151.20.243.54])
 by smtp.gmail.com with ESMTPSA id g7sm29809083wrq.21.2020.02.04.05.17.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2020 05:17:40 -0800 (PST)
Subject: Re: [PATCH] Remove support for CLOCK_MONOTONIC not being defined
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200201172252.6605-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e60ada0c-9a88-43ab-40d2-eadc30f90f5b@redhat.com>
Date: Tue, 4 Feb 2020 14:17:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200201172252.6605-1-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: i9Orl8TwN0-1znu_ssgxIw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 01/02/20 18:22, Peter Maydell wrote:
> Some older parts of QEMU's codebase assume that CLOCK_MONOTONIC
> might not be defined by the host OS, and have workarounds to
> deal with this. However, more recently (notably in commit
> 50290c002c045280f8d for qemu-img in mid-2019, but also much
> earlier in 2011 in commit 22795174a37e0 for ui/spice-display.c)
> we've written code that assumes CLOCK_MONOTONIC is always
> defined. The only host OS anybody's ever noticed this on
> is OSX 10.11 and earlier, which we don't support.
> 
> So we can assume that all our host OSes have the #define,
> and we can remove some now-unnecessary ifdefs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I've left in the runtime-check in init_get_clock(), as it's
> less easy to see if the fallback there is ever used.
> ---
>  include/qemu/timer.h     |  5 +----
>  util/qemu-timer-common.c | 11 ++++-------
>  2 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/include/qemu/timer.h b/include/qemu/timer.h
> index 85bc6eb00b2..6a8b48b5a9d 100644
> --- a/include/qemu/timer.h
> +++ b/include/qemu/timer.h
> @@ -838,14 +838,11 @@ extern int use_rt_clock;
>  
>  static inline int64_t get_clock(void)
>  {
> -#ifdef CLOCK_MONOTONIC
>      if (use_rt_clock) {
>          struct timespec ts;
>          clock_gettime(CLOCK_MONOTONIC, &ts);
>          return ts.tv_sec * 1000000000LL + ts.tv_nsec;
> -    } else
> -#endif
> -    {
> +    } else {
>          /* XXX: using gettimeofday leads to problems if the date
>             changes, so it should be avoided. */
>          return get_clock_realtime();
> diff --git a/util/qemu-timer-common.c b/util/qemu-timer-common.c
> index 06d084d3646..baf3317f745 100644
> --- a/util/qemu-timer-common.c
> +++ b/util/qemu-timer-common.c
> @@ -49,14 +49,11 @@ int use_rt_clock;
>  
>  static void __attribute__((constructor)) init_get_clock(void)
>  {
> +    struct timespec ts;
> +
>      use_rt_clock = 0;
> -#ifdef CLOCK_MONOTONIC
> -    {
> -        struct timespec ts;
> -        if (clock_gettime(CLOCK_MONOTONIC, &ts) == 0) {
> -            use_rt_clock = 1;
> -        }
> +    if (clock_gettime(CLOCK_MONOTONIC, &ts) == 0) {
> +        use_rt_clock = 1;
>      }
> -#endif
>  }
>  #endif
> 

Queued, thanks.

Paolo



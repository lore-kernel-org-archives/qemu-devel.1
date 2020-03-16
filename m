Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5ACC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:10:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C756B20719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 20:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmE9Y6GI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C756B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDw3n-0002MG-2R
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 16:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDw38-0001q5-3J
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDw35-0004kJ-JD
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:09:21 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDw34-0004Xo-Aw
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 16:09:19 -0400
Received: by mail-pg1-x541.google.com with SMTP id t24so10347139pgj.7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 13:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iHWNGHwZg0b9gZmRRuZF0ElUxFU5qu0I08unHCAlUTo=;
 b=CmE9Y6GIRrEIFvCBFwc3pmjmYPqQ/MY52zfMZfNZMTcbUXhyZGGYlCZi0eVCmBVCIP
 UjA7lYlBipTKZTVo2Gs75p76wj/pRrheSrHYLUmItGJcc+gqetzboJpaJBUaGIrMSgAN
 0FTeLyZVjdPXRhJxsu6aNeWE1kO09Ftpzk+QceM+nx+SJOTKhUlrVD1tm8IBRwwNjTPn
 h49QreqTPOmHVcyCcpZqMeAgcqRGf1qVvtY4LK0JhEN3VxFuXWoCY9XltQgKBGVzsLhg
 yvm6EGvbW3L0mo22l2kWROnd/oYRhTsA4zusQ+fQfoCFE5QZys27szf2nvMqOxshtxjM
 BWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iHWNGHwZg0b9gZmRRuZF0ElUxFU5qu0I08unHCAlUTo=;
 b=LYhMmcgpHpurPDjmYvTlBf56bnlgFbiv3uB1YqHV6zA/1UyCMOT9ztTev/VaqOAM7S
 OtnJ6WRWJiQIiIHaslFQgEimzu4zg3CDTDH02tMf/QlwL7bQxgjLD2gcLa0fDGG9Igu2
 QAgfLMa8a9schHbJZ5O4UHlsOJAo5zM5halTINX1Z52zDF4fy8wtSRWyJ7H5FcBMo0ue
 SSRTa6CGy2kVHirq+bZFzpY175s/x5fnBcKbF2s7aOMP3G8RHop0ILeE1fupxbBxfe0a
 9fGQf76NOItlm6euknLfKSy7tcqi/hh9N3mmU9z2EKSII+5dukFnMKMHWibdyeN4YttO
 BjNw==
X-Gm-Message-State: ANhLgQ1jkc+C6uaO0kjrX1rOqjV1wFtcCiqZ+o0RN00ZfmjGpjJMyqho
 Z0jhH5UC47FTWmtEVUsvQebNKw==
X-Google-Smtp-Source: ADFU+vvwIq9UpPBuFyug8mpIP8LNVAnbLWqF2AkU3+pV85O/b7C5pVFS7sPIzV+bLSU23jKDsIvnSg==
X-Received: by 2002:a62:4ec4:: with SMTP id c187mr1376639pfb.223.1584389356184; 
 Mon, 16 Mar 2020 13:09:16 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 r186sm685696pfc.181.2020.03.16.13.09.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 13:09:15 -0700 (PDT)
Subject: Re: [PATCH v3 09/19] target/arm: Move ARM_V7M Kconfig from hw/ to
 target/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-10-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d09210dd-2837-1fb3-2dc5-c17c2f86d908@linaro.org>
Date: Mon, 16 Mar 2020 13:09:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> ARM_V7M is a concept tied to the architecture. Move it to the
> target/arm/ directory to keep the hardware/architecture separation
> clearer.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/Kconfig     | 3 ---
>  target/Kconfig     | 2 +-
>  target/arm/Kconfig | 2 ++
>  3 files changed, 3 insertions(+), 4 deletions(-)
>  create mode 100644 target/arm/Kconfig

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~


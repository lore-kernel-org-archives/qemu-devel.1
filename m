Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791A5C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3944A20721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/c+YBk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3944A20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVeqC-0001yM-B2
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVeof-0008CM-Ii
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:23:41 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVeoe-0004mh-N9
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:23:41 -0400
Received: by mail-pf1-x442.google.com with SMTP id y25so5852574pfn.5
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NGvAWxkqCIyyAwGZQ7SL2t/jWme3fwef6fP8pgEOidQ=;
 b=U/c+YBk6klsDXgt2Js6oAdP10/9wxGV/0vrK/G6Z1UnnxZZAz85o6KsGJpzBIM9OmM
 l/z5fbxIio3SxLEqAsUF6vCvIUEaUtCskRLiLU92AQf25zMeDHMw6+ZPTHM1JukRpsi5
 BDRGdsMp5YsMaa3Kvc0RX1FTL3ZuPQURQevdXY/e5qahP/Twj0FLngLJ2KNjvsSoniBp
 bXSU5oDgOYv+5QqWhDlDYfGBfYy6QzOrTr2xAVTS7IRIW6E3cICKHP10mhrLwx5Ez1hp
 He2HYahT9yRX6IoBUbXBHZ+OjgLzyWibvANyxQMTa/4ztfBd9RA+XIkgLdNLbdObGjrF
 6gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NGvAWxkqCIyyAwGZQ7SL2t/jWme3fwef6fP8pgEOidQ=;
 b=jsnTdZSvwxhlobIUqflPXZ+jJ60ZJcEgWmt29t2gLbTBrEFy52ITvJ6x4Ul9BdQB7Z
 Nzpm7FNioRn243PTlF5ZzRP0TfJga+Ivsn0wAVPeSDL2M/WKLsoNG0x9Vg5G29SUhxHb
 IDyAJMYW2o2hxtbhBh3vbbyHeTRSkj+EJ/IE2sOf5fz+3w4lq1wEJi5CgasDYrbyHh8Y
 7xMqC9JoaH8eIqxa5q3SZ5gkX6ycKDuN7dnw6X7zj0syJmNpx0dsdAp8NLK4rxJaroEg
 iZqGrk9ruNYv2lYSzLd22nHyVl9ielYj55csyD2pdULkLHoNg3qH57VRJlB/xRp2kg8a
 GAaQ==
X-Gm-Message-State: AGi0PuagTWYMkDKYllQX6QKHTMk+6/h0/Dx7Hj9bwtbfnvILfmhzwIMD
 0pNtnHoa7aMdLalFkJG/nB2Ludi1Vyk=
X-Google-Smtp-Source: APiQypLsPZFO+6xYCzOzMSsCw0iAA21vb3PufceTO5yfi/jpmfEJu2130mq8TeWw7JVHaBNDntGY1A==
X-Received: by 2002:a65:5805:: with SMTP id g5mr45313pgr.110.1588613016914;
 Mon, 04 May 2020 10:23:36 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id f26sm9294985pfn.183.2020.05.04.10.23.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:23:35 -0700 (PDT)
Subject: Re: [PATCH 1/4] hw/i386/pc: Create 'vmport' device in place
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504083342.24273-1-f4bug@amsat.org>
 <20200504083342.24273-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <73ed450c-9a23-f05d-fd3b-1d163e1137c0@linaro.org>
Date: Mon, 4 May 2020 10:23:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504083342.24273-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 1:33 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/i386/pc.h | 6 ------
>  hw/i386/pc.c         | 2 +-
>  2 files changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



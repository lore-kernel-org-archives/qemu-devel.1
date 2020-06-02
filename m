Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5115CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:11:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20D2C206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="illVb5fh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D2C206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfuWS-0002PU-AW
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 20:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuVe-0001n8-UA
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:10:26 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuVd-0004vQ-Nd
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:10:26 -0400
Received: by mail-pf1-x442.google.com with SMTP id a4so4202723pfo.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fIKLbHoFKg+nznod2itU42c+/0e2vFiUewBNDVR2woY=;
 b=illVb5fhOxZSpL6paFF/zFih/5SCmShPxekPzVodzrtSxB8k2nAPRHKd5iQhXx5P3V
 tI2SfQAYd0wWCwOHcEYfax+tsw6bKst0Ftbj/fDM6p+3wg4IINot9hn9jbALLgLqX/Xa
 WThNjKNBIcwHhlkdFoumCncKZJkAGHtoMfCj03lfjlFutQ1COBeEuDSwdZ6af6Zliomd
 ErAql51P2F8Xp4oMCrHBTbhbwihK476K5MYUxSim/PtTxHl2tz1vO5wQtrDAv2SR/s8z
 AU/U6ayMh2jsTEid7KZVT5o0cXzDcOL788x3stLqsS8ojm5iiGrpmR3hictVDaQ5hnRl
 xO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fIKLbHoFKg+nznod2itU42c+/0e2vFiUewBNDVR2woY=;
 b=XvL97gEd4Bv7WB377Zd3aV17SSQYBf9UK+qKDIf9v3rARZlRjzxDyBN/LdCJNx37A/
 HFK8I0N4/alRyfFrVrrk76Id4JBXE1wc7gzyRn7ODK6HNPm3pBGzqLdZG1Wbg3CUGPpA
 kSdhWhTMfgpK/Upe32JoxUkcHgW8r0HE99Fo1gQlxLo4XjTENG2vJw6Pt44vBqu3rNkr
 /A1HZADlvq7SYBZ1YLTKUPUaEO7wkkgdc/hJkH5rMvt4TxXO0iTAi8j1Lrr+J90C6hX9
 kiZxQ6vHquF34vgIO0Z9xSkVhibq5+KUXWg884HDcohmOo7T/BjSe1CuWCGjITxymPjg
 FbBA==
X-Gm-Message-State: AOAM532vYGosztz15hrChvO+r7KrypJy6y6x/NgklNyQ0wiJOm4Lj0+U
 J+WeVTGv/jCjMu1It6+RpaUOnQ==
X-Google-Smtp-Source: ABdhPJy8E+dBB+B6xxH6g4XYaRfMTQDSSVQjABsveDzD7SE5UnKrgiryvqCCTdscifAd58+mzrbIdQ==
X-Received: by 2002:a62:8f45:: with SMTP id n66mr21589233pfd.276.1591056623457; 
 Mon, 01 Jun 2020 17:10:23 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id z140sm502984pfc.135.2020.06.01.17.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 17:10:22 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] exec/cpu-common: Move MUSB specific typedefs to
 'hw/usb/hcd-musb.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200601141536.15192-1-f4bug@amsat.org>
 <20200601141536.15192-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ee8fffed-cbd0-53e2-2e94-c4c9555e81a9@linaro.org>
Date: Mon, 1 Jun 2020 17:10:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601141536.15192-4-f4bug@amsat.org>
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 7:15 AM, Philippe Mathieu-Daudé wrote:
> The CPUReadMemoryFunc/CPUWriteMemoryFunc typedefs are legacy
> remnant from before the conversion to MemoryRegions.
> Since they are now only used in tusb6010.c and hcd-musb.c,
> move them to "hw/usb/musb.h" and rename them appropriately.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/exec/cpu-common.h | 3 ---
>  include/hw/usb/hcd-musb.h | 9 +++++----
>  hw/usb/hcd-musb.c         | 4 ++--
>  3 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~




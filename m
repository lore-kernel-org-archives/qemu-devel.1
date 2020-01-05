Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B05DC33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 21:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0522072C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 21:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b7vDyQtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0522072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioD92-0004wC-45
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 16:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ioD8O-0004WS-B0
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 16:08:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ioD8N-0004sl-4x
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 16:08:28 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38394)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ioD8M-0004s9-Tm
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 16:08:27 -0500
Received: by mail-pl1-x641.google.com with SMTP id f20so21069039plj.5
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 13:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rwQRorD+10OIlfDpA7r+Inc4JLz1Z+ZaatRp+32GDgU=;
 b=b7vDyQtZppjmugD+YneZxjLKV8Nie5ahPwggmuuLXWrzMtxogg1oXkbzn+0qtIdtX4
 E1ZJgRKjnwRnyinDRe/w9veu2V7hsRgryS336jJNymlGv45ZAArkIZ91fJsYmXEKrHDI
 dK6TMWjJ4XTM83Aua8jrpmMaqNy5FwO6cboJbQOTQ/gIMWPyLciu6wiLlSXsZCxMwIw+
 FnbC/Ddd5Mb2gSIOeGHPgF2v9XQ1c315O88+eUgqKHkWXqIy1MGio9Mv+V0HjSyJ/yc4
 gQHI3WuXSPwD5g9EnxSgs/lM+rmvJ8Ry27J9FAnz7BT+ls5u3tyd59Pd07iUSKUcGdqj
 BSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rwQRorD+10OIlfDpA7r+Inc4JLz1Z+ZaatRp+32GDgU=;
 b=c/3ldyC4lfZVyxXRLHdmzZY1RfPOUE2zP6JGsWxKX+PWjru66gGquj9kPNiq7EJELR
 fWL+nuSvBHw3lOi+G8vJwYXO6M8nylf8vruA+9S374Vb8E9ZVwYKWi+bu2Pfp80zb9zU
 LGPZ2lZuy6rPpvSV54Fd4cTZUPJjtbD5lLH+dH4aFV+ueNlHCHIS0Hl0Wyrcz7UkhwOT
 TcGZThuNUpBxs9dP//4uNLr0GaQcx41jBwOJdNeSIjEli7i/2Zpgd/PvijJvnKOuEPrl
 cnTod8/+EosV7XsvI+kiCuSDQt6bPVa8Bv4sDMeTnMEICoiKPxuThhdgjGG1uUHMjfFh
 7VGg==
X-Gm-Message-State: APjAAAVApxhJY6iFkgGLSNCrWRUjCaxyff4NDqQIsM4/nhSAuWeDQg8w
 18vQ22puSP+NVki1mSaK5LZRBQ==
X-Google-Smtp-Source: APXvYqySYZDrjmkRBxa9Dk70VOEDHNlNOnRdgcZFSSHaGuQpRRSH8zr7pwu3/V6ffjAk43B0Kxfv1w==
X-Received: by 2002:a17:902:b186:: with SMTP id
 s6mr104393488plr.333.1578258505456; 
 Sun, 05 Jan 2020 13:08:25 -0800 (PST)
Received: from ?IPv6:2001:44b8:2176:c800:f1c3:9f9c:2e9f:1ebd?
 (2001-44b8-2176-c800-f1c3-9f9c-2e9f-1ebd.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:f1c3:9f9c:2e9f:1ebd])
 by smtp.gmail.com with ESMTPSA id u3sm71735930pga.72.2020.01.05.13.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jan 2020 13:08:24 -0800 (PST)
Subject: Re: [PATCH] plugins/core: add missing break in cb_to_tcg_flags
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
References: <20200105072940.32204-1-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <09f8a30f-c786-f281-3489-c90378cbc5c1@linaro.org>
Date: Mon, 6 Jan 2020 07:08:08 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200105072940.32204-1-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Robert Henry <robhenry@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/5/20 5:29 PM, Emilio G. Cota wrote:
> Reported-by: Robert Henry <robhenry@microsoft.com>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  plugins/core.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F86C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A307206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 18:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjNkrhUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A307206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Zwy-0001Kd-Ie
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 13:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53519)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZwG-0000oA-BE
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZwF-0006na-9z
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:07:12 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33569)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZwF-0006m2-3i
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 13:07:11 -0500
Received: by mail-oi1-x243.google.com with SMTP id q81so13699251oig.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 10:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6YuhnM4N+bP39zc1A+7seitOZi7dhgpYfAausQXuDo8=;
 b=BjNkrhULGSPjZw775xDjFUa4GS9wznNMUYYn4c+2Yi9N2tqPBVaVfceLgxrYfDZj7L
 uRVOQStb/gV0bc7wDGXFCqHl56y0mh3ZUAtfiiS63WtRBqGMJYzPD27YH9x13IsuGekT
 cPgh0gV5kAODbh+4v/Q2TjGlHWT4c4WY/SCZut5YT9BJCIWZoBjncfKypzNWphrkfZ2b
 HsafWqkVfZcIGetL5KFYSxq5bDBKE4SiFOxoCaZwPrWJEAyi4EES2Na1v6cSkaiMTKDI
 W3qAHZnZCuSEZc2euHs3WUscPsnfVaLGw1UNVjCH70JgR90PsETxLIq9c/Wf027LWCIu
 SMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6YuhnM4N+bP39zc1A+7seitOZi7dhgpYfAausQXuDo8=;
 b=ZerCRZZMoBBlionaDZMdgxhdMDCL4/TuiCVyASEwTY87JK+6muSf4WzcAWbNT8sCZv
 wkoVAtLAl3p4WLEnDUR6U39qiWkYma+le0GTo3zMKlqBEqz4GZFA/wX34f/Y+FZ0+op6
 izrVHtYWZY8DcG02L1xMJoUS+UH2CQ9pGUqRl7Q9EXag8HqDw2dBDTCRy5Jl/K0ol9z8
 o5AJhnitq3ZJROMrdIHD6jasOgUuPsiOGPGmtVBzTrOl5OHmxntdpVl6s66dyupu8XSa
 PkzdSOuYy5N3ObOcocCI21DJ9EFhC4CczM4XM3LusJpoXqvq1LusNK5G11BpnJfetF+b
 irag==
X-Gm-Message-State: APjAAAXWAroyJxu8hYYk+Lq4lXmsCKjcMz4uWhC+fVAVApMbjufbDdBn
 lVPZ0nXTYlkSevzqmlVAp4QuSlOoKM3wfY8fpWSN8g==
X-Google-Smtp-Source: APXvYqwaHbv5ET9BSpOw9eo4RdrIpDpzFm2DSwAhKEgJsYJTrCgo9gdniaoa9XDxr/40G2a7t/HU5IgHqHQQF5wEB70=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr3550391oie.146.1581444430140; 
 Tue, 11 Feb 2020 10:07:10 -0800 (PST)
MIME-Version: 1.0
References: <20200208125816.14954-1-richard.henderson@linaro.org>
 <20200208125816.14954-6-richard.henderson@linaro.org>
In-Reply-To: <20200208125816.14954-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Feb 2020 18:06:59 +0000
Message-ID: <CAFEAcA9o4hRDwHpwP+q_Qz6zDe1tY50aw0eM+vHjqx7edsDB4A@mail.gmail.com>
Subject: Re: [PATCH v4 05/20] target/arm: Split out aarch32_cpsr_valid_mask
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020 at 12:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Split this helper out of msr_mask in translate.c.  At the same time,
> transform the negative reductive logic to positive accumulative logic.
> It will be usable along the exception paths.
>
> While touching msr_mask, fix up formatting.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v4: Keep CPSR_J unconditionally in this patch.
>     Fix all formatting in msr_mask.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E882ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:53:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67C320873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 15:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrbIAOFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67C320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMZzl-0004nC-TZ
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 11:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMZz1-0004Np-6C
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMZyz-00079q-VO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:52:34 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:44602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMZyz-00079Q-Nr
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 11:52:33 -0400
Received: by mail-pl1-x641.google.com with SMTP id q15so6809025pll.11
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZMB/mHRa6PG84KARd7SoApJywyhfh9wQqKiyFaeoWVs=;
 b=JrbIAOFi/3FdUH9xLVE/qgf46WGciicOc2U+crk3ER4eGtYH9tG5J+OQ/clrCelAHf
 2Iret7ZeNWiaZj9d11yH1VlSbB5QZevKepBy68I0RyyYfowHnonna+VOE/wSZvD3+HK8
 gD2Yp/qbSpHOZ/Tfy49qnhCm0zo1ylQaoN/AMn+2uSd2INfTFcA/CAh7NXSoo/jtHJyQ
 3jrtZ74nfqPI+meEfYgCO1Ts7yYZmwu2RWy1kq423DjbV1012lgXNxeYHvR8m4bhdoHv
 JlLds3DWXR9xvD7UqjqakgO0/OG0vRn7GBWG3xHRaHGsC27RHMSkVvcvcvUvJPi+V2zb
 Pd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZMB/mHRa6PG84KARd7SoApJywyhfh9wQqKiyFaeoWVs=;
 b=qB1wdd6tdOxw4yDWZ6ZPPIUknXExS+neMkmpZ2gHmVSulejKu8dWeJ9i3XKQX37B89
 3+fnhdj0kdAHZyxVV+4SoEuEVwYIU8mFeK+MdUgRXMP8XCP30yy7xaxbfAunIGvxCO2P
 H67zOgCuQDK0pBuubc17qPcE9DI1M4AWdH3YuM77I2JJqZWT4pjV5cjANssp3Ds8xxF/
 Ot2DyW9/6Zcp/zYVs7hRRtrJGLR9ltHS9SQVXZwR2uCv4zFK+9YhiFdbOIdUu5lpnuQK
 wb98qjeVxNHDk0Q7OGVKAuvyRb6xmpiOjRYnjogMtTshWTyKXJ19cRveT5UqCfKzpIXw
 qgMQ==
X-Gm-Message-State: APjAAAW3nc3pJW6JkO86I7U6gZ567egEW11HA2so5q9+F9WJmFD+5xoo
 MnigLp5wn/GK2Ey6hu5vumlYsg==
X-Google-Smtp-Source: APXvYqz32E8K1aAou0rVBUwc8gD8lelO9tVaZ0Wjn+IwOBA/ANj5KFfdvWoW441UhAjWm+PRmaELKA==
X-Received: by 2002:a17:902:b412:: with SMTP id
 x18mr20441329plr.236.1571673152283; 
 Mon, 21 Oct 2019 08:52:32 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z23sm13533708pgu.16.2019.10.21.08.52.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 08:52:31 -0700 (PDT)
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191021145839.12684-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <06e15851-0b4e-63c3-001d-dd7ea5855872@linaro.org>
Date: Mon, 21 Oct 2019 08:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021145839.12684-1-peter.maydell@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Claudio Fontana <claudio.fontana@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 7:58 AM, Peter Maydell wrote:
> Since 2008 the tcg/LICENSE file has not changed: it claims that
> everything under tcg/ is BSD-licensed.
> 
> This is not true and hasn't been true for years: in 2013 we
> accepted the tcg/aarch64 target code under a GPLv2-or-later
> license statement. We don't really consider the tcg
> subdirectory to be a distinct part of QEMU anyway.
> 
> Remove the LICENSE file, since claiming false information
> about the license of the code is confusing, and update
> the main project LICENSE file also to be clearer about
> the license used by TCG.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This patch takes the simple approach of just documenting
> the de-facto current reality; does anybody want to argue
> for something else? Other possibilities I guess would be
> specifically documenting tcg/aarch64 as an accidental
> exception to the general licensing rule for tcg/, or even
> trying to get it relicensed.
> 
> Does having tcg/ be BSD-licensed gain the project anything?
> From my point of view I don't really see it as a cleanly
> separable module of code -- it's quite tightly integrated
> with the rest of QEMU, including code in accel/tcg which
> is variously GPL or LGPL.

I think this is the best solution.  I've never been convinced that TCG can
usefully be extracted and reused for something else.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


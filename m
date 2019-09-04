Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F07C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 10:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3383222CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 10:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oWaOIckJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3383222CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55737 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5SUZ-0004Rd-DG
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 06:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5STK-0003t2-L8
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 06:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5STJ-0001Gv-0l
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 06:25:06 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:46411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5STI-0001GD-HR
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 06:25:04 -0400
Received: by mail-ot1-x32b.google.com with SMTP id z17so20014064otk.13
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 03:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9w+AsOkz3r4hn6ehf7Do8hIiqcYEcP1/45LVHTd5Jy0=;
 b=oWaOIckJEEYqBBrBIQLXf4loDBSSAZLsX0JjIzJ7wv7GZNCvXCJIL/4TCt3JwkfRJg
 8n5dtPIzDB4/Hgcr7d23/F7sMoGxslMnZXBdlG8zeUakJq7+XwwYCTvoRV/XSq2tF+7T
 0+UiUNlvlDOsOLrES+sDGWIUJ0g6zXimCoYVdbmEFyVcrhEuMcLXj3Oh0XmfLGvEHThH
 S+/3/81VgAVmgWyZa0RepQ6ncn5SMZpzFROQlDyi6+xSkYsPSmaTma/S1cbKYNiAchdV
 Qd0wsr441b0X8gVUJY2uAfhtji9psOcHTlcxh9N2l57G86NMxgMqd/HZyUUfKBqRhKw0
 FiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9w+AsOkz3r4hn6ehf7Do8hIiqcYEcP1/45LVHTd5Jy0=;
 b=QWCVtHZ7M62xRxCLyL5X3RI0ppNjy06rvFVSQXAl7JVyUdjq9UXo6oJW+pLbtfSIHS
 Sheu0vN+HEjZsBV5wKN8WZGYAZbfcNrnIBOdE6mWPqS4znNt4/F36rJGgKJFM94EWO9k
 D1Zi1aNNoXvdcDo/1ntjtnDN76FcqMP3nhkofmq3NLndCYuS5X+WzRZS4TSUJ0Cppwzg
 prCw8WFgF7f+5Ts4PKDlpXo/b32SXKYewxrYqU/MZC8Xk+DY3yTe9v31BjzeADZpPYp/
 wxyLAfeh7uZlFg+0JsnsKTcOZKeVGz120sHnOyf2qDQdhYD1R8X40tUmU1kkMp9LLigQ
 FHhw==
X-Gm-Message-State: APjAAAUERCjVJrxGhyc2Yy/0BKC2kLlz5FTNcikICI9bnPff7M5U8Xvp
 9dGD/MBingB2x5B92oDBTMPizPu+8KRwD3uu8rVgRA==
X-Google-Smtp-Source: APXvYqzSGOE95qSgXuegAcs9KVpynqQ3NlNhZ+amRRCsoHEdp0hqK5DPozgFy0W6aorJpZn0trgtXwQ31I8mkmAIUDA=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr14468315otk.221.1567592703368; 
 Wed, 04 Sep 2019 03:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1567074313-22998-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 11:24:52 +0100
Message-ID: <CAFEAcA9ZB59+kwo-w1an=mHTLAPFH4emVNzi=5gvEfeMFr270w@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PULL 00/31] MIPS queue for August 29th, 2019
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Aug 2019 at 11:25, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 1b142da5f82a8fcdc7783a418592de654d5c6052:
>
>   target/mips: Clean up handling of CP0 register 0 (2019-08-29 11:50:18 +0200)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-aug-29-2019
>
> for you to fetch changes up to abd4393d769d9fe2333b2e83e00f911a78475943:
>
>   target/mips: Fix emulation of ST.W in system mode (2019-08-29 12:11:14 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for August 29th, 2019
>
> Highlights:
>
>   - cleanup of handling of configuration register CP0
>   - fix for ST.W emulation (in system mode only)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


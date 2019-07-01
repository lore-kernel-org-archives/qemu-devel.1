Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AC8C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CEA216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSwtwocO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CEA216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8Q4-0007RW-8g
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55948)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4Nc-0005GN-HF
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4NZ-0000aa-2F
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:02:30 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4NY-0000Tm-K7
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:02:28 -0400
Received: by mail-oi1-f193.google.com with SMTP id v186so11284413oie.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UOKX3CNpHJ3zybgDKn68WrkRADlqvmSpAEztOenFeiE=;
 b=aSwtwocOUHAVpX1uHLrKZfxw6ISWOM1GAr31YOaj30YIA4tcPtRFhBKrVXsYkwPQOS
 zRBKuouoOVtfdfGq8ZXf4bhtKKRwwFiVmq4BN+V0YaTm+yeWWTvZI7Iaoyq7jQbRsD6o
 k2My/O9NUsI72yaJ6r7KW5XQZwcSi70d1ACwcnuFVBgYtdW4itdu32vYCb+xGnp2qIxw
 Hf+6i80zYFkDi/9k2gsLiBvCxdni/7AzTz7pxFmLXdTjidv6kGIKlT3p4U9uHwtMUNva
 0m1djXYAzLtvG3jNYU2L5CVIfXJhAlRQ1AnZLUiIeKdA40r2Mxu5gMAdeDqm8umFiK8B
 BafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UOKX3CNpHJ3zybgDKn68WrkRADlqvmSpAEztOenFeiE=;
 b=g3J8Fn6mH454IGHQ1GqQPOk7lTKGMob4ZtGECgUweSqUvIAQnr3Rgu1a3cswbuf2Dg
 zlMiYGr9q5xRgblVVeknVN+n0SDGjT+4mDk8axzF+7xVrKiD9I2pW+V0hhxN4nfqdQ+Q
 WQWMExOMnyM5O1cFNpGseOD7Apz8qRaxYbeVlmBFMLGpIgUXyH+qQol9NhN+nWkKq64D
 xSmRFcTF53y+k5NKc5hfsRcmeA4cwPm7omfHTJsV1of101Fbv2VVnneJhqeXA6tnNnQ8
 UmEZEmTvTzKSNs2M5ojm0rdWcyvldhW3N48DgxdSBefNDJ23xPrJO2hC5b5EPgfnTUyw
 L5Lg==
X-Gm-Message-State: APjAAAV1FX1OsjZ6TXbfTa08tzaf4weAdQ2zV3yy17hx7JEFn3RPMt9t
 gH4pA7rhAPF33mE32tzAs2bdm9c/LilksyeaEoY0p0or8w8=
X-Google-Smtp-Source: APXvYqyCv59RS+NfsuX8oeaG03c0Pkz0/aQEeVWILkc+9fw8w1/8Pc4rKeqLw/cLAIpU2LgrM1lP9luVTGDspT6+Wng=
X-Received: by 2002:a05:6808:8c2:: with SMTP id k2mr129314oij.98.1561999222502; 
 Mon, 01 Jul 2019 09:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190626162100.24774-1-laurent@vivier.eu>
In-Reply-To: <20190626162100.24774-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 17:40:11 +0100
Message-ID: <CAFEAcA-af8rcbUeh23Z+oy9Oh2vdcqYJWwXmjqeufJi5wvdfGg@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.193
Subject: Re: [Qemu-devel] [PULL 0/3] M68k next patches
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 at 17:42, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-next-pull-request
>
> for you to fetch changes up to c6d0700f57b2c50229a27e31b9f99056a011215f:
>
>   linux-user/m68k: remove simulator syscall interface (2019-06-26 17:14:41 +0200)
>
> ----------------------------------------------------------------
> remove m68k simulator syscall interface
> Fix comments format
> Fix gdbstub
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM


Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE1BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A20206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TWrLllCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A20206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFTT-0005Yf-L1
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeFSr-0004xq-05
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:08:41 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeFSo-00023W-B4
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:08:39 -0400
Received: by mail-oi1-x241.google.com with SMTP id y85so24334749oie.11
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c04qI1ZEckpFGoTEpW2LSba8yEdJqmU99oJmXMYcy80=;
 b=TWrLllCYaguIlMjC61v/Jf/bWdSmUXv3vunUnjGhfkrqGyCMAyY8XPU01y9FjLoAGn
 iNk0y3XF//5l/iE+GbcWgaTP1+kxCwqFW83FiOkQpgfOAh0UuxQhB6Za4CGh24crk8+y
 w1hkWc//iTA1iqKP0DYW4gQ+E17L9mn/5wetPnEDibQU2z3xei34H71BX/lvqzko8Sas
 VCMLqKembktD+Tlb+yJBxLqlSM8pX+b2ijko0kmGSMrqMoMerbpjeadxvO1BYecnQiCU
 Ccden8qm8YH3nec1MH0Rt5lCrdXlesa8NRTx3IDvjSPPTCdQ7ubW0/AEnHccsC5378zI
 6Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c04qI1ZEckpFGoTEpW2LSba8yEdJqmU99oJmXMYcy80=;
 b=rFKNpJyD0yJn8NnNvlme9ZkpFGvp37SjVvIYVJRE4FOi4BETS4UYC4G1f2jcyHKyDb
 069HKj9C9x72FMHtF5zsRS+bZ7IEsNXwviX5FS7AiSLq1COGv8ihoAs0vlP0VaC3JBNZ
 ulpvTcCin+jC039P/R5yAy+Nss6yY7YKpy+1UCuoOmfegI+UZ5zj5bjWPKigXHd1TmOS
 MpUIrrPdCYsKPbnrfr3GyqJ5fbBf4WrwrSPwXFyOBESZEh2RUXS0ZhAp0ai035VNp/uh
 TSOTafDVjj0uaWoTIct34sZmPPDTOwHaIOSpJK7BTwEnkvRGmVZu0y8/5U+BG/XAHn4B
 BwtA==
X-Gm-Message-State: AOAM5311jL9rtGRxMmWpkFRSYhkiMLcpBJwgXGT6ZM74IQDPKH55BzUE
 t2lyO98es4jJNPCyohzLX90SEdVzJn/BnBhArpIIrQ==
X-Google-Smtp-Source: ABdhPJw9BdLuS7B/w+a9L0nRYx4Ezl7OimnqrIAv6LgrV5CJ8/+4fivUJlKqtLAMWqOcL4i6tTf4w48vEENgzDphyck=
X-Received: by 2002:a54:469a:: with SMTP id k26mr1598194oic.163.1590660517110; 
 Thu, 28 May 2020 03:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200519194452.9009-1-richard.henderson@linaro.org>
In-Reply-To: <20200519194452.9009-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2020 11:08:25 +0100
Message-ID: <CAFEAcA8q-4o3yWX2kwS1inPiajP1yzc3NOLBjzQUubKzDNGhhw@mail.gmail.com>
Subject: Re: [PATCH 0/2] linux-user: Load a vdso for x86_64
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 May 2020 at 20:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>  Makefile                  |   4 +-
>  linux-user/elfload.c      | 203 +++++++++++++++++++++++++++++++++++++-
>  pc-bios/Makefile          |   5 +
>  pc-bios/vdso-linux-x64.S  | 115 +++++++++++++++++++++
>  pc-bios/vdso-linux-x64.ld |  81 +++++++++++++++
>  pc-bios/vdso-linux-x64.so | Bin 0 -> 7500 bytes

I'm not really a fan of binaries in source control :-(

thanks
-- PMM


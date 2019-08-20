Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC29C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:41:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2580F22CF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aDD6V3QO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2580F22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i03SE-00021h-Co
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 08:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i03RL-0001PL-3o
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i03RJ-0005hj-OB
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:40:42 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:40874)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i03RJ-0005hM-Ir
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:40:41 -0400
Received: by mail-oi1-x232.google.com with SMTP id h21so3933829oie.7
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 05:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+aZsrBTaooSJ5x8Li72tf9SAdw3HLZxWdwusM6j++l0=;
 b=aDD6V3QOq4chfFSMJTN0dgHbcGT5ex4Y9ASbb8ESuN+VUcNXG2I12Mzp+o45ag+jGA
 DMJDgkz6m5hhXvWODBqW8sljmo7Kokb3qOnxItkW91xUrJ+xN8rqZx57rkBjiUujWDKz
 K1NvLbBu1niHfDr1BOFPwPT7hkmkOSJx3VhGbZTkGU8A1DqDjvi5s3qDfgqME+Z72t5/
 xOAWFZwBO7QWhMEhImTesX41aoFv1IeK55nCFgTSAbfL1mfjrhWI4qCzSSRNlpA++8Aj
 zSRtSAfiLFcODtWCNJRfTmq1PYs6QAKVYaCBz5QPj9b1MnodfWRMBTxgXmWxFHlcBjgj
 qvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+aZsrBTaooSJ5x8Li72tf9SAdw3HLZxWdwusM6j++l0=;
 b=YA6eLPfIYu1FDV00SnGGLqU5GUsYfEnKv82Kcjs55iJVhK+Z0NaDoNY8K951MlnU1x
 /XeAnhkbhEzBIbNVq0bkWKqXgEpauu308RfgB5rlctlljFg3OHXOtdc6xBPClBNEjK42
 oHdJ822PnMyvSfSroi1Adeno8ToZivgJ81xbceW41RhAGB1N6MW98faxuSe4pTGrSX1a
 l5lulMBQ8kT38c5aQ71gf7qi/8nCXhno18YSb8RzGgqctWLiq8BkgZTGkOJD08H4SzX5
 bx/eMM+IrOxMacu4MufgEhWew1e/5OJDtJC5eHuCkwWUC9+m8Kn17w9CjLkqCB1bMPv4
 /+5g==
X-Gm-Message-State: APjAAAUwUEmPiuS0rsaAQ+qP9qZZF8C/7JcoImRfqh2sNgeVAV8UZFKN
 k0mdH/Nsv4zD9QU1OBTicbOvUmY7YjrbTkLQtgEW6Q==
X-Google-Smtp-Source: APXvYqyhUlAL1hcWXirPTaz1dVmota1hEmJY9J722gOMWyTuJ2TqHef2ihSOFeud4tNPK74mpmjt639tYrAhKo16+H4=
X-Received: by 2002:aca:50cb:: with SMTP id e194mr9325622oib.48.1566304840330; 
 Tue, 20 Aug 2019 05:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190819161723.7746-1-mreitz@redhat.com>
In-Reply-To: <20190819161723.7746-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 13:40:29 +0100
Message-ID: <CAFEAcA-qnEPEMCNs20Vx44_1VGEEEomZbiwe3VXJ7ho+vEWRwg@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
Subject: Re: [Qemu-devel] [PULL 00/17] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 17:17, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 3fbd3405d2b0604ea530fc7a1828f19da1e95ff9:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-08-17' into staging (2019-08-19 14:14:09 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-08-19
>
> for you to fetch changes up to fa27c478102a6b5d1c6b02c005607ad9404b915f:
>
>   doc: Preallocation does not require writing zeroes (2019-08-19 17:13:26 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - preallocation=falloc/full support for LUKS
> - Various minor fixes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


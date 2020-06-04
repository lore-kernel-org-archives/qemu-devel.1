Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E460EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA63D206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+RFbO1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA63D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoGC-0002ry-03
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgoFA-00021H-RG
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:41:09 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:33098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgoF9-0004Tz-OU
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:41:08 -0400
Received: by mail-oi1-x22d.google.com with SMTP id i74so4801143oib.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pbu4IL52Qvx/60GgNc5nXA1qF20KysAQnKMWID8Syag=;
 b=F+RFbO1lJHXDoYuIEtSrpHiMUR18ix1+uxznRELhFq2xewZGhHpTXIflOiK9LkbJ9Z
 BflpNUSYw5/uqYfv8ZgRT1MUlOk1C2RfraUlqj0ygnnoMfzzC4pMfmQH9ev73IpoACte
 9aaFD9u5IPlKE43xFYhFTZMSu7WSt63ANvYRxOXk0It0KvhJPBImdM93w6NqwmluMazG
 dXN7rmjj+JoeTcYUX0FfPVUKdNaoO+Jce/2B4UPkbtG9qft4uoxQnWnrwebvQ+SkMm1B
 dyMfVhRqhX2u5uK4NWhWrfYrT0cvAYcKptFPFPMl6VmRfn/erO8i5cwzJn2PT1/GGr76
 bcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pbu4IL52Qvx/60GgNc5nXA1qF20KysAQnKMWID8Syag=;
 b=BtZEqi3QNG348/pqEVARJlXm3o+HyKdc5IAoKGBHtBA4SZ/bwhgR4QBWCySHG56OLZ
 m30TgR/hA0v1EhL5sePpARxU63zhZO2oHrEEpTiHqTSuVU2m4XMA0EAQhJmg53mM3pNF
 Cm38pZKaKq93/1e2BBm9UJ+LO0FD7uQ9Biq4Wm1L/hUnOIMFOkzG92AuFJo2UCNk6FdK
 87SpSqdMdqt7W3LgweVlaNd/Uy8pWjVaL7AjjbyAA9j3HR6ZVxHl9+qdjVKl+u6GGKrl
 RyYZVnH6kmiCNF62Y5qkX/PBV2tMc1xCKJDKTNb77302c8diMd5yU1GygfyNSqNu+7uE
 igMw==
X-Gm-Message-State: AOAM533lMDu4rWdFpwIE++puW0zsxlLEEBf79pwGJ6kPz9faNJeDqjFU
 1g4fvSudcViN6ZNHyPAZD9ZyKgXEf2X/t8U2wHYeLw==
X-Google-Smtp-Source: ABdhPJz71hdqULNcG2XnhQfv2khPh4ayscsbDN1Hz1KWFgjxlBTgeD6Y6XVI2dzzZanH6N/qn1cEnaL+4y2//xDB5qI=
X-Received: by 2002:aca:5152:: with SMTP id f79mr2673140oib.146.1591270866079; 
 Thu, 04 Jun 2020 04:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200603161352.744204-1-alistair.francis@wdc.com>
In-Reply-To: <20200603161352.744204-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jun 2020 12:40:55 +0100
Message-ID: <CAFEAcA9rwhZ-UNwYc6kDX3ZTqJEQ+k=wq6hBEfdWZhz24Vt_2w@mail.gmail.com>
Subject: Re: [PULL 00/15] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22d.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 17:22, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 5cc7a54c2e91d82cb6a52e4921325c511fd90712:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200602' into staging (2020-06-02 18:16:38 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200603
>
> for you to fetch changes up to fe0fe4735e798578097758781166cc221319b93d:
>
>   riscv: Initial commit of OpenTitan machine (2020-06-03 09:11:51 -0700)
>
> ----------------------------------------------------------------
> This is a collection of RISC-V patches for 5.1.
>
> This incldues removing deprecated features and part of the OpenTitan
> support series.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


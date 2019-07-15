Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC8AC76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31BD32054F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4vyIkSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31BD32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn2dk-0003n9-Cf
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 11:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43981)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn2dS-0002ki-Ac
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn2dQ-0002UM-9m
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:11:26 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn2dQ-0002Tc-1M
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:11:24 -0400
Received: by mail-ot1-x344.google.com with SMTP id n5so17381494otk.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 08:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jA1oz0CnIFFH9xIt5PnRhMeufX8puveWqu8COvjsHCo=;
 b=R4vyIkSezVQxMUSIdsbh9Ar8bkUfVen2xIOApJ3xSiMMOpj9vexHV+77++swXwkWCw
 zInN6JHyJOheTi86ty30fH2IbYVbfa3XDghQWHFJCjs/E36588kMSU0pESphlaQ/aEZ+
 V0qeFpJpSx0Tbe7nHcvElC4s6vqb2HE0f54c18BWNLOUqlE8+DQFxKByir0OMIisI6oM
 jNW5v9pqffzFuLYdgUBT05gUVC3H/Vb2s9iSHLiFewsXsXavRqgqQ+no9oKJuYvvuMai
 BqRaVRQl3fneT2zGbUs5a2UiV/lF3xll1mlg8OVmRv+3G3m46PG+j/RYnf5fJ03ICpqa
 cOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jA1oz0CnIFFH9xIt5PnRhMeufX8puveWqu8COvjsHCo=;
 b=VNwJhM7Ub+AfX1BO0mOkhygV9xA6u5Y5NbmfDHW9OViHio/Fp2nmA+o29DpjoClzw6
 cQlY2sINj9d9wivr8lrmf/Jze7DceGT8g7uyzuECsblIMc7sm4CDCz6LYyZHEY2xYSQr
 QHQLK6/O973pFZJoA//j/MbTEcBYd1oXLpc/j6GRZEph9IRgA6ZhgHnVTgNIdjmVEYbj
 T4HuhX8Av7GkAZoOfR0PZMzvRB+PSVIhnCS4thE24nCcm+OoIsUEkDjhHM5Nl6f7qm6q
 fGh3yrVEHCdteIt8QWH//f2DTQG3zarmQLH4gDRc1Tzrc+rHcYECqVonsHgw2xlvJqSp
 FE8g==
X-Gm-Message-State: APjAAAUpMKmsniAoP2xAyMij6u9ccpM25ptGOjUGuBFi2wFPkNhTX103
 Ok30UN0yydTCb+sR+G3FLrV4YGhv6JaxqYxKpedOAQ==
X-Google-Smtp-Source: APXvYqzfMbsXYOABV/Vi4r1uvVUtWsNdAMij2znhlmM7zPm1OegLzBDUpgPTFcEdT4qWYlw9zjboUF6ssw1sl+2FbdI=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr21003288oti.91.1563203482714; 
 Mon, 15 Jul 2019 08:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190715135125.17770-1-quintela@redhat.com>
In-Reply-To: <20190715135125.17770-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 16:11:11 +0100
Message-ID: <CAFEAcA94NybRjhDhsmKjB0iT4Zw27LA_t4pqdMArGmqEvAVZRA@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 00/21] Migration pull request
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jul 2019 at 14:51, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit b9404bf592e7ba74180e1a54ed7a266ec6ee67f2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20190715' into staging (2019-07-15 12:22:07 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-request
>
> for you to fetch changes up to 40c4d4a835453452a262f32450a0449886aa19ce:
>
>   migration: always initial RAMBlock.bmap to 1 for new migration (2019-07-15 15:47:47 +0200)
>
> ----------------------------------------------------------------
> Pull request:
> - update last pull requset
> - drop multifd test: For some reason, 32bit and a packed struct are
>   giving me too much trouble.  Still investigating.
> - New fixes from upstream.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM


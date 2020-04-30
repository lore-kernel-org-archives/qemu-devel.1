Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8768AC8300C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5647020838
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dm9hOo6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5647020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU8qa-00047S-DL
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU8o5-00031I-Qa
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU8ng-0008AI-K6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:00:49 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:40323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU8ng-00087Q-1O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:00:24 -0400
Received: by mail-oi1-x232.google.com with SMTP id t199so5118774oif.7
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GAQpBHnSdfuHsWdp9pq+gZ9nRzw75HOaXMW+xo/DyFQ=;
 b=Dm9hOo6iq4M8sI06wXCVOzyXPIuJoyqOtteE5n/RMgHUYfpE4UxL+JX1hqAhMPs9gs
 FlirTxpasfq0nFCtxjE5ndOJzCl2DdMVCIYGWx6hfckx/QO1aSCYkcW1r28or9AL8XBs
 AoikxGWC8YGC4kdeBUrCoFkj3XCC1sn4fGntsRhDTqWTVbu53jUdkHxr0yQHtvIRXp2W
 /uBJ/BBZ0P0Sa5OHb+Vsq2fku5xul8bjr0ncNzK1JRbWxnp1OD8jUQq/DSmeY/ayaoyg
 bAjYCca9Mc1Jn6nYVvFbDv2Sbml3k6v0DVuSGbKmdeFgwZTT4mKneNfSXIGMejGtq/9/
 +OIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GAQpBHnSdfuHsWdp9pq+gZ9nRzw75HOaXMW+xo/DyFQ=;
 b=bOlOpwx5T+4pbBgZVN0hofBO07wqU8JYAWlmirYZBkIHLWe29yzp0UamMxXz50SlIV
 rpaehUw8Ry3bnOdEBXud1MeTHbH8xzzrK3s3QdvPHyTzsADDRgYGv3halIYBEyNEznx+
 vYOlnuao1fMHU27W8y4QtRKX1S2vAqJViS1Ksi418A0FhgZw+BjNL3pcK+vslLGhA4Ur
 fCz1lfci/6JAGLvrJgSigA6jzCu5D6/aXbunoCpHI+mlFKlP+/FIxx+DdP5VymeyPWY6
 5lEC0yFP/GUMF7jUQ6eueRKJCZ9cyFPDERuvoU4fMqbEyJ4m0HAEsSdtRREgJOVx9xAv
 VFBA==
X-Gm-Message-State: AGi0Pub0QeA4bDoV5nHI4QTHwG4+u/e2LyQBN1jX5giIAs+FIxgtg47p
 on3Cx7+ZkjBSwzRISLmDSYTRWpsvFKmBviDwFaAx1Q==
X-Google-Smtp-Source: APiQypJd7DghqTkFpLrNDkRrrDhByYOpChsgBFeDHHpnVHmKreVlFrlRKeU7gNlPIjUTyxwjQpkXxR8AhW2bi6hL/Zo=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr1515256oia.48.1588251622588; 
 Thu, 30 Apr 2020 06:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200430053104.32204-1-armbru@redhat.com>
In-Reply-To: <20200430053104.32204-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2020 14:00:11 +0100
Message-ID: <CAFEAcA9nQ4CRDHndV3qd7L5P9yzKDzmh4Kc17u_=bVRxHgmiUA@mail.gmail.com>
Subject: Re: [PULL 00/20] QAPI patches for 2020-04-30
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x232.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Apr 2020 at 06:32, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 648db19685b7030aa558a4ddbd3a8e53d8c9a062:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-misc-2020-04-29' into staging (2020-04-29 15:07:33 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-04-30
>
> for you to fetch changes up to 89bf68f933393a1bc0de4d07b59ffa8920da130f:
>
>   qapi: Generate simpler marshalling code when no arguments (2020-04-30 07:26:41 +0200)
>
> ----------------------------------------------------------------
> QAPI patches for 2020-04-30
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


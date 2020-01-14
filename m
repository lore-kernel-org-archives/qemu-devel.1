Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8807BC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53BAA2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urj9jvaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BAA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irPHb-0003SY-Fk
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 11:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1irPGs-00031J-IS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1irPGr-0005YL-3T
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:42:26 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:39579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1irPGq-0005XB-Su
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:42:25 -0500
Received: by mail-oi1-x233.google.com with SMTP id a67so12431090oib.6
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 08:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J4vRYlVEcRGovgB5LsfAsx/bT6hwd3oLwR/GwmrNpVc=;
 b=urj9jvaHRaHBL0FmMkYpMz2FJhnQnCl4UxtO0eCoeJLQx0CtSfPOdODdaWbR4d8OVx
 t4zKai2gKRfqIlcssHQcddmcADMBqB3slxqqtzKkv8fidX+J2AhMrGvuPBFZo6Dyg7tb
 1TDBOzj/xC45I7BxdAl+gJp/rp37uvN4wUeEE1HLpdJYznEvA4OqeoelqK8dDAL3pOlg
 NkpuBqtbYlzi3g3CIcQo+ZnBMcSTJH8zjTAuBkdjXJ91CxJMSaOlArpoLE+GfMj80dg3
 uy3ik3C4BN3K9QDOyWVpPJ26p9mbnFj85WzmT3o/NiAuP05vT4PQEW7TNo1QBanJfcAV
 HlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J4vRYlVEcRGovgB5LsfAsx/bT6hwd3oLwR/GwmrNpVc=;
 b=Vy+OHsOGwiZ9SlN5gEeHeZLHQFyKRxN5W3MiWrfBnlGjF1RX1kXjKISbyDptZpacEA
 hxuaJCgC2b28xTgkLbiUNISi3c/MBA3/fv3uulawo7LhHpRJPz1m313segSuPcqYfpqC
 V66Wpfy/N08DrMjTanIXe+mniubJ4NVOFYqeFb4rUFhY8qxp6/NTzWIWtI16ashnlD16
 5T5tZqRRB+Y10oWpppZLDWikCWjf/VOHZi3hP7aVQdsig5t0+srxVczyJs16XYEPwgc9
 bwUZ327aNbah8/isQaB8sVe8woRw38u1ooJYuyHaQ9H3mGji1oP8V88xC38V+wwHqWD6
 McHw==
X-Gm-Message-State: APjAAAVkjfrs3hwNPQjdZVllHp9eiUGOXWwccPrCSH+8NIe5oYlRh5HI
 P9ytWHAk3XjpoLw5XgBaurUfPtlfSdjS33doQ2kAng==
X-Google-Smtp-Source: APXvYqx7xSEGhLeneFjOpoZam1Ke2gtVN8GcNbb1ISPAh5EhF2tLQLucKmmcwlIIJxdwKPNcSlwcW4sC9No9zR0PZxU=
X-Received: by 2002:aca:570d:: with SMTP id l13mr16661058oib.146.1579020143870; 
 Tue, 14 Jan 2020 08:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20200114100125.31604-1-kraxel@redhat.com>
In-Reply-To: <20200114100125.31604-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jan 2020 16:42:12 +0000
Message-ID: <CAFEAcA9vBqf0tyvL+Z5-siJskjU9vT9HP7xbeH7fFYJX9n+wAg@mail.gmail.com>
Subject: Re: [PULL 0/2] Ui 20200114 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 at 10:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 3c8a6575985b1652b45bfa670b5e1907d642cfa0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200113-pull-request' into staging (2020-01-13 14:19:57 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20200114-pull-request
>
> for you to fetch changes up to c4c00922cc948bb5e879bfae60764eba1f8745f3:
>
>   display/gtk: get proper refreshrate (2020-01-14 07:26:36 +0100)
>
> ----------------------------------------------------------------
> ui: add "-display help", gtk refresh rate.
>
> ----------------------------------------------------------------
>
> Nikola Pavlica (1):
>   display/gtk: get proper refreshrate
>
> Thomas Huth (1):
>   ui: Print available display backends with '-display help'


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


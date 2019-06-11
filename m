Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4EAC06508
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D135A20866
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 16:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZgg3NPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D135A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60594 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hajSI-00043c-0J
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 12:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34302)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haiti-0006iR-7O
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haitf-0002hW-EK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:41:17 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:40999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haitd-0002Vh-MN
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:41:14 -0400
Received: by mail-oi1-x22c.google.com with SMTP id g7so6109950oia.8
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 08:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mVrdwewFvzaDIDqY9ytK3IQVz2xWVvID8ZIpN3z1MB4=;
 b=SZgg3NPRs6KyE0X0bHWCmGwX5uwnR8OfVejizaw1qv+WeJGoK5sMTTgeDtG0FhCEpA
 CjXu3gy6zsDXKUBk/v9crq1VEhBep+U6kna3q+sg4TpW4lXdY6FJDS7BKR6FNf/5zx3o
 pCnVnvbJlrrwYB7R7l+rQAF6eC+CtPJEm9rCAPrM+dmAtCeA20qjVRz/wDnACZpAPxzu
 nHllHl3HKyt08BQYVi+zOuriD9v7DzI7VK6FD1TZ91m487e3077JoaWWwP5j+76mHJ3h
 FfBnWikHz/M/We+eV9OGO6dPPJpjN0TJZIxicCnjVcTmsxndDUEHpzOLFfpPNJ07uIgE
 Caog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mVrdwewFvzaDIDqY9ytK3IQVz2xWVvID8ZIpN3z1MB4=;
 b=rsvf0DItBaNIsIsnePnPuONxyw7z3OuFWROzEmljW9QnzE2lxQACqGpbjyepZGV8wE
 GVAdI/gQ5gTXqUa0x2/S+hbbANjyaBu8lUnOsLEpP3WlFzyrQ210TIGvl9NpdR2kNiKw
 /IQtr0gY/JwiPCfyH1YPTDKB5sITYdOLs/2xmZEJwRR42Qxx02Ek6yOq7JQq5HCT3ZhK
 cg9y35WW4po8bIXdFbPggecNWhO84DRAxAkIGXwEk/ZYbJoDG2SE9MFWBn8KpKg87Bfw
 DKrpy9U6FUk1BbXDU56xLhJZNa8WiWx6qxfgt8SvMY5Xp/6ltuQmfo9z4KaNNQ77NVTj
 H5bA==
X-Gm-Message-State: APjAAAWqxsnaK8hcpfv73JdZwik0WN328svm20u/MHz3Ha0wDYnALdF1
 vicw/eVNoqwoa0+xmBmy/SuV/QxIjrOKfqigskn0pQ==
X-Google-Smtp-Source: APXvYqzpf1CZhIyQyzEH13GbibBXPksUA/i2R5m9aa8xbT4DCDydjYEabLrHPnoM2ILSranLpjRfnmmSV7mTvgquZC4=
X-Received: by 2002:aca:c786:: with SMTP id
 x128mr15348157oif.146.1560267660452; 
 Tue, 11 Jun 2019 08:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190611134224.6683-1-ehabkost@redhat.com>
In-Reply-To: <20190611134224.6683-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jun 2019 16:40:49 +0100
Message-ID: <CAFEAcA8eQAG7dKKMFk7jnGHN_4X11mrwO1+32sHNm+hbGTzSjQ@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
Subject: Re: [Qemu-devel] [PULL 0/3] x86 queue, 2019-06-11
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
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Jun 2019 at 14:42, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit a578cdfbdd8f9beff5ced52b7826ddb1669abbbf:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190610' into staging (2019-06-10 16:09:19 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 89a44a103315267122119b4311218d00d2561ebe:
>
>   i386: Save EFER for 32-bit targets (2019-06-11 10:17:47 -0300)
>
> ----------------------------------------------------------------
> x86 queue, 2019-06-11
>
> * "unavailable-features" QOM property (Eduardo Habkost)
> * Save EFER for 32-bit targets (Pavel Dovgalyuk)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM


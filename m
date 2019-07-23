Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6722DC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32EA821873
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 09:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gnID6p/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32EA821873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hprSA-0003tb-Hv
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 05:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51487)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hprRz-0003QD-S1
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hprRy-0001cn-NQ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:51:15 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hprRy-0001cO-HR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 05:51:14 -0400
Received: by mail-oi1-x243.google.com with SMTP id g7so31831786oia.8
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 02:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QtrX9Q4+VPDU9tJ5tlIMXte9GhvmQMvNfkQK9Br5RIM=;
 b=gnID6p/6rz7Oe9SCnco5IembN84TqYsYk4pWtNHtAaNIEHPQPcGSeK9ZQ8nXrfQOgw
 WuHRJgnWRdMQLoXAeA9OIDxby3YVtgkatFAugnlIgmfq/64Wz90p3hh7PqVn3cc2lsww
 JED1BXzk7a7R/UcnUS933CZ3AjzKSNbzS4/DlUvjTAetH3xMIpn5LWmkNBsD/yyupNPt
 AITwD1aqi8gwZWLHhRqNuOV6UqpTMVegggI3Vf2YRiVqgOaeI6dQAfDm2EuwtpJrtT8B
 EpNE+2YotPGSaOC+LnJHnGOVKkWOi5DTS9JDFDIbVGa5pCoGPAduV1FZQ2yRNKHEBFvG
 lP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QtrX9Q4+VPDU9tJ5tlIMXte9GhvmQMvNfkQK9Br5RIM=;
 b=JiD69wgYK7XKRcSzexvKorFQsAxeKn/FnqRYGGs6NKODXtWLSFHINaArldRys1cvY1
 Gp33f9JSSTLYjZ6rWg7MLJT9RCYiPAMOznxqlQRxLiy4X3a4T7LodDvgQbosoQsWiqTF
 2bcMouHWABbcZncFhvHvBEIxM9zVsdld2xI+k+V5nCtVHK6KpgeAvwA9MjY0DUCb8WKQ
 QNskHIwV9PSGLUr46jkncWHQOBkB9uW3AYIJEfJAE+GH+TFdJ3j9MSfExt/wvUJQzuo/
 lpbKaueEuLOEhGZRBKOuBl2eG0LVLIz+cZ20Zy6BldEbOBYEhogT2i0C4ELlVnEtZ9sE
 5D0Q==
X-Gm-Message-State: APjAAAVg32s+ziB6xFbPVQnt31QQwp2okHunbbi8Qp0hyxzXzXx7z67G
 SIkBFEkOSeOoPVBbUJB8HHN4lqDbzNTbjxl555So0smlhyI=
X-Google-Smtp-Source: APXvYqx+cJZ+jCmJL59UJxYIoC3Yafn7k7A4OTwAGCdyZopvqm5uA6P3/tsYFMsZmikZ3aaTHuARmHmadOBrGhwm/K8=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr35783551oie.48.1563875473805; 
 Tue, 23 Jul 2019 02:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190722172616.28797-1-mreitz@redhat.com>
In-Reply-To: <20190722172616.28797-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jul 2019 10:51:03 +0100
Message-ID: <CAFEAcA_W-2uUHS2Jw4=7+z5n-gnfofgC5XMR=qqh=jq5dPNZJQ@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 0/5] Block patches for 4.1.0-rc2
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

On Mon, 22 Jul 2019 at 18:26, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 23da9e297b4120ca9702cabec91599a44255fe96:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190722' into staging (2019-07-22 15:16:48 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-07-22
>
> for you to fetch changes up to 43eaaaef0e18817bf78d8f135993f8579cad2cc6:
>
>   block: Only the main loop can change AioContexts (2019-07-22 18:41:43 +0200)
>
> ----------------------------------------------------------------
> Block patches for 4.1.0-rc2:
> - NVMe block driver fixes
> - Drain/AioContext fixes
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM


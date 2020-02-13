Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FFBC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AD7217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OxpIC6Zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AD7217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2EkT-0004Ze-6A
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ejf-0003OT-Kr
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Eje-0006t1-Id
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:40:55 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:37368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Eje-0006sT-Cs
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:40:54 -0500
Received: by mail-oi1-x22a.google.com with SMTP id q84so5785575oic.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 05:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MtAGkGK4I4OJrvWcXHbfo+Gu9+IKfhkYzru3WpLH5vQ=;
 b=OxpIC6Znjo8rU6yfe6sK2CJMBR8b3YJ3WLBahuC1FpAwSIMJ2nSnpCRsUWGpfeo8Lf
 wBCGySbuQ/Y5RdRz0tw/b+ng4eJGVhU0QKDk2s612OjEJ+GrXFp5Pf5kKpcsjNbnLwXH
 N7oifTtWEN6An8CVeziv2o9LLKvETH6f4OoM2mw/BFxlqFLHFqtgN1ya8oOColEqUPjL
 n8iDH227DuTn8VjrFVF8+e2AAvDPlPsh7YKSLonFer1jKni6Iobt30BZv+tvcWSO/Tnx
 diNjoG82UvfjekINnw4oGMgz+kGiBfZk10T1wqbyVcci9x18f0YOwMOTXo6r8AfuknnF
 MgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MtAGkGK4I4OJrvWcXHbfo+Gu9+IKfhkYzru3WpLH5vQ=;
 b=CJUe3K6Hc+84rByJo7v5zAlfD5Vrya3G3jhibZt0Ym5ONVbXEiLfLk2Xb0NBR+duig
 Z450GKyPXBAi91b7w64NedxxHKj00ynkeysKCLpAiMnSwYu4rW5vDEjbL08Er9r/wNeG
 NM/rP1hc26kEDVH/fwZzl5elR3cYViZUl4vQr3LlRS3WzHQGwEE7DeV8+MxZGh8bHrkt
 rx1BUvrnNsgee5J5LdaRTUuNFOT/WEHxO9H10hs9u4SmST/WMEzqvGpfeipoPI4X1O0w
 /IwCuh0vD+sQFgqcVz1KqXzB5RVGqpmfmVFpoARaKJ31nBIlU62f35OLr+oc8A24Dn94
 Sk7g==
X-Gm-Message-State: APjAAAVkGfPq4UrjFzgoi3f1TlsCrJSnYcFu74NwGgvHLNXlDSfgi2sF
 +Of0Vqra31Pxehmm6VgluGRGI1K5Wx668wGvh2WWaQ==
X-Google-Smtp-Source: APXvYqx+DWx5rhKOFy4k2ATTegrvEiVQHMe4TLxW4YLg11/iYY8+KfoncrRHlWGGv2KmUFVmWIL96/0TSJBKczx5hjE=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr2812023oie.146.1581601253719; 
 Thu, 13 Feb 2020 05:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20200212161835.28576-1-kraxel@redhat.com>
In-Reply-To: <20200212161835.28576-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 13:40:43 +0000
Message-ID: <CAFEAcA-BuDz3Vn1b_H76y-jH4YAo7erdjANx3maBA2mWZ=MuGQ@mail.gmail.com>
Subject: Re: [PULL 00/10] Ui 20200212 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Libvirt <libvir-list@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Feb 2020 at 16:18, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e18e5501d8ac692d32657a3e1ef545b14e72b730:
>
>   Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-20200210' into staging (2020-02-10 18:09:14 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20200212-pull-request
>
> for you to fetch changes up to 483644c25b932360018d15818d8bcd8c85ba70b8:
>
>   ui/cocoa: Drop workarounds for pre-10.12 OSX (2020-02-12 13:27:08 +0100)
>
> ----------------------------------------------------------------
> gtk: refresh rate fix.
> cocoa: drop pre-10.12 support.
> ui: rework show-cursor option.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


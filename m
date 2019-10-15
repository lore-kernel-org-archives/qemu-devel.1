Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E767ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 12:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380BD2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 12:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hrcF7ioo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380BD2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKLu5-0003zz-Dz
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 08:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKLsq-0002iQ-8P
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKLsp-0005Om-3R
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:25:00 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:35063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKLso-0005ON-R0
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:24:59 -0400
Received: by mail-oi1-x22e.google.com with SMTP id x3so16611661oig.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HxATHG1/JJeV451UJPl0zTWmwQC+XBzz1bjeBFDm1w0=;
 b=hrcF7ioobNXYzvG3GXPoLNIjkYYl/bcylT8FqvKnbgM/1VZnkXwtjZt3/184RvZAHC
 PBxzNfV8vywk8xZAXXlVDMGZVBVh9Hu2746zeY0wbi0TueEXFb/OAVO1pEWsdvoa/HyS
 jyngTjJjJXW2etTkqzAkJ57XtaI5j4jAK8saH13T7wwcytg+RRNxSNenmvbcc1psgA85
 MDMQfuu+VIr2gIzkkxbmoQ2BnFbh//rz8oWUwZJ089Xj0MmWYDJJ9vht0PGCSRPaNkWu
 NjdAvKR94NtQIMKxP3GzEBEzatC0sLxWSvjlvNZ2CGhD1BFTWdFNFOHXyvDc5MoNX1Z8
 b3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HxATHG1/JJeV451UJPl0zTWmwQC+XBzz1bjeBFDm1w0=;
 b=YU737tlots8LvjTeUTom5lfOGdwlJ4BJZaUIJ34EeRA+Cpa9pVjaLeeCdd836BP5aC
 eFaHHNo28wQvnclJuMXuTDgY67lWR1zZfGUU71+gLZe7rFD37h4eDBNZXJIfUIQEMGBf
 TALyQiKgw2akHOt4kBZPRz0rgY7SV0Y0awLpuWkYoXEFxr3ffOSxY4NHwiZr57+ietzF
 PtEehVoywGBFeNHHPBru11whH9UaCvFGkQ38eQCkKU4XJ0ynRNbtiwmgX9om6pTvjqeh
 uUzq5ZKBfx9fIK/XkfvJc8WyOL7akhomkosdaJx7dRPZIFzYO1VN7XpZRI2t6nw90kOR
 xmZw==
X-Gm-Message-State: APjAAAWsqZrbKDWhliNqD469BNd6S0U8RFHx58AoLN5+4sfHxL8L7ARd
 7bHDrCSm4ilKtXVISJb8oVCErnBB1AVip9upz3Y6iA==
X-Google-Smtp-Source: APXvYqwg2ih9x+8Tm41QRFGiDfexTL0T3dOyvMmnh4Lu36Jq3xJO59qeeJFEXHedWmw2CVOtohG8enSXrylaS2Zjyew=
X-Received: by 2002:aca:49c2:: with SMTP id
 w185mr29066541oia.163.1571142297843; 
 Tue, 15 Oct 2019 05:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191014085709.26812-1-stefanha@redhat.com>
In-Reply-To: <20191014085709.26812-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2019 13:24:46 +0100
Message-ID: <CAFEAcA_tPs_hfO3GVSf2CsYTFvBH5-RWe+JsR5vfqkh5HjAVNQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: Fam Zheng <fam@euphon.net>, Qemu-block <qemu-block@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Oct 2019 at 09:57, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-10-08 16:08:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to a1f4fc951a277c49a25418cafb028ec5529707fa:
>
>   trace: avoid "is" with a literal Python 3.8 warnings (2019-10-14 09:54:46 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------
>
> Stefan Hajnoczi (2):
>   trace: add --group=all to tracing.txt
>   trace: avoid "is" with a literal Python 3.8 warnings
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


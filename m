Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0797C11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3F62467B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 19:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8aR8Go5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3F62467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Og5-0000ys-TW
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 14:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Oco-0007uH-TI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:15:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Ocn-0000qZ-9q
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:15:10 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7Ocn-0000q5-3I
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 14:15:09 -0500
Received: by mail-oi1-x241.google.com with SMTP id 2so338835oiz.5
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 11:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gn6HGIwRjGjHRRQXw8jkuOaGu5lJC1BjWCfRwccDGiM=;
 b=l8aR8Go5CGHN6lVy+ke9TLpEUz1OVREoBwAgjacYBnvY9Hoh1ajrfP181klV89gD8G
 JlVTrUXLDG4UirqBOm9/09kiuLZyTYnffGF0cepUICz+OXa7z1ofRBVncLJIgVRAYvhA
 lLGqGppvVgveTZV7nJD53CW0KZQI/bg9Mb/+t+22ePNlYFq9dCM1OHuOAfHyutg1kujp
 7iYQauNohuhcb9/A+jUaDI+8O1x6+T+//FXAYQZ33QyoSrij8xmvr11da484AzVvt73t
 oaW8QHobrX3lxm1PpUOPAlbI0pA9U3Uc8fTpWZrlJKl9Tb+Urn/NLFNE6zRCzkSkybuf
 Ee8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gn6HGIwRjGjHRRQXw8jkuOaGu5lJC1BjWCfRwccDGiM=;
 b=G4guCbYwRtfqD0DVVGNGmJO14ZAVezNU1oHeC6lt+zNAwopWLJyUn0EPn6p8SEqzZe
 xUY1KxGdYkEHzWpKQGqSXouu3qoHnQY95JtIebcpPCIJNStCVF3jnRvJudun263/IY+q
 aVQke1CoRbDzVq+IfEahwR0s+u8mqiTB+ZLZ71hosxexKuCeA54x2cryDXKIRyuXbUgp
 Cgw1D78nSPI//OcLe2GOp6bgPzCijLIOMdbzGYounqz1pIoa3GmtfQ3QI3G1CQeHq8zn
 XbbPUp1L1WTqxQbhlbUbsBY9L6fLxbxvwXvQNqw5cXZdNKE+SVJ2ceVDBtxXzPFUFR5k
 xC+A==
X-Gm-Message-State: APjAAAVxGD2Q63Gyby6ysXJ4sfvd/LanTFDJ2QlnwUFRMTG5Vcjchnwd
 ZfBwc9Lu4jl4YuIIQ9CS2UDbZP11kMmrroK0VjtfwQ==
X-Google-Smtp-Source: APXvYqz1B4IippaiFbpL/9XGpB31Mu/Ch3FOaedjsDsP9WhnAWmrU7NmTvVgeIBDU/KWhBw0Kd1Mkb8cIDu6KE1BIVo=
X-Received: by 2002:a05:6808:289:: with SMTP id z9mr433820oic.48.1582830908248; 
 Thu, 27 Feb 2020 11:15:08 -0800 (PST)
MIME-Version: 1.0
References: <20200227015448.960538-1-eblake@redhat.com>
In-Reply-To: <20200227015448.960538-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 19:14:57 +0000
Message-ID: <CAFEAcA-R+KsMYWwvFRu0tkkkFqfETfq826=qeTiRi7oSTMMK0g@mail.gmail.com>
Subject: Re: [PULL 0/4] NBD patches for 2020-02-26
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Thu, 27 Feb 2020 at 01:56, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit db736e0437aa6fd7c1b7e4599c17f9619ab6b837:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2020-02-25 13:31:16 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-02-26
>
> for you to fetch changes up to 8198cf5ef0ef98118b4176970d1cd998d93ec849:
>
>   block/nbd: fix memory leak in nbd_open() (2020-02-26 17:29:00 -0600)
>
> ----------------------------------------------------------------
> nbd patches for 2020-02-26
>
> - ensure multiple meta contexts work
> - allow leading / in export names
> - fix a failure path memory leak
>
> ----------------------------------------------------------------
> Eric Blake (2):
>       nbd: Fix regression with multiple meta contexts
>       nbd-client: Support leading / in NBD URI
>
> Pan Nengyuan (2):
>       block/nbd: extract the common cleanup code
>       block/nbd: fix memory leak in nbd_open()
>
>  block/nbd.c  | 33 ++++++++++++++++++++-------------
>  nbd/server.c | 12 ++++++++++--
>  2 files changed, 30 insertions(+), 15 deletions(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


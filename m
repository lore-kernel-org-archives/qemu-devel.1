Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4DDECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DDC2133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 15:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bq/72Uqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DDC2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1ze-00016o-NP
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 11:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK1yt-0000bv-Gt
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK1ys-0001xO-2o
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:09:55 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:34692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK1yr-0001xB-To
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 11:09:54 -0400
Received: by mail-ot1-x334.google.com with SMTP id m19so14105939otp.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9oYzgHekzk9qCymt7fHW69btA1putZ30A5v64sw7n6Y=;
 b=bq/72Uqp1lP7dLH8iUjjlm8MKeH0F8xS4Uf0PJ4Ai+dh6xuEDs3n/jRPqPFVrB/8sT
 QqssrQ2D5TcawJZ9bb0wl8aDUnGYuQ0d3thtkfQsJgvXqe7WLiiJL9zDPL4XutibnbOU
 PjbAhL/CjujdnQ0aCc/m92VKcJC3VE3WVffdETnczitoUEPlXarsugr0YqLXtB4DfF18
 zauh0I1nO7k2VWjxc2Dd7uyQRVAZJUwchMheqjII7ZK89sK79WE2/MRPnvqB6gbjrtlL
 c3/Qrkl5ZFVAzLx890Gxw3hlJk6CmKxGZfYBDrSZHel4arDEReK6B+VErnRkxlHoaZfp
 o9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9oYzgHekzk9qCymt7fHW69btA1putZ30A5v64sw7n6Y=;
 b=DgPCJyx0f4v2D1Sca1/+7HPlZ0pUPVWGbAiE2JhzIxf42H52BwcRPhCV5k280ug9yT
 KRIR8o8sHgm9u9lBruNAe6nBBkFSLw0P+dF9eIoTUBmRfQifbZqSlvtqayAYPO5ndSp/
 kmODb8SQvCP6ByuQBugXHJwKrtxD5gfDJ1LzZwDCNG5pAeoO0jbKziybPAj/QtPQG2KF
 uU3eXjZ+Soait+h92cEsJr6cR8lk29qP7WX8qLHnu64ZD8Bl2DzUQi3ZQLS75T1GWrGN
 7ic2uoGsOftm0aUsTWmMedU+BAmuoc1q1FmmiY3vgbW0YgfrLcFHEqvh2GsUNAIRiqet
 8o8g==
X-Gm-Message-State: APjAAAU3KtoyjZOdEjUeOoIOIgDZ9R39AECJ0xB90bRwajImuM9t90qR
 xsrDQbpNs812qg8ltNA9ERKl8IZabX3csWEw+6dMkQ==
X-Google-Smtp-Source: APXvYqy/H0xqj8pdHCoiZruc+5LTYSV1NISaJ0TxbDKwktSuQTm5T+tvC62AIdgy99s5gGz/0RD3PSv1dFbxmfrxXXM=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr25132732otg.91.1571065792844; 
 Mon, 14 Oct 2019 08:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <157073476983.23153.13333563650903948665.stgit@gimli.home>
In-Reply-To: <157073476983.23153.13333563650903948665.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 16:09:40 +0100
Message-ID: <CAFEAcA-u0zK1p4t0N7uj39q7KAYTYZt88K_-egsDjBJfX9RxeA@mail.gmail.com>
Subject: Re: [PULL 0/1] vfio update 2019-10-10
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::334
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

On Thu, 10 Oct 2019 at 20:15, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> The following changes since commit 98b2e3c9ab3abfe476a2b02f8f51813edb90e72d:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into
> staging (2019-10-08 16:08:35 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20191010.0
>
> for you to fetch changes up to d964d3b5abb5242591a088dacb1dc01e608b5158:
>
>   hw/vfio/pci: fix double free in vfio_msi_disable (2019-10-10 11:07:28 -0600)
>
> ----------------------------------------------------------------
> VFIO update 2019-10-10
>
>  - Fix MSI error path double free (Evgeny Yakovlev)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


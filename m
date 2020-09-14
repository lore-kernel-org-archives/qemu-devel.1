Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D95C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1D0208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ln35/Bxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1D0208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmPh-0006Mn-6W
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHmPA-0005ux-J5
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:12:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:35429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHmP8-0006WK-9Z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:12:16 -0400
Received: by mail-ej1-x62f.google.com with SMTP id u21so22644230eja.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HCtdB/VftZjcE7mFOeKNH6NZdTsCkzELYqoanYD6IZI=;
 b=Ln35/BxipurAhPcxwVfdO7zmqwUn//YehjQoHmog3dkTnKpmm6oUGPKb9NT1iQg1q2
 H4PnBwvo8438TyRerXD81TUnhASgH/9moMf0I40J/y1kCsMaGQoMFBr72w+P2mkoTC6R
 qmPtMIyj9RAE51LPkT9E3sS7ft9Q2qb7EqYyaYFa/EIvIHqNB8gBxAwbZQXaFx/XHRLw
 7KurpJeeNV2vERHLL4CYkAs5Cccjgq8QGqWmg3RfcIxcqGacHPOyzFUPVLUKBcWdYv1o
 0xLu6zdY4GT2ofBhMCrjcSJfAwkr6EICW9AXDd+mcxi25GOQxjCAjhSbrg6tuPKN/dKl
 fTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HCtdB/VftZjcE7mFOeKNH6NZdTsCkzELYqoanYD6IZI=;
 b=FY/bjlCwUOaabuTiD1jia00efEFh3g/fPFne2hagQU6O1BUu4Ri+2qGXDkgaBp1FXj
 Y5sTJ0iVQlOecUhTAS+TCES84/D85JGYBi6pQXPzbeWnpsuhUrO1/dx/rjkSzps17LB4
 BXBXeJKQVVICVYeeB22P7ZFQlrJp3R/z8lrnDUw5A+tcdpi85Otm2ArUCVh/tPdcTvzk
 hUqs9yv3QL8UqwSm9ajolrXGw0rmjik/2Fz6PrcOdUtvfpi44hJWrpDFz48lq63AfM4Z
 xuH9Sj+a35AzTiamd0fLh+nYrPlSUPi1TI/WJ5AZSGo2QSp/Hdiy7YN6yzWTCeBHKxMZ
 gWLw==
X-Gm-Message-State: AOAM5314/cjCmKwAOzkozAR+0Ku1h7iOBCLiP46v7mR8CRl1uteHxXwS
 /raXdlwvHEC/0VfLMpapgWIYuPPSRayL6w9Akq1yfA==
X-Google-Smtp-Source: ABdhPJyl25ISe/rHkxkHYcWLowyGECZ0qHHBizXJWvZxeVXaVLW9J1IRE/cuv9+Q/wATKXaKQqOnT+5EhqZfCWVvmFE=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr13737068ejb.85.1600081932844; 
 Mon, 14 Sep 2020 04:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20200914015902.25769-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 12:12:01 +0100
Message-ID: <CAFEAcA_3P=9kGwtxLh__3fUhmVcH-KJsB1_EqrFEZJnUK96Wtw@mail.gmail.com>
Subject: Re: [PULL 0/4] qemu-ga patch queue
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 02:59, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
>
> The following changes since commit c47edb8dda0660180f86df4defae2a1f60e345db:
>
>   Merge remote-tracking branch 'remotes/berrange-gitlab/tags/crypt-perf-pull-request' into staging (2020-09-12 21:17:22 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2020-09-12-tag
>
> for you to fetch changes up to 2e4211cee49a666bf0e333011689b0981025879e:
>
>   qga: add command guest-get-devices for reporting VirtIO devices (2020-09-12 20:37:48 -0500)
>
> ----------------------------------------------------------------
> patch queue for qemu-ga
>
> * add guest-get-devices for reporting virtio devices (w32-only)
> * extend guest-get-fsinfo to support non-PCI virtio disk controllers
>
> * NOTE: qemu-ga w32 build currently broken, fixed with pending patch:
>     "meson: fix MSI rule"
>   w32 tested with patch applied.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


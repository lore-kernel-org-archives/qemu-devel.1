Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF1DC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 15:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67FAE20786
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 15:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oFJpqv7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FAE20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juHoE-0004Ok-Ls
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 11:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juHnf-0003uU-Nm
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 11:52:27 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juHnd-0006uf-UL
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 11:52:27 -0400
Received: by mail-ot1-x343.google.com with SMTP id h1so6360269otq.12
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KQxJhmS5Xfetmaqpkn13Jb3vpLilbZIBiFU9edrGha8=;
 b=oFJpqv7QEeZslyGnq2di1VTsRBnViWAVUdb0i+K+afNS9REVNjr27aNYxnIaMp9qjH
 sML0x7hIlJQzyvWAoFWycXHluGYJF/lnJS+eMhQeSHpaRNGcR6jHmT4TmV+nvjX7WER/
 cDsFuotMbI1BFDq7lt2CIGCFIxopMC8FSoRlMCYFCtJL/mBizUuKRZclpOsySV94NqV+
 B0NP07+5b0gxeeFH/mNM16dq2O0+f+Sn99emNouAHYnJD/c98I3Da41/JejB1VgiZlxW
 Xw9GCJuOr41IaMftRO2w9TUq0qHYIQlc3omVaAtAgdxoTiGIG12v5I/XqdKfHNmjnpfp
 WA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KQxJhmS5Xfetmaqpkn13Jb3vpLilbZIBiFU9edrGha8=;
 b=W6uNZAd3SXTCwogMYhlvNgF7rMG6/PuVVjNsNjCa6KdUj3HNVyuCsqAycc8+nQuoB7
 KUZ0Mb2xNEYZvrnUIq2ymIp9k/mS7yba7JSJtxTATgw3yxaERS5Uum8pu7xJbOqBnraI
 1C7CwXTKwD/V1ArkBI7IK3vZ1ST7NEjE1vbx9yOjQa7OLaKeViJAUy68hsl7tFws1pWb
 0HjpGY+ONdTYS243+oznDUVgkbjs3mxa/xmbUG9SQJYDzCSn6UsKF6OJCDLHEgLjsiSm
 u0PmdhbkzKs8QCeB2QLn27Jfvf3FeWVtTYABgxe0oOLxg7p9g8yYDiiqqkLOqIvybz2L
 l/oA==
X-Gm-Message-State: AOAM533CB+tL6li7Qm2vaqo8U2DGo++AN9YOWgOpmq0hQbDYPpd7/zhu
 pdoBIgqInPhIjYDJ1zCSUzPmzQjWPia3ZqFDvdCQBQ==
X-Google-Smtp-Source: ABdhPJxRMpVHPhFdl1flb1AcJwye+5+Imz6vHNY2AhupqnHLi2FHdq36wJEjkDdx9OPPaSumXIoZ1GrpI8xDSq2tVUk=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr54635950otk.221.1594482744365; 
 Sat, 11 Jul 2020 08:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200710163531.526224-1-groug@kaod.org>
In-Reply-To: <20200710163531.526224-1-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 Jul 2020 16:52:13 +0100
Message-ID: <CAFEAcA9ahXkwaxrw71VCMueouB1sRDr=3+Vnxi-j6ZJ5EknufQ@mail.gmail.com>
Subject: Re: [PULL 0/1] 9p fixes for 5.1 2020-07-10
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 17:35, Greg Kurz <groug@kaod.org> wrote:
>
> The following changes since commit b6d7e9b66f59ca6ebc6e9b830cd5e7bf849d31cf:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2020-07-10 09:01:28 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/gkurz/qemu.git tags/9p-fix-2020-07-10
>
> for you to fetch changes up to 353b5a91ccf2789b85967d19a8795816b8865562:
>
>   9p: null terminate fs driver options list (2020-07-10 12:48:06 +0200)
>
> ----------------------------------------------------------------
> Add missing NULL terminating element in fsdev option lists. Never
> crashed QEMU by pure luck.
>
> ----------------------------------------------------------------
> Prasad J Pandit (1):
>       9p: null terminate fs driver options list
>
>  fsdev/qemu-fsdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> --


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


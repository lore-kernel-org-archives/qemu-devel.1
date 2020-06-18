Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D30C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EDC12070A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c44xuYMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDC12070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwqw-0003Lx-Bn
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlwpk-0001lT-3X
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:52:08 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlwpi-0002tl-8i
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:52:07 -0400
Received: by mail-ot1-x343.google.com with SMTP id v13so4911564otp.4
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=alwHMRezmE5H7JKw2LPCRm8OIUKyVuXWrKWRu3+F4rY=;
 b=c44xuYMGQhCA2dCElAG5nB4alqDiq71ia6EpsbX+FGrmExBKTKsEfvKXQTp8K/WVIG
 OAizHhshIxGQSL7YQuWvir6GPmWRRXGNPch+PnG4NJ/nr9IR6xz0zksZwgcOslH915K4
 524x+koW7b4R6QxiruKTsA5ft+nMasqMQTlOh/TnmvPV1LPYMsvgUkMEY7nVx4g3w74h
 /ArT4H4WfTfbKa7q4wPEuum7rF4fxCdaIWIuErYqu3WUptbIFYG+j6Qd46usn05qbtW2
 y6BHXJ/7Xh4XOg47G/RZ4g4UophsNNFiAGls9zcopeQvTpGEh5HFvgkn66kwndSPdN9s
 xJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=alwHMRezmE5H7JKw2LPCRm8OIUKyVuXWrKWRu3+F4rY=;
 b=btIbJuMFuffW3VzgXdM/+GPpzQwzVuWvyL7kS8jg93RUJt+yX44Jcx8tDbh2PQ83MU
 /TtYWx0XgpB8NhBHcsFnRpdMZp0UKWEWdrTJ7k/LYFuJvpRRQQD0REEo5l72mosF0muD
 fHuRr9TEseISkBy9Yrp7GMbxxxWMaY/fImOVbEFWuFf4M/xvSjHAjTL5FDBVuJM3CYrj
 1xeJzi8yTQkMRBcW6plkckvXEqU90XLKarieAd1SOZUbPSBCcwC0dCy53JdxOTu9D0T3
 wu/u+OJMrNqykTLdxcWacMQEV03C2RO3Ju/aveIMIBLeDPRYQite/9LLjrhXaw0K4j4L
 GrrA==
X-Gm-Message-State: AOAM533PYZBsW36YuJSoECaf03UoLJXDuJPBtPMcxMyqmmtGtkS3LiN8
 6dBKPcDQrDC6FMz2gfypgfUMCuMwBCGzGdzOZigegA==
X-Google-Smtp-Source: ABdhPJx7+6vsrjusctGG2K7TSTil/iitQ86YARVGnAapaetiTPSr84qB/TCI3Bt2DR0COrFu1sbFj2gcOB216Zh1YEs=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr4176149ote.135.1592495524768; 
 Thu, 18 Jun 2020 08:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200617183733.186168-1-dgilbert@redhat.com>
In-Reply-To: <20200617183733.186168-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 16:51:53 +0100
Message-ID: <CAFEAcA9dNxBH89o77tfZwC7NrzB+GkQwSikPpVZV3uF2PCFOFA@mail.gmail.com>
Subject: Re: [PULL 00/12] migration, HMP and virtiofs queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Mao Zhongyi <maozhongyi@cmss.chinamobile.com>,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 at 19:38, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 26bf4a29213b432eb390726c698a1915550a9cf9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200617-pull-request' into staging (2020-06-17 16:24:24 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20200617a
>
> for you to fetch changes up to 7e89a1401a9674c9882948f05f4d17ea7be1c4eb:
>
>   migration: fix multifd_send_pages() next channel (2020-06-17 17:48:39 +0100)
>
> ----------------------------------------------------------------
> Migration (and HMP and virtiofs) pull 2020-06-17
>
> Migration:
>    HMP/migration and test changes from Mao Zhongyi
>    multifd fix from Laurent Vivier
> HMP
>    qom-set partial reversion/change from David Hildenbrand
>       now you need -j to pass json format, but it's regained the
>       old 100M type format.
>   Memory leak fix from Pan Nengyuan
>
> Virtiofs
>   fchmod seccomp fix from Max Reitz
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA663C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:54:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888F22173E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 21:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UssqEOL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888F22173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3nqG-0005ve-MV
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 17:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k3npP-0005K8-4j
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:53:35 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:40478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k3npN-0000ha-8t
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 17:53:34 -0400
Received: by mail-il1-x143.google.com with SMTP id x1so119911ilp.7
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 14:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p//KkcnVGkvxP2VOVxHag28aTalCuqvo5yfPSi6fTFw=;
 b=UssqEOL5/ptj9pmzWJblmjGh5BIXzouXN9WnHpmMaIzfi+JZXc/LMC7LfaaRlpBElI
 80rbKx+ixq71QRisLhiJ8iVMiY0WJYPuUSc4uBaYOki1WAevRZA6n2o3/qs7uz+GEapt
 UQOnqVOarh58oET47SERepwpJVN45q+X6kreS4tlkx5MO7TRVs8tRo7K+9JbLsPePwBo
 JVj9PfvelATvc0mqcne07kW9K+PaY9tenlmtCrZtk4f1MivCdHT02sF52N0T9hB2w3ni
 xbk9N9elhYVqAfTM8TBxitqnbQ7M2sukKpAuGNz0kTdEA2dx+K39SwJ6av2yN8AuYLAd
 lhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p//KkcnVGkvxP2VOVxHag28aTalCuqvo5yfPSi6fTFw=;
 b=AL1S/NzNaPcDqB9y4a8RyfdAKNhlEr+YeGxwwFaEnDGoFQz/IP9AnzovrUmOmvLLkM
 KGl7baArU2cC/nGSN3k0hiW2J+6kSB/8UujArpSfCT6dToP16DgazL3B4YQWrQAx2uS3
 nfNjy3VSsl7F4hKq1SaTqpBtpFL3KV5HUiCftofJoglyRAu4J1tzUpGkJLvwEnQaplkC
 HbuTjHqCc6rgVNCgE06eRxK5UJ+CSXD74rwm+9Zvc0xpzKbQuB1J6fUCOCdueTKU7Tfd
 QFVDBESdIXaCveg2Cjld12HtCg7NZ9/e5hZMOpJfJqA0fLimJWz27dEoP51q2ny+jMlT
 Zgew==
X-Gm-Message-State: AOAM531XbOrgvD9RvCLEZ4p0lxKfjKUyGawLhRHLrcdaQWXbCNWPnK2G
 +prZQ+o9Z4b5IvmoCr+0Nm5g+CQUy3lghPknIi8=
X-Google-Smtp-Source: ABdhPJw28PfHqCwxqzQI4tyjY2lJZt0eQoFAvErCO/94Fxtw6Nz+wbmKgC/4BTupe2aBafSLP3ib7syT0hQaZdrtgW8=
X-Received: by 2002:a92:4989:: with SMTP id k9mr1159176ilg.177.1596750811551; 
 Thu, 06 Aug 2020 14:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200805095755.16414-1-thuth@redhat.com>
In-Reply-To: <20200805095755.16414-1-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Aug 2020 17:52:57 -0400
Message-ID: <CAKmqyKP83X8R8jnoAMgwjSQX_3WKaR+PpAQyqrRQUwMucNKGzw@mail.gmail.com>
Subject: Re: [PULL 0/6] Improve gitlab-CI and fix a compiler warning
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 5, 2020 at 5:58 AM Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit fd3cd581f9dcd11286daacaa5272e721c65aece8:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200804' into staging (2020-08-04 18:20:32 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-08-05
>
> for you to fetch changes up to d2a71d7474d4649eabe554994a3fcba75244cce3:
>
>   Get rid of the libqemustub.a remainders (2020-08-05 11:45:43 +0200)
>
> (I know it's late in the 5.1 cycle, feel free to ignore this if it's
> too much for 5.1)
>
> ----------------------------------------------------------------
> * Test rx-softmmu, avr-softmmu, Centos7 and Debian on gitlab-CI
> * Fix compiler warning on 32-bit big endian systems
> * Remove remainders of libqemustub.a
> ----------------------------------------------------------------
>
> Thomas Huth (6):
>       tests/docker: Add python3-venv and netcat to the debian-amd64 container
>       tests/acceptance: Disable the rx sash and arm cubieboard replay test on Gitlab
>       gitlab-ci.yml: Add build-system-debian and build-system-centos jobs
>       gitlab-ci: Fix Avocado cache usage
>       target/riscv/vector_helper: Fix build on 32-bit big endian hosts
>       Get rid of the libqemustub.a remainders

Thanks for the RISC-V fix, I'm currently on holidays which is why I
haven't reviewed it.

Alistair

>
>  .gitlab-ci.yml                               | 109 ++++++++++++++++++++++-----
>  Makefile                                     |   2 +-
>  scripts/coverity-scan/run-coverity-scan      |   3 -
>  target/riscv/vector_helper.c                 |   4 +-
>  tests/acceptance/machine_rx_gdbsim.py        |   4 +
>  tests/acceptance/replay_kernel.py            |   1 +
>  tests/docker/dockerfiles/debian-amd64.docker |   4 +-
>  tests/test-util-sockets.c                    |   3 +-
>  8 files changed, 103 insertions(+), 27 deletions(-)
>
>


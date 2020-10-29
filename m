Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72615C55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:09:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3EA20706
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 10:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwS+i9Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3EA20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4sT-00077Q-MR
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 06:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY4mK-0001Sg-M2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:03:33 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:44463)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY4mI-0000CK-Ut
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 06:03:32 -0400
Received: by mail-ed1-x530.google.com with SMTP id w1so1280799edv.11
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 03:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=E2YCmm4hqIiNa7O/d+tl+9EEzjZMgYTXxABBb2o0uj8=;
 b=GwS+i9Tj8FuePBiht52Z6qixTIHW4I9pBuYXa7ebuYV7T5dOqOJacgWh7v8nZpu+rz
 v+hobu88QfOJkWXcmtGqS8hYuXGvddFe5cE4XNhLKOo4IanAk2KAaavpxxYb6bZaUfsc
 7w5saTQQswrhIu9OR6RmanCrwCfDZ4tPvBt6kx4yHX0PJvPRXxjmwPRvHiTIvgNNOtpf
 1jJjCG+xLlHyGawNjcCWY0ZdGlCcQggV1g+7PM/9TWnIcTjQcqOGZiOl/2SyhuqrgwKS
 FYcrrKIPgqjgvarfnN9iuzaFqdiBFv24o8wpJ1gCAxCXjmiQodtYhQ0rV6lBRVgAh0gr
 Gb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=E2YCmm4hqIiNa7O/d+tl+9EEzjZMgYTXxABBb2o0uj8=;
 b=Vu/gvtwTvApI6OUF4mAWSxq3L6VlWmTrUam3sWNlVvtRbWZ0O4rnDL6FW8roDlLX1k
 3cIMnTKQSxGT7Mjg2/tbdt0vilrNIJBNDb4orawe31wKk8fvxy5KxLiQa4XgMXRAHd81
 NnI7nmFhFtmcaNWpq66avT6Nwybh0QlovPcMtqB+xmilsnyjHxZmJ0v967hfR23SXZKK
 aQ8ApWIc5YYMAFrDvLmvnzOkWoh2Y1BEnxtpj0l7D7ssn1hFXdOEOKojRxBs/DrjTjj1
 p5JGgsXyjaK8XzTzZiZzkgI08L1Auw+oX74QxT0S5sfGkNrLJf+2oUuZHZsi9dnAKCFa
 pB2Q==
X-Gm-Message-State: AOAM5308GgoV1h/KqLW1+nUDdc65so4jS9MQ0TkL9iDQwsG3itIcM53o
 jHUNkSN1jV5ZP3xG00iU/LOSAa7x9Y4EtjLKRfH8eQ==
X-Google-Smtp-Source: ABdhPJzeH6mU/r2bkjqFbEQ7teexDjpfGuzqDj2N+i+ako99Ha+1HLetK8OGRZiBLL4KcZL1y9O2UsnTaBzZqdD1mog=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr3047688edq.146.1603965808891; 
 Thu, 29 Oct 2020 03:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201027095938.28673-1-alex.bennee@linaro.org>
In-Reply-To: <20201027095938.28673-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 10:03:17 +0000
Message-ID: <CAFEAcA90vgR2FfPE08CkDLWPg3P89Cxo3LMrSSaHz6dwCp+Z=A@mail.gmail.com>
Subject: Re: [PULL 0/8] testing and misc (gitdm, gitlab, docker, make)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 27 Oct 2020 at 09:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c06=
d5:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-202010=
26' into staging (2020-10-26 17:19:26 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-misc-271020-1
>
> for you to fetch changes up to c8e6cfba1291df2202bf406bb5137c9d365505d1:
>
>   makefile: handle -n / -k / -q correctly (2020-10-27 09:53:51 +0000)
>
> ----------------------------------------------------------------
> Testing and gitdm updates
>
>   - add some more individual contributors
>   - include SDL2 in centos images
>   - skip checkpatch check when no commits found
>   - use random port for gdb reverse debugging
>   - make gitlab use it's own mirrors to clone
>   - fix detection of make -nqp
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


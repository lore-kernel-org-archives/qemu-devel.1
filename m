Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC146C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 137DC20759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzYre/R0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 137DC20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNe25-0001Hk-1a
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNdsi-0000Oo-D2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:19:04 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNdsf-0006RQ-NY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:19:00 -0400
Received: by mail-ed1-x541.google.com with SMTP id n22so2286339edt.4
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9f8yvg4nHDtbp4k+M6DrVvog15lTAgRwMYiFIt1HueI=;
 b=QzYre/R09wOAy8rY9ggS6++AGIoiBnwSf13ocfcWBx4XRGRJdr/yl/24t19PablQ2x
 sj0kMg4M71L61eGX13eHQCxX/5O6blgDt8dXtrC7OvXroueIeEaOR5Bqm1koLJLBcp/K
 sqDubxkxevInD1GG091NA9VzQCuNFSAqzLMLklyPnmiu33PNe2yBdWqjX/pDInlB31vx
 +hWQVjy5dg+Tw99ZmvThIK5oR89VqAShayuFEbOq5ufvTATnR6hEiInw99p9mZAqc7Vc
 SDGAM8YGirkqgVjM7dfQ7Q7UuUOZhdmiNdEzB9Dm0b12UeVobC7FziQwPW2uuFjcFyzs
 WUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9f8yvg4nHDtbp4k+M6DrVvog15lTAgRwMYiFIt1HueI=;
 b=aKfLq9z8lIj6R3dUsw8mTyMdyMvEEo0KT1oK2mQwHi8Hf5H2rtnn7rMCXubp5kqW0X
 YxKzsJkIQTssbdKWI5xj6myWYSx/gc5cJ/wgV4nZP0GBkZ2ogzCI+rZ2MJ7OMvedBPD7
 a81TSW1I1y9OY8iStlHbUH9gtV1fdur9khvXWnLaJ/5UqxECZDgVUpKEfMe+TBc+Xqpm
 cgtfiOh9SjovnV8HnENKrr159uQZ8mWswFzYVIAkDXqMcljQSkKttK8HoDiATCz9r3MD
 0YZVl5txm2hmJVGdhyTHWNnMzH1aiAEQ94MuDnKiKD8gUKmmrdyyePXwmMaeMvvaApyF
 sAIQ==
X-Gm-Message-State: AOAM533tRLGeRNfW7bqTzi0rqw9TmJncR4DX/eHeV4zfzbUg5OrXmYzP
 PuwgBiH5Z8xBQR+CNRSRQEDiw3kKVobzv0KaOnSUkg==
X-Google-Smtp-Source: ABdhPJwh5vFEmd5U+rE4guUw6GwbF63dIzpVkeE2/MhBCH7+CRS4HbgZfmVRnVBoiq6k7fMZxtsjcvAK6amIYe1HcnA=
X-Received: by 2002:a05:6402:202a:: with SMTP id
 ay10mr3388600edb.36.1601479135646; 
 Wed, 30 Sep 2020 08:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200930083552.506733-1-mst@redhat.com>
In-Reply-To: <20200930083552.506733-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Sep 2020 16:18:44 +0100
Message-ID: <CAFEAcA_fhNYeed=E1-Ym1sbwdUwr=qKUUoeUC0cWkOf-D6HJ_Q@mail.gmail.com>
Subject: Re: [PULL 0/2] acpi: unit test
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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

On Wed, 30 Sep 2020 at 09:36, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit f142e4ede72853aaa7d306bc79b099caed45769b:
>
>   tests/acpi: drop unnecessary files (2020-09-29 07:10:37 -0400)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 42803552319a5481e90e93382d74a7336dfab496:
>
>   tests/acpi: add DSDT.hpbrroot DSDT table blob to test global i440fx hotplug (2020-09-30 04:10:51 -0400)
>
> ----------------------------------------------------------------
> acpi: unit test
>
> This just adds a unit test for previously merged functionality.
> A bit unusual, but we have a contribitor under a deadline,
> let's be nice and merge the unit test right away - does no harm.
> Hopefully this won't be a beginning of a trend ...
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Ani Sinha (2):
>       tests/acpi: unit test exercising global pci hotplug off for i440fx
>       tests/acpi: add DSDT.hpbrroot DSDT table blob to test global i440fx hotplug
>
>  tests/qtest/bios-tables-test.c   |  17 +++++++++++++++++
>  tests/data/acpi/pc/DSDT.hpbrroot | Bin 0 -> 3079 bytes
>  2 files changed, 17 insertions(+)
>  create mode 100644 tests/data/acpi/pc/DSDT.hpbrroot


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


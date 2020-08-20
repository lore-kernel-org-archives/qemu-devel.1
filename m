Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A7FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:46:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95C32078B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 08:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CljHDQUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95C32078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8gDn-0006DI-OZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 04:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8gCo-0005Qz-9E
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:45:54 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8gCm-0006qf-OG
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 04:45:53 -0400
Received: by mail-ed1-x541.google.com with SMTP id bs17so966127edb.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 01:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g0DlBNp6YDDBN48UNUqlDpqWU80/6uS7LKOw8pvXJhY=;
 b=CljHDQUr00WotsbQhEYPXgNFJiK3g60081aBCG+K8CB8sF8IbKCxxC6GGiHZt5RdLe
 /ZPP4IM1V2/p28MZ4ajAxOZ9QlxtlpA+uk7oy0RsP4GQqH/8/cWqozD/ApjX07GuTXi6
 WvxHT9I8xV2MMlIAwePC4PVBCFx0pVcyqI942Hsq44pNvgqEqoBxIbpSlMyzGkKiUs/u
 4afhG6Ug557mqPBg7zxJ3+rxuSU7EOiK9jqnQia+8IPjGDUBXL466K/LV7CScjN88SY2
 OsGfgm8JEhfONwIYSQXebdY6fE6r06UziIuZe1PF758VlNNIhrTO9IGmRbC0N9HK9YEy
 rtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g0DlBNp6YDDBN48UNUqlDpqWU80/6uS7LKOw8pvXJhY=;
 b=X0fHPAFOJyALKMqa0WSmZk7ZuIO+0edveBaVJ9dGCBQ4UF/0k5jRz10eMPAPxlwZD1
 H7NicJXB32kuDXuZrZkS4ZCQyJOMnNN2s//Qwr1gQUzbjobCMGXolC15o4NUHm/1NkWJ
 2mMXPXFwByBpznJ/BL+aRu0XuAiWUR/dNsFVdSICsFHxsXxaRQE8Zl39Z1MIr3QDySEb
 +0IxEGasqoXSqpSPNJjCu8/MdG3YM7zBaHIyBYpemzrf04L/THYzAnymJKhDDeIAfrqK
 ZjX+tm5tzJme8ZQiZfAyGTMxwdj+X/OKcoWTjQANQgzPg5IiAp7ajNRrWeHqzS08RLDc
 xZuA==
X-Gm-Message-State: AOAM531MfskPQOpFzmuuHVEUnjHC/BA0l7wHhiDSHsH7V4xSY8cnEoF/
 2n2uMD+gx2qWjDUn9iHRsqmizvvZWMp1BUmdb+yX/g==
X-Google-Smtp-Source: ABdhPJxhFF+a4gRibLUPfJ5YNChIP/h2dvu3919bgA5FfTMYkeNRi1ZUCMIxBn9ge2luS3AtpAwmOvpaPZJkCa/+/Q4=
X-Received: by 2002:a05:6402:17a4:: with SMTP id
 j4mr1974573edy.52.1597913150721; 
 Thu, 20 Aug 2020 01:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200811093505.972894-1-mreitz@redhat.com>
In-Reply-To: <20200811093505.972894-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Aug 2020 09:45:39 +0100
Message-ID: <CAFEAcA9vsZwGn8BUY0Y5eYwBu9FkmHkTH0zNaDt3VMm=h7Cq1A@mail.gmail.com>
Subject: Re: [PULL 0/2] Block patches for 5.1.0-rc4
To: Max Reitz <mreitz@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Aug 2020 at 10:35, Max Reitz <mreitz@redhat.com> wrote:
>
> Hi,
>
> There is a bug in the backup job that breaks backups from images whose
> size is not aligned to the job's cluster size (i.e., qemu crashes
> because of a failed assertion).  If this bug makes it into the release,
> it would be a regression from 5.0.
>
> On one hand, this is probably a rare configuration that should not
> happen in practice.  On the other, it is a regression, and the fix
> (patch 1) is simple.  So I think it would be good to have this in 5.1.
>
>
> The following changes since commit e1d322c40524d2c544d1fcd37b267d106d16d328:
>
>   Update version for v5.1.0-rc3 release (2020-08-05 17:37:17 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-08-11
>
> for you to fetch changes up to 1f3765b652930a3b485f1a67542c2410c3774abe:
>
>   iotests: add test for unaligned granularity bitmap backup (2020-08-11 09:29:31 +0200)
>
> ----------------------------------------------------------------
> Block patches for 5.1.0-rc4:
> - Fix abort when running a backup job on an image whose size is not
>   aligned to the backup job's cluster size
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF672C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF73207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hApNlZy3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF73207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlvZu-0005Fc-UQ
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 10:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlvYU-0003wR-K6
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:30:14 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlvYS-0002OF-J6
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:30:14 -0400
Received: by mail-ot1-x344.google.com with SMTP id g7so4630138oti.13
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WvMQOzBuA2ppI1w6JuSEP83Peh0EV3554WjW4lgGAn8=;
 b=hApNlZy3GPYbZpPmp551w8vv3tj1HeOcmJC5vTYZBIUwJODked/i8pZFEK6FudczgA
 zo1YtrG/bqNKXYW4IeD91zBSVxpux3ySw5KLD4nlIZ1O4Q+PhbDMtT8EK1jlb8NKr9HO
 3tT8YAp2ep3r3MQFB8NoFVWzvkgqKzz4X03kw6GqUIa0npfXw/oCCxNW/kQEjWJECl4s
 braYAeXfS1DMdKWHJ1ylw4JYFrHwFLIipuBo5zYoF4HyQufYTK9nAuhAf0SBPrbgceMs
 CszYw44bMdd10gsyWCtydjDlP5OSQDE/jFYXQeBJ6Y8oZj/hwUzSSKFXTIJDdB4ISVC0
 Zr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WvMQOzBuA2ppI1w6JuSEP83Peh0EV3554WjW4lgGAn8=;
 b=CMjc0898Sj+vGdkiJYPUgQCQgLf6Ivqp3WyNVc8iOwOHv+P4DSRkbv562qcIhmvhgI
 vxpR4MK7wi+o2gCIAV/0sgDgPh8fEUfilShIVSFqJ0p/RCXXaDqfpjHtfQl5ErMZ2mod
 ggjehTeakimQnkQxhPkGIhlf0MeQQQ79Eo4ZZmdBx5bNQC7YMMnq/nTmq1pYhvrf7+/C
 hEupcd7D5uarqtwYwf35/egauHULVJVJzbuTgujGgNdigFD2HhSnyIHJAEarzcyZWCiO
 g3fWjq/6QIs1LItVWQKrAv54FxgfUZa0vI+rqWEO/TpFQnvSiK8+4MREfoHh80mQhAAi
 yqnA==
X-Gm-Message-State: AOAM5306FDrTFSHNh1znhZZ8SeM3S6sZUzjrxKc+BDni4V1vLSOwlCmk
 VJF9hxLYVCmkNVRF+ZboSJChxzPZVn0EUJGpzdczWJIyHA4=
X-Google-Smtp-Source: ABdhPJyYv91nJvCkasdbIkG3SPFL3gQQV5uXmAPGfr5xweqeVkFXZHcVDeVeWxloZzCGIa7WVwq0tu6U7MbHCALNk1w=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr3640186oto.91.1592490611290; 
 Thu, 18 Jun 2020 07:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200617144909.192176-1-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 15:30:00 +0100
Message-ID: <CAFEAcA869qxSMaZiw2Hz-ESFbRL+Mq9Yoq=pGRBbL8oUV7Gj=Q@mail.gmail.com>
Subject: Re: [PULL 00/43] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 at 15:49, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 5c24bce3056ff209a1ecc50ff4b7e65b85ad8e74:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-plugin-160620-2' into staging (2020-06-16 14:57:15 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 3419ec713f04c323b030e0763459435335b25476:
>
>   iotests: Add copyright line in qcow2.py (2020-06-17 16:21:21 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - enhance handling of size-related BlockConf properties
> - nvme: small fixes, refactoring and cleanups
> - virtio-blk: On restart, process queued requests in the proper context
> - icount: make dma reads deterministic
> - iotests: Some fixes for rarely run cases
> - .gitignore: Ignore storage-daemon files
> - Minor code cleanups
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


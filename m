Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F2CC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3812720709
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 19:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJ9Qezte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3812720709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYaL0-0006UJ-1J
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 15:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYaKA-00060w-CF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 15:44:34 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:43296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYaK8-0002qE-Mp
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 15:44:33 -0400
Received: by mail-ed1-x536.google.com with SMTP id dn5so7807283edb.10
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 12:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hwd/sGRMmS6NYhHXnZ2qmdx4sh7ls5tI2LhbXvO/RWo=;
 b=tJ9QezteLo5EGmIEucITgD/WbyWawc1cUSVYe+Y3znRtLf1PM66sUd72ZYuWu9e2en
 Gw2L0VTSzxmnxwfJ+6Ax4jD8G/XfwalUY97iH7uRkwG0FoyDcu650fkjiHHE3E31lCaZ
 8yJQJ8H45wzVAfOWMX1JhVtDQ/ixsvj3PxPehPqw0A3vfHJmgSq5raA5wHaA4nAchrEs
 97i8HKgoA6pT+N7D94mD9nyfjfKw3fZsMQHHvubf1SufkmGts326nOfwAJw2Lm4Az2uK
 lVwCM7V2pqMn1omhP09TSB7tflC0nxmrkEHe7E6F0BIDafs5bC4/9ebiEgqOYFcW/q0W
 +Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hwd/sGRMmS6NYhHXnZ2qmdx4sh7ls5tI2LhbXvO/RWo=;
 b=Zd14r1cEt116uugiAc6oMbWorXSTyS/N5fm5nHkKMR1ER8maEuVkRjFIuI/8orA2ox
 r8Ks/ZNwmTzN6KevynQGGGas90jkPxg16oY8Rm98+Kt1mOtetgEaFy9hC/XMjHP09x6d
 ZVV0k7uo0SQhBYTuWdDfJtVippf+MAzVjDK71pdUxLODiEi7Chc2co0pHouk5b1FJzgA
 LfCxuB0uzHdSzU0uF0mh5fli7gqAkaA+sjXolFNo6yq2Dsh0eIqfU4ZWlKbboOHAehQE
 8onM6BNr8R8Nhd5qdXyMa3IkukpocSlHfP0mbA82GLe608unSO1bix4TtMXTgqsn5l4x
 wGUQ==
X-Gm-Message-State: AOAM533JeUNPpBZI1w5M3MZ9Mr4tnu8FRac0AIMOh2+r6SrmDnrM/qhA
 ALR/TbjX4qhtLWNw4DitxzIA0s59w0V6lbQ8H1+brg==
X-Google-Smtp-Source: ABdhPJyf7JdHK7+3SAme7Y6Uhs+hz0mu67KlD6SY05j+/eZkRXH9PuFFLqPX+zVli6WkwDe2O5PMX+Gp3cI3s6KKh24=
X-Received: by 2002:aa7:d699:: with SMTP id d25mr4151997edr.44.1604087071158; 
 Fri, 30 Oct 2020 12:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201027163014.247336-1-laurent@vivier.eu>
In-Reply-To: <20201027163014.247336-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 19:44:20 +0000
Message-ID: <CAFEAcA_pVT+-xSD_U61dTJF=tKFJRWcTqTenurXk2ETR5n6JzA@mail.gmail.com>
Subject: Re: [PULL 0/8] Trivial branch for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 27 Oct 2020 at 16:33, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-req=
> uest' into staging (2020-10-22 12:33:21 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request
>
> for you to fetch changes up to e83029fa605d6aa475be60b191f2af3954591093:
>
>   CHANGELOG: remove disused file (2020-10-27 16:48:50 +0100)
>
> ----------------------------------------------------------------
> Pull request trivial branch 20201027
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM


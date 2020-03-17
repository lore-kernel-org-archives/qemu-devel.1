Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFE0C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0003D206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXOju6qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0003D206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEBp8-0003qd-7W
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEBnf-0001x1-Hy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEBne-0003N1-1Q
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:58:27 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEBnd-0003Eo-Qv
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 08:58:25 -0400
Received: by mail-oi1-x241.google.com with SMTP id 9so3507930oiq.12
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vEyOiHsdkpDwrVPBg4od8ujETT3HpbjzMWimG7ThbVk=;
 b=FXOju6qy3oD64HclHSnvNXQR6qUBDey+YH6dLE2VkNCVekC8byyx3NxWI7phQ60jRl
 u7lFrbc60hBFLhFjhvLW6uUVXVioegKd+wgA09WjocZa+y1kNAfmv4xUhrMytD0l2L93
 tyWdGCZuTWlvjUdFqMftixn5teiq07GqQitAhzUDNoAdaVWtxTBsNGuaKsFzzavgQQx0
 2eCHDxqgJ8KLbnpB+YK4MKffLo5Q8f2o2f1dac0723I/0WlPpRQPU4/X2SDSh/VthrE1
 TRL5/NLLiy98JX9WP9J5JnBl7ZCDPLt+7QjoDD/c0zhqwwKbcSkICBKiQnOZNIG/kk+F
 eKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vEyOiHsdkpDwrVPBg4od8ujETT3HpbjzMWimG7ThbVk=;
 b=LZbyKz9E+evJQg9yVncqBjdk5+d09cMvpxuhNZpedyjgAi2O1T0hOl8By57zOHdPDA
 XkXNjjE6MOWFy0hHjn1sxoPwNMdVSw8ZIFLpjjJH4yNgauiGzBFUMou6w+hDYhW85pL1
 3Sybyl9182YgCTYro9mrCYgnnz0GVvok24Ltyy36uGom/38zAg1AL07+x+8cD+VurbR8
 Ft8ZKnTKGhd/CZ+6k6YKjPj9pU+6h577z15sk+gKLOI8Hpo9tkTl6FSTjPsVTqAFEhrS
 7FFY+RU9w+eByw4AIE8qNPb1RSe5usGLb3NeNlxE3rgDN10egnG2ygwxNpXN86XRgZfH
 uOeQ==
X-Gm-Message-State: ANhLgQ1z481AomGDQxx6HiMg3LpO+OfdcGy9E2KD2eJl80Y4YigfXLS+
 DHwgFWqQjkMXidVx8mfzzNBQ7f8iFudbcJg73AV+LQ==
X-Google-Smtp-Source: ADFU+vuiwazAjoxQ7YHwGhvnyjgLXrD8+Zl7gAbcwlbqqC9jnX1qXW9hUwn7VwApLlSImh7LvsBX9zQxIM1ssH+Nzog=
X-Received: by 2002:aca:5b07:: with SMTP id p7mr3219694oib.146.1584449904852; 
 Tue, 17 Mar 2020 05:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200317040547.222501-1-palmerdabbelt@google.com>
In-Reply-To: <20200317040547.222501-1-palmerdabbelt@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Mar 2020 12:58:13 +0000
Message-ID: <CAFEAcA-Gm8U44LiS3rUxMi-qcnRJWgtisdEfJRPC4stkrbnOpg@mail.gmail.com>
Subject: Re: [PULL] RISC-V Patches for the 5.0 Soft Freeze, Part 5
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Mar 2020 at 04:06, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> The following changes since commit a98135f727595382e200d04c2996e868b7925a01:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200316-pull-request' into staging (2020-03-16 14:55:59 +0000)
>
> are available in the Git repository at:
>
>   git@github.com:palmer-dabbelt/qemu.git tags/riscv-for-master-5.0-sf5
>
> for you to fetch changes up to c5969a3a3c2cb9ea02ffb7e86acb059d3cf8c264:
>
>   target/riscv: Fix VS mode interrupts forwarding. (2020-03-16 17:03:51 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 5.0 Soft Freeze, Part 5
>
> This tag contains the last of the patches I'd like to target for the 5.0 soft
> freeze.  At this point we're mostly collecting fixes, but there are a few new
> features.  The changes include:
>
> * An OpenSBI update, including the various bits necessary to put CI together
>   and an image for the 32-bit sifive_u board.
> * A fix that disallows TSR when outside of machine mode.
> * A fix for VS-mode interrupt forwarding.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM


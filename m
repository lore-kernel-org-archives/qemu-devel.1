Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B19C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 13:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C1420760
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 13:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4AH9MVt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C1420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpXWm-00064V-Ge
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 09:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpXW5-0005dc-5G
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 09:38:41 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:40507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpXW3-0007Ji-BK
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 09:38:40 -0400
Received: by mail-ot1-x32f.google.com with SMTP id q21so5533839otc.7
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lEBdCW5hTClr7IKv7QM98niNy9li5T7EzpTJRmlx6gY=;
 b=B4AH9MVtx9poRZZtwekztsZUzMLENn+Uo9EYYrRwvfGwbUViqdKjwOiD1RyycoPc3j
 VUGZ0suaUdClLmgmPmRCxvpxk8482Xn96KvfYdBDA6j1RSx00hgYanltZp7PiaLPMNix
 plTb66C363on9U9hP5fL/Nk2CfWPWAecF3vAj6/05NA9kjc1vFDA/tu1U5Hi88OUA6wy
 HD5H/lr6lOtHGTJZvW/V5pIt91hwJDbV4VQixE4poPIeAmcHpDvmXG1DOXoVXymPG/uX
 w1J96iGgVtqev7pt6mBHAFnDmeLoiPMq2STst/kl80j8kzNr1Zr/04UlVyYbsMAgmciU
 9w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lEBdCW5hTClr7IKv7QM98niNy9li5T7EzpTJRmlx6gY=;
 b=JzbsbEJV0FcDi2Orv8Vnb10xSqdtAfZE3Deq9TtoxGNi49KqrZUtSk4H7XTRJPxhB5
 P2wP4xcQt+7Xv0SWJY6Wrt4XhoZ9cl7KNHrEIjXzJDI73gzGwE8z/vxoN+dmV+HTJLXn
 t+3OO3OHVG23sHR41Xy41yjlChPVRFLl5si2Yo71X74gFF1/602HX8LksjfPHi3+13Sy
 haCkXzjEAVP4+LyXD8LlxJ1EhTTaVUfNUohaB6bCM78VK+1UHdz0Cpt7ePmYpVmjWorc
 +PGRAYk5O0AX+UphzPREjvGu3xmJB5yIV/DU/TtTE7duX7n5wQdmM8aE+3dKst0ie8Rx
 aVew==
X-Gm-Message-State: AOAM532lZV/fCMDkoC2oei9A3NWi4vrc/eXoGIZ5+kwXhOiO4GCNLJN3
 02b+KZ6rYk9qXwKyAeiuZruDei29kDstqEg2jsmJdQ==
X-Google-Smtp-Source: ABdhPJwLcclVeDEO7h+aJ2b03uHc06HvzQ9Sy2sDySSUudjzV5rhSsnIwAfW0rZKObLB78YGs6x01yTHnO/kse/HPkk=
X-Received: by 2002:a05:6820:172:: with SMTP id
 k18mr1888298ood.69.1593351517974; 
 Sun, 28 Jun 2020 06:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 28 Jun 2020 14:38:27 +0100
Message-ID: <CAFEAcA-+3ZB7O6J8b6-T_nJ1H63S7D-5S1+SYCoFhV5hKkZaog@mail.gmail.com>
Subject: Re: [PULL 0/6] MIPS + TCG Continuous Benchmarking queue for June
 27th, 2020
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32f.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 27 Jun 2020 at 20:51, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> The following changes since commit 553cf5d7c47bee05a3dec9461c1f8430316d516b:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200626' into staging (2020-06-26 18:22:36 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-gsoc-queue-jun-27-2020
>
> for you to fetch changes up to 53fb8bfb93487c0fd88b0babb9a52ec8d67cff7b:
>
>   MAINTAINERS: Add 'Performance Tools and Tests' subsection (2020-06-27 20:15:07 +0200)
>
> ----------------------------------------------------------------
>
> MIPS + TCG Continuous Benchmarking queue for June 27th, 2020
>
>    Highlights:
>
>      - add two additional elements of Loongson-3 support
>      - add first two Python scripts as a part of a GSoC project
>
>    Notes:
>
>      - several checkpatch warnings on updating MAINTAINERS should be ignored
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


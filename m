Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49765C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15CFF2339D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YWtyeY21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15CFF2339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5VcQ-0003sj-5h
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5Vaf-0002I2-P2
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5Vae-00031D-31
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:44:53 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5Vad-00030R-PB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:44:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id r20so20634139ota.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=yWMssjLJ94nhTj0RUOc3ZyYTI003sRj/9s/LZbu5C+0=;
 b=YWtyeY21wSJlWk+D1VNsgSmSUTmIoo6PdLAKYeWL/5WOkKu4vttwzvpNkrYYCqBJYN
 oxMUgrBtHWk91o3l6ynA3YI3KYptRYXrPwbsN+vuas+Q0x1chv5/+HKFG9HdeaTt5A+3
 DRH3BnkgacSenQssl4cXBHo7hoI5suMvMq41Ar3CTRI01lD54QDPHmueZ4SImNMbovTF
 lRI1O+masSs80sBuUWrTdEnsaZxhO0LoVan4BNZ/R3lbmCU9KlsQD9NzrWckuN80uq1s
 yp5aXjRTLXCYu35YMRmivPuMx18eGqYVdNDy0Gh6a1zFLu2LqCGkEHeogrYHUpMGeXEq
 vB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=yWMssjLJ94nhTj0RUOc3ZyYTI003sRj/9s/LZbu5C+0=;
 b=CA+PgVhsDZ46Ot+Aqr51qFaXsnEGGwR0f9T18S4X1I7rDEJpCLtj4mFCJR97JwrFD0
 xb4Epab9ix4P8sPmZ3kl5Q9bHqBh53J/zlw0xwlAyUK0TshXGd+9SCN8SULMbsLFtFXG
 7bhx2lH7snBJ9UoS2Y8ZJ8wKKGpy/EIIogGwukr4p71nqm4kRtx0PoJiIiVqTwHcO43W
 8pRXpbtri32v9wkJKbMAvOUBaHMqRambaLQLMJGvU7H1GEC5bOMUxdyWB/ttNGE6rnoV
 LiNkjNYJvFXmhpH38Kh2+BohYfV/ncdKJ0zaVVgBBCEZU17dQXEDuQHTvW+BDfJAEhsN
 T3cA==
X-Gm-Message-State: APjAAAUjGmxW9gcklK3zb0FVwbiP+HKHNSRqx7Z7ZDSHKeG7aDvVOQ+M
 xLg4YCHFzr4/Gcsz2HDGiBrQq7f8AC9uvA7sV1QQMU89HLA=
X-Google-Smtp-Source: APXvYqziaFdNWwPMMs4Q/l9pSBEbcJ2KazZ5WeZrTElQyJudXFnL6fVO6ylRm0MnLX/xkA9FcePMKF5YoeoMfO1FeOA=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr33969960otp.232.1567604690596; 
 Wed, 04 Sep 2019 06:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190903153633.6651-1-peter.maydell@linaro.org>
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 14:44:39 +0100
Message-ID: <CAFEAcA8vdd4nsL9YmUiO0eKPAYW5VQex-tky_jUhatwmc2G6OA@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 00/21] target-arm queue
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Sep 2019 at 16:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> target-arm queue: this time around is all small fixes
> and changes.
>
> thanks
> -- PMM
>
> The following changes since commit fec105c2abda8567ec15230429c41429b5ee307c:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20190828-pull-request' into staging (2019-09-03 14:03:15 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190903
>
> for you to fetch changes up to 5e5584c89f36b302c666bc6db535fd3f7ff35ad2:
>
>   target/arm: Don't abort on M-profile exception return in linux-user mode (2019-09-03 16:20:35 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Revert and correctly fix refactoring of unallocated_encoding()
>  * Take exceptions on ATS instructions when needed
>  * aspeed/timer: Provide back-pressure information for short periods
>  * memory: Remove unused memory_region_iommu_replay_all()
>  * hw/arm/smmuv3: Log a guest error when decoding an invalid STE
>  * hw/arm/smmuv3: Remove spurious error messages on IOVA invalidations
>  * target/arm: Fix SMMLS argument order
>  * hw/arm: Use ARM_CPU_TYPE_NAME() macro when appropriate
>  * hw/arm: Correct reference counting for creation of various objects
>  * includes: remove stale [smp|max]_cpus externs
>  * tcg/README: fix typo
>  * atomic_template: fix indentation in GEN_ATOMIC_HELPER
>  * include/exec/cpu-defs.h: fix typo
>  * target/arm: Free TCG temps in trans_VMOV_64_sp()
>  * target/arm: Don't abort on M-profile exception return in linux-user mode
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


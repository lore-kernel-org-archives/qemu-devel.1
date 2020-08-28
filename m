Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5554FC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2EB2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 12:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jg4aEncr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2EB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBdEk-0001RF-Cl
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 08:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBdEE-000113-1g
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:11:34 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:32820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBdEC-0008DM-By
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 08:11:33 -0400
Received: by mail-ej1-x62d.google.com with SMTP id a21so1220601ejp.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 05:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LNfEcmKbcA3xTVkrGDwsy+RFnPGlncApMmrbLbCHaPk=;
 b=Jg4aEncrcl46qytD6soQ5LiQcI82fmSIJFqzrbPvOXy/ojaRhI439awaHWvbreCZ9e
 S4A1/ZkSkS6nhJYdPDJ3lFzB4av6d4IFxYfZ/bPM7T3IBjXRcZ+yOdFlMwB0SGQ3xeh4
 Yn7ighmoQQcGNyBJAlAws1/t9ROBZiydZZYGBHSdz7Vm+HW8wrIcXd5Evea7w5N0VkhU
 aPNJQgcP+f2GI9e/OKzO58F4pT2OlprNSwTDAS0nBPrVSTaouA3Fb2liuY+jktkw4L57
 Mg+kOXu3AFmf81vgPfkmcfEfqim1xTBnl5dJJirNguDUvtE676XBwbDITgA2o/Q6XVwu
 zyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LNfEcmKbcA3xTVkrGDwsy+RFnPGlncApMmrbLbCHaPk=;
 b=OaIF9sjTVZxSPD0EQ26/PcL9uu4kIhevCbaEiHVXXlup6Um2ZRbu7dpkyVFi36HEpa
 IvqJPVR66NGqNvzgVZvNz47CS9IXXglh6XlluzNcPnRdEhuNa+IZyspzbp92kr9TYuNA
 z36/Etr9R3Lv+s0UrBbWIFoTvbyvU5hbdoenT6nLvPFc/Zte1/efeiczaC2gNeB5OQlS
 4nFeE+UT5tUwtOBweYw6aZsy0KB5RicDiZVQZSOYgB6DHfkjb0rfSE3BKHvJwXXhdB7s
 61HxMnPr7BTWRHsunr46Q3/HzJLNgbS78YSvLSYHK/ObnXXqgbVpsmaogmLu7vH0LSiH
 6U5Q==
X-Gm-Message-State: AOAM530yTnRNrZX2VLk+SwaifHdxZQzlGKDjvyakx4zP8dKZ+NVKEUVS
 FfWsiVh2Po7iP6OL+FRcB1nTTYrRGfAs7D2VnoZ2aA==
X-Google-Smtp-Source: ABdhPJyx2N4ThUlNqtNBY4jEyyjl1TCHSucJwkG7v5QMTsvdfBByhae9egG0TEl7SNi8pWKwARtzbjKkw3L0b8nWdGo=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr1415441ejb.407.1598616690768; 
 Fri, 28 Aug 2020 05:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192018.2442099-1-laurent@vivier.eu>
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Aug 2020 13:11:19 +0100
Message-ID: <CAFEAcA99NybkNUT7dpECnHftOz5VrQCwZJqQkuO3sUAMseoYGQ@mail.gmail.com>
Subject: Re: [PULL 00/18] Linux user for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 20:23, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 25f6dc28a3a8dd231c2c092a0e65bd796353c769:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-08-26' =
> into staging (2020-08-26 10:28:36 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.2-pull-request
>
> for you to fetch changes up to aa26eb42f5eaec54257aaceaeda50b9aa98756a5:
>
>   linux-user: Add support for utimensat_time64() and semtimedop_time64() (202=
> 0-08-27 12:29:51 +0200)
>
> ----------------------------------------------------------------
> add utimensat_time64, semtimedop_time64, rt_sigtimedwait_time64,
>     sched_rr_get_interval_time64, clock_nanosleep_time64, clock_adjtime64,
>     mq_timedsend_time64, mq_timedreceive_time64
> fix semop, semtimedop, clock_nanosleep, mq_timedsend, target_to_host_timespec=
> 64
> fix tembits.h
> add more strace function
> Add upport DRM_IOCTL_I915_GETPARAM
> detect mismatched ELF ABI in qemu-mips[n32][el]

Hi; this fails to build with clang:

../../linux-user/syscall.c:1181:24: error: unused function
'copy_from_user_timeval64' [-Werror,-Wunused-function]
static inline abi_long copy_from_user_timeval64(struct timeval *tv,
                       ^
1 error generated.

thanks
-- PMM


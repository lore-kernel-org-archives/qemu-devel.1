Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0134C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C80207FB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 20:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oUK65th6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C80207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO5MF-0000U6-R6
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 16:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO5LL-0008ON-Qz
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 16:38:23 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:47059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kO5LJ-0002tV-NY
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 16:38:23 -0400
Received: by mail-ej1-x632.google.com with SMTP id z23so9996491ejr.13
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 13:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KKO7xx52fzo7qy0mAB/nVHsyAHZFNlL11iFS8TlQow8=;
 b=oUK65th6vLxyIKEjTyGnhvQNjbEwBL+ZoX7hTmLeuUoIIWpeYqUeNLlFEUlJ1vnafU
 lx3/kLREuViTXbxq6+Ap1+OQfrMIqzzy+HZOPoqdLjsntHZmyWSgXm76TQY79ef+oN+A
 Co50sNipTew+9aZzQIRpdRjAmNBnUccrdpDn8RNZ4ibZqq/QPXpzcorngTNoz6e0MYUe
 mja0PRKedchMJFzB4h1YZJQ91x3EaFjyVbh6sNN73FbbQtbb/y586rRgJP6DQt3Fd7ED
 qi2mPsmhBw6kHQeIvwfxErG64JkcmSB1LAt4MT8fxY2GiZisVs8pmWexTv8OFQLiuRGg
 CAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KKO7xx52fzo7qy0mAB/nVHsyAHZFNlL11iFS8TlQow8=;
 b=mSLNKiNjK37T43sMo0X+aAq2YU3IPM+7pHnG6SFDtePkLSjf5P8GpYU63T5wiMdC4C
 lzQy27ZBPi3bdmYJbjN/MNnE2NEZ/bFXn+idKPUqqXIYhuTk2bAUYdEr5+mjt3306ur5
 wajHSxJ4qq1UHtftQNRT5HmmfVI/OA62KR0aVwTH0CG8WeAyjZ8JSioD34/R/mzPSJ6J
 9h4yjHqiNZl5PQGQyw+aPJ6MaQaBzaByYfTXb0qKQYGaIHZuMAUF06+BmaZXD3VEIYJ6
 cXABsysvT/JL+jB/OoVdWPjZqhkQSKCFYB+e89NFlxuv3BauhApfAx1K7gxDnfnhSxWK
 QbKA==
X-Gm-Message-State: AOAM5305M1VPtxcQjMgAqKRXI/qBFy3bKd8zRUL34cHYB1FwZHhHtpHs
 d8ExifZnvsA7Zx7nHcjbxq8I9GcGk0ilXG9OJ8Q1pg==
X-Google-Smtp-Source: ABdhPJzVXY/+B5yFtX4WR9fgjBr7DfZSGDc/LiX9uIm1Ban/WRdPnGu9aXWAOT24GBrjrpTs32Qt+K+m1NHMU0H0tpI=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr10459071ejv.56.1601584699540; 
 Thu, 01 Oct 2020 13:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAD5Umjr6Nu6fddP2LgkfxtTTKduHEMs=C49C2r_ZcMkopsYidw@mail.gmail.com>
In-Reply-To: <CAD5Umjr6Nu6fddP2LgkfxtTTKduHEMs=C49C2r_ZcMkopsYidw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 21:38:08 +0100
Message-ID: <CAFEAcA_AjzNKzrHBU7QQzB=dxia9mYuw5oAsya3h42JEQAemaA@mail.gmail.com>
Subject: Re: ARM semihosting issue
To: Bruno Prado <bruno@dcomp.ufs.br>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Thu, 1 Oct 2020 at 21:33, Bruno Prado <bruno@dcomp.ufs.br> wrote:
> I was able to use stdout, stderr for output and files for
> both input and output in qemu-system-arm, but stdin is not
> working (always returns -1 from syscall). I found no
> information and have already checked the code for possible hints.

Rather hard to say what might be going on with this little
information... what semihosting calls are you making, what
do you expect them to do and what do they actually do?
Do you have a minimal test case we can reproduce with?

thanks
-- PMM


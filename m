Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB47BC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:37:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480052087D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRORNbnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480052087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFM1J-0002wD-G6
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFLtC-0005AK-TR
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:29:14 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:44832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFLtB-0005W9-5W
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:29:14 -0400
Received: by mail-ed1-x536.google.com with SMTP id b12so13555007edz.11
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 11:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hrzfhoNw9XhRBd4AYhQ2r8fiEBifG0Cv3MvNUPuu0oU=;
 b=gRORNbnxiRKigt1yJ1j1WxUX3r7m03u6zJJ4OD4iVO6qB5ogdaLzm+BejLPmn/sZTz
 JQN9t/EtHBYCFhtOIoBe8zQH5PbMdAqOf0W1/bUz7txT7hDXZHqp2FC51wQm+FnvQFQA
 199nF9sM9gSgyIIm323uhQNkFjEzL7sgkHkekpQ6mQuKNmJvLPRFFgMKSp8dH8Jcu9ek
 EyaUJf/GlPyeB26O4BdU4d9JNN+SDF7F1foQdTIN0J/EnGw9P5DZ722Y40VNJKxYewfV
 8C04CHnWXEMBDM0fTWw4FcxJ+uAx4usEmmJElkbf7E4jtb/8gS4VIdkEtvPSdoKEHI4X
 WbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hrzfhoNw9XhRBd4AYhQ2r8fiEBifG0Cv3MvNUPuu0oU=;
 b=FRtut4M4GcyAb8IuwdoAycJnYUUxB5lD9eyFWq8mzbdXexPHirpukzb+OqRNCLh4ut
 l//2pdGk9m/N6QiN5zjaT+2STjtDO+AXLXxIDSbra9tu9zKSI8eWinBjc37+vtdp5vCp
 AyvcggwUMckujj/6P/kryxRsIUDlaI9Ooy3AARN8RcguMAIVmQ5u3XExkRs2vabS4rWL
 SAbHTpmlsGPENFvQ+UyNaskz0Lq7qbfzYGVI9gnOkLU88Qol59Ax0FY1zKok0nSbnTx0
 OWz1LeWB4cAkT7f08Z9mc82MTe9rcc9imMDKm1Nkk8oMXglpc2jBg3CcH5BbU/+lhdfd
 cvZg==
X-Gm-Message-State: AOAM530oXphM9eMEEZvCOzz8WZRDVXoLMQRDgGHNmkNQsLlGrWqtBApp
 AjS1rRm+e/9rVdrJLpIWkXmZRyH96FTcfCBswbbqeBERVYfv+w==
X-Google-Smtp-Source: ABdhPJzYnI0kyByvTL/WbpbPUPWVXxewYrvcBRp+GrfZdK4XglBJ/g6ooQq0BguyMsZAbJUwyUCNFSIEx4EhloRtmRw=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr23724424edy.52.1599503351795; 
 Mon, 07 Sep 2020 11:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200903160746.27491-1-deller@gmx.de>
In-Reply-To: <20200903160746.27491-1-deller@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Sep 2020 19:29:00 +0100
Message-ID: <CAFEAcA_9Dkj8dJAxLdhtN_6Xw+ThX0J-s0LkG1J2mnJdd+NLWA@mail.gmail.com>
Subject: Re: [PULL 00/10] hppa power button support, graphics updates and
 firmware fixes
To: Helge Deller <deller@gmx.de>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Sep 2020 at 17:07, Helge Deller <deller@gmx.de> wrote:
>
> hppa power button support, graphics updates and firmware fixes
>
> The following changes since commit ac8b279f13865d1a4f1958d3bf34240c1c3af90d:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200827' into staging (2020-08-27 13:48:12 +0100)
>
> are available in the Git repository at:
>
>    https://github.com/hdeller/qemu-hppa.git tags/target-hppa-pull-request

Hi; this is a git tag, but it is not a signed tag; we only
take merges with signed tags.

thanks
-- PMM


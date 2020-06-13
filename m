Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230C7C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 16:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCCCE207BC
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 16:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZPACV1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCCCE207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jk8rn-0000Lb-5A
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 12:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jk8r4-0008Hb-9I
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 12:18:02 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:42170)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jk8r2-00055t-BK
 for qemu-devel@nongnu.org; Sat, 13 Jun 2020 12:18:01 -0400
Received: by mail-oi1-x230.google.com with SMTP id s21so11746819oic.9
 for <qemu-devel@nongnu.org>; Sat, 13 Jun 2020 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DjJNX3D6RNLc9mcxY2AGXC5IDPGLUpOISMcPuArgfFs=;
 b=kZPACV1p/EGNpuOrbYO2c7SZkb4cdI4RvK19Xoso78YQMrXBAFsV7TCfBfFwUlhmt6
 vJx7+7TbXFu2IHYTS2ekQ5/Tt+428W0iCTWYTkt8QO9wBrjgQPlFiP9njvN1lBX3gevP
 mvH671EUUXg6dOBXxMI/VNVa9Uib0PscPxw2Zwq6Ie2meWOYYm95sUnsDgZ5lM8g3/R9
 t5aW0aTCO77C1ATJzcNy+tylZXbdcwduvYcH8b8k1ZASVCqJOOTdeTKIPgkWtSNb3Q1L
 AoKkN6LOx/CKEgAd0gQI1JfhFjRFCcrp/9aYXVnOTXBmm69YpkGeF9NcjARYp3ngU9mY
 S3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DjJNX3D6RNLc9mcxY2AGXC5IDPGLUpOISMcPuArgfFs=;
 b=Vq0fN3SDQexbUpFxf2G0eIoFoEyQu/ZFfz+pkWGL8GLkPzFEvBy5bPqzNErgrmE4Lc
 EgZY5WxHozz6YSmjGpZerdY3V2T8+I4q1ikL/jGWGz0RhnUpNegdtWGDgAAd1YmCrasX
 fgPau7EpHx6aoEzz9Unq9mQHjxTulbNbNrv9mZd+Z8k9TlbOYAGP5HuAqTe0ya9Nr3mV
 ywytBV7p0CspcAYKWbtQp/GWK1aR8LhYbKagBVPR345yjHkdVBpMNKf7+L4LznDnSFev
 G28pJxcDDG/ABegCjThmyrHbKX43/9++xZDW+/yaIco1fCo2cXZ9MQtslRNdgkRJMig1
 VzCg==
X-Gm-Message-State: AOAM530gqYeqbxthO51yPUxL8gahqnUnQbmyzzI8DGJhcJ4y5tnVsdOk
 1uvtNezzHCzyp0Kr97nWq9jq/fBg80vQdv0lsh/pjA==
X-Google-Smtp-Source: ABdhPJyUi4vrkCU1fSMQ0HSVD5IciNdNWxB1JJADgHXynP8yQnLftdXQuZHxYWuyazC3P++vvEVQA5vkye1H+Es7Kuk=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr3232670oia.163.1592065073409; 
 Sat, 13 Jun 2020 09:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200612160755.9597-1-pbonzini@redhat.com>
In-Reply-To: <20200612160755.9597-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Jun 2020 17:17:42 +0100
Message-ID: <CAFEAcA_jwCYccvLhFBMawjZsTh7ujVVwJOvhehm6ufuXOBU+yA@mail.gmail.com>
Subject: Re: [PULL v2 000/116] Huge miscellaneous pull request for 2020-06-11
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
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

On Fri, 12 Jun 2020 at 17:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 31d321c2b3574dcc74e9f6411af06bca6b5d10f4:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sparc-next-20200609' into staging (2020-06-09 17:29:47 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3575b0aea983ad57804c9af739ed8ff7bc168393:
>
>   target/i386: Remove obsolete TODO file (2020-06-12 11:20:15 -0400)
>
> ----------------------------------------------------------------
> * Miscellaneous fixes and feature enablement (many)
> * SEV refactoring (David)
> * Hyper-V initial support (Jon)
> * i386 TCG fixes (x87 and SSE, Joseph)
> * vmport cleanup and improvements (Philippe, Liran)
> * Use-after-free with vCPU hot-unplug (Nengyuan)
> * run-coverity-scan improvements (myself)
> * Record/replay fixes (Pavel)
> * -machine kernel_irqchip=split improvements for INTx (Peter)
> * Code cleanups (Philippe)
> * Crash and security fixes (PJP)
> * HVF cleanups (Roman)

Applied, thanks. (I had to fix up a conflict in hw/i386/acpi-build.c;
might be worth checking that I got it right.)

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM


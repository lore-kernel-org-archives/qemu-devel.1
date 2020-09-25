Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE87C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEE4D2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYA6CbAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEE4D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnQu-0000Bz-Mk
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLnGv-0005JS-KG
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:56:21 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e]:36045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLnGt-0001zC-Je
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:56:21 -0400
Received: by mail-ej1-x62e.google.com with SMTP id e23so3516042eja.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WCVpTFHNU2AiGKjuIgmlP829uIyIKR4wF02R+f0K4lM=;
 b=tYA6CbAamzRlqiXs2Rsh7tVkFTg9TSPIaX6+pPTgz2rkP0FgmAqZq1TeDfR0/H9Eck
 DZpV8a47DLAJzun4ghTzPTzcJ5Gp35Dr2L2FeRtMzmpTyq19yuVF+mEwUwf66usqerQZ
 Qjn1rm/5DpiyZjAXz/EvkbrhYQmRDk0OgkVzcIthelW9RMuxjguE2DQsaS/ofLsqM3r7
 XYKwn0lzKBZSwBKxdVnIOnWrdYl10Yv2QBbHs/lSF8NdnmBkrIAXHBHHpz31wJuwW6zG
 q42p1ZKcArQr8BW3T32xMtHnGFlSI63xs65uB353M2F7IuQnRl3YN8yCRRw8kFy32MH6
 /vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WCVpTFHNU2AiGKjuIgmlP829uIyIKR4wF02R+f0K4lM=;
 b=ASWCQrqS5R75jb0CTgmybnQucZJcGAtJaEiKXpyr1RPXvb3vtrjAUjGSvdre5y1qyk
 1R4eFQ75OR/2w2kIWA1uojJIyE/2pgGOLVvf1GFJZYobpnkF6Qp97LwSrA+c14qt7JSc
 hdkaX+C701S/fCQ01STLSAs4WLeDs/ribzCz882Lm4RY0rzuHg6SAfVODDId8fuvldtI
 lUWJ+K0h/+tQ0RC4MVvfvVZS5tLWu7mBUOljbW8vh8eyjGUmJKFwTKQNIwr/5tSIbc1z
 4fGWH0lhgNCsVEry6340awfLCYnoCg/ZaoEKZ6pPSbNmWFRXHHoCk2wbz1yLA1nd8S86
 P0YA==
X-Gm-Message-State: AOAM532FtaSvq1qh3+YcrFLbF2u81v/LqgNIVkI/DQCj3qL6lLZSnmF7
 w3hGpl1Qkvin1DwhhEhgBXoHgFfZAsf3xhuNXpDCow==
X-Google-Smtp-Source: ABdhPJw8U+dsjmFQ7iR1r8xxyiVRlrFMkVgCzlhDBRI/ooRFRj7DOdbZ8ESnGxZfxzIaRTxeW+CuzJ8TH8jBwVdf97Y=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr2435760ejb.382.1601038578084; 
 Fri, 25 Sep 2020 05:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200925120546.1905386-1-pbonzini@redhat.com>
In-Reply-To: <20200925120546.1905386-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 13:56:07 +0100
Message-ID: <CAFEAcA8WNo867iFA6QY2YqO0vQsnCqSaoxRWCWZS3PrTc=kp-w@mail.gmail.com>
Subject: Re: [PULL v4 00/92] Misc patches for 2020-09-24
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
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

On Fri, 25 Sep 2020 at 13:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 8c1c07929feae876202ba26f07a540c5115c18=
cd:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2020-09-24 18:48:45 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7e8ded353c7d0602fda6614249f3a4781515dd8a:
>
>   hw/net/can: Correct Kconfig dependencies (2020-09-25 08:04:32 -0400)
>
> ----------------------------------------------------------------
> * SCSI fix (Dmitry, Li Feng, Li Qiang)
> * memory API fixes (Eduardo)
> * removal of deprecated '-numa node', 'cpu-add', '-smp' (Igor)
> * ACPI fix for VMBus (Jon)
> * relocatable install (myself)
> * always remove docker containers (myself)
> * serial cleanups (Philippe)
> * vmware cpuid leaf for tsc and apic frequency (Sunil)
> * KVM_FEATURE_ASYNC_PF_INT support (Vitaly)
> * i386 XSAVE bugfix (Xiaoyao)
> * QOM developer documentation in docs/devel (Eduardo)
> * new checkpatch tests (Dov)
> * x86_64 syscall fix (Douglas)
> * interrupt-based APF fix (Vitaly)
> * always create kvmclock (Vitaly)
> * fix bios-tables-test (Eduardo)
> * KVM PV features cleanup (myself)
> * CAN FD (Pavel)
>
> meson:
> * fixes (Marc-Andr=C3=A9, Max, Stefan, Alexander, myself)
> * moved libmpathpersist, cocoa, malloc tests (myself)
> * support for 0.56 introspected test dependencies (myself)

This still fails with the same clang linker PIE reloc errors.

thanks
-- PMM


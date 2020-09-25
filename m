Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED89CC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4587921D91
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 10:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgOJMDcx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4587921D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLlFT-0000Ya-3A
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 06:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLlER-0008Dm-Ro
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:45:40 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:42529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLlEP-0002gX-Ay
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 06:45:39 -0400
Received: by mail-ej1-x633.google.com with SMTP id q13so2965337ejo.9
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tlFRTrff3DMXp6nWx34WssSCkTnG2X1sa/2Rz/Ooul8=;
 b=LgOJMDcxhuPyj02Bmp4unQn/eKrmLx8JG/dW831w/z8eEC9V9j0n3PjHfwKMy8JAAN
 YW3W1N0eWqgXxJakPdiBwRtHx0fNZjlD+NbkvFUUeqUDI5hot4lFHcYux3Ze+iFRpxWi
 +FImTBfmiDAo2wUzbUGqCe/KH1wa1tGw5LFQl6NXnPRDbpyOOtnQjzhEhRViW6+55hTs
 i6kXb666jOBx12p5hb8d1+oMrq1x9LrJ8Ph9yj9vbRg423J0u9bfFe3s9vWnRE3bWc80
 AmVBQexzBQntXw+abo3HbGh+5jM6pw+/hvGnwhA9A+6vxjy+iWsB2GyD9LsmMEuYZiCD
 K1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tlFRTrff3DMXp6nWx34WssSCkTnG2X1sa/2Rz/Ooul8=;
 b=DQetvPG4VNCVMdcQcG590VTF3V4ZVfRZ2sPQ11x7rNkDpl0mEX//NA40PeEtgdcdkP
 eKPSmdD4Th/HFbMkZhqUtaNp21RpysnsOzCrrYGgQ5Xm7Ej6LPzVPE67jhJo4W/hsJE/
 BiF4O+r04uosJUuZZ13/Y9goxCmSpjqfowi0ZT1HuT7a20seiU+aBiVcDFQRDW47jPzp
 ZRRz08ZAVx3nul0V0bAXrFjqHCpEoe4nb+wO4x89wH0J+NAZbz1Mg7rM+V4v4sLMhcs6
 QwCC0EYQRybFfIQSbqzLAIf9A9q1PAtdz0ziPpF2kK9uQk/WPgoNZAs92Mm4l5uaHYtX
 lwPw==
X-Gm-Message-State: AOAM533EYmQsKkJSV3G7MkmKW4UwuSF4tV5hQjbBKaRmLgxkwSVfaVT7
 nTMs4zMi3WCGaob6gfaGx+7CMgeEKKtCRpDYuBOujQ==
X-Google-Smtp-Source: ABdhPJxp6DIJdWDpXsiVhoYLwOvJtscz/nDTBGO5NmbfT0DZ5F3ZYoJuucIiDRXBeirIiq1TYr41cHpjE23QQZZw5Zw=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr2013358ejb.85.1601030735040; 
 Fri, 25 Sep 2020 03:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200925102257.1848666-1-pbonzini@redhat.com>
In-Reply-To: <20200925102257.1848666-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 11:45:24 +0100
Message-ID: <CAFEAcA-okvLfrjtvVVUWJWunzOSC8kgAEUuMM1JXciebfSJ0pg@mail.gmail.com>
Subject: Re: [PULL v2 00/92] Misc patches for 2020-09-24
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Fri, 25 Sep 2020 at 11:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
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
> for you to fetch changes up to 24c146dec201c64552b20eec5a442687b65fd93d:
>
>   hw/net/can: Correct Kconfig dependencies (2020-09-25 06:18:57 -0400)
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
> * submodule and environment CFLAGS overhaul (myself)
> * moved libmpathpersist, cocoa, malloc tests (myself)
> * support for 0.56 introspected test dependencies (myself)

 Date: Fri Sep 25 11:41:22 2020 +0100
    Signed-off-by: Philippe Mathieu-Daud=C3=83=C2=A9 <f4bug@amsat.org>
ERROR: pull request includes tag with UTF-8 error in person name

(that's "configure: Do not intent to build WHPX on 32-bit host")

(I will run the merge through the other tests to see if there's
any other issues with it.)

thanks
-- PMM


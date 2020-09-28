Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D2E2074B
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z66rwIrm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D2E2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMt28-0004yz-Fn
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMso1-0006FO-VS
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:03:08 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:33059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMsnv-0000c3-MQ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:03:00 -0400
Received: by mail-ej1-x634.google.com with SMTP id j11so8422153ejk.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 06:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DcKo509pomPpPmZQnovWnnfku4Vpqk1HscjSoQVUsZE=;
 b=Z66rwIrmWi1PHUDdm1n8dBfbah4Sg5+NrTTUBgqE00GGmg0flCzEIKWxcH3oW0LGRu
 RErQ8kgGhNbf3uiQtPEzVphdC8NHtoiJ7Vp7x7fVX37m4dyOYFVIcDweSqjVzE/bMyVJ
 IjU1z3X/vkKaatvBDOKCtQj/6YXmX+uUwzngsZ+827reQSBzFP0d8nNHMVeTV2syCTQ6
 8ihuyPtt3vfKnA4kpjuPrrF2my4Uwh+ViBC0N6T/Hrj/X7Pa1hCBu5EC5IdVKpFFGf+Z
 FmqjFSVKmzbtLcZrD3ZBLLY4mcj3Imc5mDndMRxQwpNOFbjV5xs8Pe0TsMAetJlD4Gif
 JWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DcKo509pomPpPmZQnovWnnfku4Vpqk1HscjSoQVUsZE=;
 b=FmfdCcY91L0NKCFmGzn3hNpdYM0gzauSz8JByOCdTn6aMEEmd/BRVxGunTuiUiQ3t6
 lsRO5GC6+YpzHwYyrP1QYpYrEMYh1jr6rgSqdaNeewiK1VQutGVEJVaFOpHclN+WBLYG
 apx6SZ5uCdr0qRwhg537FHjQSlrGgaxmvkSecffOOubkmexveK+XMxuHNj9FeVFxT6wl
 X8+IFfSUWHjzfanJXNfIR3lnTu91bdv52nGGksOu5KPwW6/ZkaEaJtzninN303zxMurK
 vGCnNl8oDS6h3LC+id9EHMFp+YEdk6X/FBSTvjV3q57PzWP5cW4ewJmhydPJPQFAhRDf
 5Q4Q==
X-Gm-Message-State: AOAM532Rg0q2UiJ29wtJlWc8yngg7zz3G9/9LxcM9zOyIy/RCGsIsxTI
 nPlZgc/xNSsL9T5L/OD7GBx0Xvr4xcQYCkiQ5Ee7lyGJV1RF1H9G
X-Google-Smtp-Source: ABdhPJxj6mWE5mKxaWr55hlHzwF34LjU+67GQgRec22PxEcjdCT1TrIgUv80wjaCRsgXEt7SKaW5zd32Mu04Sn2cQLQ=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr1631257ejv.56.1601298173932; 
 Mon, 28 Sep 2020 06:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200925232454.2185982-1-pbonzini@redhat.com>
In-Reply-To: <20200925232454.2185982-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 14:02:43 +0100
Message-ID: <CAFEAcA8R4oVVsCyd6o1bFyHg=g8kz-uMeC=7AuOV3ftRTKVzvg@mail.gmail.com>
Subject: Re: [PULL v7 00/87] Misc patches for 2020-09-24
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Sat, 26 Sep 2020 at 00:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
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
> for you to fetch changes up to a92d54785437140cb83d47190d5fcbc12c8ad9fc:
>
>   hw/net/can: Correct Kconfig dependencies (2020-09-25 19:01:51 -0400)
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
>
> ----------------------------------------------------------------

This version has new meson warnings:
Library util found: YES
Dependency pixman-1 found: YES 0.38.4 (cached)
Library aio found: YES
Dependency zlib found: YES 1.2.11 (cached)
Dependency xkbcommon found: YES 0.10.0 (cached)
Library rt found: YES

../../meson.build:274:3: ERROR: Unknown variable "have_softmmu".

A full log can be found at /home/pm/qemu/build/all/meson-logs/meson-log.txt
/usr/bin/python3 /home/pm/qemu/meson/meson.py --internal exe --capture
qemu-version.h -- /home/pm/qemu/scripts/qemu-version.sh /home/pm/qemu
'' 5.1.50 && if test -e qemu-version.h; then printf '%s\n'
qemu-version.h > qemu-version.h.stamp; fi
MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
G_TEST_SRCDIR=3D/home/pm/qemu/tests
G_TEST_BUILDDIR=3D/home/pm/qemu/build/all/tests tests/check-block-qdict
--tap -k


(Side question: can we make errors from Meson cause the build to fail?)

thanks
-- PMM


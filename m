Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA94C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F592074B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ueZvpjBG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F592074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLvqh-0000uj-E3
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 18:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLvpQ-0000TM-Ed
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:04:32 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:38394)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLvpM-0006tt-OY
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:04:31 -0400
Received: by mail-ed1-x52f.google.com with SMTP id c8so4060809edv.5
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 15:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yG0e0qFJzFjFg1wvozInXCMKoskixBF8iD4ScRIlFYw=;
 b=ueZvpjBG/SllWPPhN6ngyzz+fjQn73vlTSTAJu6ufKBCUikVMIkHW5mOoA+kTBXaNR
 AtYB5qWnV+RP+ggh1VMATD7H+jjjPHh9bSCaoLUrd+J4RsYhygcYY0mzfSpiB/QNhZud
 jU5TQ08Yxy/vJKBIay+R1fIE5e8KjanopcxQU9tgSfsFpZNlJ0pZGEC7k0RfM4fePE9m
 dWp2y0Rnj4T1peaerH3osqZTQXSVG9XtyhbHkve+8ATE2m+p8GvPS5ar8IuLz9hkJoBr
 GilZuBigHM7LWgZGudJmHMPSXIKlAJjfKkODixeKQ8hj93OA7eoDWlA6s24ne3ESy3uw
 wD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yG0e0qFJzFjFg1wvozInXCMKoskixBF8iD4ScRIlFYw=;
 b=s70prlhVWsfd5pVu82AsVVPW6IaTMzrnvOfq+r49Sy17sYcjCfosSXF9qX5EGEwVsB
 yHvM0OYvSpYuP3y0UmNhX9VjWeLvCLGZsjQ0sqTs5sT7gGsNyqfKIsgh0hqgEfG8f/0i
 4TKEj/kiT/d2dKEttB8r5pJts8yTLZXChEtVzlbIfWPjveGqhg/uxY4wU490TDktn9Ta
 afAB0sbz3S+6CW18m5yYfnWcQZFe3LdYZNtcr550FSNhsu8fpmS4Td3I4ikcUcRomQVx
 MnzRSif8BGokb7ErKczcjnczUvjXh4Nl48vdlJOT5Yn2mKmUzkOMsMzqFA6bhcG+eeUo
 m/Zg==
X-Gm-Message-State: AOAM533FpUMHvU55BUu0ggEpMKDBhmLHjfrKV0XHQod1TQb8W81v0KvX
 2SoAEmj8oC5tXRfr4BdksQ+cs/7OBvG7s4fWskd1+g==
X-Google-Smtp-Source: ABdhPJzOYb1BI05yR3uwQCwvoDKF9810a6NMlpXTZx3EWdEWDmakjqgu53T/KP1/cCgjJlKr+VRa6kFcVG0o6oBXMmU=
X-Received: by 2002:a05:6402:202a:: with SMTP id
 ay10mr3768863edb.36.1601071466671; 
 Fri, 25 Sep 2020 15:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200925194737.2148096-1-pbonzini@redhat.com>
In-Reply-To: <20200925194737.2148096-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 23:04:15 +0100
Message-ID: <CAFEAcA8d9upaWzQp_Ux9jaTBWOS1C0Xf_8ibDh5vcyB56+PFrA@mail.gmail.com>
Subject: Re: [PULL v6 00/87] Misc patches for 2020-09-24
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 25 Sep 2020 at 20:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
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
> for you to fetch changes up to f19fc40acf2a4481f56165228f788f322d947f60:
>
>   hw/net/can: Correct Kconfig dependencies (2020-09-25 15:21:30 -0400)
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

This version fails on the BSDs:

Library util found: YES
Found pkg-config: /usr/local/bin/pkg-config (1.7.3)
Run-time dependency pixman-1 found: YES 0.40.0
Library pam found: YES
Library aio found: NO
Run-time dependency zlib found: YES 1.2.10
Run-time dependency xkbcommon found: YES 0.10.0
Library rt found: YES

../src/meson.build:274:3: ERROR: Unknown variable "target_os".

A full log can be found at
/usr/home/qemu/qemu-test.5nusiE/build/meson-logs/meson-log.txt

ERROR: meson setup failed

Windows crossbuild produces the meson.build error but then
somehow proceeds to link executables and succeed anyway(?!) :

C++ compiler for the host machine: i686-w64-mingw32.shared-g++ (gcc
5.5.0 "i686-w64-mingw32.shared-g++ (GCC) 5.5.0")
C++ linker for the host machine: i686-w64-mingw32.shared-g++ ld.bfd 2.28
Library m found: YES
Library util found: NO
Library ws2_32 found: YES
Library winmm found: YES
Windows resource compiler: GNU windres (GNU Binutils) 2.28
Dependency pixman-1 found: YES 0.33.6 (cached)
Library aio found: NO
Dependency zlib found: YES 1.2.11 (cached)
Found pkg-config: /usr/lib/mxe/usr/bin/i686-w64-mingw32.shared-pkg-config (=
0.28)
Run-time dependency xkbcommon found: NO (tried pkgconfig)
Library rt found: NO

../../meson.build:274:3: ERROR: Unknown variable "target_os".

A full log can be found at
/home/petmay01/qemu-for-merges/build/w32/meson-logs/meson-log.txt
Generating qemu-version.h with a meson_exe.py custom command
Compiling C object libqemu-i386-softmmu.fa.p/target_i386_cpu.c.obj
Compiling C object libqemu-x86_64-softmmu.fa.p/target_i386_cpu.c.obj
Linking target qemu-system-i386.exe
Linking target qemu-system-i386w.exe
Linking target qemu-system-x86_64.exe
Linking target qemu-system-x86_64w.exe
make: Leaving directory '/home/petmay01/qemu-for-merges/build/w32'
OK DONE windows crossbuilds

thanks
-- PMM


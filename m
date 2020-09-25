Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB23C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:45:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0D92083B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 18:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AD51bmHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0D92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLsiT-00052F-9B
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 14:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLshQ-0004DW-Gj
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:44:04 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:33389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLshO-0008NK-Kt
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 14:44:04 -0400
Received: by mail-ej1-x636.google.com with SMTP id j11so5031333ejk.0
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NfU6OGrSH0XZJ5HxkZiNjldD/02xqGKZxR7aWz+Q3Gg=;
 b=AD51bmHH8F7uYR1kzDRnXUNjXZ1LJcfwgb9MwHU485OEbIiNkSctkwjS2AqsIXTmG/
 q631Z7+l75DNdu0ohqj0ARdzQqgPDn5oDmMuUSrW53Hj0540x/D3e1ANOCRUrAhoqnhe
 coQqqzv7hRyFxDQfpgUFa+0OoMv9IHVkxmLZfxVNiOisv5ulLF2cjPuhneuAQcXgQpD9
 Y3vGVlBwZGNrVCydIhlBNENLcOAvvcEfxvRFX4gapdDpF382uWzlM4JFtuGuJ6k9MDq+
 9yTfj9BT5rVTCWCmoW1L/gkA9o3MuzcGcMI2f6Y8eI9BTnK0CaXgy1UJm4/eLp5zk89m
 QZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NfU6OGrSH0XZJ5HxkZiNjldD/02xqGKZxR7aWz+Q3Gg=;
 b=XpNMo3Tmruwyt0vQDsgjvgs3qN7XIjGgzbT3TzD9igfK2ibrikC8WJGAJOs7B80S5o
 jEX+gUbfd8QY+fiRZE79cP0FjLniLuQ3d0gMk02Vnt9LujAcQpXBDpuAdev1xS85VHko
 87xBGVf48xOFEq5zjEyl/ZCz5VJW8o6pTNh07DCLhRZVM7wn56CZJI8bCzC9yItORJsq
 JWZz/E+EvqtqE/8guc/qoXr3rj9SK8cMPmYwSqehEWcAwSybmnQh/JjpI9798a6wmDdZ
 iFHUoQGIaaLV6BIu3aAvvp6FCqj4s4eSyoUYXok2MP9gbNLWbtNb0nssxq1m57AwrRUc
 WSPQ==
X-Gm-Message-State: AOAM532E8wOshDNJS0fTMk60h8D7ihP5MbjS6Os1+C6UMkQvxbptYZ5h
 PJxply9hv5buJ1RDpMC3Yeu9Tt/bmdKWnlHCKzL3sA==
X-Google-Smtp-Source: ABdhPJxiPy1bgm4jE2uF1Gt+YgzaJOmjnKZZ+HsDzSFWAqGB6pDlczP/1NU14zZo4JTLSFZ2t7U1BZIOqCGbO/Qh254=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr4042366ejk.250.1601059441064; 
 Fri, 25 Sep 2020 11:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200925130630.1922528-1-pbonzini@redhat.com>
In-Reply-To: <20200925130630.1922528-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 19:43:50 +0100
Message-ID: <CAFEAcA_-cNmt-sY3nqnGkpUqET86M6-82rf-Uv3QkwCR14kYsw@mail.gmail.com>
Subject: Re: [PULL v5 00/87] Misc patches for 2020-09-24
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Fri, 25 Sep 2020 at 14:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
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
> for you to fetch changes up to e627cc59f0ad4949c9635b72a3149c9fabc044e8:
>
>   hw/net/can: Correct Kconfig dependencies (2020-09-25 09:04:23 -0400)
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

This passes all the tests, but generates some new warnings:

In the all-linux-static build:

Library rt found: YES
Found pkg-config: /usr/bin/pkg-config (0.29.1)
WARNING: Static library 'udev' not found for dependency 'libudev', may
not be statically linked
Run-time dependency libudev found: YES 237
Library devmapper found: NO

That looks like it's gone wrong -- if we're doing a static
build and it can't find the static library that means the
dependency should be a "NO", not "YES", shouldn't it ?

Also, lots of these during 'make check' on the x86-64 Linux build:

qemu-system-i386: warning: host doesn't support requested feature:
CPUID.40000001H:EAX.kvm-asyncpf-int [bit 14]

thanks
-- PMM


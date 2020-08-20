Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC935C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1862075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPTK7+xz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1862075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8lyF-0005q6-QO
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8lxK-0004zP-1m
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:54:18 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:40688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8lxI-0004If-BZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:54:17 -0400
Received: by mail-ed1-x52a.google.com with SMTP id w2so1566241edv.7
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Z7bvJwQZ1JGfBefnmYtcNr8q+mfUHAwdNt+ltSmeMk=;
 b=EPTK7+xzyUhfGnfj7c4b38DLxXreyj/55vVO26yEXhMqkxgCCz3S+iqMg7hnDPUb+J
 f+GRi65gJf4BLWmMMdfI1Od0EtlR7oMPgzWlVIilsBJmLPO2A0Wx/y0t82jRYUxdrhl8
 f1/hEmVQhd5so/EYfqZXY/oKKuUd4Hugd5bneyco9zrCoI5AKRfJQKAWgHWrVC+A5GIN
 ELymvVHZaIgbjLWlbeknQBY6GVt4biz29JemqHYtffdtkxzoDasoEqZNWhEPY65nQLNt
 WzHzqf7pnfPXDIc7moAe9F9INzQkoHK0H3Ln4RX7uRFpO4we2ROhkqeA0SB6xgzMUXiV
 1E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Z7bvJwQZ1JGfBefnmYtcNr8q+mfUHAwdNt+ltSmeMk=;
 b=g71C0B7KCcAWpZ+gCYIbxyH/HrI6u3m4thZRCT1+20I4yUWLZn+QtEYRqmzR67jrQA
 3Q0b4BDaLOIWh3lc0u7XgQd4FqA5Jh1OQSeVQJL0sEA54gbIB38OLcH9J5MGot5ms5bu
 2n0gq02U99lgankO8/Gvm2fTKDZw+r5wPMb8fr5ucIYqV0J4PxB5vQgnILqdSFBquQst
 jvLJj/2YEfYgplqLKLbxCaWrptYbTg8RkFaV3qheqOoePZgsHgkq5wnDdgAomAgpHZOR
 5r6W90k/RdUKdwU8S5iUPynb3+uJnMHBZBrCptSXWYJEG280Ccm2+sksjZpYiye82L3r
 9/ZA==
X-Gm-Message-State: AOAM533y4IkOwJs8SHTLbEBGiV746enUFySGVkOqQ7wVkKPcWAJnId/y
 Hgt9XTB0Qo0q0zpwD1Wg7KPBv1BtFAfs8qi0L0ngJQ==
X-Google-Smtp-Source: ABdhPJwxT6d37jW6WwPFSt5UuzN3aSRswvdI2gBDT51LMmhIvmKITEk609zBn4M00/DMJqQglfMOnKgEN3RzmJw38eY=
X-Received: by 2002:a05:6402:8cb:: with SMTP id
 d11mr3387446edz.100.1597935254578; 
 Thu, 20 Aug 2020 07:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200819213203.17876-1-pbonzini@redhat.com>
 <CAFEAcA86m9N5ceYB+Nu965Se=qyZ_3W-Cn76Qc+Dd75hEApz=w@mail.gmail.com>
 <446a210a-7e88-ab9b-05f4-6b0ffabf97c6@redhat.com>
In-Reply-To: <446a210a-7e88-ab9b-05f4-6b0ffabf97c6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Aug 2020 15:54:03 +0100
Message-ID: <CAFEAcA8chPqS0keyGv0vBgNgacnMo95gA3LZDU2QfmteQ=4UZg@mail.gmail.com>
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 20 Aug 2020 at 12:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 20/08/20 12:33, Peter Maydell wrote:
> > 'make check' still fails for the all-linux-static config, this
> > time for a different reason:
> >
> > make: *** No rule to make target 'check-qtest', needed by 'check'. Stop.
>
> Oh, there are two "check:" rules.
>
> I pushed again the tag

For the all-linux-static build, Meson emits these WARNING lines:

Configuring ninjatool using configuration
Library m found: YES
Library util found: YES
Library aio found: YES
Library rt found: YES
Found pkg-config: /usr/bin/pkg-config (0.29.1)
WARNING: Static library 'asound' not found for dependency 'sdl2', may
not be statically linked
WARNING: Static library 'pulse-simple' not found for dependency
'sdl2', may not be statically linked
WARNING: Static library 'pulse' not found for dependency 'sdl2', may
not be statically linked
WARNING: Static library 'sndio' not found for dependency 'sdl2', may
not be statically linked
WARNING: Static library 'wayland-egl' not found for dependency 'sdl2',
may not be statically linked
WARNING: Static library 'wayland-client' not found for dependency
'sdl2', may not be statically linked
WARNING: Static library 'wayland-cursor' not found for dependency
'sdl2', may not be statically linked
Run-time dependency sdl2 found: YES 2.0.8
Found CMake: /usr/bin/cmake (3.10.2)
Run-time dependency sdl-image found: NO (tried pkgconfig and cmake)
Run-time dependency libpng found: YES 1.6.34


What are they for, and can they be suppressed ?

thanks
-- PMM


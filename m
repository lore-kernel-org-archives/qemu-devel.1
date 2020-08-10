Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FFAC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31752073A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYZobjX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31752073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k57dC-00079O-3D
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k57cJ-0006cE-Ar
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:13:31 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k57cG-0006ju-Az
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:13:30 -0400
Received: by mail-oi1-x243.google.com with SMTP id l204so8844339oib.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CRwOwKJKDkYAIiB8CZjAApwtxLl8AikI4tNIGxc+Pic=;
 b=RYZobjX1Nd17wENYmW7kpo1A40yhU8/h6xFKVOyMdb+h6+vO0ZLQaw6v0xNRSenKDi
 yPmXtCs+ehAkJlMWzC2nEHNQFMdIidkuRdKjDjcXGZLGW6vPuhWv4cMfJR9pDgsi7OG5
 aFNWQr9fj5W4NRaK6XprbJhg28OO16ljVdQbLxiBIqKTWibEqk8RigO1VfYuOeNlgZgc
 E7WHmIin3SunUSY7eePAFkNP5XbnhWUA7tAASwpiEV8zSCVrCZamAnT0TRyx4CdW1xTa
 1eKqpsUS5zEfYgCa+GTsTwyEWS244vR0GwPDEFzPn/ndYoCPXjlcJOyGiTup4siHoCh0
 tFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CRwOwKJKDkYAIiB8CZjAApwtxLl8AikI4tNIGxc+Pic=;
 b=s8TbALY8D0ulXIJnXa/H2GFOqGVvTUs/lpylxfu3LZ/2LGEFw+8qfUkfJR1WM5kmnK
 T9OL5lII2ss0+oeClUDqZhNndIWh7PRanAT0yRBMNlvq1UM5mPrEhbOoCE85QOSkhT2t
 AfA5TB150Ns2VdyYMFgAK0oqAh0jyvCE4MHoy01Hy9lF6uvocNK6gRws/saQqri4wYsa
 Txd8pVUav2Y/dSyDeZYx0YSiXz5PC/s+uAJiX26mFpXUUvzmxSkBTO18R8amfv90yDKg
 ncoDVp7jM068Ep1BiYeT1pZ+Nmj4cTiOJC9J3Q350otfclxcnY29YnNDyTmfqfUerhHJ
 1ouA==
X-Gm-Message-State: AOAM531BDxA52UcBNaDH+okgBYLJtEFLc7XLQoGmICTfmZKS14Kdm9dS
 CGyVs2H/2wAY+rLxwUlzj0HL4ByyNJWI2vfhzIvmTQ==
X-Google-Smtp-Source: ABdhPJyreYL4LuHL19i+5hplvWjACDoYrbDBelaH4NP6tXkZV5zK6c46Lx43gux9MBI/MQo8ZmgwXBNmgci/9+glLWQ=
X-Received: by 2002:aca:5703:: with SMTP id l3mr616505oib.48.1597065206483;
 Mon, 10 Aug 2020 06:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200810092941.154911-1-pbonzini@redhat.com>
In-Reply-To: <20200810092941.154911-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 14:13:14 +0100
Message-ID: <CAFEAcA9TNhmarLD93KOpTCKiUwcrS5jFp96=O6TTS0Ot4F3V6g@mail.gmail.com>
Subject: Re: [PATCH for-5.1 v2] acceptance: use stable URLs for the Debian and
 Ubuntu installer
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 10:29, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The kernel and initrd hashes seem to have changed for the Bionic
> aarch64 installer, causing BootLinuxConsole.test_aarch64_xlnx_versal_virt
> to fail.  Correct the paths to use the previous binaries instead of
> the latest.  Do the same for the Lenny alpha installer for
> consistency, even though those are unlikely to change.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I've listed this on the Planning wiki page for the 5.1
release, but I don't think I want to roll an rc4 for it
if we don't need to for some other reason. (The
"block-copy feature can assert on unaligned images" issue
which is the only other one listed is also in the "doesn't
justify an rc4' bucket.)

thanks
-- PMM


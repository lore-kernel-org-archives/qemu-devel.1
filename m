Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31937C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586E8221FB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rDPWdgKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586E8221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXWMH-0008Jj-4F
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 17:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXWKw-0007r1-ID
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:16:58 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:46867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXWKu-0003P3-EI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:16:57 -0400
Received: by mail-ed1-x52d.google.com with SMTP id t11so336272edj.13
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9D/fc0zpPXzN1Od8PGJULxt44Z7QqmpM/OzHfJ5+w8o=;
 b=rDPWdgKwEpYTPMdiveKwHWM0qHOAVXRSR1rFEkKCSwI7UF6oaBEg/NCg6Z9Z7tSKa1
 TmeDe6G6XK4bIZ9mz3VzWSWxqKWbcBwGuKvISE3sZwpl9RF4J1iOyY3GWuN9ZAV7pwZg
 5kvHt+VQBZEYMVCLMLVKPSpsTWJgJBwS5ECf6FdVaDqwMF559LVnt9GzgYfRmtnifNFM
 D18IJa/uvltUyJNyv8cgb6xthZFPS7ExHr5ZQYoFLSfuTKflCr9PZX90LwNNAho2Kt9B
 Bf88AYaAIVH6iskNDJ1bkFP6F8pX46zZdYcsP4ieBXufsrECOV/2SZUuRXV1lg2qVot9
 6ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9D/fc0zpPXzN1Od8PGJULxt44Z7QqmpM/OzHfJ5+w8o=;
 b=TiBz+ci1ptUVPv860aiH/CSSyZmsM/C31c7Vo059mmDXlO/lnxaOGfFI5wDceqCuwP
 h1I9IhhCFM3dR2Kw9tao8p/P3FVtblQ2v1XizjN3mB2BII702F/ImRLEAx4QwGJU+NhQ
 D6q0duUSBzBEsrLc01NsLl5WSLI7Ck1VKnyE4nOUMvmpQLdiSNVYjkE1aXIjX/mNLzSc
 epMFhmtJ+2eQJSmi3z5E+uvLVkLdedl+ZH9aTkeMBkS/9SESg9cG3ywNen2AbykU9NW6
 OwghOHt0kneuQwYoIwIfdoQESeUWfjO95slzq9+RbOk1uEHmRTzIOKeWi+NGb0YSXLkU
 Q5HA==
X-Gm-Message-State: AOAM531e0a5Mp8MJEgGBp5Q7H6xY+AG1QLVmbaCHT0YqIxird8Lb+6Nk
 1TUjOJbyPc0G5hUsU8QtmQ9bAvTjqoh2Wu7qpgu14g==
X-Google-Smtp-Source: ABdhPJwczRFAKMY3g0aobvVP8IQurlYA9St53R/ltqLPQn243yvE2X9GVp32FfKNLy1FS5hNUKzW6gbmtbc5ct6CABs=
X-Received: by 2002:a50:f41a:: with SMTP id r26mr4244907edm.251.1603833414161; 
 Tue, 27 Oct 2020 14:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <F25EAD5D-59A9-44D0-A3B3-455A725BCA14@gmx.de>
In-Reply-To: <F25EAD5D-59A9-44D0-A3B3-455A725BCA14@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2020 21:16:43 +0000
Message-ID: <CAFEAcA_oriYP9E6Yvi47a62=6y_OM9OuBgvfG6u3QSLArfNJdQ@mail.gmail.com>
Subject: Re: QEMU and kvm on big.LITTLE aarch64
To: Michal Schulz <michal.schulz@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 27 Oct 2020 at 20:28, Michal Schulz <michal.schulz@gmx.de> wrote:
> Recently I have attempted to to run qemu-system-aarch64, version 5.1.0, o=
n an aarch64 machine. It is Pinebook Pro with RK3399 big.LITTLE SOC, runnin=
g Manjaro linux, kernel version 5.9.1-3. When using tcg everything works ju=
st fine, but as slow as I would expect it. In order to give it some speed I=
=E2=80=99ve attempted to enable kvm there. Unfortunately, all I get is foll=
owing:
>
> # qemu-system-aarch64 -M raspi3 -enable kvm
> qmeu-system-aarch64: /build/qemu/src/qemu-5.1.0/exec.c:850: cpu_address_s=
pace_init: Assertion `aside =3D=3D 0 || !kvm_enabled()` failed.

This is an unhelpful message, so apologies for that, but the underlying
cause is that the raspi3 machine model doesn't support KVM. You need to
use the 'virt' model instead if you want to use KVM.

(This is because the raspi3 machine needs to use a guest CPU
which emulates EL3/TrustZone and EL2/Virtualization; KVM can't
emulate CPUs with those features.)

> Of course, KVM is enabled in linux kernel. Please note that use of '-cpu =
host' parameter does not change anything. Also, attempt to define the CPU a=
ffinity for qemu using taskset tool has no influence on this behaviour.

You will need to ensure (via taskset or otherwise) that all
the threads for vCPUs end up on the same kind of CPU (if you
don't do that then you'll run into that problem once you try
with the 'virt' board, probably as a "kvm_init_vcpu failed" error).

thanks
-- PMM


Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D03C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C6C206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMGRcftJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C6C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiJOa-0002aL-3N
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41932)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiJLb-0000yQ-9w
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiJLX-0002pV-8C
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:01:25 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiJLV-0002jt-9q
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:01:21 -0400
Received: by mail-oi1-x243.google.com with SMTP id w196so13099395oie.7
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cqwgMTTgDEm/b0NIbMgi8rNGvxIw/MePJRH6fknCQjk=;
 b=zMGRcftJCYDyiMy3dVyGKxG6vha9EQTuQfKvNTea6EUz8hU9bKKL8c0amR4N+Wy8Zc
 1WzLYrk77wWjW0T361oAmNDy8sNLU+DMlFSJmGp+Ndg+N/KvDmtu0OmM3EGmf9jhS12Y
 FPu4AGFw7r0CpBERfkgKbRIno7pjPJCa68e5dU2GX5sz5StXQCNweIAzuC/cAJ4MzlgL
 btgtqNGfhXsyUEjLfgd7rWogBRdZhWKMoPUZULR09iiWN9H8c4qTq6mKtOzYehVD6cXQ
 DXpeID+ekFPVlpV8ulLnadtlvQ7gm/xyFydPW5TLNIp6FfXLdxuWVyH1H88omAIW7JY7
 V7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cqwgMTTgDEm/b0NIbMgi8rNGvxIw/MePJRH6fknCQjk=;
 b=ZEAXnoRkQe5Fa3HQDCWaYQHgbx9hFHBKGk34CgsJ6U/7YrNiJWRUPlwZJJuHNHXS2o
 1e3sxjo27Cw15bgYkTGFawjVf/Ejvo2tvot5HXY6KGUMfE6kDaX9N4NfMMjvoLA/ikmw
 42zaRNUQlaZ8C2J9z777u0HtbuNkpBiuAHs0yZNdrAM4TaGoPkB9kssfQSLIt8mv3nEr
 ZfK9G3bQAbi/IZrgr3GTHgSci7l4Eu19OBWhY928uU/IVPaiQ8PdwfICJkb52GfEbZUi
 H8e5URZqbfnMbjEphoFNxVo5oL/4yc/qTIkq/H//Y+FAyX5bcLiv0Dm9FCdy98K/pPcw
 ai1Q==
X-Gm-Message-State: APjAAAXSnMbZSbuUnMXtXYvA7qLE2T66XwH+vzKeKZ7cyI6+9koQJgyc
 EdDQhnVtZRMt3Hb2vEyLyFpyCt29Ywt7K9z12OfBeQ==
X-Google-Smtp-Source: APXvYqzcqBiLEx5yGkdB6sw872UZ3nETBgJKOfoap4Iuaxqr0qdqfzzu4MncEGbDi8xz80l/QMGIZhkFx0nmnHu5eo0=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr2988956oij.98.1562076079127; 
 Tue, 02 Jul 2019 07:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190701194942.10092-1-philmd@redhat.com>
 <20190701194942.10092-4-philmd@redhat.com>
In-Reply-To: <20190701194942.10092-4-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 15:01:08 +0100
Message-ID: <CAFEAcA99QK7u+Rev5C9Xb_vmnGSZvx9EO+8D_fFB1qFmiMejcA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v4 3/8] target/arm/helper: Move M profile
 routines to m_helper.c
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
Cc: Yang Zhong <yang.zhong@intel.com>, Andrew Jones <drjones@redhat.com>,
 Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 20:50, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> In preparation for supporting TCG disablement on ARM, we move most
> of TCG related v7m/v8m helpers and APIs into their own file.
>
> Note: It is easier to review this commit using the 'histogram'
>       diff algorithm:
>
>     $ git diff --diff-algorithm=3Dhistogram ...
>   or
>     $ git diff --histogram ...
>
> Suggested-by: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> patch generated with git diff --histogram.
>
> v4: rebased
> ---
>  target/arm/Makefile.objs |    1 +
>  target/arm/helper.c      | 2661 +------------------------------------
>  target/arm/m_helper.c    | 2676 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2681 insertions(+), 2657 deletions(-)
>  create mode 100644 target/arm/m_helper.c

This patch doesn't compile:

>
> -hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
> -                                         MemTxAttrs *attrs)
> -{
> -    ARMCPU *cpu =3D ARM_CPU(cs);
> -    CPUARMState *env =3D &cpu->env;
> -    hwaddr phys_addr;
> -    target_ulong page_size;
> -    int prot;
> -    bool ret;
> -    ARMMMUFaultInfo fi =3D {};
> -    ARMMMUIdx mmu_idx =3D arm_mmu_idx(env);
> -
> -    *attrs =3D (MemTxAttrs) {};
> -
> -    ret =3D get_phys_addr(env, addr, 0, mmu_idx, &phys_addr,
> -                        attrs, &prot, &page_size, &fi, NULL);
> -
> -    if (ret) {
> -        return -1;
> -    }
> -    return phys_addr;
> -}
> -

...it deletes the definition of arm_cpu_get_phys_page_attrs_debug(),
which should stay where it is.

thanks
-- PMM


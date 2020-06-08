Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E631C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8A92072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8vuKUnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8A92072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiHBJ-0001dA-9Z
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 08:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiH6n-0007ux-1m
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:42:33 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jiH6l-0005dx-QQ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:42:32 -0400
Received: by mail-ot1-x343.google.com with SMTP id t6so4255738otk.9
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 05:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Omxn7P4FlLl3jBaswxwaVtO3d4iliVsiPp1MUZ1VqPw=;
 b=a8vuKUnjBOJC/c0w8g0OoH+5eVD12ZleykJ6aqQRDv5n+YRoTadbqkQuGNpNy4RIfQ
 rFOP/XoqFG6xvxyCMA6M5p49ZOyunVqH5B6u/6AR2ieFJe05r00kYqmUnWNfR6e+uI/Z
 ndiXWiXPckksJ07JmT3Nh9KEJAhmabJ+6ZAMj6n+al5CwTTiSuvoQjwoqe1Rd827oHKo
 BnVLyLtnwKRUwaCf38Ov31YpFfx6uhjO3bIgrQrDYoYwC6AMbbDX8COmHi5bKgE6fRS/
 Crpx9v8hf/BGhQcr3gpJwVHhGVWPEuQx70Gjz8Iv4xd5Wrknd42k+MYguiVA8jD0A/+P
 5NGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Omxn7P4FlLl3jBaswxwaVtO3d4iliVsiPp1MUZ1VqPw=;
 b=jQ5UxMWNXtLOLb0njrFn84daicjPWfD2LSGKfk42/f9GMuRJ7/wEyswszuaHkVcAjQ
 PzhcbpZyIEpU5mRKB2Nfuy39I2K4do2+owAJv3m42rjh2U8jA9mKIYjlGLYkR9eVHH3i
 /d1G3gGpFrH9iOFQNw8LNDPXr/E4qZLtGKvEW+Rxlsqo4WZbzDi38dHBktEKU2AZbYoV
 M2Q1IoE+wGGqP3GYo6mvpWf1fOKAWK4EBliGKcTpUTm3WzWpdRVXKH4NYoluOXgso0SM
 E75b6s2hND92reh93CpRMw7kq+z1A+Bk8s0xHMgHWJv4/VwxL23gtFf93XLl3dy9VbKA
 Opww==
X-Gm-Message-State: AOAM5318oMNQpYIv1L3C/GHGN0qF5anDVme3/KyQekmKpm3LtfrjeGGN
 NvcJMUCOYnL6oIGXMyVl5vtvOycE7T++91r5vcGDWw==
X-Google-Smtp-Source: ABdhPJxHXzw2llcgH/lKsuRqBlRCVoN9wrjBqW+xC1g3KljN4eAHIXGnG5+3C9i+Z5VUCQ0mNJQV3FOQteUeB6qmYNY=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr7502617oto.91.1591620150378; 
 Mon, 08 Jun 2020 05:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200604125544.GW28566@vanye>
 <20200604131802.7w4hncgq2gopbw6z@kamzik.brq.redhat.com>
 <20200604160300.GB28566@vanye>
 <CAFEAcA8MTB5VQQbMuSfkGc9JcGeawL_GUY8Pcs3yxT9kdncZJw@mail.gmail.com>
 <20200604162607.GC28566@vanye>
 <CAFEAcA-wX-vKek_Zt5hmjiQNP1utCO7yGJQPcuny1M7xncYsQg@mail.gmail.com>
 <20200608120226.GM28566@vanye>
In-Reply-To: <20200608120226.GM28566@vanye>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2020 13:42:19 +0100
Message-ID: <CAFEAcA_V3eqzxDRbn-K3C4EKCsHx5rhcMy3NiZ8Y7gB=C3HzNg@mail.gmail.com>
Subject: Re: kvm_target, QEMU_KVM_ARM_TARGET_GENERIC_V8 questions
To: Leif Lindholm <leif@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Andrew Jones <drjones@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Rob Herring <robh@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jun 2020 at 13:02, Leif Lindholm <leif@nuviainc.com> wrote:
> On Thu, Jun 04, 2020 at 19:43:06 +0100, Peter Maydell wrote:
> > https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/cpus.yaml
> > is the official list of permitted strings, incidentally.
>
> My feeling is none of the values there are appropriate (arm,armv8
> indicates ARM ltd, but not aarch64 support). I made something up for
> the RFC set. We could always send a patch adding some qemu, or
> generic, target.

arm,armv8 is the generic "for software models" target, which
sounds appropriate enough to me. Anything consuming a dtb
presumably already knows whether it's in AArch64 state. If
you needed to be able to determine that from the device tree
then I think you'd be better off defining a property for it
rather than having some kind of lookup table of "these compat
string values imply 64-bit and these others do not".

However, I've just noticed that when the kernel added this to the
CPU binding list (apparently in passing during the conversion
to yaml) in commit 672951cbd1b70a9ede6f9c6eba4ed6b726d32b03
in 2018, it documented "arm,armv8", whereas the string QEMU uses
when KVM is being used is "arm,arm-v8" with a hyphen (or
"arm,arm-v7" for 32-bit KVM), which is what we've used since
2013. So I guess we need to also add the with-a-hyphen version
to the kernel binding documentation.

thanks
-- PMM


Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B97ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:17:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EDCD2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ix2IHurV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDCD2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8Sd-0005Ex-B2
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL7g0-0001Kx-Tf
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:26:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL7fx-0001g9-Iq
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:26:55 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL7ft-0001e2-82
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:26:49 -0400
Received: by mail-oi1-x242.google.com with SMTP id i185so2480372oif.9
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RElcEQnbjI0ueX4jJU1Vkz21ksOtQkwNshLlIkIneTc=;
 b=ix2IHurVnPwWGrrF/0rNoYy0+2v9EjPCDbL1sGRALa4eHAibcEtn8UbEf+LeLYm9+x
 zUIm6ekjDXFt+2jMESoWKt4ul71NTZptw092D97EazHhizlU/B3r4P+LT8VEjNJxUBTp
 AU9DxofxODPjw9rE6syE9zSmOV/KhuZbo9wRmBjsPohV+H2huXLDIl1rO13A3P3x+VN1
 Z/VDZ97g7EVm+WxcAFrSQ93wAUCj+l3iWcv5ksjR+AUKoGkepsewJJIrk6pS+QT3skBd
 pKApKbZIFbCxpuym5xd/8xLhyTyZC1vN/uxFXNA2gFOPGppRyuOX/Kpo73CKuXHCKs20
 qLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RElcEQnbjI0ueX4jJU1Vkz21ksOtQkwNshLlIkIneTc=;
 b=o2bwbIKUvZWXl5l8+4N9k75HUiIVHpOTvQ6cuanlXhwCOpDF3gs+IzS/H0xBChEdpA
 V8O9MDsnaYF4jKVCHCWjSD3GZa6tEqfT52+WbH9gU1k2lz3qNv3Wd5PfYSSVT3vnlHmq
 sYSFXEdjpk9YgWXXC/pVnz2BVGfUDpGKSVHKJXYk0ItRDZTLkJMQcYviYCuMU8cBuGQO
 QLAA09MfS4tan27Q5lcZy04RTL3Z2aUgdSbrlajyfAb+6SZIAH1TkueXmtL574elPREv
 jJF5w+Me9ho5b7Iip5Oo24hQv8FHwfjxhmz2kmDEWdzncYXGFa4ZNmK2xNvcBGtEAUIt
 ZmAg==
X-Gm-Message-State: APjAAAVQIzVE2BoCLuR2ZzOgle943Vpqfy+VYApguRhFbUkhcckubxkJ
 dAOQP2qZKmWae6Kc6/SV9UBGZup3OzMbnjuWs+TsNA==
X-Google-Smtp-Source: APXvYqzsW/exCzt/L7Qy9hZJh8SProUq8umB3HFWxMYZe1cGwxmP0MtXLfjQh1aouzW/HW0D9mSHjG4H+tkOmBloWTE=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr3587184oia.48.1571326006505; 
 Thu, 17 Oct 2019 08:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191011155546.14342-1-richard.henderson@linaro.org>
In-Reply-To: <20191011155546.14342-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 16:26:35 +0100
Message-ID: <CAFEAcA_fmQKOk8k=Mo7MvuKvAq9Zb90xtQ0RdaxyMdLGZUwY0Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 16:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Richard Henderson (20):
>   target/arm: Split out rebuild_hflags_common
>   target/arm: Split out rebuild_hflags_a64
>   target/arm: Split out rebuild_hflags_common_32
>   target/arm: Split arm_cpu_data_is_big_endian
>   target/arm: Split out rebuild_hflags_m32
>   target/arm: Reduce tests vs M-profile in cpu_get_tb_cpu_state
>   target/arm: Split out rebuild_hflags_a32
>   target/arm: Split out rebuild_hflags_aprofile
>   target/arm: Hoist XSCALE_CPAR, VECLEN, VECSTRIDE in
>     cpu_get_tb_cpu_state
>   target/arm: Simplify set of PSTATE_SS in cpu_get_tb_cpu_state
>   target/arm: Hoist computation of TBFLAG_A32.VFPEN
>   target/arm: Add arm_rebuild_hflags
>   target/arm: Split out arm_mmu_idx_el
>   target/arm: Hoist store to cs_base in cpu_get_tb_cpu_state
>   target/arm: Add HELPER(rebuild_hflags_{a32,a64,m32})
>   target/arm: Rebuild hflags at EL changes
>   target/arm: Rebuild hflags at MSR writes
>   target/arm: Rebuild hflags at CPSR writes
>   target/arm: Rebuild hflags for M-profile.
>   target/arm: Rely on hflags correct in cpu_get_tb_cpu_state

Don't we also need to do something to rebuild the hflags
for M-profile writes to the memory mapped system registers?
For instance rebuild_hflags_m32() bakes in state which
cares about env->v7m.ccr, which is set via nvic_writel(),
but I don't see anything whereby the write to the NVIC
register triggers a rebuild of the hflags value. Maybe I
missed it?

thanks
-- PMM


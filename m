Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BE3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:56:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA16720651
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 15:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maoBEtbl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA16720651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzk1F-0001GF-3z
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 11:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hzk0H-0000pW-GQ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hzk0F-0003hS-Tn
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:55:28 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:33678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hzk0F-0003h5-K2
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 11:55:27 -0400
Received: by mail-ot1-x32c.google.com with SMTP id q20so2129607otl.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=QQIzFXLbAmAxQFl6yS5o+5njLjephfq0hRCPswHShsE=;
 b=maoBEtbltgUFYwdf6uTlRqYyiUeCsGhdYZQWidB/vZ9MRFud2C03XfoCrrtNxx1mw5
 dVfk2nM9IS8yKiY6Z4ZUU1OpzpkwULwLY7X7VSy/E25DeZxbj+FR1HCgPQOgHJH+8qTU
 /PPAstNPolsTQrfn1XEaZpK4EoeDymD8vaVqb9w2RqrosAaqsMn4UVJIg6H4V1uBqGUT
 IKYkRZbZgtQeqa4Vk1yn2niEvKcx8/10FErVH2UXmFgZ/mFdUnyFbt/sHcTETehn2Wwa
 a6AoVeZeAgSblZ/I+cje85GkCL5AlgGbRg6SjLq0SxRmseyI66zxBkowfwDSz2qdEws1
 z2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QQIzFXLbAmAxQFl6yS5o+5njLjephfq0hRCPswHShsE=;
 b=YTcnUFb2Po+JKf7M/3oXsGpTBluLe5FwWMPPjjydIOZ9LGonOeCrQ+le/8GnkTPw64
 PDB42X2RWSmmKkq4pAcgKb59phVMJ/fnmNpzhDsJNE79RyTC4i8nDvTXqGPt4tcnEcQe
 5SUGWABnDqblVbW24wQTVHD392pw34UdiuPCY2c/CMcZvg/VnuZcReLCrhLlu5PNcS5n
 zAJGg8ZWAqYFWfyWQMQHboPfNHo+3R/qU17ys+vt48C4fI4R/rKrbpWT7BMgc/qfnOGg
 jUrH02bsKjzDv13sNNtJc6wdZ8xXpBN2/5NeJHGNJJtt9onY2P1cbPIj/BhLKu1EU3wg
 xFXw==
X-Gm-Message-State: APjAAAUOVTaRr11Nb3IB9iy62PQ7CqpKkTQwbdm7K8Kzex4OnEW5u8uz
 IcNJG9r8eeHj1t8GRupLoMY4rrYSF4jj1y0MciSEPRDF
X-Google-Smtp-Source: APXvYqx9S0pA8Ml4+aakvkaApx1hrxOxMhRTaF+yfYLEATRF4VxfNcvnb8nc9rZmKU/GhKQgZeUowZeGUYj/ZA+kdAs=
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr17634897otq.221.1566230126433; 
 Mon, 19 Aug 2019 08:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190819121709.31597-1-alex.bennee@linaro.org>
In-Reply-To: <20190819121709.31597-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2019 16:55:14 +0100
Message-ID: <CAFEAcA_J6mnvipw7WsHC2YGqLjxCdVAJk8mcPceXWEJdscDyEw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32c
Subject: Re: [Qemu-devel] [PULL 00/12] softfloat header updates
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

On Mon, 19 Aug 2019 at 13:17, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit afd760539308a5524accf964107cdb1d54a059=
e3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
90816' into staging (2019-08-16 17:21:40 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-softfloat-headers-190819-=
1
>
> for you to fetch changes up to 5f8ab0004e878a6cd0f50fa8659df4a4f853eea8:
>
>   targets (various): use softfloat-helpers.h where we can (2019-08-19 12:=
07:13 +0100)
>
> ----------------------------------------------------------------
> Softfloat updates
>
>   - minor refactoring of constants
>   - drop LIT64 macro
>   - re-organise header inclusion
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (12):
>       fpu: replace LIT64 usage with UINT64_C for specialize constants
>       fpu: convert float[16/32/64]_squash_denormal to new modern style
>       fpu: use min/max values from stdint.h for integral overflow
>       fpu: replace LIT64 with UINT64_C macros
>       target/m68k: replace LIT64 with UINT64_C macros
>       fpu: remove the LIT64 macro
>       fpu: move inline helpers into a separate header
>       fpu: make softfloat-macros "self-contained"
>       fpu: rename softfloat-specialize.h -> .inc.c
>       target/mips: rationalise softfloat includes
>       target/riscv: rationalise softfloat includes
>       targets (various): use softfloat-helpers.h where we can


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM


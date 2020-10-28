Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75014C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA04824803
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 18:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0yL5PSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA04824803
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXqFT-0003Z1-MG
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 14:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXqEN-00035n-OV
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 14:31:33 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35313)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXqEK-0000fb-Rv
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 14:31:31 -0400
Received: by mail-ej1-x641.google.com with SMTP id p5so307014ejj.2
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=roBMg6y90C4nJRXTQORH/kuBvk4p5ujx9cPMHxGfWHE=;
 b=o0yL5PSCZFr29eM//vqH9ZAVPp/QDUR+kxIUoMWzVoZPKaDOCldm7LhygyGMt9PZgk
 VyYD7xdx2xrVvBrgFB6H24nFgl1j5dwxY8MuziS+riWn3x79NbB+tbICqulegd/qj3Mr
 zljtKWDAcg2wUlRyjbEblgS1qmJhf/ydSWSBnuhnuMcUnzTv6Tddl06izrTEslkuz5sT
 SPTv21K1FHGs+f+BDrGn3/0hbIzDXmNYL+MaYFKr9LLxJ9Msoh+68wpo+co+CnaHQlfs
 yTYlpimqj6RSfXTqleYy7ZjrRz6BCWcytoF3I45VM4FehrT5YGi1RdDDKkM8tNO9k+hp
 ZkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=roBMg6y90C4nJRXTQORH/kuBvk4p5ujx9cPMHxGfWHE=;
 b=dO7GyMGN1ggyKUojKcEn3fvPznf7TyFsYOBqZeLnSZGHoSqMl6eRSGZJ2HzPaWCdHU
 UYrMMMo1AOhjC2z7MXQ3t9uZ3Y0k2j2UZmt5qHJEIcI82SD4c6YOLB3368yD1+qmW1vq
 dZf2lLffceniezbP/gssCvo2K9LtjmQrqx6f1cJCkt6plEOyt2bAFkOcx12Qxr39TlU1
 uP6Wn7OsaEAWG+Jsxy1E3oENowPhUGiJAtC8qjx5BapFk9ZF9z3FWIFokgHVrHd+dTkE
 8TKE7olKJPPZ5LDNhcPXHbGxaxI31ZrtF3y42yw2hbURmXBOr75aXAe9kSQqBe3BQYl6
 1QdA==
X-Gm-Message-State: AOAM530iH5OuZP2pRO1LKQqTZXhGWZFHVdXeKITuBQm4n2w7q6hE2fh9
 6yhsQPKuBKdT/46F6JRyi1eDjQPZz8/x1aw/A6jkcA==
X-Google-Smtp-Source: ABdhPJy3u3uL4e/ZHH9vP5lhvpERXpGAvuC7v59vfO1/fNLwkgYfHunqePLhVXn6tXoz5aH1jxNg/y057Oh7jXf7mPE=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr359138ejk.407.1603909885977; 
 Wed, 28 Oct 2020 11:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201028032703.201526-1-richard.henderson@linaro.org>
 <CAFEAcA9v7VHpy48rRShyei_TQpzt=_HWVitGEuaybpG9w7-y_g@mail.gmail.com>
In-Reply-To: <CAFEAcA9v7VHpy48rRShyei_TQpzt=_HWVitGEuaybpG9w7-y_g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 18:31:14 +0000
Message-ID: <CAFEAcA_Aj=+6cD_X2o+mFDPseDez4saNTOgXMnmyZVQazBhdWQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] target/arm: Fix neon reg offsets
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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

On Wed, 28 Oct 2020 at 16:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 28 Oct 2020 at 03:27, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > Much of the existing usage of neon_reg_offset is broken for
> > big-endian hosts, as it computes the offset of the first
> > 32-bit unit, not the offset of the entire vector register.
> >
> > Fix this by separating out the different usages.  Make the
> > whole thing look a bit more like the aarch64 code.
>
> I haven't reviewed this yet but it fixes a lot of the
> problems I saw in my risu run on an s390x box, and I
> don't see any regressions on x86-64. However these still
> fail on s390x compared to an x86-64 host:
>
> insn_VPADD_float_f16.risu.bin FAIL
> insn_VPMAX_float_f16.risu.bin FAIL
> insn_VPMIN_float_f16.risu.bin FAIL

These three turn out to be a silly bug (one of mine) unrelated
to this series (patch written).

> insn_VSDOT_s.risu.bin FAIL
> insn_VUDOT_s.risu.bin FAIL

I'll have a look at these next.

-- PMM


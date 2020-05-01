Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491E8C47257
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19BE220787
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 18:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sd43+k5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19BE220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUa88-0001yG-5T
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 14:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUa7G-0000n8-6U
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUa7F-0004jg-4c
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:10:25 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42808)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUa7E-0004fj-M9
 for qemu-devel@nongnu.org; Fri, 01 May 2020 14:10:24 -0400
Received: by mail-oi1-x243.google.com with SMTP id i13so444030oie.9
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 11:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6epJaaRgm8vNjSQ5FfAD77JCMjWkCXvpZktB1GowDJA=;
 b=sd43+k5ThjW5bgvNxuv2YZmPBOXmaWiSMDiIVajiox2DDQ9KvrD7obOSh+/PVkzklS
 lyBwlJgWIdC4un4b7WeT3YYVhxJ41LDaM0vcdC/P+hs1pX1freVeQ5Wjt45+2cUalcUM
 XsihIEcF3LwFGc700dtaBQPCO5l7P0G4mU5qw8hROOGre2r0xmFpWjpDwosY57kYHdDr
 YAMxo0fLGgFTCurxlj35DBXuHNWFGKEsGGwfoRnBFsMcUwhDRAE3IdDoHBRJz52VYRFX
 Iv727ZZ+/WYNyZIM0sHhLkbyay8gSMLzFqvoZhGaQRZ0LsGtYtJCBUW3CEvrDGunCMVX
 Jp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6epJaaRgm8vNjSQ5FfAD77JCMjWkCXvpZktB1GowDJA=;
 b=peLS5z+17FhmQy5v8wvjsSs/JWjAjJJDkCZm+dbXOLEmrPfZg+lGt7fRr7oF+VeHoJ
 8dvdot9CemJxOxA+B3aaN+spnNwz5l3V/O+cLF34scHdZs5eoduPMtHe7Xtw9xxS4BDt
 Tt8nlo0WiX6zRJxiyj7Ic6yBEG4UdJHkBX+DJytLK+KwaxgQG0z6A1yLJ+k4Cvl3BDQB
 FuyVF8jEXQe+1svONkSFoE2EHbJWnuNsfCtFZpRdGEKyLTPdK7uGRFa2ljvwrByrf3dU
 Nw0FsfzGpMl3tijRBrBSh3m9MhfoiPHsujOvcTb18RHwsDb2SnLFlsxPu9acaxtvdsYe
 b8lQ==
X-Gm-Message-State: AGi0PuZmvPJiHAFnr2wDLWRTwsZW5KHt3gy9RArh+hzUN5yVxZjDVKuR
 jyXeqSO6SUnj4xQCXiQn5J4lH9KS+QvbVyFeNzTUtA==
X-Google-Smtp-Source: APiQypKRhDYjr/poi5ztySW6mpcJBIissU/wJRRT4EOyzvRbI3XE4momZLPkrWA3+wcJxk6bGAKshEhR0wXj6iBmfbU=
X-Received: by 2002:aca:3441:: with SMTP id b62mr616818oia.146.1588356623277; 
 Fri, 01 May 2020 11:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200430181003.21682-1-peter.maydell@linaro.org>
 <20200430181003.21682-27-peter.maydell@linaro.org>
 <b1d8a9ec-a1ef-47af-f07f-3761a51945f1@linaro.org>
In-Reply-To: <b1d8a9ec-a1ef-47af-f07f-3761a51945f1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 May 2020 19:10:12 +0100
Message-ID: <CAFEAcA8Jv096T6gFPutS0DjFxi7UCDQPv2FMJZ5RjLTEVXmbwA@mail.gmail.com>
Subject: Re: [PATCH 26/36] target/arm: Convert Neon VQSHL, VRSHL, VQRSHL
 3-reg-same insns to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 1 May 2020 at 02:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
> I'm not 100% sure how best to handle the swapped operands issue.  I don't think
> we want to do it here in gen_gvec_srshl, because we don't have the same reverse
> operand problem in the aarch64 encoding, and I'm looking forward to re-using
> this generator function in aa64 and sve2.
>
> Maybe it would be better to have
>
> @3same     .... ... . . . size:2 .... .... .... . q:1 . . .... \
>            &3same vm=%vm_dp vn=%vn_dp vd=%vd_dp
> @3same_rev .... ... . . . size:2 .... .... .... . q:1 . . .... \
>            &3same vn=%vm_dp vm=%vn_dp vd=%vd_dp
>
> and swap the operands to "normal" during decode.

Yeah, I guess so. It's a little confusing because the operands
are going to appear with the "wrong" names in the trans_ functions,
but we can hopefully deflect some of that with a suitable comment
by the @3same_rev format definition.

I think that all the affected insns have asm formats like
 VSHL <Dd>, <Dm>, <Dn>
in contrast to eg
 VSUB <Dd>, <Dn>, <Dm>

so it's effectively just that the field names in the official
insn definition are backwards from what you'd expect.

thanks
-- PMM


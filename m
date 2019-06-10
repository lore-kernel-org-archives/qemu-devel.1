Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85543C28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F6A20862
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbaLDoTk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F6A20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46700 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKiV-0001iG-ET
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50613)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haKex-00078B-U8
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haKev-0000Ly-R1
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:48:27 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:40427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haKet-0008Ot-Rl
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:48:24 -0400
Received: by mail-ot1-x336.google.com with SMTP id x24so8331581otp.7
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gDsrHiBFVBOgqILQf4aIfimt2DXzKNfMkh6SBWI/abg=;
 b=fbaLDoTk++40fxsGMXpjw3jcHgLE9YtbLZvg27Ni6VUeBLwH4ehIf9qjR8v16gsFzT
 5zMM1zhz/Ij3VA/0bS81npnDsmMLEpjGKuNjX7vw3iauJbSlJ+4qy8qa04dY9VnFck6w
 rEXhUcEws9+a5n52jMFPpl1Bej4TyMm37qE/P0xVWlbJdurmojb2UPLWEBALNF3FXOvw
 TWvpM0TsJaE7o4vflXVw4VXBRW2ymZvU6ts3kpG+2fPyvUszzig1HC6YnE+GBE5pVb4L
 TZGil8fmgHvEMV7GapSodfJKPUXA6sEQ0aNjU+EW+sMhXYIMk2MtHGqe1YI0yDojhoh1
 TChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gDsrHiBFVBOgqILQf4aIfimt2DXzKNfMkh6SBWI/abg=;
 b=DtyBgMLL071Nbi34hxYCSTpOooXZfbA+Ac2FYKGn/N15WwDMJyltdDcDuggtlmlBNb
 ZPWC5CnTNnEw0WKulFZk/J/fms0RIelnRQuDfM5VJednPSNKVzkrCWd7n9SkNl4Auw1l
 3TwdZjV12GoIOcL2sza7DQuDcW4RCpntjInjCxN4ILPCKVrvTqI0Eda1HV04pVkIgKRk
 wKAb3wGmCNOmF5Yp0C9gIFFyGxtUG1lvyNSs0wlUyktUhynPOdv5LP8uU2pcCQrlq2Ik
 hvtD/FS/mIM4tZ1gTOz75VjuuAT4HSl8x441I0hnfyebSTLt750M6PYPs5x1CIqjU2cw
 1cYg==
X-Gm-Message-State: APjAAAVLBj9WAzjlmfoMfmihknaAxxbekfYYBrmhZ3YI9vfHBdv//LXq
 meJcCOj0wNvGRdMzzvXu+7anQBvo/vGQ3muybFNRxg==
X-Google-Smtp-Source: APXvYqwmIpvJUY+b0dncdu0KdRaIRN2wZnp/dO4uW1AjfwZ1EghZgTC9JmFQbdy0/faMPTlQESMniYrhVhlE95QK1aM=
X-Received: by 2002:a9d:630a:: with SMTP id q10mr8917688otk.91.1560174490407; 
 Mon, 10 Jun 2019 06:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190610020218.9228-1-richard.henderson@linaro.org>
In-Reply-To: <20190610020218.9228-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2019 14:47:58 +0100
Message-ID: <CAFEAcA-bHHjj1uBCqjLjhFY0GJLnVSZxVrqNdCUod_KGhpK6zQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
Subject: Re: [Qemu-devel] [PULL 00/39] tcg: Move the softmmu tlb to
 CPUNegativeOffsetState
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

On Mon, 10 Jun 2019 at 03:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 185b7ccc11354cbd69b6d53bf8d831dd964f6c88:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190607-2' into staging (2019-06-07 15:24:13 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190609
>
> for you to fetch changes up to e20774aed18cc5e0113e6a6c502ece2fc1c41931:
>
>   tcg/arm: Remove mostly unreachable tlb special case (2019-06-09 18:55:23 -0700)
>
> ----------------------------------------------------------------
> Move softmmu tlb into CPUNegativeOffsetState
>
> ----------------------------------------------------------------

Hi; this failed to build on OpenBSD:
/tmp/qemu-test.RzUFLe/bsd-user/main.c: In function 'cpu_loop':
/tmp/qemu-test.RzUFLe/bsd-user/main.c:143:28: error: 'cpu' undeclared
(first use in this function)
     CPUState *cs = env_cpu(cpu);
                            ^
/tmp/qemu-test.RzUFLe/bsd-user/main.c:143:28: note: each undeclared
identifier is reported only once for each function it appears in

(freebsd and netbsd were ok)

thanks
-- PMM


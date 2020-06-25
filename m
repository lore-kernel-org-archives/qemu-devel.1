Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D27C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:15:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBAD20707
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 17:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X72peg7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBAD20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joVTT-00083o-Fa
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 13:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joVRu-00071u-KD
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:14:06 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joVRs-0006Uo-MK
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 13:14:06 -0400
Received: by mail-ot1-x343.google.com with SMTP id 72so5978950otc.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 10:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/DHuqCTBEttHEHbwY3BkdETHjtz0WWooikM9ux/nuQM=;
 b=X72peg7uJ05DfE3Ay16Ngzw6Cw/Xao9gNwroTOlOrAspCZu1IUgEpP5d+l6NocvyQr
 /ds6rp3JgxGD9iB7kIk1Fg/BOT8YdABB5P082pCZks5rhY6LOpjIq7iVKnuvOV2aTsQR
 D5Yj3zs6Ew2xZgqrgrrBPgjtF6c54zLfceRip+Hx0Ui7oQo4+McvEv1RG14TJm86fUVq
 hCaQJA5a1dwSKQJJuBaxvJQJo9A88fjt+YDlRQaL7ikpGhgTvQ82RHZWRPLfOhYXUiIO
 X4I8fPEjAU35/gHvNq9QeJddJSpTgGTLpc5vlsFe+Dw7lJN8ZaObRVH/JJ2lyG1+NGk9
 hc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/DHuqCTBEttHEHbwY3BkdETHjtz0WWooikM9ux/nuQM=;
 b=kJGZPOki7bqi4NyN5Whjhb6P8oUY4ZU1yDtOcMDRIfV6lvLe6Or0HaWM8odlHsbxsa
 mcMjEEv4GEnuxs/DbJ3r9lwnGwgy4nt7ELYrtMCz0PvFs+5dM8pOqFizyKc1QQi8j07K
 bYwK9RJNL3m10BnGYAiHtNV55LxWP/+ZbZDjCEsOCTYRzXTcDhTjkIa477YEwORMIYml
 0AoKv91u0z19+s2aYVU3CNuebwkJB7jMER2j9+UUdJYxnX/73Zob/3ysy7xPOgZY0iIB
 9BFJbLabkXHysiVm4KKzH00qDyBxDLI5HN4S3b6reYzr3rQAEu1qSZFLl1sGl5BsZ/Np
 qA7w==
X-Gm-Message-State: AOAM533qbguRoiq3hONPcyOqlkRr7CJYCol5a9yskoUKukmRU2T8yMFz
 PvNWLbcihAzLGNK5/BHNebDBozN17pWxKz+HiNlML0HYgZQ=
X-Google-Smtp-Source: ABdhPJzjaQRjzK41lJaNMI697TiCN0KbmQKBhLbKrpWgnOm2Ayj97j5LqIR6oGgJ87juI4kvHzi1Od8F4yJ4uIA03q8=
X-Received: by 2002:a4a:221a:: with SMTP id f26mr28475121ooa.69.1593105243134; 
 Thu, 25 Jun 2020 10:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200605041733.415188-1-richard.henderson@linaro.org>
In-Reply-To: <20200605041733.415188-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 18:13:52 +0100
Message-ID: <CAFEAcA8XKGLipda3FaowO=JT1Ey5x0BKMqEt3znThk6k-ssJ+g@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] target-arm: Implement ARMv8.5-MemTag, user mode
To: Richard Henderson <richard.henderson@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 5 Jun 2020 at 05:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 1 was back in October:
> https://patchew.org/QEMU/20191015163254.12041-1-richard.henderson@linaro.org/
>
> Although that post claims there was an actual v1 in March 2019,
> I can't locate it, so... whatever.
>
> This version -- call it 2 -- is the first attempt to implement the
> actual in-progress kernel abi, rather than making up a private abi:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/mte-v4
>
> Based-on: 20200603011317.473934-1-richard.henderson@linaro.org
> ("target/arm: Implement ARMv8.5-MemTag, system mode")
> Based-on: 20200520172800.8499-1-richard.henderson@linaro.org
> ("linux-user: User support for AArch64 BTI")
>
> The full tree is available at:
> https://github.com/rth7680/qemu/tree/tgt-arm-mte-user

I've reviewed most of this series; the later parts look ok
but they're implementations of an ABI that hasn't yet gone
into the kernel so I haven't bothered to look closely at the
details.

thanks
-- PMM


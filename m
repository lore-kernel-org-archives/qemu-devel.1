Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA29C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 18:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 890D4208B8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 18:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e52GCJGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890D4208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlzXW-0001Nt-SS
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 14:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlzWp-0000YQ-Bd
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 14:44:47 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:45977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlzWm-0003YD-UF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 14:44:47 -0400
Received: by mail-oo1-xc42.google.com with SMTP id k7so1382885ooo.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sx+6o1FRMURxM/rnC6WvWk7o1ZMRJ9k60AmC58U6q+4=;
 b=e52GCJGl2J9qXJwRQZo6ZHEzmBM8wEaPgRwsWWXEZJWPLuchkT/Sdl1LzwVBgsZaHA
 gwoiIcu+fzGhe2eFirNT4eLYKfXHUhEGeDie2iRW5LggD3NtpTPmqLkAGEjej6969Wf1
 NeRwOzWrvSNiPUN3ur4fd+lGFEXdo3ajyJkMQkP23CEz95oBEqF9n4QXEnC3RdzHXlfT
 G443/MToBywEFKsmjLWwHs4odMaf9GCbwK0OiTWAZAOdKys9GThSE2xT7YCN4oPCshki
 zRlPTsPgDVYOdvp9N3Zoan+e1Z6pOkVp/KG56c8d/DKtP+lScK2LXyzRYZ/zdAyjKQ13
 SaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sx+6o1FRMURxM/rnC6WvWk7o1ZMRJ9k60AmC58U6q+4=;
 b=kRJKH7bVj6gnBf9UUBfAgjoLzQy5/HWlSzxq7FzGrxmfQFn89h1zjCMIrJACFejrOt
 KwWsG393+7HFuKgyx6HFkQdDjpikji79ls6bQeOQx4F1hZ3NMVW0qKVHpl8Tnmc+x1TC
 q64ZLFp7bz1l3ql1tTCyWiS3ErMmZAYbTgwGvpOcJq8nPC9bzPkBze/s/22y+hqE+z1c
 JGxDEtPXO4wua/Tp9Hm3pOnznurJgzU5K87d6tEpvVZPYUs7QIjG7cldDpmxzcusXclb
 fgJRmAJCh07ZeoiKlTFAYNwNVQfQaDprSsgDnmMZ6TkoffOjEklubP7hlFSAMogUOr2U
 WY/w==
X-Gm-Message-State: AOAM530QW0A8rAV0OzROYBB7BddZPRNhImJgo99hHuQnXK0ebfebrWtg
 cNzcVMRBoR7+yNH4PXhflFbAwaKMCK0XEIid0a2bdA==
X-Google-Smtp-Source: ABdhPJwbBDAh09qrSbCtMUn8/8YnObxWHdiATORwj9N6musTIp+que2fJrGsVJlmRKiXKjJvsPI8RiCWVu774H6vrTE=
X-Received: by 2002:a4a:221a:: with SMTP id f26mr181740ooa.69.1592505883703;
 Thu, 18 Jun 2020 11:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-4-richard.henderson@linaro.org>
 <CAFEAcA9bAt=cG9nSWP6JaVyx4jf2UGmYLKzvaJ7rVCdLVpw2ig@mail.gmail.com>
 <f2b5b9fc-0586-1716-e5bf-c04db454f745@linaro.org>
In-Reply-To: <f2b5b9fc-0586-1716-e5bf-c04db454f745@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 19:44:32 +0100
Message-ID: <CAFEAcA-RbaDWZfLt0TCxJ1Hrantjwomh96X2AXVZ3WjoYD8pbw@mail.gmail.com>
Subject: Re: [PATCH v7 03/42] target/arm: Add support for MTE to SCTLR_ELx
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Thu, 18 Jun 2020 at 19:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 6/18/20 3:52 AM, Peter Maydell wrote:
> >> +    if (ri->state == ARM_CP_STATE_AA64 && !cpu_isar_feature(aa64_mte, cpu)) {
> >> +        if (ri->opc1 == 6) { /* SCTLR_EL3 */
> >> +            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
> >> +        } else {
> >> +            value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
> >> +                       SCTLR_ATA0 | SCTLR_ATA);
> >> +        }
> >
> > Doesn't SCTLR_EL2 have the same "no ATA0 and no TCF0" that
> > SCTLR_EL3 does?
>
> No.  With HCR.{E2H,TGE} = '11', those fields are present.

Ah, right.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


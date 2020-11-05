Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DA2C388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 23:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0638C20704
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 23:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+RIH6xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0638C20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaopn-0005Mw-KB
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 18:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaoob-0004t4-Ip
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 18:37:13 -0500
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:46592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaooX-0004Zl-O1
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 18:37:13 -0500
Received: by mail-ej1-x641.google.com with SMTP id w13so5095576eju.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 15:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7Ws0N4H3e3IXPjz5uj3/DEyDWDmAgXLDdeUZPy7wlc4=;
 b=t+RIH6xxIj5vf3Bd8g74sJN04NSRLLfPXeQNCZ3jseZ2NTWfCaL9UHDGWCluSBg7Iz
 CC+g5x4DNuEa9tkn0gcaiYr/Lom1w4dLZoUJihHnQ1SzTfGDudLCKm9TEBFpg+nyst09
 TPdfZbskQx2yTyJJWg0yawA8eJyIk8o5hYTdzeNx4Dsbj+gxdRGO+rrzAbLHiuMN3IXd
 w7ud2n0YFgb4TXE+VDIQENIVDboV6gLsz2sitlEldt14U6/o0XSKWPwXQquqyC7AKq3x
 ESorAgACwJKxsc9pZ1fB4zz4ROlY95RHWsbOq9RIXEufIRu1Gi/qDj+xQU3veFkKFuGR
 IeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7Ws0N4H3e3IXPjz5uj3/DEyDWDmAgXLDdeUZPy7wlc4=;
 b=TetcHGn1lDTDyClPRYOykUNpn08gHWjYhFlJt1OvHYcbZ4/VUztX5p8MTfhKv3Gyy/
 UV/K/wDZCstybBVyX3O0DjumX0Fv2dgWv4Ih3Fil+HkO/c8QfUvP34WlHLaOCDEhJWds
 tZEeEJj0e5cj9AUu95ZY9GDz/uDulNnJLJHytjJZhAiy6KYyeCI2UI6hHDWsEXnFVmUH
 WwT8D11g3IJ7aWpvjhWzTbFoNyQoWUUntj081Q+PB2VhaTX34UsnBdjL3NedOFSNp552
 GEIaMC8RHZw6jg5npoHi5dCxm1mqFP+GKGFSfOvLMWAt7spgxuqhfM0Pd5+3SZrlN6Re
 vu9g==
X-Gm-Message-State: AOAM532o23d5DN2fRsqsqYx3le74cwtZ3BebPs1Eszm/lN9ETZIh+xs5
 V241+RaBNUYu8yP9irAtckIGuwPbRoyJuPOPoV0KTw==
X-Google-Smtp-Source: ABdhPJydGkkTWT/1M+vrM70cW6lP6l+X751B5P+4YIrvaKbkrVXiLNOlz9DktxHr0iYjsREyxFkOiKT0vVOJHa+CyFE=
X-Received: by 2002:a17:906:2bc4:: with SMTP id
 n4mr4656189ejg.407.1604619427888; 
 Thu, 05 Nov 2020 15:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20201105212314.9628-1-peter.maydell@linaro.org>
 <20201105212314.9628-2-peter.maydell@linaro.org>
 <6bdc7371-58a8-a4a8-a948-8e7fce921fdb@linaro.org>
In-Reply-To: <6bdc7371-58a8-a4a8-a948-8e7fce921fdb@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2020 23:36:56 +0000
Message-ID: <CAFEAcA8R45sv+EbeqOBdkbT7buzvFbugBdro1MxfTKw2NrD4oQ@mail.gmail.com>
Subject: Re: [PATCH for-5.2 1/3] linux-user/sparc: Fix errors in
 target_ucontext structures
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Nov 2020 at 22:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/5/20 1:23 PM, Peter Maydell wrote:
> > +} __attribute__((aligned(16)));
>
> Hmph, 96 uses of the attribute directly, 20 uses of QEMU_ALIGNED.  I suppose we
> should just remove the wrapper...

Oops, I forget about that. We're better at adhering to use
of QEMU_SENTINEL and QEMU_NORETURN, at least. And a fair
chunk of those 96 are in code-that's-not-ours like the
headers imported from Linux or the pc-bios/s390-ccw code.

I'm in two minds here -- the wrappers look less clunky than
the __attribute__ syntax, but on the other hand "there is
only one way this can be written" results in less inconsistency
than "there are two ways".

thanks
-- PMM


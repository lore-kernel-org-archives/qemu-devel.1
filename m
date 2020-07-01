Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F51C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A433F20720
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXBQ6Th/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A433F20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqi8j-0001a9-Sd
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 15:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqi7Q-0000he-Kt
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 15:10:04 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqi7O-00027F-O2
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 15:10:04 -0400
Received: by mail-wm1-x343.google.com with SMTP id l17so23698853wmj.0
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 12:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z52PV47CYlGFQWQEyivMxDSjeg7rUMVXJTxn0UE6pLk=;
 b=KXBQ6Th/vnPPPe7f/LF9YkJxpq4P494eQMy+Cjlfhu9Y+8ny58k6sDD2/5VXk19mKY
 6UBkPHqnR9s4WNnYo75A/NEJNJPaCIZql6pK9yjmMN/wfHeWJ8xRAjFvPZHGMB8u3RhZ
 G4yxJ5+WZuOAhLt+fH3hIwCy7oq7F0yv7jV3c/fVqMZeRVzrjXtxDo3ivPtHKPaTsErm
 sQVPaFQqInQdgYZFB44YzefB5GxATopcb4VvS4CwsNb99ZLo7rolBMxOofSQbo4zNk71
 8NIEl4OlV+6ftrvwCJGX2XN4r2aSjaIfKd+RSm2KlwxJWqygk/r9+3TYeQTJXR4OrViS
 QxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z52PV47CYlGFQWQEyivMxDSjeg7rUMVXJTxn0UE6pLk=;
 b=dVjMqmA2rGvJfinIQjMiFewlWsMwOYlB2Gzd9z8YvWRw4Y+Clm3ycDe87Zq0CRo7Bl
 g/cumisVMG8hTs8JqkRidP8FZvpkdDLfQAK3sBCoKIMHWRk1ginE5dEO3R0uBISx6Ez7
 8XKBwm8oHzkojO9d6avCU57adG01Aw9qtS2W26iVPY+38/B9WINpDNE35bFqJcHgb9Rk
 9GbEusVpjHM5Ic1xa4+CVkUPvWJwQSyDL0sQzNJRrrF0079GpUyVxKweVkd5jsPaiiAq
 duEECRU+nZQ1GTSQqh63BD8TbJ32Mme9aoMr5CcchkLA99qj3peJ9jLg4swHllFNzMmT
 +QAg==
X-Gm-Message-State: AOAM530l3e5+a71dq9fH9uIOH+keSnhjMLZGCAJ8douhA3jDW2tiqYMF
 dxp7fdVnr4F17pN1IS0/wLZjEvlwBwaaSlm8sjA=
X-Google-Smtp-Source: ABdhPJwkPMOeXoz7QtTnj9OluOdjv3VuFp5lNooJwskhq6DdgDL36KNS06LqvAeam5O0vZe0yf5PWp7v1r9cE6ENSOY=
X-Received: by 2002:a1c:2602:: with SMTP id m2mr29389197wmm.50.1593630601027; 
 Wed, 01 Jul 2020 12:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200701182559.28841-1-aleksandar.qemu.devel@gmail.com>
 <20200701182559.28841-3-aleksandar.qemu.devel@gmail.com>
 <CAG0y8x=hvvOzdvZEAneF8zxFfg8-Q6Yo=hDYFfDOmGBKsb_+ZA@mail.gmail.com>
In-Reply-To: <CAG0y8x=hvvOzdvZEAneF8zxFfg8-Q6Yo=hDYFfDOmGBKsb_+ZA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 1 Jul 2020 21:09:43 +0200
Message-ID: <CAHiYmc4WuwdWLyGGg+fkOrjrx_Mo_1PSQFt45kzwXV319WG6WQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] MAINTAINERS: Adjust MIPS maintainership
To: Paul Burton <paulburton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 1, 2020 at 8:43 PM Paul Burton <paulburton@kernel.org> wrote:
>
> Hi Aleksandar,
>
> On Wed, Jul 1, 2020 at 11:26 AM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> > Paul Burton and Aurelien Jarno removed for not being present.
> > A polite email was sent to them with question whether they
> > intend to actively participate, but there was no response.
>
> It was 2 days ago, not 2 months :)
>

:) Haha, but nobody said 2 months ago. What do you need - 2 years notice? :)

Paul, you know I would like you be with me here more than anything
else. I still feel the excitement of working together with you - can
you believe it? Some people here even (so wrongfully) think I have
some bad feelings about you, while the truth is the total opposite,
and I am sure you know too. All doors are open to you, if you want to
get involved, and wherever I will be. You are among the best
engineers, actually, now I am thinking, probably the very best, I
worked with!

I long our path cross again!

All the best on your pursuits!

Aleksandar

> I'm fine with being removed though - I no longer have access to modern
> MIPS CPUs or Boston hardware, and wouldn't currently have time to
> spend on them if I did. So as far as removing me goes:
>
>   Acked-by: Paul Burton <paulburton@kernel.org>
>
> > In cases where needed, other persons step in instead.
> >
> > Huacai Chen and Jiaxun Yang step in as new energy.
>
> All the best with it moving forwards, and thanks to Huacai & Jiaxun
> for stepping up!
>
> Paul


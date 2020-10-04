Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B2C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:54:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 089BF206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 17:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXmOVhO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089BF206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8Cx-0006OY-1c
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 13:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1kP8CO-0005zI-Ja
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:53:28 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:45937)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxim.cournoyer@gmail.com>)
 id 1kP8CL-0006x0-Ac
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 13:53:28 -0400
Received: by mail-qk1-x744.google.com with SMTP id o5so9135723qke.12
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 10:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:references:date:in-reply-to:message-id
 :user-agent:mime-version;
 bh=hPQH474fiqG3iymHl9RC5IEj+ZXetzkS2/iyjnPPdUs=;
 b=uXmOVhO+I8u9tNt5bY02+PjIwPGEr/HF3BzqBgzW9I5/fepDcK/+Bnxxb6POaySBR7
 eL0zL/8gK65OYCWXQfXel2J1g3iCkNDLo+h9Cee2kZi1LpTBC3oLRjeGT02T1jwHIlZP
 C+nrbfHLInI92QNAgqf1nE/oX0llDjYY432psattvBBPIAXDu3bY5lh/hT1d/7UhtAdy
 GH5KflPcIGpnGgvju8GE/cxK5SjnX73QNQubyL9KFJeTMMRHLKwxq2pTYHAjILLYoJeR
 9n5qTtf7Nea0B1QHxm6q/anhaM014D+vOrMxNv+FAT6tVx6iV/KV7hWaVoL2OAJ3RhA5
 JXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
 :message-id:user-agent:mime-version;
 bh=hPQH474fiqG3iymHl9RC5IEj+ZXetzkS2/iyjnPPdUs=;
 b=jcIx12OtA8m3A6RPgFfuJfQW6Wx37uFxn25TQ57h2wlVybqQjvmFOzk6jMdBqzDR49
 8nuuA01lKnWU0LKBvBiAVpsg/kGJhtZUhzOxcbkJtHTRbQ+yvJzVDfVY/oBCSpGGiLXZ
 sjHuH1j7SE/GXZXiYpKzrH+0JsF3imhXs/Yx1RJ8mPrJTF/hZTPoQjDnzMe2GrF0vl2p
 SCxf/c4GM7xiwCUDMSJDQc2WOYACqq3WeRKlUYwg33giw7BCGRzo7iYhHGrbQEKRFsf6
 Vt/KMATdxcOJISfxgpmqG8lp3jEzvcX/Qw4WOc9EM7b7G7WSt9OhXQOKD8iEBy9+0J08
 FrZg==
X-Gm-Message-State: AOAM531W7qCetJ/T/1Oqob9gbhYCC/CdKBf0IFUOM8sk+o80KhZfBJZp
 P43cJswpnMCKkXVPTaqambGXOFxNxy15BA==
X-Google-Smtp-Source: ABdhPJwwV6W7f/PFDQZp384cLMlfDqcOGf9n3w+DoBWVG+smhWSmweRgbX8MIpNQc2AM/df88TEclw==
X-Received: by 2002:ae9:e914:: with SMTP id x20mr10657805qkf.163.1601834003912; 
 Sun, 04 Oct 2020 10:53:23 -0700 (PDT)
Received: from hurd (dsl-156-63.b2b2c.ca. [66.158.156.63])
 by smtp.gmail.com with ESMTPSA id z2sm5752468qkg.40.2020.10.04.10.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 10:53:23 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] build: Build and install the info manual.
References: <20200925024143.26492-1-maxim.cournoyer@gmail.com>
 <CAFEAcA_wU73U6eaHU0mwccr-E0EHSKzFJ1yiR++YEKv=1LneJQ@mail.gmail.com>
 <87mu1dtao6.fsf@gmail.com>
 <CAFEAcA_4wXqGeOgsY2GbY1mk==DCz--j-jhs+OdGQnOHEf+D_A@mail.gmail.com>
 <87wo0grmae.fsf@gmail.com>
 <CAFEAcA-ZcMQB+7P1r3u8m4wM7mJ_ogPrqasKSqL_9XPS+xQ3yw@mail.gmail.com>
Date: Sun, 04 Oct 2020 13:53:15 -0400
In-Reply-To: <CAFEAcA-ZcMQB+7P1r3u8m4wM7mJ_ogPrqasKSqL_9XPS+xQ3yw@mail.gmail.com>
 (Peter Maydell's message of "Thu, 1 Oct 2020 15:58:58 +0100")
Message-ID: <87h7r9lvxw.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2607:f8b0:4864:20::744;
 envelope-from=maxim.cournoyer@gmail.com; helo=mail-qk1-x744.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hello Peter,

Peter Maydell <peter.maydell@linaro.org> writes:

> On Sun, 27 Sep 2020 at 03:21, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:

[...]

>> I personally don't understand the rationale of hiding the devel section
>> from users, especially given the kind of users QEMU is likely to attract
>> (e.g, teksavvy people, perhaps themselves developers that could be
>> curious peeking into that section to deepen their understanding of
>> QEMU's architecture and internals).
>
> Mostly I think we came to this opinion because
> (a) it was how we handled developer docs before -- they tended
> to be standalone files in docs/ somewhere, not part of the
> old shipped-to-user Texinfo docs
> (b) internals docs are much more likely to become quickly outdated:
> you almost always want to be looking at the docs for current-git,
> not for some older distro-installed QEMU version
> (c) sure, some users might want to look at QEMU internals docs,
> but they are definitely going to be the minority
> (d) the developer docs are rougher in quality overall
> (e) you need the source tree anyway if you're interested in
> the internals, because so much is not documented, or not in
> the rST manuals
>
> That said, we are kind of working against the grain of how
> Sphinx wants to be used here, which is usually not a great idea,
> and it does result in some awkwardnesses (it would be nice to
> have the devel docs on the qemu.org website, for instance).
> I asked around on IRC and nobody seemed to be very strongly
> against moving to the just-one-manual setup. So maybe we should
> do that.

OK.  Thanks for asking others if they had an opinion about it.  Given
they don't seem to feel strongly about it, I suggest:

1) Keep the developer section as the last section of the overall doc
table of content (as was done in my original patch).

2) Mark the top level couple orphaned .rst as "orphaned" as proposed in
one of my previous reply, since this is what they are.  They will get
built, but won't appear anywhere in the QEMU documentation.

If that sounds reasonable, I'll send an updated patch soon.

Another thing; there was some CI failures with the origin patches I
sent [0]; are they worth investigating or are they unrelated, "known"
failures?

Thanks,

Maxim

[0]  https://patchew.org/QEMU/20200925024143.26492-1-maxim.cournoyer@gmail.com/


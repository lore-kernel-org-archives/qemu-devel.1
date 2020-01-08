Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529F9C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F0020673
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 15:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzdZoZdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F0020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipDMg-0008Ai-Bs
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 10:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ipDLk-0007JX-Tw
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:34:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ipDLj-00068P-L4
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:34:24 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:37049)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ipDLj-000670-Dx
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 10:34:23 -0500
Received: by mail-ot1-x32e.google.com with SMTP id k14so3966639otn.4
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 07:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=liIpu8WSwoFeXXflAjPLS5+QCtJEOL/ibA0I5UuWiO8=;
 b=VzdZoZdnL3K4y1D8C0IhSg7APzu4Q+TGdDaiftXiZKL7ieypqmPwo5Pu0treDid26m
 OXv6QYP52DPlggums1QQIExdxHU1N82bWoO1urlndAIL0IEPXl6xtAQJZg69MAAwvtIT
 uNhlIHI/GnRCT+ZK3Oe58t/OZvQwPXXEYJ85GzaW9+eXFKrRyiD9HlqYBEWLn8gThkAS
 eyUUwZeZXFsfcH0uWLdXO1OrMHqRu3Ftnx/5up7R0tmOeEcHF0igCRUIXQxBlAw/cwv7
 KRhGWJUFgRD/RiShHhF9z7M6AdUUJ7PuA68GnpZQO0HpwZZ8NUXwYoFUpUOuUmJSZo1S
 iQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=liIpu8WSwoFeXXflAjPLS5+QCtJEOL/ibA0I5UuWiO8=;
 b=XcHAaT3Hol+D00KgZC4Pkq7P346z4GfqcW2SK4q150BX3YcvVavRqMIgPBNdvf3fkM
 VK0d/yVybtr6zFBR21kIccs6tOIc+aiLHoY0gFTboZuHh42WywWHbi6dfQUAHJcIipDs
 /BXQ1rccNOYSLrO01yOwrfLCynfPXuMJeppZqb9jAlsk+bqmOCXMtdTzIJsOd94+QFj4
 OEHfTNdEyTvB4/KnBta9KnVBrNZ5I2pNN3Q1r34+6m3HLY1dwE189FcvWyYJB3PkWJGr
 r8wncnjTIigKdtUxvq6ktjMyXICXYOLIdFN7ANNzjkZ6ZuG6bkeo50GesZ6pRl5VTxX8
 irrA==
X-Gm-Message-State: APjAAAU0Czu79x8YtN7cJFgc84xDBiQhvo6u96ilGCtiGw85+XKE4vkE
 Bn+SGdLCm+prw+9KyJU0Tu2PeO5UgN0/ljXwdMvs6hXyunY=
X-Google-Smtp-Source: APXvYqz4fThr0NWgIvwV2F9IdNc8cEz03K35e0sWwq4MIHrUNGI8RVT6HbaH2UOo/hzI/48Axg84SrssLBUVC8tz+IY=
X-Received: by 2002:a05:6830:1586:: with SMTP id
 i6mr2842601otr.221.1578497661900; 
 Wed, 08 Jan 2020 07:34:21 -0800 (PST)
MIME-Version: 1.0
References: <CAMAD20mmgEa_W869C961T_1DQnx+J=dKYFJgv=2WEw5iDL5T1A@mail.gmail.com>
In-Reply-To: <CAMAD20mmgEa_W869C961T_1DQnx+J=dKYFJgv=2WEw5iDL5T1A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jan 2020 15:34:11 +0000
Message-ID: <CAFEAcA8AhKu53pieZTtArO26OJ2JLvBF8usVaSAya9FCxQL2Tg@mail.gmail.com>
Subject: Re: riscv: How to debug a wrong pc after executing ret instruction?
To: Ian Jiang <ianjiang.ict@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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

On Wed, 8 Jan 2020 at 09:23, Ian Jiang <ianjiang.ict@gmail.com> wrote:
>
> Problem
> ======
> The next instruction after executing "ret" (i.e. jalr x0, 0(x1)) is not at 0x000000008000056c (x1/ra) as expected,  but at  0x000000008000056c.
> How to debug this issue? Any suggestion is appreciated.
>
> QEMU command
> =============
> qemu-system-riscv64 -nographic -machine virt -kernel my-test.elf -smp 1 -d in_asm,cpu

You are probably being confused by the tracing. 'in_asm' tracing traces the
instructions when they are *translated*, not when they are *executed*.
QEMU translates blocks of instructions at a time, and it caches the results,
so if the guest binary re-executes a set of instructions you won't see any
in_asm tracing at all for that. To see tracing that happens at execution
time you can try the 'exec' or 'cpu' tracing (this produces a lot of output
so it's slow). You may also want 'nochain' which suppresses an optimisation
where we directly link blocks of translated code (which coincidentally
means the 2nd linked block won't appear in the trace).

Basically -d tracing traces things that are easy for QEMU to debug;
to successfully interpret it you need to have some idea of what
QEMU is doing under the hood.

thanks
-- PMM


Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2B4C3404B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D51124649
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQQJasgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D51124649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46hv-0007hB-AV
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:30:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j46gK-0005iO-5B
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j46gI-0007J9-Op
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:29:11 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j46gI-0007HC-HP
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:29:10 -0500
Received: by mail-oi1-x242.google.com with SMTP id b18so20915613oie.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MFL3lvzBKh6IY2wBd5R4FKgAYOptiR6fvNbeRvwFmC4=;
 b=WQQJasgykmPAOBMHhe+qC9FKQ9efDZFMifdxdqoVmVQ8IEgjUZ4NFb6b3MebAAlieq
 ynJ81KOAyeSb4DzUtivOGRHRrN/gp3gA49PMA7JJhcYbi1uR6F14NFZ/c/ZYspJ+V6Ti
 oKKIMllieArx7hpctxJIGj7BIktZ/AOSq5pBffP23GXCKGhhBuwsnXVcB7RLKSOhdX2x
 h4d6ZmgvmG273ij/3+qpGqFSjudLal2PhcwlMFe/lpPgahtnAn5/WjQBiXOmwL1nbdVs
 FZYzNS/7IILlAbrAtM5+Viq789ljZdcJnrwsbKwMZK7aFR/2Er5DFgQYeVWIpRa805WF
 rWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MFL3lvzBKh6IY2wBd5R4FKgAYOptiR6fvNbeRvwFmC4=;
 b=sHtxK3V93PLgYgGzGkMNdt2D7EyKoe2l4mKQFBDCsElBPPWneS/qDkwG6BCnMYXBuD
 TD2NV8DiqeO6KZe4Q/1lommyu5pqnFjzoZ8UwCzrV4JjElA9CtLh49uA9VARH3pnhTFh
 y7yq/e0bdy61C/0EZ+fZfGAvRn7PGc8qqDkov6nI2NZu0xiCTKXYFZSioIGzA1h+12kZ
 DlaM4+YwbNuPaVQvoW70ftfCM4AIiKVd+7fNCvD0UoGEqjVzAULrkKrMd3mYVlWup7to
 gyuUYix8xxRjUabw4gnsvxEuCzISxwad48oXUj82qYDyw8bfmQfZrLltrG2Ib9f0QIXu
 Z1VQ==
X-Gm-Message-State: APjAAAVY97GaDJOk4Vjlg9PG3YxirKvEKEhjjMN3XHUJ5dSVUWSFJYgv
 I3UZBaJEDpOyEpFP01ewI47kkM65K/3BCRAtA6ygXQ==
X-Google-Smtp-Source: APXvYqyBzFI7GfDpb9czpqpUzgzUUupggsVHk1LnVL7JEZUjQJxlyELZl3FDATlfNXhcFbfRPLenmH+u8tSsFANwOV4=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr1974655oif.163.1582046947625; 
 Tue, 18 Feb 2020 09:29:07 -0800 (PST)
MIME-Version: 1.0
References: <20200214194643.23317-1-richard.henderson@linaro.org>
In-Reply-To: <20200214194643.23317-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 17:28:56 +0000
Message-ID: <CAFEAcA-cm8bZRz1ZTut=p9x3pTfAe6yqJGZKxMVTOU4GX8Azjw@mail.gmail.com>
Subject: Re: [PATCH 0/4] target/arm: fix some simd writes vs sve
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Fri, 14 Feb 2020 at 19:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The launchpad bug only mentions EXT, but I found three more
> via inspection.  I really should extend RISU so that we can
> do AdvSIMD testing with SVE enabled...

Applied to target-arm.next, thanks.

I did a quick pass through for other functions that seem to call
write_vec_element() but not clear_vec_high() -- do any of these
need fixes?
- handle_vec_simd_wshli()
- handle_3rd_widening()
- handle_3rd_wide()
- handle_pmull_64()
- handle_simd_3same_pair(), "size == 3" branch
- handle_2misc_widening()
- handle_rev(), "size != 0" branch
- handle_2misc_pairwise()
- handle_shll()
- disas_simd_indexed() final else branch (the one with the second
  of the two identical comments about "The simplest way to handle
  the 16x16 indexed ops")
- disas_crypto_three_reg_sha512()
- disas_crypto_four_reg()
- disas_crypto_xar()

Probably false positives in that list, I just did a quick eyeball.

We could probably test this with risu by having the startup code
fill in the top parts of the SVE regs with non-zero and then
making sure they're included in the comparison after insns.
You'd need to test each insn in a separate risu run, though,
otherwise the first insn in the block clears the Z regs and we
don't get to tell if the insn after it does...

thanks
-- PMM


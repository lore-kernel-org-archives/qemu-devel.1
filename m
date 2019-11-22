Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55EAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE90420715
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTDGf+fd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE90420715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYBTL-0002pL-PD
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 11:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iYBNz-0004cw-I0
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:02:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iYBNy-0000yz-9w
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:02:19 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:35132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iYBNy-0000yI-4g
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 11:02:18 -0500
Received: by mail-ot1-x32e.google.com with SMTP id 23so4814679otf.2
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 08:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XbNqxfwvyyNufGLQoVfPRQtPB2stZCpaOOXp2CBni3w=;
 b=RTDGf+fdlx9YJyeU2njNuWlEJfp73l28yvbKnGey2ouelWpsORrmvCoE/pzZtQNh7v
 AM7FUFSpay11FEqb0KWLIPgZ90Rvdu9v1+YNJ51fhYz8jEAqEfYkiKZDoRWC8x/hXuUn
 O9A/k2w5GcuzHxRPx8p5cPVgCeAkPxA50AJ47A18oJFVGaOt5mxgBQJBtXvmyXZCU9VV
 zIzbAutEkTZH5feD6mh82U8/klJRDz5a3q6MLLAzNZ2SMAjW9eIq97SxBK4mVVKcWtad
 ryoAnhhcCuodQoIeadEQfrGY5uUfUyGVe0CBrd6X0CRjBsvEayyO9VArB6jO+vp5mmK+
 UeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XbNqxfwvyyNufGLQoVfPRQtPB2stZCpaOOXp2CBni3w=;
 b=fXHAbHSo6Mx3xYu/nShlyPFnfN+XIdnycHH9rKgGILqa/Z06q/vCkjVDRF2PHI7EMI
 XfyneaZ/PSkAy/9/9UMi8DZ1Y9HK0lxXYUTVKq+kR4lYbV87H/Dh27kP5XMgyc0LRpB2
 ntWVHm/d7xcUNTpjk9dPGuUr7WGLZt3F+EPYrRLPUVxulPLkbI7LSDI2hx+nZJ9PdwrS
 6sVL4ANFDZ/Erjl7YrRPrKI3JjcDUPHXhd+N12aa4RCk9LtLXiZeZn1V/oioE/vvjDWI
 aXg+HC4orlR9KiFMkx47jFQxS8zbSSiRDKJCf9m24WmHI/t9U7Ps7hexz2TPFkHjqy8U
 9M+g==
X-Gm-Message-State: APjAAAUm81vaRmIG/QMJH9lxPTffhzLRmAvWf7nYp13fZ6KWLJq2SEkA
 seVsC1OV/kkN5S3qQtvd9LijXuOpSqiPPthZ+/mDq9XFUynoPQ==
X-Google-Smtp-Source: APXvYqxGwZZWrS8KLjUdn0MehPvZrnhtUe3S6TK2HvMH3ZaGT8178RbcLDsdWyaHlUVrahH8poMSISAtstU/KPNC+Wg=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr10387799oto.97.1574438535697; 
 Fri, 22 Nov 2019 08:02:15 -0800 (PST)
MIME-Version: 1.0
References: <CAL1e-=gstogyXyAFV09-_mdqPs525bQP673+TcoxoRRDKwYAqw@mail.gmail.com>
In-Reply-To: <CAL1e-=gstogyXyAFV09-_mdqPs525bQP673+TcoxoRRDKwYAqw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Nov 2019 16:02:04 +0000
Message-ID: <CAFEAcA-JgWqJcLY1mT8DZ3E2JHTa=pT+m7a7viF9QFbrpiXoCA@mail.gmail.com>
Subject: Re: [QUESTION] Usage of '0b' as a prefix for numerical constants?
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
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

On Fri, 22 Nov 2019 at 14:57, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> I remember a while ago, something stopped me from using '0b' as a
> prefix in my own code (was it checkpatch.pl, or perhaps some statement
> on coding style, or a compiler, or something else - I don't really
> remember), so I didn't use it, and used '0x' (hexadecimal constant).
>
> What is really the view of the community on usage of '0b'?

I used to be somewhat against it/uncertain, as I wasn't sure how
widely portable it was (as Eric says, it's a gccism, which isn't
inherently a problem for QEMU code but it makes it a
bit less certain in the general case whether all the versions
of gcc and clang we care about have it). But that was some
time ago, and for 0b... we have plenty of existing use in the
tree so we can be confident that it's portable-enough for us.

I agree with Philippe that whether to prefer a hex constant
or a binary one (or a decimal one, for that matter) is basically
a situational question -- aim for whichever seems to make the
intention clear, be most readable, and match up with whatever
notation the official specification uses, if applicable.

PS: for expressions like
 (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111))
it may be preferable to use something like
 (extract32(insn, 25, 7) << 3) | extract32(insn, 12, 3)
rather than raw bitfield manipulation; again this is a
judgement call based on what seems more readable
and perhaps how a specification chooses to phrase it.

thanks
-- PMM


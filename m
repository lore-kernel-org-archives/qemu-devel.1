Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1CFC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245C4206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DO21fH3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245C4206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix7U3-0002fl-D4
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 05:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ix7TH-000215-5J
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ix7TE-0003BE-S8
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:54:49 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ix7TE-0003Ag-MY
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:54:48 -0500
Received: by mail-ot1-x341.google.com with SMTP id h9so2653726otj.11
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 02:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PrdNuZsGgAmqluD6TrlybQm97PZNBfBcgKFfZrwCcKs=;
 b=DO21fH3KnhnPJl05poBk2M+MYyDyGBTtACn+EDyp5zuN7mnqsR/yE1cQRw7DGE6pgk
 +uE3SClonk7ylEC4MNc70EIOibrxV+kHQt/CwnEE7LYqM8CdI6Jx04IsIyFjyOQl28j0
 ttaSxXGqM6aAh4ujQ7WhQcNpAW4mqmslL/ZMNEB9k2mz7r8PsjFAD5JLDoGRMFVyUt1+
 wWDli8uSEd356mzoOBnNLefsMJnm12Wy+ikHnW8lJy0+xt2vDMz94zi3pmrO5XQv4KzN
 K99EnOzbhRprWMJ4T6l6Crr/uybaSBrM5LtgmXE39IfRhkpMocV5uBwXDdJbtmCaVN3W
 6jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PrdNuZsGgAmqluD6TrlybQm97PZNBfBcgKFfZrwCcKs=;
 b=a3AZ4MrWnlMRt8RBkSvNLJ6NTkkp/Tddn2jBXA9wNepwrhrm1Tzwr0dDfIfaVr5eY6
 CpIpiKJTslNbxSgv7TeRUtjawUTqDQPwrtN/ERlewFu8uklg/OeBHE9Zm7JOrGNCF/wH
 2WfbabQdlgmt+vX0wFxT3Lu7UzYO14vb69w0Ubl/Yt3qIIiXAk5e2BhHtiNvo+2fW0EN
 fvNxCx4wIseK42QZNJyRwicaeh18t8uthA84LkVAJBTMBi74uqwmfhM/V1hGVQhe1VxI
 ZIRM7sU8Gb59m3wUO3MAKIZ5dYR8EzS3E2m3M5yuvl+oUnR4h3AKVx2Vu3WWntv9dWJ3
 m6mg==
X-Gm-Message-State: APjAAAXHj+3aLvRlaa4OYFPj4DVGZO9bddIWjwwX/ufIS6uQOtifw3T/
 qYJnRTi9Qjc7vLrQXidgt3hLFggKaVLYo+PKZXq2cQ==
X-Google-Smtp-Source: APXvYqz01xLlTo7egXcYgsYmcrgtlKpwhsRKB3j7tnhm4qAofwwaFUDOsjjKjVXv8QyIU7RpkM6CUj1j9z7pakJXIFo=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr3020111otd.91.1580381687921; 
 Thu, 30 Jan 2020 02:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20200128233224.515233-1-keithp@keithp.com>
 <CAFEAcA_dD3eAfKvOGOoXe3NWKg1PiW8=s2Xk41w19Tk67R-R4A@mail.gmail.com>
 <877e1arz2w.fsf@keithp.org>
In-Reply-To: <877e1arz2w.fsf@keithp.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 10:54:37 +0000
Message-ID: <CAFEAcA8Vs5Bp7tPgxLOG_T0350-Y_w7SitNzNuvHZN6AB=b0gg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add semihosting support [v4]
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jan 2020 at 16:45, Keith Packard <keithp@keithp.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > True but irrelevant. You need to refer to a proper
> > risc-v specification for your semihosting.
>
> The RISC-V Foundation defined semihosting as relative to the existing
> ARM specification, so using a link to that is appropriate here.
>
> Here's the current specification of the unprivileged ISA, which includes
> the definition of semihosting
>
>         https://riscv.org/specifications/
>
> While it may be nice in some abstract sense to create a "better"
> semihosting spec, that's not what the RISC-V foundation has decided to
> do.

We've gone round this several times. You can't just
say "it's the arm spec", because you're not arm and
your architecture is different. You need to actually
document what the architecture-specific parts are,
even if you want to mostly say "and we follow the
Arm spec most of the time". If you really really want
to say "32 bit RISC-V is gratuitously different from
64-bit RISC-V in these areas because we just blindly
copied the way Arm happened to have historically
developed" then you can do that if you like, but you
need to actually write it down in a document somewhere.

You're trying to implement an ABI which has multiple
different implementations of both consumers and
producers; it's not a good idea to shortcut the
process of actually writing down what the requirements
between the two ends are.

thanks
-- PMM


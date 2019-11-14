Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315ADC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC787206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 17:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7hhZ+h9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC787206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVJEd-0007s8-3M
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 12:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iVJDy-0007Ou-Lb
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iVJDx-0001SE-AQ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:48:06 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46271)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iVJDx-0001Rb-4h
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 12:48:05 -0500
Received: by mail-ot1-x342.google.com with SMTP id n23so5574930otr.13
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 09:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8QNX/2fwZOwHDN+u6280guXt0ylhogW9A8B/5AKh9xM=;
 b=P7hhZ+h9gmJOStu1FCNBpieBfFMOe7OTeNHBI4o5SNRn1iMAu9cgz31MhQLdfeVCvM
 +WjQVxKa/b8NSqi78rgJ6wZiMQXdYfAaGWvuV1/BRagwoDvsdqU2BWU4Bs8Vk/r6XcCa
 vaIjJ+Ri18psWmHjleGshJrhiz0NLGQJFR0aHbwj+oVBATCUs+9SYWslXGB06PKjXMm3
 8XfYRhPSGT5lYPEz67dXzixDQk8IR0inBkvIy0q8xh49GGuAJIughFwIoJ6g2xnRI+Jo
 F9DhvK9O9hXEH0ytj9gFWQkuxQwvPvzabPlFtdHgQazHhYnIcGSU2vWc+A5lw8C1Atk+
 F+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8QNX/2fwZOwHDN+u6280guXt0ylhogW9A8B/5AKh9xM=;
 b=XIQ1BXuxB9+cyWzMXx6Z9jqANZdVn1pvLsws4HUfSDWPB5MgHlOWWSSXp0w9/56KmW
 TOct5fSOW1GO+RUnAzt6E+0nt/xf/0YM6zC5Nj4+bYEJW8sOHLZexJ4+rG+LAo0TjXXg
 r7OdMeRbnUeLJ2TFm5RaBeq6HDyztYNbBydQfudB/SISC9OyZoKBKM5MJXEhb+naaRPz
 sf03k6zaiIJcnPClIjPOsPRfNJUvY3lENUnk7RhDvYhCXzktT46hNhCCOHeReiloaZDe
 EtnQfaYdPFUEg/mGTy4/UhYDaAn3XnLqGGCphne45CWlaGURiHKwfoxzZQcZg1qq4Q2C
 vt3A==
X-Gm-Message-State: APjAAAXhSN46C1e8l1nK39W6P29EfyigbAPyGZ3CydL8D3UW+z3ramUr
 2bcjCQXIqO52mLTB1asyE5y5TNHnD9QzWAn6zeIObg==
X-Google-Smtp-Source: APXvYqyc9v5cYlnHVL/VfpnOp24fA7+72TfA4T0filsPRZfDs0xA7R8St8klrPd1+E8bDtXoyml0igQgUbnGuii5yXc=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr7566494oto.97.1573753684088; 
 Thu, 14 Nov 2019 09:48:04 -0800 (PST)
MIME-Version: 1.0
References: <89ada4b1-ee3d-a512-07c2-9bc1ba5806da@redhat.com>
 <20191024224622.12371-1-keithp@keithp.com> <8736fhm9tw.fsf@linaro.org>
 <87pnik4w9n.fsf@keithp.com>
 <CAFEAcA-g+RkvYjseDE=1Z=gnLum0Cjvn_7bqB3ti+cBq9UZ3Eg@mail.gmail.com>
 <87mudo4owu.fsf@keithp.com>
 <CAFEAcA-nnkHuj4y8+vFu5=virUoxwarg=kqQvUWeN73SDs+TzA@mail.gmail.com>
 <87eeymx603.fsf@keithp.com>
 <CAFEAcA9rSS8jwSOSFjHd7GZ0gNywEDDJPBJhJ4FxhyqqtjU6OQ@mail.gmail.com>
 <875zjmuzl3.fsf@keithp.com>
In-Reply-To: <875zjmuzl3.fsf@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2019 17:47:53 +0000
Message-ID: <CAFEAcA-EdFTUZc5+3n1_t=2QUBaaCLUCotu00Ju4UWnLdSgq1Q@mail.gmail.com>
Subject: Re: [PATCH] Semihost SYS_READC implementation (v4)
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 Nov 2019 at 17:39, Keith Packard <keithp@keithp.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > That defines the instruction sequence used to make a semihosting
> > call, but not the specification of what the calls are:
> >  * what call numbers perform which functions
> >  * how arguments are passed to the call (registers? parameter
> >    blocks in memory? other?)
> >  * the semantics of each function supported (number of arguments,
> >    behaviour, error handling)
> >
> > That's really what I had in mind by the overall semihosting spec.
>
> There isn't anything more provided by the RISC-V foundation at this
> point. I'm not sure what else they *should* provide as the goal is to
> match the ARM design, which does specify all of the above.

This isn't obvious if you just say "semihosting".
QEMU currently provides 'semihosting' ABIs for:
 * arm
 * lm32
 * m68k
 * mips
 * nios2
 * xtensa

m68k and nios2 provide basically the same set of calls,
but all the other architectures differe from each other.
"Semihosting" just means "the concept of an ABI from guest
to the debugger or emulator", not a particular ABI.

The ARM semihosting ABI also has a number of warts
which are basically historical legacy. With a clean
sheet you get to avoid some of them. (Notably you could
skip the whole 'negotiate presence of extensions' business
by just getting those parts right from the start. Actually
specifying errno values would also be sensible and is
something the ARM spec sadly does not do and can't really
at this point with multiple implementations in play.)

thanks
-- PMM


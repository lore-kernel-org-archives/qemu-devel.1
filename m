Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201E9C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D151C2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WP45tOUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D151C2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6hM-0002wA-VT
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:49:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iS6Ye-0002jt-NU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iS6Yd-00078W-9x
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:40:12 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37929)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iS6Yd-00077V-2u
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 16:40:11 -0500
Received: by mail-ot1-x344.google.com with SMTP id v24so13710794otp.5
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 13:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LN5H1uVtTYWOit6cP6PnkWxomHLp/dNM+iMBN9+wB1k=;
 b=WP45tOURcQvZXhlpBvA5Zn/PX3z9qaIvykUvMIk0CoFdWWg8ANBPLaKWEseerWhVg3
 as7wvXTFK+a1jzZEsqQ20kzbBmTD09IEzPa4Z5fq5gNndeDv0VqUpNf/IT0iPRaSHYwD
 YMeHRKt95PaFCmUgo0jnSiW//hvQ53oRrZErXPdHQhdqsBIvRK4qv+dpm4wfdRhTFybi
 aRbDsti5sfLqTn3aASehNa5z+HjvzKKp001mgr65yd6M22bMZp7YQh/npV4db/eCkdZy
 CnAHQd3ZBwBj37gl98HU6ongQ4Ls+d8qLZqRwdaV+ANcXvUs7IB4MDIumrjtOlZcW8vX
 ddqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LN5H1uVtTYWOit6cP6PnkWxomHLp/dNM+iMBN9+wB1k=;
 b=Kt0otP6L4k9m/gZ14kOjSHQDT1hV6k8h9migqZ5PmYIxNEdpbbYBempT/7Fb5swVha
 DmrQ92WhG2XN44tF1jdnX6KhkJlw4zvNx1zBd70jAqm8aHenih5dWg182qWoShgIiPMT
 j1wDB3WyL4P1uUaHhLfjXXujGxqft5p4qOCouQoB5hM6sTNZCa05gLYhEOR0b6xseHPp
 UG92B4CPzmcAIJ9JGag8c2tdfk3/5np4M2pLLBfPtFdYyEqgph+TrmO4WqiXiWNMrOb0
 a/NcqhKoJVxVnesz4iMxx6eoQAzjhusiTDlI399Msfj4EYMWfzVVs3mXDzMtrfzEGvnK
 /QEA==
X-Gm-Message-State: APjAAAUSti3cJz811xCH1ugH8sF1zAUyUUu7wGsb3UryE0tHBBnqsRLL
 2oXL9phTiZXKniReeR+oRdRIssT5BMZYZCN+CDxHFg==
X-Google-Smtp-Source: APXvYqzy+PFYCwYOCxWdaOsFEp/CH962W/CN+2S0SgieO5PkCxXredcV292YEYO7EBrUUe+OEOGPi9dh2ZaXd8lOIQc=
X-Received: by 2002:a05:6830:c3:: with SMTP id x3mr6455757oto.91.1572990010218; 
 Tue, 05 Nov 2019 13:40:10 -0800 (PST)
MIME-Version: 1.0
References: <1572911399018.17766@sandia.gov>
 <20191105164253.GJ166646@stefanha-x1.localdomain>
 <CAFEAcA_5ZS=4gHW8yph_o7Z4XrO5r2YMbGTB0oNtQKriv-qS=A@mail.gmail.com>
 <1572988990478.74192@sandia.gov>
In-Reply-To: <1572988990478.74192@sandia.gov>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2019 21:39:58 +0000
Message-ID: <CAFEAcA-EvgXF+fch2ss-NpFt8qLXA844Fay-=be1uQH91Sa05g@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Adding New, Unsupported ISA to Qemu
To: "Hanson, Seth" <shanson@sandia.gov>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 at 21:23, Hanson, Seth <shanson@sandia.gov> wrote:
> I completely understand your concern. Rest assured, this project is entir=
ely internal and requires no code contribution, unit testing, etc. from QEM=
U devs. We simply want to garner as much documentation as possible to ensur=
e optimal conversion/compatibility. My team and I have already completed a =
majority of our instruction set
mapping into TCG. Lately however, we've encountered issues with
floating point operations.

Yeah, for internal forks you have none of the upstreaming
issues (you're merely more on-your-own for figuring out
bugs :-))

> I noticed in the TCG Readme that floating point operations are no longer =
officially supported but were previously (per the last paragraph in 4.1).

Git blame will tell you that that claim about floating point
has been in there since the readme was first added to
the project in 2008. It would be more accurate to say
simply that TCG does not natively implement fp operations.

TCG's approach to fp is to just (at the TCG opcode level)
treat fp registers the same way as integer ones -- they're
32 bit or 64 bit binary values. Mostly fp operations are
implemented by having the TCG code call out to a helper
function, the same way you'd implement any moderately
complex operation that's not easy to do with inline TCG ops.
From the helper function, you can call the various emulation
functions provided by our generic fpu emulation layer
('softfloat') whose headers are in include/fpu. The FPU
emulation provides IEEE-compliant implementations of
various basic operations; you have to tell it how your target
handles things that IEEE 754 doesn't nail down (eg whether
you detect tininess before or after rounding, what your NaN
format is, that kind of thing), through
a mix of calling the functions that initialize the 'float_status'
and also adding to the target-specific ifdeffery in
fpu/softfloat-specialize.inc.c. When your target needs things
that aren't IEEE-specified you just have to implement
emulation of those in your per-target code (arm does this
for the 'recpe' reciprocal-estimate instruction, for instance).

IEEE cumulative exception flags (inexact, denormal, etc)
are tracked in the float_status and need to be made visible
to the guest in whatever fp status register it uses to show
those. The default assumption is that IEEE exceptions
don't generate guest CPU exceptions, but you can implement
the latter if you need it -- see ppc for an example of that.

> Can you please provide documentation for implementing the latter?

As usual for QEMU internals there are no documentation.
You can look at the headers in include/fpu which have some
comments describing the APIs, and at the existing CPUs
which use them to implement their FPU support.

thanks
-- PMM


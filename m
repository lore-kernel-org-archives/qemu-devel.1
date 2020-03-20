Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2568AC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:22:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2C9720724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxZEby7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C9720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKPq-00084f-2U
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jFKPB-0007av-2r
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:21:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jFKP9-0006zy-S7
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:21:52 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:46815)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jFKP9-0006xf-JV
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:21:51 -0400
Received: by mail-oi1-x22d.google.com with SMTP id x5so7025029oic.13
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 09:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EM4PKHel8jgcnWu0r6iUBxzvX1JBMCmh19NcDQzjfeE=;
 b=GxZEby7aFyNSthXdj7p0FbYHdJ9JW5JgSarbkEQtoIvCJgoFSHZ/0NJC0w0nMoLSKc
 dVrnj9Es28JST3aLCV9qeFYmKXYc3LXBkzwJa0BXAbO53DRPgmPrbkPq1QSV45XJnUHr
 s6SvUi4zYfFYWgNYEYB0OCzj4kFnBnIZyAhMWtRmCfG/sLvG7D114bLI4B2lKTuKUneV
 C1wcMEuxrPs9g4cEtYWhF6ct3cOfr/v2lqdd5b1RkCxUm4CRuVTNwOAlHkFDDyJSJGOS
 bHtRHlmhH0tY4LIfnjrVX6TnGuZPXS1SCJ8zbarq6DsJmhiTS0qFI6zJscOnPi/pNSsx
 PYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EM4PKHel8jgcnWu0r6iUBxzvX1JBMCmh19NcDQzjfeE=;
 b=XANBUynEZhfwgWrY2+QSUnVuz6SsMwq2i8KlezTvybEyjTIAigz+e55zocFvWMKQtk
 rWI9W0e+w8rzGxy8v1DtXqISps8LNmMnoF5PnF5yySc476ycHoxkOoGrUo+qrHhMcXtf
 8SEEMlLiCS/KHj9TOctEUNPPOAgJ/IogBshyDMSCBvoPyRWnEl3XXuyXk+Rd7i6dnA4n
 bRGQRgdz/NiZF6xF+mhsBGACVC5omIFNG640GC8FqwwSTNG4eo+9jioIHgeKS2douCCl
 Wni88LV7lQHa50xH05WTu1IUusEfqq+wATEqgaidwDe2eudP+JWE+IzFJw4zy6frwjI3
 R8zw==
X-Gm-Message-State: ANhLgQ0SIYreClUZZ92vBslP7pET2zCtw6OKpKwa58YJgo2Tjs+PVAgS
 STUD4gw8TTQnnsqnCR8+ei5CCyFCKmu8lvs9K9bdaA==
X-Google-Smtp-Source: ADFU+vsdlZzyNOmkpy6ojnkwOxAPkgJKS6GTv4FLDGluakjfrlaGdlAahZkLQ4TwLABSCLICDVCeW2uyf+F5EvaHQm8=
X-Received: by 2002:aca:c608:: with SMTP id w8mr7295888oif.163.1584721310406; 
 Fri, 20 Mar 2020 09:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200320103551.29246-1-f4bug@amsat.org>
 <20200320103551.29246-2-f4bug@amsat.org>
 <c7cf4bab-b9ac-4387-0709-a02c04b24061@redhat.com>
 <e4bc22f6-128d-99e9-9359-3253f666c065@linaro.org>
In-Reply-To: <e4bc22f6-128d-99e9-9359-3253f666c065@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2020 16:21:37 +0000
Message-ID: <CAFEAcA8RM6U1hKX1Wn5YmR71y=VrGimt46z_OR=+O1i9neahiw@mail.gmail.com>
Subject: Re: [PULL v2 05/13] target/rx: CPU definitions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22d
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Mar 2020 at 16:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 3/20/20 9:04 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Not related to this patch, but this line generates a warning with Clang=
:
> >
> >   CC      rx-softmmu/target/rx/cpu.o
> > target/rx/cpu.c:158:33: warning: The result of the left shift is undefi=
ned
> > because the left operand is negative
> >     address =3D physical =3D addr & TARGET_PAGE_MASK;
> >                                 ^~~~~~~~~~~~~~~~
> > include/exec/cpu-all.h:234:45: note: expanded from macro 'TARGET_PAGE_M=
ASK'
> > #define TARGET_PAGE_MASK   ((target_long)-1 << TARGET_PAGE_BITS)
> >                             ~~~~~~~~~~~~~~~ ^
> > 1 warning generated.
>
> >From configure:
>
> > # We use -fwrapv to tell the compiler that we require a C dialect where
> > # left shift of signed integers is well defined and has the expected
> > # 2s-complement style results. (Both clang and gcc agree that it
> > # provides these semantics.)
>
> Clang is *supposed* to be not generating those warnings.

I do have clang in my build tests, so at least some versions of
clang do indeed correctly handle -fwrapv. What version are
you using, Philippe ?

thanks
-- PMM


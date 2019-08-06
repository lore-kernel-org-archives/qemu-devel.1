Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56029C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E832054F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HtidOAbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E832054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hux5Z-0007Mt-86
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 06:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46242)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hux5C-0006wz-QQ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hux5B-0004Uh-NE
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:52:46 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hux5B-0004UQ-HA
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:52:45 -0400
Received: by mail-ot1-x343.google.com with SMTP id j11so34010346otp.10
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 03:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FD8taq4tAnUwC99L2ewlIKcfiNjCbbiaP85GeUPmOV0=;
 b=HtidOAbQ3JaChNArv3ArAPQQtNiYhSaQkpEOOTlxRMzlqcbddp05HZMod9iLNPSJmE
 lHVtQj1SgBgP5EU+Iwtn4yP528Y84YPKZxslBnSjcRhiQszqe9+Cyba25ph2gyq7PcwB
 rTe6KLvixOshbMtdgXcDMSGTiVclB9ufy+iZHp10nslqfnLMYl9BB0+FzqnKPgAMAJbu
 lq79E2zDHUefbrE1V9lw6rxgnYM0eADL44rXDMB0IPQDTPYllYl9u15jJxl6drQ99da1
 Dw6M/NcuPRDn2YXdVvfXXsaNwuXxIyO+1r4Cg11L+vK0ATUInV8DH4Vz4HP0EHLjwsOM
 iC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FD8taq4tAnUwC99L2ewlIKcfiNjCbbiaP85GeUPmOV0=;
 b=V00FPVp6jgRxJiWnd1hfT7CMTpXzLUjgxsa/sr4AKLQHe78KD6DCB+Y4JDHSEC4mEH
 MJv69KlWLhDamWZzqGSbx24Nk8PY0hZOnn0QRBGxFHlUsEDIFmYKya21mFZrkQ6CBkKn
 5W+uMfJVjutJv14oLKKLr974m1wEcj1PmL0NN9YM33yHSVAccS5qq+GnD0sIPM9+SzC4
 uapLutPT1qLBPe96TH9dRDiEMb5mcUqGat1AZSvdMvtmB9jLXq5J0tSqXT2+sMs4xXSe
 yBdnqb9W2DJqIpO6prTbCvkPdQ4RPV1lUFjyxc4NFIhz2jAkKNUILeKLoFHcrQqUBKyd
 UPWA==
X-Gm-Message-State: APjAAAVvIf226TsDiFfpXV0l2oMSXMmRDvuQ4mIvfDaNTFuUWbTXkWV6
 BcPnIM+gAbyDDOSM7xsSJ3zkyu7LED5Ofkuco0TM/w==
X-Google-Smtp-Source: APXvYqzfKEugcMn3hHn5yjXUd02+DI/iAXFDuHnUJa1hTdgZhluPlnpbipHaAqqmLvIrp2gw9OvR+9RsyT31IkgLz7c=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr2693245oti.91.1565088764688; 
 Tue, 06 Aug 2019 03:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190805180332.10185-1-peter.maydell@linaro.org>
 <d788f3ff-6814-117d-942d-7870b6201f30@twiddle.net>
 <56162c59-9da9-d15a-a216-530c673b4592@redhat.com>
In-Reply-To: <56162c59-9da9-d15a-a216-530c673b4592@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 11:52:33 +0100
Message-ID: <CAFEAcA9BxRuYE04i=unMH_MyWmpC17ohreRK5dQDDu45SDzcEw@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] target/i386: Return 'indefinite integer
 value' for invalid SSE fp->int conversions
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
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Aug 2019 at 00:16, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 05/08/19 23:13, Richard Henderson wrote:
> > On 8/5/19 11:03 AM, Peter Maydell wrote:
> >> The x86 architecture requires that all conversions from floating
> >> point to integer which raise the 'invalid' exception (infinities of
> >> both signs, NaN, and all values which don't fit in the destination
> >> integer) return what the x86 spec calls the "indefinite integer
> >> value", which is 0x8000_0000 for 32-bits or 0x8000_0000_0000_0000 for
> >> 64-bits.  The softfloat functions return the more usual behaviour of
> >> positive overflows returning the maximum value that fits in the
> >> destination integer format and negative overflows returning the
> >> minimum value that fits.
> >>
> >> Wrap the softfloat functions in x86-specific versions which
> >> detect the 'invalid' condition and return the indefinite integer.
> >>
> >> Note that we don't use these wrappers for the 3DNow! pf2id and pf2iw
> >> instructions, which do return the minimum value that fits in
> >> an int32 if the input float is a large negative number.
> >>
> >> Fixes: https://bugs.launchpad.net/qemu/+bug/1815423
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >> I've tested that this fixes the LP:1815423 test case. If anybody
> >> has an x86 VM image to hand that has node.js installed it would
> >> also be useful to test the operations in
> >> https://bugs.launchpad.net/qemu/+bug/1832281
> >> (I don't have such a VM.)
> >>
> >> The other approach here would be to make the softfloat functions be
> >> flexible enough to allow this behaviour -- from my reading of IEEE754
> >> I think the exact returned result for 'invalid' inputs for float to
> >> int conversions is not specified.
> >>
> >>  target/i386/ops_sse.h | 88 +++++++++++++++++++++++++++++--------------
> >>  1 file changed, 60 insertions(+), 28 deletions(-)
> >
> > I guess this is exactly what we already do in fpu_helper.c.
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >
> >
> > r~
> >
>
> Queued, thanks.

Would you like me to do a quick respin to fix the overlong lines
that checkpatch noticed ?

thanks
-- PMM


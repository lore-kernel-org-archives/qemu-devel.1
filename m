Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEB2C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B821921019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7x2SuGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B821921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36110 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTng0-00018d-Ue
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:22:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnNl-0001Po-PF
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnNg-0007Ou-Db
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:03:41 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTnNg-0007NU-2x
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:03:36 -0400
Received: by mail-oi1-x244.google.com with SMTP id u64so4293505oib.1
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=SRdaUVaPAIongb3FeH0Daw2vmeYzyFXzmMqxX+jMjDY=;
	b=e7x2SuGVNTzIYl5PeWJSBoUQRPWD5pAIRG0ZxdRRp3QonI3xpgTCUrjKpbtA8HoPnU
	9XGkV8LzwPEN/rUwpGpUXXEpn+jhyTjiB3wPf/4hSRxNDTdolH9EWqvAWW2buE52605h
	zN7sGTAHinq/JpaYlnzJ4fiv7bTvKbhIRmSGugFKlFePiFl7McvD3DnT9S2jtbmg9faU
	pCdwOccDVm4UWgN+/KE8OcX958oAcvboPD0TPox2hJYYdms0EzlX1Pttnc4cjkMNvQiW
	8SgzaF5PGUiI8FQUSCA5o6J06ZilOUDDwy+UB2js1lglXId66muE6wVDX23gzd/4LTko
	ZYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=SRdaUVaPAIongb3FeH0Daw2vmeYzyFXzmMqxX+jMjDY=;
	b=NnW75KBN58yUzdX11LhTbhW9Lt6JW3TXMYzrixVlsjm/HF9IWIEVz61RF+eGCGeRfl
	BK2QuKF9FcUalOoryltEg/htwqgd2z3hpy3nz6lwr1sgUprwymaTTOi/x3dIWjmn6tbD
	JVEH2RMbrDo/LbaZ9fDobWltYsXnZ9gDR83i7nt6oQUMOUahklRxKPB8g+RH3niCuj8w
	Yc5TgUgNZDgHwcNJctV/pAPp7Y7ez+h4ss/1dawrMnNVbfBJle676l2Y0BTmRu2RB2Vs
	QpqXMsNxAGcElukc56b32ZjI7P//m4Zoc4UoTG80VysY93IXLyz1B2ohDw2j82sK3D+v
	hmtQ==
X-Gm-Message-State: APjAAAUQp4+MfEr5AREpBaUUsGlq5/zGAR6odIk+TPKY8TchSPMTB+Cp
	GDIBe5gnFIh6UtlFvxORMo9mQkxa5F2VLvW1Dg/D4g==
X-Google-Smtp-Source: APXvYqwx+lgwxt1Y3Vl8MzuijrDlUejHwbWbYrSqdgCdo8OCKpsF5uwgzJ6VrXyvYdG8bU/X+OqPVeqSGyyZNAcVCoA=
X-Received: by 2002:aca:5785:: with SMTP id l127mr2509225oib.48.1558616613920; 
	Thu, 23 May 2019 06:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190518191934.21887-1-richard.henderson@linaro.org>
	<20190518191934.21887-2-richard.henderson@linaro.org>
	<CAFEAcA8rbLn53iP8SBKpDju-5n=u8ieWW6=RF8t37nF0UspNkQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8rbLn53iP8SBKpDju-5n=u8ieWW6=RF8t37nF0UspNkQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 14:03:22 +0100
Message-ID: <CAFEAcA_MnfJokoggLb5WmhaCZuPb8y7E8L5P+KO=nNaGyKUKAA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: Re: [Qemu-devel] [PATCH 1/2] target/arm: Vectorize USHL and SSHL
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 13:44, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sat, 18 May 2019 at 20:19, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > These instructions shift left or right depending on the sign
> > of the input, and 7 bits are significant to the shift.  This
> > requires several masks and selects in addition to the actual
> > shifts to form the complete answer.
> >
> > That said, the operation is still a small improvement even for
> > two 64-bit elements -- 13 vector operations instead of 2 * 7
> > integer operations.
> >
> > +void gen_ushl_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> > +{
> > +    TCGv_i32 lval = tcg_temp_new_i32();
> > +    TCGv_i32 rval = tcg_temp_new_i32();
> > +    TCGv_i32 lsh = tcg_temp_new_i32();
> > +    TCGv_i32 rsh = tcg_temp_new_i32();
> > +    TCGv_i32 zero = tcg_const_i32(0);
> > +    TCGv_i32 max = tcg_const_i32(32);
> > +
> > +    /*
> > +     * Perform possibly out of range shifts, trusting that the operation
> > +     * does not trap.  Discard unused results after the fact.
> > +     */
>
> This comment reads to me like we're relying on a guarantee
> that TCG doesn't make, but in fact the readme says it does:
> out-of-range shifts are "unspecified behavior" which may give
> bogus results but won't crash. Perhaps phrasing the comment
> as "relying on the TCG guarantee that these are only
> 'unspecified behavior' and not 'undefined behavior' and so
> won't crash" would be clearer ?

I had a look through the rest of the patch, but there is
too much code here and I don't have enough context to
figure out how all the various new gvec helpers are
called and what jobs they are doing compared to the
actual instruction operation. Maybe I'll have another try later.

Why can we get rid of the 8-bit, 32-bit and 64-bit old shift
helpers, but not 16-bit ?

thanks
-- PMM


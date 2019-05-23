Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048F2C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C8120862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vifgh2ZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C8120862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36217 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnjh-0004fo-0d
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:26:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnSS-0006SC-15
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTnSQ-0002jw-Nw
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:08:32 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTnSQ-0002ii-C9
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:08:30 -0400
Received: by mail-ot1-x342.google.com with SMTP id t24so5299225otl.12
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=iNi4D6yP+yLWr/A+HIxi2BRqJ+LMGJAMgF+vXMY9VHA=;
	b=Vifgh2ZNQk4CXRkJydrqZCaMJ2lIKw8VAWPXQSP9SPi+Va9+bgHqonE66Bt9DqwAUj
	g2AVU6jTIlQrnWkI5bmZiUfBS1WUYdxlSnWnpbeUXlBYUTv1zWd/HOHQ90uDHDeab/NX
	J3UFeox467tpmWhvLfzi+HJ5OdSR1IV7rj/7Hbb181sgFNfDe6xcHKln0ZZbpFiLlbE7
	IyZf3b2gbqr+22W15xQrthBZWSB/fYd64WrZqF2ReY3Y+yFGLyKUSn6+4gBU3a4V50tC
	WmWEgaHvdfw83A5h3mlA/DgtxenSdeH3aDUFG9tvs3+hJAbGlsmK5b9FzdKKOQBqoVp5
	ZmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=iNi4D6yP+yLWr/A+HIxi2BRqJ+LMGJAMgF+vXMY9VHA=;
	b=aHgkV1cQ/k52fKYx+mULXMR2RCarq4KWD3cyk4gDeO5nr2GfVYoxZo3PDeuIjQ0wrU
	mDVVrpX93G/PDwY7inZ7n8N9KnfQ3xeECkm+Elg1v/FUgNIfUKztjLBJr42DDyeebJkp
	bfRAMhueNDAYOSrcoxXfIjWksst3xLiPkMAW45AwRGnpXZaw2IPsAOFKbHJBVUMPL3oM
	FpZY1FLojyJll3pe+6b90fvy3pmAR1Sii+S2ycnHKEGb2JpjUvoHFgTdr9Jl1q0CH+iB
	gYDA+lX+E2pk5L3/J2zCWvDh+WpG7VUbNWOBD6JjVnkM0Mrp6H8xjm02QyVq+PPnDEz+
	4x3w==
X-Gm-Message-State: APjAAAXOdvpaJ+nr32pOXx/jltBbpShWnY8A1b1A4AFi3gWB2kB7a/QD
	WjCYFeueIHUKHxkrHm38kF9xMOUKiQwKjnbs2SuAQg==
X-Google-Smtp-Source: APXvYqz1fEMnjL0jID9teb73Gen7dXL+MfBFRMSECOtdw7R4tjQ0uijhCRtfWpawl02DGk3zt33nOtKrb1ice/VXZKk=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr21145703otp.91.1558616908221; 
	Thu, 23 May 2019 06:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190518191934.21887-1-richard.henderson@linaro.org>
	<20190518191934.21887-3-richard.henderson@linaro.org>
	<CAFEAcA88nA_2u1Yc-9ZPAy2w6LVk5f9Rrss0e53E11W4Xb4YpA@mail.gmail.com>
	<e177b43a-2abc-3aee-461c-2cfd9a8a0a20@linaro.org>
In-Reply-To: <e177b43a-2abc-3aee-461c-2cfd9a8a0a20@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 14:08:17 +0100
Message-ID: <CAFEAcA_1XuWqVu9gonn5_Y9x1V=UcWNHEXtwop2s0qyUbwiZpg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Use tcg_gen_gvec_bitsel
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

On Thu, 23 May 2019 at 14:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/23/19 8:46 AM, Peter Maydell wrote:
> > On Sat, 18 May 2019 at 20:19, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> This replaces 3 target-specific implementations for BIT, BIF, and BSL.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> @@ -10916,13 +10925,13 @@ static void disas_simd_3same_logic(DisasContext *s, uint32_t insn)
> >>          return;
> >>
> >>      case 5: /* BSL bitwise select */
> >> -        gen_gvec_op3(s, is_q, rd, rn, rm, &bsl_op);
> >> +        gen_gvec_fn4(s, is_q, rd, rd, rn, rm, tcg_gen_gvec_bitsel, 0);
> >>          return;
> >>      case 6: /* BIT, bitwise insert if true */
> >> -        gen_gvec_op3(s, is_q, rd, rn, rm, &bit_op);
> >> +        gen_gvec_fn4(s, is_q, rd, rm, rn, rd, tcg_gen_gvec_bitsel, 0);
> >>          return;
> >>      case 7: /* BIF, bitwise insert if false */
> >> -        gen_gvec_op3(s, is_q, rd, rn, rm, &bif_op);
> >> +        gen_gvec_fn4(s, is_q, rd, rm, rd, rn, tcg_gen_gvec_bitsel, 0);
> >>          return;
> >
> > We were previously doing different operations for these three
> > different instructions. Now we seem to always be doing the same
> > thing but with randomly reshuffled register arguments. How
> > does this work ?
>
> Because the three different instructions perform the same operation with
> reshuffled register arguments.

Ah, so they do. Next question, how do I find out what the
order of arguments in the above code means so I can compare
it against the pseudocode expression we're implementing?

thanks
-- PMM


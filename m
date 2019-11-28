Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BD2C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F05A21739
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 18:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ceO8/vrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F05A21739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaOzb-0005zY-MR
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 13:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iaOCU-0008Iq-NP
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 13:07:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iaOC2-0001k4-6e
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 13:07:08 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iaOBz-0001In-CP
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 13:07:05 -0500
Received: by mail-ot1-x342.google.com with SMTP id z25so22862166oti.5
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 10:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MJ/sPAYYo/qIT6Ymk401e7KF1FY+ovzNTYrgqfqtAao=;
 b=ceO8/vrDQ2qOydIvWROnG21GPOQXjsjM2lcssYAr/Un9ibzuSQx2OcRLffVjR3zPzA
 euVSLuH5Lz548pvc9MxMZAkFhKWeWv4h5o/Qdb6InyGjX9x53JeE00vsuWbI1TzId9Bd
 xlFrw5neBnwiXTkXrSzSBveIjG4mJ24IzgNFoxMwc4Ma7gPjF0c5+UuxFCZyFGpBn15Z
 IqthMaHfqKFC15Ac8mS7MIm+UmVOVg3AYRCDKwKk8yFFdn7/44wsPLdVKHshOb3snQir
 4dLhMUOs1e7xN0WDxanGDSIVELGf/bfAW9dlSECX5lLdhb5rZ0GejbmQ5TtGyoMtwSMY
 NLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MJ/sPAYYo/qIT6Ymk401e7KF1FY+ovzNTYrgqfqtAao=;
 b=OooylE3xGPf5SujGJDQhOtKLiz7ByiICdK0h8qjw8iP1R4dCIAUBfoOAFvtKBdk4gh
 Kp6JCmb6dC22ts1a3HwfQuTKIxrqRAovQ34UJyOQRVSjs+ng50ipI/HB63T6VZt0s07Y
 bNtZGlNg2K3SnTM29Q7DPGe+pxBhiTvrNLcnfaHWPwweCZ1J1mJMAigV+enhCw09G/Um
 DqzNpGPdkGRQAWo8OMm2rGuNgC/v+PnNr1WOQvd7ta6NvUdmFw1KFr8OL6LTbvJ9M39e
 uh7ijStXSEsVcN4r+mxzTHrVwmWwzEbAmkny0WQxfrNJHLGtZ4Vk13d28yz+pMlWIpDW
 /Ktg==
X-Gm-Message-State: APjAAAUyRkQhqE/flMDmOfdbfQiEOS6O13erPIPSNy4kX4+2cJdwZe/j
 tYeZCy09PHaZr/SGp5KFWZLcs3ZvQ9c0wvGwua67Nw==
X-Google-Smtp-Source: APXvYqxKt6orc45dUEB80sWtPH3EOZaBWL5mcL78hz6t2FcSeKfkc4eWV9sd8pVJf+Hx1HeefjCsanKuSB6IJOjlkFk=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr8682308otg.232.1574964417343; 
 Thu, 28 Nov 2019 10:06:57 -0800 (PST)
MIME-Version: 1.0
References: <20191128161718.24361-1-maz@kernel.org>
 <20191128161718.24361-4-maz@kernel.org>
 <CAFEAcA_MED0Rtqo1=HNnn7v_zQZGDsoJVsbXAsdhb_sAjvJ40Q@mail.gmail.com>
 <241a27adc76f3f6dcc96c3ef993660f7@www.loen.fr>
In-Reply-To: <241a27adc76f3f6dcc96c3ef993660f7@www.loen.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Nov 2019 18:06:46 +0000
Message-ID: <CAFEAcA9yryMgAgNbbST4ThT_ozpBUm=Lj5C33ZBP_Q8OYiV_=Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
To: Marc Zyngier <maz@kernel.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 Nov 2019 at 17:49, Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Peter,
>
> Thanks for having a look at this.
>
> On 2019-11-28 16:43, Peter Maydell wrote:
> > On Thu, 28 Nov 2019 at 16:17, Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> HCR_EL2.TID3 requires that AArch32 reads of MVFR[012] are trapped to
> >> EL2, and that HCR_EL2.TID0 does the same for reads of FPSID.
> >> In order to handle this, introduce a new TCG helper function that
> >> checks for these control bits before executing the VMRC instruction.
> >>
> >> Tested with a hacked-up version of KVM/arm64 that sets the control
> >> bits for 32bit guests.
> >>
> >> Signed-off-by: Marc Zyngier <maz@kernel.org>

> > Since the syndrome value depends only on these two things,
> > you might as well generate the full syndrome value at
> > translate time rather than doing it at runtime; then
> > you only need to pass one thing through to the helper rather
> > than two.
>
> OK. This means that the register check in check_hcr_el2_trap
> will need to extract the register value from the syndrome.
> Not a big deal, but maybe slightly less readable.

Oops, I hadn't noticed that we were switching on reg.
Yeah, you might as well leave it as is. (We could have
a separate helper for each of TID0 and TID3 but that
seems like overkill.)

> On a vaguely tangential subject, how are conditional instructions
> JIT-ed? I could perfectly imagine a conditional VMRS instruction,
> but none of the code I looked at seem to care about it. Or is
> that done before the access itself is actually emitted?

Arm conditional instructions are handled at a pretty
high level in the decode, because they all work the same way.
In disas_arm_insn() we have:

    if (cond != 0xe) {
        /* if not always execute, we generate a conditional jump to
           next instruction */
        arm_skip_unless(s, cond);
    }

and there's something similar in thumb_tr_translate_insn()
which puts in a branch based on the thumb condexec bits.
The target of the branch is a label whose position is
set either in arm_post_translate_insn() after the code for the
insn is emitted, or in arm_tr_tb_stop() if the insn is
the last in the TB (always true for branch or trap insns).

thanks
-- PMM


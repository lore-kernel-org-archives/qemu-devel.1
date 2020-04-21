Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA07C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 885E0206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a0qmtK6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885E0206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQpJ9-0003H0-OK
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQpIQ-0002eF-Av
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQpIP-0008Hy-00
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:34:26 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQpIO-0008Eh-Bh
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:34:24 -0400
Received: by mail-oi1-x244.google.com with SMTP id j16so11452350oih.10
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s/zAJIUxNrxYoJ0x/HJnhpypVh0XlsT3XQ8awieQzBc=;
 b=a0qmtK6grY2WkffuCofTeWpSL4BkmZmOoMpHNBvQ9+z+xUEX3pruCyioFzbdKUUkfD
 3RRBN2WYNfAxRmH8sIC9TMPXxWSupEyD+Vi6fEb75Mu2+kjByVAhh3wGbriCZhHFTSmI
 VKpw2P+4/zcbyVEKtwXsXeV2jdVps/7HLZbrbvDY4FZndQSQmmJoKYKKo+bFCoSPZJGx
 iN3rpGZ5T3H4LGYD9QMTvieFhWZptcdGLCBiDBifzR4IMVlcO2jgLRQON2DXcQpJHXWe
 +7MhUGqXzbLLsfWSC/xgNBmC66W4a4MjFs5Va78sKhf/G50s8TEnZj6FUr4PZwTccKab
 eaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s/zAJIUxNrxYoJ0x/HJnhpypVh0XlsT3XQ8awieQzBc=;
 b=c28bzWtwSPSxjoFkBgtyOHV0clNtw3iOOQO4RmZaNjMs+Q8j02SCtpQMCt9T4TMq1a
 5aYuU0geuyXHpK1CMxZOE8C6TpApGMjo+DEIX6Ooa3ulfE2/S/kHFHKjRKSmwf3cD88M
 JUKVrbaJRjsScBjnDTMTFHBvUG9ek4/rUQ80EPcCCCXaWTls8z/FOJ4TEhrbuPK4a4XV
 mNF33sX6mb+hSyHFYcR8z5x/asI1U7VR63hpHJEa7r5AqYX/WA9viF7RjzP4/70BkcTx
 3rX0J0xQ8ZDOuBIeXoPcatz4nJiiXwK+aOZB1BL93e4WFkihIUfa5rIHHbghgWKQWBcy
 lX1Q==
X-Gm-Message-State: AGi0PubWYCcMUAKPBpcI45a4hseCa4yCfxpLRQ6er3HMlWwF3sTpAi24
 GhxnrQr39jGPNY403ohqT1h0tn4SwwNN4btv0JRyyA==
X-Google-Smtp-Source: APiQypKg6+aMTf/Md7wrAdS8yDtwYYzfHflx8b/wwGb4M/EdccznMDgHc0EcMvOsqCImTtCJ/9OK4zNIl6ZwQPuwvD8=
X-Received: by 2002:aca:dc56:: with SMTP id t83mr2390084oig.48.1587461662996; 
 Tue, 21 Apr 2020 02:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200420212206.12776-1-peter.maydell@linaro.org>
 <20200420212206.12776-4-peter.maydell@linaro.org>
 <CAHiYmc6zqMve7J2nMqRD=nZXLMaVN+8kYB7_LtAf_4BNYu+Wug@mail.gmail.com>
In-Reply-To: <CAHiYmc6zqMve7J2nMqRD=nZXLMaVN+8kYB7_LtAf_4BNYu+Wug@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Apr 2020 10:34:11 +0100
Message-ID: <CAFEAcA_OdxjcFc_mpCdoiP9G=mJhpnJ7te=VCHiHpRmb-O78Ng@mail.gmail.com>
Subject: Re: [PATCH 3/4] linux-user/arm: Handle invalid arm-specific syscalls
 correctly
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: omerg681@gmail.com, qemu-arm <qemu-arm@nongnu.org>,
 Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Apr 2020 at 10:32, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> =D0=BF=D0=BE=D0=BD, 20. =D0=B0=D0=BF=D1=80 2020. =D1=83 23:25 Peter Mayde=
ll <peter.maydell@linaro.org> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > The kernel has different handling for syscalls with invalid
> > numbers that are in the "arm-specific" range 0x9f0000 and up:
> >  * 0x9f0000..0x9f07ff return -ENOSYS if not implemented
> >  * other out of range syscalls cause a SIGILL
> > (see the kernel's arch/arm/kernel/traps.c:arm_syscall())
> >
> > Implement this distinction. (Note that our code doesn't look
> > quite like the kernel's, because we have removed the
> > 0x900000 prefix by this point, whereas the kernel retains
> > it in arm_syscall().)
> >
>
> Hmm, I suspect other targets could have a similar problem.
>
> I am definitely going to take a look at the mips target, but did
> you Peter have a chance to take a more global look whether
> this problem is actually widespread?

My guess is that this is Arm-specific, because both the OABI-vs-EABI
"do we pass the syscall number in the insn immediate field or
via a register" changeover and also the oddball "arm-specific
handful of syscalls in a distinct range" are Arm hacks, not
something the kernel deals with in generic code.

thanks
-- PMM


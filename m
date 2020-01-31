Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28971C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99D9205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xlBKCqbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99D9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixW39-0000DL-5a
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 08:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixW0M-0005Yj-Cx
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixW0K-0007kC-3l
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:06:38 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixW0J-0007i3-Gz
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:06:36 -0500
Received: by mail-oi1-x241.google.com with SMTP id i1so7137421oie.8
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 05:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=buu9s3cSE4Z+dUhMarYywYO9VZOciHOl5cGsLW5o5rw=;
 b=xlBKCqbTMX9Sz2LzaWsG3CyWLBtEeB6M61pR3L5O9RlpXLesrc6f3q94KUObRnx19+
 usp0ohWJ1cV23Zd8pBU8Ig41CQXCaSkSW08cl8m001rOQ7VduE8sFlhovYJIviOmrEzA
 Vyt8wXTI4nWVvgoflw5AeUHizSdnBSk81Sqr2HVRj8Q9MtRs2NjVOPfiEbZBwhuslFCW
 xMX05GHyp9dIysGlK8BqNUx1uNUd7cqfwFae6FtnxQPBNCKFIL29VSqauL3tShtoik3m
 i0Gw5gUHWULSHkZb/RJMRrR4mDwoSI38z4emO8vtFq4DaqsBLgvZD3Y/9dCttf60s4xL
 j/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=buu9s3cSE4Z+dUhMarYywYO9VZOciHOl5cGsLW5o5rw=;
 b=Yg4rVWejfyE33YIU8NDDRxA5AdOtHuktB1e2c32UJPitood6/41HKyaEj9TOgzogJn
 nnSVv2vSysw5G7gVal4d84AQ6zGfxWVr62aXrZuHtWtR/HO+Nz6ZvGccB2HVq1mlm99k
 Y366Wty/tes6rhgWRn78YPyX5ZCFBpwBtgBWbGsUl+dXH7g3Rp5tiNUc4Zr8OOpLMft0
 ZKdrnk3naZF+jk7rcX17uafevnmV+uO3WPoB5rneA4XQbY120qcWJY+u/fL+klIGet4W
 x9uYkKjZFUEm26ZLfsMTdkz6+GVscj+v16AZwZEkkkJ/jMVJDmCaYb2ec//p8ys1Id8f
 188w==
X-Gm-Message-State: APjAAAWJAAAczEeAfbr0RxYBiczR6gO5/Na59URQky77JU3csTrNhhkC
 RQvHW5yXO06bpYy4o3rEi+gsNG1jbw6Zqke76rtRSg==
X-Google-Smtp-Source: APXvYqz1+ZnCPrtYznQrImz8hni73fsMFP0zVLIEHrV89mv3JyDQXBX3KBQ7MpWZnOUoXaNTL7thaT1Dvl86rEqXkFo=
X-Received: by 2002:a05:6808:3b2:: with SMTP id
 n18mr6034414oie.146.1580475994162; 
 Fri, 31 Jan 2020 05:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20200129235614.29829-1-richard.henderson@linaro.org>
 <20200129235614.29829-3-richard.henderson@linaro.org>
In-Reply-To: <20200129235614.29829-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jan 2020 13:06:23 +0000
Message-ID: <CAFEAcA8bX4h1hjOaRv7n0wH+F+2QAVjx4wPBXCdk+RbGW0g6Sw@mail.gmail.com>
Subject: Re: [PATCH v5 02/41] target/arm: Enable HCR_E2H for VHE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Wed, 29 Jan 2020 at 23:56, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    | 7 -------
>  target/arm/helper.c | 6 +++++-
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 0477cef1ea..239c9eb783 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1417,13 +1417,6 @@ static inline void xpsr_write(CPUARMState *env, ui=
nt32_t val, uint32_t mask)
>  #define HCR_ATA       (1ULL << 56)
>  #define HCR_DCT       (1ULL << 57)
>
> -/*
> - * When we actually implement ARMv8.1-VHE we should add HCR_E2H to
> - * HCR_MASK and then clear it again if the feature bit is not set in
> - * hcr_write().
> - */
> -#define HCR_MASK      ((1ULL << 34) - 1)
> -
>  #define SCR_NS                (1U << 0)
>  #define SCR_IRQ               (1U << 1)
>  #define SCR_FIQ               (1U << 2)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 19a57a17da..f5ce05fdf3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4721,7 +4721,8 @@ static const ARMCPRegInfo el3_no_el2_v8_cp_reginfo[=
] =3D {
>  static void hcr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t=
 value)
>  {
>      ARMCPU *cpu =3D env_archcpu(env);
> -    uint64_t valid_mask =3D HCR_MASK;
> +    /* Begin with bits defined in base ARMv8.0.  */
> +    uint64_t valid_mask =3D MAKE_64BIT_MASK(0, 34);
>
>      if (arm_feature(env, ARM_FEATURE_EL3)) {
>          valid_mask &=3D ~HCR_HCD;
> @@ -4735,6 +4736,9 @@ static void hcr_write(CPUARMState *env, const ARMCP=
RegInfo *ri, uint64_t value)
>           */
>          valid_mask &=3D ~HCR_TSC;
>      }
> +    if (cpu_isar_feature(aa64_vh, cpu)) {
> +        valid_mask |=3D HCR_E2H;
> +    }
>      if (cpu_isar_feature(aa64_lor, cpu)) {
>          valid_mask |=3D HCR_TLOR;
>      }

Should HCR_E2H be in the list of bits for which we do
a tlb_flush () in hcr_write()? (Currently we do this for
VM, PTW and DC.) Given some of the later TLB-flushing
changes have code that is "we only need to flush these
TLB indexes when this register is written if E2H=3D=3D1",
it makes it easier to be sure we have the right behaviour
if we don't need to think through scenarios of "write
to the register, then set E2H=3D=3D1"...

thanks
-- PMM


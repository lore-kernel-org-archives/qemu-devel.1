Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3785C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBDA4206B8
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 11:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PC49UBPR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBDA4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYs9-0002wk-Rh
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 07:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVYqg-0002Fs-Gh
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:01:22 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:36691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVYqe-0004DH-Ha
 for qemu-devel@nongnu.org; Mon, 04 May 2020 07:01:22 -0400
Received: by mail-oo1-xc41.google.com with SMTP id x17so2287083ooa.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 04:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yVE7OOtaWQAFzH7p9MnmKbIDdEATimu8INHSV0tg5EM=;
 b=PC49UBPRPHrOUzboVrOATwHK6AmFE70aObSfYq2INQkRmLMV4oFSlxfloWbCdMAY2d
 NiSfPuwdYVgVmyW4zb+r6eSMeaRouLmIociUMAXz8nNLBRJwJXGAQp8DVJethyr6Twib
 w3HNNlI8kCe04rsEZs/X5nulBsYMEWkV4rNf+ABLpe874jdesO10WTziAfq8fIXidSHz
 T7E5pBdp6cfoxegTrqawlDpe0tiN6E+fHR+UJaJl9irveiwsDXaELQ6VZ5Zlp0QVEgoS
 euxdjd3r4Mb+SL57ToK2ek2LaWI2Oih/uZ7MlVIcBLwfVkfHowopFCdviJxWLAYBNpka
 OPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yVE7OOtaWQAFzH7p9MnmKbIDdEATimu8INHSV0tg5EM=;
 b=BWgBhYTYneJrm6FDUR1cVD7UfJILVE6nNIF232alYdN43CyrYUS/JBlAdOnRos2c5o
 Dmmdtw9jvZcceDSA7x31BIon6ZlIIDb/9JOkl0zXpuG05HcJxfPlD87qCudHyazinf31
 uz68NhjKZ0Z+E68ncBtZrCa5qbUL9Itb/VaVYCZk829EyoU63G/++E4oIWXDbdQ6qymL
 lBJ8hBloBTpOTrajuF9RyOLnc9JxYCcs4jRR0ejCOQ7HL0ZAw1w2FY9j07Y0e0Vk95pQ
 Y2lu7bEFdembjUqPgYHofCGSay8chjkPm+X4wL/AZjUDuDmeLUvteluYt1SUqeEGrYgz
 cvZQ==
X-Gm-Message-State: AGi0PuZeLn4yXj8Jm/wHuwUnnrAirswsJWByrsiuR7VIeabhlHL7sXbh
 5U1pFqp/4ayviyXPD72OHvPfVk5IJRrOEyIzSDF/iA==
X-Google-Smtp-Source: APiQypLAjFNJSjf7mSLhhyPknNQBFnjS2iNiSnrI999nbUZdl/OYkT/Nf5z7MB7yuIdKvAp2brIlTGZmnRRlEPMASrU=
X-Received: by 2002:a4a:8253:: with SMTP id t19mr14372489oog.69.1588590078678; 
 Mon, 04 May 2020 04:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200428160350.10030-1-edgar.iglesias@gmail.com>
 <20200428160350.10030-2-edgar.iglesias@gmail.com>
In-Reply-To: <20200428160350.10030-2-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 May 2020 12:01:07 +0100
Message-ID: <CAFEAcA97vRE9yEPHFEBA8tw_K6Zzv0O9K=reHHP41T2GtKj44A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] target/arm: Drop access_el3_aa32ns()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Apr 2020 at 17:03, Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Calling access_el3_aa32ns() works for AArch32 only cores
> but it does not handle 32-bit EL2 on top of 64-bit EL3
> for mixed 32/64-bit cores.
>
> Fold access_el3_aa32ns() into access_el3_aa32ns_aa64any()
> and replace all direct uses of the aa32 only version with
> access_el3_aa32ns_aa64any().
>
> Fixes: 68e9c2fe65 ("target-arm: Add VTCR_EL2")
> Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

So, this is definitely a bug, but I think we could be
clearer about what we're fixing.

For all these registers, the way the Arm ARM pseudocode phrases
this access check is:
 * for the AArch64 view of the register, no check
 * for the AArch32 view of the register:
      ...
   elsif PSTATE.EL == EL2 then
      return VTTBR;
   elsif PSTATE.EL == EL3 then
      if SCR.NS == '0' then
          UNDEFINED;
      else
          return VTTBR;
(similarly for the write path). We don't implement the HSTR.T2
traps, so for us these registers are all .access = PL2_RW and
we just UNDEF for all EL0/EL1 accesses.

So what we're really trying to check for is "current EL is EL3
and we are AArch32 and SCR.NS == '0'". Because it's not possible
to be in AArch32 Hyp with SCR.NS == 0, the check we make in
your function is an equivalent test, but we could improve
the comments:
> ---
>  target/arm/helper.c | 34 ++++++++++------------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7e9ea5d20f..888f5f2314 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -504,29 +504,15 @@ void init_cpreg_list(ARMCPU *cpu)
>  /*
>   * Some registers are not accessible if EL3.NS=0 and EL3 is using AArch32 but
>   * they are accessible when EL3 is using AArch64 regardless of EL3.NS.

This could be rewritten as:
   Some registers are not accessible from AArch32 EL3 if SCR.NS == 0.

> - *
> - * access_el3_aa32ns: Used to check AArch32 register views.
> - * access_el3_aa32ns_aa64any: Used to check both AArch32/64 register views.
>   */
> -static CPAccessResult access_el3_aa32ns(CPUARMState *env,
> -                                        const ARMCPRegInfo *ri,
> -                                        bool isread)
> -{
> -    bool secure = arm_is_secure_below_el3(env);
> -
> -    assert(!arm_el_is_aa64(env, 3));
> -    if (secure) {
> -        return CP_ACCESS_TRAP_UNCATEGORIZED;
> -    }
> -    return CP_ACCESS_OK;
> -}
> -
>  static CPAccessResult access_el3_aa32ns_aa64any(CPUARMState *env,
>                                                  const ARMCPRegInfo *ri,
>                                                  bool isread)
>  {
> -    if (!arm_el_is_aa64(env, 3)) {
> -        return access_el3_aa32ns(env, ri, isread);
> +    bool secure = arm_is_secure_below_el3(env);
> +
> +    if (!arm_el_is_aa64(env, 3) && secure) {

We could either rephrase this as
       if (!is_a64(env) && arm_current_el(env) == 3 &&
           arm_is_secure_below_el3(env)) {

or just have a comment
       /*
        * This access function is only used with .access = PL2_RW
        * registers, so we are in AArch32 EL3 with SCR.NS == 0
        * if and only if EL3 is AArch32 and SCR.NS == 0, because
        * if SCR.NS == 0 we cannot be in EL2.
        */

depending on how much you proritize a more efficient test
over a more clearly correct test :-)

> +        return CP_ACCESS_TRAP_UNCATEGORIZED;
>      }
>      return CP_ACCESS_OK;
>  }

Also, once we don't have a distinction between two different
flavours of this access function we should use the simpler
"access_el2_aa32ns", rather than ending up using the longer
name for the one version of the function we're keeping.

thanks
-- PMM


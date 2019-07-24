Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E53BC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A4A0229ED
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jj1Tpsaj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A4A0229ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqFlx-0002dl-OD
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34292)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqFln-0002FO-Ly
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqFlm-00007c-JB
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:49:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqFlm-000071-Bc
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:49:18 -0400
Received: by mail-wr1-x443.google.com with SMTP id x1so31655492wrr.9
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gbscm8fANZO1dbHyTAfK2/NMpb5JzEDne5y/pCYipgQ=;
 b=jj1Tpsaj+BjF2Ho/78cdkGTaReQKYMLrS9cLrPQEuLpR6tPDwVeRM3Q7e1ak3wIwOH
 4h4qlXwz/lHERTAOTS3L4h0GzQsSjbFhezIixBav18snmUit5kLY+LSC6c++Y+lJxRCm
 Rz5w1VLGwLVxr1PjNyjebeWEOwx/qZ44kyRbAOofnF/eiBruLGZLcpABzFbiebPsgJcz
 nzFPxVmSPlkyau5cAEvKQ3qnAd8JpJYhocFJVOzBdWgg3aab8yYjdS98a6nPLMnpTggV
 Hb9ABQ2muG8aVaS5/JzjcJa/B6iGfWjaoqokjYOFDmweaI60mdu/sTAjZ7aPiNtgMJio
 yj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gbscm8fANZO1dbHyTAfK2/NMpb5JzEDne5y/pCYipgQ=;
 b=SUfAkjZnSXvubwrrFiRhWssufzPSdPqpgWqXPZbO0xWxjbphEW7qBedQzSsOsK1rDV
 dQJ5WnS1ZyM9CoxJzRN+njJfiNutxBe9ppG7VbIikK5SPDw9OpWJrXhrU5QPYs9MTAU1
 LDEewY6cgDjBMRMcIZmqjx380CDKeCA/bFVg1Yq6ee0gKN8vh8NOtP/4lHQDGgGF+woe
 Dr5L22jLDGPuP4YoNaJ65BbcKZkJ8g6H/Rpjr6o9uy/Ebn+MCan0jsGCnXaWF9FYcfE4
 oHjoU+9QJsjraMdNH0amYmoJSRm+VPS2RupcwyBxyXZ4MlatJf9AythWSOQrnwCyhpNf
 PAOA==
X-Gm-Message-State: APjAAAVWfdvM8MH5jaUgTHIYKmN1uT4NHJfMbtw4AH2uttVIS0PM0k8d
 TA9QSqNlS4bOpT23Qv/9k18lwqO2AUo=
X-Google-Smtp-Source: APXvYqwjkqNAgS63iJ9x33CKGNaJutduDcaMwAwH9Z+kNsFThRjCr4WPY/0WncBcmZxYvsrzxYzpsg==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr84735262wrj.272.1563968957109; 
 Wed, 24 Jul 2019 04:49:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c65sm43800224wma.44.2019.07.24.04.49.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 04:49:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 41E961FF87;
 Wed, 24 Jul 2019 12:49:16 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-6-richard.henderson@linaro.org>
Date: Wed, 24 Jul 2019 12:49:16 +0100
Message-ID: <87blxj1wlf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH for-4.2 05/24] target/arm: Install ASIDs
 for EL2
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The VMID is the ASID for the 2nd stage page lookup.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 1ed7c06313..3a9f35bf4b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3452,17 +3452,23 @@ static void vmsa_ttbr_el1_write(CPUARMState *env,=
 const ARMCPRegInfo *ri,
>  static void vttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                          uint64_t value)
>  {
> -    ARMCPU *cpu =3D env_archcpu(env);
> -    CPUState *cs =3D CPU(cpu);
> +    CPUState *cs =3D env_cpu(env);
> +    int vmid;
>
> -    /* Accesses to VTTBR may change the VMID so we must flush the TLB.  =
*/
> -    if (raw_read(env, ri) !=3D value) {
> -        tlb_flush_by_mmuidx(cs,
> -                            ARMMMUIdxBit_S12NSE1 |
> -                            ARMMMUIdxBit_S12NSE0 |
> -                            ARMMMUIdxBit_S2NS);
> -        raw_write(env, ri, value);
> -    }
> +    raw_write(env, ri, value);
> +
> +    /*
> +     * TODO: with ARMv8.1-VMID16, aarch64 must examine VTCR.VS
> +     * (re-evaluating with changes to VTCR) then use bits [63:48].
> +     */
> +    vmid =3D extract64(value, 48, 8);
> +
> +    /*
> +     * A change in VMID to the stage2 page table (S2NS) invalidates
> +     * the combined stage 1&2 tlbs (S12NSE1 and S12NSE0).
> +     */
> +    tlb_set_asid_for_mmuidx(cs, vmid, ARMMMUIdxBit_S2NS,
> +                            ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0);
>  }
>
>  static const ARMCPRegInfo vmsa_pmsa_cp_reginfo[] =3D {


--
Alex Benn=C3=A9e


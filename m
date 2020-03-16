Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1371C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:37:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C3E20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCMqjmpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C3E20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvY1-0003Mf-Ka
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvXM-0002qk-9b
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvXK-0001Pp-V7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:36:31 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDvXK-0001HT-Nj
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:36:30 -0400
Received: by mail-pl1-x644.google.com with SMTP id d9so8451844plo.11
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4LmArg3GTu54ll1HNRtasTPkMr+nwPGShFSLJ6YeUnI=;
 b=UCMqjmpftx/SVaAcJC2uV0Mh8wWzRMNLzGmKyg2r9FKUh1a+nm610urYYMC0euiben
 wdwoaeK8aZNWW1uvuVCokCyF6UkNhWiNY5jCrf+HgruIXY/G5m50tQXxoxFlkiIom4MS
 IiF2qaNcF93JRGICwiVHlhDp2cCEJEo+x8QqVw0gURa/ImowPkDSrmW6x+KoYXKea6Yr
 29tCDsvaYT2r+dK4EyvqXlxis3TyjerqTa1H40pQIx9hKRogNjk6VIWWbLUz0Gf/FSAt
 UyppgclCH3Qu/wwEdAhfir7lWmTSo1YcnN8uXe+rUAextBb53XOLcYO3Opcq0rNjWnn7
 1oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4LmArg3GTu54ll1HNRtasTPkMr+nwPGShFSLJ6YeUnI=;
 b=SvTTZ3KopuJx5B/U9xakTgQpuiN6YnPE1z7U55TQNseRis4J7cB0kDengPaT6OceY7
 SS1YcNkk93YBJimzhlOjtviPnlsOfD8JtLLvXCOKRdpLZZ0kGjM3+Md82/YCpSL+LHKY
 BxzwftJvXQke4RaKNDrEEkh1+aLTf1BKU5SSnQfdZe/wSN+0hAb9+V1OdfY8sbW4/Dhr
 SaPeoWUaw8efXM4on8cKHUYr/dZ1FU20dZPTK6UptK/ad93Jim00VtdCyy6lBoa3m7zp
 DMbHQg6UbF0pj1pyuToem2e0Qh4bC4KcAQK1AC74YDmrzqcbKkHII9jlEsNaLFooHb+0
 BGLw==
X-Gm-Message-State: ANhLgQ0sZbRLwKyEOCABjO89+xsqXHKj5HBnxNkzKv1KXDB2zSAKDzbj
 UqJYqJe3pLmcxBl4888wFdDaoA==
X-Google-Smtp-Source: ADFU+vtZgb/dz6XW3yb1GA5ZDRSuPFgkv5SJph2TK2P9VA40H7gjfL+36QxLD2o/1YkyWhcuBFX92A==
X-Received: by 2002:a17:90a:faa:: with SMTP id
 39mr1196481pjz.190.1584387387544; 
 Mon, 16 Mar 2020 12:36:27 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 i197sm655801pfe.137.2020.03.16.12.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 12:36:26 -0700 (PDT)
Subject: Re: [PATCH v3 03/19] target/arm: Restrict DC-CVAP instruction to TCG
 accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-4-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f570579b-da9c-e89a-3430-08e82d9052c1@linaro.org>
Date: Mon, 16 Mar 2020 12:36:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> Under KVM the 'Data or unified Cache line Clean by VA to PoP'
> instruction will trap.
> 
> Fixes: 0d57b4999 ("Add support for DC CVAP & DC CVADP ins")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/arm/helper.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b61ee73d18..924deffd65 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -6777,7 +6777,7 @@ static const ARMCPRegInfo rndr_reginfo[] = {
>      REGINFO_SENTINEL
>  };
>  
> -#ifndef CONFIG_USER_ONLY
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>  static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
>                            uint64_t value)
>  {
> @@ -6820,9 +6820,9 @@ static const ARMCPRegInfo dcpodp_reg[] = {
>        .accessfn = aa64_cacheop_poc_access, .writefn = dccvap_writefn },
>      REGINFO_SENTINEL
>  };
> -#endif /*CONFIG_USER_ONLY*/
> +#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */

I'm not 100% sure how the system regs function under kvm.

If they are not used at all, then we should avoid them all en masse an not
piecemeal like this.

If they are used for something, then we should keep them registered and change
the writefn like so:

#ifdef CONFIG_TCG
    /* existing stuff */
#else
    /* Handled by hardware accelerator. */
    g_assert_not_reached();
#endif


r~

>  
> -#endif
> +#endif /* TARGET_AARCH64 */
>  
>  static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
>                                       bool isread)
> @@ -7929,7 +7929,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      if (cpu_isar_feature(aa64_rndr, cpu)) {
>          define_arm_cp_regs(cpu, rndr_reginfo);
>      }
> -#ifndef CONFIG_USER_ONLY
> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>      /* Data Cache clean instructions up to PoP */
>      if (cpu_isar_feature(aa64_dcpop, cpu)) {
>          define_one_arm_cp_reg(cpu, dcpop_reg);
> @@ -7938,8 +7938,8 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>              define_one_arm_cp_reg(cpu, dcpodp_reg);
>          }
>      }
> -#endif /*CONFIG_USER_ONLY*/
> -#endif
> +#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
> +#endif /* TARGET_AARCH64 */
>  
>      if (cpu_isar_feature(any_predinv, cpu)) {
>          define_arm_cp_regs(cpu, predinv_reginfo);
> 



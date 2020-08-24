Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE9EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76AE62067C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6uBGgpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AE62067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFR1-0007G4-Ma
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:35:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFQF-0006QV-2n
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:34:15 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:32833)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFQC-0006pe-UY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:34:14 -0400
Received: by mail-ej1-x62b.google.com with SMTP id u21so12061819ejz.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=BmoDD6A/4ncBdMV7K6LZHv3jQzCXA4C2mq7gqvOA80g=;
 b=s6uBGgpr87vY+5MQTlwsMiS6u2Sa9+OISAEHewprth0Rs615HMe3rosRyg3Q2HMRzi
 XCd9JNkQVPyfVtvpGrZIz6g061+Zr7jcQkJvlJrgxu/O+yFQguK8mgizYOmU/wEsi5kT
 pizLmN5UxOJ1/s4rDp6GYhhNEu3LjU1h4i0h5lpi//XZzVee2W8CWN2PB19lg/euRxVN
 Dh11sBR6VfZeaQ97Nl9kOFO6+bg4ly1bS0JOMil9cK8mKixN0aVX7FnVSDExIXrJkSSd
 iPlTjsuw2CUwioZwaxe8ZbxGsnT1fVLC8X+bBC2ddvZPG7p0GOKRQU0wsuBN6f4rlMm7
 92Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=BmoDD6A/4ncBdMV7K6LZHv3jQzCXA4C2mq7gqvOA80g=;
 b=T7whp1iOOZ/3LRipg9EaGM36tVFaWYuXj8gJXsgFaeSvJzVhaJ4mTIry79GptU2DAK
 I3HFrJNmP3dqVDBD+4OZiHoav0jIoQn7DnsbXFh6tRbePn9Xq+kQjxDsZ5g1xvBWbnhd
 4Dl+9yLfPuzxctzbEmqooDDaoGxn30iZhyF4IIzuXHMddXeYVeX9eoUfYvj0Yd1iBtM7
 oAdK4ncj0PKd1aqHq4xL5OdgtHCHHBQjVR5akWL4ok9S5hxAwygPDv/SonMoh6I7uTb9
 Tjub9iRCDzQDA4DgjysykmFLA4KC7aNnvn6SUT4d85id6RregTPxUe/bt5od1Gw6BXxv
 S20Q==
X-Gm-Message-State: AOAM530sPi0voDvx1BtASRyItXhmSaUvDfr83BdZSIEus/Tbf8ahduGz
 OAovsUVFVXZt0/qODjS1pZElrXbHXbO6XQ3SBb2AquN/ybF0yA==
X-Google-Smtp-Source: ABdhPJyD42vsitx/jSkaNaffJRtYT6DpUhZL0yuNYQzVnonjRVOrOMc9LLvbXP+NEwPQT9MjOg940bTrXkzKL8D17qU=
X-Received: by 2002:a17:906:b814:: with SMTP id
 dv20mr6336153ejb.4.1598286847280; 
 Mon, 24 Aug 2020 09:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190118145805.6852-1-peter.maydell@linaro.org>
 <20190118145805.6852-40-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-40-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 17:33:55 +0100
Message-ID: <CAFEAcA9jUpJF4FQirb3avWJAMjh+AdkimW3DgMyMjbDjBCQSvQ@mail.gmail.com>
Subject: Re: [PULL 39/49] target/arm: Filter cycle counter based on
 PMCCFILTR_EL0
To: QEMU Developers <qemu-devel@nongnu.org>,
 Aaron Lindsay <Aaron@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Jan 2019 at 14:58, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Aaron Lindsay <aaron@os.amperecomputing.com>
>
> Rename arm_ccnt_enabled to pmu_counter_enabled, and add logic to only
> return 'true' if the specified counter is enabled and neither prohibited
> or filtered.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20181211151945.29137-5-aaron@os.amperecomputing.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Hi Aaron; I've just had somebody report what seems like a bug
in this code from last year:

> +/* Returns true if the counter (pass 31 for PMCCNTR) should count events using
> + * the current EL, security state, and register configuration.
> + */
> +static bool pmu_counter_enabled(CPUARMState *env, uint8_t counter)
>  {
> -    /* This does not support checking PMCCFILTR_EL0 register */
> +    uint64_t filter;
> +    bool e, p, u, nsk, nsu, nsh, m;
> +    bool enabled, prohibited, filtered;
> +    bool secure = arm_is_secure(env);
> +    int el = arm_current_el(env);
> +    uint8_t hpmn = env->cp15.mdcr_el2 & MDCR_HPMN;
>
> -    if (!(env->cp15.c9_pmcr & PMCRE) || !(env->cp15.c9_pmcnten & (1 << 31))) {
> -        return false;
> +    if (!arm_feature(env, ARM_FEATURE_EL2) ||
> +            (counter < hpmn || counter == 31)) {
> +        e = env->cp15.c9_pmcr & PMCRE;
> +    } else {
> +        e = env->cp15.mdcr_el2 & MDCR_HPME;
> +    }
> +    enabled = e && (env->cp15.c9_pmcnten & (1 << counter));
> +
> +    if (!secure) {
> +        if (el == 2 && (counter < hpmn || counter == 31)) {
> +            prohibited = env->cp15.mdcr_el2 & MDCR_HPMD;
> +        } else {
> +            prohibited = false;
> +        }
> +    } else {
> +        prohibited = arm_feature(env, ARM_FEATURE_EL3) &&
> +           (env->cp15.mdcr_el3 & MDCR_SPME);

The Arm ARM says that MDCR.SPME is 0 to prohibit secure-state
event counting, and 1 to enable it.  So shouldn't this test
be "!(env->cp15.mdcr_el3 & MDCR_SPME)" ?

(compare also the AArch32.CountEvents pseudocode, which has
a test "HaveEL3(EL3) && ISSecure() && spme == '0' &&...")

thanks
-- PMM


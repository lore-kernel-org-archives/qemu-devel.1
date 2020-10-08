Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42ADC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4012177B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojvy2QD1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4012177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTYr-0002B9-6k
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQTXq-0001A9-QC
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:53:10 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:34931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQTXp-0000BH-1Y
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:53:10 -0400
Received: by mail-ej1-x643.google.com with SMTP id u21so7460007eja.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P/L2AJxkh/7mOAakV/ngtfO8L7gKMlV7eFU2IyI1ul8=;
 b=ojvy2QD1t75wqBXL3O81r6wTWNops1BVCa3oc6g1H+VT2DFItLbuYNcXsEYJBorWl5
 nv7S9TexYYnXl/ktjRuiYRuQb/FX77x3mSQOPCuTmu8mR6wn1pM5T32Rr0WZRJLihIYj
 lnpnVt6k2oUT5HR3lhKa2RhGRqqpFF7xjShwKNnumBXMj1T1N5gIujZZfq06MTyhPaPS
 yVuGYI+yCmsEQyjbZsfqNPXuTq9NK/0wX0tZ5COY7HMw1VbjzagfFKOBvSIXeQjv1jvh
 PQZ7pr38p6KV/2t5L8/JLFts7/B8EL6T+LgIZgbW8sN40Pfv2+tJxhVTNy+XKw8GPBbP
 2H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P/L2AJxkh/7mOAakV/ngtfO8L7gKMlV7eFU2IyI1ul8=;
 b=sud8KngeX4oumXzUVi8xP3gKhGRvu7KUaELyu9spHRF7QEy/PhFaQsBBzWccDrNsaA
 WTb/HZQiZNI2dIirslnRSNWc/UOuIsqwaFKbBhH9FRg3cf0/mHSGNnr6yJowvsQeFQ8z
 ljqNQEm544sqR1KdDYTM9M6irYuQYdVIslWZnB8XazBa50n4ozu+weIo9rc6ghlnq/kz
 Birn/OoVbmJ2JlHHvA4fjGgfAJatYD2uDT2ChmOiddxBX+moCt0a4Ow6Se0iYapQg7En
 JDPGzsQGVKepXeW+FmYq4rcBt1pRpRgk3raz/5Rp6bpc72bPpOELXxd2x0lt79gsrSAx
 LBhQ==
X-Gm-Message-State: AOAM530ayL3xmcyeC8GRWRRuM+3X3YB+cv9DKesSnJ7AyrOTO4tX1kgF
 kpOaoDpFFjeMiInuFG/GqQkOYobydbZrfNaR1H7New==
X-Google-Smtp-Source: ABdhPJxW5/mOlNA4cQh94Gx+yRpRZRASMDbuFu5uVrlD1Gj/mGWx27CHjAKvcPbMkglseiDsA/2yh1PmbUwW2MgHgOk=
X-Received: by 2002:a17:907:4365:: with SMTP id
 nd5mr8336982ejb.56.1602154387427; 
 Thu, 08 Oct 2020 03:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20201007100732.4103790-1-graeme@nuviainc.com>
In-Reply-To: <20201007100732.4103790-1-graeme@nuviainc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 11:52:56 +0100
Message-ID: <CAFEAcA_P=u7DXLTEZpAQmRvqt7yNNiPNMJ4GTBwUJ+dBvAUKBA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/arm/sbsa-ref : small fixes to smmuv3
 initialisation
To: Graeme Gregory <graeme@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Leif Lindholm <leif@nuviainc.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Radoslaw Biernacki <rad@semihalf.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 7 Oct 2020 at 11:07, Graeme Gregory <graeme@nuviainc.com> wrote:
>
> Fix two issues with the smmuv3 initialisation, first where a previous
> patch had transposed an i to a 1. The second an assumption that the
> IRQs allocated were meant to be unique and not 0 based.
>
> v1->v2
>  - split into two patches
>  - previously sent as v1 post split by accident, resending for clarity
>  - added Reviewed-by
>
> Graeme Gregory (2):
>   hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
>   hw/arm/sbsa-ref : allocate IRQs for SMMUv3
>
>  hw/arm/sbsa-ref.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM


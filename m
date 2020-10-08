Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1EAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:42:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E38207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QyfskRwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E38207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQck2-00021c-NB
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 16:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQchx-0000gu-NZ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:40:13 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQchv-0007mW-Vt
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:40:13 -0400
Received: by mail-ed1-x541.google.com with SMTP id l16so7196831eds.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 13:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G3fapPkb6Gmr4cexZnT4DAT69IL+SilREqXWZZPjQy0=;
 b=QyfskRwSuuk+mHKReYYO/+YCD2hYYHD5BykYaqS4eH5G86jo8yCGbTJ1G6Hrd8NQdV
 w+RvkOWKP/UEmC3bMVn2aR1k95+avyRLjMEucl1wqIyHsPHLt63BFxxUSPLp77k0FA50
 jyWPqkqK7u4ova6JncZCS1u1eRMD/m+/5X84cj4fr74OnyhYuUS0di2pzH7PT7BrI8Np
 NBpuXx0vWy78hfJjkgzuhs/ix+3t+pY4QgYHlbwrlWDuJ4W8J7XSpobavzmAFngYM9/+
 5JUJqgNh4oSf1/CTW7Lol/SsFtV1eLPeWpxPgKRroYRI0TchO0DLOxwGP23lTWZZ3Bte
 YEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G3fapPkb6Gmr4cexZnT4DAT69IL+SilREqXWZZPjQy0=;
 b=FSc18otX9TByjKEKOxvuh0TfieLNmFzUw0TsycWlalAw+dye2NOepEx81hy2V6adNt
 HyS5dCmLbsbEZZhNKZPe3m4kCNlUYDSiZm3mepgz0qbFLZaoguZ9OP09cCbXP3HFQWXo
 jxZF1+58VN/9xcvwvxC4KDVMFcTjCfBiNFOwrAeVYFNFyi3Ix+0qVgRWTKT7AcA5L8R8
 cIiwu4slYLX7LcSRBDGjKD71GQniO0ZqP4yRctUnHPptqSNoXlErGEmdgWK4QVC3203h
 zR74t6aXwpLXcIL0G4xoVaZD4aj6yW3RfeGodIz1R5x20tlstkf9FH4OULPVUJMMSi0n
 JmSA==
X-Gm-Message-State: AOAM531CY+xnCxm1iH1bZncr4oDz7VX8+ke0xAtIi5cJxs9/53JF+2/V
 pURq+IgE04KGycScEUCCpVVnAQJl9lJ8R9TRf8Tz2w==
X-Google-Smtp-Source: ABdhPJxg6tihgeupNoH5xtppF9jYST49F7z0XieU6UFiux7DXkBvw+Xce44+2kBzKQaoSE98dN3jPyaQtH/++T/MAc8=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr11512471edf.52.1602189610373; 
 Thu, 08 Oct 2020 13:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201001061718.101915-1-drjones@redhat.com>
 <20201001061718.101915-7-drjones@redhat.com>
In-Reply-To: <20201001061718.101915-7-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 21:39:59 +0100
Message-ID: <CAFEAcA-ZwwzrjPjsaGJbwW-y0g+j-usk25f1hiFVadaS74Nv+w@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] hw/arm/virt: Implement kvm-steal-time
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 07:17, Andrew Jones <drjones@redhat.com> wrote:
>
> We add the kvm-steal-time CPU property and implement it for machvirt.
> A tiny bit of refactoring was also done to allow pmu and pvtime to
> use the same vcpu device helper functions.

> +            if (pvtime_size > pvtime_reg_size) {
> +                error_report("pvtime requires a %ld byte memory region for "
> +                             "%d CPUs, but only %ld has been reserved",
> +                             pvtime_size, max_cpus, pvtime_reg_size);
> +                exit(1);
> +            }

This turns out not to compile on Windows:

../../hw/arm/virt.c:1693:30: error: format '%ld' expects argument of
type 'long int', but argument 2 has type 'hwaddr {aka long long
unsigned int}' [-Werror=format=]
                 error_report("pvtime requires a %ld byte memory region for "
                              ^

I'm going to squash this fix into the pullreq:

--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1690,8 +1690,9 @@ static void virt_cpu_post_init(VirtMachineState
*vms, int max_cpus,
             pvtime_size = REAL_HOST_PAGE_ALIGN(pvtime_size);

             if (pvtime_size > pvtime_reg_size) {
-                error_report("pvtime requires a %ld byte memory region for "
-                             "%d CPUs, but only %ld has been reserved",
+                error_report("pvtime requires a %" HWADDR_PRId
+                             " byte memory region for %d CPUs,"
+                             " but only %" HWADDR_PRId " has been reserved",
                              pvtime_size, max_cpus, pvtime_reg_size);
                 exit(1);
             }

thanks
-- PMM


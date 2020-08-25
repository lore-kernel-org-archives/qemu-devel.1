Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D02C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2045B2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NMKQ/xTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2045B2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZw8-0003jz-Cg
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZvZ-0003Cy-JM
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:27:57 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:40154)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAZvX-0004OA-WC
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:27:57 -0400
Received: by mail-ej1-x643.google.com with SMTP id o18so16814670eje.7
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RSlLk5173LzdfvNMUnQXkt30g+jXcjnZZ0DWYEE/Je4=;
 b=NMKQ/xTum4gUKSsGytuZBEN/SHR4ScoxmFVYlXkYXPmenUa4xkeMCZ48PDRgwBFzQ8
 +F71RxFw1Efl1KABtK/yeT2iB/+h/RVToiasOgkpaCWNf2e2CvqfQxY6ms6dq7az2GdX
 4ld5vmuIQZM6JFfqOfCY7bnCsN7xnbDhLI4ZJZcIZ5ZEh2/WCjl0BtsdziD/OtqGZXlN
 4CUuDlA609+zc1R0bGKwhqJM28Poo1TDDpHXogR3o7aExnHJnMTUFcymMQyvxFewnYO8
 ubGfz8tL/TwfD9vk1kxi90qx/nhyLLhOjf6K5nHY97poUy+oFuPd+wm8J64wyCVmiatK
 9SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RSlLk5173LzdfvNMUnQXkt30g+jXcjnZZ0DWYEE/Je4=;
 b=KxxUcHW3vB33ayRiKEaWqoUJ2JeE7spJwqM/hq7Kl7D8eb7NtCH+VlMJnQatz7Y9+V
 mLUNE1xhxx/50uSNcVuaWvrNaCSdLvbGiHtrGT5KL5LVy6q2TS7n08IFIdoZ8ZpSiCbq
 1ZUxuntaxYeS07eXKmvylyXJ7EfHYj4djcFBqmt9Yo3wrq7qd2kzEaeKyiEOfpmXMu5x
 vksZG1Fgj5DV7q/le9kvXeRFeyfdDQP/MSo2VfkMwWA/8GC420H7BPov+TL3HNo0WM9W
 DkgFw7zJrsh4T4NoVkBPox6Q32QjYHPIQylkkfaJWA0BJ/RKXiDp49B9+guutD8d7684
 2jxw==
X-Gm-Message-State: AOAM5326ePPa670ouwQwYefvoo4qi2ZiUwxtWKej34BzZ6CoUaAsBeh7
 ND65mfhB57avlYvGz13x/HgQ8KkqxVXyptDTYhmJVA==
X-Google-Smtp-Source: ABdhPJzNP2M5PhRPBCzVJeKiSdEsSDc5hpKPRRBHBBKqE23OiXra8Npb2RikrzgwPt/XmGeye2v8WTAw3wtHwrkqdbg=
X-Received: by 2002:a17:906:2b0b:: with SMTP id
 a11mr1205617ejg.250.1598365674050; 
 Tue, 25 Aug 2020 07:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200805091640.11134-1-drjones@redhat.com>
 <20200805091640.11134-5-drjones@redhat.com>
In-Reply-To: <20200805091640.11134-5-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 15:27:42 +0100
Message-ID: <CAFEAcA_nUKUYdqWOJHZreOUwi8VZi2j+zMaKbY+0DOm3QGb=8Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] hw/arm/virt: Move kvm pmu setup to
 virt_cpu_post_init
To: Andrew Jones <drjones@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 at 10:16, Andrew Jones <drjones@redhat.com> wrote:
>
> Move the KVM PMU setup part of fdt_add_pmu_nodes() to
> virt_cpu_post_init(), which is a more appropriate location. Now
> fdt_add_pmu_nodes() is also named more appropriately, because it
> no longer does anything but fdt node creation.
>
> No functional change intended.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


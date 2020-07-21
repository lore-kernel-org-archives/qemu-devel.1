Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E125C433E6
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:04:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6667E20729
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kOlLPkgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6667E20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxp8N-0003w1-LO
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 06:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxp7Y-0003Dn-Sp
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:03:36 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxp7W-0007FC-0F
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:03:36 -0400
Received: by mail-oi1-x241.google.com with SMTP id t4so16719424oij.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e7xcg5KmGjBqHll9tFqg/k4svQLOxoH7Gl0fD0088R4=;
 b=kOlLPkgQToWn9AJWJEXIN54kBJTri0u6rFnvw9a2f8FoqDSos0h+pWW1GmMvOYxmC+
 pLB/lXt2f3Oeza7Qhi7ysRtBb3VBmA9NRyfuI8SDn3tP+Zjw205Vh4TgmeFM/hYUos6n
 SizpMpRUtrM91fAnJP/0bFKcV+tSP/lEbUM/3xwSlSbRT2390VND8J7Ah/RYdtC3Rj4/
 mqyhRp3obkJO/mWNZoQIcXIM6sTRpVbsNAsmqpDsTE98gd62pXrxEVKAjqKbL0PHrAjC
 FZrzn2ehrX95+2/rLZJ1tkP0l+WGY+7EZaAQ0nE2KQJ3sdWhh5vfXX2vpniNI1f6C5hd
 yHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e7xcg5KmGjBqHll9tFqg/k4svQLOxoH7Gl0fD0088R4=;
 b=ZsM5juUpG908QhIbo/fVAiOQyo+CuMWpxeX92XNOhTjzJw4snhyGAVMSXmkOyQdS9M
 5/cbfqhNKbqzKrV6QgGhB3G9CyLtNrh3v1GkXQc5Txu+DnAGZbxM1zIF0kbJPrCMqe+9
 ac5vyTaaAMkA1ukzZK8xJbTPoCvE9gQxjBcwJ/cKDBKY4t/JchszqV1iQdzP4YYO8SzU
 CpvrxnXT9bSBcaNFkzdBQmzmR3dCp8Pmo1H8MhjXTPvr9fd1jj9L2R6Ppm0zeecGw4Vd
 Q0L2ueHh2YHUtfiL19PZJW7stx+geG66YonxgUheLEPrRm+yW5a4oZzH892gxfs41R9q
 bmAg==
X-Gm-Message-State: AOAM533fGBAb44vdIzE3lo0miNxwBqHYCR67mKi8oR24TpuQDrpq0ag+
 Suf9wae2L5t0weiRs275oy1YrmpsB6eXBpQt52uZog==
X-Google-Smtp-Source: ABdhPJwmIb02l53mTOm9F9oqtLj2KmZxMHS3PC4gaNM/IERksQ7zSh0iJWj5ZyHp2MhW9U0+YIKc4RUr6y4F+X4J278=
X-Received: by 2002:aca:2819:: with SMTP id 25mr2221544oix.48.1595325812895;
 Tue, 21 Jul 2020 03:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200711101033.47371-1-drjones@redhat.com>
 <20200711101033.47371-2-drjones@redhat.com>
In-Reply-To: <20200711101033.47371-2-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 11:03:22 +0100
Message-ID: <CAFEAcA8D6xvNhaWtf9PPzQuDqj5xucioTYqygGhGJT_2XekT+Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/arm/virt: Move post cpu realize check into its own
 function
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Beata Michalska <beata.michalska@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 Jul 2020 at 11:10, Andrew Jones <drjones@redhat.com> wrote:
>
> We'll add more to this new function in coming patches so we also
> state the gic must be created and call it below create_gic().
>
> No functional change intended.
>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt.c | 43 +++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 16 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


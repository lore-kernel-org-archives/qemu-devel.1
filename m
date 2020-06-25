Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AC0C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DEE20706
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgQvm5Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DEE20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPRV-0002S8-VO
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPQq-0001ic-OZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:48:36 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joPQo-0007cB-2J
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:48:36 -0400
Received: by mail-ot1-x344.google.com with SMTP id d4so4829910otk.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vKjZbtR39GokOoxaA814Owpvk65agAdbzHUDYnKetpA=;
 b=MgQvm5MttJqoOt8BJTOdJ2jWIwBwnmC0Y2lvCLpmDRON7X2bPyljWlMXacsJ07JVhS
 7K55kcxtO9EsQcOreGFTTcBEFVX9MkDbBuFtu9yhjJff7V9S2DYCHOoFMM99ZC0IDYBV
 ZInVWqqdp9aW1/Z3eoWxRmJmxIQ8bu4hhM8bNXB+SPVB2LPsrH6Bwn7pe6BvHN5S/B7z
 B+7er+38yoJcxvdTdREfNrs3HsEdeVCwBCoSjVZa+o0GHq6o9tQwxitzu043inTUNjEe
 amCqHvWvton2Q58ECp8gkLJPvBzzTaxPQhZ4OYoAAI0mAqCR2vsCpMSApBi01tegwREC
 HWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vKjZbtR39GokOoxaA814Owpvk65agAdbzHUDYnKetpA=;
 b=e8Ug+o2LK59Wv2rwm4DN4RIil90rJnIsN20ZU16QFV6sfrdnax9C2aliZ41i9Jila/
 YOJmaBdmUPrliRd0zypWEWkmJHRPt5eH3IiU/n4tIDoheGBbuxfN1f/QSeABB5i1G5WU
 v1/z+nQWeLI6yPAs0aXmhbYNfd6FreBUVX8i8comkjkNYhkl/riMpfkxSe1coGsxbPQK
 LbUqYopJ/Ldl7s57d4+HFdUCMbGOMegS4fO61DHPMEy2hwpVrrCI6oS7EQr9dpy9nTqF
 Th+UlxrZejA/QtlYxATxdtqSyizNQIz2Mm2K2pV3qKOdIpXRvJyvHjLOyAD29Jj/XEsH
 Zjgg==
X-Gm-Message-State: AOAM531lZOh/4Yr3BFBcgTeVttKW2z7eD9AF+AcZHr7tzQEWWYVPynGa
 p4kH2iwTNrIncfq2ZG8zE3ZrL0WjkkQECUbN2/cULpIyl8c=
X-Google-Smtp-Source: ABdhPJycaddfTTSoeAJByYRnPF2Wk9X7du4+Kks2GBIrhEgx+h4YU8serdLkpNZ5EvjS5R5scBJQXVPj5PAGpOJ4Bio=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr12342673oth.135.1593082112919; 
 Thu, 25 Jun 2020 03:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-16-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 11:48:22 +0100
Message-ID: <CAFEAcA8xCDbbKn=p7GPB8qiJoT9LSTHraoeHmsVFcXXVVe5E5g@mail.gmail.com>
Subject: Re: [PATCH v8 15/45] target/arm: Implement LDG, STG, ST2G instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Split out allocation_tag_mem.  Handle atomicity of stores.
> v3: Add X[t] input to these insns; require pre-cleaned addresses.
> v5: Fix !32-byte aligned operation of st2g.
> v6: Fix op2 extract, stg pre/post-index, stores vs sp, commentary;
>     use pre-computed ata.
> v7: Fix STZG iteration (stephen long)
> v8: Merge gen_probe_access patch; align address for ldg (pmm)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


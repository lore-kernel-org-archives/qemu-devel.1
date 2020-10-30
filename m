Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88822C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:10:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACBF206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcolW3HE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACBF206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYV7E-0002LN-Ot
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYV4X-0000fV-07
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:08:05 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYV4U-0006et-69
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:08:04 -0400
Received: by mail-ej1-x641.google.com with SMTP id p5so8833307ejj.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0jdxyg+/W60FveLllmFOutmF2VFgoTYPWlaXjYUhGUA=;
 b=HcolW3HEou6QxL8E9C36k0r6xkmCNxcslUvQjoDrLygSIR6cx7k3ck4XaoZ93MZI4e
 T555y0ZqBWRyffBo6SvhPQig4J2S3qav7K9Hma/pzcg5MYcE96ja/Jm4SwZQKv/1NmfK
 CRYyGUhZd6JprasAY0GQRtkyHFllADqQLgDjYCv1AMGUpTcU4yaat+3KfvY5ZNGfPra+
 /tXBCSvC9JMapjh9EBXriGnsww0TsiG64mg+lkVtV9EQGe1JF19jRmnH0vhJp0PrW1io
 yrTaecDeWiHS64KEz99yy2v36YgUyncMuQTH+EU+GsYrSieW7jrCr8NjFc43y/MfPzFJ
 BY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0jdxyg+/W60FveLllmFOutmF2VFgoTYPWlaXjYUhGUA=;
 b=bLxWkhuckUUZhedVFSHdlb1QC6954rrbdiatwimD6lt0gVjBm07X4mjcJP/omaPia3
 4B08zLtuamrprwnVAWSB7T8wV910b/gjK2u6At7eQL/4GXMgVtYP5Rf7wOmEQ2zKGGk4
 3ExaXMvOZxGFgFKbnVFPueIUitKhqlYIyxnbN4NruuT90t95frAO8ZHZy8F+2IYsYYzj
 ug2fvs/O5mz62aJvs/4fTFwEJw11S6xcLRClHJxs+OJQHP9sqoi6/eOtqfghhH7LMUn8
 wJfL+2rh8gK13fLdqpv8swzhBDVXH4mvdefq4egBc6F08gmej7LwXJuH4t1QN5Uj4T7H
 aRjg==
X-Gm-Message-State: AOAM531jmAKOVgARhAWWe6H48y5GBC7NOAridsdfalhDSNWX8OU/tHuX
 30jBrweRgDbhOv1PZAk7eamf/Z9Xzixqw7ni89SHvg==
X-Google-Smtp-Source: ABdhPJwuq2lvpDz7Edo6JDyYMfFidKSr4TJ987o83isQSvvdUkvZumM5dcW8eAPQUCQhYwpsooPCQPHIcNY0rPwWI/w=
X-Received: by 2002:a17:907:9e3:: with SMTP id ce3mr2708765ejc.4.1604066880567; 
 Fri, 30 Oct 2020 07:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201030022618.785675-1-richard.henderson@linaro.org>
In-Reply-To: <20201030022618.785675-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 14:07:48 +0000
Message-ID: <CAFEAcA8S=uyYTuN-eHdUTkeawGoqBXBAQzPLv_KNpB0rWwSisA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] target/arm: Fix neon reg offsets
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 at 02:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Much of the existing usage of neon_reg_offset is broken for
> big-endian hosts, as it computes the offset of the first
> 32-bit unit, not the offset of the entire vector register.
>
> Fix this by separating out the different usages.  Make the
> whole thing look a bit more like the aarch64 code.
>
> Changes for v2:
>   * Fix two tcg temp leaks.



Applied to target-arm.next, thanks.

-- PMM


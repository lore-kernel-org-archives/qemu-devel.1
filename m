Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D18C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:10:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16C820771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHe5r28j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16C820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHj0-0000yV-9g
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:10:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHgi-00070Y-CX
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:08:12 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHgg-0003mR-Mn
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:08:12 -0400
Received: by mail-ot1-x342.google.com with SMTP id n70so7356172ota.5
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 07:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TuBlfcvNjx1ivWXnUZtcurEYZkkPInVj7xpKTT6P+PM=;
 b=fHe5r28jYJgKXmuBXwMViY+r2hjxoI5LVTNEkJHbNSysmAdPt9wFMRtcnb7Q+9N3PH
 d/OE8XUmaSSR7pd/Ep+GjnMun/MR+KfZ0rRLq9NF9J7NJp5KxcOJv1t4yqTYUCaXgoMb
 Mvdcm3uQndmvRMV71HMOZagsTrpsVGRnDI9S0+gSZf6lRQABPAYd3C62TGfRMTDaJx8x
 R/RDkvVU6eJp2CJumR5XwkayJd0R3Vo020xcM57rwc4Y6bUqNQyg3dxzI5f/8k5dJiTZ
 nX/ofRZcjZD3f+JnO0XpsAZf2x0/hSKCWcX4y7/hyRqvN+usOGy3bhqG2J+H3e2ya8QE
 KNXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TuBlfcvNjx1ivWXnUZtcurEYZkkPInVj7xpKTT6P+PM=;
 b=TE51jvLhF6XPilW/NcrwIRrZkQ+6m4QApVqG91RAMQfKf8ZfgJDRNCIfyFbldx4XcM
 me2rpxvpBI+WVZ5MfgGAqOumvfeVB/TtUXjvmG0gKIV3HeQKS+hVlKYk/vOxUKAsWH+B
 QVT3jZCegMIxCppb/xbMM7TMSbNLcnTyictzc4aQVMZEgRtaPDXCfSS9GH8OsnArxmqs
 cfRLEVkugPUJBHShh63HZ2lgQqZNcMUwkmCfjhiZOCn0jy/3rhQ/H0ddc7/mrz0p9qg2
 V+qwbPII/38NNtLMSDsSM2zW8pyXyyp+tmIHGnMz/dCU5J1JenxaJvzUquNqlqSfu4jv
 ezQQ==
X-Gm-Message-State: AOAM531VEaux0x3LySyfz7PQbRUji/HNSTY86fx1uh+pZ+08FqDLBEmA
 MNNtffdDynnqzxbUPpdM9ZS3VrGYiCspwb8db4gCAUhGpaw=
X-Google-Smtp-Source: ABdhPJz1B2hEcQa/MLRf631hZ/v6MvKvBWWJ7eCvUHErxII0VjMg/xLjn1bzgadHrI8GWLSDGWX5b0PXIozUE5dE/+s=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr2991183otn.221.1592575689718; 
 Fri, 19 Jun 2020 07:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-35-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 15:07:58 +0100
Message-ID: <CAFEAcA8DozK3UT-5yGivNdvMwtm0JHHAgy2VR4LYufosCW6-Pw@mail.gmail.com>
Subject: Re: [PATCH v7 34/42] target/arm: Handle TBI for sve scalar + int
 memory ops
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We still need to handle tbi for user-only when mte is inactive.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

I don't really understand how the commit message and the code
change go together here...

thanks
-- PMM


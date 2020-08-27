Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA18C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399B52075B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="noNzADQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399B52075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEEL-0007qW-Co
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBEDK-0006Z6-Kv
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:28:58 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:43074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBEDI-000429-Q8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 05:28:58 -0400
Received: by mail-ej1-x641.google.com with SMTP id m22so6693546eje.10
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 02:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lNKyWQVmt7GlUFWHoZTwmyRNJK2j89UAb8nPiiUG4IE=;
 b=noNzADQDPVadXawjYSe5fCn2sn+gbSUutTNtls9utIQ8+0mnQee2MJAT6N2nt8QcA/
 bp0rwSKoeQNSBFA76EQzURfFMdnjsHHXKW7vfN5P1iP3F272SNpARzb8JXN2dl+GTfom
 xShxvoKl7Och+vstOo+OnvnedZFwt47uEggDuTAkkVRAYT0Xd3y3apUI0lzYLAvrS6DB
 z1bss0+M65MZ3l0Qrmya8jzCNDSDyNQZSxH3Tc0+MVKkmlxycMaDtZhRRAYuIZ8ca7Or
 8BNTuUu79X0xswikQdzdMakT+33fGggjoN8e4ujtwl6E5P/KGZ6ELutXEcdYzVTExXZZ
 M9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lNKyWQVmt7GlUFWHoZTwmyRNJK2j89UAb8nPiiUG4IE=;
 b=odjMIi3hmyYC8T5PQvSg5sbU0Aag8YgkiWNWAnmIv46/xycL1hC5Mcu0gGqzzurivr
 TTDb6mulih5IErHjr+DhNA4nX8vrVoppKhvK+oXwCGXcBHGsmbfSU7VEjcGyLB12kRTD
 aUnfYo+JGQ1BwNJCWZ5u8eeb60vo53JBN+FXX/DDBQTI9lHS4MpU1910rqkkAhWXS8tW
 aGdAb7lrCF5l0tO+9+YQ3BhJ5Wutu5KGJ0SpToVEnpPO/gIg1TOsbtIFQ/qLtU+c4MGj
 Hp0q9qdcIzc4hguHdwes8YGnsOUZQqgAC+u17bp5CTeoId8dw55CMHS9v+triC6Tjfxd
 fPRg==
X-Gm-Message-State: AOAM5321ULEGzRTG356ud784RHMYeKSJwFVoEjm+OsrGrc9GcgFtWv2C
 SHzdNPkMXkINSIzVWxqfLXBPFfCMJya26Oos0wH7eQ==
X-Google-Smtp-Source: ABdhPJwMqiizVrdloQm+Nzhr9AVWDNwQZEGlWjrIKB2LZj0N2vYUuyPx8PQj4alBYvlGEWVuZqB8C9vLsDoz9TOJ+dA=
X-Received: by 2002:a17:907:2066:: with SMTP id
 qp6mr10748116ejb.85.1598520535238; 
 Thu, 27 Aug 2020 02:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200825112447.126308-1-kuhn.chenqun@huawei.com>
 <20200825112447.126308-10-kuhn.chenqun@huawei.com>
 <CAFEAcA_SLjM28bHH8WxBdHAFdLgE6zgqNAj9EpOVp77WL-iqKg@mail.gmail.com>
 <7412CDE03601674DA8197E2EBD8937E83B8E58BD@dggemm511-mbx.china.huawei.com>
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B8E58BD@dggemm511-mbx.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2020 10:28:44 +0100
Message-ID: <CAFEAcA-MU2tginRvDOUk8+sEQiDm3ZxNZ2sb-vsw4jFaomHa7Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] hw/intc: Remove redundant statement in
 exynos4210_combiner_read()
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Pannengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 08:01, Chenqun (kuhn) <kuhn.chenqun@huawei.com> wrote:
>
> > Subject: Re: [PATCH v2 09/10] hw/intc: Remove redundant statement in
> > exynos4210_combiner_read()

> > The code as it stands is definitely wrong, but I'm not sure this is the correct fix.
> > Surely the intention must have been to return the actual register value from
> > the reg_set[] array, not to return 0 ?
> >
> > I suspect the correct fix here is simply to delete the "return 0" line and leave
> > the assignment to val as it is.
>
> Hi Peter,
>   I think you're right.
>
> > Ideally you should check the h/w datasheet to confirm.
>  I checked the Exynos 4210 datasheet and found that 'Interrupt Combiner Operation' had only five types of registers.

> Please confirm that if there is no problem, I will modify it in later version.

Thanks for checking the datasheet -- I agree and we should keep
the "val = s->reg_set[offset >> 2];" and only delete the "return 0".

-- PMM


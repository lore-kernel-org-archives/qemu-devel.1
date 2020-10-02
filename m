Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2FBC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07CF920672
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 12:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNWkCRwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CF920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKOx-0000QF-1o
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 08:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOKN1-0007MO-SK
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:41:09 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:45051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOKMz-0007HP-CO
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 08:41:07 -0400
Received: by mail-ed1-x543.google.com with SMTP id b12so1469879edz.11
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4lj7wFOKksjbC5te72hpMm9u37ZJNaIbp0yvMq7z1UM=;
 b=jNWkCRwAPwCTd9qJht+GbQEYgpWkixshgDTvYvRkkwGBId28lBYyXayNzuII1TMg3K
 YJvEdGRL1xIJ2QoTxRxDt4Fa/oJvvaXBEcKPXnQlkT4Q8HuZ1MGZ68+wKOu58AMfIKUH
 Qs9RQL22sSQUkRmKw00oIiAvqEeshZ7N7mtIVxlikZANqFhyz1S28AYvxQOeVJxPJ1m8
 3UP+uCXGpigIkKWzI+hIgANQFiH3Z9haxMWlSQWHElc0JufWHg9YYfej14rQUr536hkw
 9UJ2IOZdrjTU1K6+aCJS+1Dklh4hi3FBCECxFzhR5xRpv8QdIkHi0GdAZzSnn43BaCvJ
 Q7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4lj7wFOKksjbC5te72hpMm9u37ZJNaIbp0yvMq7z1UM=;
 b=CzA3/m7x6Pb6ubTsSU22SZ+LjTHjnGqQujWUU11/GiEOADKEsmtuuSCoSrU7gKMVt6
 DfBdWCK6okVxeWZdV1tKHWDFz1W8R+afVhLOBHnaPE4JCm7gqL8Yg6BO5xbp1lj0u7w1
 oAWlD6ZSHtw0izYnef2F+mvR3U6Cu6QMLQgOHFJR8EWh4tkDd5lgByIoH4P2o4aRBgGI
 VloA72dnXkiMsgSU0rmr20/FwJrYh0CH4kGpdaK4vyK8DQ35fg12R0Elc7LKTrje28ge
 4+lR/qTwsVzwcfi0UXgf+yPO6LD3ck2lEh/xHFT26GDrOUwpC+OBvp3o6GmAoWaVKPlD
 FrTQ==
X-Gm-Message-State: AOAM5313jFGrDQDgQj/XFgckObDuESwSccX/aTMYdKHW41cw38pI3yO6
 bdzzLMl8/fx1FXCE+BfCSucYf3cSHNSOYC4CyehlMhtIADSUjQ==
X-Google-Smtp-Source: ABdhPJyq7QJe9PN1zEZM4Hzn4nCo2GOC1Vl2CpsxfFtGfn49lblEynCGq+1F/Y7q0igt6h3HQSJ6FjSSCNHJbfRji/o=
X-Received: by 2002:aa7:da94:: with SMTP id q20mr2176567eds.52.1601642463457; 
 Fri, 02 Oct 2020 05:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <1597278668-339715-1-git-send-email-fnu.vikram@xilinx.com>
 <CAFEAcA8gYXDJKMS3nUSW96hhwmC37=QX1EhVfWj7j0smKGvXgA@mail.gmail.com>
 <CAFEAcA-Y8GQXSU6F3-AWcW=5VcWOtT0w_Fi4SAbfT2M2zjxB1Q@mail.gmail.com>
 <20200914222838.GA75143@xilinx.com>
 <BYAPR02MB4823111774CAC3DA1577EF17BC300@BYAPR02MB4823.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB4823111774CAC3DA1577EF17BC300@BYAPR02MB4823.namprd02.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 13:40:51 +0100
Message-ID: <CAFEAcA-yeb7tKcb0C5L-JSKwAwMr_Hq6BobM+-EY-WUnSPsRNg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce Xilinx ZynqMP CAN controller
To: Vikram Garhwal <fnuv@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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

On Thu, 1 Oct 2020 at 18:57, Vikram Garhwal <fnuv@xilinx.com> wrote:
>
> Hi Peter,
> I sent rebased V10 series three weeks back as there were some issues with meson build on v9. Would it possible for you to apply the patch series?

Oops, sorry -- I didn't notice the resent series. I've put it on
my list to handle.

thanks
-- PMM


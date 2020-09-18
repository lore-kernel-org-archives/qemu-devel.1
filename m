Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C441FC43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261C721973
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 09:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HW+C+S7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261C721973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJCsp-0004u1-9E
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 05:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJCri-00045t-Hu
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:39:38 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:42131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kJCrh-0006Pk-0l
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 05:39:38 -0400
Received: by mail-ed1-x534.google.com with SMTP id j2so5413228eds.9
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MGko3N4yRhCP5W9o2ZgvmjhU08s360aMch4njDpqoz0=;
 b=HW+C+S7chGoOOe6n0gt5x3Bax7P9n9EtB0X897cDGjMUpBLAI+nMT95AvUvsCjAZXY
 RhPIXsS3EYTW2ycC99nYMG5JfdWZ+WxPqj1YN7soEU7PMIYvVTbCacCm9yV4IKt+C/U2
 pFmuAv7z+h4L+GQqx0tgo9RF1+Sw7qgs34+s1FpnvVjByIICpVflU6vMGDwPTUm2+Nxn
 NSXUyXxsK5BVn1TSqlrYAyZuXMYX3DSxXYZRfQi5tGoWlRtGRvWlgjPRQtELAfVJNWec
 cpDlrd2LSLb6M0Kcv6jlQ9u3BDTs8m4GWP/pO4OtRomDPMMd7aU1v1gMoaGqwPmx63Lw
 3lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MGko3N4yRhCP5W9o2ZgvmjhU08s360aMch4njDpqoz0=;
 b=bIkfPSAAuYkK+kPKqhiQseEl+1joHAiWVqILEwmtQP44ur2WhkKMNmwQeQ73W/IV35
 +3oVU6Sskzx8BpN/0Z46Um1DxcLmSX4GoW7OAtCeBPlDW5BvHCdzKfnGwIpyA2elKrWh
 ZCnceV836UIw5XLLedstdmCbt9LVkxK266X36VKbz4upLdyH2Ux6yXOPBxdg6krFYhH5
 t1X2jjdtreOb5pG2Cm1kHMGBDZ3twKlESfkj1lDXKhXPwujoI2TaqgwUpWid8BCoWACq
 eCXGrPSNOO5+cjHxf8J8IjezWxv8FOsxhldo6lXWPGGddR9Sq0Xpb556n6EmaWzikaEZ
 CiZQ==
X-Gm-Message-State: AOAM531ojXIFbLxorpcsXzHuP7Ukexze+2XRvFYrS/7SCe0lewJdAddK
 ZVCD8mA4zBiSbED7lWmu+/UrbQNGpBJ6JoYuQ9ma9w==
X-Google-Smtp-Source: ABdhPJyjqg9gkdI2aoji6C3Fd1DCL94w1588JLK7YAgpqwmkwN1HPiaLGdXAWD2iIL7GGK04IHuN6EjJMMsNTN7VWag=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr39059137edm.100.1600421974493; 
 Fri, 18 Sep 2020 02:39:34 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_EAC696641F035EB7E9885302EAAE37455907@qq.com>
 <7f78871a-01a8-f00f-4dcb-5ba95ed1fee4@amsat.org>
 <tencent_6FBC0FD37CA798D4766FE6B2822DAC3E2908@qq.com>
In-Reply-To: <tencent_6FBC0FD37CA798D4766FE6B2822DAC3E2908@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Sep 2020 10:39:23 +0100
Message-ID: <CAFEAcA8m0xuWfibSD06Aw3TGC3BpiqNC7M-+RiVzJrfKSbtNLg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Why_QEMU_translates_one_instruction_to_a_TB=EF=BC=9F?=
To: casmac <climber.cui@qq.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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
Cc: =?UTF-8?B?QWxleCZuYnNwLEJlbm7DqWU=?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 at 07:12, casmac <climber.cui@qq.com> wrote:
>
> Hello ,
>   thanks for the hints. I modified one parameter of  memory_region_init_ram() call ,and the slow-path problem disappeared.
>   What I did is , change the RAM size from the exact memory size needed to hold the object file section(s), to the size that TI C3X user manual memory mapping specifies.
>   The former size is significantly smaller. But I did not specify the memory mapping else where in the program, so still unsure about the cause of conflict.
>
>             memory_region_init_ram(ary_sect_chain[i].mem_region, NULL, ary_sect_chain[i].s_name,
>                                    /*ary_sect_chain[i].chain_size*4*/  ary_sect_chain[i].region_size,  &error_fatal);      //region_size is fixed as specified in CPU manual , region_size>chain_size*4

This still looks very strange. You shouldn't be creating
RAM memory regions in your COFF file loader at all. You create
the RAM memory regions for the board in the board model. Then
the file loader only needs to call rom_add_blob() or similar.
Look at the way we handle ELF files -- COFF loading should
work on a similar principle.

thanks
-- PMM


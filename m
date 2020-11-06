Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB57C388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB7222202
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVom4YYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB7222202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5Kq-0006eH-8a
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5GU-0000Ru-Ch
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:11:06 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kb5GS-0003JL-UD
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:11:06 -0500
Received: by mail-ej1-x642.google.com with SMTP id i19so2916574ejx.9
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8Vs2pfBLxJKV8gOI9Wghs5XWNKTqcSzvi0KbM+gWD5w=;
 b=LVom4YYwohLOk9a94b88nm/ym8AjeXjZ7BnGI60wJBX2vp0gMHomoP8998fbc8IcK5
 WRnydrImfOt+Qsykq84vcya5Rv6BAy40TtuTXttiFB0D9MjRpfNsryG39qMFJ/40wGrh
 z0tR8FkA8JSF13WkfK3lAKJjAr0ldsAtmJftqYlS35vIPF8DJtQSYOUNFaKSbDcN6Wq/
 kxcOdPcPfiomqT325pNbwTtkbuToJDAaIyapzEsnhcQnblhoiVXkSee5fupPGAd/tFpd
 Nj57UrKirQNQW2PaXk0rZWeHtuhCECP5W/Ut6DhQis9p+BkCBTPOWQ+toa/9u9XbOPev
 matw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8Vs2pfBLxJKV8gOI9Wghs5XWNKTqcSzvi0KbM+gWD5w=;
 b=TXR2sKXAveNS7zf/laz+VwrTvNecOpejkfsjUAz11dAoHCbuvcUssrFjDiF8750024
 X9O68//bAuBHBNLUr1REx76np3aRhJrVtPE6nRIz/OzjXqBAICEtA84hZdb7oiu9TTuy
 N89+vPg0do3gbBvIVqWol03Ib0f+ngZnT5SZBJmCNu8kPTyYNsbm4dp3OusL1mVGW6a+
 fYGKtDVXs+HWSHZYuDXtw0WSoFdKmvn8rG/cDCi+r9+naJ7/gjzJZZHL0BjjPvktHCNF
 lzCX/nQV552CMrInnUippaksrLgtNwkzi0P7WkhptbSODjm3ftUVL7ZoWAwh4GV/d6+H
 1WOA==
X-Gm-Message-State: AOAM532niAKXGvLZpYTp0kvt2bpmP2tNOJ9tbn5J75WAioe/UvuYoT5p
 PVDYiLxDdDfkzjhIIz81NgDRPAhTUvl2PJ5+ivau1Q==
X-Google-Smtp-Source: ABdhPJxVC6CdioXtrrQVvEkss2k1JhdkAjuupo/Mm42b52ViCJzOdkAXQuMW1BiGXBWgWbAqiPjJHK7F0aPrEUmF044=
X-Received: by 2002:a17:907:9e3:: with SMTP id ce3mr3065403ejc.4.1604682662839; 
 Fri, 06 Nov 2020 09:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20201106152738.26026-1-peter.maydell@linaro.org>
 <20201106152738.26026-2-peter.maydell@linaro.org>
 <29cf2911-b92a-ada5-fb03-18cd022fee14@linaro.org>
In-Reply-To: <29cf2911-b92a-ada5-fb03-18cd022fee14@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 17:10:51 +0000
Message-ID: <CAFEAcA8nTMGS_Eu_OJgNVBVyStFZ13x5sjY3Ec9bsXUfnVOydw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] linux-user/sparc: Correct sparc64_get/set_context()
 FPU handling
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 17:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/6/20 7:27 AM, Peter Maydell wrote:
> > +        if (fprs & FPRS_DU) {
> > +            for (i = 16; i < 31; i++) {
>
> 32.

Derp. Lucky this code basically never gets run, eh ? :-)

-- PMM


Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68146C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:06:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33CD2207DA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ioTnKmDl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33CD2207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8TQ0-000521-G1
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 15:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8TPQ-0004Qg-Tc
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:06:05 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:35972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8TPP-0006h9-C8
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:06:04 -0400
Received: by mail-ej1-x62c.google.com with SMTP id kq25so27586368ejb.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2bRrz3tYkaqLc+vx1ubDsEUVyYG09eLZNUPZPV1+dl0=;
 b=ioTnKmDlzRBsJUzDgK675LRSPgIyus11Ufh+9JMiWwlRlyQQgWCtz8gmFTWlFpX3H/
 ZvIFbQIbdWTLcOIsGKswZhcsNqt5FsviTCloqpkRxnGpqxycxe9KRDXnlboqXEZN2kbT
 4gBHHUY+bT0ERu8na01bKmbM70pYYegcKQG+208+H2dqwiUYe+mlqih+jcnEi0CBCAFL
 zNWntvXMkyKtqFM3w7c7iyEigKTaQ5s1USKqxa2qldsdqnjKyEXuDMFnnLiGE7bNEzcW
 /0PZfB+je12Y/4DTFX6fcV63bA9X5QlkAQfpx47C+txjfHFTwFAvHdz3uzar8wDAFyM3
 8d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2bRrz3tYkaqLc+vx1ubDsEUVyYG09eLZNUPZPV1+dl0=;
 b=dyrAWY0hfDYfxn1T4PBIvymH7xaxBJA9W4Nho9f9BfW1AACnrqF1YHuNPBbNr2Wf0E
 ATR2OqfaDj4bfKJulOlKANym/DfdJbeivz6cXdN7bYcyFgM1wry8Rk0CfD1thhbPkR51
 hGAHJcCzjACJFuD4+WO5MoLT4a08zwSK9UK/5S+Z8LKx0Cpdl4bl1KMUkp64Wifvt8w2
 jM7gmQCDcrqeL+A3o7W9GEwTKSPBh67mXAdCJsiqzLDuIzTwG1CAxXtRDYrJZe4sc6TC
 0xYg1+35sBQjT95PyB8aHCQBnQsoRb8J5kosxtRoM0u2P3qavcy5ERDNccTgblqTh773
 Df+g==
X-Gm-Message-State: AOAM533CPpovUoRQxLUfNCurb1/fOnXHTcmmGXhmTsBs3P9dI4aUeTht
 JjB2tqWeeM+R3DCMZM9YBzrX4tvZhi/uQpDRE5ZxPg==
X-Google-Smtp-Source: ABdhPJyYo5cJMDiiElSX+JjG9lsirtr9N9efJWqfcm0DlxD7Vi5+q/1VVlpO0YXr9gNvRUBHCG4W+FZB8p4/1wftGB4=
X-Received: by 2002:a17:906:68da:: with SMTP id
 y26mr25759781ejr.250.1597863961785; 
 Wed, 19 Aug 2020 12:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200819143525.2175-1-pbonzini@redhat.com>
 <CAFEAcA_8VJecDyK8FR0ty=pknmo+Hc5s0OFj+-Y1Ah-OJ01FDQ@mail.gmail.com>
 <CAFEAcA9jt21RHiu1eqAzK_PJAj9i6Ej27jT2=gfjSRZVjJsDKw@mail.gmail.com>
In-Reply-To: <CAFEAcA9jt21RHiu1eqAzK_PJAj9i6Ej27jT2=gfjSRZVjJsDKw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Aug 2020 20:05:50 +0100
Message-ID: <CAFEAcA_1rtOJjs40MCNmJHmyaXG9ObFsdmyr1mb7FnieRBWO7g@mail.gmail.com>
Subject: Re: [PULL v6 000/150] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Wed, 19 Aug 2020 at 19:16, Peter Maydell <peter.maydell@linaro.org> wrote:
> Spoke too soon; "make --output-sync -C build/all-linux-static check-tcg"
> failed with:
>
>   BUILD   TCG tests for mips-linux-user
>   CHECK   debian10
>   CHECK   debian-mips-cross
>   BUILD   mips-linux-user guest-tests with docker qemu/debian-mips-cross
>   RUN     TCG tests for mips-linux-user
>   CHECK   debian10
>   CHECK   debian-mips-cross
>   BUILD   mips-linux-user guest-tests with docker qemu/debian-mips-cross
>   RUN     tests for mips
>   TEST    threadcount on mips
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> timeout: the monitored command dumped core
> Segmentation fault
> ../Makefile.target:153: recipe for target 'run-threadcount' failed
> make[2]: *** [run-threadcount] Error 139
> /home/petmay01/linaro/qemu-for-merges/tests/tcg/Makefile.qemu:76:
> recipe for target 'run-guest-tests' failed
> make[1]: *** [run-guest-tests] Error 2
> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:450:
> recipe for target 'run-tcg-tests-mips-linux-user' failed

Seems to be consistent, so not an intermittent but presumably
an issue introduced by the meson changes.

-- PMM


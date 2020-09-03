Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7947C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:57:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93AC4206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDPqOQ5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93AC4206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmvk-0004MB-LX
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDmuh-0002gD-Ur
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:56:19 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDmug-0004Vb-0w
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 06:56:19 -0400
Received: by mail-ed1-x542.google.com with SMTP id n13so2176018edo.10
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 03:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6pRNVMvnme2tZ0uXf+v/uXfW4AuapxJLUhEv6h7XN6I=;
 b=VDPqOQ5LWvGpqa00knJSzMiVF6NtoAWc9bslwfAcOHourNalQd2vQcmno3G5Tq15MG
 ak0DLGeKVMjseih9oo6l0Lwdn323aAq9KdBmgK0Sc2MUPi5zA0FoHLiQACbH4ZFATz47
 LE6GJbNEcFaBQ1Jlgvk1p7+w/3frXnquWnt/xGPhgY+Io/pYHuEm49OJkWzcMDZf5GdP
 PWh20axzgCJGuSN1pw//bHKxPOqVu/DNFFgChGoxMo4sg1hgpjqTk02Pgt8IZxxu3T+G
 Z2JOT2AhJFmk4CijYeaHHanelXEnYQqOBzKu8H43O5hAkdkKtA/Lq4HPP0kPdNAqLQWB
 oBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6pRNVMvnme2tZ0uXf+v/uXfW4AuapxJLUhEv6h7XN6I=;
 b=aG2YnXmoetPlyTvWTfPE0yT9OXPa3BwCy3BgFjmvX9jmzQTiE3yOEOf5eL8Nz3VWKU
 j7hlisF90l3/ErH6qETsdipPZluI6OHsma/1aZZw/1y0/eP9bu93LVmDKQF0Gzo/BBWV
 969rhmAHRIb96xkoqa7s/N3p7zGMyWyAGLNhL+pTMo5GhhcCtVVT2Tr6pbP41rp5QMxN
 pZLN/Z35v2ApQvKbaeMOcTiPXngjXnT+MlC/lc3OTtFYiis3uabJ0ykt22MMoPdFNxaV
 ClkMBI2zdvCyTdHGgiOlSL2Gb1Qehn+CyqR4CwcLGRGQJhzbkwFzwZNCF55RCbw2YA4N
 6sZA==
X-Gm-Message-State: AOAM532fIK3i5P37DXMhzq1SOPQfg0IeTQ55t2st20xHPaQeGurD6E07
 31VX+W6RbqBaVFXgDJoWUlXVYWJRxT/IRIvfmIrbyg==
X-Google-Smtp-Source: ABdhPJwWFklU8rm1hk/OG2XT4dtGpOv6oI5F29n/c1BcZzJiefh0r2j7AQVs1tT6swNdCSZqLDLXa96fj/AWmH202W8=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr2513948edm.100.1599130576052; 
 Thu, 03 Sep 2020 03:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Sep 2020 11:56:04 +0100
Message-ID: <CAFEAcA9GjQ8Wr3QtPpobsFokQcgW-A2Qh1LrC-PErUgeafGN8g@mail.gmail.com>
Subject: Re: [PATCH 00/12] hw/riscv: Clean up the directory
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bin Meng <bin.meng@windriver.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 3 Sep 2020 at 11:42, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> From: Bin Meng <bin.meng@windriver.com>
>
> This is an effort to clean up the hw/riscv directory. Ideally it
> should only contain the RISC-V SoC / machine codes plus generic
> codes. Peripheral models for a specific SoC are moved to its
> corresponding hw/* subdirectories.

Ah, thanks for taking on this cleanup -- it's been something
that was unfortunately missed in code review for the initial
riscv work that we never got round to fixing later, so it's
nice to see things being moved into their proper places.

thanks
-- PMM


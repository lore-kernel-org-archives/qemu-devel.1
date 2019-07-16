Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77E8C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 17:00:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A209C205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 17:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wd/UmHv9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A209C205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnQoH-0004Iy-PD
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 13:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33336)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hnQo6-0003sz-Ny
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hnQo5-0005h4-Qi
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:00:02 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hnQo5-0005dm-HP
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 13:00:01 -0400
Received: by mail-oi1-x242.google.com with SMTP id s184so16118591oie.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ao0uqHHBTz4qaUS7QqvQ/t4Rvg3gvvAgwu364zBMAtc=;
 b=Wd/UmHv9gwG7dQXr2Q/0FEzKNArfC38cC6gTaQBPGZoLrQ0QrqUCC44L5BPtj50D4b
 SWS424z2mj/p+YPHsDkJWmMP9w8re0tqxEE4jXi53U7wirV9/ZnCvWdgau9iEKE5giO5
 9q/ZbjiN8jCk96alTT9Nrzv2TuLjXrt4m0ZeJ1wI4aeQEnEG3o1IqaavbiqoNLJ4SzPa
 TSLvjjDA7FL7QGM76r5MizBkvh3gTwH7ziye9yzo3VId+K1cGb3gLXrp5CpXay/8ckKI
 FTVJGKLKqiwSKqvdacvh2GDKMSg3X9xhQJNor7F37v6wyeRH7XVAVFFNgRSqsLu9NvVX
 q3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ao0uqHHBTz4qaUS7QqvQ/t4Rvg3gvvAgwu364zBMAtc=;
 b=atWMJ10NHFPAuBlxWNEY3wnlHhooL6iYHLgJh7956o8p3HI/5GRuo5SBCkrxZmhJYa
 R9ObFQ5mkA5MR9k6CIh+e58dsaNEUVkVr9QMsl+Gfm+1VHXT7l21xLRuXf+qErfnfmZs
 6nw5panJI/AFxskMgpU+DkGJucQmQD85wznfpdb//hX3BRZbdm+cTil/kv/PZO82trpO
 n4arZWpwpAHbjlWiPlrP0sFObg6Qszsy6jdEtieoti2uD0Z855I2RXztTdz9bHFsj4Fm
 AVWukAnxj15NmVoW2CZcedG0UfmUI0CcmXHLlyGCGcZp8DWf6D6ByHGT0x1cZAoDN0CA
 6d9A==
X-Gm-Message-State: APjAAAWnCzsGxq9ZSiH1U8YVKwjcrcQKAY+pHjYx8YKvA0rgi/IlYskr
 aXSB8YbdcWvzPmRfQQL2HeuucwvsVK+7PyC8zAMzUA==
X-Google-Smtp-Source: APXvYqxEMc/Td0uGfaU/WM8M8dYWXihnhNpRIWyXw1hnFO8Y2jLVgYd0yxH0JyQJO7mece5vgxFhPIpgKhY81sfo4/k=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr16513411oij.98.1563296400374; 
 Tue, 16 Jul 2019 10:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
 <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
 <417cd887-aec4-d8ba-1dd2-810bc4c04977@redhat.com>
In-Reply-To: <417cd887-aec4-d8ba-1dd2-810bc4c04977@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jul 2019 17:59:49 +0100
Message-ID: <CAFEAcA_JntiaOOWisqLVqAV6jc=wk4nR548KbbUcG0XLabcNpA@mail.gmail.com>
To: Laszlo Ersek <lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 at 17:51, Laszlo Ersek <lersek@redhat.com> wrote:
> The issue still reproduces, so it makes sense for me to look at the host
> kernel version... Well, I'm afraid it won't help much, for an upstream
> investigation:
>
>   4.14.0-115.8.2.el7a.aarch64
>
> This is the latest released kernel from "Red Hat Enterprise Linux for
> ARM 64 7".

OK. (I'm using 4.15.0-51-generic from ubuntu).

Could you run with QEMU under gdb, and when it hits the
assertion go back up a stack frame to the arm_cpu_realizefn()
frame, and then "print /x cpu->isar" ? That should show us
what we think we've got as ID registers from the kernel.
(You might need to build QEMU with --enable-debug to get
useful enough debug info to do that, not sure.)

thanks
-- PMM


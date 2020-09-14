Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B193C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F46920639
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEUf4fWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F46920639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqGi-000425-Sk
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHq43-0008EB-Sc
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:06:43 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHq41-0008WM-Sc
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:06:43 -0400
Received: by mail-ed1-x541.google.com with SMTP id n22so17981051edt.4
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=b6r4YPfFZyyO8v+WWsmwfMpFRqlJKFEvcZRxM6kDBQo=;
 b=sEUf4fWUS+flkc7fOTWXRn5l7jqd+eeuxQZMFA1gqZl5IHOtW8OLmwH7bC3mBCkWC9
 Wri+9V29LISZ/NOoxM1tDoNMtnkd8Ci/ueR7zfjXjEhJUVrwldPH76Iq0zogTTeFWSJc
 a+phHDStpa59CDb48q3LV9zVSEFgzYInQC7hx2WTVsEpyUSeYWJqz49HDYEZkvq04cT/
 uUvM1Fp96rCY03PTKA7nJPyznLTrhaWdxogEAJPezRMkMopKEi+v7V1XoRULLD0rQEJo
 JvecWGIr0Sogfbw/FzClVy3h6zGEsziiIbZ0w9k08yclVfDmZaqYfpAol0XqQrLr3fUX
 crUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b6r4YPfFZyyO8v+WWsmwfMpFRqlJKFEvcZRxM6kDBQo=;
 b=XzDWkCipAHGZ2kZqVE37rl3JWZcWG2fqfbrySj4N5bEAhdlAiS7jVBp7gn7Oft9JeB
 EFPKIwXJ4qujExkD+zwWtxWV8ZszCiDMzMSFqb5PGqrO52cfovlxNF2POGkXSwpHXpgN
 efsxXJOJzGk1TvsFLhdEXgDi1GdYIFjgKx/fWH+DnLA1Gqs325N2HWRz01yLKJgNbf/O
 ow2z+e9V7gdKGbHEANHwZDAvU4/afHiQQPMvXKnUA2VER7mznWbq58vNlaUr/sFc8pya
 YyFbyom0yY9X0D9CXbaaqdUpCC0LW2zAJArVYpHm56va5jDkuBqIQErpAjpUozZrn5JM
 wIFA==
X-Gm-Message-State: AOAM531KGJDX2vg/FBdsKjjbiwEQ0vco9kiw3tfsWZp4uLetDGDG37DQ
 83t1Ns4Cz9EvDOtMhaskLdsbwHk3KCqmpAznC/1Voj5gRYQ55v4k
X-Google-Smtp-Source: ABdhPJy3c5ZF7DuQxvVj/KklH9AO/GUSUhp0j6uDWB7JreMMMM7aQhmRhbHs0wA3+MceBXmzZ1trrF3vQwSePy2e3FQ=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr18403158edy.52.1600096000294; 
 Mon, 14 Sep 2020 08:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <1597278668-339715-1-git-send-email-fnu.vikram@xilinx.com>
 <CAFEAcA8gYXDJKMS3nUSW96hhwmC37=QX1EhVfWj7j0smKGvXgA@mail.gmail.com>
In-Reply-To: <CAFEAcA8gYXDJKMS3nUSW96hhwmC37=QX1EhVfWj7j0smKGvXgA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 16:06:29 +0100
Message-ID: <CAFEAcA-Y8GQXSU6F3-AWcW=5VcWOtT0w_Fi4SAbfT2M2zjxB1Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Introduce Xilinx ZynqMP CAN controller
To: Vikram Garhwal <fnu.vikram@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: francisco.iglesias@xilinx.com, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 14:16, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 13 Aug 2020 at 01:33, Vikram Garhwal <fnu.vikram@xilinx.com> wrote:
> > Vikram Garhwal (4):
> >   hw/net/can: Introduce Xilinx ZynqMP CAN controller
> >   xlnx-zynqmp: Connect Xilinx ZynqMP CAN controllers
> >   tests/qtest: Introduce tests for Xilinx ZynqMP CAN controller
> >   MAINTAINERS: Add maintainer entry for Xilinx ZynqMP CAN controller
>
> Applied to target-arm.next, thanks. (I had to make some
> minor fixups to convert the makefile changes to the new
> meson build system.)

I had to drop these patches because in the full merge build
test configs they failed to link because nothing was pulling
in the generic CONFIG_CAN_BUS files.

Could you rebase this, make the necessary changes to get it
to work with meson[*], and also make whatever Kconfig changes
are necessary so that the ZynqMP CAN controller device
declares its dependency on the generic CONFIG_CAN_BUS code,
please?

[*] you might want to look at the versions of the patches
I just sent out in my v1 pullreq today, but basically
instead of the Makefile.include changes you want some
simple one-liner changes to meson.build files, and also
tests/qtest/xlnx-can-test.c needs to #include "libqos/libqtest.h"
rather than just "libqtest.h".

thanks
-- PMM


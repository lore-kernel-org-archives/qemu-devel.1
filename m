Return-Path: <SRS0=qQQb=4Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7889CC10DCE
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E76420848
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2020 13:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRlLMhsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E76420848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAwAG-00014w-FV
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 09:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jAw9e-0000gO-Bh
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jAw9d-0001Rs-9l
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:39:42 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jAw9c-0001RQ-6s
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 09:39:41 -0400
Received: by mail-ot1-x342.google.com with SMTP id j14so7016875otq.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2020 06:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qaLQB60mLc0a24h1kEuz7djD22ltvJvtl5ExQk4HHys=;
 b=WRlLMhsTWF6dGyUleAMXFA4+tF9Qnfmzla3JgaOZO8KmZkQ73qh4WzL56PXCt8xp3P
 ke3zd/OybuG89CkkjQgR/iGB8oWiqMITlwKcSny9owCuNUU0qB+3yWPZU0OmsaNdqjS6
 n72pOYknZ1Qchtu3YMrgswQYDhf8SXjrQNKcR+N74c4dizdxJCAS+jVg89W5JO9Y4Xo5
 s6KBCeOmJXJRkT4W+fq/Nmp16bPPadC0ngjQ/bqT0/P/Ep5cxCcB1kP+IetxRCNqmTPA
 g2gtG35szOfdY+zKpMRutfB/AbLCizRn0YWUctiq8G/lZAvXJHJDY4FyURuHwr6D83Df
 2noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qaLQB60mLc0a24h1kEuz7djD22ltvJvtl5ExQk4HHys=;
 b=X3Yo0Xt6BH+kyheD/VteCKL4UuMoCA+6952JrcA/SSAY0I/bYKKWAKsx1uM14iFSKb
 +0LmXMDcvUAC5zgVSEqZGgzoA3rO9m/xX8VLUEuNY3iXHC1RTHaIv77JdXxYuJh4Fcss
 MwatObVrvLlDw84J0DLnBb7jaXpuhI2Y30eEROcAXubrj4M4H2V3J2WPzYID+L+23Npj
 GiwV8Z9jBIQIfVamg4ozO96a6C27EPmYUdGzaPTAf+EduJyEMxH0muWRJGfPUSj9smCO
 3NVMTROjkEsue/hQTTX8yt0qcPgj9CG6+Ud/iJPpoQcJFD6xDZu52skqfe4061SXip63
 FPHA==
X-Gm-Message-State: ANhLgQ3OZf2Yo4rkOYs+QXDW/7+fLzKyrj7I7WknvH0OnofPqeXmA5rN
 3wwQve/2L+D7h2uFCKzQ03pXRamIdijf1P5wsOUNQQ==
X-Google-Smtp-Source: ADFU+vuSkyHHHUvVxRFJGzbxaOQkk+ry5U+JlFcSqIzz1jcLKjUX+5Y7NE+XNApU4qo4JY2CROntQmCLb3nTPuMgfSU=
X-Received: by 2002:a05:6830:19e2:: with SMTP id
 t2mr2498553ott.97.1583674779119; 
 Sun, 08 Mar 2020 06:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200305065422.12707-1-pannengyuan@huawei.com>
 <8af2cdaa-7e3e-409f-5351-7fc54e00aab5@ilande.co.uk>
In-Reply-To: <8af2cdaa-7e3e-409f-5351-7fc54e00aab5@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 8 Mar 2020 13:39:28 +0000
Message-ID: <CAFEAcA_8SWR6MrNL98GFNASs0_qE_U4pgiw_LyiydKVaSb7C8A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] delay timer_new from init to realize to fix
 memleaks.
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Euler Robot <euler.robot@huawei.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 8 Mar 2020 at 11:58, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> I just tried this patchset applied on top of git master and it causes qemu-system-ppc
> to segfault on startup:
>
> $ gdb --args ./qemu-system-ppc
> ...
> ...
> Thread 1 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
> 0x0000555555e7e38c in timer_del (ts=0x0) at util/qemu-timer.c:429
> 429         QEMUTimerList *timer_list = ts->timer_list;
> (gdb) bt
> #0  0x0000555555e7e38c in timer_del (ts=0x0) at util/qemu-timer.c:429
> #1  0x0000555555b5d2c1 in mos6522_reset (dev=0x555556e0ac50) at hw/misc/mos6522.c:468
> #2  0x0000555555b63570 in mos6522_cuda_reset (dev=0x555556e0ac50) at
> hw/misc/macio/cuda.c:599

It looks like we haven't caught all the cases of "somebody created a
MOS6522 (or one of its subclasses) but forgot to realize it". This
particular one I think is the s->cuda which is inited in macio_oldworld_init()
but not realized in macio_oldworld_realize(). I think that pmu_init() in
hw/misc/macio/pmu.c also has this bug. We need to go through and
audit all the places where we create TYPE_MOS6522 or any of its
subclasses and make sure they are also realizing the devices they create.
(The presence of the new 3-phase reset infrastructure in the backtrace
is a red herring here -- this would have crashed the same way with the
old code too.)

We should probably find some generic place in Device code where we
can stick an assert "are we trying to reset an unrealized device?"
because I bet we have other instances of this bug which we haven't
noticed because the reset function happens to not misbehave on
an inited-but-not-realized device...

thanks
-- PMM


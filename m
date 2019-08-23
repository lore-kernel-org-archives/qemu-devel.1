Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707DDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FD022CE3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaGATZQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FD022CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1C8w-0005sQ-OR
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1C72-0004MM-II
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1C70-0007F9-Tv
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:08:28 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38132)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1C70-0007Bd-MP
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:08:26 -0400
Received: by mail-oi1-x242.google.com with SMTP id q8so7108953oij.5
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vJN13Og6DN9PUForrtTLS5vI8rP5ub7uU0ZHUkx6x1s=;
 b=YaGATZQsmivVFJe1C5VkG9cL/JPCHgSJoZeG0HEH/+I3RDMvRjfvTd8+rqd9IN0bGj
 UDmh3sNdzFrZJWA6+qlpemmPbOswBkUvBCI/mpe2pvB1i2va4DXj44jJNXjKmKfGAx7R
 cemUui97qmtKvkW7Cy6GDKofPog7o9rjwJWnupsAI22f8j7/Qbtq3wQgAZTdqX2+cSXk
 vu0nC6x13QUtoXsAzKmPzrxbIM8cEZHMxd352jXYIalHVzEDqDffBP/YrALKl7ymPDtz
 11V/PuQfzBj96GhC7Q1jVO9YaQ++yiCa4T5oDEOgbUecQ/w1jmt8QvBSW+7+h2iXRH2+
 5ZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vJN13Og6DN9PUForrtTLS5vI8rP5ub7uU0ZHUkx6x1s=;
 b=UvMtRfeNfjDqNiwb60x9zDyFhIvmLolaepkK+xaNAXGh5In0/YFRDklBA6H9GgXuQd
 LcoJYJMTCqF1ZLyVgtHKNDgUSm71kB0EjzDrz5qM/exkMBX8RLOFLcTjvV6nuMgusyGD
 oJA551fQQM8BbNZdGTLsC5uVOPJ5LZv7FZK6NgbcnwCacTjE4EsnwzqVwo/NN2kcxxb7
 zHUQ5j46T5IUlKTjTgFFIWGGhyRHYpdwNv7y+TA6SDdOvds8/MFarfYtAJcZI/6zI6BV
 DoJt2PxSAuaWD6qXSuCcnAzEF8RyHiBAUl/RFq5WwO2kEQkXLUMNN/jzM3tsD+4YV3Bb
 DiIQ==
X-Gm-Message-State: APjAAAVjXnvutRJnxqqoHzxwrO1oivrjTXZPczdBajA1kkoSq/6vY497
 kykvhJvzmNquDUGRpNXN3ikHLgI0c5TWYn3aR8g3cA==
X-Google-Smtp-Source: APXvYqwkMjRLV2CWvQt8PP3hFS3GJijfKwj5JGcmFntwfnH6rCBWME0jPEkfR6RE0vWOSUII2wDd6BxPFK3pTX/KHR4=
X-Received: by 2002:aca:4814:: with SMTP id v20mr3798918oia.98.1566576505486; 
 Fri, 23 Aug 2019 09:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <04703275-47e1-90c0-1b64-d2373ab48970@here.com>
In-Reply-To: <04703275-47e1-90c0-1b64-d2373ab48970@here.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 17:08:14 +0100
Message-ID: <CAFEAcA-Zc3zz8p8YnxTskkUizuEXCTRA6ejO_0VbtvGXYwjZRw@mail.gmail.com>
To: "Bonnans, Laurent" <laurent.bonnans@here.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] Running u-boot on raspi2
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
Cc: "Xiang, Cheng" <ext-cheng.xiang@here.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 at 16:54, Bonnans, Laurent <laurent.bonnans@here.com> wrote:
>
> Hi,
>
> We (mostly Cheng Xiang's work) have been trying to use the raspi2
> machine to boot an image through u-boot.
> It seems, however, that there are some missing pieces:
>
> The first problem is that it trips very early if we keep the cpus count
> at 4 but will continue if we hard-patch it to be a single core.
> Symptom is that it seems all cores are running and trying to execute
> something, while u-boot probably has not intention of doing something
> with SMP.
> Our guess is that it's something related to the asm spin routine in
> raspi.c, which is maybe awoken too soon by some event in the mbox?

This is probably because your binary is not expecting to be
run the way that QEMU is running it. QEMU supports two
ways of starting guest code on Arm:
 (1) Linux kernels; these boot with whatever the expected
 boot protocol for the kernel on this board is. For raspi
 that will be "start the primary CPU, but put the secondaries in
 the pen waiting on the mbox". Effectively, QEMU emulates a
 very minimal bit of the firmware, just enough to boot Linux.
 (2) Not Linux kernels; these are booted as if they were the
 first thing to execute on the raw hardware, which is to say
 that all CPUs start executing at once, and it is the job of
 the guest code to provide whatever penning of secondary CPUs
 it wants to do. That is, your guest code has to do the work
 of the firmware here, because it effectively is the firmware.

We assume that you're a Linux kernel if you're a raw image,
or a suitable uImage. If you're an ELF image we assume you're
not a Linux kernel. (This is not exactly ideal but we're to
some extent lumbered with it for backwards-compatibility reasons.)

> Second problem is that u-boot relies on some SoC timer for the
> raspberrypi 2, "System Timer" in
> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
> It has not been added to qemu, to our knowledge but it looks like it
> should be pretty easy to emulate.

Yeah, our emulation for this SoC's devices is still missing
pieces. Contributions of device models are welcome. (You
might want to check the list archives, etc -- I know there
are some bcm283x device models floating around which haven't
yet made it into mainline, which might be a workable base
for cleanup and contribution.)

thanks
-- PMM


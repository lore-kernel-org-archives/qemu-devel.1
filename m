Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2513BC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:51:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D972020767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rarDHms4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D972020767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVyV-0000fG-2c
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDVwp-0006YH-T2
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:49:23 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:40723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDVwo-0006sq-4S
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:49:23 -0400
Received: by mail-ej1-x62a.google.com with SMTP id z22so7616419ejl.7
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=J2FgTQ8L+1g40MXpk+StmtJjTdTW6lwBdo4gNa9fdMU=;
 b=rarDHms4UhX0lXQY/0IASgg7PUQ2mh8Cq2aTJvHfO/jZZvhYAIMDetFxjp3r53rUie
 PrlEXjWJp368d3hOwZqGqQzoOIOox7CT9TKG0JHPoBtR8vbHQWaollDqPfozeRr+YwR2
 vutx33JdGDHyiqmF39pk7Jn/9bVwd12kRT6zmdTmfYV9cvxvxQilccVoWizoJJWByIrh
 ndWUhlPIieIGnEr8th/ax1KiqQR6Ny1oN73mg1O3U94AMEbOilgkNB1elN0k3e8bCE2n
 0nWrJ17MN9U2baXk9QaNKpKNldktHK7Q0CgS5tDvS0IAqBNCDKnWCcv7csKOeVIxGMzb
 77Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=J2FgTQ8L+1g40MXpk+StmtJjTdTW6lwBdo4gNa9fdMU=;
 b=NPoc0C2y1lYPmmyf49EiukVZda3lqcePem7VDrHhIJdaAHKSbzLeK5Ctxaf7eM8cvg
 4KHbeKjfwD8xgIQBY1C/keqOedSjN7PtCiqG9nCVKEXq2gdemAKrLkmDUnhJ05AHxAqL
 znCPqIciAhH5G+DmEs4rOYzuVvzOgAgsYLMxcNUZ1twhf4wK4SqId8CCuH9wsMyi8amu
 +SkmUvcL8N/abSf1A5zmyUtUBM/DMvle++5HZzvOLx82nkZTZ5r5qFATK6LXJSHCgdid
 vyB2I4YTrJfjJOtgeahJ7nMdjOBHSYky0F2fXuJcbz8N5vqR/TM4Mr9+1yvdfLuxMod0
 s3gw==
X-Gm-Message-State: AOAM533IWQ/dbdQv07FPWYuNBgw4ap6aePEo3mlu8v8fdv0guZN1D1U8
 CpBlxqmUzwiC8SGvPnGiZHcP3VKZVmvG6HBO51AXKQ==
X-Google-Smtp-Source: ABdhPJxvKDggIxFoOtr83gNkdE6hczn6pDI+P4a+nTN9w6Z5BDrk8FJet7Meu0VxLTrRCaQzk8GHfa//tH1ujqNzOg4=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr853898ejb.407.1599065360346; 
 Wed, 02 Sep 2020 09:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <bbdacc80-a321-5f06-e430-973a38e7e037@amsat.org>
In-Reply-To: <bbdacc80-a321-5f06-e430-973a38e7e037@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2020 17:49:09 +0100
Message-ID: <CAFEAcA8mwjWP-KhJ5bp_Qo_h81Mt_yn8k_5oepgMas9COBQgWQ@mail.gmail.com>
Subject: Re: hw/clock: What clock rate for virt machines?
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2 Sep 2020 at 17:35, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> Peter said "'clock' is basically meaningless for virt machines",
>
> I understand and agree. But how to make that explicit/obvious in
> the code, when a device expects a clock frequency/period?

When a particular *device* needs a clock, then presumably
it has a defined purpose for it, and we can pick a
frequency for it then.

> See for example hw/riscv/virt.c, it uses the following (confusing
> to me) in virt_machine_init():
>
>    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
>        0, qdev_get_gpio_in(DEVICE(mmio_plic), UART0_IRQ), 399193,
>        serial_hd(0), DEVICE_LITTLE_ENDIAN);

In this case, the board has a model of a 16550A UART on it,
which uses its input clock to determine what the actual baud
rate is for particular guest settings of the divisor registers.
So we need to look at:
 * what does guest software expect the frequency to be?
 * what is a "good" frequency which gives the guest the best
   possible choices of baud rate?
and also at whether we need to tell the guest the frequency
via a device tree or other mechanism.

In some devices the input clock genuinely doesn't affect the
guest-visible behaviour, in which case we can pick an arbitrary
or conventional value, or just implement the device to work OK
without a clock connected.

Note also that we don't have to make a single decision for the
whole board -- we can run different devices with different clocks
if that makes sense.

Incidentally the serial.c API seems to be slightly confused
about the difference between setting the baudbase as a value
in bps (ie the traditional 9600, 115200, etc values) or a
frequency (where 115200 bps corresponds to a 1.8432MHz clock,
apparently). Luckily nobody uses the serial_set_frequency()
function :-)

thanks
-- PMM


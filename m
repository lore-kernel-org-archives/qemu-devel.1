Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A4CC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57072207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNSnKS9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57072207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDXLp-0007PS-71
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 14:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDXL0-0006V4-EU
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:18:26 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:34202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kDXKy-0001ic-OK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:18:26 -0400
Received: by mail-ej1-x62d.google.com with SMTP id d26so76620ejr.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D3wTSXZChbmEZYUHhRGIEeAxCcKUKyqSfx7J/61yesA=;
 b=SNSnKS9geg7DKS9qKOkSpqIHUoPrEUAopGdGM7L0upYtr94G38HouHVqqJ9noKcOxk
 Sui3mS3DhYub0h6N2bI5u/3YDOV+TiLl4Vhdzdqmm3p+qCYrUBV44qeHBO/bJRaV3yJR
 fsQJg6Kx6mKIyNCoe8Cm3XUkgK0z3lVOlJMYlYgmQNh+0kkYj1m7xQMfGF2XJfs8XXDe
 UhZXE6audIHFg7TFoM/Z71Tv9i/EYe6+DrwKwCB9VXacSNpuQ+mzKi6MfZR2rv6DwZRX
 tRtX411QtWKl4JbTU9kqlrOdPanBEhJJJoPY4vht1tRsdMFdu9I+nao7jipGzoL+Z6nL
 g3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D3wTSXZChbmEZYUHhRGIEeAxCcKUKyqSfx7J/61yesA=;
 b=I3smVT0aRVraxi9BBfHaAPzMYjUPvCv1xfSqg6G+9HLIr7SXB7hTwxl+yTKBZ+PcqP
 qx1Mnvj+4G0sf61Xn8f88Iz1JwfLm0rOtmb9lH28HnPs7/np7bFt/NcNTVNKqW9o4H8h
 j2xjSdKFJcN6AWJm+tzUzxwfTi4EvKF8bprKSaiq6pNa6Iexs8Ba7+McuGAtTd/TAQyU
 9jtFUqbV4vUQB/SOyogA1x3amGKbwa1Vte0DiScyP7vBpXVQVveeqvQNP4QyQiqPt7e2
 pwriYo2XQUp1xXzOVS7ymsXh8sCqKIJxImPxiD24CmIjeSmHCDuYtHYptIxUiUZE1DcV
 1/xg==
X-Gm-Message-State: AOAM532YpP7+lwobE75TH/MdFTNcTqGh+SWqKrlV2Bf41L3CcGiGwnFv
 dqYAcmtFEkYISqD5qVGjtx5mX+a2AYBOJirOPmwvOQ==
X-Google-Smtp-Source: ABdhPJyTn7hxfTYL51w/tLslG2AAgcCKoncg1AsPm3Al9SL+kDvL1GeS3lBRiI/NrmAdaNEGgXx8bOga6FVJF5bhu5A=
X-Received: by 2002:a17:906:59b:: with SMTP id 27mr1379011ejn.56.1599070702869; 
 Wed, 02 Sep 2020 11:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <bbdacc80-a321-5f06-e430-973a38e7e037@amsat.org>
 <CAFEAcA8mwjWP-KhJ5bp_Qo_h81Mt_yn8k_5oepgMas9COBQgWQ@mail.gmail.com>
 <f7b28480-c841-f0d7-a848-b5f1775ec12d@amsat.org>
In-Reply-To: <f7b28480-c841-f0d7-a848-b5f1775ec12d@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 2 Sep 2020 19:18:11 +0100
Message-ID: <CAFEAcA-3bkPkxuMXN7Wd-zBKajzXOr+Vib7XzCzsT_8YYQzTzQ@mail.gmail.com>
Subject: Re: hw/clock: What clock rate for virt machines?
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Wed, 2 Sep 2020 at 18:03, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> On 9/2/20 6:49 PM, Peter Maydell wrote:
> > On Wed, 2 Sep 2020 at 17:35, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> >> Peter said "'clock' is basically meaningless for virt machines",
> >>
> >> I understand and agree. But how to make that explicit/obvious in
> >> the code, when a device expects a clock frequency/period?
> >
> > When a particular *device* needs a clock, then presumably
> > it has a defined purpose for it, and we can pick a
> > frequency for it then.
> >
> >> See for example hw/riscv/virt.c, it uses the following (confusing
> >> to me) in virt_machine_init():
> >>
> >>    serial_mm_init(system_memory, memmap[VIRT_UART0].base,
> >>        0, qdev_get_gpio_in(DEVICE(mmio_plic), UART0_IRQ), 399193,
> >>        serial_hd(0), DEVICE_LITTLE_ENDIAN);
> >
> > In this case, the board has a model of a 16550A UART on it,
> > which uses its input clock to determine what the actual baud
> > rate is for particular guest settings of the divisor registers.
> > So we need to look at:
> >  * what does guest software expect the frequency to be?
>
> QEMU is supposed to model machine with no knowledge of the guest,
> but the virt case is a particular one indeed... as it has to know
> it is virtualized.
>
> >  * what is a "good" frequency which gives the guest the best
> >    possible choices of baud rate?
>
> I'll think about it...

My guess is that guest code assumes "same frequency an
x86 PC uses", but a risc-v person might know better...

(For QEMU I think it only makes a visible difference when
you pass a host serial port through to the guest as
otherwise we ignore whatever baud rate the guest sets.)

thanks
-- PMM


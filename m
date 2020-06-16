Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06335C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C407A20FC3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 12:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TFrXlGuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C407A20FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlAks-0000c2-V1
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 08:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlAj2-0008JO-2k
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:30:00 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlAj0-0004VG-F9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 08:29:59 -0400
Received: by mail-oi1-x241.google.com with SMTP id k4so19064717oik.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 05:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ghojns6lHjJyX0GLkkBuC1xLxAtJ6P64NWuKrqAH86c=;
 b=TFrXlGuTJ8P1eqbXmekuumISBs8R/F+RT/Whs/V0dVrMxrnDS4RfOULCYda12x/sHw
 ZUJsTxq8jNGcKtQLYjHU42h4Z58Jqxl7yTuKqfgU6w/sluvQVgolguAclT8rCZTEzTlw
 KcLhGIMubahzTdUvcXP9L3vWwiRNkm4SQk4C7n5TkOy0ckd6LvLdz6p9QyubLK8A5AW/
 3MdTQly8xjeivxU6Re0oDzbf7KBqAcbTjRnTIB7rKgA/RLhq6Hga0C0LpxRsUbKYY6/5
 iKLjjJyLhUK0HjM1yRROwEMk6D04cBAHPwiZG7nBfBcioUIqe1Xq9yf0NgTlf1JdwXaD
 HCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ghojns6lHjJyX0GLkkBuC1xLxAtJ6P64NWuKrqAH86c=;
 b=EvVvUS3T9Pi0RQyszLXoKM8QZxE7QC5EJRK01pjw5uxdEx+XaTneDJTcLFDdgssPaI
 eNTVNkWK8uU9+dZ4ohvMYKidnjF2u6bg4XoXM5Y5NljA8QubgqHI4vJIasXGLK+juQl9
 6PPOHVvN5RvUYDWSCjDoqinQS3Gz6PqekEXxNP2C0Kz+KfrN8uI0tXfZ5yVnJ61EtKyg
 VTbfIVTi4GvB4IJwZhjhDDxwhJvQFxnzWUKXctegkU4t/wlykH+XPKLi2y9bUgUtQlYp
 UL8zA1TI53sIKm2pnKeVYC6oLhBxIqvrcNRH33FrpWOPEwjACP4blG8DQFLKjX2sBTBS
 3NsQ==
X-Gm-Message-State: AOAM532zlHL8oONBhTog6TYDG14dGbRmz7Un0AOFcfoDcQV5NTVQHBrS
 +BmUXyg+3MT1WDfzaf6iSuCqN37a3HV6ZCjI1DKVow==
X-Google-Smtp-Source: ABdhPJzbh18LIXjO7N/f4qwbmivjjJ5RGbtxi6hZTdAe3cv8dbLFETEnEXqeMVk5pE0JHHmQbd2B+D2K62J+huNEgKU=
X-Received: by 2002:aca:568c:: with SMTP id k134mr2911722oib.48.1592310596963; 
 Tue, 16 Jun 2020 05:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200616063157.16389-1-f4bug@amsat.org>
 <20200616063157.16389-8-f4bug@amsat.org>
 <CAFEAcA8c3QVD=PcfMOXn720E0ExSdV+mb3qoA61AFrFVstFHHw@mail.gmail.com>
 <84c3ce87-fefd-5741-7588-7a8ca12fde4c@amsat.org>
In-Reply-To: <84c3ce87-fefd-5741-7588-7a8ca12fde4c@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 13:29:45 +0100
Message-ID: <CAFEAcA_GuCQRuwAgbQfHRKh732Kfzwj-zxX48tjBBnWCBjKLnQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] hw/misc/mps2-fpgaio: Implement push-buttons
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 11:40, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> On 6/16/20 12:27 PM, Peter Maydell wrote:
> > This change seems kind of pointless unless these GPIO lines are
> > actually wired up to something.
>
> Yes, I should have kept it out of this series, or documented
> better the goal in the cover.
>
> I'm setting the roots to motivate a team of developers to
> work on a visualization of the MPS2 board. The push-button is
> supported by Zephyr, so the the idea is the visualizer generates
> QMP GPIO event to be processed such in pca9552_set_led(), and
> interact with the guest firmware.

I think that having a framework so we can better model this kind
of push button / LED / similar thing is definitely good. I just
think we need to review it at the framework level first -- it
might turn out that actually the right way to wire up the push
button to the UI framework isn't with a GPIO wire at all.
Similarly with the other patchset that sends QMP events for
LEDs -- that also seems like it's half of a design and a bit
awkward to review without the context for what it connects to.

thanks
-- PMM


Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A79C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27690206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iYQuktV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27690206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssTL-0005pq-5I
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jssNR-0004SO-EP
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:31:33 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jssNO-0004wx-Aw
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:31:33 -0400
Received: by mail-ot1-x341.google.com with SMTP id w17so27204650otl.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jJvgg7ncCWsUv+I9lfgfZl/1muoCm3TDajkxbIRy6+c=;
 b=iYQuktV2Dn8rvgzdL+a7H1S6anDGryJJhzxtwHjXSeGFpTF3f+VneYtY1PM3c5oIVW
 +IJ3nReT9ryZE0mwwVjxjp1KPC1GT7qum3h5wFmCjMqLtdv4BlsKewOdz3U0bl5lTKZ+
 iq9fpwZ0rh6nST40/pBw5II12W0dI0DL/HKNlv7a5n71gHXXCuQZHneWyO05wVIRpsdI
 ZE0asodsGlBnjzT278Lc9n/FQtDHenwGG0s6kP3nSMqV7zebKF0bmGiSpw4wFWxNdkm1
 9MGkBJ+sNU8CcK50w4gdQ5j1WtYrGHQumjAFBQiZuntrM/ssbvmE2lSGOZBniCr0UAm1
 d/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jJvgg7ncCWsUv+I9lfgfZl/1muoCm3TDajkxbIRy6+c=;
 b=kJY12KTSrBimPRHMfeozPMSJmhunwEbqWGGWaCmsGTCTiPiRqVnbCs3MH2QZYz47rA
 +DGxoLAnabTmRNLVgRMA0KwyOL3Yy+wNjPOmfxM1mlaEeIVdDU77zr51Tsg88ShJlwux
 6thQkNuirDqTEI1cXfrStxHaEtec/LENtPyBMngpYTF3CrF99/kACpYMxKKxOfE4oyJe
 IlT1FTcg+Heg+arosUG60kFclkWci9dNZAZwDn8RY8t/PyicunxGs2q+8dkH/58Db+Y6
 019arsLyal3NHA2Ei29jNWOw7kLX8C0zoSt+cCMXZ4+eDz4ADeKIrZT8J5zYrs0pTsOo
 4n5w==
X-Gm-Message-State: AOAM531/hvURF85fyvYeLO6G9AfF7YbWVG9TkDN3da96JL+Apsa/yFUK
 RjjdpIq/5ctCdJ0D4wlDa83NUrYLkJ5BAOk58hKcJg==
X-Google-Smtp-Source: ABdhPJzWWfGh1KSywpxiw0BcJ5YkfiQuFTJz2YlGPyq0s1ULLalM2KdPL3Qal5GNOaNO0k7Arayf3SPqf/57jB2hHiw=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr39514512otk.221.1594146688887; 
 Tue, 07 Jul 2020 11:31:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200705204630.4133-1-f4bug@amsat.org>
 <20200705204630.4133-5-f4bug@amsat.org>
In-Reply-To: <20200705204630.4133-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jul 2020 19:31:17 +0100
Message-ID: <CAFEAcA-rhTk2cMayPVaULsbpYfLuQSFgr7D7w43bggP-LBqX6A@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] hw/arm/versatilepb: Comment to remember some
 IRQs lines are left unwired
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 Jul 2020 at 21:46, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> The 'card is readonly' and 'card inserted' IRQs are not wired.
> Add a comment in case someone know where to wire them.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/versatilepb.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
> index e596b8170f..45a13ae2b9 100644
> --- a/hw/arm/versatilepb.c
> +++ b/hw/arm/versatilepb.c
> @@ -310,7 +310,9 @@ static void versatile_init(MachineState *machine, int=
 board_id)
>      qdev_connect_gpio_out(sysctl, 0, qdev_get_gpio_in(dev, 0));
>
>      sysbus_create_varargs("pl181", 0x10005000, sic[22], sic[1], NULL);
> +    /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */
>      sysbus_create_varargs("pl181", 0x1000b000, sic[23], sic[2], NULL);
> +    /* FIXME wire 'card is readonly' and 'card inserted' IRQs? */

These should be wired up to the SYS_MCI register in the
"system and configuration registers" block:
https://developer.arm.com/documentation/dui0225/d/programmer-s-reference/st=
atus-and-system-control-registers/mci-register--sys-mci

Our "realview_sysctl" device implements this (we use it on the
realviewpb). However it only has support for having one MMC
device -- we'd need to extend it to have the GPIO inputs for
the 2nd MMC controller, and make the arm_sysctl_gpio_set()
function handle them to set the right bits. Then we could
wire it up at the board level fairly easily (more simply
than for realview, which also has to wire the same lines up
to a GPIO controller).

If you believe the documentation (which includes a little
circuit diagram in both the versatilepb and realviewpb manuals)
then the versatilepb doesn't have the inverter on the CARDIN
line that the realview does.

thanks
-- PMM


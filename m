Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB92C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4222E221E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BN6aMHne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4222E221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGSqe-0004Av-6a
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 16:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGSq4-0003cp-Rq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 16:06:36 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:34890)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGSq2-0002qX-RG
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 16:06:36 -0400
Received: by mail-ed1-x542.google.com with SMTP id i1so7656219edv.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 13:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9NhiAReKM+Boa40DXauFZF0PCmjlLggPNc6OR9kLVYU=;
 b=BN6aMHneys58jIZjfzXZZf4Tf6jQQFGBoBBBSd63ZSzfOKBrvIMNwEjJw/iATR+0KW
 ro53YHsv7slhZ1vYLVAz7f+Fg4Ck3dYKUry+oWZhgdnpw7omByXX95HPCP8Tu9FpfrB2
 8D1wObht9HnAmkfM410aQOTTlvSUPbFKVvv15nwTKlccuPsATuOKa4O0ceD2NGeslwTT
 3WnNqQcZItM1B+UmsL4HLWPWxwUmV8ix1b2yBdBb/LYIj7u30EhCmM7X5FDShpEmnJRe
 OSHtZv2SvrPKq5Pk9D2z88AEj906aLqpEuLb+zO3oTN9sD+ATwoSX4k70qN1XGWStiXZ
 j1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9NhiAReKM+Boa40DXauFZF0PCmjlLggPNc6OR9kLVYU=;
 b=g5eyRP7oMya9qZ6w0rGG77UrvtC6IrvuDixqEy5GdpaCuUrwvW/DF2wQm2itjAdN7V
 OEBR+HMe72RRQYJtMoLS/Zuz/CsAFFArn0TMXYpA4NnY3fLD+BU450msUWbEWYtja6cY
 Mb11Io7O3QZgIgSTfbUR1LkcYvdRXBBa838XiOT5vFhNqWGIFzu5lGgZ4A1npvLUla50
 0EMxkpCZOpuN8eijKuMYOqqpy386aeoSegS2VtiTsBKiiHZqadpRGw67Xlxd8paBV9zW
 lvEx2J5CTIE/Am/qXiKWp0AJqSVPoOC74x7zWLZJigwdsOhIWJbuBZfMWMhQBtKSrjES
 VHHA==
X-Gm-Message-State: AOAM531+EGHdV9PIB9a1CooJSXJLEFZ7Vd5nGVnIsd2KDqlY7Jj1cY+/
 p47kzSJ3caBH1COYD6BuN0HLlDnAjbg/5hvzQJ1Jcw==
X-Google-Smtp-Source: ABdhPJz+8QLWN8EHAmEApx8rkaZgb+bGmNDbeMbTmXo5Q12y1wLo9LR95kfbAeR2tgLUWjcPfJq3LKdA0Ez0Qd5Yp64=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr11562568edy.52.1599768393227; 
 Thu, 10 Sep 2020 13:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200903202048.15370-1-peter.maydell@linaro.org>
 <20200903202048.15370-3-peter.maydell@linaro.org>
 <29d7a1aa-7289-dabb-db3a-7bc5324d297f@amsat.org>
In-Reply-To: <29d7a1aa-7289-dabb-db3a-7bc5324d297f@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2020 21:06:22 +0100
Message-ID: <CAFEAcA8dMgyOoyLYweb5cSCEX3QnHKZXwa+_hoiK9VTJnZHydQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/arm/mps2: New board model mps2-an500
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kumar Gala <kumar.gala@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 14:38, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> On 9/3/20 10:20 PM, Peter Maydell wrote:
> > Implement a model of the MPS2 with the AN500 firmware. This is
> > similar to the AN385, with the following differences:
> >  * Cortex-M7 CPU
> >  * PSRAM is at 0x6000_0000
> >  * Ethernet is at 0xa000_0000
> >  * No zbt_boot_ctrl remapping of the low 16K
> >    (but QEMU doesn't implement this anyway)
> >  * no "block RAM" at 0x01000000
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > The AN500 also defines some behaviour for CFG_REG[2567] in
> > the SCC (QEMU hw/misc/mps2-scc.c) but none of it is anything
> > QEMU can conveniently support so I have left that code as-is
> > (a guest accessing those registers will hit the LOG_GUEST_ERROR
> > case for "bad offset").
> >
> > Tested with a buildroot image created using the instructions at:
> >  https://community.arm.com/developer/tools-software/oss-platforms/w/doc=
s/578/running-uclinux-on-the-arm-mps2-platform
> > and the "arm_mps2_CM7fpga" defconfig; QEMU commandline is
> >  qemu-system-arm -M mps2-an500 -serial stdio -display none -kernel boot=
.axf -device loader,file=3Dlinux.axf
>
> Maybe worth adding in the commit description.
>
> > @@ -143,13 +149,14 @@ static void mps2_common_init(MachineState *machin=
e)
> >       * tradeoffs. For QEMU they're all just RAM, though. We arbitraril=
y
> >       * call the 16MB our "system memory", as it's the largest lump.
> >       *
> > -     * Common to both boards:
> > -     *  0x21000000..0x21ffffff : PSRAM (16MB)
> > +     * AN385/AN386/AN511:
> > +     *  0x21000000 .. 0x21ffffff : PSRAM (16MB)
>
> ^ Actually this belong to the previous patch.

I guess so...

> > -     * AN385/AN386 only:
> > +     * AN385/AN386/AN500:
> >       *  0x00000000 .. 0x003fffff : ZBT SSRAM1
> >       *  0x00400000 .. 0x007fffff : mirror of ZBT SSRAM1
> >       *  0x20000000 .. 0x203fffff : ZBT SSRAM 2&3
> >       *  0x20400000 .. 0x207fffff : mirror of ZBT SSRAM 2&3
> > +     * AN385/AN386 only:
>
> Ditto?

No, this part is fine: at the previous patch it said
"AN385/AN386 only" for both these ZBT lines and the
parts below. It's only in this patch where we add the AN500
that it has to split into the ZBT lines being 385/386/500
and the remainder being 385/386 only.

> Otherwise:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

thanks
-- PMM


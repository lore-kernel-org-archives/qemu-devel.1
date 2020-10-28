Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F10C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:21:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747E5247E4
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 20:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PqR4TcuF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747E5247E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXrx2-0003hd-A1
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 16:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXrw7-0003CV-Pi
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:20:47 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:40835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXrw6-00086l-15
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 16:20:47 -0400
Received: by mail-ej1-x643.google.com with SMTP id z5so719151ejw.7
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9lGrMAj1QsIiuoujkX3zN8ZbB9FS9Jfq4Nhkt4pJR8s=;
 b=PqR4TcuFyFPdv7NBat1OGiwnQbiMl8+Zgcl28nvfnRFFF4toZoYWuLcdT7cMFCLtg+
 oWNhbh8dn7bRSH3N2yz372qiO4K2N3Zg1mQLgHEM2Fwg5/m+CNBPlAJrQEAHZZ7nBwr3
 QcTXLHKQZzJxJaXQgHhwlWkJBBntlgXqtMV76BCIzuWAwGNarev3x1KmRJWoA+phvP5N
 EiLuFmrrpSa2rbTuzW7pMKlljFg/IQaCLvIGrcpLm2co2TuYV3KPozEYXdf/x3bY8lCN
 4sQTHCvVvo1EueYw4TcyjERmJa+8O3kNAXfFwkldA99HLvl/Axea6d3QZufA0xWASKiZ
 ZJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9lGrMAj1QsIiuoujkX3zN8ZbB9FS9Jfq4Nhkt4pJR8s=;
 b=p1IWqP00gQc7H78zlngeQgvM+fL4tC0pZE22MrZ1qKf9N8zBduvpoDU0i8lhSNdk+v
 EXLiipAS1iC3aK0SupdJJqnWQusKy0zZ3V2OBS60YWC40gMiPh5aHJU2Hna/Ra8VU64h
 XkkHWvrXNhnlytjMxQtye8/YhWyUVGHiZ933USvLhlYhurABviz1VrbkI+ZoFcYd6w9+
 kTUa6raxvMjHJf8WhvtaggBNQ46kORbpd59XChP2p4JRRXOGwXGsyxl/5Eg1D/0lawGb
 Z2LAFfVXeCRdP4/xU8xa4tcoJ/tB5g0EhwUoNgteXq08rvF4o+nZcH/iOFf0PGiBDjWt
 te5A==
X-Gm-Message-State: AOAM531yG463ULvAwu6MGlNj792E8edAMsnc+TX3R6Q73W5gecXatGTa
 I/DI0dPK/R8zos5oT2mKLVYmqek/mVezoJQjfUAu7g==
X-Google-Smtp-Source: ABdhPJyIxE8Q+B6NPFRsCYrd7clF5G4OgDb48xnZMGkC97UHIrxT1DNg9zptazjf2X6CozB4Z0RvnlGiG5WmJ8YrrN4=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr912983ejf.56.1603916444230; 
 Wed, 28 Oct 2020 13:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201028041819.2169003-1-kuhn.chenqun@huawei.com>
 <20201028041819.2169003-3-kuhn.chenqun@huawei.com>
In-Reply-To: <20201028041819.2169003-3-kuhn.chenqun@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Oct 2020 20:20:33 +0000
Message-ID: <CAFEAcA9uyKHO06aZaKSZefpq_eXs12E+AzHHNbL+=amcfq66Cg@mail.gmail.com>
Subject: Re: [PATCH 2/9] hw/intc/arm_gicv3_kvm: silence the compiler warnings
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Gan Qixin <ganqixin@huawei.com>, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 at 04:19, Chen Qun <kuhn.chenqun@huawei.com> wrote:
>
> When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warn=
ing:
> hw/intc/arm_gicv3_kvm.c: In function =E2=80=98kvm_arm_gicv3_put=E2=80=99:
> hw/intc/arm_gicv3_kvm.c:484:13: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>              kvm_gicc_access(s, ICC_AP0R_EL1(1), ncpu, &reg64, true);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hw/intc/arm_gicv3_kvm.c:485:9: note: here
>          default:
>          ^~~~~~~
> hw/intc/arm_gicv3_kvm.c:495:13: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>              kvm_gicc_access(s, ICC_AP1R_EL1(2), ncpu, &reg64, true);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hw/intc/arm_gicv3_kvm.c:496:9: note: here
>          case 6:
>          ^~~~
> hw/intc/arm_gicv3_kvm.c:498:13: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>              kvm_gicc_access(s, ICC_AP1R_EL1(1), ncpu, &reg64, true);
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> hw/intc/arm_gicv3_kvm.c:499:9: note: here
>          default:
>          ^~~~~~~
>
> hw/intc/arm_gicv3_kvm.c: In function =E2=80=98kvm_arm_gicv3_get=E2=80=99:
> hw/intc/arm_gicv3_kvm.c:634:37: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>              c->icc_apr[GICV3_G0][2] =3D reg64;
>              ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> hw/intc/arm_gicv3_kvm.c:635:9: note: here
>          case 6:
>          ^~~~
> hw/intc/arm_gicv3_kvm.c:637:37: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>              c->icc_apr[GICV3_G0][1] =3D reg64;
>              ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> hw/intc/arm_gicv3_kvm.c:638:9: note: here
>          default:
>          ^~~~~~~
> hw/intc/arm_gicv3_kvm.c:648:39: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>              c->icc_apr[GICV3_G1NS][2] =3D reg64;
>              ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> hw/intc/arm_gicv3_kvm.c:649:9: note: here
>          case 6:
>          ^~~~
> hw/intc/arm_gicv3_kvm.c:651:39: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
>              c->icc_apr[GICV3_G1NS][1] =3D reg64;
>              ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> hw/intc/arm_gicv3_kvm.c:652:9: note: here
>          default:
>          ^~~~~~~
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>

Yep, these are all intentionall fallthrough.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


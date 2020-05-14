Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54843C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E419D2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 13:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rn+tNSGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E419D2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDrl-0005O3-Ua
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 09:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDr8-0004mK-Vk
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:24:58 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZDr7-0001K7-CQ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 09:24:58 -0400
Received: by mail-oi1-x241.google.com with SMTP id c12so23509885oic.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 06:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vHiZMc2dVedU01KNu6CUIzd5vm7R/CtTmT3piRYnjlk=;
 b=Rn+tNSGRzLJFCpPeZMPNHBOXbl3gwV4BgIVgP9bhUZRvqL0x9k+0G065is6tXSvTzC
 k0gg/+HHqwi3urlm+xweidtg9zxxlx1Up08DOhnTdIkC2d1m7+25MtbTEQmB7t+9R/IE
 6M3wyQLuLCzTia/hBtjh18Pt/fvLNR5uKuSLhW8SAd6FIagT2WS6m9CUg03tFky+VQfG
 /LsSI06+EMNDBEfrtGyb4Iz7YY3eHQojMOQy8EE6/9poRxFNxTcCUpXcJe+FTMG+Q8Af
 CRKmKpp3jiC4df9dLYUYQhF16mYDSlHFkBuc3KDZlDWITdmNt1SUR1Z2IzZjxFklqtnW
 sMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vHiZMc2dVedU01KNu6CUIzd5vm7R/CtTmT3piRYnjlk=;
 b=IMMih9JLC8TGKl80JAayYezdqo0j+O4mwZnEbp1TiO0sQ6fDok1PnufQ/CfLZpWMAf
 7l6Y2DYMoukQHuDD2teYVaexnG/pgp6OadnuEQymYb81jVWwcJf/Xqm0nt81Zjyi1rGJ
 TDVy80Mw/JxNuc0D6EqLnH2HZCseED1WAHhW0kP8hrWx5+KcGqVjVUmrdCuabFQyXLmJ
 20j4vjNI9SWiW9N7QHdBmW3eGwo7Nj/Dcs11V2UhZJjbJh3SZr4b8WaoOA8SFeRczra6
 /nblyzrI6lEl/DpNk/0BU0aNLFgHc5AcWzDSWcOtfE2brx58Qyb+zq78mYHiNQz2/QqM
 2vVg==
X-Gm-Message-State: AGi0PuZG7DpXSHIM599dt0Q23orUc1NsYfcXfnOGGe9vrXbHkldxo/lt
 tk9OOIpqWz9Qx0rWfMspuJqoUtTGyxi45HfLwes/+g==
X-Google-Smtp-Source: APiQypJvGEfVGbHL3Fxxslm8tCDS7UbzU+B6/IqaDilNfL/5YfSIeXll6sMq+riSu+dGXOsUmUWMGPfcZaL3dFMccZs=
X-Received: by 2002:aca:895:: with SMTP id 143mr30660040oii.163.1589462696310; 
 Thu, 14 May 2020 06:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200512074813.29992-1-f4bug@amsat.org>
 <20200512074813.29992-3-f4bug@amsat.org>
In-Reply-To: <20200512074813.29992-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 14:24:44 +0100
Message-ID: <CAFEAcA9=OkWR5mo=6K_YhraSUhQhzV3_G7cKQ9S5mPWhFZVfdw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/mips/mips_int: Use qdev gpio rather than
 qemu_allocate_irqs()
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stafford Horne <shorne@gmail.com>, John Snow <jsnow@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 12 May 2020 at 08:48, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Switch to using the qdev gpio API which is preferred over
> qemu_allocate_irqs(). One step to eventually deprecate and
> remove qemu_allocate_irqs() one day.

> diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> index 796730b11d..91788c51a9 100644
> --- a/hw/mips/mips_int.c
> +++ b/hw/mips/mips_int.c
> @@ -74,14 +74,12 @@ static void cpu_mips_irq_request(void *opaque, int ir=
q, int level)
>  void cpu_mips_irq_init_cpu(MIPSCPU *cpu)
>  {
>      CPUMIPSState *env =3D &cpu->env;
> -    qemu_irq *qi;
>      int i;
>
> -    qi =3D qemu_allocate_irqs(cpu_mips_irq_request, cpu, 8);
> +    qdev_init_gpio_in(DEVICE(cpu), cpu_mips_irq_request, 8);
>      for (i =3D 0; i < 8; i++) {
> -        env->irq[i] =3D qi[i];
> +        env->irq[i] =3D qdev_get_gpio_in(DEVICE(cpu), i);
>      }
> -    g_free(qi);
>  }

Similar comments as with the openrisc patch apply here:
 * ideally this code should be in target/mips/, not in hw/mips
 * board code should call qdev_get_gpio_in() to get the IRQ
   line, rather than fishing env->irq[] out of the CPU object
   directly
This is a bit more complicated than with openrisc, because there's
more than just a single board model, and not all MIPS boards call
cpu_mips_irq_init_cpu() so figuring out whether MIPS CPUs should
always provide inbound CPU lines, or only those with some
particular feature, or something else, would need some
investigation or MIPS knowledge. But this is an OK first
step anyway, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


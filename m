Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90ECC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56FE2065F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z2cWwuug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56FE2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnPxG-00019T-2C
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnPwH-0000Tm-AE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:08:57 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnPwF-0003bo-Kz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:08:56 -0400
Received: by mail-ot1-x342.google.com with SMTP id e5so13623871ote.11
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WQQfFDoYq40CfiHUhwwPkezB8UxyGnyyo1IvcMyHd9A=;
 b=z2cWwuugy1ElolpS7kA2UA4ngNVvaxb4o6HZrSY7JrAXq9H6iNgnW1B+WV0VKTTXau
 fXsUSSZ/oWuAP1v/S+fTJB2stPDuk9T3WcNHJVCy6gZ5ANnSu7n8lpx62wO8xATjeoLo
 sDgMMGasMwTqscNbtRLj83fIK0jsP+QvD/I6ROyFWiClLHUTFSSMW0GtqBakpk6EuYsP
 CAPGAkTFIyk73iiWhk+bXmJ0pr+shn5NYl4OavrAoiUDo9vH7AYpKBhGhc1lSOVW8L/9
 Q5tBHs+M3W1eesdnlO/Nzmdvj+VUUNZH67F5l/nlMgeoNfXhuIuMNeu2v4Vf2SJE3z19
 1liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WQQfFDoYq40CfiHUhwwPkezB8UxyGnyyo1IvcMyHd9A=;
 b=bbJBFiyn7zLEJr65ddzejsaXMmyY0T0p0XVGAMxB3AEqF5NLpsvmog9dry/UD1+JfU
 q+0/bfZ6rUrj26ax4/mR6PM6rkcRcV/f8oE/RwigpjsQXOxb1G4A3RxIzv4BuhX9VbZ9
 Qrw+WVnLxdJeSPgjfDksiRTBljWTMQ03YBmCk2Opug751QDgRVp6BnVVBCmEqUjyPgE6
 iqwQWeSVAHL4guY8965Vb47ctLSaw4HpNJKnAJCVZXyB+gLP7cjH7UmM3lAS8zJErBeH
 NtdP/kfpJdrz5UQ2YBPsmxB3RFdS9EZAnEh4kQ7xdBeys2EF+p6tuNfjJsDftBjwtslF
 9UMg==
X-Gm-Message-State: AOAM5328FF+6nGnl60Ch4J7E/FcoQtYHQjJhy4ZEfQs89L8w6EvsCsMx
 IxGBet1vEZtchOqq8R5JKAC+R30xLmUQBvNcEkIYHg==
X-Google-Smtp-Source: ABdhPJyL3JsRHd3Hzl43F42g+VhAkkmUmJghkQg+1ZAA8hia+j26AaOXCaTrnzBNdA/AfRpewCbh0DerRwSEjt03x2c=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr14128153otn.221.1592845734224; 
 Mon, 22 Jun 2020 10:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200617072539.32686-1-f4bug@amsat.org>
In-Reply-To: <20200617072539.32686-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2020 18:08:43 +0100
Message-ID: <CAFEAcA9-RkKd0EQ=hzkt6C=ZVOaQtybmt5uVkPiK35SuQZZi0g@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] mps2: Add few more peripherals
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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

On Wed, 17 Jun 2020 at 08:25, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Few patches while playing with Zephyr on the MPS2:
>
> - clean 'versatile_i2c' a bit,
> - describe it as 'ARM SBCon two-wire serial bus interface'
>   which is common on the ARM documentation,
> - add watchdog
> - added fpgaio with correct prescale clk
> - added i2c and spi
> - added gpio/i2s as unimp
> - dropped the fpgaio push-button patch
>
> Since v2:
> - added missing Kconfig select
> Since v1:
> - addressed Peter review comments



Applied to target-arm.next, thanks.

-- PMM


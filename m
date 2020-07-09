Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20DDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C0A20767
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZoB6z/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C0A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtbcd-0007tf-0j
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 14:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbbv-0007M2-91
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:49:31 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbbs-0001zl-LF
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:49:31 -0400
Received: by mail-oi1-x243.google.com with SMTP id l63so2686613oih.13
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FSCKa6nGURV29hH9IPRhTpUvlWl3FbAKLnoLYXR7qOE=;
 b=qZoB6z/00OFv0KcVfwP/FQvV2ZERilSZBJdoXNICOsdjLPFLGUGFlrvOObp1Nvsa+9
 VXRMxvo9+opWTz3vGndIGQ/zWyocfGAlb07HXfVQbz5NeA/6Bqz+pTkkKnWAimTahbyk
 /XVOOGaQ4Q4e3ZSErE3xnewIwXncCBBA7sUvdE0CxahUL7aOHXQ3T3nDLo60r4ya1s0k
 dRrbXvbAPMNgHQg3/+BTuYOGTEmwXjZ3Fx+9NUhP3QupiEAQ7M2ikbr3nIlNk9zoB/S8
 nU8SHaWkoK/PelP691tsTMiS9SaxV8OvYQeptHW8p+bhKnT3ZpEyyvChLYktSKpdZdnC
 rKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FSCKa6nGURV29hH9IPRhTpUvlWl3FbAKLnoLYXR7qOE=;
 b=dmQH/ZzycFdT2xF3qbTW1HLJg+fopwhECAEmjC4Ho3TiL+u0FQdywaG6jSEu2tpRv8
 yFBhNXXkn2tIEGNJuKtBWnnAMdA1Gb2cdadtmlGk8lI7z9iqVkXlh27CY5+xDL0673sA
 SmOI2h1UKXBvz/52iIfZwZLhRiMnjSeFeT8wtQ+cEFChfSj6DgrVMFgAD7cT+KIKaF6V
 8dUag5VngkPnxOfBrVEx0JjhdFlMV7YiRbvCCKWzRMpnHal5FbiPEFAFq5YIbPrzee3R
 FlBYe5sed51D7qnHSu7i/fAdVQYG4dRHJ9X384QJCATTGy2GLQ8WXnG8+ZpA97k8PN1X
 jOQw==
X-Gm-Message-State: AOAM530R0g92LvMxQ8INgFHNGBjnu4GjTMrr/NIcoehvws4pJ2oB/MMI
 NVhBYyq53+7klMTT/XJqDIN+q6SJSdGX8DCvZQZkcw==
X-Google-Smtp-Source: ABdhPJxfVkC6A9Eht9/5Xw6xx/EwgkFtLyXgk2YFXLwYN1TGi/PxQFHe+cMT0kthwyT8wZ2YUA7mzMhwYL4/XC217X0=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr1287480oib.163.1594320567428; 
 Thu, 09 Jul 2020 11:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200705224154.16917-1-f4bug@amsat.org>
 <20200705224154.16917-6-f4bug@amsat.org>
In-Reply-To: <20200705224154.16917-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 19:49:16 +0100
Message-ID: <CAFEAcA9vUqvHYzeSu_-OTxEMBq6fmBhZmigKoVeUbNTo8BS2iw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] hw/i2c: Document the I2C qdev helpers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 Jul 2020 at 23:42, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> In commit d88c42ff2c we added new prototype but neglected to
> add their documentation. Fix that.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Corey Minyard <cminyard@mvista.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


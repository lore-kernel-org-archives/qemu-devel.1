Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0228C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C94206E3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYqsPYhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C94206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVWf-0005so-0h
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVT1-0002De-IE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:33:23 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYVSz-0001cH-L6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:33:22 -0400
Received: by mail-ej1-x641.google.com with SMTP id za3so8914330ejb.5
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nWBcIljEW/ko2t1mvxBhw1CzN0d8Sg1eJ094QT7vBgA=;
 b=IYqsPYhICcdaJlKdW7SdyblrbWgDM5E0GnFT3BE06+BbenULPEIWjY+hw7cWNywAWS
 pOxtwUKzg6Sd/+E6isxolHVHCjumaOo3lJblF/DJ7ESCYsvYDzDMlt1GNyS+WeYu/5Hl
 CQUd/mtcTwxypzZ2L2yeB0KEnGBknQs4e5E0FMmGgsx0dDBSleNpgyoKyxnNqaP3dsju
 sk9WFPehbT1Q7khRJvxBGDPTmZg4QfPhJ/AsJXaNN2cLjGntfz3SHfC8rX+T6GIF4DKa
 l8AN0Fg81yTNzdlDULEAlbC0zCm1n9vySI+20zAn+kYJ2pjv2CZy60wYCTzZ/FmjKTCS
 m9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nWBcIljEW/ko2t1mvxBhw1CzN0d8Sg1eJ094QT7vBgA=;
 b=AoKvoqwCRPrSFsq6L/8q/yw24Fh9sWyuJBzF6ADuVmVyPUoG3dog8wQ4J/PkWnkm62
 662AsT1MULIXsRxIatzfeSFgxmMqTc4i2JqMDzCoTHdW0eMj+YiWySOGopqPJRlURQbk
 Rf3c6+KOjolN7O/DUZbXj97mkhi2WurW2yhCY7qDQd06EG0Kuls3canXWOigCPMrJhem
 cUDG2ap1UXlkjR2KSg2QTiQjq0obyxA6QacfF3KRW9g9uE+f9/F6qD6W8qZBsMlxANuo
 pP7TaIB2sHi4nQMv/b1jNhhRswftDk9XjmkfDTNkQag6a0gLWqu5tDiGPe87tsjuhtsv
 Tbdg==
X-Gm-Message-State: AOAM531zog5q8Vqm7E9qRmqHPRtBcQP2l2wbY4muGCktvoDiBtQSNNsP
 t5dabqBIAvpIv7WTkuFOkTw76e8XiXKU9Y7w17PvsqnGQzE9Dw==
X-Google-Smtp-Source: ABdhPJzclBiMxBwkwZEXWHJi/nOButkjqUoS5j6kyZnrv79v3+ptWzgGlNS0VSD1AWvaQZ8NVNWSgjvF3EYKo4AbBnI=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr2642285ejk.382.1604068400137; 
 Fri, 30 Oct 2020 07:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201019082121.1544550-1-f4bug@amsat.org>
In-Reply-To: <20201019082121.1544550-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 14:33:08 +0000
Message-ID: <CAFEAcA9tBN9mDsotycNHnh4cUVMaYtGJO8NBqgvATKw8fJ7i7g@mail.gmail.com>
Subject: Re: [PATCH] docs/system: Deprecate raspi2/raspi3 machine aliases
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: Libvirt <libvir-list@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 at 09:23, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Since commit aa35ec2213b ("hw/arm/raspi: Use more
> specific machine names") the raspi2/raspi3 machines
> have been renamed as raspi2b/raspi3b.
>
> As more Raspberry Pi 2/3 models are emulated, in order
> to avoid confusion deprecate the raspi2/raspi3 machine
> aliases.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  docs/system/deprecated.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 905628f3a0c..f0c7aaeb2ff 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -355,6 +355,11 @@ This machine has been renamed ``fuloong2e``.
>  These machine types are very old and likely can not be used for live mig=
ration
>  from old QEMU versions anymore. A newer machine type should be used inst=
ead.
>
> +Raspberry Pi ``raspi2`` and ``raspi3`` machines (since 5.2)
> +'''''''''''''''''''''''''''''''''''''
> +
> +These machines have been respectively renamed ``raspi2b`` and ``raspi3b`=
`.
> +

This isn't valid rST syntax, which requires the underlining to
be exactly the same length as the title string it underlines:

Warning, treated as error:
/home/petmay01/linaro/qemu-from-laptop/qemu/docs/system/deprecated.rst:348:=
Title
underline too short.

Raspberry Pi ``raspi2`` and ``raspi3`` machines (since 5.2)
'''''''''''''''''''''''''''''''''''''

I also think it would be helpful to have at least a sentence
saying why we've renamed the machines.

thanks
-- PMM


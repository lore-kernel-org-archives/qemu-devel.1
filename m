Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7485EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD6C206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 11:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHneHVmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD6C206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiybR-0002CV-Hc
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 07:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jiyak-0001fD-TR; Wed, 10 Jun 2020 07:08:22 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37939)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jiyak-0001fU-1X; Wed, 10 Jun 2020 07:08:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id f185so1427815wmf.3;
 Wed, 10 Jun 2020 04:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SO8xwsqAc9ZgB1fur2HM0vFHynwzylFI5vm83ftmqrA=;
 b=UHneHVmwkAb9/Jc6ucNX0n75OllKeoRpLXP5MUl9a8KTlGsZrGd0LHEG3GTAG9VnXM
 NoydpZq0bx9GodfMF1U3HU7gDkvi0JnYp53I2ubqFwneaBtK3s62tWruTV3izLCfzpP/
 fQhckSiXpqAOsYsKX7cskgmiWPEEHIw1/T6z4clD/dDzOzdEZ9xAOwt9eWO5QamoLWW6
 1UtQJAjB/Dd2RL0ygO8h3wxeer7HUYMSFrNBxKQbm0XyyH5POBgryHzLeKdg1YlvUWjj
 Ske9lBWn3t2YjXoF+WcOqka5JuGsoVbeoRobNK9y3IxNNo9xUx7rfJHEAQuyriyhgfI5
 euVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SO8xwsqAc9ZgB1fur2HM0vFHynwzylFI5vm83ftmqrA=;
 b=XDEnD2LgmCzGW2Q0yxYckp/T59y2A7liVHd+1zA/r416uV6YOkefVz/eeuHvXsmfoC
 p7AQe+/u6qYHl6tYB3reCbj4ZFjPhyFlg43pToqpvJUiEmTGCGJLOEZTC+daDk7j9xq+
 YWtGGmtPlpVI2SuAnd22vGH6yL5frNfLhCsDrY+fwMPi8R0YArhqvZUN5/aq/u2qwCSg
 69foFH6eURNcLTcyzlr1FDfSSmStYSXABdPt6RLm01WejZl69sUMLi7mR2cVr+BxbD9c
 PzJtvYJyVmHbzt3cMZwyVG3Xtki3TefaRAHW+TA8jpgUCGdLPvhtK521aDHGtHeI19Be
 Le8Q==
X-Gm-Message-State: AOAM531/huKCaF6TgPYWF+T8YPLXY2/ay7fNR/KZPXidOF7AMOK0Pqjz
 TItC6tm/ulcWyjwt7+4MK6rbOfbAJejPuK5ED24=
X-Google-Smtp-Source: ABdhPJxwYYBIdv2yJV7yZ9qwoDqhpDRkZrpx61tU4Bp0UBiLm1pmv/B0AWiTPt1Li98nuq6ekx4ncyMcv9YLHzJ0ZB0=
X-Received: by 2002:a05:600c:22c1:: with SMTP id
 1mr2817537wmg.50.1591787300462; 
 Wed, 10 Jun 2020 04:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-2-f4bug@amsat.org>
In-Reply-To: <20200608090142.6793-2-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 10 Jun 2020 13:08:07 +0200
Message-ID: <CAHiYmc5UUaSKB6Ee0ds_hj0FBTzt0iLxzNWySt0mcZ9dvtZNyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] MAINTAINERS: Mark SH4 hardware orphan
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BE=D0=BD, 8. =D1=98=D1=83=D0=BD 2020. =D1=83 11:05 Philippe Mathi=
eu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Aurelien Jarno expressed his desire to orphan the SH4 hardware [*]:
>
>   I don't mind being [...] removed from there.
>   I do not really have time to work on that.
>
> Mark the SH4 emulated hardware orphan.
>
> Many thanks to Aurelien for his substantial contributions to QEMU,
> and for maintaining the SH4 hardware for various years!
>
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.html
>
> Message-Id: <20200601214125.GA1924990@aurel32.net>
> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

The basic idea of the patch (as read from the title and the commit
message) is good and positive.

The problem is that the patch does something different than the commit
message says - pretending that it just orphans something. Which is not
good. Actually, very clumsy and bad.

It creates a whole new subsection in MAINTAINERS file (not said in the
commit message), without any consistency with the current organization
in the file. That new subsection looks completely misplaced, living
with "TCG CPUs" neighbours. On top of that, it creates a new
precedent, leaving many unanswered questions, like: Should other
targets follow the same pattern?

I personally think that creating a new subsection is just a code
churn, waste of everybody's time on unimportant things.

Wouldn't it be simpler that you just changed statuses of all Aurelien
sh4 sections to "Orphaned", as he already said he approves, and leave
sh4 sections reorganization to a future maintainer?

If you really want to reorganize sh4 sections, these changes should be
in a separate patch. "Orphaning" patch should contain only changes of
statuses.

Regards,
Aleksandar

>  MAINTAINERS | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6e7890ce82..49d90c70de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -299,9 +299,7 @@ SH4 TCG CPUs
>  M: Aurelien Jarno <aurelien@aurel32.net>
>  S: Odd Fixes
>  F: target/sh4/
> -F: hw/sh4/
>  F: disas/sh4.c
> -F: include/hw/sh4/
>
>  SPARC TCG CPUs
>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> @@ -1948,6 +1946,14 @@ F: hw/*/*xive*
>  F: include/hw/*/*xive*
>  F: docs/*/*xive*
>
> +SH4 Hardware
> +S: Orphan
> +F: hw/sh4/
> +F: hw/char/sh_serial.c
> +F: hw/intc/sh_intc.c
> +F: hw/timer/sh_timer.c
> +F: include/hw/sh4/
> +
>  Subsystems
>  ----------
>  Audio
> --
> 2.21.3
>
>


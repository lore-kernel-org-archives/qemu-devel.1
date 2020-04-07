Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF280C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7BC206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 08:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnRm5R4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7BC206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLjkL-0001mh-RN
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 04:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLjiN-00012G-1p
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLjiL-00043G-To
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:36:10 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:46671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLjiL-00041y-JW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:36:09 -0400
Received: by mail-ot1-x32b.google.com with SMTP id 111so878804oth.13
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 01:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+eG8VNgXDM+KX8xKXPMbGbqwxe5uZOSxXMEqg+Tj9G8=;
 b=BnRm5R4qgsnLpUyDLx7KGf2KnL2pWjmpmfZtTrjBX3oBEFFbjaGcVH/7+mxdwGWJJl
 KLbR8pq0eBUUYk8ld+2Fch37i+Q3FXZqoKllfx0lf0dg7y1LtNtUG0OAOMjP1ZKKIw2P
 BMqjcwWjbHMiUYN854jj/KwMx/EA+78QTxNjbyecJLuTFEiOciCbE7V3sSyfh1hzmvVN
 WU+tyHFFH1dKY3GYHD+RPXphizB82n4B9DubW5lk0oJM569mLkWut2LIQbzzkTVfU4Q6
 f78L2lSQINAKpSJhMvmlsHIarT4DY2F8qZmPIW6k9KoSeJxm6+UJTV8WUxYXYYSOi1Gp
 uT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+eG8VNgXDM+KX8xKXPMbGbqwxe5uZOSxXMEqg+Tj9G8=;
 b=Perlq1G9POpFTiwP/UQM02DFlMrYJexXmhIt/gEKiU7ff7EZjQRv+fCKMmhsvWJxBP
 6woUbXf1a0xuwOaL7kB1hLHdaUBg5+9xX+lL8InS0vOL+Cr0ZAQPs4fH0x/ckY7UJgu8
 iXs0RvdW7xHzc93jbvaAIoisiNoQRIgLsppE2Qt4OWpo/lSPq30SOsN+aZWaFXupj2UQ
 uvZP7l4BEceArLW/+SvAxAtfaUG9oQD0EoD7bbAvzORDsOR755Jw/HIM7RrEiTWpxB4X
 8BWdt69dX72ObSPsPmCMt8zObmFcMJQyS4TISjIxAjotT+h8eMTlI0yZEsYg1Lmiz2rJ
 JC8Q==
X-Gm-Message-State: AGi0PuYnbNlmRd6rd7ulma6XL0iN7vlWTFkwumW+iRMC61y0+JSGUyRd
 1GykMvsWCjMzSuyr2dxWjLOm7ySLojM9GROq02tmKg==
X-Google-Smtp-Source: APiQypL0nx9sSESlAcM/WLd7+YoSpTAtY/QCl3aIItRA6V3lKFou55iZbhLVmyndL7E6k7BBqmLgl87SR6E5owkS5I4=
X-Received: by 2002:a05:6830:11d5:: with SMTP id
 v21mr655119otq.91.1586248566452; 
 Tue, 07 Apr 2020 01:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200406235418.18315-1-f4bug@amsat.org>
In-Reply-To: <20200406235418.18315-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 09:35:55 +0100
Message-ID: <CAFEAcA8rPhPKTjxh-iPkP8qpRpCCYEDgepCK=MSwy96h_kk_7w@mail.gmail.com>
Subject: Re: [RFC PATCH-for-5.0?] target/mips/translate: Report exception in
 delay slot as UNPREDICTABLE
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "Emilio G . Cota" <cota@braap.org>, Brian Campbell <bacam@z273.org.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 00:55, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Using the BC1ANY4F instruction with a 24Kf core (MIPS32R2
> & ASE_MIPS16) we get:
>
>   $ echo -ne '\x03\x20\xf8\x09EEEE' > cop1x.bin
>   $ qemu-system-mipsel -bios cop1x.bin
>   unknown branch 0x13000
>   Aborted (core dumped)

> This is because this COP1X instruction generates a Reserved
> Instruction when used with this core, however we are in a delay
> slot, and exceptions in delay slot are architecturally unpredictable.
>
> Core dumps confunse users. Instead, report a friendlier error message:
>
>   $ qemu-system-mipsel -bios cop1x.bin
>   qemu-system-mipsel: Exception in delay slot is UNPREDICTABLE

UNPREDICTABLE behaviour should not in QEMU include
causing QEMU to exit. You can log it with LOG_GUEST_ERROR
if you like but you should do something plausible (ideally what
some bit of real hardware does when this situation happens).

PS: does MIPS use the "UNPREDICTABLE" terminology? I
thought it was an Arm-ism, but maybe it's caught on more widely.

thanks
-- PMM


Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44902C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F2020674
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F2020674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i58A9-0007Cj-1S
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 08:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i589A-0006gL-3f
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5897-0003Xu-Vf
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:42:55 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i5897-0003XJ-S3; Tue, 03 Sep 2019 08:42:53 -0400
Received: by mail-yw1-f66.google.com with SMTP id n205so5716088ywb.10;
 Tue, 03 Sep 2019 05:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8/io0aF14kRtFPrIzN+Bf+i4azHZocjXaM3gxSbPLo0=;
 b=b/SCxntfnLfibm/13ZWsLfkS+E1dS/pnOUqAdhharr09fE2/JGik7Ylkz80JHb1ptK
 T0AT34T00tvnSbg/COBbhdVpIltR2RmTcdQOuVq6gdOCr4Pemfc7Octt4p1N7mpE6GNH
 G+zj3yaEuQDOrdNGuAnT5odNp34pJJd5Ya153HqCOEpXbNED52MOL9DOumpkXEpbRbS2
 650D22EKKTlEOnajlMUi+Yby5agX6UPLLryGif8Oc4/W5RQ7NO9B/qGGZ3GM6juVBOM+
 yvfPL7+qsE4EMPpVbrZTUWWYhqT3XZEt9hVWRyaX1gBiCPisDsoozD/HPKQeKE/K5fe7
 W4Lw==
X-Gm-Message-State: APjAAAVSf3h5aGbcUbBpY97+uk/TnVq0Eg2O3ORN7QiStp6XUKQvG4gd
 Sxo8rNWKxOBzs62vVwYumfOdjQotv8XqkbBmryQ=
X-Google-Smtp-Source: APXvYqxPXpa19qDhBNUESpFYgzXOwKrH2Vbg3nFh0HjJBvKwSqE1305v4qia4JPa1AIYt7+GrD62giQFTEmio9dY1OM=
X-Received: by 2002:a81:b40a:: with SMTP id h10mr10925279ywi.368.1567514572963; 
 Tue, 03 Sep 2019 05:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180216070201.4271-1-penberg@iki.fi>
 <20180216070201.4271-3-penberg@iki.fi>
In-Reply-To: <20180216070201.4271-3-penberg@iki.fi>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 3 Sep 2019 14:42:41 +0200
Message-ID: <CAAdtpL7ZRxLS=wbKKQrxQ_Ob8sLJFGvsqPWXmgtCGWKdJ-Ga9g@mail.gmail.com>
To: Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?Q?Zolt=C3=A1n_Baldaszti?= <bztemail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.66
Subject: Re: [Qemu-devel] [PATCH v2 2/3] raspi: Raspberry Pi 3 support
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pekka and Zolt=C3=A1n,

On Fri, Feb 16, 2018 at 8:04 AM Pekka Enberg <penberg@iki.fi> wrote:
>
> This patch adds Raspberry Pi 3 support to hw/arm/raspi.c. The
> differences to Pi 2 are:
>
>  - Firmware address
>  - Board ID
>  - Board revision
>
> The CPU is different too, but that's going to be configured as part of
> the machine default CPU when we introduce a new machine type.
>
> The patch was written from scratch by me but the logic is similar to
> Zolt=C3=A1n Baldaszti's previous work, which I used as a reference (with
> permission from the author):
>
>   https://github.com/bztsrc/qemu-raspi3
>
> Signed-off-by: Pekka Enberg <penberg@iki.fi>
> ---
>  hw/arm/raspi.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index c24a4a1b14..66fe10e376 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -5,6 +5,9 @@
>   * Rasperry Pi 2 emulation Copyright (c) 2015, Microsoft
>   * Written by Andrew Baumann
>   *
> + * Raspberry Pi 3 emulation Copyright (c) 2018 Zolt=C3=A1n Baldaszti
> + * Upstream code cleanup (c) 2018 Pekka Enberg
> + *
>   * This code is licensed under the GNU GPLv2 and later.
>   */
>
> @@ -22,10 +25,11 @@
>  #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAG=
S */
>  #define MVBAR_ADDR      0x400 /* secure vectors */
>  #define BOARDSETUP_ADDR (MVBAR_ADDR + 0x20) /* board setup code */
> -#define FIRMWARE_ADDR   0x8000 /* Pi loads kernel.img here by default */
> +#define FIRMWARE_ADDR_2 0x8000 /* Pi 2 loads kernel.img here by default =
*/
> +#define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by default=
 */
>
>  /* Table of Linux board IDs for different Pi versions */
> -static const int raspi_boardid[] =3D {[1] =3D 0xc42, [2] =3D 0xc43};
> +static const int raspi_boardid[] =3D {[1] =3D 0xc42, [2] =3D 0xc43, [3] =
=3D 0xc44};

Where does the value 0xc44 comes from?

I can only find 0xc42/0xc43 defined:
https://github.com/raspberrypi/linux/blob/rpi-3.18.y/arch/arm/tools/mach-ty=
pes#L525

0xc43 seems controversial, see
http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-February/001268.=
html
addition: https://github.com/raspberrypi/linux/commit/d9fac63adac#diff-6722=
037d79570df5b392a49e0e006573R526

Looking at the firmware source, the r1 register is always set to the
BCM2708 machine id before calling the kernel:
https://github.com/raspberrypi/tools/blob/920c7ed2ee/armstubs/armstub7.S#L1=
33

Thanks,

Phil.


Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AFCC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 586572078A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 16:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="itP7RDKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586572078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrcJ-0004wS-Jy
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 12:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkrXk-0007mk-BF
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:01:05 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:32898)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkrXh-000131-Nh
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 12:01:04 -0400
Received: by mail-ot1-x344.google.com with SMTP id n6so13523819otl.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=I3yae7jKC5snnNCoi9B6lvanL8+kneVq8p+MpmcY3ws=;
 b=itP7RDKBY1KvCtFrJ0BIKHPe6o+xWSXMDcAe7+wC5hdyoEM6LMmMB08J2oXgwZ+AwC
 v1ka6Q7SMLNop8aFbhyYboih9E5PVXfFd7h6pVLO1CMxORK6RTODqG1zvDnbSqET5DnU
 OPZzCPm/r7BNtKrpqQ8i1DU4WhHelZrJFsXRqTP98bCcesoR28dxXcPFaZ7uh64So/DI
 2dXZdkFd614dOljqeQPetfmWLG7rVdErCa5xHSPrDJVgcC/JtBqq+Pb400ZyvZVZ6AeG
 NPc1QqpCbNuiP/1LUyK7DFvlcVUmm0/hxxu+DCiaqYwNK64c9EiPtg18tVuZp9WA9keq
 NwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=I3yae7jKC5snnNCoi9B6lvanL8+kneVq8p+MpmcY3ws=;
 b=MAXm0gYtzhHkMIwMCZpV6ElikoakWZWl3bDPnh6w9b13NLvGKEo2p5If3876pLVi87
 oqYBM0jgPQ4hLyRQ6a1xHyUtH94oi0FnNiUZdU8QMzv0uJC3z+wHxnn7lrFdUUKiVsQP
 601R2AnHEcW9PLtM6R89pUMSF5bx2ViIvGkfaytNgoF3twklezstp3fUOGKYQ89JMcWy
 0Cz17flw+HMLLVS9USXOEfVoOsxf4JI7KGj3pnZ+A9ctHL+GgjKrVK8WfzSNtYfmmBwE
 n8pvzzLXYZDlJJFsRc452kNAmZMTvUW8bQKo6AVd/DMIr09D2Y2kGgFI8JEscZZvfxuv
 jVXA==
X-Gm-Message-State: AOAM531ypF/zRy9bLe8A9QRXhLjdbPyr3SHbEpq+aXaMUDBrCr0eOLnx
 oudgItbRP7SfyP6wkYh88VAUNY1ljLZRjDEZoKst2w==
X-Google-Smtp-Source: ABdhPJxxO3aROImJ4mEpwC3PEFCUd5kgyB1AuR0Lv+srXREHtac3NVWFmbw7biFTCcw38ji5DM8jZoP/GnDBR5dmawM=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr22633420ote.135.1592236859809; 
 Mon, 15 Jun 2020 09:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200612175440.9901-1-f4bug@amsat.org>
 <20200612175440.9901-6-f4bug@amsat.org>
In-Reply-To: <20200612175440.9901-6-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 17:00:48 +0100
Message-ID: <CAFEAcA9tMd0VxEm_O1yre36kWp0U48SZj8tMna25h5M02X-_VQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] hw/arm/tosa: Use LED device for the Bluetooth
 led
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 12 Jun 2020 at 18:54, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/tosa.c  | 7 +++----
>  hw/arm/Kconfig | 1 +
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
> index 5dee2d76c6..86d7e0283a 100644
> --- a/hw/arm/tosa.c
> +++ b/hw/arm/tosa.c
> @@ -24,6 +24,7 @@
>  #include "hw/irq.h"
>  #include "hw/ssi/ssi.h"
>  #include "hw/sysbus.h"
> +#include "hw/misc/led.h"
>  #include "exec/address-spaces.h"
>
>  #define TOSA_RAM    0x04000000
> @@ -68,9 +69,6 @@ static void tosa_microdrive_attach(PXA2xxState *cpu)
>  static void tosa_out_switch(void *opaque, int line, int level)
>  {
>      switch (line) {
> -        case 0:
> -            fprintf(stderr, "blue LED %s.\n", level ? "on" : "off");
> -            break;
>          case 1:
>              fprintf(stderr, "green LED %s.\n", level ? "on" : "off");
>              break;

Why convert the blue LED and not the green, amber or wlan LEDs ?

thanks
-- PMM


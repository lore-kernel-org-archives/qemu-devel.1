Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E867DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 23:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F68206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 23:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="PWCm0son"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F68206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5H8d-0007Fl-Ob
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 19:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k5H61-0006b1-1y; Mon, 10 Aug 2020 19:20:49 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1k5H5y-0003di-Fa; Mon, 10 Aug 2020 19:20:48 -0400
Received: by mail-ej1-x642.google.com with SMTP id g19so11081046ejc.9;
 Mon, 10 Aug 2020 16:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=n7id5il0JMsIxlfb90CWIJnpGml4/jw1H46enYJZeXA=;
 b=PWCm0sonqzqBUbmd82bYe/YzqJyFYlUif7VeGN0pZuMYjvRa6VEAEY5voWnWFxMstQ
 AHEFpR/k73fshr94Oa28Wqig21sXFgcxZ1GXYdLOAlQTUC6FOPOTR1nT+KpJ+IZjRlc2
 RUYLEBZNQutHGr5Ae01hDHKBvxEazuSF/9VNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=n7id5il0JMsIxlfb90CWIJnpGml4/jw1H46enYJZeXA=;
 b=SygQIuIvOEEa/4cCEvC3Wz3rRFwYUTArH3DTxAyVjJPr1MHdDrMeml1wxH6xbxfoYM
 9aFuuXmiMj0H/AWqmQAyp9MjMLOSGIAW7yAGZKD7ILiZQRJxcEc07zZGlEu3MjSU4lP/
 7XB7BQpWYWLifcZHPX6LMffIPksDFCtWCl/owKeWZe1oWvr7TKpG5X6zsX+5bCGjS95c
 gES6hkgdabxhd/tUnGoXvqUd05k5lOMVSuScuEGmOCO9reBcbn5od2TwiUw+vPuCp/nW
 aniW2lMCSO73apN4TeU3D1uIRSr99xpBzfQJwJoBlLIX5Bu28pJM38V2/O4PCmoMEjEH
 5ByA==
X-Gm-Message-State: AOAM531N+reA19I/hnjKRbOC6HxnB8k+iCwGCYeyfgamEUYEFThap+h9
 2dpGeXnLFSPX+2ZKPmIkLYrh63zL5ERYp7sfHx8=
X-Google-Smtp-Source: ABdhPJyWcFof2F7APfk4p13Q6KeBZXymznTKUFIvpTfKvKve9HupXxyh8Jcd+8i56h01AUQspUhP3TPyXrktYj/gtpY=
X-Received: by 2002:a17:906:198e:: with SMTP id
 g14mr23312740ejd.266.1597101643380; 
 Mon, 10 Aug 2020 16:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200806132106.747414-1-clg@kaod.org>
 <20200806132106.747414-9-clg@kaod.org>
 <CACPK8Xcy-OzbQ4oiLaq96VzROSsmnmSAa0dytRcCVp2ot+mQnw@mail.gmail.com>
 <6ed71987-6247-2098-4e48-9c5d59a74353@kaod.org>
In-Reply-To: <6ed71987-6247-2098-4e48-9c5d59a74353@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 10 Aug 2020 23:20:30 +0000
Message-ID: <CACPK8Xfx+TQezEisV9Tbew7SpoGu0N-tvwNWq+3-t1Y1bA6dXQ@mail.gmail.com>
Subject: Re: [PATCH for-5.2 08/19] aspeed/sdhci: Fix reset sequence
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Eddie James <eajames@linux.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 17:16, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 8/7/20 1:42 AM, Joel Stanley wrote:
> > On Thu, 6 Aug 2020 at 13:21, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
> >>
> >> BIT(0) of the ASPEED_SDHCI_INFO register is set by SW and polled until
> >> the bit is cleared by HW. Add definitions for the default value of
> >> this register and fix the reset sequence by clearing the RESET bit.
> >
> > This is mentioned in the datasheet but I couldn't find if software
> > depends on the behaviour. Were you just trying to make the model more
> > accurate?
> >
> >>  #define ASPEED_SDHCI_INFO            0x00
> >> -#define  ASPEED_SDHCI_INFO_RESET     0x00030000
> >> +#define  ASPEED_SDHCI_INFO_SLOT1     (1 << 17)
> >> +#define  ASPEED_SDHCI_INFO_SLOT0     (1 << 16)
> >> +#define  ASPEED_SDHCI_INFO_RESET     (1 << 0)
> >>  #define ASPEED_SDHCI_DEBOUNCE        0x04
> >>  #define  ASPEED_SDHCI_DEBOUNCE_RESET 0x00000005
> >>  #define ASPEED_SDHCI_BUS             0x08
> >> @@ -67,6 +69,9 @@ static void aspeed_sdhci_write(void *opaque, hwaddr =
addr, uint64_t val,
> >>      AspeedSDHCIState *sdhci =3D opaque;
> >>
> >>      switch (addr) {
> >> +    case ASPEED_SDHCI_INFO:
> >> +        sdhci->regs[TO_REG(addr)] =3D (uint32_t)val & ~ASPEED_SDHCI_I=
NFO_RESET;
> >
> > I think bits 24 and 25 should be writable too?
> >
> >         sdhci->regs[TO_REG(addr)] =3D (uint32_t)val &
> > ~(ASPEED_SDHCI_INFO_RESET | ASPEED_SDHCI_INFO_SLOT10 |
> > ASPEED_SDHCI_INFO_SLOT1);
> >
> >> +
> >>      case ASPEED_SDHCI_SDIO_140:
> >>          sdhci->slots[0].capareg =3D (uint64_t)(uint32_t)val;
> >>          break;
> >> @@ -155,7 +160,8 @@ static void aspeed_sdhci_reset(DeviceState *dev)
> >>      AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);
> >>
> >>      memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);
> >> -    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =3D ASPEED_SDHCI_INFO_RESE=
T;
> >> +    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =3D
> >> +        ASPEED_SDHCI_INFO_SLOT1 | ASPEED_SDHCI_INFO_SLOT0;
> >
> > If we want to be super strict this is true for the "sd" devices, but
> > the "emmc" device in the ast2600 only sets slot0. I don't think this
> > distinction is important to model though.
>
> Both slots seems to be activated on all three SoCs. Am I looking at the
> wrong controller ?

Yes. the "SD/SDIO Host Controller" have both slots. The "eMMC
controller" at 0x1E750000 on the ast2600 has just the one slot.

We have a property for the number of slots, so we could do something like t=
his:

--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -159,12 +159,15 @@ static void aspeed_sdhci_realize(DeviceState
*dev, Error **errp)
 static void aspeed_sdhci_reset(DeviceState *dev)
 {
     AspeedSDHCIState *sdhci =3D ASPEED_SDHCI(dev);
+    uint32_t slots =3D ASPEED_SDHCI_INFO_SLOT0;

     memset(sdhci->regs, 0, ASPEED_SDHCI_REG_SIZE);

+    if (sdhci->num_slots =3D=3D 2)
+        slots |=3D ASPEED_SDHCI_INFO_SLOT1;
+
     /* Same default value on AST2400, AST2500 and AST2600 SoCs */
-    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =3D
-        ASPEED_SDHCI_INFO_SLOT1 | ASPEED_SDHCI_INFO_SLOT0;
+    sdhci->regs[TO_REG(ASPEED_SDHCI_INFO)] =3D slots;
     sdhci->regs[TO_REG(ASPEED_SDHCI_DEBOUNCE)] =3D ASPEED_SDHCI_DEBOUNCE_R=
ESET;
 }


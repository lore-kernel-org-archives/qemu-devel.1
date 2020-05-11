Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37849C54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01DD92080C
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHuJAJgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DD92080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY2hA-0008JJ-5S
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 03:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY2gH-0007pw-El
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:16:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY2gF-0001T8-OV
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:16:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id l18so9475675wrn.6
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 00:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cYmSBjzsEC4U8Cz0a4UgA1WWQyWXVQvgeZX/wOzI3WY=;
 b=mHuJAJgp/8pvCfKW0SNkJWd/H16xtyrLOqDKltxc1g4m9cpycGgHajHVfnBgZRcex4
 mwZxKSH+pwwZcHM5+tCH52Xq+gvLJtKkBTFWwBCI/CVdWJl0+EcGXskSYzveMM66AH4H
 n5w7DHJXzUZJMB+cDsPo5iulVqpSQYPWy+9xk5qXz85fYjtO91SpyfH+FQ7fgKXeLM3T
 K3ThyB972ycBEGQShj9poYhyhHL06BkFjBFM3X1ErKWfBaa+UNJdRpVIHqc+mjAgcneQ
 BngcLH2cWETLZH2agu//GEWcXGlg3yeIe6IMgmx+jmTLq3bbT5/e5ByTStHCHzkhbXqY
 JO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cYmSBjzsEC4U8Cz0a4UgA1WWQyWXVQvgeZX/wOzI3WY=;
 b=my16a9Uy6miv5XH2YW1ttwekaMcWPQQGmnMsLiHFB6ZoPJyTr/NDGOdJN0BnLK91sR
 jPmGYd6hlm/T/SK21bB7Ell0kojPSvc3EaMljnejsQudbNUfc7zhrxd3WegJ0CP2gl1Z
 eV6MbJtAnt73NkYGfWMWEh2p2bIXKYDYlRDi5EfjDeRrY2bMUI8KHY34VlNZwvbViHbq
 KXgVCwgo0HWVunROc08lZ5HezGmcrtHX94KgRRmM1WKCcXMBdjRVEhOpiXU9Pq9N9T7x
 oLgundS/C7o05/hf/z7w2FO87iXfpyqwrEJ92kp2pWvC+c6keOWEgMOmOXUpXNmprz5a
 gtag==
X-Gm-Message-State: AGi0Puau+gLDPX8bD2rRV5TH/Cw5eSsBDaejy+f1S3uee7DTb80K0dkh
 grArR7Hf88pUrNQN06ygJRPE9HsRsJeSIRkgZz4=
X-Google-Smtp-Source: APiQypIflNKP1+6qQ1fnJVS15U8IdVIjY3/oM/LAhGFuQ3miWNLsyH3rVe1GEk3Ov3Io39pOE3Y19FPJRhbsptJDXRg=
X-Received: by 2002:a5d:4b0f:: with SMTP id v15mr7842739wrq.162.1589181409860; 
 Mon, 11 May 2020 00:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200510210128.18343-1-f4bug@amsat.org>
 <20200510210128.18343-12-f4bug@amsat.org>
 <CAHiYmc5xCbftuexryEkY4+1FxOWVqz-wzJN2fg_dCiif0-BhYQ@mail.gmail.com>
 <58233ffa-f763-9948-6dfa-1b3159ae829f@amsat.org>
In-Reply-To: <58233ffa-f763-9948-6dfa-1b3159ae829f@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 11 May 2020 09:16:37 +0200
Message-ID: <CAHiYmc6zz=Ym5jd9C5BVYv28ofrXZq-kSMtgseNVr3MmLHt65g@mail.gmail.com>
Subject: Re: [PATCH 11/12] hw/pci-host/bonito: Set the Config register reset
 value with FIELD_DP32
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BE=D0=BD, 11. =D0=BC=D0=B0=D1=98 2020. =D1=83 08:30 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 5/11/20 8:17 AM, Aleksandar Markovic wrote:
> > =D0=BD=D0=B5=D0=B4, 10. =D0=BC=D0=B0=D1=98 2020. =D1=83 23:01 Philippe =
Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> Describe some Config registers fields with the registerfields
> >> API. Use the FIELD_DP32() macro to set the BONGENCFG register
> >> bits at reset.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>   hw/pci-host/bonito.c | 21 ++++++++++++++++++++-
> >>   1 file changed, 20 insertions(+), 1 deletion(-)
> >>
> >
> > Some Config registers? Is there any reason not to cover all Bonito
> > config registers? Or, the commit message was inprecise?
>
> The commit message is not correct English, I wanted to say "some bits of
> the Config register" (I don't want to overload the file defining bits
> we'll never use).
>
> >
> > But, in general, I salute the intent of this patch.
>
> Thanks! I'll reword the description.
>

OK, then, with that little rewording, certainly, a good patch:

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

> >
> > Sincerely,
> > Aleksandar
> >
> >> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> >> index 335c7787eb..86aceb333a 100644
> >> --- a/hw/pci-host/bonito.c
> >> +++ b/hw/pci-host/bonito.c
> >> @@ -50,6 +50,7 @@
> >>   #include "sysemu/runstate.h"
> >>   #include "exec/address-spaces.h"
> >>   #include "hw/misc/unimp.h"
> >> +#include "hw/registerfields.h"
> >>
> >>   /* #define DEBUG_BONITO */
> >>
> >> @@ -112,8 +113,19 @@
> >>   /* Power on register */
> >>
> >>   #define BONITO_BONPONCFG        (0x00 >> 2)      /* 0x100 */
> >> +
> >> +/* PCI configuration register */
> >>   #define BONITO_BONGENCFG_OFFSET 0x4
> >>   #define BONITO_BONGENCFG        (BONITO_BONGENCFG_OFFSET >> 2)   /*0=
x104 */
> >> +REG32(BONGENCFG,        0x104)
> >> +FIELD(BONGENCFG, DEBUGMODE,      0, 1)
> >> +FIELD(BONGENCFG, SNOOP,          1, 1)
> >> +FIELD(BONGENCFG, CPUSELFRESET,   2, 1)
> >> +FIELD(BONGENCFG, BYTESWAP,       6, 1)
> >> +FIELD(BONGENCFG, UNCACHED,       7, 1)
> >> +FIELD(BONGENCFG, PREFETCH,       8, 1)
> >> +FIELD(BONGENCFG, WRITEBEHIND,    9, 1)
> >> +FIELD(BONGENCFG, PCIQUEUE,      12, 1)
> >>
> >>   /* 2. IO & IDE configuration */
> >>   #define BONITO_IODEVCFG         (0x08 >> 2)      /* 0x108 */
> >> @@ -577,11 +589,18 @@ static int pci_bonito_map_irq(PCIDevice *pci_dev=
, int irq_num)
> >>   static void bonito_reset(void *opaque)
> >>   {
> >>       PCIBonitoState *s =3D opaque;
> >> +    uint32_t val =3D 0;
> >>
> >>       /* set the default value of north bridge registers */
> >>
> >>       s->regs[BONITO_BONPONCFG] =3D 0xc40;
> >> -    s->regs[BONITO_BONGENCFG] =3D 0x1384;
> >> +    val =3D FIELD_DP32(val, BONGENCFG, PCIQUEUE, 1);
> >> +    val =3D FIELD_DP32(val, BONGENCFG, WRITEBEHIND, 1);
> >> +    val =3D FIELD_DP32(val, BONGENCFG, PREFETCH, 1);
> >> +    val =3D FIELD_DP32(val, BONGENCFG, UNCACHED, 1);
> >> +    val =3D FIELD_DP32(val, BONGENCFG, CPUSELFRESET, 1);
> >> +    s->regs[BONITO_BONGENCFG] =3D val;
> >> +
> >>       s->regs[BONITO_IODEVCFG] =3D 0x2bff8010;
> >>       s->regs[BONITO_SDCFG] =3D 0x255e0091;
> >>
> >> --
> >> 2.21.3
> >>
> >


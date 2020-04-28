Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E10C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A829206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 09:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAKWe/Pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A829206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTMRv-0003z2-W2
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 05:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jTMOP-0001sW-D8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jTMFN-0004Hx-5m
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 05:14:15 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:38411)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jTLUR-0007D8-JD
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 04:21:15 -0400
Received: by mail-lf1-x144.google.com with SMTP id l11so16152401lfc.5
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 01:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZUx/xjE9NXEeS9tDsU3YesOkwefV2k0p1VjLEozlvD0=;
 b=rAKWe/PkEV7kmXbb8o6TqKcCKfEN1pZUuJq9dIEETODWLjwuckIpdh/U+v8Rvlf56v
 OIncM1Dl37/gXLV/wMpYjQzRZ94r4IVmSEFbavlK4GWp3v8RFN6RpFYiR7YrI03T6/f8
 R4qH4yWci8M2o9npo1StbwzgPZoZPTTxVtfezQTuDeaK4VQSJe/ykkQwxQIKlOFDlWxU
 JeYB15hud6H+/Drhj2/WWw8EYv+4ntXNofzXQF+2m8zXd85j8IdAAdUF29Sckp37xMrY
 G+qES5k6he0KWf6jzflJEFS9q3ZAun+uGd55xS7oxMNDCTmeOxuXOfvP0AE+qH9h6RTj
 uRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZUx/xjE9NXEeS9tDsU3YesOkwefV2k0p1VjLEozlvD0=;
 b=MKEY7YIT25XR7gfJ2Al3ht8reAtFsNrl73fbFIg89MA/OSKJt1TBefwW2GoVaeuj1B
 CQFX96yezGrjnjY3ePFadm1/Y+DGpCuCtL71bq2XSNx+y4Y0qnLQmy1t+bUNtDYSyhLL
 qwiTTaC3qfrtfTtTdS0LGkQGWq8v6/acGsunb6CduuGNBDpZSMpEKycDUJ9v7V1MCm3g
 9OM5bXJx+cwFOGjgWKZIuc1dHm80eHA+5ycjvw1dO9QxOgNaLZEsXHVOxfr+3s5/g18V
 I1+vVVnXSm5y959jecGxxyEgzO8j7MTJs9VynNB0A2GRmFzE+Mgxn0mIdmz1+hnhLKnq
 VA4A==
X-Gm-Message-State: AGi0PubDcuDA79PRdloZLvTOhbEJNEnWU/SHKss8PwAsaPsagZmiqUhI
 zerg/KwovKUXs4vWhkiSkxxeRjwRGGjj3jF3biE=
X-Google-Smtp-Source: APiQypLmBSJK6PqR4ie5yIz1/22BhDfb5dafA3aOV3JRLLNrruBcolHfWp7lJNw9qwsrn8yIsBzndFBuqHC2WOBKhn8=
X-Received: by 2002:ac2:5559:: with SMTP id l25mr18202886lfk.55.1588062073611; 
 Tue, 28 Apr 2020 01:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-3-git-send-email-chenhc@lemote.com>
 <5a4cc457-971c-de9b-7380-c5e81d1b378b@amsat.org>
In-Reply-To: <5a4cc457-971c-de9b-7380-c5e81d1b378b@amsat.org>
From: chen huacai <zltjiangshi@gmail.com>
Date: Tue, 28 Apr 2020 16:28:42 +0800
Message-ID: <CABDp7Voe_WJwa6J9W-rQdSRHMx+u=46tfd9ufEdAkE36e59_FQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 3/7] hw/mips: Add CPU IRQ3 delivery for KVM
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=zltjiangshi@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-level <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Mon, Apr 27, 2020 at 5:57 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 4/27/20 11:33 AM, Huacai Chen wrote:
> > Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch add
> > IP2 delivery as well, because Loongson-3 based machine use both IRQ2
> > (CPU's IP2) and IRQ3 (CPU's IP3).
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > ---
> >  hw/mips/mips_int.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> > index 796730b..5526219 100644
> > --- a/hw/mips/mips_int.c
> > +++ b/hw/mips/mips_int.c
> > @@ -48,16 +48,14 @@ static void cpu_mips_irq_request(void *opaque, int =
irq, int level)
> >      if (level) {
> >          env->CP0_Cause |=3D 1 << (irq + CP0Ca_IP);
> >
> > -        if (kvm_enabled() && irq =3D=3D 2) {
> > +        if (kvm_enabled() && (irq =3D=3D 2 || irq =3D=3D 3))
>
> Shouldn't we check env->CP0_Config6 (or Config7) has the required
> feature first?
I'm sorry that I can't understand IRQ delivery has something to do
with Config6/Config7, to identify Loongson-3?

>
> >              kvm_mips_set_interrupt(cpu, irq, level);
> > -        }
> >
> >      } else {
> >          env->CP0_Cause &=3D ~(1 << (irq + CP0Ca_IP));
> >
> > -        if (kvm_enabled() && irq =3D=3D 2) {
> > +        if (kvm_enabled() && (irq =3D=3D 2 || irq =3D=3D 3))
> >              kvm_mips_set_interrupt(cpu, irq, level);
> > -        }
> >      }
> >
> >      if (env->CP0_Cause & CP0Ca_IP_mask) {
> >



--=20
Huacai Chen


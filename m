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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E0EC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA60820575
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 18:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCBpkNe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA60820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45515 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTVSE-0003Zk-4n
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 14:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jTVRK-0002Q6-Hq
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:58:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jTVRH-0008Rv-VE
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:58:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jTVRH-0008Rg-JK
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 14:58:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id x4so4054970wmj.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 11:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Dq51KaSYQwvgRi06Sw6vX1BCpzIodik5YZab6lt1lW0=;
 b=DCBpkNe6UBOqxTV1YBRhzUPWvZEibS4Qnx2yIPk4p7JT4cmKgWg3JLZCbhhpZpX01y
 yrc16wf3x2YbAEpE5eJ+w69PjFTbe0g7U10sjvBREIsUSRh+kFO6u5muqo1HePTJKfGq
 Ov6m8yLjcTDngEtYhqaiU/4kL1M/xQtNuVLOXxeywouLuKsf6oy8Kd/JzLZAYpH13Tzd
 6fySfbXeDmxJ9UMlVWIPh6XKrTZ3Qra1ISyX/MjQYoe1gJLhIlop+RvXIiw4BdhtJCqu
 wMCV21B7mTGkM5/KnAm5y4eiluG5W6YyhW5f7AWpQVqwU9eZJgA4ByyV4eWqFPSm/DrZ
 e+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Dq51KaSYQwvgRi06Sw6vX1BCpzIodik5YZab6lt1lW0=;
 b=dlZZ0oL0WEkSmtId1eaMDCSEOme4AFiNVVbdiNF9nK+i7EGnPgFe6/1CpEVB46eduv
 ZVntCxTKBcWE6A/UAly1NkSeeWLL7alY049oS7c6qX38N56Re1h/tSisorb/NwHtRXOH
 KzmTXQQwMGFuHUO3+rOPTVoj0ko4CVpw2iKxIg8Yka7xrqMtBhCXtMqz5XzZ1RCpLP1Z
 Yj53acH0v/lU7lo825euUcAR/vNJTLi/JTtmvjKLfgmgd6mKuuAlUNMhv7hRO3eX2bxs
 g67Qv3j688hPKAjBuEKx60V0FRjnIwDGb9W5u5rL/aLn6PmONpsnodgcvcZxcUYbwk9b
 Ky/g==
X-Gm-Message-State: AGi0Puaa2z7Ih9PUjWMOUFTnCSdt+N4cc3DHqgQ5nLQSmjEGbJVggskp
 nC4/3NNOz1Q87dd1aXxS6ZoqeApVKVaf47Nu3Lw=
X-Google-Smtp-Source: APiQypJ9tjvyqItdKyBp8mJaSpv/MS6CJ9whOaWP9fEpEG0xuileUxI+kP1Cz3l8Ae6bDD5YU2N9YhmUg27Ons3MTiI=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr6453250wmi.50.1588100317753; 
 Tue, 28 Apr 2020 11:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-3-git-send-email-chenhc@lemote.com>
 <5a4cc457-971c-de9b-7380-c5e81d1b378b@amsat.org>
 <CABDp7Voe_WJwa6J9W-rQdSRHMx+u=46tfd9ufEdAkE36e59_FQ@mail.gmail.com>
In-Reply-To: <CABDp7Voe_WJwa6J9W-rQdSRHMx+u=46tfd9ufEdAkE36e59_FQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 28 Apr 2020 20:58:25 +0200
Message-ID: <CAHiYmc5R8icimeJ3i=E-8_uUWpRMUUH67xZKFk04CrjgXKHgcQ@mail.gmail.com>
Subject: Re: [PATCH for-5.1 3/7] hw/mips: Add CPU IRQ3 delivery for KVM
To: chen huacai <zltjiangshi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 28. =D0=B0=D0=BF=D1=80 2020. =D1=83 10:21 chen huacai <=
zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BE/=D0=BB=D0=B0:
>
> Hi, Philippe,
>
> On Mon, Apr 27, 2020 at 5:57 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
> >
> > On 4/27/20 11:33 AM, Huacai Chen wrote:
> > > Currently, KVM/MIPS only deliver I/O interrupt via IP2, this patch ad=
d
> > > IP2 delivery as well, because Loongson-3 based machine use both IRQ2
> > > (CPU's IP2) and IRQ3 (CPU's IP3).
> > >
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > ---
> > >  hw/mips/mips_int.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/mips/mips_int.c b/hw/mips/mips_int.c
> > > index 796730b..5526219 100644
> > > --- a/hw/mips/mips_int.c
> > > +++ b/hw/mips/mips_int.c
> > > @@ -48,16 +48,14 @@ static void cpu_mips_irq_request(void *opaque, in=
t irq, int level)
> > >      if (level) {
> > >          env->CP0_Cause |=3D 1 << (irq + CP0Ca_IP);
> > >
> > > -        if (kvm_enabled() && irq =3D=3D 2) {
> > > +        if (kvm_enabled() && (irq =3D=3D 2 || irq =3D=3D 3))
> >
> > Shouldn't we check env->CP0_Config6 (or Config7) has the required
> > feature first?
> I'm sorry that I can't understand IRQ delivery has something to do
> with Config6/Config7, to identify Loongson-3?
>

Obviously, yes.

Thanks,
Aleksandar


> >
> > >              kvm_mips_set_interrupt(cpu, irq, level);
> > > -        }
> > >
> > >      } else {
> > >          env->CP0_Cause &=3D ~(1 << (irq + CP0Ca_IP));
> > >
> > > -        if (kvm_enabled() && irq =3D=3D 2) {
> > > +        if (kvm_enabled() && (irq =3D=3D 2 || irq =3D=3D 3))
> > >              kvm_mips_set_interrupt(cpu, irq, level);
> > > -        }
> > >      }
> > >
> > >      if (env->CP0_Cause & CP0Ca_IP_mask) {
> > >
>
>
>
> --
> Huacai Chen


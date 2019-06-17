Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4B3C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23B0208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7Cm14Uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23B0208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvbx-0007cC-T3
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41976)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hcvKD-0000wC-4X
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hcvKB-0003Yh-NB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:21:45 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:36761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hcvK6-0003P9-K4; Mon, 17 Jun 2019 13:21:39 -0400
Received: by mail-lf1-x141.google.com with SMTP id q26so7117563lfc.3;
 Mon, 17 Jun 2019 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UvEXy6R2Oa0rw1CPw6Eg9Azivk9jG3zrLJWOzgsj+sI=;
 b=q7Cm14UcndjBBBGQs1VXcwRC8FOqZfvLoKvafiy+9Istjldw3CdnWgzwRiLLcMDfA8
 k8WUdnUIMEsPR2rzBKY0yc5fFokRib8UpISVqE77ise2Omj9bf3NWtJnSxAop3vgxUlz
 wTWOg/neRdw0uhxTI2SgqvvHL8A/KQfvPFoCGTe7mJQ2kynMmOmEz6ZIO+PEgCTfNUOG
 Kz7/l56cS1tgHSHXg+bLNFBLIBb1khW/YwR74e8SlxVjC1MMLJMG6eNwjSgEhbtDSEuh
 P3VxC+yG3fiUR3vOSXAJk4f4OcMIgfrVCLx8FoAsmI4h5ZOTi5XXfPXkJeiIDSqPgtiu
 6TVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UvEXy6R2Oa0rw1CPw6Eg9Azivk9jG3zrLJWOzgsj+sI=;
 b=U3UPb7Loz81y7inNPsw/g4RVtzjXrSTtpaLcZExxeCcwsLsB/WhQxR4hydmkaKoU8N
 y9KFhdj0b93jydPOdO2kFHb1cEV70bOJWe7efAXYnvSygt/ZrVM0iA6+au2XxXtiCIn6
 bjrAXApQq5ctzX/2Rfu+n+3eBp9DSMcYTS/8eCALrYJryA+i05POllADrXFdsENybqI5
 GSMJWsi3Djs4DGgNTQuI7xDcbjQ/er095sHs3EQhaW9fwTPhg+cau39mkjiLywfgtdO5
 IN473E+2IpiS9n248qbZ1DZ7yE98oH8SlVxcXUtrMkjWRUKaacycXE7PpWFPzzr4NbSl
 pKyw==
X-Gm-Message-State: APjAAAVRwkba3Scb+dOxeOYw74urNQiT589cZyO2WDkYXapOP+mazzKG
 cZ6DDAo3hy1ggDBMyNULW30PPQHYbkKkMdBimFE=
X-Google-Smtp-Source: APXvYqxzBbqiKphbJeBOyYKPL0V+OWiDjyEQraqhUILNDPVMtsIu9zFAriFzm9tMU7ZeEwX6hShWA0M0pOxZiy8xgfw=
X-Received: by 2002:a19:4c05:: with SMTP id z5mr46726034lfa.5.1560792096478;
 Mon, 17 Jun 2019 10:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <13fe08a2-c89c-b015-3799-067e0f04bfd3@redhat.com>
 <mhng-fb0f4eaf-5e38-4e66-958a-9942273b48c3@palmer-si-x1e>
In-Reply-To: <mhng-fb0f4eaf-5e38-4e66-958a-9942273b48c3@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 17 Jun 2019 10:18:49 -0700
Message-ID: <CAKmqyKPCXy3_YMuXmhYpoGvay4m5BpsOrs4VtFF9cU9gL-bedg@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH] RISC-V: Fix a memory leak when realizing a
 sifive_e
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 16, 2019 at 1:15 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 14 Jun 2019 05:25:50 PDT (-0700), philmd@redhat.com wrote:
> > On 6/14/19 2:08 PM, Palmer Dabbelt wrote:
> >> Coverity pointed out a memory leak in riscv_sifive_e_soc_realize(),
> >> where a pair of recently added MemoryRegion instances would not be fre=
ed
> >> if there were errors elsewhere in the function.  The fix here is to
> >> simply not use dynamic allocation for these instances: there's always
> >> one of each in SiFiveESoCState, so instead we just include them within
> >> the struct.
> >>
> >> Thanks to Peter for pointing out the bug and suggesting the fix!
> >
> > a.k.a. Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > Maybe the thanks can go below the '---' tag, so it doesn't stay in the
> > git history.
>
> Works for me.

With the updated Suggested-by line:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> >
> >>
> >> Fixes: 30efbf330a45 ("SiFive RISC-V GPIO Device")
> >> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Thanks!
>
> >
> >> ---
> >>  hw/riscv/sifive_e.c         | 12 +++++-------
> >>  include/hw/riscv/sifive_e.h |  2 ++
> >>  2 files changed, 7 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> >> index 80ac56fa7d5e..83375afcd1d6 100644
> >> --- a/hw/riscv/sifive_e.c
> >> +++ b/hw/riscv/sifive_e.c
> >> @@ -158,17 +158,15 @@ static void riscv_sifive_e_soc_realize(DeviceSta=
te *dev, Error **errp)
> >>
> >>      SiFiveESoCState *s =3D RISCV_E_SOC(dev);
> >>      MemoryRegion *sys_mem =3D get_system_memory();
> >> -    MemoryRegion *xip_mem =3D g_new(MemoryRegion, 1);
> >> -    MemoryRegion *mask_rom =3D g_new(MemoryRegion, 1);
> >>
> >>      object_property_set_bool(OBJECT(&s->cpus), true, "realized",
> >>                              &error_abort);
> >>
> >>      /* Mask ROM */
> >> -    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.e.mrom",
> >> +    memory_region_init_rom(&s->mask_rom, NULL, "riscv.sifive.e.mrom",
> >>          memmap[SIFIVE_E_MROM].size, &error_fatal);
> >>      memory_region_add_subregion(sys_mem,
> >> -        memmap[SIFIVE_E_MROM].base, mask_rom);
> >> +        memmap[SIFIVE_E_MROM].base, &s->mask_rom);
> >>
> >>      /* MMIO */
> >>      s->plic =3D sifive_plic_create(memmap[SIFIVE_E_PLIC].base,
> >> @@ -228,10 +226,10 @@ static void riscv_sifive_e_soc_realize(DeviceSta=
te *dev, Error **errp)
> >>          memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
> >>
> >>      /* Flash memory */
> >> -    memory_region_init_ram(xip_mem, NULL, "riscv.sifive.e.xip",
> >> +    memory_region_init_ram(&s->xip_mem, NULL, "riscv.sifive.e.xip",
> >>          memmap[SIFIVE_E_XIP].size, &error_fatal);
> >> -    memory_region_set_readonly(xip_mem, true);
> >> -    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base, x=
ip_mem);
> >> +    memory_region_set_readonly(&s->xip_mem, true);
> >> +    memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base, &=
s->xip_mem);
> >>  }
> >>
> >>  static void riscv_sifive_e_machine_init(MachineClass *mc)
> >> diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
> >> index 3b14eb74621f..d175b24cb209 100644
> >> --- a/include/hw/riscv/sifive_e.h
> >> +++ b/include/hw/riscv/sifive_e.h
> >> @@ -33,6 +33,8 @@ typedef struct SiFiveESoCState {
> >>      RISCVHartArrayState cpus;
> >>      DeviceState *plic;
> >>      SIFIVEGPIOState gpio;
> >> +    MemoryRegion xip_mem;
> >> +    MemoryRegion mask_rom;
> >>  } SiFiveESoCState;
> >>
> >>  typedef struct SiFiveEState {
> >>
>


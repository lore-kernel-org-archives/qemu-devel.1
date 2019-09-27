Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25425C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 04:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7290207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 04:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvRAytOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7290207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDhxN-0004S9-Sb
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 00:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iDhwB-0003qa-FT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 00:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iDhw7-0006ql-Ey
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 00:32:59 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44186)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iDhw7-0006nm-6E
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 00:32:55 -0400
Received: by mail-oi1-x242.google.com with SMTP id w6so4072806oie.11
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 21:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=gHlBjW3TovZUyf15Q44+Z+t7dXU5y+P2uAFLNymogfs=;
 b=kvRAytORRC/dufO/grq6T1vrYlAN5LYHjpWTsLgdCOWPG0E+xKniW/W8bzKWx22FgD
 dITxxJn34eJg9X82m0Y37PZZ4YN7U1NWoSeGZHicgWFx86k9ewNhvhXF/OwkLjLQwKTj
 fSawtz2MRXpcaz+L4NCVualR3LYdni9pqazkHnWC6ayKJLeQ/d8FY3LkcmbZcJ0z4uS/
 VlZh8btVr/bubkfToZBodEH8pfim9TFpEEuTC0G58yCZAS9NsH1VpbOWiiR5/JjNrCs1
 VSC+bVuWXo9FUU0dgyPj7Ynr7SY/VpN718xzhBVfeTVRUppV4OZqzItOL2HV+SMj+E4B
 setQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=gHlBjW3TovZUyf15Q44+Z+t7dXU5y+P2uAFLNymogfs=;
 b=mpUiaI+tLUr2JUOr6Ki0NqGkFH/EVJa7OlZgrdZhGaEZG6TO0kGKbTNnskdxHMRJzm
 EOyQYrLS796o62tQ0ITfVM/rs6ZqUBgOiKT3eZ2pVNgYYqQCWdQ9h5485x4ZqjUOUQO3
 uPlGKVBWzQgM8t8u/kQGbuoAEVb2nIwlHE9C9RmOr1ab2wSD47PJLhS+0FG9BsxIc8wD
 KUX3BK5skSub/uBErRAUUnvMNJPnVl5Ba4QLMpi6bA1v1j/tmo/Z/nOlCtGx1OEMWqY8
 Bo4X7knABgehSteXC8q9yd4WYyDi0qyt4MG1tvl6HEQuKNSLjs+czta96/tHc1IAMYoV
 ujSA==
X-Gm-Message-State: APjAAAUro8cNbt9V0OvQ9ClPyNn0wFInnwVpP3amKTAeXBYZ+aHOb5U8
 2wzaUvasA7rbehm/whOSMgBbVWgc+CQzp9rLfGw=
X-Google-Smtp-Source: APXvYqz22f35XqDMyPLJ4WwYwsLqvuePP20uAw0HHrv65PCI++fgSh6NqRnJ4OmqbSeTyT4WEsLcguGuiatRUiuSqAY=
X-Received: by 2002:aca:7291:: with SMTP id p139mr5489671oic.53.1569558773614; 
 Thu, 26 Sep 2019 21:32:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 26 Sep 2019 21:32:52
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 26 Sep 2019 21:32:52
 -0700 (PDT)
In-Reply-To: <8f976a4a-e56a-d1f7-def9-14dd66140f0c@redhat.com>
References: <1569415572-19635-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1569415572-19635-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <8f976a4a-e56a-d1f7-def9-14dd66140f0c@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 27 Sep 2019 06:32:52 +0200
Message-ID: <CAL1e-=gdKQvtCX5DXCzMGPum5XiOxr7j51bQM0K8vosjPa-TcQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] target/mips: Clean up helper.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000027ce4a0593816167"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, arikalo@wavecomp.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000027ce4a0593816167
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

25.09.2019. 17.53, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =D1=98=
=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 9/25/19 2:45 PM, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Mostly fix errors and warnings reported by 'checkpatch.pl -f'.
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >  target/mips/helper.c | 132
+++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 80 insertions(+), 52 deletions(-)
> >
> > diff --git a/target/mips/helper.c b/target/mips/helper.c
> > index a2b6459..3dd1aae 100644
> > --- a/target/mips/helper.c
> > +++ b/target/mips/helper.c
> > @@ -39,8 +39,8 @@ enum {
> >  #if !defined(CONFIG_USER_ONLY)
> >
> >  /* no MMU emulation */
> > -int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int *prot=
,
> > -                        target_ulong address, int rw, int access_type)
> > +int no_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
> > +                       target_ulong address, int rw, int access_type)
> >  {
> >      *physical =3D address;
> >      *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> > @@ -48,26 +48,28 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr
*physical, int *prot,
> >  }
> >
> >  /* fixed mapping MMU emulation */
> > -int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int
*prot,
> > -                           target_ulong address, int rw, int
access_type)
> > +int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int
*prot,
> > +                          target_ulong address, int rw, int
access_type)
> >  {
> >      if (address <=3D (int32_t)0x7FFFFFFFUL) {
> > -        if (!(env->CP0_Status & (1 << CP0St_ERL)))
> > +        if (!(env->CP0_Status & (1 << CP0St_ERL))) {
> >              *physical =3D address + 0x40000000UL;
> > -        else
> > +        } else {
> >              *physical =3D address;
> > -    } else if (address <=3D (int32_t)0xBFFFFFFFUL)
> > +        }
> > +    } else if (address <=3D (int32_t)0xBFFFFFFFUL) {
> >          *physical =3D address & 0x1FFFFFFF;
> > -    else
> > +    } else {
> >          *physical =3D address;
> > +    }
> >
> >      *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> >      return TLBRET_MATCH;
> >  }
> >
> >  /* MIPS32/MIPS64 R4000-style MMU emulation */
> > -int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *prot,
> > -                     target_ulong address, int rw, int access_type)
> > +int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *prot,
> > +                    target_ulong address, int rw, int access_type)
> >  {
> >      uint16_t ASID =3D env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask;
> >      int i;
> > @@ -99,8 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr
*physical, int *prot,
> >              if (rw !=3D MMU_DATA_STORE || (n ? tlb->D1 : tlb->D0)) {
> >                  *physical =3D tlb->PFN[n] | (address & (mask >> 1));
> >                  *prot =3D PAGE_READ;
> > -                if (n ? tlb->D1 : tlb->D0)
> > +                if (n ? tlb->D1 : tlb->D0) {
> >                      *prot |=3D PAGE_WRITE;
> > +                }
> >                  if (!(n ? tlb->XI1 : tlb->XI0)) {
> >                      *prot |=3D PAGE_EXEC;
> >                  }
> > @@ -130,8 +133,11 @@ static int is_seg_am_mapped(unsigned int am, bool
eu, int mmu_idx)
> >      int32_t adetlb_mask;
> >
> >      switch (mmu_idx) {
> > -    case 3 /* ERL */:
> > -        /* If EU is set, always unmapped */
> > +    case 3:
> > +        /*
> > +         * ERL
> > +         * If EU is set, always unmapped
> > +         */
>
> My IDE show the current form nicer when the switch is folded.
>
> Are these comment really bothering checkpatch?
>

While being sintaxically correct, interleaving comments and code in a
single code line is considered a bad practice by many.

> >          if (eu) {
> >              return 0;
> >          }
> > @@ -204,9 +210,9 @@ static int get_segctl_physical_address(CPUMIPSState
*env, hwaddr *physical,
> >                                      pa & ~(hwaddr)segmask);
> >  }
> >
> > -static int get_physical_address (CPUMIPSState *env, hwaddr *physical,
> > -                                int *prot, target_ulong real_address,
> > -                                int rw, int access_type, int mmu_idx)
> > +static int get_physical_address(CPUMIPSState *env, hwaddr *physical,
> > +                               int *prot, target_ulong real_address,
> > +                               int rw, int access_type, int mmu_idx)
> >  {
> >      /* User mode can only access useg/xuseg */
> >  #if defined(TARGET_MIPS64)
> > @@ -252,14 +258,15 @@ static int get_physical_address (CPUMIPSState
*env, hwaddr *physical,
> >          } else {
> >              segctl =3D env->CP0_SegCtl2 >> 16;
> >          }
> > -        ret =3D get_segctl_physical_address(env, physical, prot,
real_address, rw,
> > -                                          access_type, mmu_idx, segctl=
,
> > -                                          0x3FFFFFFF);
> > +        ret =3D get_segctl_physical_address(env, physical, prot,
> > +                                          real_address, rw,
access_type,
> > +                                          mmu_idx, segctl, 0x3FFFFFFF)=
;
> >  #if defined(TARGET_MIPS64)
> >      } else if (address < 0x4000000000000000ULL) {
> >          /* xuseg */
> >          if (UX && address <=3D (0x3FFFFFFFFFFFFFFFULL & env->SEGMask))=
 {
> > -            ret =3D env->tlb->map_address(env, physical, prot,
real_address, rw, access_type);
> > +            ret =3D env->tlb->map_address(env, physical, prot,
> > +                                        real_address, rw, access_type)=
;
> >          } else {
> >              ret =3D TLBRET_BADADDR;
> >          }
> > @@ -267,7 +274,8 @@ static int get_physical_address (CPUMIPSState *env,
hwaddr *physical,
> >          /* xsseg */
> >          if ((supervisor_mode || kernel_mode) &&
> >              SX && address <=3D (0x7FFFFFFFFFFFFFFFULL & env->SEGMask))=
 {
> > -            ret =3D env->tlb->map_address(env, physical, prot,
real_address, rw, access_type);
> > +            ret =3D env->tlb->map_address(env, physical, prot,
> > +                                        real_address, rw, access_type)=
;
> >          } else {
> >              ret =3D TLBRET_BADADDR;
> >          }
> > @@ -307,7 +315,8 @@ static int get_physical_address (CPUMIPSState *env,
hwaddr *physical,
> >          /* xkseg */
> >          if (kernel_mode && KX &&
> >              address <=3D (0xFFFFFFFF7FFFFFFFULL & env->SEGMask)) {
> > -            ret =3D env->tlb->map_address(env, physical, prot,
real_address, rw, access_type);
> > +            ret =3D env->tlb->map_address(env, physical, prot,
> > +                                        real_address, rw, access_type)=
;
> >          } else {
> >              ret =3D TLBRET_BADADDR;
> >          }
> > @@ -328,8 +337,10 @@ static int get_physical_address (CPUMIPSState
*env, hwaddr *physical,
> >                                            access_type, mmu_idx,
> >                                            env->CP0_SegCtl0 >> 16,
0x1FFFFFFF);
> >      } else {
> > -        /* kseg3 */
> > -        /* XXX: debug segment is not emulated */
> > +        /*
> > +         * kseg3
> > +         * XXX: debug segment is not emulated
> > +         */
>
> Ditto.
>
> >          ret =3D get_segctl_physical_address(env, physical, prot,
real_address, rw,
> >                                            access_type, mmu_idx,
> >                                            env->CP0_SegCtl0,
0x1FFFFFFF);
> > @@ -515,9 +526,9 @@ static void raise_mmu_exception(CPUMIPSState *env,
target_ulong address,
> >  #if defined(TARGET_MIPS64)
> >      env->CP0_EntryHi &=3D env->SEGMask;
> >      env->CP0_XContext =3D
> > -        /* PTEBase */   (env->CP0_XContext & ((~0ULL) << (env->SEGBITS
- 7))) |
> > -        /* R */         (extract64(address, 62, 2) << (env->SEGBITS -
9)) |
> > -        /* BadVPN2 */   (extract64(address, 13, env->SEGBITS - 13) <<
4);
> > +        (env->CP0_XContext & ((~0ULL) << (env->SEGBITS - 7))) | /*
PTEBase */
> > +        (extract64(address, 62, 2) << (env->SEGBITS - 9)) |     /* R
     */
> > +        (extract64(address, 13, env->SEGBITS - 13) << 4);       /*
BadVPN2 */
> >  #endif
> >      cs->exception_index =3D exception;
> >      env->error_code =3D error_code;
> > @@ -945,7 +956,8 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address,
int size,
> >  }
> >
> >  #ifndef CONFIG_USER_ONLY
> > -hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong
address, int rw)
> > +hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulong
address,
> > +                                  int rw)
> >  {
> >      hwaddr physical;
> >      int prot;
> > @@ -1005,7 +1017,7 @@ static const char * const excp_names[EXCP_LAST +
1] =3D {
> >  };
> >  #endif
> >
> > -target_ulong exception_resume_pc (CPUMIPSState *env)
> > +target_ulong exception_resume_pc(CPUMIPSState *env)
> >  {
> >      target_ulong bad_pc;
> >      target_ulong isa_mode;
> > @@ -1013,8 +1025,10 @@ target_ulong exception_resume_pc (CPUMIPSState
*env)
> >      isa_mode =3D !!(env->hflags & MIPS_HFLAG_M16);
> >      bad_pc =3D env->active_tc.PC | isa_mode;
> >      if (env->hflags & MIPS_HFLAG_BMASK) {
> > -        /* If the exception was raised from a delay slot, come back to
> > -           the jump.  */
> > +        /*
> > +         * If the exception was raised from a delay slot, come back to
> > +         *  the jump.
> > +         */
> >          bad_pc -=3D (env->hflags & MIPS_HFLAG_B16 ? 2 : 4);
> >      }
> >
> > @@ -1022,14 +1036,14 @@ target_ulong exception_resume_pc (CPUMIPSState
*env)
> >  }
> >
> >  #if !defined(CONFIG_USER_ONLY)
> > -static void set_hflags_for_handler (CPUMIPSState *env)
> > +static void set_hflags_for_handler(CPUMIPSState *env)
> >  {
> >      /* Exception handlers are entered in 32-bit mode.  */
> >      env->hflags &=3D ~(MIPS_HFLAG_M16);
> >      /* ...except that microMIPS lets you choose.  */
> >      if (env->insn_flags & ASE_MICROMIPS) {
> > -        env->hflags |=3D (!!(env->CP0_Config3
> > -                           & (1 << CP0C3_ISA_ON_EXC))
> > +        env->hflags |=3D (!!(env->CP0_Config3 &
> > +                           (1 << CP0C3_ISA_ON_EXC))
> >                          << MIPS_HFLAG_M16_SHIFT);
> >      }
> >  }
> > @@ -1096,10 +1110,12 @@ void mips_cpu_do_interrupt(CPUState *cs)
> >      switch (cs->exception_index) {
> >      case EXCP_DSS:
> >          env->CP0_Debug |=3D 1 << CP0DB_DSS;
> > -        /* Debug single step cannot be raised inside a delay slot and
> > -           resume will always occur on the next instruction
> > -           (but we assume the pc has always been updated during
> > -           code translation). */
> > +        /*
> > +         * Debug single step cannot be raised inside a delay slot and
> > +         * resume will always occur on the next instruction
> > +         * (but we assume the pc has always been updated during
> > +         * code translation).
> > +         */
> >          env->CP0_DEPC =3D env->active_tc.PC | !!(env->hflags &
MIPS_HFLAG_M16);
> >          goto enter_debug_mode;
> >      case EXCP_DINT:
> > @@ -1111,7 +1127,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
> >      case EXCP_DBp:
> >          env->CP0_Debug |=3D 1 << CP0DB_DBp;
> >          /* Setup DExcCode - SDBBP instruction */
> > -        env->CP0_Debug =3D (env->CP0_Debug & ~(0x1fULL << CP0DB_DEC)) =
|
9 << CP0DB_DEC;
> > +        env->CP0_Debug =3D (env->CP0_Debug & ~(0x1fULL << CP0DB_DEC)) =
|
> > +                         (9 << CP0DB_DEC);
> >          goto set_DEPC;
> >      case EXCP_DDBS:
> >          env->CP0_Debug |=3D 1 << CP0DB_DDBS;
> > @@ -1132,8 +1149,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
> >          env->hflags |=3D MIPS_HFLAG_DM | MIPS_HFLAG_CP0;
> >          env->hflags &=3D ~(MIPS_HFLAG_KSU);
> >          /* EJTAG probe trap enable is not implemented... */
> > -        if (!(env->CP0_Status & (1 << CP0St_EXL)))
> > +        if (!(env->CP0_Status & (1 << CP0St_EXL))) {
> >              env->CP0_Cause &=3D ~(1U << CP0Ca_BD);
> > +        }
> >          env->active_tc.PC =3D env->exception_base + 0x480;
> >          set_hflags_for_handler(env);
> >          break;
> > @@ -1159,8 +1177,9 @@ void mips_cpu_do_interrupt(CPUState *cs)
> >          }
> >          env->hflags |=3D MIPS_HFLAG_CP0;
> >          env->hflags &=3D ~(MIPS_HFLAG_KSU);
> > -        if (!(env->CP0_Status & (1 << CP0St_EXL)))
> > +        if (!(env->CP0_Status & (1 << CP0St_EXL))) {
> >              env->CP0_Cause &=3D ~(1U << CP0Ca_BD);
> > +        }
> >          env->active_tc.PC =3D env->exception_base;
> >          set_hflags_for_handler(env);
> >          break;
> > @@ -1176,12 +1195,16 @@ void mips_cpu_do_interrupt(CPUState *cs)
> >                  uint32_t pending =3D (env->CP0_Cause & CP0Ca_IP_mask) =
>>
CP0Ca_IP;
> >
> >                  if (env->CP0_Config3 & (1 << CP0C3_VEIC)) {
> > -                    /* For VEIC mode, the external interrupt
controller feeds
> > -                     * the vector through the CP0Cause IP lines.  */
> > +                    /*
> > +                     * For VEIC mode, the external interrupt
controller feeds
> > +                     * the vector through the CP0Cause IP lines.
> > +                     */
> >                      vector =3D pending;
> >                  } else {
> > -                    /* Vectored Interrupts
> > -                     * Mask with Status.IM7-IM0 to get enabled
interrupts. */
> > +                    /*
> > +                     * Vectored Interrupts
> > +                     * Mask with Status.IM7-IM0 to get enabled
interrupts.
> > +                     */
> >                      pending &=3D (env->CP0_Status >> CP0St_IM) & 0xff;
> >                      /* Find the highest-priority interrupt. */
> >                      while (pending >>=3D 1) {
> > @@ -1354,7 +1377,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
> >
> >          env->active_tc.PC +=3D offset;
> >          set_hflags_for_handler(env);
> > -        env->CP0_Cause =3D (env->CP0_Cause & ~(0x1f << CP0Ca_EC)) |
(cause << CP0Ca_EC);
> > +        env->CP0_Cause =3D (env->CP0_Cause & ~(0x1f << CP0Ca_EC)) |
> > +                         (cause << CP0Ca_EC);
> >          break;
> >      default:
> >          abort();
> > @@ -1390,7 +1414,7 @@ bool mips_cpu_exec_interrupt(CPUState *cs, int
interrupt_request)
> >  }
> >
> >  #if !defined(CONFIG_USER_ONLY)
> > -void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_extra)
> > +void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extra)
> >  {
> >      CPUState *cs =3D env_cpu(env);
> >      r4k_tlb_t *tlb;
> > @@ -1400,16 +1424,20 @@ void r4k_invalidate_tlb (CPUMIPSState *env, int
idx, int use_extra)
> >      target_ulong mask;
> >
> >      tlb =3D &env->tlb->mmu.r4k.tlb[idx];
> > -    /* The qemu TLB is flushed when the ASID changes, so no need to
> > -       flush these entries again.  */
> > +    /*
> > +     * The qemu TLB is flushed when the ASID changes, so no need to
> > +     * flush these entries again.
> > +     */
> >      if (tlb->G =3D=3D 0 && tlb->ASID !=3D ASID) {
> >          return;
> >      }
> >
> >      if (use_extra && env->tlb->tlb_in_use < MIPS_TLB_MAX) {
> > -        /* For tlbwr, we can shadow the discarded entry into
> > -           a new (fake) TLB entry, as long as the guest can not
> > -           tell that it's there.  */
> > +        /*
> > +         * For tlbwr, we can shadow the discarded entry into
> > +         * a new (fake) TLB entry, as long as the guest can not
> > +         * tell that it's there.
> > +         */
> >          env->tlb->mmu.r4k.tlb[env->tlb->tlb_in_use] =3D *tlb;
> >          env->tlb->tlb_in_use++;
> >          return;
> >
>
> Except 2 comments, OK for the rest.
>
> Another patch that makes rebasing very painful :(
>

It would be fantastic if you apply the same reasoning to your patches, that
spread all over the code base, and happen so frequently, and certainly
create enormously more rebasing problems for multitude of people than this
patch or series does.

Yours, Aleksandar

>

--00000000000027ce4a0593816167
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
25.09.2019. 17.53, &quot;Philippe Mathieu-Daud=C3=A9&quot; &lt;<a href=3D"m=
ailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=
=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On 9/25/19 2:45 PM, Aleksandar Markovic wrote:<br>
&gt; &gt; From: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecom=
p.com">amarkovic@wavecomp.com</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; Mostly fix errors and warnings reported by &#39;<a href=3D"http:/=
/checkpatch.pl">checkpatch.pl</a> -f&#39;.<br>
&gt; &gt; <br>
&gt; &gt; Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovi=
c@wavecomp.com">amarkovic@wavecomp.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 target/mips/helper.c | 132 +++++++++++++++++++++++++++++++-=
-------------------<br>
&gt; &gt;=C2=A0 1 file changed, 80 insertions(+), 52 deletions(-)<br>
&gt; &gt; <br>
&gt; &gt; diff --git a/target/mips/helper.c b/target/mips/helper.c<br>
&gt; &gt; index a2b6459..3dd1aae 100644<br>
&gt; &gt; --- a/target/mips/helper.c<br>
&gt; &gt; +++ b/target/mips/helper.c<br>
&gt; &gt; @@ -39,8 +39,8 @@ enum {<br>
&gt; &gt;=C2=A0 #if !defined(CONFIG_USER_ONLY)<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 /* no MMU emulation */<br>
&gt; &gt; -int no_mmu_map_address (CPUMIPSState *env, hwaddr *physical, int=
 *prot,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 target_ulong address, int rw, int access_type)<br>
&gt; &gt; +int no_mmu_map_address(CPUMIPSState *env, hwaddr *physical, int =
*prot,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0target_ulong address, int rw, int access_type)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 *physical =3D address;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;=
<br>
&gt; &gt; @@ -48,26 +48,28 @@ int no_mmu_map_address (CPUMIPSState *env, hw=
addr *physical, int *prot,<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 /* fixed mapping MMU emulation */<br>
&gt; &gt; -int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *physical, =
int *prot,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_ulong address, int rw, int access_=
type)<br>
&gt; &gt; +int fixed_mmu_map_address(CPUMIPSState *env, hwaddr *physical, i=
nt *prot,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong address, int rw, int access_type)<=
br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (address &lt;=3D (int32_t)0x7FFFFFFFUL) {<=
br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env-&gt;CP0_Status &amp; (1 &l=
t;&lt; CP0St_ERL)))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env-&gt;CP0_Status &amp; (1 &l=
t;&lt; CP0St_ERL))) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D add=
ress + 0x40000000UL;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D add=
ress;<br>
&gt; &gt; -=C2=A0 =C2=A0 } else if (address &lt;=3D (int32_t)0xBFFFFFFFUL)<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 } else if (address &lt;=3D (int32_t)0xBFFFFFFFUL) =
{<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D address &amp; 0x1=
FFFFFFF;<br>
&gt; &gt; -=C2=A0 =C2=A0 else<br>
&gt; &gt; +=C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *physical =3D address;<br>
&gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 return TLBRET_MATCH;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 /* MIPS32/MIPS64 R4000-style MMU emulation */<br>
&gt; &gt; -int r4k_map_address (CPUMIPSState *env, hwaddr *physical, int *p=
rot,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0target_ulong address, int rw, int access_type)<br>
&gt; &gt; +int r4k_map_address(CPUMIPSState *env, hwaddr *physical, int *pr=
ot,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 target_ulong address, int rw, int access_type)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 uint16_t ASID =3D env-&gt;CP0_EntryHi &amp; e=
nv-&gt;CP0_EntryHi_ASID_mask;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; &gt; @@ -99,8 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr=
 *physical, int *prot,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rw !=3D MMU_D=
ATA_STORE || (n ? tlb-&gt;D1 : tlb-&gt;D0)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ph=
ysical =3D tlb-&gt;PFN[n] | (address &amp; (mask &gt;&gt; 1));<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *pr=
ot =3D PAGE_READ;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n ? =
tlb-&gt;D1 : tlb-&gt;D0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (n ? =
tlb-&gt;D1 : tlb-&gt;D0) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *prot |=3D PAGE_WRITE;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
(!(n ? tlb-&gt;XI1 : tlb-&gt;XI0)) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *prot |=3D PAGE_EXEC;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<b=
r>
&gt; &gt; @@ -130,8 +133,11 @@ static int is_seg_am_mapped(unsigned int am,=
 bool eu, int mmu_idx)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int32_t adetlb_mask;<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 switch (mmu_idx) {<br>
&gt; &gt; -=C2=A0 =C2=A0 case 3 /* ERL */:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If EU is set, always unmapped */<=
br>
&gt; &gt; +=C2=A0 =C2=A0 case 3:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ERL<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If EU is set, always unmappe=
d<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;<br>
&gt; My IDE show the current form nicer when the switch is folded.<br>
&gt;<br>
&gt; Are these comment really bothering checkpatch?<br>
&gt;</p>
<p dir=3D"ltr">While being sintaxically correct, interleaving comments and =
code in a single code line is considered a bad practice by many.</p>
<p dir=3D"ltr">&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (eu) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; @@ -204,9 +210,9 @@ static int get_segctl_physical_address(CPUMIP=
SState *env, hwaddr *physical,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pa &amp;=
 ~(hwaddr)segmask);<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; -static int get_physical_address (CPUMIPSState *env, hwaddr *phys=
ical,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *prot, target_ulong re=
al_address,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rw, int access_type, i=
nt mmu_idx)<br>
&gt; &gt; +static int get_physical_address(CPUMIPSState *env, hwaddr *physi=
cal,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *prot, target_ulong rea=
l_address,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int rw, int access_type, in=
t mmu_idx)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* User mode can only access useg/xuseg */<br=
>
&gt; &gt;=C2=A0 #if defined(TARGET_MIPS64)<br>
&gt; &gt; @@ -252,14 +258,15 @@ static int get_physical_address (CPUMIPSSta=
te *env, hwaddr *physical,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 segctl =3D env-&g=
t;CP0_SegCtl2 &gt;&gt; 16;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_segctl_physical_address(=
env, physical, prot, real_address, rw,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 access_type, mmu_idx, segctl,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 0x3FFFFFFF);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_segctl_physical_address(=
env, physical, prot,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 real_address, rw, access_type,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 mmu_idx, segctl, 0x3FFFFFFF);<br>
&gt; &gt;=C2=A0 #if defined(TARGET_MIPS64)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 } else if (address &lt; 0x4000000000000000ULL=
) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* xuseg */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (UX &amp;&amp; address &lt;=
=3D (0x3FFFFFFFFFFFFFFFULL &amp; env-&gt;SEGMask)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env-&gt;tlb-&g=
t;map_address(env, physical, prot, real_address, rw, access_type);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env-&gt;tlb-&g=
t;map_address(env, physical, prot,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 real_address, rw, access_type);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D TLBRET_BA=
DADDR;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; @@ -267,7 +274,8 @@ static int get_physical_address (CPUMIPSState=
 *env, hwaddr *physical,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* xsseg */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((supervisor_mode || kernel_=
mode) &amp;&amp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SX &amp;&amp; add=
ress &lt;=3D (0x7FFFFFFFFFFFFFFFULL &amp; env-&gt;SEGMask)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env-&gt;tlb-&g=
t;map_address(env, physical, prot, real_address, rw, access_type);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env-&gt;tlb-&g=
t;map_address(env, physical, prot,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 real_address, rw, access_type);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D TLBRET_BA=
DADDR;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; @@ -307,7 +315,8 @@ static int get_physical_address (CPUMIPSState=
 *env, hwaddr *physical,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* xkseg */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kernel_mode &amp;&amp; KX &=
amp;&amp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 address &lt;=3D (=
0xFFFFFFFF7FFFFFFFULL &amp; env-&gt;SEGMask)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env-&gt;tlb-&g=
t;map_address(env, physical, prot, real_address, rw, access_type);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D env-&gt;tlb-&g=
t;map_address(env, physical, prot,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 real_address, rw, access_type);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D TLBRET_BA=
DADDR;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; @@ -328,8 +337,10 @@ static int get_physical_address (CPUMIPSStat=
e *env, hwaddr *physical,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 access_type, mmu_idx,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 env-&gt;CP0_SegCtl0 &gt;&gt; 16, 0x1FFFFFFF);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* kseg3 */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* XXX: debug segment is not emulate=
d */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* kseg3<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* XXX: debug segment is not em=
ulated<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt;<br>
&gt; Ditto.<br>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D get_segctl_physical_add=
ress(env, physical, prot, real_address, rw,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 access_type, mmu_idx,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 env-&gt;CP0_SegCtl0, 0x1FFFFFFF);<br>
&gt; &gt; @@ -515,9 +526,9 @@ static void raise_mmu_exception(CPUMIPSState =
*env, target_ulong address,<br>
&gt; &gt;=C2=A0 #if defined(TARGET_MIPS64)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_EntryHi &amp;=3D env-&gt;SEGMask;=
<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_XContext =3D<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* PTEBase */=C2=A0 =C2=A0(env-&gt;C=
P0_XContext &amp; ((~0ULL) &lt;&lt; (env-&gt;SEGBITS - 7))) |<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* R */=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(extract64(address, 62, 2) &lt;&lt; (env-&gt;SEGBITS - 9)) |<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* BadVPN2 */=C2=A0 =C2=A0(extract64=
(address, 13, env-&gt;SEGBITS - 13) &lt;&lt; 4);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (env-&gt;CP0_XContext &amp; ((~0ULL)=
 &lt;&lt; (env-&gt;SEGBITS - 7))) | /* PTEBase */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (extract64(address, 62, 2) &lt;&lt; =
(env-&gt;SEGBITS - 9)) |=C2=A0 =C2=A0 =C2=A0/* R=C2=A0 =C2=A0 =C2=A0 =C2=A0=
*/<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (extract64(address, 13, env-&gt;SEGB=
ITS - 13) &lt;&lt; 4);=C2=A0 =C2=A0 =C2=A0 =C2=A0/* BadVPN2 */<br>
&gt; &gt;=C2=A0 #endif<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 cs-&gt;exception_index =3D exception;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 env-&gt;error_code =3D error_code;<br>
&gt; &gt; @@ -945,7 +956,8 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr ad=
dress, int size,<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 #ifndef CONFIG_USER_ONLY<br>
&gt; &gt; -hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulon=
g address, int rw)<br>
&gt; &gt; +hwaddr cpu_mips_translate_address(CPUMIPSState *env, target_ulon=
g address,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int rw)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 hwaddr physical;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 int prot;<br>
&gt; &gt; @@ -1005,7 +1017,7 @@ static const char * const excp_names[EXCP_L=
AST + 1] =3D {<br>
&gt; &gt;=C2=A0 };<br>
&gt; &gt;=C2=A0 #endif<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; -target_ulong exception_resume_pc (CPUMIPSState *env)<br>
&gt; &gt; +target_ulong exception_resume_pc(CPUMIPSState *env)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong bad_pc;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong isa_mode;<br>
&gt; &gt; @@ -1013,8 +1025,10 @@ target_ulong exception_resume_pc (CPUMIPSS=
tate *env)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 isa_mode =3D !!(env-&gt;hflags &amp; MIPS_HFL=
AG_M16);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 bad_pc =3D env-&gt;active_tc.PC | isa_mode;<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (env-&gt;hflags &amp; MIPS_HFLAG_BMASK) {<=
br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If the exception was raised from =
a delay slot, come back to<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0the jump.=C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If the exception was raised =
from a delay slot, come back to<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*=C2=A0 the jump.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bad_pc -=3D (env-&gt;hflags &am=
p; MIPS_HFLAG_B16 ? 2 : 4);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt; @@ -1022,14 +1036,14 @@ target_ulong exception_resume_pc (CPUMIPS=
State *env)<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 #if !defined(CONFIG_USER_ONLY)<br>
&gt; &gt; -static void set_hflags_for_handler (CPUMIPSState *env)<br>
&gt; &gt; +static void set_hflags_for_handler(CPUMIPSState *env)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* Exception handlers are entered in 32-bit m=
ode.=C2=A0 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 env-&gt;hflags &amp;=3D ~(MIPS_HFLAG_M16);<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 /* ...except that microMIPS lets you choose.=
=C2=A0 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (env-&gt;insn_flags &amp; ASE_MICROMIPS) {=
<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;hflags |=3D (!!(env-&gt;CP0_=
Config3<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp; (1 &lt;&lt; CP0C3_ISA_ON_EXC))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;hflags |=3D (!!(env-&gt;CP0_=
Config3 &amp;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; CP0C3_ISA_ON_EXC))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &lt;&lt; MIPS_HFLAG_M16_SHIFT);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt; @@ -1096,10 +1110,12 @@ void mips_cpu_do_interrupt(CPUState *cs)<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 switch (cs-&gt;exception_index) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 case EXCP_DSS:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_Debug |=3D 1 &lt;&l=
t; CP0DB_DSS;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Debug single step cannot be raise=
d inside a delay slot and<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resume will always occu=
r on the next instruction<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(but we assume the pc h=
as always been updated during<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0code translation). */<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Debug single step cannot be =
raised inside a delay slot and<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* resume will always occur on =
the next instruction<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* (but we assume the pc has al=
ways been updated during<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* code translation).<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_DEPC =3D env-&gt;ac=
tive_tc.PC | !!(env-&gt;hflags &amp; MIPS_HFLAG_M16);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto enter_debug_mode;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 case EXCP_DINT:<br>
&gt; &gt; @@ -1111,7 +1127,8 @@ void mips_cpu_do_interrupt(CPUState *cs)<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 case EXCP_DBp:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_Debug |=3D 1 &lt;&l=
t; CP0DB_DBp;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Setup DExcCode - SDBBP instr=
uction */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_Debug =3D (env-&gt;CP0_D=
ebug &amp; ~(0x1fULL &lt;&lt; CP0DB_DEC)) | 9 &lt;&lt; CP0DB_DEC;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_Debug =3D (env-&gt;CP0_D=
ebug &amp; ~(0x1fULL &lt;&lt; CP0DB_DEC)) |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(9 &lt;&lt; CP0DB_DEC);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto set_DEPC;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 case EXCP_DDBS:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_Debug |=3D 1 &lt;&l=
t; CP0DB_DDBS;<br>
&gt; &gt; @@ -1132,8 +1149,9 @@ void mips_cpu_do_interrupt(CPUState *cs)<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;hflags |=3D MIPS_HFLAG_=
DM | MIPS_HFLAG_CP0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;hflags &amp;=3D ~(MIPS_=
HFLAG_KSU);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* EJTAG probe trap enable is n=
ot implemented... */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env-&gt;CP0_Status &amp; (1 &l=
t;&lt; CP0St_EXL)))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env-&gt;CP0_Status &amp; (1 &l=
t;&lt; CP0St_EXL))) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_Cause=
 &amp;=3D ~(1U &lt;&lt; CP0Ca_BD);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;active_tc.PC =3D env-&g=
t;exception_base + 0x480;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_hflags_for_handler(env);<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; @@ -1159,8 +1177,9 @@ void mips_cpu_do_interrupt(CPUState *cs)<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;hflags |=3D MIPS_HFLAG_=
CP0;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;hflags &amp;=3D ~(MIPS_=
HFLAG_KSU);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env-&gt;CP0_Status &amp; (1 &l=
t;&lt; CP0St_EXL)))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(env-&gt;CP0_Status &amp; (1 &l=
t;&lt; CP0St_EXL))) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_Cause=
 &amp;=3D ~(1U &lt;&lt; CP0Ca_BD);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;active_tc.PC =3D env-&g=
t;exception_base;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_hflags_for_handler(env);<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; @@ -1176,12 +1195,16 @@ void mips_cpu_do_interrupt(CPUState *cs)<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uin=
t32_t pending =3D (env-&gt;CP0_Cause &amp; CP0Ca_IP_mask) &gt;&gt; CP0Ca_IP=
;<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if =
(env-&gt;CP0_Config3 &amp; (1 &lt;&lt; CP0C3_VEIC)) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* For VEIC mode, the external interrupt controller feeds<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0* the vector through the CP0Cause IP lines.=C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0* For VEIC mode, the external interrupt controller feeds<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0* the vector through the CP0Cause IP lines.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*/<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 vector =3D pending;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } e=
lse {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Vectored Interrupts<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0* Mask with Status.IM7-IM0 to get enabled interrupts. */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0* Vectored Interrupts<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0* Mask with Status.IM7-IM0 to get enabled interrupts.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*/<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pending &amp;=3D (env-&gt;CP0_Status &gt;&gt; CP0St_IM) &amp; 0x=
ff;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* Find the highest-priority interrupt. */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 while (pending &gt;&gt;=3D 1) {<br>
&gt; &gt; @@ -1354,7 +1377,8 @@ void mips_cpu_do_interrupt(CPUState *cs)<br=
>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;active_tc.PC +=3D offse=
t;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_hflags_for_handler(env);<br=
>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_Cause =3D (env-&gt;CP0_C=
ause &amp; ~(0x1f &lt;&lt; CP0Ca_EC)) | (cause &lt;&lt; CP0Ca_EC);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;CP0_Cause =3D (env-&gt;CP0_C=
ause &amp; ~(0x1f &lt;&lt; CP0Ca_EC)) |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0(cause &lt;&lt; CP0Ca_EC);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
&gt; &gt; @@ -1390,7 +1414,7 @@ bool mips_cpu_exec_interrupt(CPUState *cs, =
int interrupt_request)<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 #if !defined(CONFIG_USER_ONLY)<br>
&gt; &gt; -void r4k_invalidate_tlb (CPUMIPSState *env, int idx, int use_ext=
ra)<br>
&gt; &gt; +void r4k_invalidate_tlb(CPUMIPSState *env, int idx, int use_extr=
a)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 CPUState *cs =3D env_cpu(env);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 r4k_tlb_t *tlb;<br>
&gt; &gt; @@ -1400,16 +1424,20 @@ void r4k_invalidate_tlb (CPUMIPSState *en=
v, int idx, int use_extra)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 target_ulong mask;<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 tlb =3D &amp;env-&gt;tlb-&gt;mmu.r4k.tlb[idx]=
;<br>
&gt; &gt; -=C2=A0 =C2=A0 /* The qemu TLB is flushed when the ASID changes, =
so no need to<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0flush these entries again.=C2=A0 */<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* The qemu TLB is flushed when the ASID chan=
ges, so no need to<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* flush these entries again.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (tlb-&gt;G =3D=3D 0 &amp;&amp; tlb-&gt;ASI=
D !=3D ASID) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt;=C2=A0 <br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (use_extra &amp;&amp; env-&gt;tlb-&gt;tlb_=
in_use &lt; MIPS_TLB_MAX) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* For tlbwr, we can shadow the disc=
arded entry into<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a new (fake) TLB entry,=
 as long as the guest can not<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tell that it&#39;s ther=
e.=C2=A0 */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* For tlbwr, we can shadow the=
 discarded entry into<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* a new (fake) TLB entry, as l=
ong as the guest can not<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* tell that it&#39;s there.<br=
>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;tlb-&gt;mmu.r4k.tlb[env=
-&gt;tlb-&gt;tlb_in_use] =3D *tlb;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;tlb-&gt;tlb_in_use++;<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; <br>
&gt;<br>
&gt; Except 2 comments, OK for the rest.<br>
&gt;<br>
&gt; Another patch that makes rebasing very painful :(<br>
&gt;</p>
<p dir=3D"ltr">It would be fantastic if you apply the same reasoning to you=
r patches, that spread all over the code base, and happen so frequently, an=
d certainly create enormously more rebasing problems for multitude of peopl=
e than this patch or series does.</p>
<p dir=3D"ltr">Yours, Aleksandar<br><br></p>
<p dir=3D"ltr">&gt;<br>
</p>

--00000000000027ce4a0593816167--


Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543CCC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E33520775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 09:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZjt1Aee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E33520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTjLQ-0002tc-4V
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 05:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jTjKN-0001sD-4b
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <chenhuacai@gmail.com>) id 1jTjId-0006YW-JH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:48:26 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:33555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenhuacai@gmail.com>)
 id 1jTjId-0006YG-5x
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 05:46:39 -0400
Received: by mail-il1-x141.google.com with SMTP id q10so1842233ile.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 02:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=568Exfl5/FR9TmIJa2L9iZymCH6Bn8adiNX/MQRcNwU=;
 b=kZjt1Aee0g3hSfXcNlwGSfkc70arzCQyCR31E0AI8hgmidQeUA9SvEQXPXLWnXPJyi
 6r9h9SX5u4hKDlG0vvEBm/WvM/8bnLTuyq0ljGrKovwmlAMT8lroN116HvlLV6gCC8jk
 vnwf1O2DegmvCM3dslrBhnnrFVy4cFfD8F3zDuAGgil084/5shnWeT+HIWPsQQtEmriM
 hJOE6gR2ojNJ0VIVQbK9K3yh/Ny2Y8oztXjRo9J7A1gIK3eMjfbuW+KJOPnhyKToOTsy
 COk5ZVKrI7A/PIIkxxPF9KDyA8Dw8rh/qdGMLz/WgABB172jLqmVdcG2qzUQ5bj5nY+k
 tA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=568Exfl5/FR9TmIJa2L9iZymCH6Bn8adiNX/MQRcNwU=;
 b=uQvwFDK3d3zUTxyew1ND8cy42nl8hWoP4IPMhFhcO1YOhzT2qIOPnjFh+XPHA4f5Sp
 qIO7m3n+r6wTXT2Y7YpeKEXmoL/G5LtqqUIEiA/z+9mt4b0o2qucAAjVF6e8cc0rHYGe
 zH6oNw7QtNIDd311kdFXGGaQjEWlALcQtOhSX2bU2jiQweyQ1v0+HyEH1gQ6QZGfbK2g
 gQahqLBOT+mZtu40TPtJkwm1M8dNMVpf+HvTRPAIQrw2XWFojymUJLjbxCakkGoNbp6b
 S0IVOG+5SDuEgDAw9ilMDUpYy4GogSKUZg3iJLqWxDzmpZqJvNMTwXzLVKCnMF6HmU0N
 YCZw==
X-Gm-Message-State: AGi0PuYICVxKLWmhcZx7RTSlG+9qk4UhSukxBqPhSNJuu+ZMyqKCp0fP
 eCPhZEuSjE63bZATFapahRCqp1M/DWf/d3OJJnI=
X-Google-Smtp-Source: APiQypI9eXlK8voOt+t6P5U9u3tyfFfKXpGyu9jWBs5tJLv0m0vprf+u1oRiEkDQKvM0TlEOOGHwfax4bVpEfGdSn6Q=
X-Received: by 2002:a92:c52a:: with SMTP id m10mr30516172ili.208.1588153597341; 
 Wed, 29 Apr 2020 02:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <1587979995-17717-1-git-send-email-chenhc@lemote.com>
 <1587979995-17717-4-git-send-email-chenhc@lemote.com>
 <c1a3aec6-dc45-3484-3a70-c06449bee609@amsat.org>
 <CABDp7Vq-YX0LWU3iM=oygpcKzoS8cmXG6mvTQ5Gm_PbQsQMAgw@mail.gmail.com>
 <CAHiYmc6zFjBtgXRv=8+dqnbDtZqKqiwSDwEi0wKqJmJnys_y0g@mail.gmail.com>
 <CAAhV-H6NFV7hbaOp8BwPck3FWm5ZHBpuoA9FDmN6tby5LcoTeg@mail.gmail.com>
 <a791f90b-a2a5-6665-59b5-212f98c7afc8@amsat.org>
 <CAAhV-H7NS_KCTuYQYvZeseNEZh56FBFz97kEj4KK-NsBDMJotQ@mail.gmail.com>
 <a1b333c6-e9a0-aabc-9ec2-b9bcb2007211@amsat.org>
 <CAAhV-H5_0Nn-omF+_+6T1mbtnFC-3VHTOgvAPfbc44Fnv0px_Q@mail.gmail.com>
 <c133fe4a-03a9-c3c5-540b-31fd0283d62d@amsat.org>
In-Reply-To: <c133fe4a-03a9-c3c5-540b-31fd0283d62d@amsat.org>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Wed, 29 Apr 2020 17:54:06 +0800
Message-ID: <CAAhV-H5fi-A9_zWL+HOJP2Np4JBi_MevSp5OTUDWuKXxKc381g@mail.gmail.com>
Subject: Re: [PATCH for-5.1 4/7] target/mips: Add Loongson-3 CPU definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=chenhuacai@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: chen huacai <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-level <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Philippe,

On Wed, Apr 29, 2020 at 5:30 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On 4/29/20 11:25 AM, Huacai Chen wrote:
> > Hi, Philippe,
> >
> > I think that this CPU definition is for Guest, not for Host (Maybe I'm =
wrong?).
>
> OK, it was not obvious to me (I haven't received the cover letter of
> this series).
> The code you modified is used by both host emulation and guest
> virtualization.
I'm very sorry that I hadn't send a cover letter...
Now I preparing the V2 series and I think put the cover letter of V2
here could make life easier...
----
Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
Loongson-3A R4 is the newest and its ISA is almost the superset of all
others. To reduce complexity, in QEMU we just define two CPU types:

1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
   suitable for TCG because Loongson-3A R1 has fewest ASE.
2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
   suitable for KVM because Loongson-3A R4 has the VZ ASE.

Loongson-3 lacks English documents. I've tried to translated them with
translate.google.com, and the machine translated documents (together
with their original Chinese versions) are available here.

......

We are preparing to add QEMU's Loongson-3 support. MIPS VZ extension is
fully supported in Loongson-3A R4+, so we at first add QEMU/KVM support
in this series. And the next series will add QEMU/TCG support (it will
emulate Loongson-3A R1).

We already have a full functional Linux kernel (based on Linux-5.4.x LTS
but not upstream yet) here:

https://github.com/chenhuacai/linux

How to use QEMU/Loongson-3?
1, Download kernel source from the above URL;
2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
3, Boot the a Loongson-3A4000 host with this kernel;
4, Build QEMU-5.0.0 with this patchset;
5, modprobe kvm;
6, Use QEMU with TCG (available in future):
       qemu-system-mips64el -M loongson3,accel=3Dtcg -cpu
Loongson-3A1000 -kernel <path_to_kernel> -append ...
   Use QEMU with KVM (available at present):
       qemu-system-mips64el -M loongson3,accel=3Dkvm -cpu
Loongson-3A4000 -kernel <path_to_kernel> -append ...

   The "-cpu" parameter can be omitted here and QEMU will use the
correct type for TCG/KVM automatically.
----
>
> If you want to only add a guest cpu type, you should name it
> "Loongson-3A virtualized" and can restrict with:
>
>    if (kvm_enabled()) {
>      add_guest_cpu();
>    }
>
> But cleaner is to add the host cpu regardless, and in cpu_state_reset()
> restrict when virtualized:
>
>    if (kvm_enabled()) {
>      /* disable host features on guest */
>      env->CP0_Config3 &=3D ~CP0C3_VZ;
>      ...
>    }
>
> >
> > On Wed, Apr 29, 2020 at 4:58 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote:
> >>
> >> On 4/29/20 10:27 AM, Huacai Chen wrote:
> >>> Hi, Philippe,
> >>>
> >>> The major differences of R3 and R4 are:
> >>> 1, R4 has complete MIPS VZ ASE (while R3 is incomplete), so very
> >>> usable for KVM host;
> >>
> >> So you need to set CP0C3_VZ.
> > If the definition is for Guest, I think CP0C3_VZ should not be set in
> > CP0_Config3, because only the Host can see VZ ASE.
> >
> >>
> >>> 2, R4 has MSA ASE while R3 hasn't;
> >>
> >> So you need to set CP0C5_MSAEn.
> > I have already set CP0C5_MSAEn CP0_Config5_rw_bitmask, but I don't
> > think it should be set in CP0_Config5 because MSA is disabled by
> > default.
> >
> >>
> >>> 3, R4 has cpucfg, rdcsr and wrcsr instructions (similar to cpuid,
> >>> rdmsr and wrmsr in X86).
> >>
> >> OK, these are not implemented.
>
> I was looking at TCG emulation, now I understand why you don't mind
> about them there.
Assume that you have read my cover letter now. So TCG only need to
consider Loongson-3A1000 and KVM only need to consider Loongson-3A4000
(in V2 I will define two types of CPU).

>
> >>
> >> [...]
> >>
> >>>>>>>>> diff --git a/target/mips/translate_init.inc.c b/target/mips/tra=
nslate_init.inc.c
> >>>>>>>>> index 6d145a9..a32412d 100644
> >>>>>>>>> --- a/target/mips/translate_init.inc.c
> >>>>>>>>> +++ b/target/mips/translate_init.inc.c
> >>>>>>>>> @@ -802,6 +802,57 @@ const mips_def_t mips_defs[] =3D
> >>>>>>>>>             .mmu_type =3D MMU_TYPE_R4000,
> >>>>>>>>>         },
> >>>>>>>>>         {
> >>>>>>>>> +        .name =3D "Loongson-3A",
> >>>>>>>>> +        .CP0_PRid =3D 0x14C000,
> >>>>>>>>> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache l=
ine size.  */
> >>>>>>>>> +        .CP0_Config0 =3D MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0=
x2 << CP0C0_AT) |
> >>>>>>>>> +                       (MMU_TYPE_R4000 << CP0C0_MT),
> >>>>>>>>> +        .CP0_Config1 =3D MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 =
<< CP0C1_MMU) |
> >>>>>>>>> +                       (2 << CP0C1_IS) | (4 << CP0C1_IL) | (3 =
<< CP0C1_IA) |
> >>>>>>>>> +                       (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 =
<< CP0C1_DA) |
> >>>>>>>>> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 =
<< CP0C1_EP),
> >>>>>>>>> +        .CP0_Config2 =3D MIPS_CONFIG2,
> >>>>>>>>> +        .CP0_Config3 =3D MIPS_CONFIG3 | (1U << CP0C3_M) | (1 <=
< CP0C3_MSAP) |
> >>>>>>>>> +                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 =
<< CP0C3_ULRI) |
> >>>>>>>>> +                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (=
1 << CP0C3_VInt),
> >>>>>>>>> +        .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (2 <=
< CP0C4_IE) |
> >>>>>>>>> +                       (1 << CP0C4_AE) | (0x1c << CP0C4_KScrEx=
ist),
> >>>>>>>>> +        .CP0_Config4_rw_bitmask =3D 0,
> >>>>>>>>> +        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_NFExists) =
| (1 << 18),
> >>>>>>>>> +        .CP0_Config5_rw_bitmask =3D (1 << CP0C5_K) | (1 << CP0=
C5_CV) |
> >>>>>>>>> +                                  (1 << CP0C5_MSAEn) | (1 << C=
P0C5_UFE) |
> >>>>>>>>> +                                  (1 << CP0C5_FRE) | (1 << CP0=
C5_SBRI),
> >>>>>>>>> +        .CP0_Config6 =3D (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLR=
U) | (1 << CP0C6_SFBEN) |
> >>>>>>>>> +                       (1 << CP0C6_FLTINT) | (1 << CP0C6_INSTP=
REF) | (1 << CP0C6_DATAPREF),
> >>>>>>>>> +        .CP0_Config6_rw_bitmask =3D (1 << CP0C6_BPPASS) | (0x3=
f << CP0C6_KPOS) |
> >>>>>>>>> +                                  (1 << CP0C6_KE) | (1 << CP0C=
6_VTLBONLY) | (1 << CP0C6_LASX) |
> >>>>>>>>> +                                  (1 << CP0C6_SSEN) | (1 << CP=
0C6_DISDRTIME) |
> >>>>>>>>> +                                  (1 << CP0C6_PIXNUEN) | (1 <<=
 CP0C6_SCRAND) |
> >>>>>>>>> +                                  (1 << CP0C6_LLEXCEN) | (1 <<=
 CP0C6_DISVC) |
> >>>>>>>>> +                                  (1 << CP0C6_VCLRU) | (1 << C=
P0C6_DCLRU) |
> >>>>>>>>> +                                  (1 << CP0C6_PIXUEN) | (1 << =
CP0C6_DISBLKLYEN) |
> >>>>>>>>> +                                  (1 << CP0C6_UMEMUALEN) | (1 =
<< CP0C6_SFBEN) |
> >>>>>>>>> +                                  (1 << CP0C6_FLTINT) | (1 << =
CP0C6_VLTINT) |
> >>>>>>>>> +                                  (1 << CP0C6_DISBTB) | (3 << =
CP0C6_STPREFCTL) |
> >>>>>>>>> +                                  (1 << CP0C6_INSTPREF) | (1 <=
< CP0C6_DATAPREF),
> >>>>>>>>> +        .CP0_Config7 =3D 0,
> >>>>>>>>> +        .CP0_Config7_rw_bitmask =3D (1 << CP0C7_NAPCGEN) | (1 =
<< CP0C7_UNIMUEN) | \
> >>>>>>>>> +                                  (1 << CP0C7_VFPUCGEN),
> >>>>>>>>> +        .CP0_LLAddr_rw_bitmask =3D 1,
> >>>>>>>>> +        .SYNCI_Step =3D 16,
> >>>>>>>>> +        .CCRes =3D 2,
> >>>>>>>>> +        .CP0_Status_rw_bitmask =3D 0x7DDBFFFF,
> >>>>>>>>> +        .CP0_PageGrain_rw_bitmask =3D (1U << CP0PG_RIE) | (1 <=
< CP0PG_XIE) |
> >>>>>>>>> +                    (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
> >>>>>>>>> +        .CP1_fcr0 =3D (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) |=
 (0x1 << FCR0_F64),
> >>>>>>>>> +        .CP1_fcr31 =3D 0,
> >>>>>>>>> +        .CP1_fcr31_rw_bitmask =3D 0xFF83FFFF,
> >>>>>>>>> +        .SEGBITS =3D 48,
> >>>>>>>>> +        .PABITS =3D 48,
> >>>>>>>>> +        .insn_flags =3D CPU_LOONGSON3A,
> >>>>>>>>> +        .mmu_type =3D MMU_TYPE_R4000,
> >>>>>>>>> +    },
> >>>>>>>>> +    {
> >>>>>>>>>             /* A generic CPU providing MIPS64 DSP R2 ASE featur=
es.
> >>>>>>>>>                FIXME: Eventually this should be replaced by a r=
eal CPU model. */
> >>>>>>>>>             .name =3D "mips64dspr2",
> >>>>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> --
> >>>>>>> Huacai Chen
> >>>>>
> >>>
> >


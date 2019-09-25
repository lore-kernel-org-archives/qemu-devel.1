Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1804EC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 00:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1C420872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 00:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5EBFYHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1C420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCv9p-0000Eb-Rh
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 20:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iCv8e-0007Ts-J3
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iCv8c-0004DB-MK
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:26:36 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:37675)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iCv8c-0004Ct-Cx; Tue, 24 Sep 2019 20:26:34 -0400
Received: by mail-lj1-x241.google.com with SMTP id l21so3744893lje.4;
 Tue, 24 Sep 2019 17:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HK1OznEzGlTq61LpVAwuAqDz3yv7Y0o+u0T1oyc3oVU=;
 b=g5EBFYHqIsty2tPByQg3LOnZv6i0SL1ZoOVoWQY3yQzutx1faCi8bMk8KgNqvUgddx
 6hGu1dN74VfiRbmH22OFLQ/z4TlCbyH75h7bAW9RnkFN3RSkEknSD/c23qobbzaChRV2
 ZQcQnwJxWd4EfLFAeiRv5CmKf47f9kOaGORFOr8DmaAbjunOyvq4oK/R2GDbyBONVk51
 9iQDb2Veo0/7gM7vRZRAjud94hTCQErx0jl57c7TvVd4/Cvgd1Sv3qK/E/5SG8vpoMU0
 ZDNMhzA+mO0PTShmBjrKBGzyI2yjkPNtoWKxs70KhJ0zi+Pg7TcLljLoTzdtLo7Pc/8b
 QEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HK1OznEzGlTq61LpVAwuAqDz3yv7Y0o+u0T1oyc3oVU=;
 b=eGaelDrFkn/x0EazMgX/PbDG3CVq6clUcZE8fxKg3J+0irnVwv+mtSO7UI7ktdf2py
 OjUy3fwuHBJNwm2BzOk+5XFk0fcQXRMbYfS3efiN0DoA+SrsKyjfYphnuml2OsxkwHwp
 FH3+1IZ5AD4G6HSilLop1l+wAPgHD2NhVSU3lZJvRlAQpdKx3/5P65UJbA3bakZycGGg
 vcHEMDDwf+R7ITW5oAvAQWVYbahuLy727ObQX/xhhDao6C7qJ1Qh/B1VIt2IAPiUkp11
 f31V0rTs2BAHGF6+jcbq4FVGiua4nWm+6/XbPYNx3nPts6slHaGnD1Ll9HIWlzeBo4Qy
 2XvA==
X-Gm-Message-State: APjAAAV9w11U0ZWhxLHDnOC8H2e98nQNrt4IhrhStOyKP0J7XUuyTixQ
 yrdVOOmrsRTcbZYSra58ncC7L92H129IRPPqzXM=
X-Google-Smtp-Source: APXvYqwAmkq9IBanv/e7bTBddT0Lgx/AMPpwrQUqvIWeAB6vjHqsf4kUfd6o1OWxoy7iIlAOScCQJ+ddETNu6HypRRA=
X-Received: by 2002:a05:651c:1132:: with SMTP id
 e18mr3889334ljo.33.1569371192878; 
 Tue, 24 Sep 2019 17:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <1569311902-12173-1-git-send-email-guoren@kernel.org>
 <CAKmqyKMzpTKBT+urX_7qFASqcAd4kkfJmf6LUk-0V=0LOuHLxw@mail.gmail.com>
 <8E7A78A5-5E6F-49A2-89BC-85D2506229C6@c-sky.com>
In-Reply-To: <8E7A78A5-5E6F-49A2-89BC-85D2506229C6@c-sky.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 24 Sep 2019 17:21:50 -0700
Message-ID: <CAKmqyKPAnb1bb+v=+v_jHmA58bRjmUqO9XcZbLyxsUX1udtXBQ@mail.gmail.com>
Subject: Re: [PATCH V2] target/riscv: Bugfix reserved bits in PTE for RV64
To: Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, guoren@kernel.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 5:13 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
>
> > =E5=9C=A8 2019=E5=B9=B49=E6=9C=8825=E6=97=A5=EF=BC=8C=E4=B8=8A=E5=8D=88=
7:33=EF=BC=8CAlistair Francis <alistair23@gmail.com> =E5=86=99=E9=81=93=EF=
=BC=9A
> >
> > On Tue, Sep 24, 2019 at 12:58 AM <guoren@kernel.org> wrote:
> >>
> >> From: Guo Ren <ren_guo@c-sky.com>
> >>
> >> Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so =
we
> >> need to ignore them. They can not be a part of ppn.
> >>
> >> 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architectu=
re
> >>   4.4 Sv39: Page-Based 39-bit Virtual-Memory System
> >>   4.5 Sv48: Page-Based 48-bit Virtual-Memory System
> >
> > Thanks for the patch!
> >
> > The spec says "must be zeroed by software for forward compatibility"
> > so I don't think it's correct for QEMU to zero out the bits.
> QEMU don=E2=80=99t zero out the bits, QEMU just ignore the bits for ppn.

Yes, from reading the spec that seems to be the correct behaviour.

>
> >
> > Does this fix a bug you are seeing?
> Yes, because we try to reuse these bits as attributes.

That isn't really a bug then, the spec says not to do that.

>
> >
> >>
> >> Changelog V2:
> >> - Bugfix pte destroyed cause boot fail
> >> - Change to AND with a mask instead of shifting both directions
> >
> > The changelog shouldn't be in the commit, it should be kept under the
> > line line below.
> I just prefer to save them in commit.

Fair, but in QEMU we don't commit the change log in the commit.

>
> >
> >>
> >> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> >> Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> >> ---
> >
> > The change log should go here.
> OK, but git am we=E2=80=99ll lose them.
>
> >
> >> target/riscv/cpu_bits.h   | 3 +++
> >> target/riscv/cpu_helper.c | 3 ++-
> >> 2 files changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> >> index e998348..ae8aa0f 100644
> >> --- a/target/riscv/cpu_bits.h
> >> +++ b/target/riscv/cpu_bits.h
> >> @@ -470,6 +470,9 @@
> >> #define PTE_D               0x080 /* Dirty */
> >> #define PTE_SOFT            0x300 /* Reserved for Software */
> >>
> >> +/* Reserved highest 10 bits in PTE */
> >> +#define PTE_RESERVED        ((target_ulong)0x3ff << 54)
> >
> > I think it's just easier to define this as 0xFFC0000000000000ULL and
> > remove the cast.
> OK follow your rule, but I still prefer prior.
>
> >
> >> +
> >> /* Page table PPN shift amount */
> >> #define PTE_PPN_SHIFT       10
> >>
> >> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> >> index 87dd6a6..7a540cc 100644
> >> --- a/target/riscv/cpu_helper.c
> >> +++ b/target/riscv/cpu_helper.c
> >> @@ -258,10 +258,11 @@ restart:
> >>         }
> >> #if defined(TARGET_RISCV32)
> >>         target_ulong pte =3D ldl_phys(cs->as, pte_addr);
> >> +        hwaddr ppn =3D pte >> PTE_PPN_SHIFT;
> >> #elif defined(TARGET_RISCV64)
> >>         target_ulong pte =3D ldq_phys(cs->as, pte_addr);
> >> +        hwaddr ppn =3D (pte & ~PTE_RESERVED) >> PTE_PPN_SHIFT;
> >> #endif
> >> -        hwaddr ppn =3D pte >> PTE_PPN_SHIFT;
> >
> > You don't have to move this shift
> En=E2=80=A6 Do you want this: ?
>
> #if defined(TARGET_RISCV32)
>         target_ulong pte =3D ldl_phys(cs->as, pte_addr);
> +      hwaddr ppn =3D pte;
> #elif defined(TARGET_RISCV64)
>          target_ulong pte =3D ldq_phys(cs->as, pte_addr);
> +       hwaddr ppn =3D (pte & ~PTE_RESERVED);
> #endif
> +        ppn =3D ppn >> PTE_PPN_SHIFT;
>

Yeah, it seems a little cleaner.

Alistair

> The pte couldn=E2=80=99t be destroyed, just ppn ignore the RESERVED bits.
>
>


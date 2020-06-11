Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0A4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:02:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493E6207C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISpEJT3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493E6207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjK2J-0006tG-J5
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjK16-00069F-Ke
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:01:00 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35213)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjK15-0004EI-D7
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:01:00 -0400
Received: by mail-wr1-x42a.google.com with SMTP id x14so5503919wrp.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2txvGK7cakVj6vkQBRqURSgm1nrF4Wrvaq3qcOBzqY0=;
 b=ISpEJT3VAiEisLOy7Jk3+vi6jshyiuDtR001bHF9NzFya541xWzy5EU/Vsn/FGQRVY
 ey0ldO1fHNXnf035LzwcjkXWDhkE4kRQKgjPDKCbNd6ZBOjkth6c81aWDahpfE8tJvzp
 sKO8cJDptEQUmaDsfHD7VqJ8AUIEusTuUS+O/JHM8jWg4CAMDJBZ1UBKcdqcSY92N9I0
 wd/158aYWfSW5UOqwY7/7Xi65fSVf3d/SxGeY1bruz5b8W3R4BnyqE/gGagcJCjegdg8
 0hRTONqds5hbLvUD6257985TPkgwZF38RHzqEfLdh0jA12lI/GL+EvKLBccETxNqqIDe
 /OqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2txvGK7cakVj6vkQBRqURSgm1nrF4Wrvaq3qcOBzqY0=;
 b=o8HQtwkmEhT9bjoM0EfgBDZFaMpGVIvl8iAjGXU5mXTWMfvfy8bnGfiLs9QYc11O06
 xOMkY5KnoJ+ITxH+ithyIsmJ/qBMBPZmYt39D3R6sMxT6aULElT1cHRscwBvnBl/MnoO
 eHw+2oe9qQcwnM3/lRXJgp26DRKr4HhbTaPmR5EM/kjSRTnl0h7uCobiZGlujw/aa+E0
 VHddbUjOOl13+zO+cbSJRUeCSrd6waja4qSnosGKyUjeVFcl6y5z55gtevEG82Zjxrxp
 O5nJLfXZZxyK+MZ47vsb+hCXKkkrRjlH2RyGaROzUu+YaYRqVW672KjjLt8s6HKwIKoz
 9C8g==
X-Gm-Message-State: AOAM532+TZs91EO09WKHDN8o0Q3NyAfpq8HZcoEt85veZa9KZ+6S6gG+
 nKVxXvpklnI/NHBH7dSe9iML2UNGgkmUbPQOu5c=
X-Google-Smtp-Source: ABdhPJz6o4FCkpHcnRaRT6o0Xm5zlh3WDY79v4UYTPWLQW6R/doqT3JgPXacy9uGHgp7KrWwEs57tmSZmjg/LF/Dvds=
X-Received: by 2002:adf:e64b:: with SMTP id b11mr8475102wrn.402.1591869652650; 
 Thu, 11 Jun 2020 03:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1591015405-19651-5-git-send-email-aleksandar.qemu.devel@gmail.com>
 <87h7vi3p9h.fsf@linaro.org>
In-Reply-To: <87h7vi3p9h.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 11 Jun 2020 12:00:40 +0200
Message-ID: <CAHiYmc7oA_+55nWY2uiuW_K6RojkNVqHg20ovdLOhBTe3MEZsg@mail.gmail.com>
Subject: Re: [PULL 4/6] target/mips: Add more CP0 register for save/restore
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=87=D0=B5=D1=82, 11. =D1=98=D1=83=D0=BD 2020. =D1=83 11:50 Alex Benn=C3=
=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:
>
> > From: Huacai Chen <zltjiangshi@gmail.com>
> >
> > Add more CP0 register for save/restore, including: EBase, XContext,
> > PageGrain, PWBase, PWSize, PWField, PWCtl, Config*, KScratch1~KScratch6=
.
> >
> > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> > Message-Id: <1588501221-1205-6-git-send-email-chenhc@lemote.com>
>
> It seems while our mips cross build has been broken this commit has
> caused a build regression:
>

I'll take a look, but would ask Huacai to do the same.

Thanks,
Aleksandar

>   make docker-test-build@debian-mips-cross J=3D30
>
> Results in:
>
>   /tmp/qemu-test/src/target/mips/kvm.c: In function 'kvm_mips_put_cp0_reg=
isters':
>   /tmp/qemu-test/src/target/mips/kvm.c:412:49: error: 'CP0C6_BPPASS' unde=
clared (first use in this function); did you mean 'CP0C3_LPA'?
>    #define KVM_REG_MIPS_CP0_CONFIG6_MASK   ((1U << CP0C6_BPPASS) | \
>                                                    ^~~~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of macr=
o 'KVM_REG_MIPS_CP0_CONFIG6_MASK'
>                                      KVM_REG_MIPS_CP0_CONFIG6_MASK);
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:412:49: note: each undeclared iden=
tifier is reported only once for each function it appears in
>    #define KVM_REG_MIPS_CP0_CONFIG6_MASK   ((1U << CP0C6_BPPASS) | \
>                                                    ^~~~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of macr=
o 'KVM_REG_MIPS_CP0_CONFIG6_MASK'
>                                      KVM_REG_MIPS_CP0_CONFIG6_MASK);
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:413:52: error: 'CP0C6_KPOS' undecl=
ared (first use in this function); did you mean 'CP0C3_IPLV'?
>                                             (0x3fU << CP0C6_KPOS) | \
>                                                       ^~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of macr=
o 'KVM_REG_MIPS_CP0_CONFIG6_MASK'
>                                      KVM_REG_MIPS_CP0_CONFIG6_MASK);
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:414:49: error: 'CP0C6_KE' undeclar=
ed (first use in this function); did you mean 'CP0C4_AE'?
>                                             (1U << CP0C6_KE) | \
>                                                    ^~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of macr=
o 'KVM_REG_MIPS_CP0_CONFIG6_MASK'
>                                      KVM_REG_MIPS_CP0_CONFIG6_MASK);
>
>
> > ---
> >  target/mips/kvm.c     | 212 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  target/mips/machine.c |   6 +-
> >  2 files changed, 216 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> > index de3e26e..96cfa10 100644
> > --- a/target/mips/kvm.c
> > +++ b/target/mips/kvm.c
> > @@ -245,10 +245,16 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int =
irq, int level)
> >      (KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U64 | (8 * (_R) + (_S)))
> >
> >  #define KVM_REG_MIPS_CP0_INDEX          MIPS_CP0_32(0, 0)
> > +#define KVM_REG_MIPS_CP0_RANDOM         MIPS_CP0_32(1, 0)
> >  #define KVM_REG_MIPS_CP0_CONTEXT        MIPS_CP0_64(4, 0)
> >  #define KVM_REG_MIPS_CP0_USERLOCAL      MIPS_CP0_64(4, 2)
> >  #define KVM_REG_MIPS_CP0_PAGEMASK       MIPS_CP0_32(5, 0)
> > +#define KVM_REG_MIPS_CP0_PAGEGRAIN      MIPS_CP0_32(5, 1)
> > +#define KVM_REG_MIPS_CP0_PWBASE         MIPS_CP0_64(5, 5)
> > +#define KVM_REG_MIPS_CP0_PWFIELD        MIPS_CP0_64(5, 6)
> > +#define KVM_REG_MIPS_CP0_PWSIZE         MIPS_CP0_64(5, 7)
> >  #define KVM_REG_MIPS_CP0_WIRED          MIPS_CP0_32(6, 0)
> > +#define KVM_REG_MIPS_CP0_PWCTL          MIPS_CP0_32(6, 6)
> >  #define KVM_REG_MIPS_CP0_HWRENA         MIPS_CP0_32(7, 0)
> >  #define KVM_REG_MIPS_CP0_BADVADDR       MIPS_CP0_64(8, 0)
> >  #define KVM_REG_MIPS_CP0_COUNT          MIPS_CP0_32(9, 0)
> > @@ -258,13 +264,22 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int =
irq, int level)
> >  #define KVM_REG_MIPS_CP0_CAUSE          MIPS_CP0_32(13, 0)
> >  #define KVM_REG_MIPS_CP0_EPC            MIPS_CP0_64(14, 0)
> >  #define KVM_REG_MIPS_CP0_PRID           MIPS_CP0_32(15, 0)
> > +#define KVM_REG_MIPS_CP0_EBASE          MIPS_CP0_64(15, 1)
> >  #define KVM_REG_MIPS_CP0_CONFIG         MIPS_CP0_32(16, 0)
> >  #define KVM_REG_MIPS_CP0_CONFIG1        MIPS_CP0_32(16, 1)
> >  #define KVM_REG_MIPS_CP0_CONFIG2        MIPS_CP0_32(16, 2)
> >  #define KVM_REG_MIPS_CP0_CONFIG3        MIPS_CP0_32(16, 3)
> >  #define KVM_REG_MIPS_CP0_CONFIG4        MIPS_CP0_32(16, 4)
> >  #define KVM_REG_MIPS_CP0_CONFIG5        MIPS_CP0_32(16, 5)
> > +#define KVM_REG_MIPS_CP0_CONFIG6        MIPS_CP0_32(16, 6)
> > +#define KVM_REG_MIPS_CP0_XCONTEXT       MIPS_CP0_64(20, 0)
> >  #define KVM_REG_MIPS_CP0_ERROREPC       MIPS_CP0_64(30, 0)
> > +#define KVM_REG_MIPS_CP0_KSCRATCH1      MIPS_CP0_64(31, 2)
> > +#define KVM_REG_MIPS_CP0_KSCRATCH2      MIPS_CP0_64(31, 3)
> > +#define KVM_REG_MIPS_CP0_KSCRATCH3      MIPS_CP0_64(31, 4)
> > +#define KVM_REG_MIPS_CP0_KSCRATCH4      MIPS_CP0_64(31, 5)
> > +#define KVM_REG_MIPS_CP0_KSCRATCH5      MIPS_CP0_64(31, 6)
> > +#define KVM_REG_MIPS_CP0_KSCRATCH6      MIPS_CP0_64(31, 7)
> >
> >  static inline int kvm_mips_put_one_reg(CPUState *cs, uint64_t reg_id,
> >                                         int32_t *addr)
> > @@ -394,6 +409,29 @@ static inline int kvm_mips_get_one_ureg64(CPUState=
 *cs, uint64_t reg_id,
> >                                           (1U << CP0C5_UFE) | \
> >                                           (1U << CP0C5_FRE) | \
> >                                           (1U << CP0C5_UFR))
> > +#define KVM_REG_MIPS_CP0_CONFIG6_MASK   ((1U << CP0C6_BPPASS) | \
> > +                                         (0x3fU << CP0C6_KPOS) | \
> > +                                         (1U << CP0C6_KE) | \
> > +                                         (1U << CP0C6_VTLBONLY) | \
> > +                                         (1U << CP0C6_LASX) | \
> > +                                         (1U << CP0C6_SSEN) | \
> > +                                         (1U << CP0C6_DISDRTIME) | \
> > +                                         (1U << CP0C6_PIXNUEN) | \
> > +                                         (1U << CP0C6_SCRAND) | \
> > +                                         (1U << CP0C6_LLEXCEN) | \
> > +                                         (1U << CP0C6_DISVC) | \
> > +                                         (1U << CP0C6_VCLRU) | \
> > +                                         (1U << CP0C6_DCLRU) | \
> > +                                         (1U << CP0C6_PIXUEN) | \
> > +                                         (1U << CP0C6_DISBLKLYEN) | \
> > +                                         (1U << CP0C6_UMEMUALEN) | \
> > +                                         (1U << CP0C6_SFBEN) | \
> > +                                         (1U << CP0C6_FLTINT) | \
> > +                                         (1U << CP0C6_VLTINT) | \
> > +                                         (1U << CP0C6_DISBTB) | \
> > +                                         (3U << CP0C6_STPREFCTL) | \
> > +                                         (1U << CP0C6_INSTPREF) | \
> > +                                         (1U << CP0C6_DATAPREF))
>
> It seems a lot of the defines here aren't in this commit. Was one missed?
>
> --
> Alex Benn=C3=A9e


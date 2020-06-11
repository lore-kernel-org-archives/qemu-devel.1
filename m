Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BD1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:59:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 830662063A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAvjnKGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830662063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKvW-0002Zf-He
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjKuj-0001fr-BW
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:58:29 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44238)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjKuh-0008E4-HJ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:58:28 -0400
Received: by mail-wr1-x442.google.com with SMTP id y17so5659811wrn.11
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 03:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=idvPFCU5stMGa4qhmjOVcbkLx9hS6g853aJIDSpX+aE=;
 b=eAvjnKGFwaghY6nPymFQY7qJ1U9BJ7fW+jiar/BpttIlT4NjjB2LkjIC05Q+V/NF+s
 0CAPdRZfTho2CjfaugdxF9LWgR4l7hP/bKHOtbiVx6U3CggB3bTpifPvhye2ZXGkFvHR
 PdsnFCMWIUqb28at/kI+Bl84kfiWK8y0zjrY1fcGfsrpbywe1Q4N9pA5IPiztrff8z0L
 aIGeBk07AOOtyX+Nu0zIZbsVPLrGQYW1Qb1dyyvLHHfB6KRABy1sxGEPMZ91EPVjGopw
 s/e6TNI4jlEGO0luXG3TWLyTVVucrohhAvCnxS9U2o/2ohoT2T8T0FgFLNIwel5t+FDw
 ow/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=idvPFCU5stMGa4qhmjOVcbkLx9hS6g853aJIDSpX+aE=;
 b=R06sVvNlNro+VdZh6jP9o3zzWyfa1JAjEqNeg/bboAvUJ1b01aUHJXx2zGWIfuXE1/
 MjutItp+OMZSiakWa1nWG1Sx2FbgqwUX5Gcl4muvys4cAYqSsOHYJUuoKAMu6IP9B1hj
 9ekv0lSdmdmwzzz//kBA2RanOF8EddeytPZcIo05Sv9jMiuHOv+HWr92NXySzrgOPY2m
 q3up/myb8V/biHLdJsW6SEgfqK3WfsZWPL95sSk5ZmoARcmT/q3UD6imFEyL488U9/Af
 PulAl/kmzhurdl0XvyURT9Ou+g7/ewkFlo5kVJbh+TtDh9phecGUUtWbi0tvbJvNwwWM
 HDnA==
X-Gm-Message-State: AOAM5310AE61dr3hioOqeG+oXzrTC6XRFVBIh7p/grVvSotVCJeUc77O
 CU3Wb5qT84S6aos4sG/cRACnlGti+j/tGbdW4+PLeqjMqQY=
X-Google-Smtp-Source: ABdhPJywqQT4kiLmcuDDyx4dR/5xVfU+loIm6nT/Ec5P7TTmQysTgUu9+7jB8U/WXvK801mm+K1P33fXGz5R8yY0mQM=
X-Received: by 2002:adf:c98a:: with SMTP id f10mr8839158wrh.329.1591873100885; 
 Thu, 11 Jun 2020 03:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <1591015405-19651-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1591015405-19651-5-git-send-email-aleksandar.qemu.devel@gmail.com>
 <87h7vi3p9h.fsf@linaro.org>
In-Reply-To: <87h7vi3p9h.fsf@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 11 Jun 2020 12:58:05 +0200
Message-ID: <CAHiYmc6g1AuaV+knvwfMqpdDx5zmnwQMcHqn+CLeLHDmJ=L=Vw@mail.gmail.com>
Subject: Re: [PULL 4/6] target/mips: Add more CP0 register for save/restore
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b4b1f705a7ccd6ef"
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000b4b1f705a7ccd6ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D0=B5=D1=82, 11. =D1=98=D1=83=D0=BD 2020. =D1=83 11:50 Alex Benn=C3=
=A9e <alex.bennee@linaro.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
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

It appears that the fix for this issue is already a part of my pull request
from Tuesday evening:

https://github.com/AMarkovic/qemu/commit/af868995e1b7641577300d1342ede452ef=
0c5565

There should be need for any additional patch to fix the issue.

Of course, this wouldn't have happened, if I had been more careful. My bad.

Hopefully everything will work without any problems and glitches after the
pull request is applied.

Thanks,
Aleksandar

>   make docker-test-build@debian-mips-cross J=3D30
>
> Results in:
>
>   /tmp/qemu-test/src/target/mips/kvm.c: In function
'kvm_mips_put_cp0_registers':
>   /tmp/qemu-test/src/target/mips/kvm.c:412:49: error: 'CP0C6_BPPASS'
undeclared (first use in this function); did you mean 'CP0C3_LPA'?
>    #define KVM_REG_MIPS_CP0_CONFIG6_MASK   ((1U << CP0C6_BPPASS) | \
>                                                    ^~~~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of
macro 'KVM_REG_MIPS_CP0_CONFIG6_MASK'
>                                      KVM_REG_MIPS_CP0_CONFIG6_MASK);
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:412:49: note: each undeclared
identifier is reported only once for each function it appears in
>    #define KVM_REG_MIPS_CP0_CONFIG6_MASK   ((1U << CP0C6_BPPASS) | \
>                                                    ^~~~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of
macro 'KVM_REG_MIPS_CP0_CONFIG6_MASK'
>                                      KVM_REG_MIPS_CP0_CONFIG6_MASK);
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:413:52: error: 'CP0C6_KPOS'
undeclared (first use in this function); did you mean 'CP0C3_IPLV'?
>                                             (0x3fU << CP0C6_KPOS) | \
>                                                       ^~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of
macro 'KVM_REG_MIPS_CP0_CONFIG6_MASK'
>                                      KVM_REG_MIPS_CP0_CONFIG6_MASK);
>                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:414:49: error: 'CP0C6_KE'
undeclared (first use in this function); did you mean 'CP0C4_AE'?
>                                             (1U << CP0C6_KE) | \
>                                                    ^~~~~~~~
>   /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion of
macro 'KVM_REG_MIPS_CP0_CONFIG6_MASK'
>                                      KVM_REG_MIPS_CP0_CONFIG6_MASK);
>
>
> > ---
> >  target/mips/kvm.c     | 212
++++++++++++++++++++++++++++++++++++++++++++++++++
> >  target/mips/machine.c |   6 +-
> >  2 files changed, 216 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> > index de3e26e..96cfa10 100644
> > --- a/target/mips/kvm.c
> > +++ b/target/mips/kvm.c
> > @@ -245,10 +245,16 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int
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
> > @@ -258,13 +264,22 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int
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
> > @@ -394,6 +409,29 @@ static inline int kvm_mips_get_one_ureg64(CPUState
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

--000000000000b4b1f705a7ccd6ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>=D1=87=D0=B5=D1=82, 11. =D1=98=D1=83=D0=BD 2020. =
=D1=83 11:50 Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org"=
>alex.bennee@linaro.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:<br>&gt;<br>&gt;<br>&gt; Aleksandar Markovic &lt;=
<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gm=
ail.com</a>&gt; writes:<br>&gt;<br>&gt; &gt; From: Huacai Chen &lt;<a href=
=3D"mailto:zltjiangshi@gmail.com">zltjiangshi@gmail.com</a>&gt;<br>&gt; &gt=
;<br>&gt; &gt; Add more CP0 register for save/restore, including: EBase, XC=
ontext,<br>&gt; &gt; PageGrain, PWBase, PWSize, PWField, PWCtl, Config*, KS=
cratch1~KScratch6.<br>&gt; &gt;<br>&gt; &gt; Signed-off-by: Huacai Chen &lt=
;<a href=3D"mailto:chenhc@lemote.com">chenhc@lemote.com</a>&gt;<br>&gt; &gt=
; Co-developed-by: Jiaxun Yang &lt;<a href=3D"mailto:jiaxun.yang@flygoat.co=
m">jiaxun.yang@flygoat.com</a>&gt;<br>&gt; &gt; Reviewed-by: Aleksandar Mar=
kovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksandar.qem=
u.devel@gmail.com</a>&gt;<br>&gt; &gt; Signed-off-by: Aleksandar Markovic &=
lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel=
@gmail.com</a>&gt;<br>&gt; &gt; Message-Id: &lt;<a href=3D"mailto:158850122=
1-1205-6-git-send-email-chenhc@lemote.com">1588501221-1205-6-git-send-email=
-chenhc@lemote.com</a>&gt;<br>&gt;<br>&gt; It seems while our mips cross bu=
ild has been broken this commit has<br>&gt; caused a build regression:<br><=
div>&gt;</div><div><br></div><div>It appears that the fix for this issue is=
 already a part of my pull request from Tuesday evening:</div><div><br></di=
v><div><a href=3D"https://github.com/AMarkovic/qemu/commit/af868995e1b76415=
77300d1342ede452ef0c5565">https://github.com/AMarkovic/qemu/commit/af868995=
e1b7641577300d1342ede452ef0c5565</a></div><div><br></div><div>There should =
be need for any additional patch to fix the issue.</div><div><br></div><div=
>Of course, this wouldn&#39;t have happened, if I had been more careful. My=
 bad.</div><div><br></div><div>Hopefully everything will work without any p=
roblems and glitches after the pull request is applied.</div><div><br></div=
><div>Thanks,</div><div>Aleksandar<br></div><div><br></div>&gt; =C2=A0 make=
 docker-test-build@debian-mips-cross J=3D30<br>&gt;<br>&gt; Results in:<br>=
&gt;<br>&gt; =C2=A0 /tmp/qemu-test/src/target/mips/kvm.c: In function &#39;=
kvm_mips_put_cp0_registers&#39;:<br>&gt; =C2=A0 /tmp/qemu-test/src/target/m=
ips/kvm.c:412:49: error: &#39;CP0C6_BPPASS&#39; undeclared (first use in th=
is function); did you mean &#39;CP0C3_LPA&#39;?<br>&gt; =C2=A0 =C2=A0#defin=
e KVM_REG_MIPS_CP0_CONFIG6_MASK =C2=A0 ((1U &lt;&lt; CP0C6_BPPASS) | \<br>&=
gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~<br>&gt; =C2=A0 /tmp/qemu=
-test/src/target/mips/kvm.c:923:35: note: in expansion of macro &#39;KVM_RE=
G_MIPS_CP0_CONFIG6_MASK&#39;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0KVM_REG_MIPS_CP0_CONFIG6_MASK);<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~~~<=
br>&gt; =C2=A0 /tmp/qemu-test/src/target/mips/kvm.c:412:49: note: each unde=
clared identifier is reported only once for each function it appears in<br>=
&gt; =C2=A0 =C2=A0#define KVM_REG_MIPS_CP0_CONFIG6_MASK =C2=A0 ((1U &lt;&lt=
; CP0C6_BPPASS) | \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~<=
br>&gt; =C2=A0 /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expans=
ion of macro &#39;KVM_REG_MIPS_CP0_CONFIG6_MASK&#39;<br>&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0KVM_REG_MIPS_CP0_CONFIG6_MASK)=
;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~<br>&gt; =C2=A0 /tmp/qemu-test/src/target/mips/kvm.c=
:413:52: error: &#39;CP0C6_KPOS&#39; undeclared (first use in this function=
); did you mean &#39;CP0C3_IPLV&#39;?<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x3fU &lt;&lt; CP0C6_=
KPOS) | \<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>&=
gt; =C2=A0 /tmp/qemu-test/src/target/mips/kvm.c:923:35: note: in expansion =
of macro &#39;KVM_REG_MIPS_CP0_CONFIG6_MASK&#39;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0KVM_REG_MIPS_CP0_CONFIG6_MASK);<br=
>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~<br>&gt; =C2=A0 /tmp/qemu-test/src/target/mips/kvm.c:414:4=
9: error: &#39;CP0C6_KE&#39; undeclared (first use in this function); did y=
ou mean &#39;CP0C4_AE&#39;?<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_KE) | \<br>&gt=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~<br>&gt; =C2=A0 /tmp/qemu-test/sr=
c/target/mips/kvm.c:923:35: note: in expansion of macro &#39;KVM_REG_MIPS_C=
P0_CONFIG6_MASK&#39;<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0KVM_REG_MIPS_CP0_CONFIG6_MASK);<br>&gt;<br>&gt;<br>&gt; &gt; -=
--<br>&gt; &gt; =C2=A0target/mips/kvm.c =C2=A0 =C2=A0 | 212 +++++++++++++++=
+++++++++++++++++++++++++++++++++++<br>&gt; &gt; =C2=A0target/mips/machine.=
c | =C2=A0 6 +-<br>&gt; &gt; =C2=A02 files changed, 216 insertions(+), 2 de=
letions(-)<br>&gt; &gt;<br>&gt; &gt; diff --git a/target/mips/kvm.c b/targe=
t/mips/kvm.c<br>&gt; &gt; index de3e26e..96cfa10 100644<br>&gt; &gt; --- a/=
target/mips/kvm.c<br>&gt; &gt; +++ b/target/mips/kvm.c<br>&gt; &gt; @@ -245=
,10 +245,16 @@ int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int le=
vel)<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0(KVM_REG_MIPS_CP0 | KVM_REG_SIZE_U64 =
| (8 * (_R) + (_S)))<br>&gt; &gt; <br>&gt; &gt; =C2=A0#define KVM_REG_MIPS_=
CP0_INDEX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_32(0, 0)<br>&gt; &gt; =
+#define KVM_REG_MIPS_CP0_RANDOM =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_CP0_32(1,=
 0)<br>&gt; &gt; =C2=A0#define KVM_REG_MIPS_CP0_CONTEXT =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MIPS_CP0_64(4, 0)<br>&gt; &gt; =C2=A0#define KVM_REG_MIPS_CP0_USE=
RLOCAL =C2=A0 =C2=A0 =C2=A0MIPS_CP0_64(4, 2)<br>&gt; &gt; =C2=A0#define KVM=
_REG_MIPS_CP0_PAGEMASK =C2=A0 =C2=A0 =C2=A0 MIPS_CP0_32(5, 0)<br>&gt; &gt; =
+#define KVM_REG_MIPS_CP0_PAGEGRAIN =C2=A0 =C2=A0 =C2=A0MIPS_CP0_32(5, 1)<b=
r>&gt; &gt; +#define KVM_REG_MIPS_CP0_PWBASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 MI=
PS_CP0_64(5, 5)<br>&gt; &gt; +#define KVM_REG_MIPS_CP0_PWFIELD =C2=A0 =C2=
=A0 =C2=A0 =C2=A0MIPS_CP0_64(5, 6)<br>&gt; &gt; +#define KVM_REG_MIPS_CP0_P=
WSIZE =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_CP0_64(5, 7)<br>&gt; &gt; =C2=A0#def=
ine KVM_REG_MIPS_CP0_WIRED =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_32(6,=
 0)<br>&gt; &gt; +#define KVM_REG_MIPS_CP0_PWCTL =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MIPS_CP0_32(6, 6)<br>&gt; &gt; =C2=A0#define KVM_REG_MIPS_CP0_HWR=
ENA =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_CP0_32(7, 0)<br>&gt; &gt; =C2=A0#defin=
e KVM_REG_MIPS_CP0_BADVADDR =C2=A0 =C2=A0 =C2=A0 MIPS_CP0_64(8, 0)<br>&gt; =
&gt; =C2=A0#define KVM_REG_MIPS_CP0_COUNT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0MIPS_CP0_32(9, 0)<br>&gt; &gt; @@ -258,13 +264,22 @@ int kvm_mips_set_ip=
i_interrupt(MIPSCPU *cpu, int irq, int level)<br>&gt; &gt; =C2=A0#define KV=
M_REG_MIPS_CP0_CAUSE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_32(13, 0)<b=
r>&gt; &gt; =C2=A0#define KVM_REG_MIPS_CP0_EPC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0MIPS_CP0_64(14, 0)<br>&gt; &gt; =C2=A0#define KVM_REG_MIPS_CP0=
_PRID =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_CP0_32(15, 0)<br>&gt; &gt; +#=
define KVM_REG_MIPS_CP0_EBASE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_64=
(15, 1)<br>&gt; &gt; =C2=A0#define KVM_REG_MIPS_CP0_CONFIG =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 MIPS_CP0_32(16, 0)<br>&gt; &gt; =C2=A0#define KVM_REG_MIPS_CP=
0_CONFIG1 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_32(16, 1)<br>&gt; &gt; =C2=A0=
#define KVM_REG_MIPS_CP0_CONFIG2 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_32(16,=
 2)<br>&gt; &gt; =C2=A0#define KVM_REG_MIPS_CP0_CONFIG3 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MIPS_CP0_32(16, 3)<br>&gt; &gt; =C2=A0#define KVM_REG_MIPS_CP0_CO=
NFIG4 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_32(16, 4)<br>&gt; &gt; =C2=A0#def=
ine KVM_REG_MIPS_CP0_CONFIG5 =C2=A0 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_32(16, 5)<=
br>&gt; &gt; +#define KVM_REG_MIPS_CP0_CONFIG6 =C2=A0 =C2=A0 =C2=A0 =C2=A0M=
IPS_CP0_32(16, 6)<br>&gt; &gt; +#define KVM_REG_MIPS_CP0_XCONTEXT =C2=A0 =
=C2=A0 =C2=A0 MIPS_CP0_64(20, 0)<br>&gt; &gt; =C2=A0#define KVM_REG_MIPS_CP=
0_ERROREPC =C2=A0 =C2=A0 =C2=A0 MIPS_CP0_64(30, 0)<br>&gt; &gt; +#define KV=
M_REG_MIPS_CP0_KSCRATCH1 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_64(31, 2)<br>&gt; &gt=
; +#define KVM_REG_MIPS_CP0_KSCRATCH2 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_64(31, 3=
)<br>&gt; &gt; +#define KVM_REG_MIPS_CP0_KSCRATCH3 =C2=A0 =C2=A0 =C2=A0MIPS=
_CP0_64(31, 4)<br>&gt; &gt; +#define KVM_REG_MIPS_CP0_KSCRATCH4 =C2=A0 =C2=
=A0 =C2=A0MIPS_CP0_64(31, 5)<br>&gt; &gt; +#define KVM_REG_MIPS_CP0_KSCRATC=
H5 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_64(31, 6)<br>&gt; &gt; +#define KVM_REG_MIP=
S_CP0_KSCRATCH6 =C2=A0 =C2=A0 =C2=A0MIPS_CP0_64(31, 7)<br>&gt; &gt; <br>&gt=
; &gt; =C2=A0static inline int kvm_mips_put_one_reg(CPUState *cs, uint64_t =
reg_id,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 int32_t *addr)<br>&gt; &gt; @@ -394,6 +409,29 @@ static inlin=
e int kvm_mips_get_one_ureg64(CPUState *cs, uint64_t reg_id,<br>&gt; &gt; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
1U &lt;&lt; CP0C5_UFE) | \<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C5_FRE) | \<br>&gt; =
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1U &lt;&lt; CP0C5_UFR))<br>&gt; &gt; +#define KVM_REG_MIPS_CP0_CONFIG6=
_MASK =C2=A0 ((1U &lt;&lt; CP0C6_BPPASS) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x3fU &lt;&lt; CP0C6_=
KPOS) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_KE) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_VTL=
BONLY) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_LASX) | \<br>&gt; &gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_SSE=
N) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_DISDRTIME) | \<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_=
PIXNUEN) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_SCRAND) | \<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP=
0C6_LLEXCEN) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_DISVC) | \<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt;=
 CP0C6_VCLRU) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_DCLRU) | \<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt;=
 CP0C6_PIXUEN) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_DISBLKLYEN) | \<br>&gt; &gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;=
&lt; CP0C6_UMEMUALEN) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_SFBEN) | \<br>&gt; &gt; =
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;=
&lt; CP0C6_FLTINT) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_VLTINT) | \<br>&gt; &gt;=
 + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &=
lt;&lt; CP0C6_DISBTB) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (3U &lt;&lt; CP0C6_STPREFCTL) | \<br>&gt; &=
gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U =
&lt;&lt; CP0C6_INSTPREF) | \<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1U &lt;&lt; CP0C6_DATAPREF))<br>&gt;<br=
>&gt; It seems a lot of the defines here aren&#39;t in this commit. Was one=
 missed?<br>&gt;<br>&gt; --<br>&gt; Alex Benn=C3=A9e</div>

--000000000000b4b1f705a7ccd6ef--


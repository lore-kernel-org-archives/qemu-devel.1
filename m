Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04672C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C111D206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uoml0Ug2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C111D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgpfL-0005vo-3Q
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jgpea-0005Cn-3C
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:11:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jgpeZ-00018c-3N
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:11:27 -0400
Received: by mail-wm1-x344.google.com with SMTP id q25so5588604wmj.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kDgIwhHEpsMApYOvWesR6+idHIDmIg08yib6elr0dhI=;
 b=Uoml0Ug2P7WwrptHcuQnpVKt/s/JxubRbjczs1DuakGiz9H0suHJByQrQn03B2d5qU
 oJJvvo95NQB2vKRZpgTzDkkJL09BfQpUEQop9kiRZAXEcQ/85IdXlgHuzcp5+/vEPfFn
 90xmCQleGFR5QEWWrMiX0nAmjroUBovDB4q7QLFKUtOBCUgNfrOblMGcXm5ZMVzZ03bG
 zm3nfm58Ln0VbYPaFBursdvE2TLYikLyAt6HKf9SEd3rA3fA26UO4oZehCPQEIY4FLvc
 vwLJLOGkkMDluprw0QGSfnyMYCRs0qxY2tFBapganqQ0+yzgr247kbKcNEklYjLp4JaV
 58Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kDgIwhHEpsMApYOvWesR6+idHIDmIg08yib6elr0dhI=;
 b=r3Is4BaA5g/U8LTY3yT+ssD2dy7IdAcOjao1ICrVghuJKI2z6coc59xxB7pSQqyljL
 rLyHjw7+rAHI4X2VQHKpGWesDTV1Hc6lcmKJQ1IMIYf/pIlIyhm15f22UfZf/yBOdroy
 fHpbG7QBNmu/5Vp2DHr4Cyuh7g5UzJ7f8ihveVdZo52Rt2/FMTIfBipkaLHV03OVyqEP
 nRvEHiY9gRIgp7DRLBLAz/dzbnJX8DR+u5uKm0rbQzLrE2YhNNw/g6/HY/OAWyxbk/BT
 bVOA0bRQOWBg6qyf6fV47wE5wL0T410s1IjzNkHifL50iD0E90I3M1keJeNnm/DlG6oS
 nQmQ==
X-Gm-Message-State: AOAM532PsQnsaPQ0xkpiVwtqcyDfH/I1Aycl5PQ3GiwdPJQ5zeca1cJR
 9h/KH4jPSO1RCGOMH4wNneei5F/PRAALEAfACWU=
X-Google-Smtp-Source: ABdhPJyLJUHbk55gETF4xoKWZhVHurKQw2EtCVa5q78w6kjOuHK6J88Puo2h1GShTXPvJR8rPEMpgCDDhbJrjeU3j8E=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr3857454wma.36.1591276283349; 
 Thu, 04 Jun 2020 06:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200517092357.1469-1-aleksandar.qemu.devel@gmail.com>
 <78f4e779-246a-c7c2-d295-6b97dcd6cc31@syrmia.com>
In-Reply-To: <78f4e779-246a-c7c2-d295-6b97dcd6cc31@syrmia.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 4 Jun 2020 15:11:11 +0200
Message-ID: <CAHiYmc4tpLoK8WOH7nS5WgG=fb3kH0w8ZmSx=u4251R23bFZeQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/19] target/mips: FPU and other cleanups and
 improvements
To: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=BE=D0=BD, 18. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:01 Aleksandar Ri=
kalo
<aleksandar.rikalo@syrmia.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>  > This series contains mostly cosmetic FPU cleanups aimed to make
>  > source code recognition easier for tools like gdb, gcov, calgrind,
>  > and others.
>  >
>  > There is also a patch that refactors conversion from ieee to mips
>  > fp exception flags. This refactoring will improve the performance
>  > of almost all fp-related mips instructions, albait very modestly
>  > (less that one percent).
>  >
>  > There is a patch that introduces some logging in mips_malta.c.
>  >
>  > There is a patch on change of Aleksandar Rikalo's email.
>  >
>  > Finally, there is a patch on renaming some files in hw/mips folder.
>  >
>  > v3->v4:
>  >
>  >   - corrected some spelling and style mistakes in commit messages
>  >   - added a patch on renaming some files in hw/mips
>  >
>  > v2->v3:
>  >
>  >   - changed Malta patch to perform logging
>  >   - added change of Aleksandar Rikalo's email
>  >
>  > v1->v2:
>  >
>  >   - added more demacroing
>  >
>  > Aleksandar Markovic (19):
>  >   target/mips: fpu: Demacro ADD.<D|S|PS>
>  >   target/mips: fpu: Demacro SUB.<D|S|PS>
>  >   target/mips: fpu: Demacro MUL.<D|S|PS>
>  >   target/mips: fpu: Demacro DIV.<D|S|PS>
>  >   target/mips: fpu: Remove now unused macro FLOAT_BINOP
>  >   target/mips: fpu: Demacro MADD.<D|S|PS>
>  >   target/mips: fpu: Demacro MSUB.<D|S|PS>
>  >   target/mips: fpu: Demacro NMADD.<D|S|PS>
>  >   target/mips: fpu: Demacro NMSUB.<D|S|PS>
>  >   target/mips: fpu: Remove now unused UNFUSED_FMA and FLOAT_FMA macros
>  >   target/mips: fpu: Demacro CLASS.<D|S>
>  >   target/mips: fpu: Remove now unused FLOAT_CLASS macro
>  >   target/mips: fpu: Demacro RINT.<D|S>
>  >   target/mips: fpu: Remove now unused FLOAT_RINT macro
>  >   target/mips: fpu: Name better paired-single variables
>  >   target/mips: fpu: Refactor conversion from ieee to mips exception
>  >     flags
>  >   hw/mips: Add some logging for bad register offset cases
>  >   MAINTAINERS: Change Aleksandar Rikalo's email address
>  >   hw/mips: Rename malta/mipssim/r4k/jazz files in hw/mips
>  >
>  >  .mailmap                              |   3 +-
>  >  MAINTAINERS                           |  12 +-
>  >  hw/mips/Makefile.objs                 |   8 +-
>  >  hw/mips/{mips_jazz.c =3D> jazz.c}       |   0
>  >  hw/mips/{mips_malta.c =3D> malta.c}     |  14 +-
>  >  hw/mips/{mips_mipssim.c =3D> mipssim.c} |   0
>  >  hw/mips/{mips_r4k.c =3D> r4k.c}         |   0
>  >  target/mips/fpu_helper.c              | 658 ++++++++++++++++++-------=
-
>  >  target/mips/internal.h                |   1 -
>  >  target/mips/msa_helper.c              |  77 ++-
>  >  10 files changed, 523 insertions(+), 250 deletions(-)
>  >  rename hw/mips/{mips_jazz.c =3D> jazz.c} (100%)
>  >  rename hw/mips/{mips_malta.c =3D> malta.c} (99%)
>  >  rename hw/mips/{mips_mipssim.c =3D> mipssim.c} (100%)
>  >  rename hw/mips/{mips_r4k.c =3D> r4k.c} (100%)
>  >
>  > --
>  > 2.20.1
>  >
>
> For patches 1-16 and 18:
>
> Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
>


Patches 1-16 applied to MIPS queue.

Patch 18 is already upstream.
Tthanks,
Aleksandar M.
> Please make sure you rerun our MIPS FPU regression tests after the
> series is applied.
>
> Thanks,
> Aleksandar Rikalo
>


Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B8CC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B55206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 09:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGzcUUxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B55206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY4yv-0003RY-MP
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 05:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY4y8-0002wX-5Q
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:43:28 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jY4y6-00024e-60
 for qemu-devel@nongnu.org; Mon, 11 May 2020 05:43:27 -0400
Received: by mail-wm1-x344.google.com with SMTP id d207so3459539wmd.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 02:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t4a6EitklfM4cMKqe/aAP3h1iETuRVqtm3hsYTtBiuU=;
 b=sGzcUUxUlBwP+Atztv2tuMGB294MenhhBhfl8WJhdYAvcCuyK9DFol6/OPAY91Scur
 E8gQeVmT3mVm3kNbzSxXzVJcO/7vNYLrkNpfgdNWW/W2sxvPj6EAWJE2+mBmoRd4s5qL
 CovAw9970TbcFJmcVL8jbxoeMFFNSkxo3dRR4jWLgOkUx4BB4+7ROZg/KNmuemij6rs1
 S+AYgsdDLqyj9cvLbLuJtXrSI+9cubqJ5D1zn4zsIdOWFqjC70Axw3B2U1wKb0sr+6hP
 /8So0VhhYgU/rjFlzGIpNzq9UDpLGME3fId2sXCyLS1IHpZH5Ce3WHmpf6mt+kQ6+1MG
 Yd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t4a6EitklfM4cMKqe/aAP3h1iETuRVqtm3hsYTtBiuU=;
 b=oB7Foxx8+xHPPHCb1LYuDpcOe/mSxXHxYHkkyPMlwPMeAdlNSUx2hLwODoFLP7gU5Q
 Vz0cuGtnuMbzS/pOWBF7gr7C9q/UYoew/rYGEQbnio9yjuggSuFXooPJoWrtnXcBPY07
 kbMADwN2TauUEkfryqXQhvGZPgY66UQK7ttoNXzbuZvWLs2yNSzZRoDmSqGjAiO83nKn
 Pe1dJXqioWx+r4wHAbVo3caewnoj/F4H9AjzhHRE16p7hhGLFuwTIMuHUir/5KgX3OXy
 OsU00ht/1HzSqJxQquNeaM1Rlueb1D7D18PCfPtndxJaePeqktftJ0u1p37kJtwx7rdJ
 o53A==
X-Gm-Message-State: AGi0PubxQjm4qdKqQ2SdeUi+NvIgtZXBP/qY3EHxh46gLY8vy+IRI8mq
 WApoDTe+cSaR/5j52G8fA7sjo8AxFM5ZBY9dCJ0=
X-Google-Smtp-Source: APiQypJuXvq+WR2jguMuGT2dPIG5P4XGKx4u5yCPkU3F0ac569+VG25GY8UZpw98ZQAzaxvVdFmHgerQBzGal2x4ICw=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr29543340wmk.36.1589190204661; 
 Mon, 11 May 2020 02:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200510210128.18343-1-f4bug@amsat.org>
In-Reply-To: <20200510210128.18343-1-f4bug@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 11 May 2020 11:43:11 +0200
Message-ID: <CAHiYmc6mKVgNAkW4wG7_hcjiF6u_9odJA-fOOk0Z-ZvviXb4Xw@mail.gmail.com>
Subject: Re: [PATCH 00/12] hw/mips/fuloong2e: PoC to fix hang after reboot
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
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

=D0=BD=D0=B5=D0=B4, 10. =D0=BC=D0=B0=D1=98 2020. =D1=83 23:01 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> The PMON firmware behave differently regarding it is run
> after a cold/warm reset. A simple bit flip fix the issue,
> however we need to know the type of reset to set it.
> Currently QEMU only supports COLD reset.
>
> This series contains various of my current Fuloong queue,
> - Welcome Huacai Chen as co-maintainer,
> - Fix typo in machine name,
> - Few cleanups in Bonito64,
> - Report various Bonito64 accesses as UNIMP,
> - Proof-of-concept fix for the reset bit.
>
> The last patch is not for merging, but is included to see
> if the Multi-phase reset mechanism can fix the problem.
>

Perhaps you can change the title of the series in its next version to:

target/mips: Fuloong2e and ither mips fixes and improvements

or similar, since its scope is wider than the current title conveys.

Regards,
Aleksandar



> Regards,
>
> Phil.
>
> Huacai Chen (1):
>   MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer
>
> Philippe Mathieu-Daud=C3=A9 (11):
>   hw/mips/fuloong2e: Rename PMON BIOS name
>   hw/mips/fuloong2e: Move code and update a comment
>   hw/mips/fuloong2e: Fix typo in Fuloong machine name
>   hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
>   hw/pci-host/bonito: Fix DPRINTF() format strings
>   hw/pci-host/bonito: Map peripheral using physical address
>   hw/pci-host/bonito: Map all the Bonito64 I/O range
>   hw/pci-host/bonito: Map the different PCI ranges more detailled
>   hw/pci-host/bonito: Better describe the I/O CS regions
>   hw/pci-host/bonito: Set the Config register reset value with
>     FIELD_DP32
>   POC hw/pci-host/bonito: Fix BONGENCFG value after a warm-reset
>
>  docs/system/target-mips.rst              |  2 +-
>  default-configs/mips64el-softmmu.mak     |  2 +-
>  hw/isa/vt82c686.c                        |  2 +-
>  hw/mips/{mips_fulong2e.c =3D> fuloong2e.c} | 41 +++++------
>  hw/pci-host/bonito.c                     | 92 +++++++++++++++++++-----
>  tests/qtest/endianness-test.c            |  2 +-
>  MAINTAINERS                              |  6 +-
>  hw/mips/Kconfig                          |  3 +-
>  hw/mips/Makefile.objs                    |  2 +-
>  hw/pci-host/Kconfig                      |  5 ++
>  hw/pci-host/Makefile.objs                |  2 +-
>  11 files changed, 114 insertions(+), 45 deletions(-)
>  rename hw/mips/{mips_fulong2e.c =3D> fuloong2e.c} (91%)
>
> --
> 2.21.3
>


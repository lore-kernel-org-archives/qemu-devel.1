Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418A4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0272E2084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQg16WAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0272E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZR3-0004PO-7Z
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdZQG-0003ju-Hn
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:15:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:50388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdZQF-0002lX-LH
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:15:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id v19so3113381wmj.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nBRwjZOALQit1YdU4JzrN02McvCHQt3E0H9tcf5pzFQ=;
 b=MQg16WAfilWw6OsCl20qg4ceC3IwWVgtu/PgM8OxJDYZCJ1nwGnpE1tJczLgsBLfeA
 ETqXuwzMXGMbYHKbThoYNHQq/YuJg8ZrrqbvCPG7mqiIxNwH8r02l02U7ygY/sxgSirA
 q5zrGbi3DYNluv+MtTWVo4rJ+iZ5pItQy7KdDdv8gN7oBj3ckcX3iV4QcDg7mZlHQjZb
 3FcMUJnGKnXc0FSeeG79rerrgvRJeGkEjKiYsRPv0Ir5EpK1C6dduz/7iRFzUt8O3t4Z
 w4ILFUNnsG9nmPq3foRaEEhI5wE4iC75OKn3ZBfEvntY9RBkGmbQPB+0dzjj75Kq0xOh
 bcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nBRwjZOALQit1YdU4JzrN02McvCHQt3E0H9tcf5pzFQ=;
 b=USoPlq1oZodAjO+PpaG5mdqkBQmQh/4o6ywpli+qbWAPEdSasleiN/xOv7cQDz6YFI
 oiwpMQ+b3wUdtv8b8xg7w4p0xwTqtDnCRkw2vzoFrPx62i716v0w4/54gWS6AhqK8Gzd
 E8mG9a4oqO3msUgwYyKDNrSx2Docu1Ecg6kIQbQzCOwNleCNa2qGzFxebRarvXwVwmp6
 6x2P8RGhTqubuNKV6Xt7R3Pi/1MdAeQHT3RWd0rVYmPPjOhTacFM9NPtYHa9HnGSi8Dp
 JCicQw0Mbx9PtLdzrsgxfEQypOk0E9yUp9WtI+Vumi0xPvHlvOO60j+zwq2tXnzcz8l7
 ORzg==
X-Gm-Message-State: AOAM532AVeH18FRFrWNkPvg6mQROzvvu3QhZfaTw0m48coiatOGCElQS
 W8karazs+tAW0CJzimWzXkqFt/SShd8US5FBGeI=
X-Google-Smtp-Source: ABdhPJxVeWcVZwOKolOH0U4Zzqx1Gp0e46sd4mBp44gNYp3in34AVOfM6kVUxCHv3cu6aU4fKSUX9TbPKV/IaOzspag=
X-Received: by 2002:a05:600c:22c1:: with SMTP id
 1mr1475752wmg.50.1590498910275; 
 Tue, 26 May 2020 06:15:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200526104726.11273-1-f4bug@amsat.org>
 <CAHiYmc7_Td7hCPbkboMUZpy5HQH47DR1Jh-ux9t7MW+kt=o6Eg@mail.gmail.com>
In-Reply-To: <CAHiYmc7_Td7hCPbkboMUZpy5HQH47DR1Jh-ux9t7MW+kt=o6Eg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 15:14:57 +0200
Message-ID: <CAHiYmc5ir9JDULc2ssNLx+DQZ7jm7oY_UxYiotHV4Yh+pJH7vw@mail.gmail.com>
Subject: Re: [PATCH 00/14] hw/mips: patch queue for 2020-05-26
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, 
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32b.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, libvir-list@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhc@lemote.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:06 Aleksandar Ma=
rkovic
<aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> =D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:47 Philippe Ma=
thieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > Hi,
> >
> > This is the current state of my hw/mips/next tree.
> >
> > - MAINTAINERS updated to welcome Huacai Chen and Jiaxun Yang,
> >   and update Aleksandar Rikalo's email address,
> >
> > - Trivial improvements in the Bonito64 North Bridge and the
> >   Fuloong 2e machine,
> >
> > - MIPS Machines names unified without 'mips_' prefix.
> >
> > The following patches need review:
> >
> > - #6  "hw/pci-host/bonito: Map the different PCI ranges more detailled"
> > - #10 "hw/mips/fuloong2e: Fix typo in Fuloong machine name"
> >
>
> I agreed with these two patches, thanks for your help, patch 6 looks
> much better now.
>
> Hope you will be able to send pull request sooner rather than later.
> Please work with Gerd to speed up the process, resolving the
> dependencies efficiently.
>

Hi, Gerd,

My understanding is that a rather trivial issue (removing an #include)
from a mips-specific file, makes your potential pull request, and this
Philippe's pull request dependent between themself. I think actually
Philippe is waiting for your pull request to be sent and applied.
Could you update us on the planned timing of your pull request?

Thanks,
Aleksandar

P.S Too bad such trivial issues from time to time cause stalls in our
workflows, but I guess it is sometimes unavoidable, and we have to
live with that.


> Yours,
> Aleksandar
>
>
>
>
> > Aleksandar Markovic (3):
> >   hw/mips: Rename malta/mipssim/r4k/jazz files
> >   hw/mips/malta: Add some logging for bad register offset cases
> >   MAINTAINERS: Change Aleksandar Rikalo's email address
> >
> > Huacai Chen (1):
> >   MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer
> >
> > Philippe Mathieu-Daud=C3=A9 (10):
> >   hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
> >   hw/pci-host/bonito: Fix DPRINTF() format strings
> >   hw/pci-host/bonito: Map peripheral using physical address
> >   hw/pci-host/bonito: Map all the Bonito64 I/O range
> >   hw/pci-host/bonito: Map the different PCI ranges more detailled
> >   hw/pci-host/bonito: Better describe the I/O CS regions
> >   hw/pci-host/bonito: Set the Config register reset value with
> >     FIELD_DP32
> >   hw/mips/fuloong2e: Move code and update a comment
> >   hw/mips/fuloong2e: Fix typo in Fuloong machine name
> >   hw/mips/mips_int: De-duplicate KVM interrupt delivery
> >
> >  docs/system/deprecated.rst               |  5 ++
> >  docs/system/target-mips.rst              |  2 +-
> >  default-configs/mips64el-softmmu.mak     |  2 +-
> >  hw/isa/vt82c686.c                        |  2 +-
> >  hw/mips/{mips_fulong2e.c =3D> fuloong2e.c} | 48 ++++++-------
> >  hw/mips/{mips_jazz.c =3D> jazz.c}          |  0
> >  hw/mips/{mips_malta.c =3D> malta.c}        | 14 ++--
> >  hw/mips/mips_int.c                       | 11 +--
> >  hw/mips/{mips_mipssim.c =3D> mipssim.c}    |  0
> >  hw/mips/{mips_r4k.c =3D> r4k.c}            |  0
> >  hw/pci-host/bonito.c                     | 87 +++++++++++++++++++-----
> >  tests/qtest/endianness-test.c            |  2 +-
> >  .mailmap                                 |  3 +-
> >  MAINTAINERS                              | 26 +++----
> >  hw/mips/Kconfig                          |  3 +-
> >  hw/mips/Makefile.objs                    | 10 +--
> >  hw/pci-host/Kconfig                      |  5 ++
> >  hw/pci-host/Makefile.objs                |  2 +-
> >  18 files changed, 142 insertions(+), 80 deletions(-)
> >  rename hw/mips/{mips_fulong2e.c =3D> fuloong2e.c} (91%)
> >  rename hw/mips/{mips_jazz.c =3D> jazz.c} (100%)
> >  rename hw/mips/{mips_malta.c =3D> malta.c} (99%)
> >  rename hw/mips/{mips_mipssim.c =3D> mipssim.c} (100%)
> >  rename hw/mips/{mips_r4k.c =3D> r4k.c} (100%)
> >
> > --
> > 2.21.3
> >


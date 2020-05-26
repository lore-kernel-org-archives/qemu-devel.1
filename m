Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043CEC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:30:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C10207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 13:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UH+YmlHy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C10207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdZfO-0005VE-Vm
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 09:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdZeY-0004qb-4Q
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:29:58 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jdZeW-00059t-Vx
 for qemu-devel@nongnu.org; Tue, 26 May 2020 09:29:57 -0400
Received: by mail-wr1-x444.google.com with SMTP id j10so4801436wrw.8
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vkjNSZ+ZGxkshuOXxNAzhpfU1GxeVeMpWlsxxPOD+yw=;
 b=UH+YmlHy8XRbgvZhKQQ1bVLTgX3iFrJeiV7ptkYm4Y5XS70e7ZzX84fVU9xAzoghb/
 RdTNztjwEvdT8n5AGWSR58iJX7aTXnkVt0MXinEt6NW/JsuD1AIh3M5IRQTmLONnlybQ
 2i0hfUIj5eZOWRUry24beUM3PO6kF34q3eYyhWUyupWUJOX7XDvrq4XmCur3XF6feQqB
 mZ7POU4H0GdQNR8T49fpChVrTjyS7HqbbKUoqNs6u2+OoEAgmoxhwvRAumgz4yLW5yGP
 xS/anzmtAN3h03H7erK439qEPqHAYHGDOAaHlojzLstJku+L/V4+T0/VFqUwzyCQ0xeK
 EJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vkjNSZ+ZGxkshuOXxNAzhpfU1GxeVeMpWlsxxPOD+yw=;
 b=UkYrMNlYJtpOkKKYqqpRl3aO/vkOiC9vPp5ymw96K+ru42IouRe3TJJ5Nj+T69PwCv
 Ow8ho1x3l+gVVvm2VtAJ3jbuBNvkxs28z9W0/4gY3GA7Rz/XQLg9o+JnlisDBikIYYEc
 Jyd1C81TOmWkBE55rNPiFXDvMU3fEVWBHlgxCiq6OCZOhieXq3NbTRyQBymu88vi1WP0
 l0PlTQg+5OTKOeMsoeRxC6m6d95UXvqsjWkQ+7zhUbXqko9RZXSJODpBkpqZQI6n4Igj
 wd4oez7qxrg9WW78UQOVqnCpUh8/XLfS+vMbGdZ02rABUTQgvVJFlqH1EreHPRkqsArW
 2TqQ==
X-Gm-Message-State: AOAM533l1em3VCJWD/a/rSdxObT8eIKFqoOjgPCsaDPpPNM1fxklWmrj
 hxbke1JFauF4O4oTOo8bO4+mHJ5P67YoKOZ2qGE=
X-Google-Smtp-Source: ABdhPJwsjj5xzv/iS9c9EoaBCciCnMJ3CV5pL48/W5XV7bIw5cMmNriK3ttI5Vn+v/ILg7xVMr3wu+beKTXhv3dTH5s=
X-Received: by 2002:a5d:4385:: with SMTP id i5mr13307108wrq.420.1590499795086; 
 Tue, 26 May 2020 06:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200526104726.11273-1-f4bug@amsat.org>
 <CAHiYmc7_Td7hCPbkboMUZpy5HQH47DR1Jh-ux9t7MW+kt=o6Eg@mail.gmail.com>
 <CAHiYmc5ir9JDULc2ssNLx+DQZ7jm7oY_UxYiotHV4Yh+pJH7vw@mail.gmail.com>
 <d343aa59-625e-28c4-315d-aab79d668a95@amsat.org>
In-Reply-To: <d343aa59-625e-28c4-315d-aab79d668a95@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 26 May 2020 15:29:41 +0200
Message-ID: <CAHiYmc43oy4N++bZeTzB93Uk09eYtmcvKJNSnDtzgoFd6m6zbg@mail.gmail.com>
Subject: Re: [PATCH 00/14] hw/mips: patch queue for 2020-05-26
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
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
 Gerd Hoffmann <kraxel@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 15:20 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 5/26/20 3:14 PM, Aleksandar Markovic wrote:
> > =D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:06 Aleksanda=
r Markovic
> > <aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> =D1=83=D1=82=D0=BE, 26. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:47 Philippe=
 Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> >> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>>
> >>> Hi,
> >>>
> >>> This is the current state of my hw/mips/next tree.
> >>>
> >>> - MAINTAINERS updated to welcome Huacai Chen and Jiaxun Yang,
> >>>   and update Aleksandar Rikalo's email address,
> >>>
> >>> - Trivial improvements in the Bonito64 North Bridge and the
> >>>   Fuloong 2e machine,
> >>>
> >>> - MIPS Machines names unified without 'mips_' prefix.
> >>>
> >>> The following patches need review:
> >>>
> >>> - #6  "hw/pci-host/bonito: Map the different PCI ranges more detaille=
d"
> >>> - #10 "hw/mips/fuloong2e: Fix typo in Fuloong machine name"
> >>>
> >>
> >> I agreed with these two patches, thanks for your help, patch 6 looks
> >> much better now.
> >>
> >> Hope you will be able to send pull request sooner rather than later.
> >> Please work with Gerd to speed up the process, resolving the
> >> dependencies efficiently.
> >>
> >
> > Hi, Gerd,
> >
> > My understanding is that a rather trivial issue (removing an #include)
> > from a mips-specific file, makes your potential pull request, and this
> > Philippe's pull request dependent between themself. I think actually
> > Philippe is waiting for your pull request to be sent and applied.
> > Could you update us on the planned timing of your pull request?
>
> Don't worry, Gerd sent his pullreq and Peter is testing it. I'm waiting
> Peter's testing done to rebase/send. No hurry anyway ;)
>

Peter accepted Gerd's pull request 17 mins ago.

There is a hurry, Philippe, because, some other pending series needs
to be rebased because of file name changes in this series, and I
really would not like to prolong and complicate your efforts in case
we clash with some other pull request over such trivial stuff. i
advice you to send a pull request as soon as you do your regular
preparation and tests - I would really appreciate today, if possible.
Thanks for for your involvement, and meticulousness regarding all
patches in this series and future pull request!

Aleksandar


> >
> > Thanks,
> > Aleksandar
> >
> > P.S Too bad such trivial issues from time to time cause stalls in our
> > workflows, but I guess it is sometimes unavoidable, and we have to
> > live with that.
> >
> >
> >> Yours,
> >> Aleksandar
> >>
> >>
> >>
> >>
> >>> Aleksandar Markovic (3):
> >>>   hw/mips: Rename malta/mipssim/r4k/jazz files
> >>>   hw/mips/malta: Add some logging for bad register offset cases
> >>>   MAINTAINERS: Change Aleksandar Rikalo's email address
> >>>
> >>> Huacai Chen (1):
> >>>   MAINTAINERS: Add Huacai Chen as fuloong2e co-maintainer
> >>>
> >>> Philippe Mathieu-Daud=C3=A9 (10):
> >>>   hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridg=
e
> >>>   hw/pci-host/bonito: Fix DPRINTF() format strings
> >>>   hw/pci-host/bonito: Map peripheral using physical address
> >>>   hw/pci-host/bonito: Map all the Bonito64 I/O range
> >>>   hw/pci-host/bonito: Map the different PCI ranges more detailled
> >>>   hw/pci-host/bonito: Better describe the I/O CS regions
> >>>   hw/pci-host/bonito: Set the Config register reset value with
> >>>     FIELD_DP32
> >>>   hw/mips/fuloong2e: Move code and update a comment
> >>>   hw/mips/fuloong2e: Fix typo in Fuloong machine name
> >>>   hw/mips/mips_int: De-duplicate KVM interrupt delivery
> >>>
> >>>  docs/system/deprecated.rst               |  5 ++
> >>>  docs/system/target-mips.rst              |  2 +-
> >>>  default-configs/mips64el-softmmu.mak     |  2 +-
> >>>  hw/isa/vt82c686.c                        |  2 +-
> >>>  hw/mips/{mips_fulong2e.c =3D> fuloong2e.c} | 48 ++++++-------
> >>>  hw/mips/{mips_jazz.c =3D> jazz.c}          |  0
> >>>  hw/mips/{mips_malta.c =3D> malta.c}        | 14 ++--
> >>>  hw/mips/mips_int.c                       | 11 +--
> >>>  hw/mips/{mips_mipssim.c =3D> mipssim.c}    |  0
> >>>  hw/mips/{mips_r4k.c =3D> r4k.c}            |  0
> >>>  hw/pci-host/bonito.c                     | 87 +++++++++++++++++++---=
--
> >>>  tests/qtest/endianness-test.c            |  2 +-
> >>>  .mailmap                                 |  3 +-
> >>>  MAINTAINERS                              | 26 +++----
> >>>  hw/mips/Kconfig                          |  3 +-
> >>>  hw/mips/Makefile.objs                    | 10 +--
> >>>  hw/pci-host/Kconfig                      |  5 ++
> >>>  hw/pci-host/Makefile.objs                |  2 +-
> >>>  18 files changed, 142 insertions(+), 80 deletions(-)
> >>>  rename hw/mips/{mips_fulong2e.c =3D> fuloong2e.c} (91%)
> >>>  rename hw/mips/{mips_jazz.c =3D> jazz.c} (100%)
> >>>  rename hw/mips/{mips_malta.c =3D> malta.c} (99%)
> >>>  rename hw/mips/{mips_mipssim.c =3D> mipssim.c} (100%)
> >>>  rename hw/mips/{mips_r4k.c =3D> r4k.c} (100%)
> >>>
> >>> --
> >>> 2.21.3
> >>>
> >


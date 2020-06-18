Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30480C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049752075E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 15:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049752075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlwMG-0005eR-8d
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 11:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlwLP-0004nG-Bl
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:20:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:49524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlwLM-0003xa-Qc
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 11:20:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jlwLK-0000id-C9
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 15:20:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5AEE82E810A
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 15:20:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2020 15:11:42 -0000
From: Aleksandar Markovic <1883560@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: build linux-user mips
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee aleksandar-markovic laurent-vivier
X-Launchpad-Bug-Reporter: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
X-Launchpad-Bug-Modifier: Aleksandar Markovic (aleksandar-markovic)
References: <159223432851.7281.13140123017230519248.malonedeb@gac.canonical.com>
Message-ID: <CAHiYmc4CSjJ2ZVmAtfaQNqve=XQD04-JZrcVnozk18vWtxBmug@mail.gmail.com>
Subject: Re: [Bug 1883560] [NEW] mips linux-user builds occasionly crash
 randomly only to be fixed by a full clean re-build
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 603bcab4b7d8d10d60e59472bd55d73d2ae5790d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 11:20:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1883560 <1883560@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200618151142.G3Th_GWxoe1_Jft7QkAe_0Sufdz8FKI6PF_dr1Gl69g@z>

=D1=87=D0=B5=D1=82=D0=B2=D1=80=D1=82=D0=B0=D0=BA, 18. =D1=98=D1=83=D0=BD 20=
20., Cornelia Huck <cohuck@redhat.com> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> On Mon, 15 Jun 2020 15:18:48 -0000
> Alex Benn=C3=A9e <1883560@bugs.launchpad.net> wrote:
>
> > Public bug reported:
> >
> > >From time to time I find check-tcg crashes with a one of the MIPS
> > binaries. The last time it crashed was running the test:
> >
> >   ./mips64el-linux-user/qemu-mips64el ./tests/tcg/mips64el-linux-
> > user/threadcount
> >
> > Inevitably after some time noodling around wondering what could be
> > causing this weird behaviour I wonder if it is a build issue. I wipe all
> > the mips* build directories, re-run configure and re-build and voila
> > problem goes away.
> >
> > It seems there must be some sort of build artefact which isn't being
> > properly re-generated on a build update which causes weird problems.
> > Additional data point if I:
> >
> >   rm -rf mips64el-linux-user
> >   ../../configure
> >   make
> >
> > then I see failures in mip32 builds - eg:
> >
> >     GEN     mipsn32el-linux-user/config-target.h
> >   In file included from /home/alex/lsrc/qemu.git/
> linux-user/syscall_defs.h:10,
> >                    from /home/alex/lsrc/qemu.git/linux-user/qemu.h:16,
> >                    from /home/alex/lsrc/qemu.git/
> linux-user/linuxload.c:5:
> >   /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:1: error:
> unterminated #ifndef
> >    #ifndef LINUX_USER_MIPS64_SYSCALL_NR_H
> >
> >   make[1]: *** [/home/alex/lsrc/qemu.git/rules.mak:69:
> linux-user/linuxload.o] Error 1
> >   make[1]: *** Waiting for unfinished jobs....
> >
> > which implies there is a cross dependency between different targets
> > somewhere. If I executed:
> >
> >   rm -rf mips*
> >
> > before re-configuring and re-building then everything works again.
> >
> > ** Affects: qemu
> >      Importance: Undecided
> >          Status: New
> >
> >
> > ** Tags: build linux-user mips
> >
>
> FWIW, this does not seem to be a mips-only issue: I'm seeing the
> threadcount test fail with s390x-linux-user as well, and it also goes
> away (only) if I purge the build directory, re-configure, and re-build.
>
>
Valuable info!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1883560

Title:
  mips linux-user builds occasionly crash randomly only to be fixed by a
  full clean re-build

Status in QEMU:
  New

Bug description:
  From time to time I find check-tcg crashes with a one of the MIPS
  binaries. The last time it crashed was running the test:

    ./mips64el-linux-user/qemu-mips64el ./tests/tcg/mips64el-linux-
  user/threadcount

  Inevitably after some time noodling around wondering what could be
  causing this weird behaviour I wonder if it is a build issue. I wipe
  all the mips* build directories, re-run configure and re-build and
  voila problem goes away.

  It seems there must be some sort of build artefact which isn't being
  properly re-generated on a build update which causes weird problems.
  Additional data point if I:

    rm -rf mips64el-linux-user
    ../../configure
    make

  then I see failures in mip32 builds - eg:

      GEN     mipsn32el-linux-user/config-target.h
    In file included from /home/alex/lsrc/qemu.git/linux-user/syscall_defs.=
h:10,
                     from /home/alex/lsrc/qemu.git/linux-user/qemu.h:16,
                     from /home/alex/lsrc/qemu.git/linux-user/linuxload.c:5:
    /home/alex/lsrc/qemu.git/linux-user/mips64/syscall_nr.h:1: error: unter=
minated #ifndef
     #ifndef LINUX_USER_MIPS64_SYSCALL_NR_H

    make[1]: *** [/home/alex/lsrc/qemu.git/rules.mak:69: linux-user/linuxlo=
ad.o] Error 1
    make[1]: *** Waiting for unfinished jobs....

  which implies there is a cross dependency between different targets
  somewhere. If I executed:

    rm -rf mips*

  before re-configuring and re-building then everything works again.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1883560/+subscriptions


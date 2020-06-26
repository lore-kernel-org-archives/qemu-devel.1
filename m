Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A14BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:46:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9C920775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 07:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9C920775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joj4N-00023q-P6
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 03:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1joj3S-0001Lu-2g
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:45:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:41292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1joj3O-0006Gw-LO
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 03:45:45 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1joj3M-00066p-Ed
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 07:45:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4528D2E8109
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 07:45:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2020 07:37:14 -0000
From: Aleksandar Markovic <1885247@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aleksandar-markovic
X-Launchpad-Bug-Reporter: Aleksandar Markovic (aleksandar-markovic)
X-Launchpad-Bug-Modifier: Aleksandar Markovic (aleksandar-markovic)
References: <159315507826.13901.17398620572438937429.malonedeb@wampee.canonical.com>
Message-ID: <CAHiYmc7_ra2qWJ8mkZ-vqL5vN2BKdWxAZeKNnMEkPtien5-fsw@mail.gmail.com>
Subject: Re: [Bug 1885247] [NEW] Build error in Intel 32-bit hosts
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: e58a5496bc49c0139aae747357b3fe36ef862840
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:10:42
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
Reply-To: Bug 1885247 <1885247@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200626073714.qV5UsGTQXYA0LPnu8O7P57Z_a2lB1rahKqN3baLjJiU@z>

=D0=BF=D0=B5=D1=82, 26. =D1=98=D1=83=D0=BD 2020. =D1=83 09:11 Aleksandar Ma=
rkovic
<1885247@bugs.launchpad.net> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:
>
> Public bug reported:
>
> The code base is on master, checked out on Thursday June25th 2020,
> 0250c595c9d. The build procedure:
>
> $ mkdir build-gcc
> $ cd build-gcc
> $ ../configure
> $ make
>
> The build error message is:
>
>   CC      x86_64-softmmu/hw/hyperv/hyperv.o
>   CC      x86_64-softmmu/hw/hyperv/hyperv_testdev.o
>   CC      x86_64-softmmu/hw/hyperv/vmbus.o
> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c: In function =E2=80=98gpad=
l_iter_io=E2=80=99:
> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c:386:13: error: cast to poi=
nter from integer of different size [-Werror=3Dint-to-pointer-cast]
>          p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_i=
n_page);
>              ^
> cc1: all warnings being treated as errors
> make[1]: *** [/home/rtrk/Build/qemu-master/rules.mak:69: hw/hyperv/vmbus.=
o] Error 1
> make: *** [Makefile:527: x86_64-softmmu/all] Error 2
>

Jon,

Do arilyou have any comment or insight on this?

Thanks,
Aleksandar

> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1885247
>
> Title:
>   Build error in Intel 32-bit hosts
>
> Status in QEMU:
>   New
>
> Bug description:
>   The code base is on master, checked out on Thursday June25th 2020,
>   0250c595c9d. The build procedure:
>
>   $ mkdir build-gcc
>   $ cd build-gcc
>   $ ../configure
>   $ make
>
>   The build error message is:
>
>     CC      x86_64-softmmu/hw/hyperv/hyperv.o
>     CC      x86_64-softmmu/hw/hyperv/hyperv_testdev.o
>     CC      x86_64-softmmu/hw/hyperv/vmbus.o
>   /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c: In function =E2=80=98gp=
adl_iter_io=E2=80=99:
>   /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c:386:13: error: cast to p=
ointer from integer of different size [-Werror=3Dint-to-pointer-cast]
>            p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off=
_in_page);
>                ^
>   cc1: all warnings being treated as errors
>   make[1]: *** [/home/rtrk/Build/qemu-master/rules.mak:69: hw/hyperv/vmbu=
s.o] Error 1
>   make: *** [Makefile:527: x86_64-softmmu/all] Error 2
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1885247/+subscriptions
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1885247

Title:
  Build error in Intel 32-bit hosts

Status in QEMU:
  New

Bug description:
  The code base is on master, checked out on Thursday June25th 2020,
  0250c595c9d. The build procedure:

  $ mkdir build-gcc
  $ cd build-gcc
  $ ../configure
  $ make

  The build error message is:

    CC      x86_64-softmmu/hw/hyperv/hyperv.o
    CC      x86_64-softmmu/hw/hyperv/hyperv_testdev.o
    CC      x86_64-softmmu/hw/hyperv/vmbus.o
  /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c: In function =E2=80=98gpad=
l_iter_io=E2=80=99:
  /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c:386:13: error: cast to poi=
nter from integer of different size [-Werror=3Dint-to-pointer-cast]
           p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_i=
n_page);
               ^
  cc1: all warnings being treated as errors
  make[1]: *** [/home/rtrk/Build/qemu-master/rules.mak:69: hw/hyperv/vmbus.=
o] Error 1
  make: *** [Makefile:527: x86_64-softmmu/all] Error 2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1885247/+subscriptions


Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8E9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3070420791
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 11:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3070420791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jomV5-0002VE-DA
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 07:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jomUL-00022j-65
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:25:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:58936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jomUI-0001OS-SX
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 07:25:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jomUG-0007ye-Gl
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:25:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 78B6E2E806D
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:25:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2020 11:20:08 -0000
From: Aleksandar Markovic <1885247@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aleksandar-markovic philmd pmaydell
X-Launchpad-Bug-Reporter: Aleksandar Markovic (aleksandar-markovic)
X-Launchpad-Bug-Modifier: Aleksandar Markovic (aleksandar-markovic)
References: <159315507826.13901.17398620572438937429.malonedeb@wampee.canonical.com>
Message-ID: <CAHiYmc7SrqDZQzEdfM7NKt=vPjmXACQF+C45R76yNEgq1VQJxw@mail.gmail.com>
Subject: Re: [Bug 1885247] [NEW] Build error in Intel 32-bit hosts
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 144cda33e94c4baded3a0bb5387c3209b5791fb1
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:10:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Message-ID: <20200626112008.5uF4TVqvVXT8PqCfugMbElv7kwffl_tjsMJONyLvV7k@z>

=D0=BF=D0=B5=D1=82, 26. =D1=98=D1=83=D0=BD 2020. =D1=83 12:54 Jon Doron <ar=
ilou@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=
=BB=D0=B0:
>
> Is there a container I can download which has your build environment?
>

Hello, Jon.

I don't know about the container, but, as Peter noted, the following
(non-beautiful) diff fixes the build problem on the real host:

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index f371240176..9220f7b529 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -383,7 +383,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void
*buf, uint32_t len)
             }
         }

-        p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_=
page);
+        p =3D (void *)(uintptr_t)(((uintptr_t)iter->map & TARGET_PAGE_MASK=
) |
+                                off_in_page);
         if (iter->dir =3D=3D DMA_DIRECTION_FROM_DEVICE) {
             memcpy(p, buf, cplen);
         } else {

Not sure if this is an optimal/most-elegant solution though.

Warmly,
Aleksandar


> On Fri, Jun 26, 2020 at 12:27 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > On 6/26/20 11:20 AM, Thomas Huth wrote:
> > > On 26/06/2020 11.13, Philippe Mathieu-Daud=C3=A9 wrote:
> > >> On 6/26/20 9:37 AM, Aleksandar Markovic wrote:
> > >>> =D0=BF=D0=B5=D1=82, 26. =D1=98=D1=83=D0=BD 2020. =D1=83 09:11 Aleks=
andar Markovic
> > >>> <1885247@bugs.launchpad.net> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> > >>>>
> > >>>> Public bug reported:
> > >>>>
> > >>>> The code base is on master, checked out on Thursday June25th 2020,
> > >>>> 0250c595c9d. The build procedure:
> > >>>>
> > >>>> $ mkdir build-gcc
> > >>>> $ cd build-gcc
> > >>>> $ ../configure
> > >>>> $ make
> > >>>>
> > >>>> The build error message is:
> > >>>>
> > >>>>    CC      x86_64-softmmu/hw/hyperv/hyperv.o
> > >>>>    CC      x86_64-softmmu/hw/hyperv/hyperv_testdev.o
> > >>>>    CC      x86_64-softmmu/hw/hyperv/vmbus.o
> > >>>> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c: In function
> > >>>> =E2=80=98gpadl_iter_io=E2=80=99:
> > >>>> /home/rtrk/Build/qemu-master/hw/hyperv/vmbus.c:386:13: error: cast
> > >>>> to pointer from integer of different size [-Werror=3Dint-to-pointe=
r-cast]
> > >>>>           p =3D (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK)=
 |
> > >>>> off_in_page);
> > >>>>               ^
> > >>>> cc1: all warnings being treated as errors
> > >>>> make[1]: *** [/home/rtrk/Build/qemu-master/rules.mak:69:
> > >>>> hw/hyperv/vmbus.o] Error 1
> > >>>> make: *** [Makefile:527: x86_64-softmmu/all] Error 2
> > >>
> > >> FWIW there is no CI job covering x86 KVM on 32-bit host build.
> > >> Should this be covered? I guess the problem is no CI services
> > >> provide 32-bit x86...
> > >
> > > You can certainly provide either a container, or install the 32-bit
> > > libraries in a 64-bit environment. Then run
> > >
> > > PKG_CONFIG_LIBDIR=3D... ./configure --extra-cflags=3D-m32
> > >
> > > and it should be possible to build 32-bit binaries, too.
> > >
> > > Alternatively, we could add a cross-compilation job that builds with
> > > i686-w64-mingw32 in 32-bit.
> >
> > Oh, this case is covered:
> > https://app.shippable.com/github/qemu/qemu/runs/2437/2/console
> >
> > But this doesn't use KVM ;)
> >

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


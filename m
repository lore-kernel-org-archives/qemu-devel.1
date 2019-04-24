Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA72EC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FE42089F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FE42089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36074 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJAWD-0001ia-Ra
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 01:32:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAUa-0000n8-ER
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAUY-0004a8-9f
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:30:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:36206)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAUY-0004Xh-3M
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:30:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAUW-0002pt-CT
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:30:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5C1F52E80CC
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:30:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:25:22 -0000
From: Thomas Huth <1817525@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Tags: compilation gcc9 ppc64le
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell sathnaga th-huth
X-Launchpad-Bug-Reporter: Satheesh Rajendran (sathnaga)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <155108616330.22359.6416860237413372412.malonedeb@wampee.canonical.com>
Message-Id:
 <155608352297.14287.7791897477863980356.launchpad@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: b38f19edd5a923ca5b8b4e0fcad7a37ff8081e87
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1817525] Re: qemu fails to compile on gcc 9
 "block/nvme.c:209:22: error: taking address of packed member of 'struct
 <anonymous>' may result in an unaligned pointer value
 [-Werror=address-of-packed-member]"
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1817525 <1817525@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424052522.DFZzufi31tIxAapfMoUesLku7clQItTSIRJssAlKYkI@z>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1817525

Title:
  qemu fails to compile on gcc 9 "block/nvme.c:209:22: error: taking
  address of packed member of 'struct <anonymous>' may result in an
  unaligned pointer value [-Werror=3Daddress-of-packed-member]"

Status in QEMU:
  Fix Released

Bug description:
  Issue:
  Qemu compilation fails with below error on ppc64le host with gcc 9, repo(=
https://github.com/dgibson/qemu.git), branch(ppc-for-4.0), Commit (0483e903=
93bac8546a1fbc95ab912a1e78e92b00)

  =C2=A0CHK version_gen.h
  =C2=A0=C2=A0CC      block/nvme.o
  block/nvme.c: In function =E2=80=98nvme_create_queue_pair=E2=80=99:
  block/nvme.c:209:22: error: taking address of packed member of =E2=80=98s=
truct <anonymous>=E2=80=99 may result in an unaligned pointer value [-Werro=
r=3Daddress-of-packed-member]
  =C2=A0=C2=A0209 |     q->sq.doorbell =3D &s->regs->doorbells[idx * 2 * s-=
>doorbell_scale];
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|                      ^~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  block/nvme.c:216:22: error: taking address of packed member of =E2=80=98s=
truct <anonymous>=E2=80=99 may result in an unaligned pointer value [-Werro=
r=3Daddress-of-packed-member]
  =C2=A0=C2=A0216 |     q->cq.doorbell =3D &s->regs->doorbells[idx * 2 * s-=
>doorbell_scale + 1];
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|                      ^~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cc1: all warnings being treated as errors
  make: *** [/usr/share/avocado-plugins-vt/build/qemu/rules.mak:69: block/n=
vme.o] Error 1

  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  $git commit:
  commit 0483e90393bac8546a1fbc95ab912a1e78e92b00 (HEAD -> ppc-for-4.0)
  Author: Thomas Huth <thuth@redhat.com>
  Date:   Thu Feb 21 12:24:48 2019 +0100

  =C2=A0=C2=A0=C2=A0=C2=A0hw/ppc: Use object_initialize_child for correct r=
eference counting

  =C2=A0=C2=A0=C2=A0=C2=A0Both functions, object_initialize() and object_pr=
operty_add_child() increase
  =C2=A0=C2=A0=C2=A0=C2=A0the reference counter of the new object, so one o=
f the references has to be
  =C2=A0=C2=A0=C2=A0=C2=A0dropped afterwards to get the reference counting =
right. Otherwise the child
  =C2=A0=C2=A0=C2=A0=C2=A0object will not be properly cleaned up when the p=
arent gets destroyed.
  =C2=A0=C2=A0=C2=A0=C2=A0Thus let's use now object_initialize_child() inst=
ead to get the reference
  =C2=A0=C2=A0=C2=A0=C2=A0counting here right.

  =C2=A0=C2=A0=C2=A0=C2=A0Suggested-by: Eduardo Habkost <ehabkost@redhat.co=
m>
  =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Thomas Huth <thuth@redhat.com>
  =C2=A0=C2=A0=C2=A0=C2=A0Message-Id: <1550748288-30598-1-git-send-email-th=
uth@redhat.com>
  =C2=A0=C2=A0=C2=A0=C2=A0Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
  =C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: David Gibson <david@gibson.dropbea=
r.id.au>
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  Note: Same commit on a different ppc64le host with gcc(8.1.1 20180712)
  compile without any issue.

  Host Env:

  Power8

  #lscpu
  Architecture:         ppc64le
  Byte Order:           Little Endian
  CPU(s):               160
  On-line CPU(s) list:  0,8,16,24,32,40,48,56,64,72,80,88,96,104,112,120,12=
8,136,144,152
  Off-line CPU(s) list: 1-7,9-15,17-23,25-31,33-39,41-47,49-55,57-63,65-71,=
73-79,81-87,89-95,97-103,105-111,113-119,121-127,129-135,137-143,145-151,15=
3-159
  Thread(s) per core:   1
  Core(s) per socket:   5
  Socket(s):            4
  NUMA node(s):         4
  Model:                2.1 (pvr 004b 0201)
  Model name:           POWER8E (raw), altivec supported
  CPU max MHz:          3690.0000
  CPU min MHz:          2061.0000
  L1d cache:            64K
  L1i cache:            32K
  L2 cache:             512K
  L3 cache:             8192K
  NUMA node0 CPU(s):    0,8,16,24,32
  NUMA node1 CPU(s):    40,48,56,64,72
  NUMA node16 CPU(s):   80,88,96,104,112
  NUMA node17 CPU(s):   120,128,136,144,152

  # gcc --version
  gcc (GCC) 9.0.1 20190209 (Red Hat 9.0.1-0.4)
  Copyright (C) 2019 Free Software Foundation, Inc.
  This is free software; see the source for copying conditions.  There is NO
  warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.

  # uname -r
  5.0.0-rc7-ge50585e89

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1817525/+subscriptions


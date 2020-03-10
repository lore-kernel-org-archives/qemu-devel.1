Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C18C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 172B8222D9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172B8222D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBbmn-0000lH-7q
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jBbli-0000Ai-4O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jBblg-00076q-LR
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:05:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:47692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jBblg-0006ym-Ez
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:05:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jBble-0000hS-1P
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 10:05:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 018FA2E8029
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 10:05:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Mar 2020 09:57:12 -0000
From: Eilert <1866792@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: backhus
X-Launchpad-Bug-Reporter: Eilert (backhus)
X-Launchpad-Bug-Modifier: Eilert (backhus)
Message-Id: <158383423277.12441.11625227963369015627.malonedeb@soybean.canonical.com>
Subject: [Bug 1866792] [NEW] formating vdi-disk over nbd fails
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 25539c519ea2754b1f0727d65f5257cfcbf6f990
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1866792 <1866792@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hi,
after creating a vdi-image with qemu-vdi and attaching it with qemu-nbd par=
titioning works fine, but the system hangs up during formating with mkfs.ex=
t4.

Same procedure with qcow2-image works fine =

Tested on Fedora 31 kernel  5.5.7-200.fc31.x86_64


-----------------
#! /bin/sh

qemu-img create -f qcow2 ~/test.qcow2 32G
#qemu-img version 4.1.1 (qemu-4.1.1-1.fc31)

modprobe nbd max_part=3D8
qemu-nbd --connect=3D/dev/nbd2 ~/test.qcow2
#qemu-nbd 4.1.1 (qemu-4.1.1-1.fc31)

parted -s /dev/nbd2 "mklabel gpt"
parted -s -a optimal /dev/nbd2 "mkpart test ext4 2048 32G "
parted  -s -a optimal /dev/nbd2 "p"

mkfs.ext4 /dev/nbd2p1
#Format hangs up due to IO errors.
#Tested on Fedora 31, kernel 5.5.7-200.fc31.x86_64

mkdir /mnt/test_qcow2

mount /dev/nbd2p1 /mnt/test_qcow2
df -H

-------------------
#! /bin/sh

qemu-img create -f vdi ~/test.vdi 32G

modprobe nbd max_part=3D8
qemu-nbd --connect=3D/dev/nbd4 ~/test.vdi

parted -s /dev/nbd4 "mklabel gpt"
parted -s -a optimal /dev/nbd4 "mkpart test ext4 2048 32G "
parted  -s -a optimal /dev/nbd4 "p"

mkfs.ext4 /dev/nbd4p1
#Format hangs up due to IO errors =

#Tested on Fedora 31 kernel  5.5.7-200.fc31.x86_64

mkdir /mnt/test_vdi

mount /dev/nbd4p1 /mnt/test_vdi
df -H
----------------------


Kind regards
  Eilert

PS.: There may be a connection to this bug:
=E2=80=8B 	=

#1661758 qemu-nbd causes data corruption in VDI-format disk images

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "virtual_disk_vdi.sh"
   https://bugs.launchpad.net/bugs/1866792/+attachment/5335236/+files/virtu=
al_disk_vdi.sh

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1866792

Title:
  formating vdi-disk over nbd fails

Status in QEMU:
  New

Bug description:
  Hi,
  after creating a vdi-image with qemu-vdi and attaching it with qemu-nbd p=
artitioning works fine, but the system hangs up during formating with mkfs.=
ext4.

  Same procedure with qcow2-image works fine =

  Tested on Fedora 31 kernel  5.5.7-200.fc31.x86_64

  =

  -----------------
  #! /bin/sh

  qemu-img create -f qcow2 ~/test.qcow2 32G
  #qemu-img version 4.1.1 (qemu-4.1.1-1.fc31)

  modprobe nbd max_part=3D8
  qemu-nbd --connect=3D/dev/nbd2 ~/test.qcow2
  #qemu-nbd 4.1.1 (qemu-4.1.1-1.fc31)

  parted -s /dev/nbd2 "mklabel gpt"
  parted -s -a optimal /dev/nbd2 "mkpart test ext4 2048 32G "
  parted  -s -a optimal /dev/nbd2 "p"

  mkfs.ext4 /dev/nbd2p1
  #Format hangs up due to IO errors.
  #Tested on Fedora 31, kernel 5.5.7-200.fc31.x86_64

  mkdir /mnt/test_qcow2

  mount /dev/nbd2p1 /mnt/test_qcow2
  df -H

  -------------------
  #! /bin/sh

  qemu-img create -f vdi ~/test.vdi 32G

  modprobe nbd max_part=3D8
  qemu-nbd --connect=3D/dev/nbd4 ~/test.vdi

  parted -s /dev/nbd4 "mklabel gpt"
  parted -s -a optimal /dev/nbd4 "mkpart test ext4 2048 32G "
  parted  -s -a optimal /dev/nbd4 "p"

  mkfs.ext4 /dev/nbd4p1
  #Format hangs up due to IO errors =

  #Tested on Fedora 31 kernel  5.5.7-200.fc31.x86_64

  mkdir /mnt/test_vdi

  mount /dev/nbd4p1 /mnt/test_vdi
  df -H
  ----------------------

  =

  Kind regards
    Eilert

  PS.: There may be a connection to this bug:
  =E2=80=8B 	=

  #1661758 qemu-nbd causes data corruption in VDI-format disk images

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1866792/+subscriptions


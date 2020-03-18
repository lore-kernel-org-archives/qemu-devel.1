Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8FAC5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0444F2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 11:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0444F2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEXEW-0006fz-4S
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 07:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jEXDr-0006Gx-TN
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jEXDq-00074D-HN
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:50:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:48804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jEXDq-0006zR-Au
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 07:50:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jEXDn-0002Po-PG
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 11:50:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8A1132E80E1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 11:50:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Mar 2020 11:37:44 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1867519@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Confirmed; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: focal
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange mohamadh paelzer
X-Launchpad-Bug-Reporter: Mohammad Heib (mohamadh)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <158428174672.11238.3583143675239092561.malonedeb@soybean.canonical.com>
Message-Id: <158453146435.10748.1050705633553135844.malone@soybean.canonical.com>
Subject: [Bug 1867519] Re: qemu 4.2 segfaults on VF detach
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7dd4a569eacfa169c6da0627e3bb539c9d8cb890
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
Reply-To: Bug 1867519 <1867519@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

At the breaking function we have:

29      void notifier_remove(Notifier *notifier)
30      {
31          QLIST_REMOVE(notifier, node);
32      }


(gdb) p notifier
$1 =3D (Notifier *) 0x55d2f40c5078
(gdb) p *notifier
$2 =3D {notify =3D 0x0, node =3D {le_next =3D 0x0, le_prev =3D 0x0}}

And since QLIST_REMOVE is defined as:
140 #define QLIST_REMOVE(elm, field) do {                                  =
 \        =

141         if ((elm)->field.le_next !=3D NULL)                            =
   \        =

142                 (elm)->field.le_next->field.le_prev =3D                =
   \        =

143                     (elm)->field.le_prev;                              =
 \        =

144         *(elm)->field.le_prev =3D (elm)->field.le_next;                =
   \        =

145 } while (/*CONSTCOND*/0)

(gdb) p (notifier)->node.le_next
$5 =3D (struct Notifier *) 0x0
(gdb) p &(notifier->node)
$11 =3D (struct {...} *) 0x55d2f40c5080

There actually is a !=3D NULL check, might it have changed on the fly.
I need to look at it more thoroughly, but it should be enough to recognize =
a known issue.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1867519

Title:
  qemu 4.2 segfaults on VF detach

Status in QEMU:
  Fix Committed
Status in qemu package in Ubuntu:
  Confirmed

Bug description:
  After updating Ubuntu 20.04 to the Beta version, we get the following
  error and the virtual machines stucks when detaching PCI devices using
  virsh command:

  Error:
  error: Failed to detach device from /tmp/vf_interface_attached.xml
  error: internal error: End of file from qemu monitor

  steps to reproduce:
   1. create a VM over Ubuntu 20.04 (5.4.0-14-generic)
   2. attach PCI device to this VM (Mellanox VF for example)
   3. try to detaching  the PCI device using virsh command:
     a. create a pci interface xml file:
          =

        <hostdev mode=3D'subsystem' type=3D'pci' managed=3D'yes'>
        <driver name=3D'vfio'/>
        <source>
        <address type=3D'pci' domain=3D'0x0000' bus=3D'0x11' slot=3D'0x00' =
function=3D'0x2' />
        </source>
        </hostdev>
      =

     b.  #virsh detach-device <VM-Doman-name> <pci interface xml file>


  - Ubuntu release:
    Description:    Ubuntu Focal Fossa (development branch)
    Release:        20.04

  - Package ver:
    libvirt0:
    Installed: 6.0.0-0ubuntu3
    Candidate: 6.0.0-0ubuntu5
    Version table:
       6.0.0-0ubuntu5 500
          500 http://il.archive.ubuntu.com/ubuntu focal/main amd64 Packages
   *** 6.0.0-0ubuntu3 100
          100 /var/lib/dpkg/status

  - What you expected to happen: =

    PCI device detached without any errors.

  - What happened instead:
    getting the errors above and he VM stuck

  additional info:
  after downgrading the libvirt0 package and all the dependent packages to =
5.4 the previous, version, seems that the issue disappeared

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1867519/+subscriptions


Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39CDC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 01:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBCF20708
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 01:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBCF20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbDBV-00082x-1l
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 21:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbDAy-0007e6-3d
 for qemu-devel@nongnu.org; Tue, 19 May 2020 21:05:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:37214)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbDAw-0000kn-QB
 for qemu-devel@nongnu.org; Tue, 19 May 2020 21:05:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jbDAv-0002Gl-6Y
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 01:05:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2F4052E806D
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 01:05:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2020 00:59:34 -0000
From: chris pugmire <1879590@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: chrisp99
X-Launchpad-Bug-Reporter: chris pugmire (chrisp99)
X-Launchpad-Bug-Modifier: chris pugmire (chrisp99)
Message-Id: <158993637415.31242.3259652866813380059.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1879590] [NEW] Using qemu-system-sparc64 no network interface
 seems to exist
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d1f943458c0d4a308dff4ffef93ba03b29748d13
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 20:30:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1879590 <1879590@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Using boot command:

qemu-system-sparc64 -M niagara -L /home/chrisp/sparc/S10image/
-nographic -m 256 -drive
if=3Dpflash,readonly=3Don,file=3D/home/chrisp/sparc/S10image/disk.s10hw2

After I log into solaris system I see no network devices other than the loo=
pback device.
All the docs I can see suggest it should come up with a default network dev=
ice that allows communication via the hosts network. Host is ubuntu 64bit.  =


root@giant:/home/chrisp/sparc# qemu-system-sparc64 -version
QEMU emulator version 5.0.0
Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers


dladm show-link
ifconfig -a


ok boot
Loading ufs-file-system package 1.4 04 Aug 1995 13:02:54.
FCode UFS Reader 1.12 00/07/17 15:48:16.
Loading: /platform/SUNW,Sun-Fire-T2000/ufsboot
Loading: /platform/sun4v/ufsboot
SunOS Release 5.10 Version Generic_118822-23 64-bit
Copyright 1983-2005 Sun Microsystems, Inc.  All rights reserved.
Use is subject to license terms.
Hostname: unknown

unknown console login: root
Last login: Wed Feb  8 09:01:28 on console
Sun Microsystems Inc.   SunOS 5.10      Generic January 2005
# dladm show-link
# ifconfig -a
lo0: flags=3D2001000849<UP,LOOPBACK,RUNNING,MULTICAST,IPv4,VIRTUAL> mtu 823=
2 index 1
        inet 127.0.0.1 netmask ff000000

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1879590

Title:
  Using qemu-system-sparc64 no network interface seems to exist

Status in QEMU:
  New

Bug description:
  Using boot command:

  qemu-system-sparc64 -M niagara -L /home/chrisp/sparc/S10image/
  -nographic -m 256 -drive
  if=3Dpflash,readonly=3Don,file=3D/home/chrisp/sparc/S10image/disk.s10hw2

  After I log into solaris system I see no network devices other than the l=
oopback device.
  All the docs I can see suggest it should come up with a default network d=
evice that allows communication via the hosts network. Host is ubuntu 64bit=
.  =


  root@giant:/home/chrisp/sparc# qemu-system-sparc64 -version
  QEMU emulator version 5.0.0
  Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers

  =

  dladm show-link
  ifconfig -a


  ok boot
  Loading ufs-file-system package 1.4 04 Aug 1995 13:02:54.
  FCode UFS Reader 1.12 00/07/17 15:48:16.
  Loading: /platform/SUNW,Sun-Fire-T2000/ufsboot
  Loading: /platform/sun4v/ufsboot
  SunOS Release 5.10 Version Generic_118822-23 64-bit
  Copyright 1983-2005 Sun Microsystems, Inc.  All rights reserved.
  Use is subject to license terms.
  Hostname: unknown

  unknown console login: root
  Last login: Wed Feb  8 09:01:28 on console
  Sun Microsystems Inc.   SunOS 5.10      Generic January 2005
  # dladm show-link
  # ifconfig -a
  lo0: flags=3D2001000849<UP,LOOPBACK,RUNNING,MULTICAST,IPv4,VIRTUAL> mtu 8=
232 index 1
          inet 127.0.0.1 netmask ff000000

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1879590/+subscriptions


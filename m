Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1356DC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBC922D2C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBC922D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8msM-00026I-5i
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mlJ-0001Gp-VI
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:45:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:36468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mlG-0002mB-Fx
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:45:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k8mlD-0007o1-5K
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:45:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 076932E8110
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:45:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2020 15:39:47 -0000
From: Thomas Huth <1867519@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
 status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: focal
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange janitor mohamadh paelzer
X-Launchpad-Bug-Reporter: Mohammad Heib (mohamadh)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <158428174672.11238.3583143675239092561.malonedeb@soybean.canonical.com>
Message-Id: <159793798809.4725.11764228327633254726.launchpad@gac.canonical.com>
Subject: [Bug 1867519] Re: qemu 4.2 segfaults on VF detach
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 21db58316b77743c086595620bbf77abb247e049
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 10:50:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1867519 <1867519@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1867519

Title:
  qemu 4.2 segfaults on VF detach

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released

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


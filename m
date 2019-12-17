Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECC1C2D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:46:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3704721582
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3704721582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihCFR-0005FW-72
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 07:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ihCEX-0004TT-0A
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ihCEV-0008TB-MP
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:45:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:34776)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ihCEV-0008Sf-Gh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:45:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ihCER-0003cA-Hn
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 12:45:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B43202E80FF
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 12:45:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Dec 2019 12:32:15 -0000
From: Vasili <1851552@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=cloud-init; status=New; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: product=networking-calico; status=New; importance=Undecided; 
 assignee=None; 
X-Launchpad-Bug: product=nova; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: product=openstack-community; status=New; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug: product=qemu-kvm; status=New; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=cloud-init; component=main;
 status=Confirmed; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: daniel-thewatkins janitor legovini raharper smoser
 vasili.namatov
X-Launchpad-Bug-Reporter: Vasili (vasili.namatov)
X-Launchpad-Bug-Modifier: Vasili (vasili.namatov)
References: <157306761727.2702.10828795840242046904.malonedeb@gac.canonical.com>
Message-Id: <157658593537.27888.8722754371971862282.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1851552] Re: since ubuntu 18 bionic release and latest,
 the ubuntu18 cloud image is unable to boot up on openstack instance 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 839795d481c81019775835d874e9f4e0b72f5632
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1851552 <1851552@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Also affects: cloud-init
   Importance: Undecided
       Status: New

** Also affects: openstack-community
   Importance: Undecided
       Status: New

** Also affects: qemu
   Importance: Undecided
       Status: New

** Also affects: qemu-kvm
   Importance: Undecided
       Status: New

** Also affects: networking-calico
   Importance: Undecided
       Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1851552

Title:
  since ubuntu 18 bionic release and latest, the ubuntu18 cloud image is
  unable to boot up on openstack instance

Status in cloud-init:
  New
Status in networking-calico:
  New
Status in OpenStack Compute (nova):
  New
Status in OpenStack Community Project:
  New
Status in QEMU:
  New
Status in qemu-kvm:
  New
Status in cloud-init package in Ubuntu:
  Confirmed

Bug description:
  Openstack Queens release which is running on ubuntu 18 LTS Controller and=
 Compute.
  Tried to boot up the instance via horizon dashboard without success.
  Nova flow works perfect.
  When access to console I discovered that the boot process stuck in the mi=
ddle.
  [[0;1;31m TIME [0m] Timed out waiting for device dev-vdb.device.
  [[0;1;33mDEPEND[0m] Dependency failed for /mnt.
  [[0;1;33mDEPEND[0m] Dependency failed for File System Check on /dev/vdb.
  It receives IP but looks like not get configured at time.
  since ubuntu 18 there is netplan feature managing the network interfaces
  please advise.

  more details as follow:
  https://bugs.launchpad.net/networking-calico/+bug/1851548

To manage notifications about this bug go to:
https://bugs.launchpad.net/cloud-init/+bug/1851552/+subscriptions


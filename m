Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35DDC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CF2205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 15:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CF2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHr1v-0000DL-D3
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 11:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iHqzo-0006vr-S3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iHqzn-0001IN-BZ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:01:52 -0400
Received: from indium.canonical.com ([91.189.90.7]:39974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iHqzn-0001Hl-56
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 11:01:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iHqzl-0004VV-EN
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 15:01:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 69EAF2E80CE
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 15:01:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Oct 2019 14:47:57 -0000
From: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF?= <1633508@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: libvirt
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: havok4u paelzer th-huth
X-Launchpad-Bug-Reporter: Tim Epkes (havok4u)
X-Launchpad-Bug-Modifier: =?utf-8?q?Christian_Ehrhardt_=EE=83=BF_=28paelzer?=
 =?utf-8?q?=29?=
References: <20161014143633.7783.6982.malonedeb@gac.canonical.com>
Message-Id: <157054607755.22315.205061503565236664.malone@gac.canonical.com>
Subject: [Bug 1633508] Re: libvirt cannot hot insert interfaces to qemu
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 12a3877fc63d093e0740fc05b51e08856f0455b2
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
Reply-To: Bug 1633508 <1633508@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

That seems to be the Libvirt of Ubuntu in Xenial.

In the past similar issues were uncommon configs or changed behavior on
updates that triggered apparmor or SELinux protection.

=3D> https://bugs.launchpad.net/ubuntu/+source/libvirt/+bug/1747442
=3D> https://bugzilla.redhat.com/show_bug.cgi?id=3D731243

It could as well be some variant of bug 1677398.

If you are still affected by this, could you check:
1. if it also happens on newer libvirt versions e.g. do a trial run in the =
most recent Ubuntu
2. if it does could you check dmesg in your setup for related apparmor deni=
als?


** Bug watch added: Red Hat Bugzilla #731243
   https://bugzilla.redhat.com/show_bug.cgi?id=3D731243

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1633508

Title:
  libvirt cannot hot insert interfaces to qemu

Status in QEMU:
  Incomplete

Bug description:
  When attempting to hot insert an interface using Ubuntu 16.04.1, I get th=
e following
  $ virsh attach-interface --domain gluster1 --type direct \
  >         --source test0 --model virtio \
  >         --mac 2a:b6:b0:dc:c7:c4 --config --live
  error: Failed to attach interface
  error: internal error: unable to execute QEMU command 'getfd': No file de=
scriptor supplied via SCM_RIGHTS

  test0 exists:
  $ ip link show test0
  35: test0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast =
state DOWN mode DEFAULT group default qlen 1000
      link/ether aa:8c:65:2e:79:61 brd ff:ff:ff:ff:ff:ff

  Just in case I did it wrong with direct, I did network
  $ virsh net-list
   Name                 State      Autostart     Persistent
  ----------------------------------------------------------
   default              active     yes           yes
   mgmtnet0             active     yes           yes

  $ virsh attach-interface --domain gluster1 --type network \
  >         --source default --model virtio \
  >         --mac 2a:b6:b0:dc:c7:c4 --config --live
  error: Failed to attach interface
  error: internal error: unable to execute QEMU command 'getfd': No file de=
scriptor supplied via SCM_RIGHTS

  =

  This seems to be an old bug, but is still present.  Other relevant inform=
ation:
  $ qemu-system-x86_64 --version
  QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.5), Copyright (c=
) 2003-2008 Fabrice Bellard
  $ virsh -v
  1.3.1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1633508/+subscriptions


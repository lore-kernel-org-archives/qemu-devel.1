Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F970C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 11:08:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 742AF216F4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 11:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742AF216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEtXh-0005qC-IP
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 07:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iEtWS-0004zy-PM
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 07:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iEtWR-0001yR-KO
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 07:07:20 -0400
Received: from indium.canonical.com ([91.189.90.7]:60124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iEtWR-0001yB-FA
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 07:07:19 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iEtWP-00031e-Sw
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 11:07:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B110F2E80CC
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 11:07:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Sep 2019 10:58:43 -0000
From: Thomas Huth <1633508@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: libvirt
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: havok4u th-huth
X-Launchpad-Bug-Reporter: Tim Epkes (havok4u)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20161014143633.7783.6982.malonedeb@gac.canonical.com>
Message-Id: <156984112379.11375.17922477998911764239.malone@soybean.canonical.com>
Subject: [Bug 1633508] Re: libvirt cannot hot insert interfaces to qemu
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19065";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ac223f706e2b1ef6acbe14d3e1f2dda96c919eaf
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

This looks like a libvirt bug at a first glance. Have you tried to
report it to the libvirt project? (See https://libvirt.org/bugs.html )
... also, can you re-create the bug with the very latest upstream
version of libvirt and qemu, or does it only occur with an (older?)
version of Ubuntu?

** Changed in: qemu
       Status: New =3D> Incomplete

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


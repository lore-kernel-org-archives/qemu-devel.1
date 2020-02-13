Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81417C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 568F820873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 568F820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Dxe-000533-Hq
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j2Dx0-0004U6-IP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j2Dwy-00047r-Rz
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:50:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:38464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j2Dwy-00047D-Lw
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:50:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j2Dwx-0006ng-2l
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 12:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0F6832E80C3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 12:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Feb 2020 12:42:35 -0000
From: Cheng Jiang <1863096@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: chengjiang
X-Launchpad-Bug-Reporter: Cheng Jiang (chengjiang)
X-Launchpad-Bug-Modifier: Cheng Jiang (chengjiang)
Message-Id: <158159775529.28653.1884388369388986202.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1863096] [NEW] vhost-user multi-queues interrupt failed when
 Qemu reconnection happens
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 7507caa2ca503eef65fbe2479285e517f6560d87
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
Reply-To: Bug 1863096 <1863096@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

After upgrade qemu to v4.2.0, vhost-user multi-queues interrupt failed
with event idx interrupt mode when reconnection happens.

Test Environment:
DPDK version: DPDK v19.11
Other software versions: qemu 4.2.0.
OS: Linux 4.15.0-20-generic
Compiler: gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
Hardware platform: Purley.

The reproduce step is:
1. Launch l3fwd-power example app with client mode::

    ./l3fwd-power -l 1-16 \
    -n 4 --socket-mem 1024,1024 --legacy-mem --no-pci\
    --log-level=3D9 \
    --vdev 'eth_vhost0,iface=3D/vhost-net0,queues=3D16,client=3D1' \
    -- -p 0x1 \
    --parse-ptype 1 \
    --config "(0,0,1),(0,1,2),(0,2,3),(0,3,4),(0,4,5),(0,5,6),(0,6,7),(0,7,=
8),(0,8,9),(0,9,10),(0,10,11),(0,11,12),(0,12,13),(0,13,14),(0,14,15),(0,15=
,16)"

2. Launch VM1 with server mode:

3. Relauch l3fwd-power sample to for reconnection:

    ./l3fwd-power -l 1-16 \
    -n 4 --socket-mem 1024,1024 --legacy-mem --no-pci\
    --log-level=3D9 \
    --vdev 'eth_vhost0,iface=3D/vhost-net0,queues=3D16,client=3D1' \
    -- -p 0x1 \
    --parse-ptype 1 \
    --config "(0,0,1),(0,1,2),(0,2,3),(0,3,4),(0,4,5),(0,5,6),(0,6,7),(0,7,=
8),(0,8,9),(0,9,10),(0,10,11),(0,11,12),(0,12,13),(0,13,14),(0,14,15),(0,15=
,16)"

4. Set vitio-net with 16 quques and give vitio-net ip address:

    ethtool -L [ens3] combined 16    # [ens3] is the name of virtio-net
    ifconfig [ens3] 1.1.1.1

5. Send packets with different IPs from virtio-net, notice to bind each
vcpu to different send packets process::

    taskset -c 0 ping 1.1.1.2
    taskset -c 1 ping 1.1.1.3
    taskset -c 2 ping 1.1.1.4
    taskset -c 3 ping 1.1.1.5
    taskset -c 4 ping 1.1.1.6
    taskset -c 5 ping 1.1.1.7
    taskset -c 6 ping 1.1.1.8
    taskset -c 7 ping 1.1.1.9
    taskset -c 8 ping 1.1.1.2
    taskset -c 9 ping 1.1.1.2
    taskset -c 10 ping 1.1.1.2
    taskset -c 11 ping 1.1.1.2
    taskset -c 12 ping 1.1.1.2
    taskset -c 13 ping 1.1.1.2
    taskset -c 14 ping 1.1.1.2
    taskset -c 15 ping 1.1.1.2

If everything ok, then we can see the result such as following:

    L3FWD_POWER: lcore 0 is waked up from rx interrupt on port 0 queue 0
    ...
    ...
    L3FWD_POWER: lcore 15 is waked up from rx interrupt on port 0 queue 15

But we can't see the log above because of the bug.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863096

Title:
  vhost-user multi-queues interrupt failed when Qemu reconnection
  happens

Status in QEMU:
  New

Bug description:
  After upgrade qemu to v4.2.0, vhost-user multi-queues interrupt failed
  with event idx interrupt mode when reconnection happens.

  Test Environment:
  DPDK version: DPDK v19.11
  Other software versions: qemu 4.2.0.
  OS: Linux 4.15.0-20-generic
  Compiler: gcc (Ubuntu 7.3.0-16ubuntu3) 7.3.0
  Hardware platform: Purley.

  The reproduce step is:
  1. Launch l3fwd-power example app with client mode::

      ./l3fwd-power -l 1-16 \
      -n 4 --socket-mem 1024,1024 --legacy-mem --no-pci\
      --log-level=3D9 \
      --vdev 'eth_vhost0,iface=3D/vhost-net0,queues=3D16,client=3D1' \
      -- -p 0x1 \
      --parse-ptype 1 \
      --config "(0,0,1),(0,1,2),(0,2,3),(0,3,4),(0,4,5),(0,5,6),(0,6,7),(0,=
7,8),(0,8,9),(0,9,10),(0,10,11),(0,11,12),(0,12,13),(0,13,14),(0,14,15),(0,=
15,16)"

  2. Launch VM1 with server mode:

  3. Relauch l3fwd-power sample to for reconnection:

      ./l3fwd-power -l 1-16 \
      -n 4 --socket-mem 1024,1024 --legacy-mem --no-pci\
      --log-level=3D9 \
      --vdev 'eth_vhost0,iface=3D/vhost-net0,queues=3D16,client=3D1' \
      -- -p 0x1 \
      --parse-ptype 1 \
      --config "(0,0,1),(0,1,2),(0,2,3),(0,3,4),(0,4,5),(0,5,6),(0,6,7),(0,=
7,8),(0,8,9),(0,9,10),(0,10,11),(0,11,12),(0,12,13),(0,13,14),(0,14,15),(0,=
15,16)"

  4. Set vitio-net with 16 quques and give vitio-net ip address:

      ethtool -L [ens3] combined 16    # [ens3] is the name of virtio-net
      ifconfig [ens3] 1.1.1.1

  5. Send packets with different IPs from virtio-net, notice to bind
  each vcpu to different send packets process::

      taskset -c 0 ping 1.1.1.2
      taskset -c 1 ping 1.1.1.3
      taskset -c 2 ping 1.1.1.4
      taskset -c 3 ping 1.1.1.5
      taskset -c 4 ping 1.1.1.6
      taskset -c 5 ping 1.1.1.7
      taskset -c 6 ping 1.1.1.8
      taskset -c 7 ping 1.1.1.9
      taskset -c 8 ping 1.1.1.2
      taskset -c 9 ping 1.1.1.2
      taskset -c 10 ping 1.1.1.2
      taskset -c 11 ping 1.1.1.2
      taskset -c 12 ping 1.1.1.2
      taskset -c 13 ping 1.1.1.2
      taskset -c 14 ping 1.1.1.2
      taskset -c 15 ping 1.1.1.2

  If everything ok, then we can see the result such as following:

      L3FWD_POWER: lcore 0 is waked up from rx interrupt on port 0 queue 0
      ...
      ...
      L3FWD_POWER: lcore 15 is waked up from rx interrupt on port 0 queue 15

  But we can't see the log above because of the bug.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863096/+subscriptions


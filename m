Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9C9C55178
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3464220702
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3464220702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbhHh-0005o7-8C
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 04:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbhGa-0004TZ-Hr
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:45:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:57454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbhGY-0001og-IR
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:45:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbhGX-0000ae-EI
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:45:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6A2322E811E
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 09:45:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 09:36:22 -0000
From: Thomas Huth <1642421@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mail-wz6bkyhu4uqpfausw0ege9b0y3 rodrivg th-huth
X-Launchpad-Bug-Reporter: manut (mail-wz6bkyhu4uqpfausw0ege9b0y3)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20161116225238.8681.9123.malonedeb@gac.canonical.com>
Message-Id: <160482818298.28244.16570311093552108179.malone@chaenomeles.canonical.com>
Subject: [Bug 1642421] Re: qemu-system-x86_64: ipv6 and dns is broken with
 netdev user
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 8a9dde9b3c500e60573508ac22f2c429440ddad4
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 04:10:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1642421 <1642421@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project is currently considering to move its bug tracking to anoth=
er system. For this we need to know which bugs are still valid and which co=
uld be closed already. Thus we are setting all older bugs to
"Incomplete" now.
If you still think this bug report here is valid, then please switch the st=
ate back to "New" within the next 60 days, otherwise this report will be ma=
rked as "Expired". Thank you and sorry for the inconvenience.


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1642421

Title:
  qemu-system-x86_64: ipv6 and dns is broken with netdev user

Status in QEMU:
  Incomplete

Bug description:
  Hi,

  dhcp inside qemu returns an ipv6 address as dns-server. However this is n=
ot
  working. If i replace it with the ipv4 address '10.0.0.2' dns is working
  again. I would expect that the qemu emulated dhcp server responds either =
an
  ipv4 configuration that is working or its dns server/forwarder listens on=
 the
  ipv6 address returned by the emulated dhcp server.

  I used latest qemu from git (
  b0bcc86d2a87456f5a276f941dc775b265b309cf) and used the following
  commands:

  $ ./qemu-system-x86_64 -enable-kvm -M pc -device virtio-rng-pci -device
  virtio-net-pci,netdev=3Duser.0 -drive file=3Dbuildenv.img,if=3Dvirtio,bus=
=3D1,unit=3D0
  -no-reboot -netdev user,id=3Duser.0,hostfwd=3Dtcp::5022-:22,hostfwd=3Dtcp=
::7587-:7588
  -m 1024 -usb -nographic -smp 4

  buildenv.img is a debian jessie amd64 installation.

  Inside qemu the network is configured to use dhcp:

  $ cat /etc/network/interfaces
  allow-hotplug eth0
  iface eth0 inet dhcp

  $ ifconfig eth0
  eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
            inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
            inet6 addr: fe80::5054:ff:fe12:3456/64 Scope:Link
            inet6 addr: fec0::5054:ff:fe12:3456/64 Scope:Site
            UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
            RX packets:10 errors:0 dropped:0 overruns:0 frame:0
            TX packets:28 errors:0 dropped:0 overruns:0 carrier:0
            collisions:0 txqueuelen:1000
            RX bytes:3215 (3.1 KiB)  TX bytes:3638 (3.5 KiB)

  $ cat /etc/resolv.conf
  nameserver fec0::3

  $ arp google.de
  google.de: Host name lookup failure

  $ strace -f arp google.de
  ...
  socket(PF_INET6, SOCK_DGRAM|SOCK_NONBLOCK, IPPROTO_IP) =3D 4
  connect(4, {sa_family=3DAF_INET6, sin6_port=3Dhtons(53), inet_pton(AF_INE=
T6, "fec0::3", &sin6_addr), sin6_flowinfo=3D0, sin6_scope_id=3D0}, 28) =3D 0
  poll([{fd=3D4, events=3DPOLLOUT}], 1, 0)    =3D 1 ([{fd=3D4, revents=3DPO=
LLOUT}])
  sendto(4, "\17\320\1\0\0\1\0\0\0\0\0\0\6google\2de\0\0\1\0\1", 27, MSG_NO=
SIGNAL, NULL, 0) =3D 27
  poll([{fd=3D4, events=3DPOLLIN}], 1, 5000)  =3D 0 (Timeout)
  poll([{fd=3D4, events=3DPOLLOUT}], 1, 0)    =3D 1 ([{fd=3D4, revents=3DPO=
LLOUT}])
  sendto(4, "\17\320\1\0\0\1\0\0\0\0\0\0\6google\2de\0\0\1\0\1", 27, MSG_NO=
SIGNAL, NULL, 0) =3D 27
  poll([{fd=3D4, events=3DPOLLIN}], 1, 5000)  =3D 0 (Timeout)
  close(4)                                =3D 0
  ...

  $ echo nameserver 10.0.0.2 > /etc/resolv.conf

  $ arp google.de
  google.de (216.58.208.35) -- no entry

  Note: I reported this bug also to debian: https://bugs.debian.org/cgi-
  bin/bugreport.cgi?bug=3D844566

  Regards,

    Manuel

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1642421/+subscriptions


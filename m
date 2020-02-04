Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DF5C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8E22082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 14:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8E22082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyzXq-0005Oq-8H
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 09:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iyzXC-0004wH-LJ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:50:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iyzXB-00077h-9H
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:50:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:39954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iyzXB-0006xp-2w
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 09:50:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iyzX9-0002yu-K9
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 14:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 974632E802B
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 14:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Feb 2020 14:40:33 -0000
From: Maarten <1861875@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: mvgijssel
X-Launchpad-Bug-Reporter: Maarten (mvgijssel)
X-Launchpad-Bug-Modifier: Maarten (mvgijssel)
References: <158082639262.26675.4971489062247211077.malonedeb@soybean.canonical.com>
Message-Id: <158082723344.8247.14571828801571348763.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1861875] Re: VDE networking barely working 
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 105b9cf0e8422def15da17f094ef9f89e50b4a4b
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
Reply-To: Bug 1861875 <1861875@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  Running qemu with a vde_switch and slirpvde:
  =

  =C2=A0=C2=A0vde_switch -F -sock /tmp/qemu_vde_switch -M /tmp/qemu_vde_mgmt
  =C2=A0=C2=A0slirpvde -s /tmp/qemu_vde_switch -dhcp
- =C2=A0=C2=A0qemu-system-x86_64 -m 2048 -smp 2 -serial mon:stdio -display =
none =

-     -vga none -nodefaults -accel hax
-     -net nic,macaddr=3D52:54:00:0e:e0:61,model=3Dvirtio
-     -net vde,sock=3D/tmp/qemu_vde_switch -device virtio-rng-pci
-     -drive file=3Dworker.qcow2,if=3Dvirtio
-     -drive file=3Dcloud-init.iso,format=3Draw,if=3Dvirtio
+ =C2=A0=C2=A0qemu-system-x86_64 -m 2048 -smp 2 -serial mon:stdio -display =
none -vga none -nodefaults -accel hax -net nic,macaddr=3D52:54:00:0e:e0:61,=
model=3Dvirtio -net vde,sock=3D/tmp/qemu_vde_switch -device virtio-rng-pci =
-drive file=3Dworker.qcow2,if=3Dvirtio -drive file=3Dcloud-init.iso,format=
=3Draw,if=3Dvirtio
  =

  There is some network connectivity, ping and curl work, but bigger
- transfers like apt-get update break with the following errors printed in
- the output of vde_switch:
+ transfers like apt-get update or iperf break with the following errors
+ printed in the output of vde_switch:
  =

  =C2=A0=C2=A0vde_switch: send_sockaddr port 2: No buffer space available
  =C2=A0=C2=A0vde_switch: send_sockaddr port 2: No buffer space available
  =C2=A0=C2=A0vde_switch: send_sockaddr port 2: No buffer space available
  =

  I've tried to change the MTU size and model of the adapter inside of the
  VM, but nothing worked.
  =

  OS: macOS 10.15.2
  qemu: 4.2.0
  vde2 (vde_switch / slirpvde): 2.3.2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861875

Title:
  VDE networking barely working

Status in QEMU:
  New

Bug description:
  Running qemu with a vde_switch and slirpvde:

  =C2=A0=C2=A0vde_switch -F -sock /tmp/qemu_vde_switch -M /tmp/qemu_vde_mgmt
  =C2=A0=C2=A0slirpvde -s /tmp/qemu_vde_switch -dhcp
  =C2=A0=C2=A0qemu-system-x86_64 -m 2048 -smp 2 -serial mon:stdio -display =
none -vga none -nodefaults -accel hax -net nic,macaddr=3D52:54:00:0e:e0:61,=
model=3Dvirtio -net vde,sock=3D/tmp/qemu_vde_switch -device virtio-rng-pci =
-drive file=3Dworker.qcow2,if=3Dvirtio -drive file=3Dcloud-init.iso,format=
=3Draw,if=3Dvirtio

  There is some network connectivity, ping and curl work, but bigger
  transfers like apt-get update or iperf break with the following errors
  printed in the output of vde_switch:

  =C2=A0=C2=A0vde_switch: send_sockaddr port 2: No buffer space available
  =C2=A0=C2=A0vde_switch: send_sockaddr port 2: No buffer space available
  =C2=A0=C2=A0vde_switch: send_sockaddr port 2: No buffer space available

  I've tried to change the MTU size and model of the adapter inside of
  the VM, but nothing worked.

  OS: macOS 10.15.2
  qemu: 4.2.0
  vde2 (vde_switch / slirpvde): 2.3.2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861875/+subscriptions


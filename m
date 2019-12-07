Return-Path: <SRS0=SuvF=Z5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ABEC43603
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 17:24:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF5DC24670
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Dec 2019 17:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5DC24670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iddoV-0005aU-SU
	for qemu-devel@archiver.kernel.org; Sat, 07 Dec 2019 12:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iddnQ-0004iM-Tw
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 12:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iddnP-0005Nf-Gc
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 12:23:08 -0500
Received: from indium.canonical.com ([91.189.90.7]:55870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iddnP-0005Lk-AP
 for qemu-devel@nongnu.org; Sat, 07 Dec 2019 12:23:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1idZhR-0008Hs-1S
 for <qemu-devel@nongnu.org>; Sat, 07 Dec 2019 13:00:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 083B32E8073
 for <qemu-devel@nongnu.org>; Sat,  7 Dec 2019 13:00:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Dec 2019 12:51:22 -0000
From: Leonardo <1855535@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: aix fwd port
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: leohori
X-Launchpad-Bug-Reporter: Leonardo (leohori)
X-Launchpad-Bug-Modifier: Leonardo (leohori)
Message-Id: <157572308250.7047.10873331100308147678.malonedeb@gac.canonical.com>
Subject: [Bug 1855535] [NEW] Connection reset by peer when using port fwd
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c879b6ed5bb217b894b78288e25cd5e73a9c5c2f
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
Reply-To: Bug 1855535 <1855535@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

$ qemu-system-ppc64 -cpu POWER8,compat=3Dpower7 -machine pseries -m 8G -smp=
 cores=3D8 -serial mon:stdio -nographic \
-drive file=3D/qemu/aix72.img,if=3Dnone,id=3Ddrive-virtio-disk0 \
-device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Ddrive-virtio-disk=
0 \
-cdrom /qemu/aix72.iso \
-prom-env boot-command=3D'boot disk:' \
-name ctsprod -k es \
-netdev user,id=3Dnetdev0,hostfwd=3Dtcp:127.0.0.1:2222-:22 \
-device virtio-net-pci,netdev=3Dnetdev0 \
-netdev bridge,id=3Dhostnet0,br=3Dvirbr0 \
-device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:96:2f:7a \
-device virtio-net,netdev=3Dvmnic -netdev tap,id=3Dvmnic,ifname=3Dvnet0,scr=
ipt=3Dno,downscript=3Dno \
-monitor telnet:127.0.0.1:5801,server,nowait,nodelay


$ ssh -p 2222 root@127.0.0.1 -v

OpenSSH_7.6p1 Ubuntu-4ubuntu0.3, OpenSSL 1.0.2n  7 Dec 2017
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: /etc/ssh/ssh_config line 19: Applying options for *
debug1: Connecting to 127.0.0.1 [127.0.0.1] port 2222.
debug1: Connection established.
debug1: permanently_set_uid: 0/0
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_rsa type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_rsa-cert type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_dsa type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_dsa-cert type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_ecdsa type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_ecdsa-cert type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_ed25519 type -1
debug1: key_load_public: No such file or directory
debug1: identity file /root/.ssh/id_ed25519-cert type -1
debug1: Local version string SSH-2.0-OpenSSH_7.6p1 Ubuntu-4ubuntu0.3
ssh_exchange_identification: read: Connection reset by peer

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: aix fwd port

** Tags added: aix

** Tags added: fwd port

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1855535

Title:
  Connection reset by peer when using port fwd

Status in QEMU:
  New

Bug description:
  $ qemu-system-ppc64 -cpu POWER8,compat=3Dpower7 -machine pseries -m 8G -s=
mp cores=3D8 -serial mon:stdio -nographic \
  -drive file=3D/qemu/aix72.img,if=3Dnone,id=3Ddrive-virtio-disk0 \
  -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Ddrive-virtio-di=
sk0 \
  -cdrom /qemu/aix72.iso \
  -prom-env boot-command=3D'boot disk:' \
  -name ctsprod -k es \
  -netdev user,id=3Dnetdev0,hostfwd=3Dtcp:127.0.0.1:2222-:22 \
  -device virtio-net-pci,netdev=3Dnetdev0 \
  -netdev bridge,id=3Dhostnet0,br=3Dvirbr0 \
  -device virtio-net-pci,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:96:2f:7=
a \
  -device virtio-net,netdev=3Dvmnic -netdev tap,id=3Dvmnic,ifname=3Dvnet0,s=
cript=3Dno,downscript=3Dno \
  -monitor telnet:127.0.0.1:5801,server,nowait,nodelay

  =

  $ ssh -p 2222 root@127.0.0.1 -v

  OpenSSH_7.6p1 Ubuntu-4ubuntu0.3, OpenSSL 1.0.2n  7 Dec 2017
  debug1: Reading configuration data /etc/ssh/ssh_config
  debug1: /etc/ssh/ssh_config line 19: Applying options for *
  debug1: Connecting to 127.0.0.1 [127.0.0.1] port 2222.
  debug1: Connection established.
  debug1: permanently_set_uid: 0/0
  debug1: key_load_public: No such file or directory
  debug1: identity file /root/.ssh/id_rsa type -1
  debug1: key_load_public: No such file or directory
  debug1: identity file /root/.ssh/id_rsa-cert type -1
  debug1: key_load_public: No such file or directory
  debug1: identity file /root/.ssh/id_dsa type -1
  debug1: key_load_public: No such file or directory
  debug1: identity file /root/.ssh/id_dsa-cert type -1
  debug1: key_load_public: No such file or directory
  debug1: identity file /root/.ssh/id_ecdsa type -1
  debug1: key_load_public: No such file or directory
  debug1: identity file /root/.ssh/id_ecdsa-cert type -1
  debug1: key_load_public: No such file or directory
  debug1: identity file /root/.ssh/id_ed25519 type -1
  debug1: key_load_public: No such file or directory
  debug1: identity file /root/.ssh/id_ed25519-cert type -1
  debug1: Local version string SSH-2.0-OpenSSH_7.6p1 Ubuntu-4ubuntu0.3
  ssh_exchange_identification: read: Connection reset by peer

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1855535/+subscriptions


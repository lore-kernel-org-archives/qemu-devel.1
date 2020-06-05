Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99923C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C09A2065C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 12:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C09A2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhBfJ-0004V0-KH
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 08:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jhBed-0003hC-B8
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:40:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:51290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jhBeb-0002Pr-4B
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 08:40:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jhBeX-00064M-Cd
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 12:40:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 264BB2E8107
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2020 12:40:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2020 12:30:39 -0000
From: timsoft <1882241@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: i82551
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: tim-tree-of-life
X-Launchpad-Bug-Reporter: timsoft (tim-tree-of-life)
X-Launchpad-Bug-Modifier: timsoft (tim-tree-of-life)
Message-Id: <159136023930.32294.17616621945608188739.malonedeb@gac.canonical.com>
Subject: [Bug 1882241] [NEW] file transfer over cifs to 64bit guest corrupts
 large files
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="ef9fc486e875d54078fa61cf91e898b895125d89";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 219de917e7f32009d15601a99fc1382909f9124e
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 04:10:55
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
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
Reply-To: Bug 1882241 <1882241@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

qemu 4.0 compiled fom source.
vm called by
qemu-system-x86_64 -cpu qemu64 -smp 4 -m 4G -drive file=3D/data/images/slac=
k14.2_64bit_test.qcow2,format=3Dqcow2 -cdrom /mnt/smb1/slackware/iso/slackw=
are64-14.2-install-dvd.iso -boot c -net nic,macaddr=3D02:00:00:11:11:17,mod=
el=3Di82551 -net bridge,br=3Dbr0 -enable-kvm -k en-gb -display vnc=3D:3 -mo=
nitor telnet:localhost:7103,server,nowait,nodelay

copying large files eg 2.4gb or reading them on a cifs mount in the guest c=
auses corruption every time. For smaller files 40-60mb corruption is more t=
han 50% of the time. tested by md5sum on cifs server, or on host machine vs=
. on guest vm.
corruption is seen only with 64bit guest using cifs with i82551 emulated ne=
twork device
ie. 32bit guest using cifs with i82551 emulated network device gives no cor=
ruption.

changing the emulated device to vmxnet3 removes the data corruption (see
below)

qemu-system-x86_64 -cpu qemu64 -smp 4 -m 4G -drive
file=3D/data/images/slack14.2_64bit_test.qcow2,format=3Dqcow2 -cdrom
/mnt/smb1/slackware/iso/slackware64-14.2-install-dvd.iso -boot c -net
nic,macaddr=3D02:00:00:11:11:17,model=3Dvmxnet3 -net bridge,br=3Dbr0 -enabl=
e-
kvm -k en-gb -display vnc=3D:3 -monitor
telnet:localhost:7103,server,nowait,nodelay

this corruption is repeatable. ie. I created new vm, call using top example=
, installed 64bit linux, mounted cifs share and copied 2.4gb file to /tmp t=
hen run md5sum "filecopied"
the md5sum is different every time. copy same file to the host, or to a 32b=
it guest with the same virtual network device and bridge and md5sums are co=
rrect. The host pysical network adapter is
lspci|grep Ether
1e:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8=
411 PCI Express Gigabit Ethernet Controller (rev 11)

physically connected via gigabit ethernet to cifs server (via gigabit
switch)

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: i82551

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1882241

Title:
  file transfer over cifs to 64bit guest corrupts large files

Status in QEMU:
  New

Bug description:
  qemu 4.0 compiled fom source.
  vm called by
  qemu-system-x86_64 -cpu qemu64 -smp 4 -m 4G -drive file=3D/data/images/sl=
ack14.2_64bit_test.qcow2,format=3Dqcow2 -cdrom /mnt/smb1/slackware/iso/slac=
kware64-14.2-install-dvd.iso -boot c -net nic,macaddr=3D02:00:00:11:11:17,m=
odel=3Di82551 -net bridge,br=3Dbr0 -enable-kvm -k en-gb -display vnc=3D:3 -=
monitor telnet:localhost:7103,server,nowait,nodelay

  copying large files eg 2.4gb or reading them on a cifs mount in the guest=
 causes corruption every time. For smaller files 40-60mb corruption is more=
 than 50% of the time. tested by md5sum on cifs server, or on host machine =
vs. on guest vm.
  corruption is seen only with 64bit guest using cifs with i82551 emulated =
network device
  ie. 32bit guest using cifs with i82551 emulated network device gives no c=
orruption.

  changing the emulated device to vmxnet3 removes the data corruption
  (see below)

  qemu-system-x86_64 -cpu qemu64 -smp 4 -m 4G -drive
  file=3D/data/images/slack14.2_64bit_test.qcow2,format=3Dqcow2 -cdrom
  /mnt/smb1/slackware/iso/slackware64-14.2-install-dvd.iso -boot c -net
  nic,macaddr=3D02:00:00:11:11:17,model=3Dvmxnet3 -net bridge,br=3Dbr0
  -enable-kvm -k en-gb -display vnc=3D:3 -monitor
  telnet:localhost:7103,server,nowait,nodelay

  this corruption is repeatable. ie. I created new vm, call using top examp=
le, installed 64bit linux, mounted cifs share and copied 2.4gb file to /tmp=
 then run md5sum "filecopied"
  the md5sum is different every time. copy same file to the host, or to a 3=
2bit guest with the same virtual network device and bridge and md5sums are =
correct. The host pysical network adapter is
  lspci|grep Ether
  1e:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168=
/8411 PCI Express Gigabit Ethernet Controller (rev 11)

  physically connected via gigabit ethernet to cifs server (via gigabit
  switch)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1882241/+subscriptions


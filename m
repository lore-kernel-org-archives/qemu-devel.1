Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA91FC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:31:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE40E2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE40E2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Cl7-0004db-Va
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k9CkU-0004DA-GV
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:30:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:35652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k9CkS-0008Tz-DU
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:30:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k9CkQ-0005Dh-PT
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 19:30:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B9B042E80DC
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 19:30:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2020 19:24:09 -0000
From: Yonggang Luo <1892541@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: luoyonggang
X-Launchpad-Bug-Reporter: Yonggang Luo (luoyonggang)
X-Launchpad-Bug-Modifier: Yonggang Luo (luoyonggang)
Message-Id: <159803784913.1330.10602234543815325007.malonedeb@wampee.canonical.com>
Subject: [Bug 1892541] [NEW] qemu 5.1 on windows 10 with whpx can not install
 Windows 7 guest
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: adecd735e9351f1014b7695e1792900ae8b2c5c8
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 13:35:28
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
Reply-To: Bug 1892541 <1892541@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Command install and start win7

qemu-system-x86_64  -smbios type=3D1,uuid=3De77aacd6-0acb-4a5c-9a83-a80d029=
b36f1 -smp 2,sockets=3D1,cores=3D2,maxcpus=3D2 -nodefaults -boot menu=3Don,=
strict=3Don,reboot-timeout=3D1000 -m 8192 ^
-readconfig pve-q35-4.0.cfg ^
-device vmgenid,guid=3D6d4865f5-353e-4cf1-b8ca-f5abbd062736 -device usb-tab=
let,id=3Dtablet,bus=3Dehci.0,port=3D1 -device VGA,id=3Dvga,bus=3Dpcie.0,add=
r=3D0x1 ^
-device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x3 ^
-drive file=3Den_windows_7_ultimate_with_sp1_x64_dvd_u_677332.iso,if=3Dnone=
,id=3Ddrive-ide2,media=3Dcdrom,aio=3Dthreads ^
-device ide-cd,bus=3Dide.1,unit=3D0,drive=3Ddrive-ide2,id=3Dide2,bootindex=
=3D200 -device ahci,id=3Dahci0,multifunction=3Don,bus=3Dpci.0,addr=3D0x7 ^
-drive id=3Ddrive-sata0,if=3Dnone,file=3Dwin7.qcow2,format=3Dqcow2,cache=3D=
none,aio=3Dnative,detect-zeroes=3Don ^
-device ide-hd,bus=3Dahci0.0,drive=3Ddrive-sata0,id=3Dsata0,bootindex=3D100=
 ^
-netdev type=3Dtap,id=3Dmynet0,ifname=3Dtap1,script=3Dno,downscript=3Dno ^
-device e1000,netdev=3Dmynet0,mac=3D52:55:00:d1:55:10,bus=3Dpci.0,addr=3D0x=
12,id=3Dnet0,bootindex=3D300 ^
-machine type=3Dq35,accel=3Dwhpx

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1892541

Title:
  qemu 5.1 on windows 10 with whpx can not install Windows 7 guest

Status in QEMU:
  New

Bug description:
  Command install and start win7

  qemu-system-x86_64  -smbios type=3D1,uuid=3De77aacd6-0acb-4a5c-9a83-a80d0=
29b36f1 -smp 2,sockets=3D1,cores=3D2,maxcpus=3D2 -nodefaults -boot menu=3Do=
n,strict=3Don,reboot-timeout=3D1000 -m 8192 ^
  -readconfig pve-q35-4.0.cfg ^
  -device vmgenid,guid=3D6d4865f5-353e-4cf1-b8ca-f5abbd062736 -device usb-t=
ablet,id=3Dtablet,bus=3Dehci.0,port=3D1 -device VGA,id=3Dvga,bus=3Dpcie.0,a=
ddr=3D0x1 ^
  -device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x3 ^
  -drive file=3Den_windows_7_ultimate_with_sp1_x64_dvd_u_677332.iso,if=3Dno=
ne,id=3Ddrive-ide2,media=3Dcdrom,aio=3Dthreads ^
  -device ide-cd,bus=3Dide.1,unit=3D0,drive=3Ddrive-ide2,id=3Dide2,bootinde=
x=3D200 -device ahci,id=3Dahci0,multifunction=3Don,bus=3Dpci.0,addr=3D0x7 ^
  -drive id=3Ddrive-sata0,if=3Dnone,file=3Dwin7.qcow2,format=3Dqcow2,cache=
=3Dnone,aio=3Dnative,detect-zeroes=3Don ^
  -device ide-hd,bus=3Dahci0.0,drive=3Ddrive-sata0,id=3Dsata0,bootindex=3D1=
00 ^
  -netdev type=3Dtap,id=3Dmynet0,ifname=3Dtap1,script=3Dno,downscript=3Dno ^
  -device e1000,netdev=3Dmynet0,mac=3D52:55:00:d1:55:10,bus=3Dpci.0,addr=3D=
0x12,id=3Dnet0,bootindex=3D300 ^
  -machine type=3Dq35,accel=3Dwhpx

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1892541/+subscriptions


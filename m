Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0424C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D5772071A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5772071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlE9m-00046g-NR
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlE53-0005sf-NF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:04:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:59702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlE51-00042m-TA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:04:57 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jlE50-0004H7-2Z
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:04:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EC4A82E8114
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:04:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2020 15:55:08 -0000
From: Bugs SysSec <697510@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bugs-syssec janitor jeromepoulin stefanha th-huth
 vrozenfe
X-Launchpad-Bug-Reporter: =?utf-8?q?J=C3=A9r=C3=B4me_Poulin_=28jeromepoulin?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Bugs SysSec (bugs-syssec)
References: <20110105050549.989.70900.malonedeb@wampee.canonical.com>
Message-Id: <159232290935.29149.750886573430088461.launchpad@soybean.canonical.com>
Subject: [Bug 697510] Re: Machine shut off after tons of lsi_scsi: error: MSG
 IN data too long
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: bc62bcbf1c66987d8917ddd1df1039e0c812a5da
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 11:30:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 697510 <697510@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: Expired =3D> New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/697510

Title:
  Machine shut off after tons of lsi_scsi: error: MSG IN data too long

Status in QEMU:
  New

Bug description:
  The problem mostly happens during our backup, syslog does not have any
  problematic messages.

  Host is Ubuntu 10.10 x86 64 bits
  Guest is Windows 2003 Server 32 bits
  Using Virtio and Red Hat driver I get a STOP screen 0x100000d1 and machin=
e either reboot, stay frozen or shut off.
  Using SCSI the machine shuts off and I get tons of message on stdout;

  LC_ALL=3DC PATH=3D/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin=
:/bin QEMU_AUDIO_DRV=3Dnone /usr/bin/kvm -S -M pc-0.12 -enable-kvm -m 3500 =
-smp 4,sockets=3D4,cores=3D1,threads=3D1 -name BMSRV0101 -uuid 6ccbb5fa-588=
0-a1ab-3b7a-fb7ccc7c8ccf -nodefaults -chardev socket,id=3Dmonitor,path=3D/v=
ar/lib/libvirt/qemu/BMSRV0101.monitor,server,nowait -mon chardev=3Dmonitor,=
mode=3Dreadline -rtc base=3Dlocaltime -boot c -device lsi,id=3Dscsi0,bus=3D=
pci.0,addr=3D0x4 -drive if=3Dnone,media=3Dcdrom,id=3Ddrive-ide0-1-0,readonl=
y=3Don,format=3Draw -device ide-drive,bus=3Dide.1,unit=3D0,drive=3Ddrive-id=
e0-1-0,id=3Dide0-1-0 -drive file=3D/dev/vgUbuntu/vmBMSRV0101,if=3Dnone,id=
=3Ddrive-scsi0-0-0,boot=3Don,format=3Draw -device scsi-disk,bus=3Dscsi0.0,s=
csi-id=3D0,drive=3Ddrive-scsi0-0-0,id=3Dscsi0-0-0 -device virtio-net-pci,vl=
an=3D0,id=3Dnet0,mac=3D52:54:00:5d:7b:07,bus=3Dpci.0,addr=3D0x3 -net tap,fd=
=3D63,vlan=3D0,name=3Dhostnet0 -chardev pty,id=3Dserial0 -device isa-serial=
,chardev=3Dserial0 -usb -device usb-tablet,id=3Dinput0 -vnc 127.0.0.1:0 -vg=
a cirrus -device usb-host,hostbus=3D002,hostaddr=3D005,id=3Dhostdev0 -devic=
e virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x6 =

  char device redirected to /dev/pts/0
  pci_add_option_rom: failed to find romfile "pxe-virtio.bin"
  husb: open device 2.5
  husb: config #1 need -1
  husb: 1 interfaces claimed for configuration 1
  husb: grabbed usb device 2.5
  husb: config #1 need 1
  husb: 1 interfaces claimed for configuration 1

  lsi_scsi: error: Unimplemented message 0x00
  (x8)

  lsi_scsi: error: MSG IN data too long
  lsi_scsi: error: Unimplemented message 0x00
  (x760)

  lsi_scsi: error: MSG IN data too long
  lsi_scsi: error: MSG IN data too long
  kvm: /build/buildd/qemu-kvm-0.12.5+noroms/hw/lsi53c895a.c:512: lsi_do_dma=
: Assertion `s->current' failed.

  =

  I can include minidump file if needed.
  I am currently using IDE and it seems OK.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/697510/+subscriptions


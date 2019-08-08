Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B44C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 07:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC5B9214C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 07:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5B9214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvcf4-0007OU-Vc
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 03:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53369)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hvceG-0006g6-4j
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hvceE-0003Dl-IW
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:15:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:50964)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hvceE-0003DN-D6
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 03:15:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hvceC-0002Nt-Sd
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 07:15:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D44392E80C8
 for <qemu-devel@nongnu.org>; Thu,  8 Aug 2019 07:15:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Aug 2019 07:02:01 -0000
From: Xujun Ma <1839428@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: maxujun
X-Launchpad-Bug-Reporter: Xujun Ma (maxujun)
X-Launchpad-Bug-Modifier: Xujun Ma (maxujun)
Message-Id: <156524772160.13996.4537778553837159229.malonedeb@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19015";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d7dff36972beb3a0ad7b4772f5960fe888d36ea8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1839428] [NEW] qemu core dumped when repeat
 "system_reset" multiple times during guest boot
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
Reply-To: Bug 1839428 <1839428@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

commit 864ab314f1d924129d06ac7b571f105a2b76a4b2 (HEAD, tag: v4.1.0-rc4, ori=
gin/master, origin/HEAD, master)
Test arch:x86 and power

Steps:
1.Boot up guest with command
power cmdline:
/usr/libexec/backup/qemu-kvm \
 -smp 8 \
 -m 4096 \
 -nodefaults \
 -device virtio-blk-pci,id=3Dimage1,drive=3Ddrive_image1,bootindex=3D1,bus=
=3Dpci.0,addr=3D0x7 \
 -drive file=3Drhel77-ppc64le-virtio.qcow2,if=3Dnone,id=3Ddrive_image1,form=
at=3Dqcow2,cache=3Dnone \
 -chardev stdio,mux=3Don,id=3Dserial_id_serial0,server,nowait,signal=3Doff \
 -device spapr-vty,id=3Dserial111,chardev=3Dserial_id_serial0 \
 -mon chardev=3Dserial_id_serial0,mode=3Dreadline \
x86 cmdline:
/usr/libexec/qemu-kvm \
 -m 4096 -smp 8 \
 -boot menu=3Don \
 -device virtio-blk-pci,id=3Dimage1,drive=3Ddrive_image1\
 -drive file=3Drhel77-64-virtio.qcow2,if=3Dnone,id=3Ddrive_image1,format=3D=
qcow2,cache=3Dnone \
 -vga std \
 -vnc :9 \
 -nographic \
 -device virtio-net-pci,netdev=3Dnet0,id=3Dnic0,mac=3D52:54:00:c4:e7:84 \
 -netdev tap,id=3Dnet0,script=3D/etc/qemu-ifup,downscript=3D/etc/qemu-ifdow=
n,vhost=3Don \

2.when guest start to boot up kernel(when no output infomation),run hmp
command "system_reset"


Result:

Sometimes,qemu core dumped with error as following:
system_reset
(qemu) qemu-system-ppc64: /root/qemu/hw/virtio/virtio.c:225: vring_get_regi=
on_caches: Assertion `caches !=3D NULL' failed.
b.sh: line 11: 73679 Aborted                 (core dumped) /usr/local/bin/q=
emu-system-ppc64 -enable-kvm -smp 8 -m 4096 -nodefaults -device virtio-blk-=
pci,id=3Dimage1,drive=3Ddrive_image1,bootindex=3D1,bus=3Dpci.0,addr=3D0x7 -=
drive file=3Drhel77-ppc64le-virtio.qcow2,if=3Dnone,id=3Ddrive_image1,format=
=3Dqcow2,cache=3Dnone -chardev stdio,mux=3Don,id=3Dserial_id_serial0,server=
,nowait,signal=3Doff -device spapr-vty,id=3Dserial111,chardev=3Dserial_id_s=
erial0 -mon chardev=3Dserial_id_serial0,mode=3Dreadline

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1839428

Title:
   qemu core dumped when repeat "system_reset" multiple times during
  guest boot

Status in QEMU:
  New

Bug description:
  commit 864ab314f1d924129d06ac7b571f105a2b76a4b2 (HEAD, tag: v4.1.0-rc4, o=
rigin/master, origin/HEAD, master)
  Test arch:x86 and power

  Steps:
  1.Boot up guest with command
  power cmdline:
  /usr/libexec/backup/qemu-kvm \
   -smp 8 \
   -m 4096 \
   -nodefaults \
   -device virtio-blk-pci,id=3Dimage1,drive=3Ddrive_image1,bootindex=3D1,bu=
s=3Dpci.0,addr=3D0x7 \
   -drive file=3Drhel77-ppc64le-virtio.qcow2,if=3Dnone,id=3Ddrive_image1,fo=
rmat=3Dqcow2,cache=3Dnone \
   -chardev stdio,mux=3Don,id=3Dserial_id_serial0,server,nowait,signal=3Dof=
f \
   -device spapr-vty,id=3Dserial111,chardev=3Dserial_id_serial0 \
   -mon chardev=3Dserial_id_serial0,mode=3Dreadline \
  x86 cmdline:
  /usr/libexec/qemu-kvm \
   -m 4096 -smp 8 \
   -boot menu=3Don \
   -device virtio-blk-pci,id=3Dimage1,drive=3Ddrive_image1\
   -drive file=3Drhel77-64-virtio.qcow2,if=3Dnone,id=3Ddrive_image1,format=
=3Dqcow2,cache=3Dnone \
   -vga std \
   -vnc :9 \
   -nographic \
   -device virtio-net-pci,netdev=3Dnet0,id=3Dnic0,mac=3D52:54:00:c4:e7:84 \
   -netdev tap,id=3Dnet0,script=3D/etc/qemu-ifup,downscript=3D/etc/qemu-ifd=
own,vhost=3Don \

  2.when guest start to boot up kernel(when no output infomation),run
  hmp command "system_reset"

  =

  Result:

  Sometimes,qemu core dumped with error as following:
  system_reset
  (qemu) qemu-system-ppc64: /root/qemu/hw/virtio/virtio.c:225: vring_get_re=
gion_caches: Assertion `caches !=3D NULL' failed.
  b.sh: line 11: 73679 Aborted                 (core dumped) /usr/local/bin=
/qemu-system-ppc64 -enable-kvm -smp 8 -m 4096 -nodefaults -device virtio-bl=
k-pci,id=3Dimage1,drive=3Ddrive_image1,bootindex=3D1,bus=3Dpci.0,addr=3D0x7=
 -drive file=3Drhel77-ppc64le-virtio.qcow2,if=3Dnone,id=3Ddrive_image1,form=
at=3Dqcow2,cache=3Dnone -chardev stdio,mux=3Don,id=3Dserial_id_serial0,serv=
er,nowait,signal=3Doff -device spapr-vty,id=3Dserial111,chardev=3Dserial_id=
_serial0 -mon chardev=3Dserial_id_serial0,mode=3Dreadline

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1839428/+subscriptions


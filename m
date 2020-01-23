Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22096C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 06:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB42E217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 06:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB42E217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuW6Y-00064j-5N
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 01:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iuW4w-0004hE-Op
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 01:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iuW4v-0005sb-F4
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 01:34:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:55842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iuW4v-0005qq-8w
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 01:34:57 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iuW4u-0003MT-Ef
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:34:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4F3042E80C8
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 06:34:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jan 2020 06:21:41 -0000
From: Thomas Huth <1592336@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jirislaby th-huth
X-Launchpad-Bug-Reporter: Jirislaby (jirislaby)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160614095524.12099.1990.malonedeb@wampee.canonical.com>
Message-Id: <157976050180.4742.2306385019888439298.malone@wampee.canonical.com>
Subject: [Bug 1592336] Re: mouse is defunct when grabbed
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b8d1327fd820d6bf500589d6da587d5037c7d88e";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b048f25fd07316d9970ebfef5a03706e905678c9
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
Reply-To: Bug 1592336 <1592336@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Can you still reproduce the issue with the latest version of QEMU
(currently v4.2)?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1592336

Title:
  mouse is defunct when grabbed

Status in QEMU:
  Incomplete

Bug description:
  I run qemu as follows:
  qemu-system-x86_64 -machine accel=3Dkvm -k en-us -smp 4 -m 2371 -usb \
    -device virtio-rng-pci \
    -drive file=3D/home/new/suse-fact.img,format=3Draw,discard=3Dunmap,if=
=3Dnone,id=3Dhd
    -device virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Dhd \
    -soundhw hda \
    -net user,tftp=3D/home/xslaby/tftp,bootfile=3D/pxelinux.0,hostfwd=3Dtcp=
::2222-:22,hostfwd=3Dtcp::3632-:3632 -net nic,model=3Dvirtio \
    -serial pty -balloon virtio -vga virtio -display gtk,gl=3Don

  When I run X server with icewm inside the machine, the cursor works
  until I grab the mous with ctrl-alt-g. Then the cursor dismissed and
  the mouse is defunct.

  I also tried -usbdevice mouse and  -usbdevice tablet with the same
  result.

  I have these versions of qemu packages:
  qemu-2.6.0-470.2.x86_64
  qemu-ipxe-1.0.0-470.2.noarch
  qemu-ksm-2.6.0-470.2.x86_64
  qemu-kvm-2.6.0-470.2.x86_64
  qemu-ovmf-x86_64-2015+git1462940744.321151f-2.1.noarch
  qemu-ppc-2.6.0-470.2.x86_64
  qemu-seabios-1.9.1-470.2.noarch
  qemu-sgabios-8-470.2.noarch
  qemu-tools-2.6.0-470.2.x86_64
  qemu-vgabios-1.9.1-470.2.noarch
  qemu-x86-2.6.0-470.2.x86_64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1592336/+subscriptions


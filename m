Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE7DC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 23:36:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03EE42072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 23:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03EE42072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3pwY-0006BB-85
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 18:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j3pqm-0006Go-R1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 18:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j3pql-0001xl-Im
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 18:30:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:49616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j3pql-0001xG-DG
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 18:30:51 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j3pqj-00061E-Rj
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 23:30:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C21B12E80C8
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 23:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Feb 2020 23:19:58 -0000
From: JS <1859920@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: js1943 th-huth
X-Launchpad-Bug-Reporter: JS (js1943)
X-Launchpad-Bug-Modifier: JS (js1943)
References: <157915647770.15306.7117337280333115892.malonedeb@wampee.canonical.com>
Message-Id: <158198159884.25031.15556646452813111891.malone@gac.canonical.com>
Subject: [Bug 1859920] Re: daemoniz not working on MacOS
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 4e5af7c34d12ac037ede80af5e5b6cf949261761
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
Reply-To: Bug 1859920 <1859920@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Anything else I should supply to move status away from incomplete?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1859920

Title:
  daemoniz not working on MacOS

Status in QEMU:
  Incomplete

Bug description:
  OS: MacOS Catalina 10.15.2
  Qemu install via brew: brew install qemu

  qemu-system-x86_64 -version
  QEMU emulator version 4.2.50 (v4.2.0-13-g084a398bf8-dirty)
  Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

  ---

  Start Ubuntu Desktop 18.04 client as follow:

  IMG_CD=3D$HOME/Downloads/iso/ubuntu-18.04.3-desktop-amd64.iso
  IMG_FILE=3D$HOME/code/vm/qemu/u64d01.qcow2
  MAC_ADDR=3Dxx:xx:xx:xx:xx:xx

  qemu-system-x86_64 \
  -no-user-config -nodefaults \
  -show-cursor \
  -name u64d01 \
  -M q35,accel=3Dhvf,usb=3Doff,vmport=3Doff \
  -cpu host -smp 4 -m 2048 \
  -overcommit mem-lock=3Doff \
  -overcommit cpu-pm=3Doff \
  -rtc base=3Dutc,clock=3Dhost \
  \
  -device virtio-tablet-pci \
  -device virtio-vga \
  \
  -device virtio-blk-pci,drive=3Dssd1 \
  -drive id=3Dssd1,file=3D$IMG_FILE,if=3Dnone,format=3Dqcow2 \
  \
  -device virtio-net-pci,netdev=3Dnic1,mac=3D$MAC_ADDR \
  -netdev user,id=3Dnic1,ipv4=3Don,ipv6=3Don,hostname=3Du64d01,hostfwd=3Dtc=
p::2222-:22 \
  \
  -device ich9-intel-hda,id=3Dsnd,msi=3Don \
  -device hda-output,id=3Dsnd-codec0,bus=3Dsnd.0,cad=3D0,audiodev=3Dsnd0 \
  -audiodev coreaudio,id=3Dsnd0,out.buffer-count=3D10000 \
  \
  -daemonize

  Give following error:

  objc[3432]: +[NSNumber initialize] may have been in progress in another t=
hread when fork() was called.
  objc[3432]: +[NSNumber initialize] may have been in progress in another t=
hread when fork() was called. We cannot safely call it or ignore it in the =
fork() child process. Crashing instead. Set a breakpoint on objc_initialize=
AfterForkError to debug.

  =

  I checked "ps -ef|grep qemu" before and after the command, there was no q=
emu process running.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1859920/+subscriptions


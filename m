Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7F4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233B620756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 21:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233B620756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5bZ3-0007QB-Cu
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 17:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5bY5-0006aJ-KB
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:11:10 -0400
Received: from indium.canonical.com ([91.189.90.7]:39218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5bY3-0002ct-B0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 17:11:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5bY0-0005Ad-Ku
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 21:11:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8D1292E809C
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 21:11:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2020 21:02:59 -0000
From: Alexander Bulekov <1810000@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: usb xhci
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr balaton-4 benquike bugs-syssec th-huth
X-Launchpad-Bug-Reporter: PH (benquike)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
References: <154603590627.5548.1380267988808710453.malonedeb@wampee.canonical.com>
Message-Id: <159717977974.22566.17246830439718265798.malone@chaenomeles.canonical.com>
Subject: [Bug 1810000] Re: qemu system emulator crashed when using xhci usb
 controller
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 10342e82fba0d56d819cf293bff2d9374ad8f796
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 17:11:05
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
Reply-To: Bug 1810000 <1810000@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here's a QTest reproducer:

cat << EOF | ./i386-softmmu/qemu-system-i386 \
-device nec-usb-xhci -trace usb\* \
-device usb-audio -device usb-storage,drive=3Dmydrive \
-drive id=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnone \
-nodefaults -nographic -qtest stdio
outl 0xcf8 0x80001016
outl 0xcfc 0x3c319f0d
outl 0xcf8 0x80001004
outl 0xcfc 0xc77695e
writel 0x9f0d000000000040 0xffffd855
writeq 0x9f0d000000002000 0xff2f9e0000000000
write 0x1d 0x1 0x27
write 0x2d 0x1 0x2e
write 0x17232 0x1 0x03
write 0x17254 0x1 0x05
write 0x17276 0x1 0x72
write 0x17278 0x1 0x02
write 0x3d 0x1 0x27
write 0x40 0x1 0x2e
write 0x41 0x1 0x72
write 0x42 0x1 0x01
write 0x4d 0x1 0x2e
write 0x4f 0x1 0x01
writel 0x9f0d000000002000 0x0
write 0x2007d 0x1 0x2e
writeq 0x9f0d000000002000 0x514ef013d000009
write 0x20096 0x1 0x23
write 0x20098 0x1 0x08
write 0x2009c 0x1 0xfe
write 0x2009d 0x1 0x08
write 0x200ad 0x1 0x10
writeq 0x9f0d000000002000 0x100ef0100000009
EOF

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810000

Title:
  qemu system emulator crashed when using xhci usb controller

Status in QEMU:
  New

Bug description:
  I am testing usb-bt-dongle device on xchi host controller, and found
  that the qemu crashed directly with an assertion failer.

  Here is the information to reproduce the crash:

  Qemu git revision: 9b2e891ec5ccdb4a7d583b77988848282606fdea
  System emulator: qemu-x86_64
  VM image: https://people.debian.org/~aurel32/qemu/amd64/debian_squeeze_am=
d64_desktop.qcow2
  CommandLine: qemu-system-x86_64 -M q35 -device qemu-xhci,id=3Dxhci -enabl=
e-kvm -device usb-bt-dongle  -hda ./debian_wheezy_amd64_standard.qcow2

  Error message:

  qemu-system-x86_64: /build/qemu-
  Eap4uc/qemu-2.11+dfsg/hw/usb/core.c:592: usb_packet_copy: Assertion
  `p->actual_length + bytes <=3D iov->size' failed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1810000/+subscriptions


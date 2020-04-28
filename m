Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA2EC83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 06:28:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5EA206B8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 06:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5EA206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTJjA-0006Jx-QL
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 02:28:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jTJfa-00017K-C3
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jTJc5-0003Jr-PN
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:24:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:54224)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jTJc5-0003J6-Au
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:21:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jTJc3-0007aW-0S
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 06:20:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EBABF2E8107
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 06:20:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2020 06:07:10 -0000
From: Thomas Huth <1869858@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: chenyifei2008 th-huth
X-Launchpad-Bug-Reporter: chen (chenyifei2008)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <158564614354.21602.16034266356442698815.malonedeb@gac.canonical.com>
Message-Id: <158805403090.26493.6411268698828874238.malone@wampee.canonical.com>
Subject: [Bug 1869858] Re: qemu can't start Windows10arm64 19H1(with kvm)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d1105341713c5be348effe2a5142c4a210ce4cde";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 327a927f3cd386c610df248ea9f5b368bbce5677
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:20:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1869858 <1869858@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

What is your host machine? And could you please try with the latest
version of QEMU (v5.0)?

** Changed in: qemu
       Status: New =3D> Incomplete

** Information type changed from Private Security to Public

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1869858

Title:
  qemu can't start Windows10arm64 19H1(with kvm)

Status in QEMU:
  Incomplete

Bug description:
  My cpu's model is arm64(cortex-a53),I want start Win10arm64 with kvm,Beca=
use is fast than x86.But it's did'nt work.The screnn is card in Uefi's logo=
. But I am use ramfb now,So it has nothing to do with the graphics card.But=
 if I discard kvm,It can start now.But its so slowly.But I use the uefi and=
 kvm can start with Debian arm64 buster. So who's the problem?qemu or kvm o=
r Microsoft?But others use it to start successfully. I don't know what I wo=
uld like to do
  This is start command(Qemu version is 4.1')
  qemu-system-aarch64 -hda /win10.vhdx -cdrom /win10arm.iso -m 1G -accel kv=
m -smp 4 -cpu host -pflash efi.img -pflash var.img -device ramfb -device qe=
mu-xhci -device usb-kbd -device usb-mouse -device usb-tablet
  If I replace the above three parameters with "- CPU cortex-a53" and "- ac=
cel TCG" and "- device VGA", I can start normally. What's the matter?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1869858/+subscriptions


Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDD2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F4D20723
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F4D20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdbUF-0006I5-NU
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdbSb-0004P2-BZ
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:25:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:35024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdbSY-0005TT-Vu
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:25:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jdbSV-0000Xo-VN
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 15:25:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E99CE2E8048
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 15:25:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2020 15:20:18 -0000
From: Ottavio Caruso <1743191@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: regression
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: gson kraxel-redhat ottaviocr philmd stefanha
X-Launchpad-Bug-Reporter: Andreas Gustafsson (gson)
X-Launchpad-Bug-Modifier: Ottavio Caruso (ottaviocr)
References: <151591854188.4596.10964938100242408667.malonedeb@wampee.canonical.com>
Message-Id: <159050641843.20620.539925788806851332.malone@soybean.canonical.com>
Subject: [Bug 1743191] Re: Interacting with NetBSD serial console boot blocks
 no longer works
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d8159e66fb28f3fb3a95b1e448f4ddb2ec1a997b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 11:25:40
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
Reply-To: Bug 1743191 <1743191@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just to clarify my last comment, and in absence of updates, if I launch
the VM as:

qemu-system-x86_64 \
-drive if=3Dvirtio,file=3D/home/oc/VM/img/openbsd.image,index=3D0,media=3Dd=
isk \
-drive if=3Dvirtio,file=3D/home/oc/VM/img/openbsd.image.old,index=3D1,media=
=3Ddisk \
-M q35,accel=3Dkvm,graphics=3Don -m 250M -cpu host -smp $(nproc) \
-nic user,hostfwd=3Dtcp::6666-:22,model=3Dvirtio-net-pci -nographic

(note the -M q35,accel=3Dkvm,graphics=3Don), the problem still persists.

I'm still on version 4.2 and I haven't updated to 5.0 yet.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1743191

Title:
  Interacting with NetBSD serial console boot blocks no longer works

Status in QEMU:
  New

Bug description:
  The NetBSD boot blocks display a menu allowing the user to make a
  selection using the keyboard.  For example, when booting a NetBSD
  installation CD-ROM, the menu looks like this:

           1. Install NetBSD
           2. Install NetBSD (no ACPI)
           3. Install NetBSD (no ACPI, no SMP)
           4. Drop to boot prompt

      Choose an option; RETURN for default; SPACE to stop countdown.
      Option 1 will be chosen in 30 seconds.

  When booting NetBSD in a recent qemu using an emulated serial console,
  making this menu selection no longer works: when you type the selected
  number, the keyboard input is ignored, and the 30-second countdown
  continues.  In older versions of qemu, it works.

  To reproduce the problem, run:

     wget http://ftp.netbsd.org/pub/NetBSD/NetBSD-7.1.1/amd64/installation/=
cdrom/boot-com.iso
     qemu-system-x86_64 -nographic -cdrom boot-com.iso

  During the 30-second countdown, press 4

  Expected behavior: The countdown stops and you get a ">" prompt

  Incorrect behavior: The countdown continues

  There may also be some corruption of the terminal output; for example,
  "Option 1 will be chosen in 30 seconds" may be displayed as "Option 1
  will be chosen in p0 seconds".

  Using bisection, I have determined that the problem appeared with qemu
  commit 083fab0290f2c40d3d04f7f22eed9c8f2d5b6787, in which seabios was
  updated to 1.11 prerelease, and the problem is still there as of
  commit 7398166ddf7c6dbbc9cae6ac69bb2feda14b40ac.  The host operating
  system used for the tests was Debian 9 x86_64.

  Credit for discovering this bug goes to Paul Goyette.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1743191/+subscriptions


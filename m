Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FD6C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0124620829
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 19:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0124620829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6JBN-0007uB-4W
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 15:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k6JAU-0006pv-Bn
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 15:45:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:46864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k6JAS-0000le-CM
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 15:45:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k6JAQ-0000Sz-KG
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 19:45:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8C6192E808C
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 19:45:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2020 19:35:59 -0000
From: Laci <1890775@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jacoka
X-Launchpad-Bug-Reporter: Laci (jacoka)
X-Launchpad-Bug-Modifier: Laci (jacoka)
References: <159677829829.10348.2497937987968118298.malonedeb@chaenomeles.canonical.com>
Message-Id: <159734735959.2224.14156909621352685516.malone@soybean.canonical.com>
Subject: [Bug 1890775] Re: Aten USB to Serial bridge does not work with qemu
 under Windows 10
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="7eee5e59278f8f8118989c0aaceab242e073896e";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6c304f4a755c0b285ced77f35ee8c6061084f14b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 15:20:40
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
Reply-To: Bug 1890775 <1890775@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi again,

Seems to be there is no solution for my problem :(
I have succeeded create NTVDMx64 patch on my Windows 10 installation, so i =
can run directly 16 bit ms dos applications without any dos emulator.
I take the initiative to close the bug.

Bye

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890775

Title:
  Aten USB to Serial bridge does not work with qemu under Windows 10

Status in QEMU:
  New

Bug description:
  I would like to use MSDOS 6.22 with qemu (unfortunatelly lot of our test =
programs has been written in dos).
  I tried to connect two laptop by RS232 port, one of the machine have a bu=
ilt-in serial port and run with native MSDOS 6.22 with 4.0 norton commander=
. Another machine have only USB ports and i try to use a new Aten USB to Se=
rial device. Ok. Has been started qemu with -serial and -chardev parameters=
, at startup appear a window with serial port setting such as baud rate, st=
art bit, etc...

  Quemu has been satrted succeeded but serial port cannot be used
  becouse was nothing activited on usb serial adapter :(

  I tried same configuration with VirtualBox and everything was worked
  fine (serial connection was estabiled and copied several files from
  one machine into another machine), seems to be the emulated serial
  port has been worked fine.

  I would like to use qemu, i just thougt qemu is better, simple and
  faster...

  Exists solution or is this a qemu bug?

  Thank you!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890775/+subscriptions


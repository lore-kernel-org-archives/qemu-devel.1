Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F8BC388F2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CA1206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CA1206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbh80-0007b6-1W
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 04:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbh6l-0006c2-FE
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:35:35 -0500
Received: from indium.canonical.com ([91.189.90.7]:56964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbh6j-0006VZ-5w
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:35:35 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbh6h-0008Mc-7o
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:35:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 384FB2E811E
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 09:35:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 09:26:09 -0000
From: Thomas Huth <1639791@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hramrach th-huth
X-Launchpad-Bug-Reporter: Michal Suchanek (hramrach)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20161107132438.29321.64918.malonedeb@wampee.canonical.com>
Message-Id: <160482757003.17715.1681215804065750249.malone@wampee.canonical.com>
Subject: [Bug 1639791] Re: early virtio console output is lost
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 72e2f3b6a93c6001f143f02de35c553f4f781656
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 04:10:58
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1639791 <1639791@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project is currently considering to move its bug tracking to anoth=
er system. For this we need to know which bugs are still valid and which co=
uld be closed already. Thus we are setting all older bugs to
"Incomplete" now.
If you still think this bug report here is valid, then please switch the st=
ate back to "New" within the next 60 days, otherwise this report will be ma=
rked as "Expired". Thank you and sorry for the inconvenience.


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1639791

Title:
  early virtio console output is lost

Status in QEMU:
  Incomplete

Bug description:
  This is broken in git and reportedly in 2.5 through 2.7.

  Running a Linux kernel which includes a testsuite in initrd sometimes
  produces no output.

  Reportedly the console is sometimes not open when the early userspace
  tries to log output resulting in either the testsuite terminating
  early or not writing the output.

  Workaround patch is here:

  https://git.zx2c4.com/WireGuard/commit/?id=3Dd2de8b0862a7fbb51a7f2f958d58=
f0efe4648259

  reportedly you would get -EBADF there when no output is generated.

  Also this reportedly happens with virtio console only, not virtio
  serial port.

  It seems that the author of said testsuite did not report the problem
  so I write it down so it does not get lost.

  test (in bash):

  n=3D0 ; while [ $n -lt 100 ] && grep -m 1 -F "WireGuard Test Suite on
  Linux 4.8.6" <( /opt/qemu/bin/qemu-system-x86_64         -nodefaults
  -nographic         -machine q35,accel=3Dkvm         -cpu host
  -smp 2         -m 64M         -object rng-
  random,id=3Drng0,filename=3D/dev/urandom         -device virtio-rng-
  pci,rng=3Drng0         -device virtio-serial,max_ports=3D2
  -chardev stdio,id=3Dstdio         -device virtconsole,chardev=3Dstdio
  -chardev file,id=3Dstatus,path=3Dresult.txt         -device
  virtserialport,chardev=3Dstatus         -monitor none         -kernel
  wireguard-testing-harness-bzImage-e87cb2a7-145c-4985-907f-17e81fae329b
  -append "console=3Dhvc0 initcall_debug=3D1 loglevel=3D7" ) ; do echo $n ;
  n=3D$(expr $n + 1) ; pkill -f wireguard ; done

  This typically does 10-20 iterations but sometimes tens of iterations
  run without issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1639791/+subscriptions


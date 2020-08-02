Return-Path: <SRS0=xk1j=BM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE587C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 16:11:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1718206F6
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2020 16:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1718206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2GaW-0008E5-UV
	for qemu-devel@archiver.kernel.org; Sun, 02 Aug 2020 12:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2GYc-0006ry-6Y
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 12:09:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:57412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2GYZ-00031C-3S
 for qemu-devel@nongnu.org; Sun, 02 Aug 2020 12:09:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k2GYX-00038S-2V
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2020 16:09:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id F3B3A2E802E
 for <qemu-devel@nongnu.org>; Sun,  2 Aug 2020 16:09:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2020 15:59:04 -0000
From: hakan <1404278@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: 64bit tap windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dhsc19 myersjj prideaux90 stefanha tf-x th-huth
 tim-tree-of-life wsertz3a
X-Launchpad-Bug-Reporter: timsoft (tim-tree-of-life)
X-Launchpad-Bug-Modifier: hakan (tf-x)
References: <20141219153639.25009.84583.malonedeb@wampee.canonical.com>
Message-Id: <159638394450.11064.9327137954898121885.malone@chaenomeles.canonical.com>
Subject: [Bug 1404278] Re: tap connections not working on windows host
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ab666ea8531eee7749cb4d3c30c7284778104ec7
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/02 12:09:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1404278 <1404278@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

I want to run u-boot for x86_64 architecture in windows10 and I am using
qemu-5.0.0, the latest version of qemu. The TAP adapter for Linux (host)
worked successfully and I communicated between u-boot (guest) and Linux
(host), but the result for Windows (host) failed.

I installed the Tap Network Adapter for windows and renamed it to "tap0" . =
when I ran the qemu with the following command without creating a bridge, u=
-boot was successfully initialized, but I cannot ping Windows (host).
qemu-system-x86_64.exe -bios u-boot.rom -nographic -device  e1000,netdev=3D=
mynet0 -netdev tap,id=3Dmynet0,ifname=3Dtap0

When I check (right click> status) for Tap0 it says No Network Connection.
I terminated qemu and connected tap0 to the internet using the config files=
 I downloaded for OpenVPN.
When I checked tap0 again, I saw "Ipv4: Internet" but when I try to run qem=
u this way, I get an error like this.

tap: Could not open 'tap0'
qemu-system-x86_64.exe: Device 'tap' could not be initialized

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1404278

Title:
  tap connections not working on windows host

Status in QEMU:
  Fix Released

Bug description:
  using latest qemu 2.2.0 64bit for windows host (installed from
  qemu-w64-setup-20141210.exe obtained from http://qemu.weilnetz.de/w64/
  ),OpenVPN 2.6.3-I601 64bit tap adapter named tap01 and calling qemu
  using the following.

  qemu-system-x86_64.exe -m 512 -net nic -net tap,ifname=3Dtap01 -hda
  "c:\\data\\images\\test.img"

  where the image contains a slackware 14.0 64bit install.
  The tap is bridged with the real network adapter and the bridge is given =
an ip of 10.1.1.41 (which works as the ip for the windows host). The tap ad=
apter (in network connections) shows connected when the qemu vm is running.=
 inside the vm, the network is given an ip of 10.1.1.143 (the netmask and d=
efault gateway are the same for the virtual and real pc).
  fault.
  The vm cannot see the rest of the local network or visa-versa. This used =
to work in early (0.9 32bit) versions of qemu.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1404278/+subscriptions


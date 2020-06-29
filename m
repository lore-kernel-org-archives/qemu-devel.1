Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F177C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:06:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C562078A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 18:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C562078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpyBB-00028h-VV
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 14:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jpyA1-0001DX-4h
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 14:05:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:46142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jpy9y-0005Vl-SK
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 14:05:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jpy9w-0004tz-LY
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 18:05:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 9CEE72E8106
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 18:05:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2020 17:58:19 -0000
From: Kenneth Van Alstyne <1884990@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kvanals philmd
X-Launchpad-Bug-Reporter: Kenneth Van Alstyne (kvanals)
X-Launchpad-Bug-Modifier: Kenneth Van Alstyne (kvanals)
References: <159301342319.25339.2718719880566533302.malonedeb@gac.canonical.com>
Message-Id: <159345349931.32478.2682896062647722984.malone@chaenomeles.canonical.com>
Subject: [Bug 1884990] Re: Cirrus graphics results in monochrome colour depth
 at 640x480 resolution
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b76a2b96268204b90345cf2245df037feba94d66
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 06:50:40
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
Reply-To: Bug 1884990 <1884990@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ah, great catch!  Yes, that does appear to be the issue+fix.  Is QEMU
planning on integrating the next release of SeaBIOS or fixing this as a
one-off for now?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1884990

Title:
  Cirrus graphics results in monochrome colour depth at 640x480
  resolution

Status in QEMU:
  New

Bug description:
  Recently we upgraded to a distribution that bundled QEMU 4.2.0.  We
  were previously running on QEMU 3.0.0.  When booting Windows 10 VMs on
  x86_64, users experienced slow, monochrome graphics and the resolution
  was restricted to 640x480.  Reverting to the prior vgabios-cirrus.bin
  from the prior source tarball remediated the issue.

  An example QEMU command line is below, if needed:
  /bin/qemu-system-x86_64 -vnc 0.0.0.0:100 -device cirrus-vga,id=3Dvideo0,b=
us=3Dpci.0,addr=3D0x2  -machine pc-i440fx-4.2,accel=3Dkvm,usb=3Doff,dump-gu=
est-core=3Doff -cpu qemu64 -m 2048 -overcommit mem-lock=3Doff -smp 1,socket=
s=3D1,cores=3D1,threads=3D1 -no-user-config -nodefaults -hda test.raw &

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1884990/+subscriptions


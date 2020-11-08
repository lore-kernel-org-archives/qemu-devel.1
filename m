Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637C0C55178
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5903206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 09:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5903206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbgk0-0003SH-Tb
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 04:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbgj0-0002AM-HY
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:11:02 -0500
Received: from indium.canonical.com ([91.189.90.7]:54130)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kbgiy-0006XD-Kt
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 04:11:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kbgix-0006W0-Eh
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 09:10:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6C4AB2E800F
 for <qemu-devel@nongnu.org>; Sun,  8 Nov 2020 09:10:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2020 09:04:33 -0000
From: Thomas Huth <1649236@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: commit daemonize
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 6sense.ru th-huth
X-Launchpad-Bug-Reporter: Vasya (6sense.ru)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20161212102447.23016.40899.malonedeb@chaenomeles.canonical.com>
Message-Id: <160482627343.12514.2799438470542177483.malone@gac.canonical.com>
Subject: [Bug 1649236] Re: Commit snapshot fails with Permission denied when
 daemonized
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 8c089307491a6a8366cd35d513309dee56ad0d75
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
Reply-To: Bug 1649236 <1649236@bugs.launchpad.net>
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
https://bugs.launchpad.net/bugs/1649236

Title:
  Commit snapshot fails with Permission denied when daemonized

Status in QEMU:
  Incomplete

Bug description:
  When running qemu with daemonize option it is impossible to run
  "commit all" in monitor.

  I run qemu 2.7.0 under gentoo 64 bit distribution with following
  command line:

  qemu-system-x86_64 -m 4096 -cpu host -smp 2 -enable-kvm -snapshot \
      -drive file=3Dvm.img,if=3Dvirtio \
      -net nic,model=3Dvirtio,macaddr=3D11:11:11:11:11:11 \
      -net tap,ifname=3Dtap$PORT,script=3Dno,downscript=3Dno \
      -vnc :1 -daemonize \
      -chardev vc,id=3Dmon0 -mon chardev=3Dmon0,mode=3Dreadline \
      -chardev socket,id=3Dmon1,host=3Dlocalhost,port=3D10001,server,nowait=
 -mon chardev=3Dmon1,mode=3Dcontrol =


  I connect to vm through VNC viewer and press CTRL+ALT+2 and run "commit a=
ll" command.
  Following error is shown:
  `commit` error for `all`: Permission denied

  When I run my VM without `daemonize` option the command "commit all"
  works without errors.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1649236/+subscriptions


Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C2DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B06F20748
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 10:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B06F20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3zQW-0007qV-9e
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 06:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3zPm-0007QG-WF
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:15:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:35508)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3zPk-0008B4-Sp
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 06:15:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k3zPi-0000vl-Er
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 10:15:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6728C2E8025
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 10:15:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 10:05:33 -0000
From: Thomas Huth <1253563@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: amoskong th-huth
X-Launchpad-Bug-Reporter: Amos Jianjun Kong (amoskong)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20131121092412.27241.16050.malonedeb@gac.canonical.com>
Message-Id: <159679473342.5527.7207423639313432047.malone@soybean.canonical.com>
Subject: [Bug 1253563] Re: bad performance with rng-egd backend
X-Launchpad-Message-Rationale: Subscriber @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a5bedd18aa5432bc3e2e1e59447238409ce57c27
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
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
Reply-To: Bug 1253563 <1253563@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looking through old bug tickets... is this still an issue with the
latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to the bug report.
https://bugs.launchpad.net/bugs/1253563

Title:
  bad performance with rng-egd backend

Status in QEMU:
  Incomplete

Bug description:
  =

  1. create listen socket
  # cat /dev/random | nc -l localhost 1024

  2. start vm with rng-egd backend

  ./x86_64-softmmu/qemu-system-x86_64 --enable-kvm -mon chardev=3Dqmp,mode=
=3Dcontrol,pretty=3Don -chardev socket,id=3Dqmp,host=3Dlocalhost,port=3D123=
4,server,nowait -m 2000 -device virtio-net-pci,netdev=3Dh1,id=3Dvnet0 -netd=
ev tap,id=3Dh1 -vnc :0 -drive file=3D/images/RHEL-64-virtio.qcow2 \
  -chardev socket,host=3Dlocalhost,port=3D1024,id=3Dchr0 \
  -object rng-egd,chardev=3Dchr0,id=3Drng0 \
  -device virtio-rng-pci,rng=3Drng0,max-bytes=3D1024000,period=3D1000

  (guest) # dd if=3D/dev/hwrng of=3D/dev/null

  note: cancelling dd process by Ctrl+c, it will return the read speed.

  Problem:   the speed is around 1k/s

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  If I use rng-random backend (filename=3D/dev/random), the speed is about
  350k/s).

  It seems that when the request entry is added to the list, we don't read =
the data from queue list immediately.
  The chr_read() is delayed, the virtio_notify() is delayed.  the next requ=
est will also be delayed. It effects the speed.

  I tried to change rng_egd_chr_can_read() always returns 1,  the speed
  is improved to (about 400k/s)

  Problem: we can't poll the content in time currently

  =

  Any thoughts?

  Thanks, Amos

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1253563/+subscriptions


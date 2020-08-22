Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A77C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 18:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2BF9206C0
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 18:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BF9206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9YDm-0007qd-7w
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 14:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k9YCy-0007Kj-I3
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 14:25:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:39670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k9YCw-0000yw-Dv
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 14:25:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k9YCt-0002CO-Sl
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 18:25:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D895E2E8073
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 18:25:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2020 18:17:29 -0000
From: Thomas Huth <1892441@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: s390x softmmu
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahmedkrmn th-huth
X-Launchpad-Bug-Reporter: Ahmed Karaman (ahmedkrmn)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <159797545688.2805.5115079878417995484.malonedeb@chaenomeles.canonical.com>
Message-Id: <159812024945.1602.13731643447908486053.malone@wampee.canonical.com>
Subject: [Bug 1892441] Re: "No zIPL section in IPL2 record" error when
 emulating Debian 10.5.0 on s390x
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 24cf6ca7f3b304a726945bf27c02f264fb9dffbd
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 12:55:35
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
Reply-To: Bug 1892441 <1892441@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As far as I know, the Debian CD ISO images are not bootable on s390x
(they do not contain boot information according to the El-Torrito
standard). Please open a bug against Debian instead if you want to have
that changed. So far, you have to boot here manually instead (see
http://people.redhat.com/~thuth/blog/qemu/2017/12/19/install-fedora.html
for some more information).


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1892441

Title:
  "No zIPL section in IPL2 record" error when emulating Debian 10.5.0 on
  s390x

Status in QEMU:
  Invalid

Bug description:
  Hi,

  I want to emulate Debian 10.5.0 for the s390x architecture on an
  Ubuntu x86_64 host.

  The Debian image is downloaded from the following link:
  https://cdimage.debian.org/debian-cd/current/s390x/iso-cd/debian-10.5.0-s=
390x-netinst.iso

  Using the latest QEMU version 5.1.0, the Debian image is emulated using t=
he given command:
  qemu-system-s390x -boot d -m 4096 -hda debian.qcow -cdrom debian-10.5.0-s=
390x-netinst.iso -nographic

  Running the command causes the output below:

      LOADPARM=3D[        ]
      Using virtio-blk.
      Using guessed DASD geometry.
      Using ECKD scheme (block size  4096), CDL
      =

      ! No zIPL section in IPL2 record. !

  Using exactly the same qemu command above with the Alpine 3.12 image
  for s390x ran successfully without any errors.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1892441/+subscriptions


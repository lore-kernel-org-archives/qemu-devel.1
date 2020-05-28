Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D06BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 23:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E184B20776
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 23:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E184B20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeRcB-000832-4M
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 19:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jeRam-0006Vn-QF
 for qemu-devel@nongnu.org; Thu, 28 May 2020 19:05:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:45624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jeRal-0006O6-IQ
 for qemu-devel@nongnu.org; Thu, 28 May 2020 19:05:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jeRaj-0001AP-Gv
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 23:05:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7EBFB2E8033
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 23:05:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2020 22:55:54 -0000
From: John Snow <1872790@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow sxtf
X-Launchpad-Bug-Reporter: a (sxtf)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <158688621326.6027.1278663333852888209.malonedeb@chaenomeles.canonical.com>
Message-Id: <159070655430.5073.1052279742416408045.malone@wampee.canonical.com>
Subject: [Bug 1872790] Re: empty qcow2
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 020b5612c4f81116fe9727eed17dd221cad572bb
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:25:41
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
Reply-To: Bug 1872790 <1872790@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It sounds like maybe these disks have been partitioned in a format that
only Windows understands. Can you tell me what the windows disk manager
claims the partition table format to be?

If you still think that maybe there's a QEMU bug, please give more
details:

- host kernel version

- qemu version

- qemu command line

- how were these qcow2 files created?

- What version of qcow2 file does `qemu-img info` say they are?

- What version of windows? (10?)

- Can you name one of the third party disk managers so we can try to
reproduce it?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1872790

Title:
  empty qcow2

Status in QEMU:
  Incomplete

Bug description:
  I plugged multiple qcow2 to a Windows guest. On the Windows disk
  manager all disks are listed perfectly, with their data, their real
  space, I even can explore all files on the Explorer, all cool

  On third party disk manager (all of them), I only have the C:\ HDD who
  act normally, all the other plugged qcow2 are seen as fully
  unallocated, so I can't manipulate them

  I want to move some partitions, create others, but on Windows disk
  manager I can't extend or create partition and on third party I didn't
  see the partitions at all

  Even guestfs doesn't recognize any partition table `libguestfs: error:
  inspect_os: /dev/sda: not a partitioned device`

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1872790/+subscriptions


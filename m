Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD22C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 04:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0602075E
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 04:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0602075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kM1rU-0000UJ-DL
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 00:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kM1qN-0008OV-61
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 00:29:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:51124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kM1qH-0003EY-22
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 00:29:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kM1qC-0004iB-5H
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 04:29:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 14EF32E80F1
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 04:29:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2020 04:17:22 -0000
From: Launchpad Bug Tracker <1070762@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor jnsnow oliver-francke
X-Launchpad-Bug-Reporter: Oliver Francke (oliver-francke)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20121024095851.10767.86404.malonedeb@gac.canonical.com>
Message-Id: <160109384268.7355.6927776608355997026.malone@loganberry.canonical.com>
Subject: [Bug 1070762] Re: savevm fails with inserted CD,
 "Device '%s' is writable but does not support  snapshots."
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a314d157ca9be8d00eae0214fc0d7dff1cd406e4"; Instance="production"
X-Launchpad-Hash: eb539b9fcf10c4d1f4e112d9ec60b2fcbadcbb21
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/26 00:29:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1070762 <1070762@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1070762

Title:
  savevm fails with inserted CD, "Device '%s' is writable but does not
  support  snapshots."

Status in QEMU:
  Expired

Bug description:
  Hi,

  yesterday unfortunately a customer reported a failed snapshot of his
  VM. Going through the logfile I discovered:

  "Device 'ide1-cd0' is writable but does not support snapshots"

  this is with qemu-1.2.0 and 1.0.1 at least...

  Why writeable?
  Even if I specify "-drive ...,readonly=3Don,snapshot=3Doff" to qemu the m=
onitor-command sees the CD-ROM-device as being writeable?!

  Somewhere I saw a "hint" for blockdev.c:
  =3D=3D=3D snip =3D=3D=3D

  --- /tmp/blockdev.c	2012-10-24 11:37:10.000000000 +0200
  +++ blockdev.c	2012-10-24 11:37:17.000000000 +0200
  @@ -551,6 +551,7 @@
       case IF_XEN:
       case IF_NONE:
           dinfo->media_cd =3D media =3D=3D MEDIA_CDROM;
  +	dinfo->bdrv->read_only =3D 1;
           break;
       case IF_SD:
       case IF_FLOPPY:

  =3D=3D=3D snap =3D=3D=3D

  after installing with this small patch applied it works, so insert CD, sa=
vevm <somename> succeeds.
  This should be fixed at all correct places, and the tags "readonly=3Don,s=
napshot=3Doff" should do it, too. Or even just work after specifying a driv=
e being a CD-rom should do the trick ;-)

  Another "bad habit" is, that the ISO/DVD-file has to be writeable to
  be changed?

  Thnx for attention and regards,

  Oliver.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1070762/+subscriptions


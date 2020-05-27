Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627A3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:20:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3748520787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3748520787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdpQF-0002v5-E2
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdpPh-0002VK-HN
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:19:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:36576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jdpPg-0005d0-2c
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:19:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jdpPd-0005lz-TU
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 06:19:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id CB3412E8087
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 06:19:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2020 06:03:53 -0000
From: Greg Kurz <1336794@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=None; component=None;
 status=Confirmed; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: agretha crobinso ericvh gkurz infinoid janitor
 l-admin-o maxim-kuvyrkov
X-Launchpad-Bug-Reporter: Cole Robinson (crobinso)
X-Launchpad-Bug-Modifier: Greg Kurz (gkurz)
References: <20140702135258.23882.15100.malonedeb@soybean.canonical.com>
Message-Id: <159055943336.806.7379057394662646136.malone@chaenomeles.canonical.com>
Subject: [Bug 1336794] Re: 9pfs does not honor open file handles on unlinked
 files
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a4b391a2f278390a1fc11040096240214498ea60
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:00:55
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
Reply-To: Bug 1336794 <1336794@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For the records.

QEMU patches:

https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg07586.html

Linux patches:

https://sourceforge.net/p/v9fs/mailman/message/35175775/

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1336794

Title:
  9pfs does not honor open file handles on unlinked files

Status in QEMU:
  Confirmed
Status in Ubuntu:
  Confirmed

Bug description:
  This was originally filed over here:
  https://bugzilla.redhat.com/show_bug.cgi?id=3D1114221

  The open-unlink-fstat idiom used in some places to create an anonymous
  private temporary file does not work in a QEMU guest over a virtio-9p
  filesystem.

  Version-Release number of selected component (if applicable):

  qemu-kvm-1.6.2-6.fc20.x86_64
  qemu-system-x86-1.6.2-6.fc20.x86_64
  (those are fedora RPMs)

  How reproducible:

  Always. See this example C program:

  https://bugzilla.redhat.com/attachment.cgi?id=3D913069

  Steps to Reproduce:
  1. Export a filesystem with virt-manager for the guest.
        (type: mount, driver: default, mode: passthrough)
  2. Start guest and mount that filesystem
        (mount -t 9p -o trans=3Dvirtio,version=3D9p2000.L  ...)
  3. Run a program that uses open-unlink-fstat
        (in my case it was trying to compile Perl 5.20)

  Actual results:

  fstat fails:

  open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) =3D 3
  unlink("/home/tst/filename")            =3D 0
  fstat(3, 0x23aa1a8)                     =3D -1 ENOENT (No such file or di=
rectory)
  close(3)

  Expected results:

  open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) =3D 3
  unlink("/home/tst/filename")            =3D 0
  fstat(3, {st_mode=3DS_IFREG|0600, st_size=3D0, ...}) =3D 0
  fcntl(3, F_SETFD, FD_CLOEXEC)           =3D 0
  close(3) =


  Additional info:

  There was a patch put into the kernel back in '07 to handle this very
  problem for other filesystems; maybe its helpful:

        http://lwn.net/Articles/251228/

  There is also a thread on LKML from last December specifically about
  this very problem:

        https://lkml.org/lkml/2013/12/31/163

  There was a discussion on the QEMU list back in '11 that doesn't seem
  to have come to a conclusion, but did provide the test program that
  i've attached to this report:

        http://marc.info/?l=3Dqemu-devel&m=3D130443605720648&w=3D2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1336794/+subscriptions


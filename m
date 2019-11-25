Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047DEC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 19:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93F72071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 19:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93F72071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZKTU-0001Jd-VP
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 14:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iZKSR-0000mO-0C
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iZKSP-0004ZF-Lh
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:55:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:43512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iZKSP-0004XX-1E
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 14:55:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iZKSN-00032w-M7
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 19:55:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A51132E802B
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 19:55:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Nov 2019 19:48:37 -0000
From: Tony Asleson <tasleson@redhat.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: tasleson
X-Launchpad-Bug-Reporter: Tony Asleson (tasleson)
X-Launchpad-Bug-Modifier: Tony Asleson (tasleson)
Message-Id: <157471131796.22652.8509856251989177519.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1853898] [NEW] qemu/hw/scsi/lsi53c895a.c:417: lsi_soft_reset:
 Assertion `QTAILQ_EMPTY(&s->queue)' failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a112afa31b9f78fa21d0d062f7373b18611a1223
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1853898 <1853898@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

While experimenting with blkdebug I can consistently hit this assertion
in lsi53c895a.c.

Using locally built from master, commit:
2061735ff09f9d5e67c501a96227b470e7de69b1

Steps to reproduce

$ qemu-img create -f raw empty.raw 8G
$ sudo losetup -f --show empty.raw
$ sudo mkfs.ext3 /dev/loop0
$ sudo losetup -D

$ cat blkdebug.conf =

[inject-error]
event =3D "read_aio"
errno =3D "5"

$ qemu-system-x86_64 -enable-kvm -m 2048 -cpu host -smp 4 -nic
user,ipv6=3Doff,model=3De1000,hostfwd=3Dtcp::2222-:22,net=3D172.16.0.0/255.=
255.255.0
-device lsi53c895a,id=3Dscsi -device scsi-hd,drive=3Dhd,wwn=3D12345678 -dri=
ve
if=3Dscsi,id=3Dhd,file=3Dblkdebug:blkdebug.conf:empty.raw,cache=3Dnone,form=
at=3Draw
-cdrom Fedora-Server-dvd-x86_64-31-1.9.iso -display gtk

Initiate install from cdrom ISO image results in:

qemu-system-x86_64: /builddir/build/BUILD/qemu-3.1.1/hw/scsi/lsi53c895a.c:3=
81: lsi_soft_reset: Assertion `QTAILQ_EMPTY(&s->queue)' failed.
Aborted (core dumped)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1853898

Title:
  qemu/hw/scsi/lsi53c895a.c:417: lsi_soft_reset: Assertion
  `QTAILQ_EMPTY(&s->queue)' failed.

Status in QEMU:
  New

Bug description:
  While experimenting with blkdebug I can consistently hit this
  assertion in lsi53c895a.c.

  Using locally built from master, commit:
  2061735ff09f9d5e67c501a96227b470e7de69b1

  Steps to reproduce

  $ qemu-img create -f raw empty.raw 8G
  $ sudo losetup -f --show empty.raw
  $ sudo mkfs.ext3 /dev/loop0
  $ sudo losetup -D

  $ cat blkdebug.conf =

  [inject-error]
  event =3D "read_aio"
  errno =3D "5"

  $ qemu-system-x86_64 -enable-kvm -m 2048 -cpu host -smp 4 -nic
  user,ipv6=3Doff,model=3De1000,hostfwd=3Dtcp::2222-:22,net=3D172.16.0.0/25=
5.255.255.0
  -device lsi53c895a,id=3Dscsi -device scsi-hd,drive=3Dhd,wwn=3D12345678
  -drive
  if=3Dscsi,id=3Dhd,file=3Dblkdebug:blkdebug.conf:empty.raw,cache=3Dnone,fo=
rmat=3Draw
  -cdrom Fedora-Server-dvd-x86_64-31-1.9.iso -display gtk

  Initiate install from cdrom ISO image results in:

  qemu-system-x86_64: /builddir/build/BUILD/qemu-3.1.1/hw/scsi/lsi53c895a.c=
:381: lsi_soft_reset: Assertion `QTAILQ_EMPTY(&s->queue)' failed.
  Aborted (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1853898/+subscriptions


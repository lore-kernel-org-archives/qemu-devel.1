Return-Path: <SRS0=SwYc=4S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB661C3F2CD
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 15:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEA324672
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2020 15:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEA324672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8QYy-0007ww-Nt
	for qemu-devel@archiver.kernel.org; Sun, 01 Mar 2020 10:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j8QYG-0007Vn-4L
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 10:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j8QYE-0001OT-UV
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 10:30:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:35940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j8QYE-0001OJ-PA
 for qemu-devel@nongnu.org; Sun, 01 Mar 2020 10:30:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j8QYD-0005cD-BV
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2020 15:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 513A52E8031
 for <qemu-devel@nongnu.org>; Sun,  1 Mar 2020 15:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Mar 2020 15:22:51 -0000
From: f1outsourcing <1865350@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: f1outsourcing
X-Launchpad-Bug-Reporter: f1outsourcing (f1outsourcing)
X-Launchpad-Bug-Modifier: f1outsourcing (f1outsourcing)
Message-Id: <158307617196.25994.14347393969000973600.malonedeb@gac.canonical.com>
Subject: [Bug 1865350] [NEW] fstrim not working with image mounted to path?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 93b80839c252d343882f6eb4e9533cb0475b68be
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1865350 <1865350@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:


guest os: windows server standard 2016
qemu agent version 100.0.0

os supports trimming
path mounted image does not support trimming

C:\Users\Administrator>fsutil behavior query disabledeletenotify
NTFS DisableDeleteNotify =3D 0
ReFS DisableDeleteNotify =3D 1


[@ ~]# virsh qemu-agent-command vps-xxx '{"execute":"guest-fstrim"}'
{"return":{"paths":[{"path":"C:\\"},{"path":"C:\\Program Files\\Microsoft\\=
Exchange Server\\V15\\Mailbox\\xxxx\\","error":"The given volume path is in=
valid. (0x89000001)"}]}}


Looks like the fstrim does not like/check images mounted on a path? Nor det=
ects if image trimming is supported. xxxx is a ReFS mounted image without t=
rimming support. =


If I enable trimming on the ReFS image, and configure it win2016, the
result is still the same.


C:\Users\Administrator>fsutil behavior query disabledeletenotify
NTFS DisableDeleteNotify =3D 0
ReFS DisableDeleteNotify =3D 0

[root@c03 ~]# virsh qemu-agent-command vps-xxx '{"execute":"guest-fstrim"}'
{"return":{"paths":[{"path":"C:\\"},{"path":"C:\\Program Files\\Microsoft\\=
Exchange Server\\V15\\Mailbox\\xxxx\\","error":"The given volume path is in=
valid. (0x89000001)"}]}}

PS. tried this on a win 2016 std server with just one fs, no problems
then.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1865350

Title:
  fstrim not working with image mounted to path?

Status in QEMU:
  New

Bug description:
  =

  guest os: windows server standard 2016
  qemu agent version 100.0.0

  os supports trimming
  path mounted image does not support trimming

  C:\Users\Administrator>fsutil behavior query disabledeletenotify
  NTFS DisableDeleteNotify =3D 0
  ReFS DisableDeleteNotify =3D 1

  =

  [@ ~]# virsh qemu-agent-command vps-xxx '{"execute":"guest-fstrim"}'
  {"return":{"paths":[{"path":"C:\\"},{"path":"C:\\Program Files\\Microsoft=
\\Exchange Server\\V15\\Mailbox\\xxxx\\","error":"The given volume path is =
invalid. (0x89000001)"}]}}

  =

  Looks like the fstrim does not like/check images mounted on a path? Nor d=
etects if image trimming is supported. xxxx is a ReFS mounted image without=
 trimming support. =


  If I enable trimming on the ReFS image, and configure it win2016, the
  result is still the same.

  =

  C:\Users\Administrator>fsutil behavior query disabledeletenotify
  NTFS DisableDeleteNotify =3D 0
  ReFS DisableDeleteNotify =3D 0

  [root@c03 ~]# virsh qemu-agent-command vps-xxx '{"execute":"guest-fstrim"=
}'
  {"return":{"paths":[{"path":"C:\\"},{"path":"C:\\Program Files\\Microsoft=
\\Exchange Server\\V15\\Mailbox\\xxxx\\","error":"The given volume path is =
invalid. (0x89000001)"}]}}

  PS. tried this on a win 2016 std server with just one fs, no problems
  then.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1865350/+subscriptions


Return-Path: <SRS0=sqIQ=4K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25458C35669
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 04:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBCA420707
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Feb 2020 04:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBCA420707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5MNI-0007YP-4o
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 23:26:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j5MMT-0006kX-Pi
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 23:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j5MMQ-0005MA-6v
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 23:25:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:40668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j5MMP-0005Lg-Fn
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 23:25:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j5MMM-0005Eo-TU
 for <qemu-devel@nongnu.org>; Sat, 22 Feb 2020 04:25:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C9F3D2E80D3
 for <qemu-devel@nongnu.org>; Sat, 22 Feb 2020 04:25:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Feb 2020 04:17:23 -0000
From: Launchpad Bug Tracker <1719282@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: drive-mirror
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: farid67z janitor jnsnow
X-Launchpad-Bug-Reporter: Farid Zarazvand (farid67z)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <150633291490.21822.10650098875082014124.malonedeb@chaenomeles.canonical.com>
Message-Id: <158234504399.8772.16879367956995903567.malone@loganberry.canonical.com>
Subject: [Bug 1719282] Re: Unable to boot after drive-mirror
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b08fa42b1f5c55e6ac06352a6bec81f8f1fbc2d8
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
Reply-To: Bug 1719282 <1719282@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719282

Title:
  Unable to boot after drive-mirror

Status in QEMU:
  Expired

Bug description:
  Hi,
  I am using "drive-mirror" qmp block-job command to transfer VM disk image=
 to other path (different physical disk on host).
  Unfortunately after shutting down and starting from new image, VM is unab=
le to boot and qrub enters rescue mode displaying following error:
  ```
  error: file '/grub/i386-pc/normal.mod' not found.
  Entering rescue mode...
  grub rescue>
  ```

  To investigate the problem, I compared both RAW images using linux
  "cmp -l" command and found out that they differ in 569028 bytes
  starting from address 185598977 to 252708864 which are located on
  /boot partition.

  So I mounted /boot partition of mirrored RAW image on host OS and it
  seems that file-system is broken and grub folder is not recognized.
  But /boot on original RAW image has no problem.

  Mirrored Image:
  ls -l /mnt/vm-boot/
  ls: cannot access /mnt/vm-boot/grub: Structure needs cleaning
  total 38168
  -rw-r--r-- 1 root root   157721 Oct 19  2016 config-3.16.0-4-amd64
  -rw-r--r-- 1 root root   129281 Sep 20  2015 config-3.2.0-4-amd64
  d????????? ? ?    ?           ?            ? grub
  -rw-r--r-- 1 root root 15739360 Nov  2  2016 initrd.img-3.16.0-4-amd64
  -rw-r--r-- 1 root root 12115412 Oct 10  2015 initrd.img-3.2.0-4-amd64
  drwxr-xr-x 2 root root    12288 Oct  7  2013 lost+found
  -rw-r--r-- 1 root root  2679264 Oct 19  2016 System.map-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2114662 Sep 20  2015 System.map-3.2.0-4-amd64
  -rw-r--r-- 1 root root  3126448 Oct 19  2016 vmlinuz-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2842592 Sep 20  2015 vmlinuz-3.2.0-4-amd64

  Original Image:
  ls /mnt/vm-boot/ -l
  total 38173
  -rw-r--r-- 1 root root   157721 Oct 19  2016 config-3.16.0-4-amd64
  -rw-r--r-- 1 root root   129281 Sep 20  2015 config-3.2.0-4-amd64
  drwxr-xr-x 5 root root     5120 Nov  2  2016 grub
  -rw-r--r-- 1 root root 15739360 Nov  2  2016 initrd.img-3.16.0-4-amd64
  -rw-r--r-- 1 root root 12115412 Oct 10  2015 initrd.img-3.2.0-4-amd64
  drwxr-xr-x 2 root root    12288 Oct  7  2013 lost+found
  -rw-r--r-- 1 root root  2679264 Oct 19  2016 System.map-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2114662 Sep 20  2015 System.map-3.2.0-4-amd64
  -rw-r--r-- 1 root root  3126448 Oct 19  2016 vmlinuz-3.16.0-4-amd64
  -rw-r--r-- 1 root root  2842592 Sep 20  2015 vmlinuz-3.2.0-4-amd64

  ls /mnt/vm-boot/grub/ -l
  total 2376
  -rw-r--r-- 1 root root      48 Oct  7  2013 device.map
  drwxr-xr-x 2 root root    1024 Oct 10  2015 fonts
  -r--r--r-- 1 root root    9432 Nov  2  2016 grub.cfg
  -rw-r--r-- 1 root root    1024 Oct  7  2013 grubenv
  drwxr-xr-x 2 root root    6144 Aug  6  2016 i386-pc
  drwxr-xr-x 2 root root    1024 Aug  6  2016 locale
  -rw-r--r-- 1 root root 2400500 Aug  6  2016 unicode.pf2

  qemu Version: 2.7.0-10

  Host OS: Debian 8x64
  Guest OS: Debian 8x64

  QMP Commands log:
  socat UNIX-CONNECT:/var/run/qemu-server/48016.qmp STDIO
  {"QMP": {"version": {"qemu": {"micro": 0, "minor": 7, "major": 2}, "packa=
ge": "pve-qemu-kvm_2.7.0-10"}, "capabilities": []}}
  { "execute": "qmp_capabilities" }
  {"return": {}}
  { "execute": "drive-mirror",
    "arguments": {
      "device": "drive-ide0",
      "target": "/diskc/48016/vm-48016-disk-2.raw",
      "sync": "full",
      "mode": "absolute-paths",
      "speed": 0
    }
  }
  {"return": {}}
  {"timestamp": {"seconds": 1506331591, "microseconds": 623095}, "event": "=
BLOCK_JOB_READY", "data": {"device": "drive-ide0", "len": 269445758976, "of=
fset": 269445758976, "speed": 0, "type": "mirror"}}
  {"timestamp": {"seconds": 1506332641, "microseconds": 245272}, "event": "=
SHUTDOWN"}
  {"timestamp": {"seconds": 1506332641, "microseconds": 377751}, "event": "=
BLOCK_JOB_COMPLETED", "data": {"device": "drive-ide0", "len": 271707340800,=
 "offset": 271707340800, "speed": 0, "type": "mirror"}}

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1719282/+subscriptions


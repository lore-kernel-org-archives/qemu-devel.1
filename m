Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C696CC2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 21:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8AA206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 21:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8AA206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijUuc-0008NO-PH
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 16:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ijUtj-0007RT-1Q
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:05:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ijUth-0007IY-Kq
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:05:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:48682)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ijUth-0007Hz-F5
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 16:05:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ijUtg-0007ZC-ER
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 21:05:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4F3252E80C9
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 21:05:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Dec 2019 20:56:14 -0000
From: John Snow <1719282@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: drive-mirror
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: farid67z jnsnow
X-Launchpad-Bug-Reporter: Farid Zarazvand (farid67z)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <150633291490.21822.10650098875082014124.malonedeb@chaenomeles.canonical.com>
Message-Id: <157713457405.2407.13331923547667071028.malone@soybean.canonical.com>
Subject: [Bug 1719282] Re: Unable to boot after drive-mirror
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 305b5634d189588926acef0dfe335e63f0c51c7a
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
Reply-To: Bug 1719282 <1719282@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OK, so we're only talking about migrating a disk and not a whole VM, I
misunderstood. However... are you using qemu *2.7*? That's quite old!
Before digging into this further I need to insist that you try on a
supported release, either 4.0.1, 4.1.1, or 4.2.0.

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1719282

Title:
  Unable to boot after drive-mirror

Status in QEMU:
  Incomplete

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


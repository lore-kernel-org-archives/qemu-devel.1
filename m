Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9C6C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 15:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43707206CD
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 15:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43707206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJJ0N-0000KF-EP
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 11:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iJIj8-00085k-G1
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iJIj6-0000P8-OL
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:50:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:55034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iJIj6-0000K6-Hg
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 10:50:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iJIj5-0004Sm-3f
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 14:50:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E7C322E80C8
 for <qemu-devel@nongnu.org>; Sat, 12 Oct 2019 14:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Oct 2019 14:44:18 -0000
From: Emanuele Faranda <black.silver@hotmail.it>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: black-silver
X-Launchpad-Bug-Reporter: Emanuele Faranda (black-silver)
X-Launchpad-Bug-Modifier: Emanuele Faranda (black-silver)
References: <157089035721.2099.14904442368526379360.malonedeb@wampee.canonical.com>
Message-Id: <157089145885.9931.2617879447910979408.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1847861] Re: Guest stuttering under high disk IO (virtio)
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a4a369216c782988673e38166b9de3d67d2802c4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Sat, 12 Oct 2019 11:06:39 -0400
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
Reply-To: Bug 1847861 <1847861@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Description changed:

  Performing io intensive tasks on virtualized Windows causes the system
  to visually stutter. I can often reproduce the problem by running fio on
  windows:
  =

  fio --randrepeat=3D1 --ioengine=3Dwindowsaio --direct=3D1 --gtod_reduce=
=3D1
  --name=3Dtest --filename=3D\\.\PhysicalDrive0 --bs=3D4k --iodepth=3D128
  --size=3D4G --readwrite=3Drandread
  =

  While the fio command is running, moving the mouse pointer will be be
  laggy. The stuttering does not appear with iodepth <=3D 32 . The
  stuttering also manifests while playing games, the music and video
  pauses for a fraction of second in a playable but disturbing way.
  =

  Here are my system specs:
  =

  Host OS: archlinux
  Guest OS: Windows 10 Enterprise
  qemu version: qemu-git 8:v4.1.0.r1378.g98b2e3c9ab-1 (from AUR, compiled w=
ith -march=3Dnative)
  CPU: AMD Ryzen Threadripper 1900X 8-Core Processor
  Huge Pages: vm.nr_hugepages=3D4128
  Disk: nvme type=3Draw, io=3Dthreads bus=3Dvirtio
  GPU (passthrough): Radeon RX 570
  =

  Here are some fio test results on my windows guest:
  =

  [size=3D512M,iodepth=3D1 -> min=3D30k,avg=3D31k,stddev=3D508]
  [size=3D2G,iodepth=3D8 -> min=3D203k,avg=3D207k,stddev=3D2.3k]
  [size=3D2G,iodepth=3D16 -> min=3D320k,avg=3D330k,stddev=3D4.3k]
  [size=3D4G,iodepth=3D32 -> min=3D300k,avg=3D310k,stddev=3D4.8k]
  [size=3D4G,iodepth=3D64 -> min=3D278k,avg=3D366k,stddev=3D68.6k] -> STUTT=
ER
  [size=3D4G,iodepth=3D64 -> min=3D358k,avg=3D428k,stddev=3D52.6k] -> STUTT=
ER
  [size=3D4G,iodepth=3D128 -> min=3D92k,avg=3D217k,stddev=3D185k] -> STUTTER
  [size=3D4G,iodepth=3D128 -> min=3D241k,avg=3D257k,stddev=3D14k] -> same c=
onfig as above, but no stuttering
  =

  The min and avg values are the bandwidth values reported in KB/s by fio.
  You can see that, when the stuttering occurs, the stardard deviation is
  high and the minimum bandwidth is way below the average.
  =

  Additional note: the bandwidth reported with `fio` on my linux host is
  about 2x the one reported in the guest:
  =

  sudo fio --randrepeat=3D1 --ioengine=3Dlibaio --direct=3D1 --gtod_reduce=
=3D1
  --name=3Dtest --filename=3D/dev/nvme0n1 --bs=3D4k --iodepth=3D64 --size=
=3D512M
  --readwrite=3Drandread
  =

  read: IOPS=3D279k, BW=3D1092MiB/s (1145MB/s)(512MiB/469msec)
+ =

+ Moreover, during the fio tests on the guest I've noticed that the CPU
+ usage on the host is very high (around 450%) whereas on the guest is
+ only 10%

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1847861

Title:
  Guest stuttering under high disk IO (virtio)

Status in QEMU:
  New

Bug description:
  Performing io intensive tasks on virtualized Windows causes the system
  to visually stutter. I can often reproduce the problem by running fio
  on windows:

  fio --randrepeat=3D1 --ioengine=3Dwindowsaio --direct=3D1 --gtod_reduce=
=3D1
  --name=3Dtest --filename=3D\\.\PhysicalDrive0 --bs=3D4k --iodepth=3D128
  --size=3D4G --readwrite=3Drandread

  While the fio command is running, moving the mouse pointer will be be
  laggy. The stuttering does not appear with iodepth <=3D 32 . The
  stuttering also manifests while playing games, the music and video
  pauses for a fraction of second in a playable but disturbing way.

  Here are my system specs:

  Host OS: archlinux
  Guest OS: Windows 10 Enterprise
  qemu version: qemu-git 8:v4.1.0.r1378.g98b2e3c9ab-1 (from AUR, compiled w=
ith -march=3Dnative)
  CPU: AMD Ryzen Threadripper 1900X 8-Core Processor
  Huge Pages: vm.nr_hugepages=3D4128
  Disk: nvme type=3Draw, io=3Dthreads bus=3Dvirtio
  GPU (passthrough): Radeon RX 570

  Here are some fio test results on my windows guest:

  [size=3D512M,iodepth=3D1 -> min=3D30k,avg=3D31k,stddev=3D508]
  [size=3D2G,iodepth=3D8 -> min=3D203k,avg=3D207k,stddev=3D2.3k]
  [size=3D2G,iodepth=3D16 -> min=3D320k,avg=3D330k,stddev=3D4.3k]
  [size=3D4G,iodepth=3D32 -> min=3D300k,avg=3D310k,stddev=3D4.8k]
  [size=3D4G,iodepth=3D64 -> min=3D278k,avg=3D366k,stddev=3D68.6k] -> STUTT=
ER
  [size=3D4G,iodepth=3D64 -> min=3D358k,avg=3D428k,stddev=3D52.6k] -> STUTT=
ER
  [size=3D4G,iodepth=3D128 -> min=3D92k,avg=3D217k,stddev=3D185k] -> STUTTER
  [size=3D4G,iodepth=3D128 -> min=3D241k,avg=3D257k,stddev=3D14k] -> same c=
onfig as above, but no stuttering

  The min and avg values are the bandwidth values reported in KB/s by
  fio. You can see that, when the stuttering occurs, the stardard
  deviation is high and the minimum bandwidth is way below the average.

  Additional note: the bandwidth reported with `fio` on my linux host is
  about 2x the one reported in the guest:

  sudo fio --randrepeat=3D1 --ioengine=3Dlibaio --direct=3D1 --gtod_reduce=
=3D1
  --name=3Dtest --filename=3D/dev/nvme0n1 --bs=3D4k --iodepth=3D64 --size=
=3D512M
  --readwrite=3Drandread

  read: IOPS=3D279k, BW=3D1092MiB/s (1145MB/s)(512MiB/469msec)

  Moreover, during the fio tests on the guest I've noticed that the CPU
  usage on the host is very high (around 450%) whereas on the guest is
  only 10%

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1847861/+subscriptions


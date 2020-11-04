Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82181C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 00:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93300206F4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 00:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93300206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaSjb-0001IW-HL
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 19:02:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaSiF-0000Sq-6u
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 19:01:11 -0500
Received: from indium.canonical.com ([91.189.90.7]:43568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaSi9-0007dA-Gq
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 19:01:10 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaSi6-00050u-I0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 00:01:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 8109A2E80AB
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 00:01:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 23:48:28 -0000
From: John Snow <1681439@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr bugs-syssec janitor jnsnow kempniu th-huth
X-Launchpad-Bug-Reporter: =?utf-8?b?TWljaGHFgiBLxJlwaWXFhCAoa2VtcG5pdSk=?=
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <20170410132346.31250.84835.malonedeb@wampee.canonical.com>
Message-Id: <160453370817.19128.5024093621288569432.malone@soybean.canonical.com>
Subject: [Bug 1681439] Re: qemu-system-x86_64: hw/ide/core.c:685:
 ide_cancel_dma_sync: Assertion `s->bus->dma->aiocb == NULL' failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 62cccdf0cdc57176ee43c4f8d17745424aa180fb
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 17:35:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1681439 <1681439@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

TLDR: I am not actively working on this, because the problem extends
well below IDE and I don't have the bandwidth to take point on this at
the moment.

Here's a writeup I sent to qemu-devel on 2020-07-30:


First, the (partially bogus, fuzzer-generated) IDE command wants to:

1. dma write 259 sectors starting at sector 1

2. Provides a PRDT at addr 0x00 whose first PRDT describes a data buffer
at 0xffffffff of length 0x10000. [a]

3. The remaining 8,191 PRD entries are uninitialized memory that all
wind up describing the same data buffer at 0x00 of length 0x10000.

Generally, the entire PRDT is going to be read, but truncated into an
SGList that's exactly as long as the IDE command. Here, that's 0x20600
bytes.

Yadda, yadda, yadda, that winds up turning into these map requests:

addr 0xffffffff; len 0x10000
  -- mapped length: 0x01 (normal map return)

addr 0x100000000; len 0xffff
  -- mapped length: 0x1000 (bounce buffer return)

addr 0x100001000; len 0xefff
  -- bounce buffer is busy, cannot map

Then it proceeds and calls the iofunc. We return to dma_blk_cb and then:

unmap 0xffffffff; len 0x01; access_len 0x01;

... That unmaps the "direct" one, but we seemingly fail to unmap the
indirect one.

Uh, cool. When we build the IOV, we build it with two entries; but
qemu_iovec_discard_back discards the second entry entirely without
unmapping it.

IDE asks for an alignment of BDRV_SECTOR_SIZE (512 bytes). The IDE state
machine transfers an entire sector or nothing at all. The total IOV size
we have build thus far is 0x1001 bytes, which is not aligned as you
might have noticed.

So, we try to align it:

qemu_iovec_discard_back(&dbs->iov, QEMU_ALIGN_DOWN(4097, 512))

... I think we probably wanted to ask to shave off one byte instead of
asking to shave off 4096 bytes.


So, a few perceived problems with dma_blk_cb:

1. Our alignment math is wrong. discard_back takes as an argument the
number of bytes to discard, not the number of bytes you want to have
afterwards.

2. qemu_iovec_discard_back will happily unwind entire IO vectors that we
would need to unmap and have now lost. Worse, whenever we do any kind of
truncating at all, those bytes are not re-added to the source SGList, so
subsequent transfers will have skipped some bytes in the guest SGList.

3. the dma_blk_io interfaces don't ever check to see if the sg list is
an even multiple of the alignment. They don't return synchronous error
and no callers check for an error case. (Though BMDMA does carefully
prepare the SGList such that it is aligned in this way. AHCI does too,
IIRC.) This means we might have an unaligned tail that we will just drop
or ignore, leading to another partial DMA.

4. There's no guarantee that any given individual IO vector will have an
entire sector's worth of data in it. It is theoretically valid to
describe a series of vectors of two bytes each. If we can only map 1-2
vectors at a time, depending, we're never going to be able to scrounge
up enough buffer real estate to transfer an entire sector.


[a] This is against the BMDMA spec. The address must be aligned to 0x02
and cannot cross a 64K boundary. bit0 is documented as always being
zero, but it's not clear what should happen if the boundary constraint
is violated. Absent other concerns, it might just be easiest to fulfill
the transfer if it's possible.


** Changed in: qemu
     Assignee: John Snow (jnsnow) =3D> (unassigned)

** Changed in: qemu
       Status: In Progress =3D> Confirmed

** Summary changed:

- qemu-system-x86_64: hw/ide/core.c:685: ide_cancel_dma_sync: Assertion `s-=
>bus->dma->aiocb =3D=3D NULL' failed.
+ dma_blk_cb leaks memory map handles on misaligned IO

** Description changed:

+ Maintainer Edit:
+ =

+ The functions in dma-helpers mismanage misaligned IO, badly enough to
+ cause an infinite loop where no progress can be made. This allows the
+ IDE state machine to get wedged such that cancelling DMA can fail;
+ because the DMA helpers have bodged the state of the DMA transfer. See
+ Comment #15 for the in-depth analysis.
+ =

+ I've updated the name of this bug to reflect the current status as I
+ understand it.
+ =

+ --js
+ =

+ =

+ Original report:
+ =

  Since upgrading to QEMU 2.8.0, my Windows 7 64-bit virtual machines
  started crashing due to the assertion quoted in the summary failing.
  The assertion in question was added by commit 9972354856 ("block: add
  BDS field to count in-flight requests").  My tests show that setting
  discard=3Dunmap is needed to reproduce the issue.  Speaking of
  reproduction, it is a bit flaky, because I have been unable to come up
  with specific instructions that would allow the issue to be triggered
  outside of my environment, but I do have a semi-sane way of testing that
  appears to depend on a specific initial state of data on the underlying
  storage volume, actions taken within the VM and waiting for about 20
  minutes.
  =

  Here is the shortest QEMU command line that I managed to reproduce the
  bug with:
  =

-     qemu-system-x86_64 \
-         -machine pc-i440fx-2.7,accel=3Dkvm \
-         -m 3072 \
-         -drive file=3D/dev/lvm/qemu,format=3Draw,if=3Dide,discard=3Dunmap=
 \
- 	-netdev tap,id=3Dhostnet0,ifname=3Dtap0,script=3Dno,downscript=3Dno,vhos=
t=3Don \
-         -device virtio-net-pci,netdev=3Dhostnet0 \
- 	-vnc :0
+ =C2=A0=C2=A0=C2=A0=C2=A0qemu-system-x86_64 \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-machine pc-i440fx-2.7,ac=
cel=3Dkvm \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-m 3072 \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-drive file=3D/dev/lvm/qe=
mu,format=3Draw,if=3Dide,discard=3Dunmap \
+ =C2=A0-netdev tap,id=3Dhostnet0,ifname=3Dtap0,script=3Dno,downscript=3Dno=
,vhost=3Don \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device virtio-net-pci,ne=
tdev=3Dhostnet0 \
+ =C2=A0-vnc :0
  =

  The underlying storage (/dev/lvm/qemu) is a thin LVM snapshot.
  =

  QEMU was compiled using:
  =

-     ./configure --python=3D/usr/bin/python2.7 --target-list=3Dx86_64-soft=
mmu
-     make -j3
+ =C2=A0=C2=A0=C2=A0=C2=A0./configure --python=3D/usr/bin/python2.7 --targe=
t-list=3Dx86_64-softmmu
+ =C2=A0=C2=A0=C2=A0=C2=A0make -j3
  =

  My virtualization environment is not really a critical one and
  reproduction is not that much of a hassle, so if you need me to gather
  further diagnostic information or test patches, I will be happy to help.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1681439

Title:
  dma_blk_cb leaks memory map handles on misaligned IO

Status in QEMU:
  Confirmed

Bug description:
  Maintainer Edit:

  The functions in dma-helpers mismanage misaligned IO, badly enough to
  cause an infinite loop where no progress can be made. This allows the
  IDE state machine to get wedged such that cancelling DMA can fail;
  because the DMA helpers have bodged the state of the DMA transfer. See
  Comment #15 for the in-depth analysis.

  I've updated the name of this bug to reflect the current status as I
  understand it.

  --js

  =

  Original report:

  Since upgrading to QEMU 2.8.0, my Windows 7 64-bit virtual machines
  started crashing due to the assertion quoted in the summary failing.
  The assertion in question was added by commit 9972354856 ("block: add
  BDS field to count in-flight requests").  My tests show that setting
  discard=3Dunmap is needed to reproduce the issue.  Speaking of
  reproduction, it is a bit flaky, because I have been unable to come up
  with specific instructions that would allow the issue to be triggered
  outside of my environment, but I do have a semi-sane way of testing that
  appears to depend on a specific initial state of data on the underlying
  storage volume, actions taken within the VM and waiting for about 20
  minutes.

  Here is the shortest QEMU command line that I managed to reproduce the
  bug with:

  =C2=A0=C2=A0=C2=A0=C2=A0qemu-system-x86_64 \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-machine pc-i440fx-2.7,ac=
cel=3Dkvm \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-m 3072 \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-drive file=3D/dev/lvm/qe=
mu,format=3Draw,if=3Dide,discard=3Dunmap \
  =C2=A0-netdev tap,id=3Dhostnet0,ifname=3Dtap0,script=3Dno,downscript=3Dno=
,vhost=3Don \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device virtio-net-pci,ne=
tdev=3Dhostnet0 \
  =C2=A0-vnc :0

  The underlying storage (/dev/lvm/qemu) is a thin LVM snapshot.

  QEMU was compiled using:

  =C2=A0=C2=A0=C2=A0=C2=A0./configure --python=3D/usr/bin/python2.7 --targe=
t-list=3Dx86_64-softmmu
  =C2=A0=C2=A0=C2=A0=C2=A0make -j3

  My virtualization environment is not really a critical one and
  reproduction is not that much of a hassle, so if you need me to gather
  further diagnostic information or test patches, I will be happy to help.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1681439/+subscriptions


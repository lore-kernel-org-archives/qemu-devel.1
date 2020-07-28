Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1783CC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFEF920829
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 01:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEF920829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0EO7-0006Wf-88
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 21:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0ENV-00066B-GD
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 21:26:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:42858)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k0ENT-0003uX-7z
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 21:26:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k0ENR-000774-1u
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 01:25:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 046ED2E80EE
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 01:25:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2020 01:11:39 -0000
From: John Snow <1681439@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=jsnow@redhat.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr bugs-syssec janitor jnsnow kempniu th-huth
X-Launchpad-Bug-Reporter: =?utf-8?b?TWljaGHFgiBLxJlwaWXFhCAoa2VtcG5pdSk=?=
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <20170410132346.31250.84835.malonedeb@wampee.canonical.com>
Message-Id: <159589869923.9862.12491854264782196101.malone@chaenomeles.canonical.com>
Subject: [Bug 1681439] Re: qemu-system-x86_64: hw/ide/core.c:685:
 ide_cancel_dma_sync: Assertion `s->bus->dma->aiocb == NULL' failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 65d61b2984fb3cdb3edd7551bd5024d4cabeb130
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 21:25:57
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
Reply-To: Bug 1681439 <1681439@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qtest reproducers are so nice.

writel 0x0 0xffffffff

outw 0x171 0x32a
  features :=3D 0x2a    b8cb
  count :=3D 0x03;      b8cb
outw 0x176 0x3570
  device :=3D 0x70     (select device1)   b8cb
  command :=3D 0x35    (DMA WRITE EXT)    8f98

outl 0xcf8 0x80000903
outl 0xcfc 0x4e002700
outl 0xcf8 0x80000920
outb 0xcfc 0x5e

outb 0x58 0xe1
  bmdma_cmd_writeb val =3D 0xe1 [1110 0001]
                           DMA READ ^  ^ DMA Start
outw 0x57 0x0
  bmdma_cmd_writeb val =3D 0x00 [0000 0000]
                                       ^ DMA Cancel
EOF


This should be a straightforward DMA cancel. I added some more traces;

# After the 0x35 command write:
ide_exec_cmd IDE exec cmd: bus 0x561808b0ecc0; state 0x561808b0f118; cmd 0x=
35
ide_sector_start_dma IDEState 0x561808b0f118;
ide_start_dma IDEState 0x561808b0f118;

# After the 0xe1 bmdma kick:
ide_dma_cb_entry IDEState 0x561808b0f118; ret 0;
ide_dma_cb IDEState 0x561808b0f118; sector_num=3D1 n=3D259 cmd=3DDMA WRITE
ide_dma_cb_next IDEState 0x561808b0f118;

So far, pretty normal. IDE calls the HBA's DMA start, but the HBA
doesn't have DMA enabled, so it stalls. Later, when we turn on DMA, the
HBA engages the DMA callback and sets up the first transfer. This sets
s->bus->dma->aiocb.

Then, we try to cancel DMA:

ide_cancel_dma_sync IDEState 0x561808b0f118;
ide_cancel_dma_sync_remaining draining all remaining requests
1343877@1595891049.469050:dma_blk_cb dbs=3D0x55baededdc50 ret=3D0
1343877@1595891049.469054:dma_map_wait dbs=3D0x55baededdc50
qemu-system-i386: /home/jsnow/src/qemu/hw/ide/core.c:732: void ide_cancel_d=
ma_sync(IDEState *): Assertion `s->bus->dma->aiocb =3D=3D NULL' failed.

We still have a DMA callback out, so we try to synchronously cancel it;
but the blk_drain doesn't appear to be effective!

We apparently wind up here:

    if (dbs->iov.size =3D=3D 0) {
        trace_dma_map_wait(dbs);
        dbs->bh =3D aio_bh_new(dbs->ctx, reschedule_dma, dbs);
        cpu_register_map_client(dbs->bh);
        return;
    }


... The DMA simply re-schedules itself (?) when iov.size is zero. unfortuna=
tely for us, that means that the original point of scheduling the drain doe=
sn't work, because the DMA never returns all the way to the IDE device emul=
ation code.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1681439

Title:
  qemu-system-x86_64: hw/ide/core.c:685: ide_cancel_dma_sync: Assertion
  `s->bus->dma->aiocb =3D=3D NULL' failed.

Status in QEMU:
  Confirmed

Bug description:
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

      qemu-system-x86_64 \
          -machine pc-i440fx-2.7,accel=3Dkvm \
          -m 3072 \
          -drive file=3D/dev/lvm/qemu,format=3Draw,if=3Dide,discard=3Dunmap=
 \
  	-netdev tap,id=3Dhostnet0,ifname=3Dtap0,script=3Dno,downscript=3Dno,vhos=
t=3Don \
          -device virtio-net-pci,netdev=3Dhostnet0 \
  	-vnc :0

  The underlying storage (/dev/lvm/qemu) is a thin LVM snapshot.

  QEMU was compiled using:

      ./configure --python=3D/usr/bin/python2.7 --target-list=3Dx86_64-soft=
mmu
      make -j3

  My virtualization environment is not really a critical one and
  reproduction is not that much of a hassle, so if you need me to gather
  further diagnostic information or test patches, I will be happy to help.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1681439/+subscriptions


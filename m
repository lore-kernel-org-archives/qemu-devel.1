Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C2FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 07:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAED220723
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 07:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAED220723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jew7b-00066Q-Rq
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 03:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jew71-00058S-90
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:40:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:47400)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jew6z-0002vt-JD
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:40:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jew6x-0004zG-Lj
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 07:40:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A2CDB2E805B
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 07:40:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2020 07:33:31 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1878255@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr jnsnow philmd stefanha
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158930780033.13046.17639068194138488918.malonedeb@wampee.canonical.com>
 <159079315819.13831.18211338576992499588.malone@gac.canonical.com>
Message-ID: <50c992d8-d48b-a247-41e2-15dfde41940a@redhat.com>
Subject: Re: [Bug 1878255] Re: Assertion failure in bdrv_aio_cancel,
 through ide
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="275d46a24253e557e4403d52832837e4bfa425b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 16e7d003246deda91f95a34953693f45afe13d3c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 03:40:56
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
Reply-To: Bug 1878255 <1878255@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200530073331.stDjNoou5_88vhGC40NCkerW69xs2-J5gpAGeS5UFhI@z>

On 5/30/20 12:59 AM, John Snow wrote:
> outl 0xcf8 0x8000fa24
> outl 0xcfc 0xe106c000 (Writes e106c00 to BAR5 for 0:31:2)

We might eventually display this in the reproducer output.

> =

> outl 0xcf8 0x8000fa04
> outw 0xcfc 0x7 (Enables BM, Memory IO and PIO for 0:31:2)
> =

> outl 0xcf8 0x8000fb20 (Enables 0:31:3, I guess? My PCI knowledge is
> iffy. We set the enable bit and select BAR4, but then we don't actually
> write to 0xcfc again to set anything.)
> =

> =

> write 0x0 0x3 0x2780e7
> - write these three bytes to addr 0 in memory.
> =

> write 0xe106c22c 0xd 0x1130c218021130c218021130c2
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSCTL] @ 0x2c=
: 0x18c23011
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSERR] @ 0x30=
: 0xc2301102
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSACT] @ 0x34=
: 0x30110218
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxCI] @ 0x38: =
0x000000c2
> =

> write 0xe106c218 0x15 0x110010110010110010110010110010110010110010
> =

> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxCMD] @ 0x18:=
 0x11100011
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:Reserved] @ 0x=
1c: 0x00111000
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxTFD] @ 0x20:=
 0x10001110
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSIG] @ 0x24:=
 0x11100011
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSSTS] @ 0x28=
: 0x00111000
> - ahci_port_write ahci(0x555c950f71a0)[2]: port write [reg:PxSCTL] @ 0x2c=
: 0x00000010
> =

> Not all of those register writes are actually important for the bug, so
> I simplified them to the fewest writes and fewest bits.
> =

> outl 0xcf8 0x8000fa24
> outl 0xcfc 0xe106c000
> outl 0xcf8 0x8000fa04
> outw 0xcfc 0x7
> outl 0xcf8 0x8000fb20
> write 0x0 0x3 0x2780e7
> write 0xe106c22c 0x4 0x01000000
> write 0xe106c238 0x2 0x02
> write 0xe106c218 0x4 0x11000000
> write 0xe106c22c 0x1 0x00
> =

> =

> 1. PxSCTL write arms the DET bit. It isn't intended to be left on when Px=
CMD.ST (Start) is issued. It's not clear what should happen if this DOES oc=
cur. (Undefined behavior, at the very least.)
> See AHCI 1.3 section 3.3.1.1 "Offset 2Ch: PxSCTL =E2=80=93 Port x Serial =
ATA Control (SCR2: SControl)"
> =

> This bit is intended to send a reset signal to attached SATA drives.
> QEMU just synchronously resets the drive because we can.
> =

> =

> 2. PxCI is not intended to be written to when PxCMD.ST is unset. The spec=
 suggests that when ST transitions from '1' to '0' that this field is clear=
ed, but it does not suggest what happens when it transitions from '0' to '1=
'. QEMU will happily set the register.
> =

> =

> 3. PxCMD write: This sets PxCMD.ST and PxCMD.FRE, which engages the AHCI =
device in earnest.
> =

> At this point, AHCI sees outstanding commands and tries to process them.
> The FIS receive address is never programmed, so it's at zero. We start
> reading a FIS there:
> =

> 15712@1590789960.784835:handle_cmd_fis_dump ahci(0x55b4c56621a0)[2]: FIS:
> 0x00: 27 80 e7 00 00 00 00 00 00 00 00 00 00 00 00 00 =

> 0x10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =

> 0x20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =

> 0x30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =

> 0x40: 34 40 70 01 01 14 eb 20 00 00 00 00 01 00 00 00 =

> 0x50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =

> 0x60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =

> 0x70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =

> =

> This is translated as:
> 0x27 SATA_FIS_TYPE_REGISTER_H2D
> 0x80 SATA_FIS_REG_H2D_UPDATE_COMMAND_REGISTER
> 0xe7 command =3D FLUSH CACHE
> =

> This will engage ide_flush_cache() (core.c)
> =

> =

> At this point I get a little confused. I wouldn't think we'd have a Block=
Backend here for ide_flush to work on, but it seems to think we do and allo=
ws the flush command to proceed. We then immediately try to cancel this flu=
sh, but bdrv_aio_cancel can't tolerate an aiocb with a null BDS and panics.
> =

> ...Hm, it should be the case that blk_do_flush detects this as
> ENOMEDIUM, but are we maybe just canceling this request too fast? I
> actually can't trigger this through the console, but I can trigger it by
> redirecting input from a .txt file.
> =

> Yup, OK: if you look in blk_aio_prwv, we schedule a oneshot to invoke
> the callback on a synchronous failure, but we are managing to inject the
> reset command before the oneshot gets a chance to run.

What is not clear to me is, can this be reproduced by a real guest, or
only replaying the fuzzer payload (via the qtest chardev)?

Very nicely detailed analysis btw!

Various parts are worth being copied in the fix commit description.

> =

> I think either blk_aio_cancel or bdrv_aio_cancel needs to check that
> there isn't a dangling BH callback -- it seems wrong to make it as far
> as bdrv_aio_cancel when there's no BDS, but the IDE device no longer has
> any idea why its callback hasn't returned yet, and blk_aio_cancel is the
> only mechanism it has to kick the state machine forward.
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878255

Title:
  Assertion failure in bdrv_aio_cancel, through ide

Status in QEMU:
  New

Bug description:
  Hello,
  While fuzzing, I found an input that triggers an assertion failure in bdr=
v_aio_cancel, through ide:

  #1  0x00007ffff685755b in __GI_abort () at abort.c:79
  #2  0x0000555556a8d396 in bdrv_aio_cancel (acb=3D0x607000061290) at /home=
/alxndr/Development/qemu/block/io.c:2746
  #3  0x0000555556a58525 in blk_aio_cancel (acb=3D0x2) at /home/alxndr/Deve=
lopment/qemu/block/block-backend.c:1540
  #4  0x0000555556552f5b in ide_reset (s=3D<optimized out>) at /home/alxndr=
/Development/qemu/hw/ide/core.c:1318
  #5  0x0000555556552aeb in ide_bus_reset (bus=3D0x62d000017398) at /home/a=
lxndr/Development/qemu/hw/ide/core.c:2422
  #6  0x0000555556579ba5 in ahci_reset_port (s=3D<optimized out>, port=3D<o=
ptimized out>) at /home/alxndr/Development/qemu/hw/ide/ahci.c:650
  #7  0x000055555657bd8d in ahci_port_write (s=3D0x61e000014d70, port=3D0x2=
, offset=3D<optimized out>, val=3D0x10) at /home/alxndr/Development/qemu/hw=
/ide/ahci.c:360
  #8  0x000055555657bd8d in ahci_mem_write (opaque=3D<optimized out>, addr=
=3D<optimized out>, val=3D<optimized out>, size=3D<optimized out>) at /home=
/alxndr/Development/qemu/hw/ide/ahci.c:513
  #9  0x00005555560028d7 in memory_region_write_accessor (mr=3D<optimized o=
ut>, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optimized out=
>, shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at /home/a=
lxndr/Development/qemu/memory.c:483
  #10 0x0000555556002280 in access_with_adjusted_size (addr=3D<optimized ou=
t>, value=3D<optimized out>, size=3D<optimized out>, access_size_min=3D<opt=
imized out>, access_size_max=3D<optimized out>, access_fn=3D<optimized out>=
, mr=3D0x61e000014da0, attrs=3D...) at /home/alxndr/Development/qemu/memory=
.c:544
  #11 0x0000555556002280 in memory_region_dispatch_write (mr=3D<optimized o=
ut>, addr=3D<optimized out>, data=3D0x10, op=3D<optimized out>, attrs=3D...=
) at /home/alxndr/Development/qemu/memory.c:1476
  #12 0x0000555555f171d4 in flatview_write_continue (fv=3D<optimized out>, =
addr=3D0xe106c22c, attrs=3D..., ptr=3D<optimized out>, len=3D0x1, addr1=3D0=
x7fffffffb8d0, l=3D<optimized out>, mr=3D0x61e000014da0) at /home/alxndr/De=
velopment/qemu/exec.c:3137
  #13 0x0000555555f0fb98 in flatview_write (fv=3D0x60600003b180, addr=3D<op=
timized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimized out>) at=
 /home/alxndr/Development/qemu/exec.c:3177

  I can reproduce it in qemu 5.0 using:

  cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -qtes=
t stdio -monitor none -serial none -M pc-q35-5.0  -nographic
  outl 0xcf8 0x8000fa24
  outl 0xcfc 0xe106c000
  outl 0xcf8 0x8000fa04
  outw 0xcfc 0x7
  outl 0xcf8 0x8000fb20
  write 0x0 0x3 0x2780e7
  write 0xe106c22c 0xd 0x1130c218021130c218021130c2
  write 0xe106c218 0x15 0x110010110010110010110010110010110010110010
  EOF

  I also attached the commands to this launchpad report, in case the
  formatting is broken:

  qemu-system-i386 -qtest stdio -monitor none -serial none -M pc-q35-5.0
  -nographic < attachment

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878255/+subscriptions


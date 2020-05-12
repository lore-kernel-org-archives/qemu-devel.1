Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DAAC2D0F7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2BEE207BC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BEE207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYa1r-0003L6-1G
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYZzE-0000u1-PQ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:50:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:55310)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jYZzC-0005uH-Pd
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:50:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jYZzA-0008P6-V5
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 18:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E8A8A2E80E7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 18:50:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2020 18:41:47 -0000
From: Alexander Bulekov <1878263@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <158930890733.12498.3041231636988541980.malonedeb@wampee.canonical.com>
Subject: [Bug 1878263] [NEW] Assertion-failure in scsi_dma_complete,
 with megasas
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="013b6f2a3f3ba130b50b9eee1a89957ee38a5c15";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b55568f46136c2f4d1c1f43d6a435cfc5c088cca
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 11:25:43
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1878263 <1878263@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,
While fuzzing, I found an input that triggers an assertion-failure in scsi_=
dma_complete, with megasas:

qemu-system-i386: /home/alxndr/Development/qemu/hw/scsi/scsi-disk.c:292:
void scsi_dma_complete(void *, int): Assertion `r->req.aiocb !=3D NULL'
failed.

#3  0x00007ffff6866092 in __GI___assert_fail (assertion=3D0x555556efa460 <s=
tr> "r->req.aiocb !=3D NULL", file=3D0x555556ef9b20 <str> "/home/alxndr/Dev=
elopment/qemu/hw/scsi/scsi-disk.c", line=3D0x124, function=3D0x555556efa560=
 <__PRETTY_FUNCTION__.scsi_dma_complete> "void scsi_dma_complete(void *, in=
t)") at assert.c:101
#4  0x000055555669d473 in scsi_dma_complete (opaque=3D0x616000040280, ret=
=3D<optimized out>) at /home/alxndr/Development/qemu/hw/scsi/scsi-disk.c:292
#5  0x000055555639c89b in dma_complete (dbs=3D<optimized out>, ret=3D<optim=
ized out>) at /home/alxndr/Development/qemu/dma-helpers.c:118
#6  0x000055555639c89b in dma_blk_cb (opaque=3D<optimized out>, ret=3D<opti=
mized out>) at /home/alxndr/Development/qemu/dma-helpers.c:136
#7  0x000055555639bd58 in dma_blk_io (ctx=3D<optimized out>, sg=3D<optimize=
d out>, offset=3D<optimized out>, align=3D<optimized out>, io_func=3D<optim=
ized
out>, io_func_opaque=3D<optimized out>, cb=3D<optimized out>, opaque=3D<opt=
imized out>, dir=3D<optimized out>) at /home/alxndr/Development/qemu/dma-he=
lpers.c:232
#8  0x000055555669baa5 in scsi_write_data (req=3D0x616000040280) at /home/a=
lxndr/Development/qemu/hw/scsi/scsi-disk.c:583
#9  0x00005555566b5d93 in scsi_req_continue (req=3D0x616000040280) at /home=
/alxndr/Development/qemu/hw/scsi/scsi-bus.c:1337
#10 0x00005555566f52e3 in megasas_enqueue_req (cmd=3D<optimized out>, is_wr=
ite=3D<optimized out>) at /home/alxndr/Development/qemu/hw/scsi/megasas.c:1=
651
#11 0x00005555566e276f in megasas_handle_io (s=3D<optimized out>, cmd=3D<op=
timized out>, frame_cmd=3D<optimized out>) at /home/alxndr/Development/qemu=
/hw/scsi/megasas.c:1790
#12 0x00005555566e276f in megasas_handle_frame (s=3D<optimized out>, frame_=
addr=3D<optimized out>, frame_count=3D<optimized out>) at /home/alxndr/Deve=
lopment/qemu/hw/scsi/megasas.c:1969
#13 0x00005555566e276f in megasas_mmio_write (opaque=3D<optimized out>, add=
r=3D<optimized out>, val=3D<optimized out>, size=3D<optimized out>) at /hom=
e/alxndr/Development/qemu/hw/scsi/megasas.c:2122
#14 0x00005555560028d7 in memory_region_write_accessor (mr=3D<optimized out=
>, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optimized out>,=
 shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at /home/alx=
ndr/Development/qemu/memory.c:483
#15 0x0000555556002280 in access_with_adjusted_size (addr=3D<optimized out>=
, value=3D<optimized out>, size=3D<optimized out>, access_size_min=3D<optim=
ized out>, access_size_max=3D<optimized out>, access_fn=3D<optimized out>, =
mr=3D0x7fffeeb301e0, attrs=3D...) at /home/alxndr/Development/qemu/memory.c=
:544
#16 0x0000555556002280 in memory_region_dispatch_write (mr=3D<optimized out=
>, addr=3D<optimized out>, data=3D0x17, op=3D<optimized out>, attrs=3D...) =
at /home/alxndr/Development/qemu/memory.c:1476
#17 0x0000555555f171d4 in flatview_write_continue (fv=3D<optimized out>, ad=
dr=3D0xc1c0, attrs=3D..., ptr=3D<optimized out>, len=3D0x1, addr1=3D0x7ffff=
fffae00, l=3D<optimized out>, mr=3D0x7fffeeb301e0) at /home/alxndr/Developm=
ent/qemu/exec.c:3137
#18 0x0000555555f0fb98 in flatview_write (fv=3D0x606000038180, addr=3D<opti=
mized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimized out>) at /=
home/alxndr/Development/qemu/exec.c:3177

I can reproduce it in qemu 5.0 using:

cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -qtest =
stdio -nographic -monitor none -serial none -M q35 -device megasas -device =
scsi-cd,drive=3Dnull0 -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=
=3Dnull0
outl 0xcf8 0x80001818
outl 0xcfc 0xc101
outl 0xcf8 0x8000181c
outl 0xcf8 0x80001804
outw 0xcfc 0x7
outl 0xcf8 0x8000186a
write 0x14 0x1 0xfe
write 0x0 0x1 0x02
outb 0xc1c0 0x17
EOF

I also attached the commands to this launchpad report, in case the
formatting is broken:

qemu-system-i386 -qtest stdio -nographic -monitor none -serial none -M
q35 -device megasas -device scsi-cd,drive=3Dnull0 -blockdev driver=3Dnull-co
,read-zeroes=3Don,node-name=3Dnull0 < attachment

Please let me know if I can provide any further info.
-Alex

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "attachment"
   https://bugs.launchpad.net/bugs/1878263/+attachment/5370508/+files/attac=
hment

** Description changed:

  Hello,
  While fuzzing, I found an input that triggers an assertion-failure in scs=
i_dma_complete, with megasas:
+ =

+ qemu-system-i386: /home/alxndr/Development/qemu/hw/scsi/scsi-disk.c:292:
+ void scsi_dma_complete(void *, int): Assertion `r->req.aiocb !=3D NULL'
+ failed.
  =

  #3  0x00007ffff6866092 in __GI___assert_fail (assertion=3D0x555556efa460 =
<str> "r->req.aiocb !=3D NULL", file=3D0x555556ef9b20 <str> "/home/alxndr/D=
evelopment/qemu/hw/scsi/scsi-disk.c", line=3D0x124, function=3D0x555556efa5=
60 <__PRETTY_FUNCTION__.scsi_dma_complete> "void scsi_dma_complete(void *, =
int)") at assert.c:101
  #4  0x000055555669d473 in scsi_dma_complete (opaque=3D0x616000040280, ret=
=3D<optimized out>) at /home/alxndr/Development/qemu/hw/scsi/scsi-disk.c:292
  #5  0x000055555639c89b in dma_complete (dbs=3D<optimized out>, ret=3D<opt=
imized out>) at /home/alxndr/Development/qemu/dma-helpers.c:118
  #6  0x000055555639c89b in dma_blk_cb (opaque=3D<optimized out>, ret=3D<op=
timized out>) at /home/alxndr/Development/qemu/dma-helpers.c:136
  #7  0x000055555639bd58 in dma_blk_io (ctx=3D<optimized out>, sg=3D<optimi=
zed out>, offset=3D<optimized out>, align=3D<optimized out>, io_func=3D<opt=
imized
  out>, io_func_opaque=3D<optimized out>, cb=3D<optimized out>, opaque=3D<o=
ptimized out>, dir=3D<optimized out>) at /home/alxndr/Development/qemu/dma-=
helpers.c:232
  #8  0x000055555669baa5 in scsi_write_data (req=3D0x616000040280) at /home=
/alxndr/Development/qemu/hw/scsi/scsi-disk.c:583
  #9  0x00005555566b5d93 in scsi_req_continue (req=3D0x616000040280) at /ho=
me/alxndr/Development/qemu/hw/scsi/scsi-bus.c:1337
  #10 0x00005555566f52e3 in megasas_enqueue_req (cmd=3D<optimized out>, is_=
write=3D<optimized out>) at /home/alxndr/Development/qemu/hw/scsi/megasas.c=
:1651
  #11 0x00005555566e276f in megasas_handle_io (s=3D<optimized out>, cmd=3D<=
optimized out>, frame_cmd=3D<optimized out>) at /home/alxndr/Development/qe=
mu/hw/scsi/megasas.c:1790
  #12 0x00005555566e276f in megasas_handle_frame (s=3D<optimized out>, fram=
e_addr=3D<optimized out>, frame_count=3D<optimized out>) at /home/alxndr/De=
velopment/qemu/hw/scsi/megasas.c:1969
  #13 0x00005555566e276f in megasas_mmio_write (opaque=3D<optimized out>, a=
ddr=3D<optimized out>, val=3D<optimized out>, size=3D<optimized out>) at /h=
ome/alxndr/Development/qemu/hw/scsi/megasas.c:2122
  #14 0x00005555560028d7 in memory_region_write_accessor (mr=3D<optimized o=
ut>, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optimized out=
>, shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at /home/a=
lxndr/Development/qemu/memory.c:483
  #15 0x0000555556002280 in access_with_adjusted_size (addr=3D<optimized ou=
t>, value=3D<optimized out>, size=3D<optimized out>, access_size_min=3D<opt=
imized out>, access_size_max=3D<optimized out>, access_fn=3D<optimized out>=
, mr=3D0x7fffeeb301e0, attrs=3D...) at /home/alxndr/Development/qemu/memory=
.c:544
  #16 0x0000555556002280 in memory_region_dispatch_write (mr=3D<optimized o=
ut>, addr=3D<optimized out>, data=3D0x17, op=3D<optimized out>, attrs=3D...=
) at /home/alxndr/Development/qemu/memory.c:1476
  #17 0x0000555555f171d4 in flatview_write_continue (fv=3D<optimized out>, =
addr=3D0xc1c0, attrs=3D..., ptr=3D<optimized out>, len=3D0x1, addr1=3D0x7ff=
fffffae00, l=3D<optimized out>, mr=3D0x7fffeeb301e0) at /home/alxndr/Develo=
pment/qemu/exec.c:3137
  #18 0x0000555555f0fb98 in flatview_write (fv=3D0x606000038180, addr=3D<op=
timized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimized out>) at=
 /home/alxndr/Development/qemu/exec.c:3177
- =

  =

  I can reproduce it in qemu 5.0 using:
  =

  cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -qtes=
t stdio -nographic -monitor none -serial none -M q35 -device megasas -devic=
e scsi-cd,drive=3Dnull0 -blockdev driver=3Dnull-co,read-zeroes=3Don,node-na=
me=3Dnull0
  outl 0xcf8 0x80001818
  outl 0xcfc 0xc101
  outl 0xcf8 0x8000181c
  outl 0xcf8 0x80001804
  outw 0xcfc 0x7
  outl 0xcf8 0x8000186a
  write 0x14 0x1 0xfe
  write 0x0 0x1 0x02
  outb 0xc1c0 0x17
  EOF
  =

  I also attached the commands to this launchpad report, in case the
  formatting is broken:
  =

  qemu-system-i386 -qtest stdio -nographic -monitor none -serial none -M
  q35 -device megasas -device scsi-cd,drive=3Dnull0 -blockdev driver=3Dnull=
-co
  ,read-zeroes=3Don,node-name=3Dnull0 < attachment
  =

  Please let me know if I can provide any further info.
  -Alex

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878263

Title:
  Assertion-failure in scsi_dma_complete, with megasas

Status in QEMU:
  New

Bug description:
  Hello,
  While fuzzing, I found an input that triggers an assertion-failure in scs=
i_dma_complete, with megasas:

  qemu-system-i386: /home/alxndr/Development/qemu/hw/scsi/scsi-
  disk.c:292: void scsi_dma_complete(void *, int): Assertion
  `r->req.aiocb !=3D NULL' failed.

  #3  0x00007ffff6866092 in __GI___assert_fail (assertion=3D0x555556efa460 =
<str> "r->req.aiocb !=3D NULL", file=3D0x555556ef9b20 <str> "/home/alxndr/D=
evelopment/qemu/hw/scsi/scsi-disk.c", line=3D0x124, function=3D0x555556efa5=
60 <__PRETTY_FUNCTION__.scsi_dma_complete> "void scsi_dma_complete(void *, =
int)") at assert.c:101
  #4  0x000055555669d473 in scsi_dma_complete (opaque=3D0x616000040280, ret=
=3D<optimized out>) at /home/alxndr/Development/qemu/hw/scsi/scsi-disk.c:292
  #5  0x000055555639c89b in dma_complete (dbs=3D<optimized out>, ret=3D<opt=
imized out>) at /home/alxndr/Development/qemu/dma-helpers.c:118
  #6  0x000055555639c89b in dma_blk_cb (opaque=3D<optimized out>, ret=3D<op=
timized out>) at /home/alxndr/Development/qemu/dma-helpers.c:136
  #7  0x000055555639bd58 in dma_blk_io (ctx=3D<optimized out>, sg=3D<optimi=
zed out>, offset=3D<optimized out>, align=3D<optimized out>, io_func=3D<opt=
imized
  out>, io_func_opaque=3D<optimized out>, cb=3D<optimized out>, opaque=3D<o=
ptimized out>, dir=3D<optimized out>) at /home/alxndr/Development/qemu/dma-=
helpers.c:232
  #8  0x000055555669baa5 in scsi_write_data (req=3D0x616000040280) at /home=
/alxndr/Development/qemu/hw/scsi/scsi-disk.c:583
  #9  0x00005555566b5d93 in scsi_req_continue (req=3D0x616000040280) at /ho=
me/alxndr/Development/qemu/hw/scsi/scsi-bus.c:1337
  #10 0x00005555566f52e3 in megasas_enqueue_req (cmd=3D<optimized out>, is_=
write=3D<optimized out>) at /home/alxndr/Development/qemu/hw/scsi/megasas.c=
:1651
  #11 0x00005555566e276f in megasas_handle_io (s=3D<optimized out>, cmd=3D<=
optimized out>, frame_cmd=3D<optimized out>) at /home/alxndr/Development/qe=
mu/hw/scsi/megasas.c:1790
  #12 0x00005555566e276f in megasas_handle_frame (s=3D<optimized out>, fram=
e_addr=3D<optimized out>, frame_count=3D<optimized out>) at /home/alxndr/De=
velopment/qemu/hw/scsi/megasas.c:1969
  #13 0x00005555566e276f in megasas_mmio_write (opaque=3D<optimized out>, a=
ddr=3D<optimized out>, val=3D<optimized out>, size=3D<optimized out>) at /h=
ome/alxndr/Development/qemu/hw/scsi/megasas.c:2122
  #14 0x00005555560028d7 in memory_region_write_accessor (mr=3D<optimized o=
ut>, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optimized out=
>, shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at /home/a=
lxndr/Development/qemu/memory.c:483
  #15 0x0000555556002280 in access_with_adjusted_size (addr=3D<optimized ou=
t>, value=3D<optimized out>, size=3D<optimized out>, access_size_min=3D<opt=
imized out>, access_size_max=3D<optimized out>, access_fn=3D<optimized out>=
, mr=3D0x7fffeeb301e0, attrs=3D...) at /home/alxndr/Development/qemu/memory=
.c:544
  #16 0x0000555556002280 in memory_region_dispatch_write (mr=3D<optimized o=
ut>, addr=3D<optimized out>, data=3D0x17, op=3D<optimized out>, attrs=3D...=
) at /home/alxndr/Development/qemu/memory.c:1476
  #17 0x0000555555f171d4 in flatview_write_continue (fv=3D<optimized out>, =
addr=3D0xc1c0, attrs=3D..., ptr=3D<optimized out>, len=3D0x1, addr1=3D0x7ff=
fffffae00, l=3D<optimized out>, mr=3D0x7fffeeb301e0) at /home/alxndr/Develo=
pment/qemu/exec.c:3137
  #18 0x0000555555f0fb98 in flatview_write (fv=3D0x606000038180, addr=3D<op=
timized out>, attrs=3D..., buf=3D<optimized out>, len=3D<optimized out>) at=
 /home/alxndr/Development/qemu/exec.c:3177

  I can reproduce it in qemu 5.0 using:

  cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -qtes=
t stdio -nographic -monitor none -serial none -M q35 -device megasas -devic=
e scsi-cd,drive=3Dnull0 -blockdev driver=3Dnull-co,read-zeroes=3Don,node-na=
me=3Dnull0
  outl 0xcf8 0x80001818
  outl 0xcfc 0xc101
  outl 0xcf8 0x8000181c
  outl 0xcf8 0x80001804
  outw 0xcfc 0x7
  outl 0xcf8 0x8000186a
  write 0x14 0x1 0xfe
  write 0x0 0x1 0x02
  outb 0xc1c0 0x17
  EOF

  I also attached the commands to this launchpad report, in case the
  formatting is broken:

  qemu-system-i386 -qtest stdio -nographic -monitor none -serial none -M
  q35 -device megasas -device scsi-cd,drive=3Dnull0 -blockdev driver=3Dnull-
  co,read-zeroes=3Don,node-name=3Dnull0 < attachment

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878263/+subscriptions


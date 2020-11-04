Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6564BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE5320759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 20:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE5320759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaPSj-0003yD-QD
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 15:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaPQg-00017p-7W
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:30:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:51612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaPQd-0007Km-6p
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 15:30:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaPQb-0001ls-4I
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 20:30:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1E3962E809C
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 20:30:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 20:21:34 -0000
From: John Snow <1887303@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=jsnow@redhat.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr jnsnow philmd
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <159457987931.19254.12792549057508161525.malonedeb@chaenomeles.canonical.com>
Message-Id: <160452129438.13066.7578328958314128298.malone@gac.canonical.com>
Subject: [Bug 1887303] Re: Assertion failure in *bmdma_active_if
 `bmdma->bus->retry_unit != (uint8_t)-1' failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 93a0e0b64a6201e4d90a8b305b5f2336e1f7a5cd
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 14:49:49
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
Reply-To: Bug 1887303 <1887303@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Merged upstream:

55adb3c45620c31f29978f209e2a44a08d34e2da
4ac4e7281a2dd1ca5158812198c4d2cbacf2ae25
b45bcd81e05dea2781f2164ca1c9dd86069502ea
1a9925e3390b6adf1125e3abaa17c80ca012bede

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1887303

Title:
  Assertion failure in *bmdma_active_if `bmdma->bus->retry_unit !=3D
  (uint8_t)-1' failed.

Status in QEMU:
  Fix Committed

Bug description:
  Hello,
  Here is a QTest Reproducer:

  cat << EOF | ./i386-softmmu/qemu-system-i386 -M pc,accel=3Dqtest\
   -qtest null -nographic -vga qxl -qtest stdio -nodefaults\
   -drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,file.read-zeroes=3Don,for=
mat=3Draw\
   -drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,file.read-zeroes=3Don,for=
mat=3Draw\
   -device ide-cd,drive=3Ddrive0 -device ide-hd,drive=3Ddrive1
  outw 0x176 0x3538
  outw 0x376 0x6007
  outw 0x376 0x6b6b
  outw 0x176 0x985c
  outl 0xcf8 0x80000903
  outl 0xcfc 0x2f2931
  outl 0xcf8 0x80000920
  outb 0xcfc 0x6b
  outb 0x68 0x7
  outw 0x176 0x2530
  EOF

  Here is the call-stack:

      #8 0x7f00e0443091 in __assert_fail /build/glibc-GwnBeO/glibc-2.30/ass=
ert/assert.c:101:3
      #9 0x55e163f5a1af in bmdma_active_if /home/alxndr/Development/qemu/in=
clude/hw/ide/pci.h:59:5
      #10 0x55e163f5a1af in bmdma_prepare_buf /home/alxndr/Development/qemu=
/hw/ide/pci.c:132:19
      #11 0x55e163f4f00d in ide_dma_cb /home/alxndr/Development/qemu/hw/ide=
/core.c:898:17
      #12 0x55e163de86ad in dma_complete /home/alxndr/Development/qemu/dma-=
helpers.c:120:9
      #13 0x55e163de86ad in dma_blk_cb /home/alxndr/Development/qemu/dma-he=
lpers.c:138:9
      #14 0x55e1642ade85 in blk_aio_complete /home/alxndr/Development/qemu/=
block/block-backend.c:1402:9
      #15 0x55e1642ade85 in blk_aio_complete_bh /home/alxndr/Development/qe=
mu/block/block-backend.c:1412:5
      #16 0x55e16443556f in aio_bh_call /home/alxndr/Development/qemu/util/=
async.c:136:5
      #17 0x55e16443556f in aio_bh_poll /home/alxndr/Development/qemu/util/=
async.c:164:13
      #18 0x55e16440fac3 in aio_dispatch /home/alxndr/Development/qemu/util=
/aio-posix.c:380:5
      #19 0x55e164436dac in aio_ctx_dispatch /home/alxndr/Development/qemu/=
util/async.c:306:5
      #20 0x7f00e16e29ed in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e9ed)
      #21 0x55e164442f2b in glib_pollfds_poll /home/alxndr/Development/qemu=
/util/main-loop.c:219:9
      #22 0x55e164442f2b in os_host_main_loop_wait /home/alxndr/Development=
/qemu/util/main-loop.c:242:5
      #23 0x55e164442f2b in main_loop_wait /home/alxndr/Development/qemu/ut=
il/main-loop.c:518:11
      #24 0x55e164376953 in flush_events /home/alxndr/Development/qemu/test=
s/qtest/fuzz/fuzz.c:47:9
      #25 0x55e16437b8fa in general_fuzz /home/alxndr/Development/qemu/test=
s/qtest/fuzz/general_fuzz.c:544:17

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

  Here is the same assertion failure but triggered through a different
  call-stack:

  cat << EOF | ./i386-softmmu/qemu-system-i386 -M pc,accel=3Dqtest\
   -qtest null -nographic -vga qxl -qtest stdio -nodefaults\
   -drive if=3Dnone,id=3Ddrive0,file=3Dnull-co://,file.read-zeroes=3Don,for=
mat=3Draw\
   -drive if=3Dnone,id=3Ddrive1,file=3Dnull-co://,file.read-zeroes=3Don,for=
mat=3Draw\
   -device ide-cd,drive=3Ddrive0 -device ide-hd,drive=3Ddrive1
  outw 0x171 0x2fe9
  outb 0x177 0xa0
  outl 0x170 0x928
  outl 0x170 0x2b923b31
  outl 0x170 0x800a24d7
  outl 0xcf8 0x80000903
  outl 0xcfc 0x842700
  outl 0xcf8 0x80000920
  outb 0xcfc 0x5e
  outb 0x58 0x7
  outb 0x376 0x5
  outw 0x376 0x11
  outw 0x176 0x3538
  EOF

  Call-stack:
      #8 0x7f00e0443091 in __assert_fail /build/glibc-GwnBeO/glibc-2.30/ass=
ert/assert.c:101:3
      #9 0x55e163f5a622 in bmdma_active_if /home/alxndr/Development/qemu/in=
clude/hw/ide/pci.h:59:5
      #10 0x55e163f5a622 in bmdma_rw_buf /home/alxndr/Development/qemu/hw/i=
de/pci.c:187:19
      #11 0x55e163f57577 in ide_atapi_cmd_read_dma_cb /home/alxndr/Developm=
ent/qemu/hw/ide/atapi.c:375:13
      #12 0x55e163f44c55 in ide_buffered_readv_cb /home/alxndr/Development/=
qemu/hw/ide/core.c:650:9
      #13 0x55e1642ade85 in blk_aio_complete /home/alxndr/Development/qemu/=
block/block-backend.c:1402:9
      #14 0x55e1642ade85 in blk_aio_complete_bh /home/alxndr/Development/qe=
mu/block/block-backend.c:1412:5
      #15 0x55e16443556f in aio_bh_call /home/alxndr/Development/qemu/util/=
async.c:136:5
      #16 0x55e16443556f in aio_bh_poll /home/alxndr/Development/qemu/util/=
async.c:164:13
      #17 0x55e16440fac3 in aio_dispatch /home/alxndr/Development/qemu/util=
/aio-posix.c:380:5
      #18 0x55e164436dac in aio_ctx_dispatch /home/alxndr/Development/qemu/=
util/async.c:306:5
      #19 0x7f00e16e29ed in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e9ed)
      #20 0x55e164442f2b in glib_pollfds_poll /home/alxndr/Development/qemu=
/util/main-loop.c:219:9
      #21 0x55e164442f2b in os_host_main_loop_wait /home/alxndr/Development=
/qemu/util/main-loop.c:242:5
      #22 0x55e164442f2b in main_loop_wait /home/alxndr/Development/qemu/ut=
il/main-loop.c:518:11
      #23 0x55e164376953 in flush_events /home/alxndr/Development/qemu/test=
s/qtest/fuzz/fuzz.c:47:9
      #24 0x55e16437b8fa in general_fuzz /home/alxndr/Development/qemu/test=
s/qtest/fuzz/general_fuzz.c:544:17

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

  The first reproducer with -trace ide*:
  [I 1594579788.601818] OPENED
  26995@1594579788.617583:ide_reset IDEstate 0x565534a7b898
  26995@1594579788.617684:ide_reset IDEstate 0x565534a7bc68
  26995@1594579788.618019:ide_reset IDEstate 0x565534a7c188
  26995@1594579788.618087:ide_reset IDEstate 0x565534a7c558
  26995@1594579788.619271:ide_reset IDEstate 0x565534a7c188
  26995@1594579788.619377:ide_reset IDEstate 0x565534a7c558
  26995@1594579788.623224:ide_reset IDEstate 0x565534a7b898
  26995@1594579788.623267:ide_reset IDEstate 0x565534a7bc68
  26995@1594579788.623273:ide_reset IDEstate 0x565534a7c188
  26995@1594579788.623275:ide_reset IDEstate 0x565534a7c558
  [R +0.023386] outw 0x176 0x3538
  26995@1594579788.625224:ide_ioport_write IDE PIO wr @ 0x176 (Device/Head)=
; val 0x38; bus 0x565534a7c100 IDEState 0x565534a7c188
  26995@1594579788.625228:ide_ioport_write IDE PIO wr @ 0x177 (Command); va=
l 0x35; bus 0x565534a7c100 IDEState 0x565534a7c558
  26995@1594579788.625230:ide_exec_cmd IDE exec cmd: bus 0x565534a7c100; st=
ate 0x565534a7c558; cmd 0x35
  [S +0.023416] OK
  [R +0.023442] outw 0x376 0x6007
  26995@1594579788.625263:ide_cmd_write IDE PIO wr @ 0x376 (Device Control)=
; val 0x07; bus 0x565534a7c100
  [S +0.023447] OK
  [R +0.023455] outw 0x376 0x6b6b
  26995@1594579788.625276:ide_cmd_write IDE PIO wr @ 0x376 (Device Control)=
; val 0x6b; bus 0x565534a7c100
  [S +0.023460] OK
  [R +0.023464] outw 0x176 0x985c
  26995@1594579788.625285:ide_ioport_write IDE PIO wr @ 0x176 (Device/Head)=
; val 0x5c; bus 0x565534a7c100 IDEState 0x565534a7c558
  26995@1594579788.625287:ide_ioport_write IDE PIO wr @ 0x177 (Command); va=
l 0x98; bus 0x565534a7c100 IDEState 0x565534a7c558
  26995@1594579788.625289:ide_exec_cmd IDE exec cmd: bus 0x565534a7c100; st=
ate 0x565534a7c558; cmd 0x98
  [S +0.023473] OK
  [R +0.023477] outl 0xcf8 0x80000903
  [S +0.023481] OK
  [R +0.023485] outl 0xcfc 0x2f2931
  [S +0.023492] OK
  [R +0.023496] outl 0xcf8 0x80000920
  [S +0.023498] OK
  [R +0.023503] outb 0xcfc 0x6b
  [S +0.023644] OK
  [R +0.023651] outb 0x68 0x7
  26995@1594579788.625548:ide_dma_cb IDEState 0x565534a7c558; sector_num=3D=
1 n=3D255 cmd=3DDMA WRITE
  [S +0.023809] OK
  [R +0.023817] outw 0x176 0x2530
  26995@1594579788.625638:ide_ioport_write IDE PIO wr @ 0x176 (Device/Head)=
; val 0x30; bus 0x565534a7c100 IDEState 0x565534a7c558
  26995@1594579788.625640:ide_ioport_write IDE PIO wr @ 0x177 (Command); va=
l 0x25; bus 0x565534a7c100 IDEState 0x565534a7c558
  26995@1594579788.625642:ide_exec_cmd IDE exec cmd: bus 0x565534a7c100; st=
ate 0x565534a7c558; cmd 0x25
  [S +0.023827] OK
  qemu-system-i386: /home/alxndr/Development/qemu/include/hw/ide/pci.h:59: =
IDEState *bmdma_active_if(BMDMAState *): Assertion `bmdma->bus->retry_unit =
!=3D (uint8_t)-1' failed.

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

  The second reproducer with -trace ide*:

  [I 1594579681.691528] OPENED
  8293@1594579681.707423:ide_reset IDEstate 0x55fc044c3898
  8293@1594579681.707540:ide_reset IDEstate 0x55fc044c3c68
  8293@1594579681.707902:ide_reset IDEstate 0x55fc044c4188
  8293@1594579681.707969:ide_reset IDEstate 0x55fc044c4558
  8293@1594579681.709859:ide_reset IDEstate 0x55fc044c4188
  8293@1594579681.709976:ide_reset IDEstate 0x55fc044c4558
  8293@1594579681.714051:ide_reset IDEstate 0x55fc044c3898
  8293@1594579681.714073:ide_reset IDEstate 0x55fc044c3c68
  8293@1594579681.714076:ide_reset IDEstate 0x55fc044c4188
  8293@1594579681.714079:ide_reset IDEstate 0x55fc044c4558
  [R +0.024386] outw 0x171 0x2fe9
  8293@1594579681.715950:ide_ioport_write IDE PIO wr @ 0x171 (Features); va=
l 0xe9; bus 0x55fc044c4100 IDEState 0x55fc044c4188
  8293@1594579681.715955:ide_ioport_write IDE PIO wr @ 0x172 (Sector Count)=
; val 0x2f; bus 0x55fc044c4100 IDEState 0x55fc044c4188
  OK
  [S +0.024430] OK
  [R +0.024436] outb 0x177 0xa0
  8293@1594579681.715967:ide_ioport_write IDE PIO wr @ 0x177 (Command); val=
 0xa0; bus 0x55fc044c4100 IDEState 0x55fc044c4188
  8293@1594579681.715970:ide_exec_cmd IDE exec cmd: bus 0x55fc044c4100; sta=
te 0x55fc044c4188; cmd 0xa0
  OK
  [S +0.024444] OK
  [R +0.024448] outl 0x170 0x928
  8293@1594579681.715978:ide_data_writel IDE PIO wr @ 0x170 (Data: Long); v=
al 0x00000928; bus 0x55fc044c4100; IDEState 0x55fc044c4188
  OK
  [S +0.024453] OK
  [R +0.024456] outl 0x170 0x2b923b31
  8293@1594579681.715986:ide_data_writel IDE PIO wr @ 0x170 (Data: Long); v=
al 0x2b923b31; bus 0x55fc044c4100; IDEState 0x55fc044c4188
  OK
  [S +0.024460] OK
  [R +0.024464] outl 0x170 0x800a24d7
  8293@1594579681.715994:ide_data_writel IDE PIO wr @ 0x170 (Data: Long); v=
al 0x800a24d7; bus 0x55fc044c4100; IDEState 0x55fc044c4188
  8293@1594579681.715996:ide_atapi_cmd IDEState: 0x55fc044c4188; cmd: 0x28
  8293@1594579681.716000:ide_atapi_cmd_packet IDEState: 0x55fc044c4188; lim=
it=3D0xeb14 packet: 28 09 00 00 31 3b 92 2b d7 24 0a 80
  8293@1594579681.716004:ide_atapi_cmd_read IDEState: 0x55fc044c4188; read =
dma: LBA=3D12603 nb_sectors=3D11223
  OK
  [S +0.024479] OK
  [R +0.024483] outl 0xcf8 0x80000903
  OK
  [S +0.024485] OK
  [R +0.024489] outl 0xcfc 0x842700
  OK
  [S +0.024604] OK
  [R +0.024610] outl 0xcf8 0x80000920
  OK
  [S +0.024613] OK
  [R +0.024616] outb 0xcfc 0x5e
  OK
  [S +0.024720] OK
  [R +0.024726] outb 0x58 0x7
  8293@1594579681.716258:ide_atapi_cmd_read_dma_cb_aio IDEState: 0x55fc044c=
4188; aio read: lba=3D12603 n=3D64
  OK
  [S +0.024786] OK
  [R +0.024791] outb 0x376 0x5
  8293@1594579681.716322:ide_cmd_write IDE PIO wr @ 0x376 (Device Control);=
 val 0x05; bus 0x55fc044c4100
  OK
  [S +0.024797] OK
  [R +0.024800] outw 0x376 0x11
  8293@1594579681.716330:ide_cmd_write IDE PIO wr @ 0x376 (Device Control);=
 val 0x11; bus 0x55fc044c4100
  OK
  [S +0.024804] OK
  [R +0.024807] outw 0x176 0x3538
  8293@1594579681.716337:ide_ioport_write IDE PIO wr @ 0x176 (Device/Head);=
 val 0x38; bus 0x55fc044c4100 IDEState 0x55fc044c4188
  8293@1594579681.716340:ide_ioport_write IDE PIO wr @ 0x177 (Command); val=
 0x35; bus 0x55fc044c4100 IDEState 0x55fc044c4558
  8293@1594579681.716342:ide_exec_cmd IDE exec cmd: bus 0x55fc044c4100; sta=
te 0x55fc044c4558; cmd 0x35
  8293@1594579681.716388:ide_dma_cb IDEState 0x55fc044c4558; sector_num=3D5=
04 n=3D257 cmd=3DDMA WRITE
  OK
  [S +0.024882] OK
  qemu-system-i386: /home/alxndr/Development/qemu/include/hw/ide/pci.h:59: =
IDEState *bmdma_active_if(BMDMAState *): Assertion `bmdma->bus->retry_unit =
!=3D (uint8_t)-1' failed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1887303/+subscriptions


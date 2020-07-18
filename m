Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A01DC433E3
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 10:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45DE20691
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 10:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45DE20691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwk8C-0007Nn-3j
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 06:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jwk7P-0006z1-Oy
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 06:30:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:39950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jwk7N-0000Ul-Dg
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 06:30:59 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jwk7L-00053q-9V
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 10:30:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 468A12E80E7
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 10:30:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2020 10:24:32 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1878057@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr philmd
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <158921834595.12757.16112597546001644574.malonedeb@wampee.canonical.com>
Message-Id: <159506787209.11805.3527732807105189455.malone@soybean.canonical.com>
Subject: [Bug 1878057] Re: null-ptr dereference in megasas_command_complete
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6cd75ae5f38ef549373c1cf0f5ea14cc1e5d4e8f
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/18 03:50:36
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
Reply-To: Bug 1878057 <1878057@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Might be relevant:

commit 6df5718bd3ec56225c44cf96440c723c1b611b87
Author: Hannes Reinecke <hare@suse.de>
Date:   Wed Oct 29 13:00:15 2014 +0100

    megasas: Rework frame queueing algorithm
    =

    Windows requires the frames to be unmapped, otherwise we run
    into a race condition where the updated frame data is not
    visible to the guest.
    With that we can simplify the queue algorithm and use a bitmap
    for tracking free frames.

 /*
  * This absolutely needs to be locked if
  * qemu ever goes multithreaded.
  */
 static MegasasCmd *megasas_enqueue_frame(MegasasState *s,
     hwaddr frame, uint64_t context, int count)

Using -trace scsi\* -trace megasas\*:

megasas_qf_enqueue frame 0x0 count 0 context 0x0 head 0x0 tail 0x0 busy 1
megasas_handle_scsi LD SCSI dev 1/0/0 sdev 0x5555573f5560 xfer 0
scsi_req_parsed target 0 lun 0 tag 0 command 53 dir 0 length 0
scsi_req_parsed_lba target 0 lun 0 tag 0 command 53 lba 0
scsi_req_alloc target 0 lun 0 tag 0
scsi_disk_new_request Command: lun=3D0 tag=3D0x0 data=3D 0x35 0x00 0x00 0x0=
0 0x00 0x00 0x00 0x00 0x00 0x00
megasas_scsi_nodata scmd 0: no data to be transferred
megasas_mmio_invalid_writel addr 0x44: 0x3101
megasas_mmio_invalid_writel addr 0x48: 0x44b0100
megasas_mmio_invalid_writel addr 0x4c: 0x380100
megasas_mmio_invalid_writel addr 0x50: 0x4b010000
megasas_mmio_invalid_writel addr 0x54: 0x3f010004
megasas_mmio_invalid_writel addr 0x58: 0x1000000
megasas_mmio_invalid_writel addr 0x5c: 0x100044b
megasas_mmio_invalid_writel addr 0x60: 0x46
megasas_mmio_invalid_writel addr 0x64: 0x44b01
megasas_mmio_invalid_writel addr 0x68: 0x4d01
megasas_mmio_invalid_writel addr 0x6c: 0x44b0100
megasas_mmio_invalid_writel addr 0x70: 0x540100
megasas_mmio_invalid_writel addr 0x74: 0x4b010000
megasas_mmio_invalid_writel addr 0x78: 0x5b010004
megasas_mmio_invalid_writel addr 0x7c: 0x1000000
megasas_mmio_invalid_writel addr 0x80: 0x100044b
megasas_mmio_invalid_writel addr 0x84: 0x62
megasas_mmio_invalid_writel addr 0x88: 0x44b01
megasas_mmio_invalid_writel addr 0x8c: 0x6901
megasas_mmio_invalid_writel addr 0x90: 0x44b0100
megasas_mmio_invalid_writel addr 0x94: 0x700100
megasas_mmio_invalid_writel addr 0x98: 0x4b010000
megasas_mmio_invalid_writel addr 0x9c: 0x77010004
megasas_mmio_writel reg MFI_ODCR0: 0x1000000
megasas_mmio_invalid_writel addr 0xa4: 0x100044b
megasas_mmio_invalid_writel addr 0xa8: 0x7e
megasas_mmio_invalid_writel addr 0xac: 0x44b01
megasas_mmio_invalid_writel addr 0xb0: 0x8501
megasas_mmio_invalid_writel addr 0xb4: 0x44b0100
megasas_mmio_invalid_writel addr 0xb8: 0x8c0100
megasas_mmio_invalid_writel addr 0xbc: 0x4b010000
megasas_mmio_writel reg MFI_IQPL: 0x4
megasas_qf_new frame 0x1 addr 0x0
megasas_enqueue_frame fr: 0x7fffa1e00000
megasas_qf_enqueue frame 0x1 count 2 context 0x0 head 0x0 tail 0x0 busy 2
megasas_init_firmware pa 0x0 =

megasas_init_queue queue at 0x0 len 0 head 0x0 tail 0x0 flags 0x0
megasas_unmap_frame fr: 0x7fffa1e44b00
megasas_unmap_frame fr: 0x7fffa1e00000
megasas_qf_complete_noirq context 0x0 =

scsi_req_dequeue target 0 lun 0 tag 0
scsi_aio_complete
megasas_command_complete scmd 0: status 0x0, residual 0
megasas_scsi_complete scmd 0: status 0x0, len 0/0

The frame is unmapped when the complete callback occurs.
Then SIGSEGV in megasas_command_complete():

1856 static void megasas_command_complete(SCSIRequest *req, uint32_t status,
1857                                      size_t resid)
1858 {
1859     MegasasCmd *cmd =3D req->hba_private;
1860     uint8_t cmd_status =3D MFI_STAT_OK;
1861 =

1862     trace_megasas_command_complete(cmd->index, status, resid);
1863 =

1864     if (req->io_canceled) {
1865         return;
1866     }
1867 =

1868     if (cmd->dcmd_opcode !=3D -1) {
1869         /*
1870          * Internal command complete
1871          */
1872         cmd_status =3D megasas_finish_internal_dcmd(cmd, req, resid);
1873         if (cmd_status =3D=3D MFI_STAT_INVALID_STATUS) {
1874             return;
1875         }
1876     } else {
1877         req->status =3D status;
1878         trace_megasas_scsi_complete(cmd->index, req->status,
1879                                     cmd->iov_size, req->cmd.xfer);
1880         if (req->status !=3D GOOD) {
1881             cmd_status =3D MFI_STAT_SCSI_DONE_WITH_ERROR;
1882         }
1883         if (req->status =3D=3D CHECK_CONDITION) {
1884             megasas_copy_sense(cmd);
1885         }
1886 =

1887         cmd->frame->header.scsi_status =3D req->status;

             ^^^^^^^^^^ This is NULL.

1888     }
1889     cmd->frame->header.cmd_status =3D cmd_status;
1890     megasas_complete_command(cmd);
1891 }

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878057

Title:
  null-ptr dereference in megasas_command_complete

Status in QEMU:
  Confirmed

Bug description:
  Hello,
  While fuzzing, I found an input that triggers a null-pointer dereference =
in
  megasas_command_complete:

  =3D=3D14959=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00000=
0000003 (pc 0x55b1d11b4df1 bp 0x7ffeb55ca450 sp 0x7ffeb55ca1e0 T0)
  =3D=3D14959=3D=3DThe signal is caused by a WRITE memory access.
  =3D=3D14959=3D=3DHint: address points to the zero page.
      #0 0x55b1d11b4df1 in megasas_command_complete /home/alxndr/Developmen=
t/qemu/hw/scsi/megasas.c:1877:40
      #1 0x55b1d11759ec in scsi_req_complete /home/alxndr/Development/qemu/=
hw/scsi/scsi-bus.c:1430:5
      #2 0x55b1d115c98f in scsi_aio_complete /home/alxndr/Development/qemu/=
hw/scsi/scsi-disk.c:216:5
      #3 0x55b1d151c638 in blk_aio_complete /home/alxndr/Development/qemu/b=
lock/block-backend.c:1375:9
      #4 0x55b1d151c638 in blk_aio_complete_bh /home/alxndr/Development/qem=
u/block/block-backend.c:1385:5
      #5 0x55b1d16f3a5b in aio_bh_call /home/alxndr/Development/qemu/util/a=
sync.c:136:5
      #6 0x55b1d16f3a5b in aio_bh_poll /home/alxndr/Development/qemu/util/a=
sync.c:164:13
      #7 0x55b1d16fe43e in aio_dispatch /home/alxndr/Development/qemu/util/=
aio-posix.c:380:5
      #8 0x55b1d16f54fa in aio_ctx_dispatch /home/alxndr/Development/qemu/u=
til/async.c:306:5
      #9 0x7f47937c89ed in g_main_context_dispatch (/usr/lib/x86_64-linux-g=
nu/libglib-2.0.so.0+0x4e9ed)
      #10 0x55b1d16fbef4 in glib_pollfds_poll /home/alxndr/Development/qemu=
/util/main-loop.c:219:9
      #11 0x55b1d16fbef4 in os_host_main_loop_wait /home/alxndr/Development=
/qemu/util/main-loop.c:242:5
      #12 0x55b1d16fbef4 in main_loop_wait /home/alxndr/Development/qemu/ut=
il/main-loop.c:518:11
      #13 0x55b1d0cd16a6 in qemu_main_loop /home/alxndr/Development/qemu/so=
ftmmu/vl.c:1664:9
      #14 0x55b1d1608dca in main /home/alxndr/Development/qemu/softmmu/main=
.c:49:5
      #15 0x7f4792378e0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.3=
0/csu/../csu/libc-start.c:308:16
      #16 0x55b1d091d7b9 in _start (/home/alxndr/Development/qemu/build/i38=
6-softmmu/qemu-system-i386+0x8f47b9)

  I can reproduce it in qemu 5.0 built with using:
  cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc=
-q35-5.0 -no-shutdown -M q35 -device megasas -device scsi-cd,drive=3Dnull0 =
-blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull0 -nographic -q=
test stdio -monitor none -serial none
  outl 0xcf8 0x80001814
  outl 0xcfc 0xc021
  outl 0xcf8 0x80001818
  outl 0xcf8 0x80001804
  outw 0xcfc 0x7
  outl 0xcf8 0x80001810
  outl 0xcfc 0xe10c0000
  outl 0xcf8 0x8000f810
  write 0x44b20 0x1 0x35
  write 0x44b00 0x1 0x03
  write 0xc021e10c0040 0x81 0x014b04000131000000014b04000138000000014b04000=
13f000000014b04000146000000014b0400014d000000014b04000154000000014b0400015b=
000000014b04000162000000014b04000169000000014b04000170000000014b04000177000=
000014b0400017e000000014b04000185000000014b0400018c000000014b04
  EOF

  I also attached the trace to this launchpad report, in case the
  formatting is broken:

  qemu-system-i386 -qtest stdio -monitor none -serial none -M pc-q35-5.0
  -no-shutdown -M q35 -device megasas -device scsi-cd,drive=3Dnull0
  -blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull0 -nographic <
  attachment

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878057/+subscriptions


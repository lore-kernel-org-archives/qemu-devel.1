Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E335AC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 06:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B488C20828
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 06:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B488C20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2UwC-0001Fk-LE
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 02:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i2UvR-0000pD-RI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 02:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i2UvQ-0000H1-Bl
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 02:25:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:58870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i2UvQ-0000G0-5i
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 02:25:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i2UvO-0006Zc-IM
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 06:25:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 79CE62E80CD
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 06:25:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Aug 2019 06:16:52 -0000
From: Xujun Ma <1839428@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: maxujun philmd
X-Launchpad-Bug-Reporter: Xujun Ma (maxujun)
X-Launchpad-Bug-Modifier: Xujun Ma (maxujun)
References: <156524772160.13996.4537778553837159229.malonedeb@wampee.canonical.com>
Message-Id: <156688661263.3027.3336339084032447737.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19031";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 227b03d28f2e147e8d0bae4bc485378ecedf23f8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1839428] Re: qemu core dumped when repeat
 "system_reset" multiple times during guest boot
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
Reply-To: Bug 1839428 <1839428@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I found the commit that introduced this regression.

commit 57830a499f7c815bb0cb325c94a3d8c910d13cfa (HEAD)
Author: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date:   Fri Feb 15 16:03:25 2019 +0300

    block: don't set the same context

    Adds a fast path on aio context setting preventing
    unnecessary context setting routine.
    Also, it prevents issues with cyclic walk of child
    bds-es appeared because of registering aio walking
    notifiers:

    Call stack:

    0  __GI_raise
    1  __GI_abort
    2  __assert_fail_base
    3  __GI___assert_fail
    4  bdrv_detach_aio_context (bs=3D0x55f54d65c000)      <<<
    5  bdrv_detach_aio_context (bs=3D0x55f54fc8a800)
    6  bdrv_set_aio_context (bs=3D0x55f54fc8a800, ...)
    7  block_job_attached_aio_context
    8  bdrv_attach_aio_context (bs=3D0x55f54d65c000, ...) <<<
    9  bdrv_set_aio_context (bs=3D0x55f54d65c000)
    10 blk_set_aio_context
    11 virtio_blk_data_plane_stop
    12 virtio_bus_stop_ioeventfd
    13 virtio_vmstate_change
    14 vm_state_notify (running=3D0, state=3DRUN_STATE_SHUTDOWN)
    15 do_vm_stop (state=3DRUN_STATE_SHUTDOWN, send_stop=3Dtrue)
    16 vm_stop (state=3DRUN_STATE_SHUTDOWN)
    17 main_loop_should_exit
    18 main_loop
    19 main

    This can happen because of "new" context attachment to VM disk bds.
    When attaching a new context the corresponding aio context handler is
    called for each of aio_notifiers registered on the VM disk bds context.
    Among those handlers, there is the block_job_attached_aio_context handl=
er
    which sets a new aio context for the block job bds. When doing so,
    the old context is detached from all the block job bds children and one=
 of
    them is the VM disk bds, serving as backing store for the blockjob bds,
    although the VM disk bds is actually the initializer of that process.
    Since the VM disk bds is protected with walking_aio_notifiers flag
    from double processing in recursive calls, the assert fires.

    Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
    Signed-off-by: Kevin Wolf <kwolf@redhat.com>

diff --git a/block.c b/block.c
index 4ad0e90d7e..0c12632661 100644
--- a/block.c
+++ b/block.c
@@ -5265,6 +5265,10 @@ void bdrv_set_aio_context(BlockDriverState *bs, AioC=
ontext *new_context)
 {
     AioContext *ctx =3D bdrv_get_aio_context(bs);

+    if (ctx =3D=3D new_context) {
+        return;
+    }
+
     aio_disable_external(ctx);
     bdrv_parent_drained_begin(bs, NULL, false);
     bdrv_drain(bs); /* ensure there are no in-flight requests */

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1839428

Title:
   qemu core dumped when repeat "system_reset" multiple times during
  guest boot

Status in QEMU:
  Confirmed

Bug description:
  commit 864ab314f1d924129d06ac7b571f105a2b76a4b2 (HEAD, tag: v4.1.0-rc4, o=
rigin/master, origin/HEAD, master)
  Test arch:x86 and power

  Steps:
  1.Boot up guest with command
  power cmdline:
  /usr/libexec/backup/qemu-kvm \
   -smp 8 \
   -m 4096 \
   -nodefaults \
   -device virtio-blk-pci,id=3Dimage1,drive=3Ddrive_image1,bootindex=3D1,bu=
s=3Dpci.0,addr=3D0x7 \
   -drive file=3Drhel77-ppc64le-virtio.qcow2,if=3Dnone,id=3Ddrive_image1,fo=
rmat=3Dqcow2,cache=3Dnone \
   -chardev stdio,mux=3Don,id=3Dserial_id_serial0,server,nowait,signal=3Dof=
f \
   -device spapr-vty,id=3Dserial111,chardev=3Dserial_id_serial0 \
   -mon chardev=3Dserial_id_serial0,mode=3Dreadline \
  x86 cmdline:
  /usr/libexec/qemu-kvm \
   -m 4096 -smp 8 \
   -boot menu=3Don \
   -device virtio-blk-pci,id=3Dimage1,drive=3Ddrive_image1\
   -drive file=3Drhel77-64-virtio.qcow2,if=3Dnone,id=3Ddrive_image1,format=
=3Dqcow2,cache=3Dnone \
   -vga std \
   -vnc :9 \
   -nographic \
   -device virtio-net-pci,netdev=3Dnet0,id=3Dnic0,mac=3D52:54:00:c4:e7:84 \
   -netdev tap,id=3Dnet0,script=3D/etc/qemu-ifup,downscript=3D/etc/qemu-ifd=
own,vhost=3Don \

  2.when guest start to boot up kernel(when no output infomation),run
  hmp command "system_reset"

  =

  Result:

  Sometimes,qemu core dumped with error as following:
  system_reset
  (qemu) qemu-system-ppc64: /root/qemu/hw/virtio/virtio.c:225: vring_get_re=
gion_caches: Assertion `caches !=3D NULL' failed.
  b.sh: line 11: 73679 Aborted                 (core dumped) /usr/local/bin=
/qemu-system-ppc64 -enable-kvm -smp 8 -m 4096 -nodefaults -device virtio-bl=
k-pci,id=3Dimage1,drive=3Ddrive_image1,bootindex=3D1,bus=3Dpci.0,addr=3D0x7=
 -drive file=3Drhel77-ppc64le-virtio.qcow2,if=3Dnone,id=3Ddrive_image1,form=
at=3Dqcow2,cache=3Dnone -chardev stdio,mux=3Don,id=3Dserial_id_serial0,serv=
er,nowait,signal=3Doff -device spapr-vty,id=3Dserial111,chardev=3Dserial_id=
_serial0 -mon chardev=3Dserial_id_serial0,mode=3Dreadline

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1839428/+subscriptions


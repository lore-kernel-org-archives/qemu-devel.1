Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E71C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:31:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108D0206D4
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108D0206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2bUv-0005te-8j
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 10:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2bUF-0005Rj-Mw
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 10:30:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:47270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2bUD-0004h5-BI
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 10:30:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k2bUA-0008J8-Hg
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 14:30:42 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 82E462E80DC
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 14:30:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2020 14:23:19 -0000
From: Alexander Bulekov <1890155@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <159646459931.15346.8925027856621311713.malonedeb@wampee.canonical.com>
Subject: [Bug 1890155] [NEW] Abort in vmxnet3_validate_interrupt_idx
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 66abf3bbca6c57fdcc77b3f158f0e9281288eaaa
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 07:00:58
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
Reply-To: Bug 1890155 <1890155@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,
Reproducer:

cat << EOF | ./i386-softmmu/qemu-system-i386 \
-device vmxnet3 -m 64 -nodefaults -qtest stdio -nographic
outl 0xcf8 0x80001014
outl 0xcfc 0xe0001000
outl 0xcf8 0x80001018
outl 0xcf8 0x80001004
outw 0xcfc 0x7
write 0x0 0x1 0xe1
write 0x1 0x1 0xfe
write 0x2 0x1 0xbe
write 0x3 0x1 0xba
write 0x52 0x1 0x61
writeq 0xe0001020 0xef0bff5ecafe0000
EOF

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 #7 0x55b271a89b67 in hw_error /home/alxndr/Development/qemu/general-fuzz/s=
oftmmu/cpus.c:927:5
 #8 0x55b272fc6433 in vmxnet3_validate_interrupt_idx /home/alxndr/Developme=
nt/qemu/general-fuzz/hw/net/vmxnet3.c:1355:9
 #9 0x55b272fc4e6d in vmxnet3_validate_interrupts /home/alxndr/Development/=
qemu/general-fuzz/hw/net/vmxnet3.c:1364:5
 #10 0x55b272fbe723 in vmxnet3_activate_device /home/alxndr/Development/qem=
u/general-fuzz/hw/net/vmxnet3.c:1546:5
 #11 0x55b272fb6fba in vmxnet3_handle_command /home/alxndr/Development/qemu=
/general-fuzz/hw/net/vmxnet3.c:1576:9
 #12 0x55b272fb410f in vmxnet3_io_bar1_write /home/alxndr/Development/qemu/=
general-fuzz/hw/net/vmxnet3.c:1772:9
 #13 0x55b271ac4193 in memory_region_write_accessor /home/alxndr/Developmen=
t/qemu/general-fuzz/softmmu/memory.c:483:5
 #14 0x55b271ac3637 in access_with_adjusted_size /home/alxndr/Development/q=
emu/general-fuzz/softmmu/memory.c:544:18
 #15 0x55b271ac1256 in memory_region_dispatch_write /home/alxndr/Developmen=
t/qemu/general-fuzz/softmmu/memory.c:1466:16
 #16 0x55b270e724a6 in flatview_write_continue /home/alxndr/Development/qem=
u/general-fuzz/exec.c:3176:23
 #17 0x55b270e5acc6 in flatview_write /home/alxndr/Development/qemu/general=
-fuzz/exec.c:3216:14


qemu: hardware error: Bad interrupt index: 97
Aborted

-Alex

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890155

Title:
  Abort in vmxnet3_validate_interrupt_idx

Status in QEMU:
  New

Bug description:
  Hello,
  Reproducer:

  cat << EOF | ./i386-softmmu/qemu-system-i386 \
  -device vmxnet3 -m 64 -nodefaults -qtest stdio -nographic
  outl 0xcf8 0x80001014
  outl 0xcfc 0xe0001000
  outl 0xcf8 0x80001018
  outl 0xcf8 0x80001004
  outw 0xcfc 0x7
  write 0x0 0x1 0xe1
  write 0x1 0x1 0xfe
  write 0x2 0x1 0xbe
  write 0x3 0x1 0xba
  write 0x52 0x1 0x61
  writeq 0xe0001020 0xef0bff5ecafe0000
  EOF

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   #7 0x55b271a89b67 in hw_error /home/alxndr/Development/qemu/general-fuzz=
/softmmu/cpus.c:927:5
   #8 0x55b272fc6433 in vmxnet3_validate_interrupt_idx /home/alxndr/Develop=
ment/qemu/general-fuzz/hw/net/vmxnet3.c:1355:9
   #9 0x55b272fc4e6d in vmxnet3_validate_interrupts /home/alxndr/Developmen=
t/qemu/general-fuzz/hw/net/vmxnet3.c:1364:5
   #10 0x55b272fbe723 in vmxnet3_activate_device /home/alxndr/Development/q=
emu/general-fuzz/hw/net/vmxnet3.c:1546:5
   #11 0x55b272fb6fba in vmxnet3_handle_command /home/alxndr/Development/qe=
mu/general-fuzz/hw/net/vmxnet3.c:1576:9
   #12 0x55b272fb410f in vmxnet3_io_bar1_write /home/alxndr/Development/qem=
u/general-fuzz/hw/net/vmxnet3.c:1772:9
   #13 0x55b271ac4193 in memory_region_write_accessor /home/alxndr/Developm=
ent/qemu/general-fuzz/softmmu/memory.c:483:5
   #14 0x55b271ac3637 in access_with_adjusted_size /home/alxndr/Development=
/qemu/general-fuzz/softmmu/memory.c:544:18
   #15 0x55b271ac1256 in memory_region_dispatch_write /home/alxndr/Developm=
ent/qemu/general-fuzz/softmmu/memory.c:1466:16
   #16 0x55b270e724a6 in flatview_write_continue /home/alxndr/Development/q=
emu/general-fuzz/exec.c:3176:23
   #17 0x55b270e5acc6 in flatview_write /home/alxndr/Development/qemu/gener=
al-fuzz/exec.c:3216:14

  =

  qemu: hardware error: Bad interrupt index: 97
  Aborted

  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890155/+subscriptions


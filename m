Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83D9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE1F2076E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE1F2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2bZW-0007dH-E2
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 10:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2bYt-0006qo-Be
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 10:35:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:48000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2bYr-00059d-JU
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 10:35:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k2bYq-0000NB-IG
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 14:35:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 85B6F2E80D2
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 14:35:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2020 14:28:44 -0000
From: Alexander Bulekov <1890157@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <159646492473.2215.15136197151554355859.malonedeb@gac.canonical.com>
Subject: [Bug 1890157] [NEW] Assertion failure in net_tx_pkt_reset through
 vmxnet3
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b186fbeb7e0225f17015653be6d2ab9ec2747cd2
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
Reply-To: Bug 1890157 <1890157@bugs.launchpad.net>
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
outl 0xcf8 0x80001083
write 0x0 0x1 0xe1
write 0x1 0x1 0xfe
write 0x2 0x1 0xbe
write 0x3 0x1 0xba
writeq 0xe0001020 0xefefff5ecafe0000
writeq 0xe0001020 0xffff5e5ccafe0002
EOF

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
qemu-system-i386: /home/alxndr/Development/qemu/general-fuzz/hw/net/net_tx_=
pkt.c:450: void net_tx_pkt_reset(struct NetTxPkt *): Assertion `pkt->raw' f=
ailed.

    #9 0x564838761930 in net_tx_pkt_reset /home/alxndr/Development/qemu/gen=
eral-fuzz/hw/net/net_tx_pkt.c:450:5
    #10 0x564838881749 in vmxnet3_deactivate_device /home/alxndr/Developmen=
t/qemu/general-fuzz/hw/net/vmxnet3.c:1159:9
    #11 0x56483888cf71 in vmxnet3_reset /home/alxndr/Development/qemu/gener=
al-fuzz/hw/net/vmxnet3.c:1170:5
    #12 0x564838882124 in vmxnet3_handle_command /home/alxndr/Development/q=
emu/general-fuzz/hw/net/vmxnet3.c:1610:9
    #13 0x56483887f10f in vmxnet3_io_bar1_write /home/alxndr/Development/qe=
mu/general-fuzz/hw/net/vmxnet3.c:1772:9
    #14 0x56483738f193 in memory_region_write_accessor /home/alxndr/Develop=
ment/qemu/general-fuzz/softmmu/memory.c:483:5
    #15 0x56483738e637 in access_with_adjusted_size /home/alxndr/Developmen=
t/qemu/general-fuzz/softmmu/memory.c:544:18
    #16 0x56483738c256 in memory_region_dispatch_write /home/alxndr/Develop=
ment/qemu/general-fuzz/softmmu/memory.c:1466:16
    #17 0x56483673d4a6 in flatview_write_continue /home/alxndr/Development/=
qemu/general-fuzz/exec.c:3176:23

-Alex

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890157

Title:
  Assertion failure in net_tx_pkt_reset through vmxnet3

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
  outl 0xcf8 0x80001083
  write 0x0 0x1 0xe1
  write 0x1 0x1 0xfe
  write 0x2 0x1 0xbe
  write 0x3 0x1 0xba
  writeq 0xe0001020 0xefefff5ecafe0000
  writeq 0xe0001020 0xffff5e5ccafe0002
  EOF

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  qemu-system-i386: /home/alxndr/Development/qemu/general-fuzz/hw/net/net_t=
x_pkt.c:450: void net_tx_pkt_reset(struct NetTxPkt *): Assertion `pkt->raw'=
 failed.

      #9 0x564838761930 in net_tx_pkt_reset /home/alxndr/Development/qemu/g=
eneral-fuzz/hw/net/net_tx_pkt.c:450:5
      #10 0x564838881749 in vmxnet3_deactivate_device /home/alxndr/Developm=
ent/qemu/general-fuzz/hw/net/vmxnet3.c:1159:9
      #11 0x56483888cf71 in vmxnet3_reset /home/alxndr/Development/qemu/gen=
eral-fuzz/hw/net/vmxnet3.c:1170:5
      #12 0x564838882124 in vmxnet3_handle_command /home/alxndr/Development=
/qemu/general-fuzz/hw/net/vmxnet3.c:1610:9
      #13 0x56483887f10f in vmxnet3_io_bar1_write /home/alxndr/Development/=
qemu/general-fuzz/hw/net/vmxnet3.c:1772:9
      #14 0x56483738f193 in memory_region_write_accessor /home/alxndr/Devel=
opment/qemu/general-fuzz/softmmu/memory.c:483:5
      #15 0x56483738e637 in access_with_adjusted_size /home/alxndr/Developm=
ent/qemu/general-fuzz/softmmu/memory.c:544:18
      #16 0x56483738c256 in memory_region_dispatch_write /home/alxndr/Devel=
opment/qemu/general-fuzz/softmmu/memory.c:1466:16
      #17 0x56483673d4a6 in flatview_write_continue /home/alxndr/Developmen=
t/qemu/general-fuzz/exec.c:3176:23

  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890157/+subscriptions


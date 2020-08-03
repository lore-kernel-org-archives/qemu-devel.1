Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4021CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196CB207DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 14:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196CB207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2bes-0001Bu-B9
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 10:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2be2-0000lW-Bv
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 10:40:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:49118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k2be0-0005uY-AB
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 10:40:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k2bdy-0001BC-8U
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 14:40:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 351FC2E802E
 for <qemu-devel@nongnu.org>; Mon,  3 Aug 2020 14:40:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2020 14:33:40 -0000
From: Alexander Bulekov <1890159@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Alexander Bulekov (a1xndr)
Message-Id: <159646522011.3204.4947256792028563402.malonedeb@gac.canonical.com>
Subject: [Bug 1890159] [NEW] Assertion failure in net_tx_pkt_add_raw_fragment
 through vmxnet3
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 12f0eb8ab9a40f992c453d6f746abc99258ae9cb
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
Reply-To: Bug 1890159 <1890159@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello,
Reproducer:

cat << EOF | ./i386-softmmu/qemu-system-i386 \
-device vmxnet3 -m 64 -nodefaults -qtest stdio -nographic
outl 0xcf8 0x80001010
outl 0xcfc 0xe0000000
outl 0xcf8 0x80001014
outl 0xcfc 0xe0001000
outl 0xcf8 0x80001018
outl 0xcf8 0x80001001
outl 0xcfc 0x3fff3fff
outl 0xcf8 0x80001016
outl 0xcfc 0x5c84ff00
outl 0xcf8 0x800010ff
write 0x0 0x1 0xe1
write 0x1 0x1 0xfe
write 0x2 0x1 0xbe
write 0x3 0x1 0xba
writeq 0xff001020 0xef0bff5ecafe0000
writel 0xe0000605 0xa7ff845e
EOF

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
qemu-system-i386: hw/net/net_tx_pkt.c:382: _Bool net_tx_pkt_add_raw_fragmen=
t(struct NetTxPkt *, hwaddr, size_t): Assertion `pkt->max_raw_frags > pkt->=
raw_frags' failed.
Aborted


#9 0x5607db7efdc0 in net_tx_pkt_add_raw_fragment /home/alxndr/Development/q=
emu/general-fuzz/hw/net/net_tx_pkt.c:382:5
#10 0x5607db902ef0 in vmxnet3_process_tx_queue /home/alxndr/Development/qem=
u/general-fuzz/hw/net/vmxnet3.c:653:18
#11 0x5607db9021db in vmxnet3_io_bar0_write /home/alxndr/Development/qemu/g=
eneral-fuzz/hw/net/vmxnet3.c:1097:9
#12 0x5607da41f193 in memory_region_write_accessor /home/alxndr/Development=
/qemu/general-fuzz/softmmu/memory.c:483:5
#13 0x5607da41e637 in access_with_adjusted_size /home/alxndr/Development/qe=
mu/general-fuzz/softmmu/memory.c:544:18
#14 0x5607da41c256 in memory_region_dispatch_write /home/alxndr/Development=
/qemu/general-fuzz/softmmu/memory.c:1466:16
#15 0x5607d97cd4a6 in flatview_write_continue /home/alxndr/Development/qemu=
/general-fuzz/exec.c:3176:23

-Alex

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890159

Title:
  Assertion failure in net_tx_pkt_add_raw_fragment through vmxnet3

Status in QEMU:
  New

Bug description:
  Hello,
  Reproducer:

  cat << EOF | ./i386-softmmu/qemu-system-i386 \
  -device vmxnet3 -m 64 -nodefaults -qtest stdio -nographic
  outl 0xcf8 0x80001010
  outl 0xcfc 0xe0000000
  outl 0xcf8 0x80001014
  outl 0xcfc 0xe0001000
  outl 0xcf8 0x80001018
  outl 0xcf8 0x80001001
  outl 0xcfc 0x3fff3fff
  outl 0xcf8 0x80001016
  outl 0xcfc 0x5c84ff00
  outl 0xcf8 0x800010ff
  write 0x0 0x1 0xe1
  write 0x1 0x1 0xfe
  write 0x2 0x1 0xbe
  write 0x3 0x1 0xba
  writeq 0xff001020 0xef0bff5ecafe0000
  writel 0xe0000605 0xa7ff845e
  EOF

  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  qemu-system-i386: hw/net/net_tx_pkt.c:382: _Bool net_tx_pkt_add_raw_fragm=
ent(struct NetTxPkt *, hwaddr, size_t): Assertion `pkt->max_raw_frags > pkt=
->raw_frags' failed.
  Aborted

  =

  #9 0x5607db7efdc0 in net_tx_pkt_add_raw_fragment /home/alxndr/Development=
/qemu/general-fuzz/hw/net/net_tx_pkt.c:382:5
  #10 0x5607db902ef0 in vmxnet3_process_tx_queue /home/alxndr/Development/q=
emu/general-fuzz/hw/net/vmxnet3.c:653:18
  #11 0x5607db9021db in vmxnet3_io_bar0_write /home/alxndr/Development/qemu=
/general-fuzz/hw/net/vmxnet3.c:1097:9
  #12 0x5607da41f193 in memory_region_write_accessor /home/alxndr/Developme=
nt/qemu/general-fuzz/softmmu/memory.c:483:5
  #13 0x5607da41e637 in access_with_adjusted_size /home/alxndr/Development/=
qemu/general-fuzz/softmmu/memory.c:544:18
  #14 0x5607da41c256 in memory_region_dispatch_write /home/alxndr/Developme=
nt/qemu/general-fuzz/softmmu/memory.c:1466:16
  #15 0x5607d97cd4a6 in flatview_write_continue /home/alxndr/Development/qe=
mu/general-fuzz/exec.c:3176:23

  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890159/+subscriptions


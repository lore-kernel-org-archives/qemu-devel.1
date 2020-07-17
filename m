Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F05C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB172064C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 17:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB172064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUWB-0007Kd-V7
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 13:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jwUVW-0006vy-RD
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:50:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:33456)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jwUVU-0004EB-As
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 13:50:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jwUVR-000611-Ru
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 17:50:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B09622E80F1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 17:50:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2020 17:39:32 -0000
From: "Dr. David Alan Gilbert" <1878043@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=dgilbert@redhat.com; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr dgilbert-h
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Dr. David Alan Gilbert (dgilbert-h)
References: <158921393717.5475.17098174167918208525.malonedeb@soybean.canonical.com>
Message-Id: <159500757206.13740.11189896052809716530.malone@gac.canonical.com>
Subject: [Bug 1878043] Re: memcpy param-overlap in Slirp ip_stripoptions
 through e1000e
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 080ef00e22f72d17a9813ae60c302d3431aac929
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 11:25:37
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
Reply-To: Bug 1878043 <1878043@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Committed in upstream libslirp:

commit d620bac888923524f8b8407dbf35f6d2b3b7ddb2 (origin/lp1878043, lp187804=
3)
Author: Dr. David Alan Gilbert <dgilbert@redhat.com>
Date:   Fri Jul 17 18:17:41 2020 +0100

    ip_stripoptions use memmove

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878043

Title:
  memcpy param-overlap in Slirp ip_stripoptions through e1000e

Status in QEMU:
  In Progress

Bug description:
  Hello,
  While fuzzing, I found an input that triggers an overlapping memcpy (caug=
ht by AddressSanitizer).
  Overlapping memcpys are undefined behavior according to the POSIX and C s=
tandards, and can lead to bugs.

  =3D=3D16666=3D=3DERROR: AddressSanitizer: memcpy-param-overlap: memory ra=
nges [0x625000264940,0x62500026699a) and [0x625000264948, 0x6250002669a2) o=
verlap
      #0 0x5622d7b6a3d4 in __asan_memcpy (/home/alxndr/Development/qemu/bui=
ld/i386-softmmu/qemu-system-i386+0x96c3d4)
      #1 0x5622d896a2d2 in ip_stripoptions /home/alxndr/Development/qemu/sl=
irp/src/ip_input.c:457:5
      #2 0x5622d8963378 in udp_input /home/alxndr/Development/qemu/slirp/sr=
c/udp.c:86:9
      #3 0x5622d89351ea in slirp_input /home/alxndr/Development/qemu/slirp/=
src/slirp.c:840:13
      #4 0x5622d852e162 in net_slirp_receive /home/alxndr/Development/qemu/=
net/slirp.c:126:5
      #5 0x5622d8515851 in nc_sendv_compat /home/alxndr/Development/qemu/ne=
t/net.c:700:15
      #6 0x5622d8515851 in qemu_deliver_packet_iov /home/alxndr/Development=
/qemu/net/net.c:728:15
      #7 0x5622d851786d in qemu_net_queue_deliver_iov /home/alxndr/Developm=
ent/qemu/net/queue.c:179:11
      #8 0x5622d851786d in qemu_net_queue_send_iov /home/alxndr/Development=
/qemu/net/queue.c:224:11
      #9 0x5622d851b1c1 in net_hub_receive_iov /home/alxndr/Development/qem=
u/net/hub.c:74:9
      #10 0x5622d851b1c1 in net_hub_port_receive_iov /home/alxndr/Developme=
nt/qemu/net/hub.c:125:12
      #11 0x5622d851572b in qemu_deliver_packet_iov /home/alxndr/Developmen=
t/qemu/net/net.c:726:15
      #12 0x5622d851786d in qemu_net_queue_deliver_iov /home/alxndr/Develop=
ment/qemu/net/queue.c:179:11
      #13 0x5622d851786d in qemu_net_queue_send_iov /home/alxndr/Developmen=
t/qemu/net/queue.c:224:11
      #14 0x5622d828bf87 in net_tx_pkt_sendv /home/alxndr/Development/qemu/=
hw/net/net_tx_pkt.c:546:9
      #15 0x5622d828bf87 in net_tx_pkt_send /home/alxndr/Development/qemu/h=
w/net/net_tx_pkt.c:620:9
      #16 0x5622d82b5f22 in e1000e_tx_pkt_send /home/alxndr/Development/qem=
u/hw/net/e1000e_core.c:666:16
      #17 0x5622d82b5f22 in e1000e_process_tx_desc /home/alxndr/Development=
/qemu/hw/net/e1000e_core.c:743:17
      #18 0x5622d82b5f22 in e1000e_start_xmit /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:934:9
      #19 0x5622d82b2be0 in e1000e_set_tdt /home/alxndr/Development/qemu/hw=
/net/e1000e_core.c:2451:9
      #20 0x5622d82a30fc in e1000e_core_write /home/alxndr/Development/qemu=
/hw/net/e1000e_core.c:3261:9
      #21 0x5622d7c9e336 in memory_region_write_accessor /home/alxndr/Devel=
opment/qemu/memory.c:483:5
      #22 0x5622d7c9dcdf in access_with_adjusted_size /home/alxndr/Developm=
ent/qemu/memory.c:544:18
      #23 0x5622d7c9dcdf in memory_region_dispatch_write /home/alxndr/Devel=
opment/qemu/memory.c:1476:16
      #24 0x5622d7bb31d3 in flatview_write_continue /home/alxndr/Developmen=
t/qemu/exec.c:3137:23
      #25 0x5622d7babb97 in flatview_write /home/alxndr/Development/qemu/ex=
ec.c:3177:14
      #26 0x5622d7babb97 in address_space_write /home/alxndr/Development/qe=
mu/exec.c:3268:18

  0x625000264940 is located 64 bytes inside of 8354-byte region [0x62500026=
4900,0x6250002669a2)
  allocated by thread T0 here:
      #0 0x5622d7b6b06d in malloc (/home/alxndr/Development/qemu/build/i386=
-softmmu/qemu-system-i386+0x96d06d)
      #1 0x7f724b932500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.=
so.0+0x54500)

  0x625000264948 is located 72 bytes inside of 8354-byte region [0x62500026=
4900,0x6250002669a2)
  allocated by thread T0 here:
      #0 0x5622d7b6b06d in malloc (/home/alxndr/Development/qemu/build/i386=
-softmmu/qemu-system-i386+0x96d06d)
      #1 0x7f724b932500 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.0.=
so.0+0x54500)

  I can reproduce it in qemu 5.0 built with --enable-sanitizers using:
  cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc=
-q35-5.0 -accel qtest -qtest stdio -nographic -monitor none -serial none
  outl 0xcf8 0x80001010
  outl 0xcfc 0xe1020000
  outl 0xcf8 0x80001014
  outl 0xcf8 0x80001004
  outw 0xcfc 0x7
  outl 0xcf8 0x800010a2
  outl 0xcf8 0x8000fa24
  outl 0xcfc 0xe1069000
  outl 0xcf8 0x8000fa04
  outw 0xcfc 0x7
  outl 0xcf8 0x8000fb20
  write 0xe1069100 0xe 0xff810000000000008420f9e10019
  write 0x820b 0xc 0x080047bb0c02e10000004011
  write 0xe1020403 0x36 0xb700000000e1000f009006e100000000625c5e0000b700000=
000e1000f009006e100000000625c5e0000b700000000e1000f009006e1
  EOF

  I also attached the trace to this launchpad report, in case the
  formatting is broken:

  qemu-system-i386 -M pc-q35-5.0 -accel qtest -qtest stdio -nographic
  -monitor none -serial none < attachment

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878043/+subscriptions


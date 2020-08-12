Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076BDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 11:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AB420781
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 11:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AB420781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5ogf-0004dm-2i
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 07:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5ofv-0003ze-Qu
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 07:12:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:48694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5oft-0001QP-IY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 07:12:07 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5ofq-0002pe-Hy
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:12:02 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 798BD2E812D
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:12:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2020 11:04:09 -0000
From: Stefan Hajnoczi <1890360@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Stefan Hajnoczi (stefanha)
References: <159659017753.10948.1930355246009105000.malonedeb@chaenomeles.canonical.com>
Message-Id: <159723025043.22066.18112604098006063299.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1890360] Re: Assertion failure in address_space_unmap through
 virtio-blk
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 5e4207a14b17d50edb7ff3372036f6917407f4ee
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:10:59
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
Reply-To: Bug 1890360 <1890360@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Changed in: qemu
       Status: New =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1890360

Title:
  Assertion failure in address_space_unmap through virtio-blk

Status in QEMU:
  In Progress

Bug description:
  Hello,
  Reproducer:
  cat << EOF | ./i386-softmmu/qemu-system-i386 \
  -drive id=3Dmydrive,file=3Dnull-co://,size=3D2M,format=3Draw,if=3Dnone \
  -device virtio-blk,drive=3Dmydrive \
  -nodefaults -nographic -qtest stdio
  outl 0xcf8 0x80001010
  outl 0xcfc 0xc001
  outl 0xcf8 0x80001014
  outl 0xcf8 0x80001004
  outw 0xcfc 0x7
  outl 0xc006 0x3aff9090
  outl 0xcf8 0x8000100e
  outl 0xcfc 0x41005e1e
  write 0x3b00002 0x1 0x5e
  write 0x3b00004 0x1 0x5e
  write 0x3aff5e6 0x1 0x11
  write 0x3aff5eb 0x1 0xc6
  write 0x3aff5ec 0x1 0xc6
  write 0x7 0x1 0xff
  write 0x8 0x1 0xfb
  write 0xc 0x1 0x11
  write 0xe 0x1 0x5e
  write 0x5e8 0x1 0x11
  write 0x5ec 0x1 0xc6
  outl 0x410e 0x10e
  EOF

  =

  qemu-fuzz-i386: /exec.c:3623: void address_space_unmap(AddressSpace *, vo=
id *, hwaddr, _Bool, hwaddr): Assertion `mr !=3D NULL' failed.
  =3D=3D789=3D=3D ERROR: libFuzzer: deadly signal
      #8  in __assert_fail /build/glibc-GwnBeO/glibc-2.30/assert/assert.c:1=
01:3
      #9  in address_space_unmap /exec.c:3623:9
      #10 in dma_memory_unmap /include/sysemu/dma.h:145:5
      #11 in virtqueue_unmap_sg /hw/virtio/virtio.c:690:9
      #12 in virtqueue_fill /hw/virtio/virtio.c:843:5
      #13 in virtqueue_push /hw/virtio/virtio.c:917:5
      #14 in virtio_blk_req_complete /hw/block/virtio-blk.c:83:5
      #15 in virtio_blk_handle_request /hw/block/virtio-blk.c:671:13
      #16 in virtio_blk_handle_vq /hw/block/virtio-blk.c:780:17
      #17 in virtio_queue_notify_aio_vq /hw/virtio/virtio.c:2324:15
      #18 in virtio_queue_host_notifier_aio_read /hw/virtio/virtio.c:3495:9
      #19 in aio_dispatch_handler /util/aio-posix.c:328:9
      #20 in aio_dispatch_handlers /util/aio-posix.c:371:20
      #21 in aio_dispatch /util/aio-posix.c:381:5
      #22 in aio_ctx_dispatch /util/async.c:306:5
      #23 in g_main_context_dispatch

  =

  With -trace virtio\*

  ...
  [S +0.099667] OK
  [R +0.099681] write 0x5ec 0x1 0xc6
  OK
  [S +0.099690] OK
  [R +0.099700] outl 0x410e 0x10e
  29575@1596590112.074339:virtio_queue_notify vdev 0x62d000030590 n 0 vq 0x=
7f9b93fc9800
  29575@1596590112.074423:virtio_blk_data_plane_start dataplane 0x60600000f=
260
  OK
  [S +0.099833] OK
  29575@1596590112.076459:virtio_queue_notify vdev 0x62d000030590 n 0 vq 0x=
7f9b93fc9800
  29575@1596590112.076642:virtio_blk_handle_read vdev 0x62d000030590 req 0x=
611000043e80 sector 0 nsectors 0
  29575@1596590112.076651:virtio_blk_req_complete vdev 0x62d000030590 req 0=
x611000043e80 status 1
  qemu-system-i386: /home/alxndr/Development/qemu/general-fuzz/exec.c:3623:=
 void address_space_unmap(AddressSpace *, void *, hwaddr, _Bool, hwaddr): A=
ssertion `mr !=3D NULL' failed.

  =

  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1890360/+subscriptions


Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09135C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9D3206D5
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 14:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9D3206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcrjm-00027V-1e
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 10:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcrix-0001Ii-Pq
 for qemu-devel@nongnu.org; Sun, 24 May 2020 10:35:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:49626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcriw-0008GH-3n
 for qemu-devel@nongnu.org; Sun, 24 May 2020 10:35:35 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jcrit-0001jq-3M
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 14:35:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E50D22E8080
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 14:35:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2020 14:27:48 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1880355@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr philmd pmaydell
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <159029353528.907.11982786579949073896.malonedeb@chaenomeles.canonical.com>
 <ced59c5e-01e9-9da6-5191-9d34ffa976b0@redhat.com>
 <CAFEAcA83E33xNjhXvbZr9oe7TO9kMa0nArroCA_mY3zy+0bq2g@mail.gmail.com>
Message-ID: <c8326e26-c529-18c1-4bd2-63a5aec071fb@redhat.com>
Subject: Re: [Bug 1880355] [NEW] Length restrictions for fw_cfg_dma_transfer?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: dadcf6e8d9dcd1ab4f65be9be1af8fca06881d1d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 09:50:35
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
Reply-To: Bug 1880355 <1880355@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200524142748.rDfBLFhRcc5ZCZwSQskrdRUGJaGsxK4WpfA-z8RusRU@z>

On 5/24/20 3:40 PM, Peter Maydell wrote:
> On Sun, 24 May 2020 at 11:30, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>> It looks to me a normal behavior for a DMA device. DMA devices have a
>> different address space view than the CPUs.
>> Also note the fw_cfg is a generic device, not restricted to the x86 arch.
> =

> In an ideal world all our DMA devices would use some kind of common
> framework or design pattern so they didn't hog all the CPU
> and/or spend minutes with the BQL held if the guest requests
> an enormous-sized DMA. In practice many of them just have
> a simple "loop until the DMA transfer is complete" implementation...

Is this framework already implemented in the hidden dma-helpers.c?

Apparently this file was written for BlockBackend, but the code seems
rather generic.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880355

Title:
  Length restrictions for fw_cfg_dma_transfer?

Status in QEMU:
  New

Bug description:
  For me, this takes close to 3 minutes at 100% CPU:
  echo "outl 0x518 0x9596ffff" | ./i386-softmmu/qemu-system-i386 -M q35 -m =
32 -nographic -accel qtest -monitor none -serial none -qtest stdio

  #0  phys_page_find (d=3D0x606000035d80, addr=3D136728041144404) at /exec.=
c:338
  #1  address_space_lookup_region (d=3D0x606000035d80, addr=3D1367280411444=
04, resolve_subpage=3Dtrue) at /exec.c:363
  #2  address_space_translate_internal (d=3D0x606000035d80, addr=3D13672804=
1144404, xlat=3D0x7fff1fc0d070, plen=3D0x7fff1fc0d090, resolve_subpage=3Dtr=
ue) at /exec.c:382
  #3  flatview_do_translate (fv=3D0x606000035d20, addr=3D136728041144404, x=
lat=3D0x7fff1fc0d070, plen_out=3D0x7fff1fc0d090, page_mask_out=3D0x0, is_wr=
ite=3Dtrue, is_mmio=3Dtrue, target_as=3D0x7fff1fc0ce10, attrs=3D...)
      pment/qemu/exec.c:520
  #4  flatview_translate (fv=3D0x606000035d20, addr=3D136728041144404, xlat=
=3D0x7fff1fc0d070, plen=3D0x7fff1fc0d090, is_write=3Dtrue, attrs=3D...) at =
/exec.c:586
  #5  flatview_write_continue (fv=3D0x606000035d20, addr=3D136728041144404,=
 attrs=3D..., ptr=3D0x7fff1fc0d660, len=3D172, addr1=3D136728041144400, l=
=3D172, mr=3D0x557fd54e77e0 <io_mem_unassigned>)
      pment/qemu/exec.c:3160
  #6  flatview_write (fv=3D0x606000035d20, addr=3D136728041144064, attrs=3D=
..., buf=3D0x7fff1fc0d660, len=3D512) at /exec.c:3177
  #7  address_space_write (as=3D0x557fd54e7a00 <address_space_memory>, addr=
=3D136728041144064, attrs=3D..., buf=3D0x7fff1fc0d660, len=3D512) at /exec.=
c:3271
  #8  dma_memory_set (as=3D0x557fd54e7a00 <address_space_memory>, addr=3D13=
6728041144064, c=3D0 '\000', len=3D1378422272) at /dma-helpers.c:31
  #9  fw_cfg_dma_transfer (s=3D0x61a000001e80) at /hw/nvram/fw_cfg.c:400
  #10 fw_cfg_dma_mem_write (opaque=3D0x61a000001e80, addr=3D4, value=3D4294=
940309, size=3D4) at /hw/nvram/fw_cfg.c:467
  #11 memory_region_write_accessor (mr=3D0x61a000002200, addr=3D4, value=3D=
0x7fff1fc0e3d0, size=3D4, shift=3D0, mask=3D4294967295, attrs=3D...) at /me=
mory.c:483
  #12 access_with_adjusted_size (addr=3D4, value=3D0x7fff1fc0e3d0, size=3D4=
, access_size_min=3D1, access_size_max=3D8, access_fn=3D0x557fd2288c80 <mem=
ory_region_write_accessor>, mr=3D0x61a000002200, attrs=3D...)
      pment/qemu/memory.c:539
  #13 memory_region_dispatch_write (mr=3D0x61a000002200, addr=3D4, data=3D4=
294940309, op=3DMO_32, attrs=3D...) at /memory.c:1476
  #14 flatview_write_continue (fv=3D0x606000035f00, addr=3D1304, attrs=3D..=
., ptr=3D0x7fff1fc0ec40, len=3D4, addr1=3D4, l=3D4, mr=3D0x61a000002200) at=
 /exec.c:3137
  #15 flatview_write (fv=3D0x606000035f00, addr=3D1304, attrs=3D..., buf=3D=
0x7fff1fc0ec40, len=3D4) at /exec.c:3177
  #16 address_space_write (as=3D0x557fd54e7bc0 <address_space_io>, addr=3D1=
304, attrs=3D..., buf=3D0x7fff1fc0ec40, len=3D4) at /exec.c:3271

  =

  It looks like fw_cfg_dma_transfer gets the address(136728041144064) and l=
ength(1378422272) for the read from the value provided as input 4294940309 =
(0xFFFF9695) which lands in pcbios. Should there be any limits on the lengt=
h of guest-memory that fw_cfg should populate?
  Found by libfuzzer

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880355/+subscriptions


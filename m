Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F485C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148352075E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148352075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8maQ-0007J2-5O
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 11:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mNI-00013i-Hi
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:21:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:53526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8mNE-0008BT-5a
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 11:21:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k8mNA-0001mc-9i
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:21:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 31F9D2E80EE
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 15:20:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2020 15:12:17 -0000
From: Thomas Huth <1878134@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr balaton-4 rafaeldtinoco th-huth
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <158925637015.6343.182119641060008506.malonedeb@soybean.canonical.com>
Message-Id: <159793633707.4511.16900053193073105334.malone@gac.canonical.com>
Subject: [Bug 1878134] Re: Assertion failures in
 ati_reg_read_offs/ati_reg_write_offs
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: c595b0ff38da4a039fc7a9ce8e35696a6c00978d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 10:50:55
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
Reply-To: Bug 1878134 <1878134@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Db0588cb51da698671

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878134

Title:
  Assertion failures in ati_reg_read_offs/ati_reg_write_offs

Status in QEMU:
  Fix Released

Bug description:
  Hello,
  While fuzzing, I found inputs that trigger assertion failures in
  ati_reg_read_offs/ati_reg_write_offs

  uint32_t extract32(uint32_t, int, int): Assertion `start >=3D 0 &&
  length > 0 && length <=3D 32 - start' failed

  #3  0x00007ffff6866092 in __GI___assert_fail (assertion=3D0x555556e760c0 =
<str> "start >=3D 0 && length > 0 && length <=3D 32 - start", file=3D0x5555=
56e76120 <str> "/home/alxndr/Development/qemu/include/qemu/bitops.h", line=
=3D0x12c, function=3D0x555556e76180 <__PRETTY_FUNCTION__.extract32> "uint32=
_t extract32(uint32_t, int, int)") at assert.c:101
  #4  0x000055555653d8a7 in ati_mm_read (opaque=3D<optimized out>, addr=3D0=
x1a, size=3D<optimized out>) at /home/alxndr/Development/qemu/include/qemu/=
log-for-trace.h:29
  #5  0x000055555653c825 in ati_mm_read (opaque=3D<optimized out>, addr=3D0=
x4, size=3D<optimized out>) at /home/alxndr/Development/qemu/hw/display/ati=
.c:289
  #6  0x000055555601446e in memory_region_read_accessor (mr=3D0x63100004dc2=
0, addr=3D<optimized out>, value=3D<optimized out>, size=3D<optimized out>,=
 shift=3D<optimized out>, mask=3D<optimized out>, attrs=3D...) at /home/alx=
ndr/Development/qemu/memory.c:434
  #7  0x0000555556001a70 in access_with_adjusted_size (addr=3D<optimized ou=
t>, value=3D<optimized out>, size=3D<optimized out>, access_size_min=3D<opt=
imized out>, access_size_max=3D<optimized out>, access_fn=3D<optimized out>=
, mr=3D0x63100004dc20, attrs=3D...) at /home/alxndr/Development/qemu/memory=
.c:544
  #8  0x0000555556001a70 in memory_region_dispatch_read1 (mr=3D0x63100004dc=
20, addr=3D0x4, pval=3D<optimized out>, size=3D0x4, attrs=3D...) at /home/a=
lxndr/Development/qemu/memory.c:1396

  =

  I can reproduce it in qemu 5.0 built with using:
  cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc=
-q35-5.0 -device ati-vga -nographic -qtest stdio -monitor none -serial none
  outl 0xcf8 0x80001018
  outl 0xcfc 0xe2000000
  outl 0xcf8 0x8000101c
  outl 0xcf8 0x80001004
  outw 0xcfc 0x7
  outl 0xcf8 0x8000fa20
  write 0xe2000004 0x1 0x1a
  readq 0xe2000000
  EOF

  Similarly for ati_reg_write_offs:
  cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386 -M pc=
-q35-5.0 -device ati-vga -nographic -qtest stdio -monitor none -serial none
  outl 0xcf8 0x80001018
  outl 0xcfc 0xe2000000
  outl 0xcf8 0x8000101c
  outl 0xcf8 0x80001004
  outw 0xcfc 0x7
  outl 0xcf8 0x8000fa20
  write 0xe2000000 0x8 0x6a00000000006a00
  EOF

  I also attached the traces to this launchpad report, in case the
  formatting is broken:

  qemu-system-i386 -M pc-q35-5.0 -device ati-vga -nographic -qtest stdio
  -monitor none -serial none < attachment

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878134/+subscriptions


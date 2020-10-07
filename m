Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264EBC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97CBC208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CBC208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ1JV-0008Q3-JI
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 00:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ15j-0002gq-Ah
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:30:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:38390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ15e-0005Tt-MD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:30:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kQ15N-00027I-OX
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:29:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5FB772E813E
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 04:29:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2020 04:17:21 -0000
From: Launchpad Bug Tracker <754635@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bradh ferux janitor th-huth
X-Launchpad-Bug-Reporter: ferux@mail.ru (ferux)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20110408133245.2975.97973.malonedeb@wampee.canonical.com>
Message-Id: <160204424190.20421.287875401909236464.malone@loganberry.canonical.com>
Subject: [Bug 754635] Re: -d option outs wrong info about sections
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: 079a7311ed8fc60754ee37e8a9c0d7a2d56029fb
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 22:50:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 754635 <754635@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/754635

Title:
  -d option outs wrong info about sections

Status in QEMU:
  Expired

Bug description:
  For example, after run ./qemu-i386 -d in_asm /bin/ls from 0.14.0 release,=
 I received this qemu.log file:
  $ cat /tmp/qemu.log | grep -A7 guest
  Relocating guest address space from 0x08048000 to 0x8048000
  guest_base  0x0
  start    end      size     prot
  00048000-0005f000 00017000 r-x
  0005f000-00069000 0000a000 rw-
  00040000-00041000 00001000 ---
  00041000-00041800 00000800 rw-
  00041800-0005d800 0001c000 r-x
  0005d800-0005f800 00002000 rw-

  But such command in 0.12.5 release outs this:
  $ cat /tmp/qemu.log | grep -A7 guest
  guest_base  0x0
  start    end      size     prot
  00f38000-00f39000 00001000 ---
  08048000-0805f000 00017000 r-x
  0805f000-08061000 00002000 rw-
  40000000-40080000 00080000 rw-
  40080000-40081000 00001000 ---
  40081000-4009d000 0001c000 r-x

  It looks correct.
  I received such differences and with qemu-microblaze. =


  After comparing 0.12.5 and 0.14.0 releases I found this differences in ex=
ec.c:
  in 0.12.5:
  end =3D (i << (32 - L1_BITS)) | (j << TARGET_PAGE_BITS);

  in 0.14.0:
  int rc =3D walk_memory_regions_1(&data, (abi_ulong)i << V_L1_SHIFT,

  V_L1_SHIFT in my case is 10, but 32 - L1_BITS is 22

  I make this changes:
  $ diff -up qemu-0.14.0/exec.c exec.c
  --- qemu-0.14.0/exec.c	2011-04-08 17:26:00.524464002 +0400
  +++ exec.c	2011-04-08 17:26:09.800464003 +0400
  @@ -2340,7 +2340,7 @@ int walk_memory_regions(void *priv, walk
       data.prot =3D 0;
   =

       for (i =3D 0; i < V_L1_SIZE; i++) {
  -        int rc =3D walk_memory_regions_1(&data, (abi_ulong)i << V_L1_SHI=
FT,
  +        int rc =3D walk_memory_regions_1(&data, (abi_ulong)i << (V_L1_SH=
IFT + TARGET_PAGE_BITS),
                                          V_L1_SHIFT / L2_BITS - 1, l1_map =
+ i);
           if (rc !=3D 0) {
               return rc;

  After this outputs looks correct.

  I don't know code base good, and think what may to do more general correc=
tions.
  Host system: linux i386

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/754635/+subscriptions


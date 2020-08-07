Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEA5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 534AD221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534AD221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xSw-00074n-BW
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3xS3-0005pY-1i
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:07 -0400
Received: from indium.canonical.com ([91.189.90.7]:57946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k3xS0-0001W2-Vo
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k3xRz-0005By-7E
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 08:10:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D20322E808D
 for <qemu-devel@nongnu.org>; Fri,  7 Aug 2020 08:10:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2020 07:59:51 -0000
From: Thomas Huth <754635@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bradh ferux th-huth
X-Launchpad-Bug-Reporter: ferux@mail.ru (ferux)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20110408133245.2975.97973.malonedeb@wampee.canonical.com>
Message-Id: <159678719163.2973.9711731269428459307.malone@gac.canonical.com>
Subject: [Bug 754635] Re: -d option outs wrong info about sections
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="a24057fea7e4c6a98c0220d5f878da0f3c783699";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 93e5ef70962bf0f01c9e9e72e851884233f49298
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 01:41:01
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
Reply-To: Bug 754635 <754635@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looking through old bug tickets... is this still an issue with the
latest version of QEMU? Or could we close this ticket nowadays?


** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/754635

Title:
  -d option outs wrong info about sections

Status in QEMU:
  Incomplete

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


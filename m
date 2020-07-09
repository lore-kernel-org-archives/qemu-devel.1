Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66683C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D79E206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D79E206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtUw0-0005Cz-Ib
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jtUvM-0004Oy-He
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:41:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:52330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jtUvK-0003d2-7y
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:41:08 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jtUvH-0005T3-K0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 11:41:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 94B632E8024
 for <qemu-devel@nongnu.org>; Thu,  9 Jul 2020 11:41:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2020 11:32:25 -0000
From: Laurent Vivier <1886076@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: risc-v
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: laurent-vivier nroyer
X-Launchpad-Bug-Reporter: Nicolas Royer (nroyer)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <159371008164.16126.4627604650696899204.malonedeb@soybean.canonical.com>
Message-Id: <159429434518.31066.10783347168196519513.malone@soybean.canonical.com>
Subject: [Bug 1886076] Re: risc-v pmp implementation error
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b24753402d6321ed1b9083e580f5f014a46bab00";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 14151ed46d46f0400699068339d154b73cabb7cf
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 07:41:03
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
Reply-To: Bug 1886076 <1886076@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nicolas,

to be reviewed your patch must be sent to qemu-devel@nongnu.org

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1886076

Title:
  risc-v pmp implementation error

Status in QEMU:
  New

Bug description:
  QEMU Commit fc1bff958998910ec8d25db86cd2f53ff125f7ab

  =

  RISC-V PMP implementation is not correct on QEMU.

  When an access is granted there is no more PMP check on the 4KB memory ra=
nge of the accessed location.
  A cache flush is needed in order to force a PMP check on next access to t=
his 4KB memory range.
  A correct implementation would be to grant access to the maximum allowed =
area around the accessed location within the 4KB memory range.

  For instance, if PMP is configured to block all accesses from 0x80003000 =
to 0x800037FF and from 0x80003C00 to 0x80003FFF:
  1st case:
      1) A read access is done @0x80003900 --> access OK as expected
      2) Then a read access is done @0x80003400 --> access OK while it must=
 be blocked!
  2nd case:
      1) A read access is done @0x80003900 --> access OK as expected
      2) Cache is flushed (__asm__ __volatile__ ("sfence.vma" : : : "memory=
");)  =

      3) A read access is done @0x80003400 --> access blocked as expected

  Analysis:
      After the 1st read @0x80003900 QEMU add the memory range 0x80003000 t=
o 0x80003FFF into a TLB entry.
      Then no more PMP check is done from 0x80003000 to 0x80003FFF until th=
e TLB is flushed.
  What should be done:
      Only the range 0x80003800 to 0x80003BFF should be added to the TLB en=
try.

  The 4KB range is the default size of a TLB page on QEMU for RISCV.
  The minimum size that can be set is 64Bytes. However the PMP granularity =
can be as low as 4Bytes.

  I tested a quick fix and PMP is working as expected.
  The quick fix consist in replacing this line:
  tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK, prot,=
 mmu_idx, TARGET_PAGE_SIZE);
  By this one in target/riscv/cpu_helper.c:
  tlb_set_page(cs, address & ~0x3, pa & ~0x3, prot, mmu_idx, size);

  This quick fix has to be optimized in order to consume less HW
  resources, as explained at the beginning.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1886076/+subscriptions


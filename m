Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE046C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E01E206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 13:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E01E206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jblgR-0008Mn-OC
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 09:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jblft-0007xY-Md
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:55:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:45612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jblfs-000129-Cu
 for qemu-devel@nongnu.org; Thu, 21 May 2020 09:55:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jblfp-00087l-JV
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 13:55:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 59AF52E8086
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 13:55:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2020 13:41:33 -0000
From: Peter Maydell <1879955@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell
X-Launchpad-Bug-Reporter: Peter Maydell (pmaydell)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
Message-Id: <159006849314.7162.9087011214859581235.malonedeb@gac.canonical.com>
Subject: [Bug 1879955] [NEW] target/i386/seg_helper.c: 16-bit TSS struct
 format wrong?
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 656314cdbb8fc9ff08dc51d8d292850a32750ffa
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 08:50:51
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
Reply-To: Bug 1879955 <1879955@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

In target/i386/seg_helper.c:switch_tss_ra() we have the following code
to load registers from a 16-bit TSS struct:

        /* 16 bit */
        new_cr3 =3D 0;
        new_eip =3D cpu_lduw_kernel_ra(env, tss_base + 0x0e, retaddr);
        new_eflags =3D cpu_lduw_kernel_ra(env, tss_base + 0x10, retaddr);
        for (i =3D 0; i < 8; i++) {
            new_regs[i] =3D cpu_lduw_kernel_ra(env, tss_base + (0x12 + i * =
2),
                                             retaddr) | 0xffff0000;
        }
        for (i =3D 0; i < 4; i++) {
            new_segs[i] =3D cpu_lduw_kernel_ra(env, tss_base + (0x22 + i * =
4),
                                             retaddr);
        }
        new_ldt =3D cpu_lduw_kernel_ra(env, tss_base + 0x2a, retaddr);

This doesn't match up with the structure described here:
https://www.sandpile.org/x86/tss.htm -- which has only 2-byte slots for
the segment registers. It also makes the 3rd segreg use the same offset
as the LDTR, which is very suspicious. I suspect that this should use
"(0x22 + i * 2)".

The code later in the same function that stores the segment registers to
the struct has the same bug.

Found by code inspection; I don't have a test case to check this. As a
non-x86-expert I'm just going to file a bug report in case somebody else
feels like confirming the issue and sending a patch.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1879955

Title:
  target/i386/seg_helper.c: 16-bit TSS struct format wrong?

Status in QEMU:
  New

Bug description:
  In target/i386/seg_helper.c:switch_tss_ra() we have the following code
  to load registers from a 16-bit TSS struct:

          /* 16 bit */
          new_cr3 =3D 0;
          new_eip =3D cpu_lduw_kernel_ra(env, tss_base + 0x0e, retaddr);
          new_eflags =3D cpu_lduw_kernel_ra(env, tss_base + 0x10, retaddr);
          for (i =3D 0; i < 8; i++) {
              new_regs[i] =3D cpu_lduw_kernel_ra(env, tss_base + (0x12 + i =
* 2),
                                               retaddr) | 0xffff0000;
          }
          for (i =3D 0; i < 4; i++) {
              new_segs[i] =3D cpu_lduw_kernel_ra(env, tss_base + (0x22 + i =
* 4),
                                               retaddr);
          }
          new_ldt =3D cpu_lduw_kernel_ra(env, tss_base + 0x2a, retaddr);

  This doesn't match up with the structure described here:
  https://www.sandpile.org/x86/tss.htm -- which has only 2-byte slots
  for the segment registers. It also makes the 3rd segreg use the same
  offset as the LDTR, which is very suspicious. I suspect that this
  should use "(0x22 + i * 2)".

  The code later in the same function that stores the segment registers
  to the struct has the same bug.

  Found by code inspection; I don't have a test case to check this. As a
  non-x86-expert I'm just going to file a bug report in case somebody
  else feels like confirming the issue and sending a patch.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1879955/+subscriptions


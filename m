Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F69C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 05:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2F92073B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 05:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2F92073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbztA-0000Fg-7o
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 01:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbzsL-00072x-Li
 for qemu-devel@nongnu.org; Fri, 22 May 2020 01:05:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:55960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jbzsK-0008Jr-Rq
 for qemu-devel@nongnu.org; Fri, 22 May 2020 01:05:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jbzsJ-00036m-T8
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 05:05:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DB8622E806F
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 05:05:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2020 04:56:55 -0000
From: Thomas Huth <1879998@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Won't Fix; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hanno-hboeck th-huth
X-Launchpad-Bug-Reporter: =?utf-8?q?Hanno_B=C3=B6ck_=28hanno-hboeck=29?=
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <159008099475.30627.1939183196125263199.malonedeb@wampee.canonical.com>
Message-Id: <159012341514.1561.13987261786891694844.malone@chaenomeles.canonical.com>
Subject: [Bug 1879998] Re: Bad check for return value of mmap()
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1b79585b73b1a171ff967dccee9b521912c7e954
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 21:50:42
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
Reply-To: Bug 1879998 <1879998@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

skiboot is a separate project, we do not manage its code in the QEMU
project, but just include the source code in our release tarballs since
we ship the skiboot binary with QEMU. Please report these problems to
the skiboot project instead:

 https://github.com/open-power/skiboot

** Changed in: qemu
       Status: New =3D> Won't Fix

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1879998

Title:
  Bad check for return value of mmap()

Status in QEMU:
  Won't Fix

Bug description:
  In
  ./roms/skiboot/extract-gcov.c
  there is this code:

          addr =3D mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
          assert(addr !=3D NULL);

  This check is wrong, mmap never returns NULL, on errors it returns
  MAP_FAILED (or -1). (Also sidenote: asserts usually shouldn't be used
  for error checking.)

  In
  roms/skiboot/libstb/print-container.c
  there's a similar issue:

          payload =3D mmap(NULL, payload_st.st_size - SECURE_BOOT_HEADERS_S=
IZE,
                          PROT_READ, MAP_PRIVATE, fdin, SECURE_BOOT_HEADERS=
_SIZE);
          if (!payload)

  This if should be (payload =3D=3D MAP_FAILED).

  Another one is in
  ./roms/skiboot/libstb/create-container.c

  And in
  ./roms/u-boot/tools/aisimage.c
  there's an mmap call that does not check the return value at all.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1879998/+subscriptions


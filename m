Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CECC47095
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33673214DB
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33673214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ1F2-0002x2-UO
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 00:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ15J-0002RB-E1
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:29:49 -0400
Received: from indium.canonical.com ([91.189.90.7]:37530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kQ15G-0005P6-EX
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:29:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kQ15D-00027L-Ko
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:29:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4496B2E811C
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 04:29:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2020 04:17:25 -0000
From: Launchpad Bug Tracker <1245543@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor p12 th-huth
X-Launchpad-Bug-Reporter: Povilas Kanapickas (p12)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20131028155324.10487.34334.malonedeb@wampee.canonical.com>
Message-Id: <160204424557.20421.8748268192879610058.malone@loganberry.canonical.com>
Subject: [Bug 1245543] Re: Wrong implementation of SSE4.1 pmovzxbw and similar
 instructions
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="d50d1e75c500726862802414f880ee3e3bb759bf"; Instance="production"
X-Launchpad-Hash: d3c567432d437740eac5839672b457976c43044b
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
Reply-To: Bug 1245543 <1245543@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1245543

Title:
  Wrong implementation of SSE4.1 pmovzxbw and similar instructions

Status in QEMU:
  Expired

Bug description:
  QEMU 1.5.0 (and git version, as far as I can tell from the source
  code) has incorrect implementation of pmovzxbw and similar SSE4.1
  instructions. The instruction zero-extends the first 8 8-bit elements
  of a vector to 16bit vector and puts them to another vector. The
  current implementation applies this operation only to the first
  element and zeros out the rest.

  To verify, compile the attached program for SSE4.1 (g++ -msse4.1
  cvtint.cc). On real hardware, it produces the following output:

  $ ./a.out
  1 0 2 0 3 0 4 0 5 0 6 0 7 0 8 0

  On QEMU, the output is as follows:

  $ ./a.out
  1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0

  QEMU is invoked as:

  qemu-system-x86_64 \
      -M pc -cpu Haswell,+sse4.1,+avx,+avx2,+fma,enforce -m 512 \
      -serial stdio -no-reboot \
      -kernel vmlinuz -initrd initrd.img \
      -netdev user,id=3Duser.0 -device rtl8139,netdev=3Duser.0  -redir tcp:=
2222::22 \
      -hda ubuntu-amd64.ext3 \
      --append "rw console=3Dtty root=3D/dev/sda"

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1245543/+subscriptions


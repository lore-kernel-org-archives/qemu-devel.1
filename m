Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2354DC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBC420791
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 15:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBC420791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k59mB-0001GQ-6V
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 11:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k59lL-0000Ne-6C
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:30:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:34308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k59lF-0007Z1-Oy
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 11:30:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k59lB-0004T0-Vf
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 15:30:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1574D2E810C
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 15:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2020 15:23:11 -0000
From: Steve Dodd <1793539@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: anarchetic schwab-linux-m68k
X-Launchpad-Bug-Reporter: Andreas Schwab (schwab-linux-m68k)
X-Launchpad-Bug-Modifier: Steve Dodd (anarchetic)
References: <153745238166.24916.6273048340249119390.malonedeb@gac.canonical.com>
Message-Id: <159707299170.27105.191060901591173391.malone@gac.canonical.com>
Subject: [Bug 1793539] Re: qemu:handle_cpu_signal received signal outside vCPU
 context @ pc=0x6003ddc5
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 839e007178abf7e1603b336cf49f8875df7360af
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 11:25:02
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
Reply-To: Bug 1793539 <1793539@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Possibly duplicate of bug #1594394, in which case it would be worth
testing with 5.0.0 or above..

** Bug watch added: github.com/vivier/qemu-m68k/issues #33
   https://github.com/vivier/qemu-m68k/issues/33

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1793539

Title:
  qemu:handle_cpu_signal received signal outside vCPU context @
  pc=3D0x6003ddc5

Status in QEMU:
  New

Bug description:
  During the build of gedit for RISC-V this error occurs:

  $ qemu-riscv64 -E LD_LIBRARY_PATH=3Dgedit/.libs ./gedit/.libs/gedit
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6003=
ddc5
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6000=
09e4

  https://build.opensuse.org/package/live_build_log/openSUSE:Factory:RISCV/=
gedit/standard/riscv64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1793539/+subscriptions


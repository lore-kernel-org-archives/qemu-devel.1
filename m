Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8F8C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 08:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C83206C3
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 08:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C83206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcPnr-0006SO-Le
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 04:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcPmq-0005rx-Pc
 for qemu-devel@nongnu.org; Sat, 23 May 2020 04:45:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:38116)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jcPmm-0001KD-0j
 for qemu-devel@nongnu.org; Sat, 23 May 2020 04:45:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jcPmj-0005vg-Rs
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 08:45:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id D0DDD2E8047
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 08:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2020 08:36:18 -0000
From: Helge Deller <1880287@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 8-deller
X-Launchpad-Bug-Reporter: Helge Deller (8-deller)
X-Launchpad-Bug-Modifier: Helge Deller (8-deller)
Message-Id: <159022297856.20775.958724179871171148.malonedeb@soybean.canonical.com>
Subject: [Bug 1880287] [NEW] gcc crashes in hppa emulation
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1f7bc749b40714a4cc10f5e4d787118a78037035";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 8094a976631371f2718f09c2568948bfc416c24d
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 03:45:44
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
Reply-To: Bug 1880287 <1880287@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

There seems to be a translation bug in the qemu-hppa (qemu v5.0.0) emulatio=
n:
A stripped down testcase (taken from Linux kernel build) is attached.

In there is "a.sh", a shell script which calls gcc-9 (fails with both
debian gcc-9.3.0-11 or gcc-9.3.0-12). and "a.iii", the preprocessed
source.

When starting a.sh, in the emulation gcc crashes with segfault.
On real hardware gcc succeeds to compile the source.

In a hppa-user chroot running "apt update && apt install gcc-9" should
be sufficient to get the needed reproducer environment.

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "reproducer testcase, including a script to call gcc a=
nd the preprocessed source"
   https://bugs.launchpad.net/bugs/1880287/+attachment/5375826/+files/gcc-9=
.3.0-12-segfault.tgz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1880287

Title:
  gcc crashes in hppa emulation

Status in QEMU:
  New

Bug description:
  There seems to be a translation bug in the qemu-hppa (qemu v5.0.0) emulat=
ion:
  A stripped down testcase (taken from Linux kernel build) is attached.

  In there is "a.sh", a shell script which calls gcc-9 (fails with both
  debian gcc-9.3.0-11 or gcc-9.3.0-12). and "a.iii", the preprocessed
  source.

  When starting a.sh, in the emulation gcc crashes with segfault.
  On real hardware gcc succeeds to compile the source.

  In a hppa-user chroot running "apt update && apt install gcc-9" should
  be sufficient to get the needed reproducer environment.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1880287/+subscriptions


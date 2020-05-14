Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F37C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E4620657
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E4620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFzU-00043c-Ea
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jZFyl-00038T-6V
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:40:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:49612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jZFyj-00053e-V3
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:40:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jZFyh-0007Ko-Py
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 15:40:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B4B0D2E810A
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 15:40:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2020 15:31:49 -0000
From: Richard Henderson <rth@twiddle.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: i386 linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: husseydevin laurent-vivier rth
X-Launchpad-Bug-Reporter: easyaspi314 (husseydevin)
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <158941344748.31408.6066832909673515633.malonedeb@chaenomeles.canonical.com>
Message-Id: <158947030987.31351.7177611672243491107.malone@chaenomeles.canonical.com>
Subject: [Bug 1878501] Re: qemu-i386 does not define AT_SYSINFO
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 927c44a5a33502eae9bd39b8787cc78997412106
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:40:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1878501 <1878501@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not define AT_SYSINFO because we do not implement the vdso.
All we have so far is the vsyscall page, which is not the same thing.

I've had patches for the vdso for a number of years; perhaps it's
time to update and re-send that...

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878501

Title:
  qemu-i386 does not define AT_SYSINFO

Status in QEMU:
  New

Bug description:
  qemu-i386 does not define the AT_SYSINFO auxval when running i386
  Linux binaries.

  On most libcs, this is properly handled, but this is mandatory for the
  i686 Bionic (Android) libc or it will segfault.

  This is due to a blind assumption that getauxval(AT_SYSINFO) will
  return a valid function pointer:

  The code varies from version to version, but it looks like this:

  void *__libc_sysinfo;
  // mangled as _Z19__libc_init_sysinfov
  void __libc_init_sysinfo() {
    bool dummy;
    // __bionic_getauxval =3D getauxval
    __libc_sysinfo =3D reinterpret_cast<void *>(__bionic_getauxval(AT_SYSIN=
FO, dummy));
  }

  A simple way to reproduce is to compile a basic C program against the
  NDK:

  int main(void) { return 0; }

  $ i686-linux-android-clang -static empty.c -o empty
  $ qemu-i386 -cpu max ./empty
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault

  The place where it segfaults is misleading: It will, at least on the
  current NDK, crash on __set_thread_area, this is due to it calling a
  function pointer to __libc_sysinfo returned by __kernel_syscall.

  QEMU 4.1.1 (aarch64)
  Pixel 2 XL via Termux

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878501/+subscriptions


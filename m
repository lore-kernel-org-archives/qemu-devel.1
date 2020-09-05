Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1D3C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 09:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC16206A5
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 09:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC16206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEUSu-0008Tj-4c
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 05:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kEUS6-00081U-1D
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 05:25:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:55424)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kEUS3-0005JE-B7
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 05:25:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kEUS1-0007xN-2A
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 09:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0BAFB2E80AD
 for <qemu-devel@nongnu.org>; Sat,  5 Sep 2020 09:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2020 09:19:25 -0000
From: Serge Belyshev <1785203@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: belyshev
X-Launchpad-Bug-Reporter: Serge Belyshev (belyshev)
X-Launchpad-Bug-Modifier: Serge Belyshev (belyshev)
References: <153328934781.28538.2265879315975123435.malonedeb@chaenomeles.canonical.com>
Message-Id: <159929756559.18848.6020499309544019907.malone@gac.canonical.com>
Subject: [Bug 1785203] Re: accel/tcg/translate-all.c:2511: page_check_range:
 Assertion `start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS)' failed.
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="90a5703803d95539bdb5c0b289b1675630569e1e"; Instance="production"
X-Launchpad-Hash: 0387a7b04ec020645589c384e63e6821b2619682
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/05 03:50:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1785203 <1785203@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed by 0acd4ab849827bbc20402e01c9da088207c0d236  ("linux-user: check
valid address in access_ok()"),  fix released in v5.0.0.

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1785203

Title:
  accel/tcg/translate-all.c:2511: page_check_range: Assertion `start <
  ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS)' failed.

Status in QEMU:
  Fix Released

Bug description:
  qemu-riscv64 version 2.12.93 crashes when mincore() is called with
  invalid pointer with the following message:

  qemu-riscv64: /opt/qemu/accel/tcg/translate-all.c:2511: page_check_range:=
 Assertion `start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS)' failed.
  qemu:handle_cpu_signal received signal outside vCPU context @ pc=3D0x6000=
14ef

  Testcase:

  #include <sys/mman.h>

  int main (void)
  {
    unsigned char v;
    return mincore ((void *) 0x00000010000000000, 1, &v);
  }

  Backtrace:

  #0  raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:50
  #1  0x000000006000140a in abort () at abort.c:79
  #2  0x00000000600012ec in __assert_fail_base (
      fmt=3D0x6024eae8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", =

      assertion=3D0x601b9758 "start < ((target_ulong)1 << L1_MAP_ADDR_SPACE=
_BITS)", =

      file=3D0x601b9658 "/opt/qemu/accel/tcg/translate-all.c", line=3D2511, =

      function=3D0x601b9810 <__PRETTY_FUNCTION__.23867> "page_check_range")=
 at assert.c:92
  #3  0x000000006010e10e in __assert_fail (
      assertion=3Dassertion@entry=3D0x601b9758 "start < ((target_ulong)1 <<=
 L1_MAP_ADDR_SPACE_BITS)", file=3Dfile@entry=3D0x601b9658 "/opt/qemu/accel/=
tcg/translate-all.c", line=3Dline@entry=3D2511, =

      function=3Dfunction@entry=3D0x601b9810 <__PRETTY_FUNCTION__.23867> "p=
age_check_range")
      at assert.c:101
  #4  0x000000006003e916 in page_check_range (start=3Dstart@entry=3D1099511=
627776, len=3Dlen@entry=3D1, =

      flags=3Dflags@entry=3D1) at /opt/qemu/accel/tcg/translate-all.c:2511
  #5  0x0000000060057717 in access_ok (size=3D1, addr=3D1099511627776, type=
=3D0)
      at /opt/qemu/linux-user/qemu.h:567
  #6  lock_user (copy=3D0, len=3D1, guest_addr=3D1099511627776, type=3D0)
      at /opt/qemu/linux-user/qemu.h:567
  #7  do_syscall (cpu_env=3Dcpu_env@entry=3D0x622fca28, num=3D232, arg1=3D1=
099511627776, arg2=3D1, =

      arg3=3D274886298751, arg4=3D0, arg5=3D274886298808, arg6=3D66518, arg=
7=3D0, arg8=3D0)
      at /opt/qemu/linux-user/syscall.c:11635
  #8  0x0000000060066c5c in cpu_loop (env=3Denv@entry=3D0x622fca28)
      at /opt/qemu/linux-user/riscv/cpu_loop.c:55
  #9  0x0000000060002156 in main (argc=3D<optimized out>, argv=3D0x7fffffff=
ed68, =

      envp=3D<optimized out>) at /opt/qemu/linux-user/main.c:819

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1785203/+subscriptions


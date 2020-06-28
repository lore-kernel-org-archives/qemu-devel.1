Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF724C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 00:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE39206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 00:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE39206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jphJp-0005jo-SN
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 20:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jphIx-0005JF-4d
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 20:05:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:52778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jphIt-0001Vk-PZ
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 20:05:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jphIq-00073b-S6
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 00:05:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B24452E8114
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 00:05:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2020 23:56:40 -0000
From: Richard Henderson <1883268@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=In Progress; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm testcase
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: christophe-lyon rth
X-Launchpad-Bug-Reporter: Christophe Lyon (christophe-lyon)
X-Launchpad-Bug-Modifier: Richard Henderson (rth)
References: <159197267869.7647.15246075911938911102.malonedeb@gac.canonical.com>
Message-Id: <159338860080.468.6362774173081954365.malone@chaenomeles.canonical.com>
Subject: [Bug 1883268] Re: random errors on aarch64 when executing
 __aarch64_cas8_acq_rel
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 92eb48f746603642a53573c1d700eff20a7e790b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 20:05:41
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1883268 <1883268@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There's nothing wrong with the atomic operation, which
makes sense since it's against a NULL pointer.  The
problem that I see is in the unwinding -- the catch
never happens and std::terminate gets called.

There must be some sort of 32-bit TCG error though,
because the same binary works on x86_64 host.

The most confusing thing about this test case is that
12 previous throws work correctly, but the 13th fails.

** Changed in: qemu
       Status: Confirmed =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1883268

Title:
  random errors on aarch64 when executing __aarch64_cas8_acq_rel

Status in QEMU:
  In Progress

Bug description:
  Hello,

  Since I upgraded to qemu-5.0 when executing the GCC testsuite,
  I've noticed random failures of g++.dg/ext/sync-4.C.

  I'm attaching the source of the testcase, the binary executable and
  the qemu traces (huge, 111MB!) starting at main (with qemu-aarch64
  -cpu cortex-a57 -R 0 -d
  in_asm,int,exec,cpu,unimp,guest_errors,nochain)

  The traces where generated by a CI build, I built the executable
  manually but I expect it to be the same as the one executed by CI.

  In seems the problem occurs in f13, which leads to a call to abort()

  The preprocessed version of f13/t13 are as follows:
  static bool f13 (void *p) __attribute__ ((noinline));
  static bool f13 (void *p)
  {
    return (__sync_bool_compare_and_swap((ditype*)p, 1, 2));
  }
  static void t13 ()
  {
    try {
      f13(0);
    }
    catch (...) {
      return;
    }
    abort();
  }

  =

  When looking at the execution traces at address 0x00400c9c, main calls f1=
3, which in turn calls __aarch64_cas8_acq_rel (at 0x00401084)
  __aarch64_cas8_acq_rel returns to f13 (address 0x0040113c), then f13 retu=
rns to main (0x0040108c) which then calls abort (0x00400ca0)

  I'm not quite sure what's wrong :-(

  I've not noticed such random problems with native aarch64 hardware.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1883268/+subscriptions


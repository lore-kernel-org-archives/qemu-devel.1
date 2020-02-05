Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79654C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:30:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F24220659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F24220659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOUy-0002A8-GE
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:30:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1izOM0-000502-LS
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1izOLz-0000FC-Co
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:20:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:45374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1izOLz-000076-5U
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:20:43 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1izOLx-0005aT-2i
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 17:20:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 137A92E80C7
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 17:20:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Feb 2020 17:15:14 -0000
From: Thomas Huth <1861605@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: arichardson th-huth
X-Launchpad-Bug-Reporter: Alexander Richardson (arichardson)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <158064672776.8396.11527564563260103475.malonedeb@chaenomeles.canonical.com>
Message-Id: <158092291417.20106.17071061912772608922.malone@wampee.canonical.com>
Subject: [Bug 1861605] Re: LL/SC broken for MIPS after
 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ef348f676c40a7160749fd00ec519fce65136d68
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1861605 <1861605@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch has been merged here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dec860426dfbebe0c

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861605

Title:
  LL/SC broken for MIPS after 7dd547e5ab6b31e7a0cfc182d3ad131dd55a948f

Status in QEMU:
  Fix Committed

Bug description:
  In that commit the env->llval value is loaded as an unsigned value
  (instead of sign-extended as before and therefore the CMPXCHG in
  gen_st_cond() in translate.c fails.

  I have committed a fix for this issue as
  https://github.com/qemu/qemu/commit/6ff8dec97f1a105d0da96c67ee24c75e437df=
162

  An alternative solution would be to change the cmpxchg line to perform a =
non-sign-extended compare, i.e. replace
  =C2=A0=C2=A0=C2=A0=C2=A0tcg_gen_atomic_cmpxchg_tl(t0, cpu_lladdr, cpu_llv=
al, val,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0eva ? MIPS_HFLAG_UM : ctx->mem_idx, tcg_mo=
);
  with
  =C2=A0=C2=A0=C2=A0=C2=A0tcg_gen_atomic_cmpxchg_tl(t0, cpu_lladdr, cpu_llv=
al, val,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0eva ? MIPS_HFLAG_UM : ctx->mem_idx, tcg_mo=
 & ~MO_SIGN);

  However, that change does not fix the fact that the result of ll is no
  longer sign-extended, therefore I think adding a cast in the helpers
  is better.

  I cannot send this patch to the QEMU mailing list as I am not able to set=
up git-send-email.
  Feel free to apply this commit or the alternative solution.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861605/+subscriptions


Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54C1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA23E24125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA23E24125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuaYx-0004Km-PK
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:22:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iuaXt-0003ER-FZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iuaXr-0002MK-Aa
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:21:09 -0500
Received: from indium.canonical.com ([91.189.90.7]:57026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iuaXr-0002Lp-50
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:21:07 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iuaXo-0008JU-4b
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:21:04 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6DFC02E80DA
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:21:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jan 2020 11:11:37 -0000
From: Thomas Huth <1661815@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: shqking th-huth
X-Launchpad-Bug-Reporter: shqking (shqking)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20170204082040.20702.26524.malonedeb@gac.canonical.com>
Message-Id: <157977789768.5441.13453741863477584993.malone@chaenomeles.canonical.com>
Subject: [Bug 1661815] Re: Stack address is returned from function
 translate_one
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b8d1327fd820d6bf500589d6da587d5037c7d88e";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 40ffabe7b01c9564088c755f3e4801445fd9707a
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
Reply-To: Bug 1661815 <1661815@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I've finally posted a patch for this:
https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg05204.html

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1661815

Title:
  Stack address is returned from function translate_one

Status in QEMU:
  New

Bug description:
  The vulnerable version is qemu-2.8.0, and the vulnerable function is
  in "target-s390x/translate.c".

  The code snippet is as following.

  static ExitStatus translate_one(CPUS390XState *env, DisasContext *s)
  {
      const DisasInsn *insn;
      ExitStatus ret =3D NO_EXIT;
      DisasFields f;
      ...
      s->fields =3D &f;
      ...
      s->pc =3D s->next_pc;
      return ret;
  }

  A stack address, i.e. the address of local variable "f" is returned
  from current function through the output parameter "s->fields" as a
  side effect.

  This issue is one kind of undefined behaviors, according the C
  Standard, 6.2.4 [ISO/IEC 9899:2011]
  (https://www.securecoding.cert.org/confluence/display/c/DCL30-C.+Declare+=
objects+with+appropriate+storage+durations)

  This dangerous defect may lead to an exploitable vulnerability.
  We suggest sanitizing "s->fields" as null before return.

  Note that this issue is reported by shqking and Zhenwei Zou together.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1661815/+subscriptions


Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A403AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D36E2070C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 15:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D36E2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itYqn-0000sQ-5e
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 10:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1itYmX-0005an-Gk
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:16:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1itYmS-0001PZ-5T
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:16:01 -0500
Received: from indium.canonical.com ([91.189.90.7]:43306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1itYmR-0001OQ-HF
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 10:15:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1itYmM-0004wH-OK
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 15:15:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 226F82E80D6
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 15:15:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jan 2020 15:02:36 -0000
From: Samuel thibault <samuel.thibault@ens-lyon.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: asiagaming samuel-thibault
X-Launchpad-Bug-Reporter: jusunLee (asiagaming)
X-Launchpad-Bug-Modifier: Samuel thibault (samuel-thibault)
References: <154785010249.1233.12902128942224805447.malonedeb@gac.canonical.com>
Message-Id: <157953255816.4478.11753035949965603376.malone@soybean.canonical.com>
Subject: [Bug 1812451] Re: In windows host,
 tftp arbitrary file read vulnerability
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="f1052173880d8dae43faa7c2fc45da1b42227143";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 16a9badfeedc9f86114a17df197870c87804753a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Reply-To: Bug 1812451 <1812451@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is fixed upstream by
https://gitlab.freedesktop.org/slirp/libslirp/commit/14ec36e107a8c9af7d0a80=
c3571fe39b291ff1d4

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1812451

Title:
  In windows host, tftp arbitrary file read vulnerability

Status in QEMU:
  Fix Committed

Bug description:
  https://github.com/qemu/qemu/blob/master/slirp/tftp.c#L343

  =C2=A0=C2=A0if (!strncmp(req_fname, "../", 3) ||
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0req_fname[strlen(req_fname) - 1] =3D=
=3D '/' ||
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strstr(req_fname, "/../")) {
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tftp_send_error(spt, 2, "Access viola=
tion", tp);
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
  =C2=A0=C2=A0}

  There is file path check for not allowing escape tftp directory.
  But, in windows, file path is separated by "\" backslash.
  So, guest can read arbitrary file in Windows host.

  This bug is variant of CVE-2019-2553 - Directory traversal
  vulnerability.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1812451/+subscriptions


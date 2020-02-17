Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22E3C34022
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 02:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5746206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 02:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5746206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3sBC-0002ey-Nx
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 21:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j3oWI-00076i-VG
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:05:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j3oWH-0007Fp-T3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:05:38 -0500
Received: from indium.canonical.com ([91.189.90.7]:58466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j3oWH-0007Ex-NW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 17:05:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j3oWG-0002yp-9H
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:05:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 3AAC22E80C0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:05:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Feb 2020 21:51:52 -0000
From: matthew <coltoiu.matei@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: compilation misc.c
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: coltoiu-matei
X-Launchpad-Bug-Reporter: matthew (coltoiu-matei)
X-Launchpad-Bug-Modifier: matthew (coltoiu-matei)
Message-Id: <158197631227.29007.17964725834927610095.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1863678] [NEW] qemu and virtio-vga black screen in Android
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="19413b719a8df7423ab1390528edadce9e0e4aca";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 374d20c14bec93bfd9ee7e68698d9bfe7de7637c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Mon, 17 Feb 2020 20:59:24 -0500
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
Reply-To: Bug 1863678 <1863678@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

QEMU emulator version 4.2.50

kernel 5.3.0-29-generic
host Ubuntu 19.10
guest: Android 8.1

While trying to compile I get the following error

qemu/slirp/src/misc.c:146: undefined reference to
`g_spawn_async_with_fds'

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: compilation misc.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1863678

Title:
  qemu and virtio-vga black screen in Android

Status in QEMU:
  New

Bug description:
  QEMU emulator version 4.2.50

  kernel 5.3.0-29-generic
  host Ubuntu 19.10
  guest: Android 8.1

  While trying to compile I get the following error

  qemu/slirp/src/misc.c:146: undefined reference to
  `g_spawn_async_with_fds'

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1863678/+subscriptions


Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA8C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:13:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569DA205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569DA205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDngS-0003Jf-2x
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jDmOJ-0000OM-Sn
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jDmOI-00060E-Mt
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:50:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:49608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jDmOI-0005hG-Er
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 05:50:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jDmOG-0002hO-NG
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:50:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AE0802E80C0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 09:50:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Mar 2020 09:43:48 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1867601@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <158435182879.11338.3192996907536554019.malonedeb@soybean.canonical.com>
Subject: [Bug 1867601] [NEW] test-char not concurrent with unix socket
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="3a6db24bbe7280ec09bae73384238390fcc98ad3";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 650e21459755d15fbd1101ec00d75e5d4782f9a6
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
Reply-To: Bug 1867601 <1867601@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

'make check-unit' might fail when running multiple tests in parallel.

Apparently occurred on OSX CI:
https://travis-ci.org/github/philmd/qemu/jobs/662357430

Guess is same unix path used:

static SocketAddress unixaddr =3D {
    .type =3D SOCKET_ADDRESS_TYPE_UNIX,
    .u.q_unix.path =3D (char *)"test-char.sock",
};

Note, other tests in this file use g_dir_make_tmp().

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1867601

Title:
  test-char not concurrent with unix socket

Status in QEMU:
  New

Bug description:
  'make check-unit' might fail when running multiple tests in parallel.

  Apparently occurred on OSX CI:
  https://travis-ci.org/github/philmd/qemu/jobs/662357430

  Guess is same unix path used:

  static SocketAddress unixaddr =3D {
      .type =3D SOCKET_ADDRESS_TYPE_UNIX,
      .u.q_unix.path =3D (char *)"test-char.sock",
  };

  Note, other tests in this file use g_dir_make_tmp().

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1867601/+subscriptions


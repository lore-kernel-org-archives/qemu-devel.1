Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F99C10DCE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 01:54:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED87820675
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 01:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED87820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jB7cg-0002Lb-0W
	for qemu-devel@archiver.kernel.org; Sun, 08 Mar 2020 21:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jB7bC-0001ZM-Uo
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 21:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jB7bB-0005Qz-Re
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 21:52:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:55590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jB7bB-0005QZ-Mk
 for qemu-devel@nongnu.org; Sun, 08 Mar 2020 21:52:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jB7KN-0005rE-6I
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 01:35:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 219932E80C3
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2020 01:35:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Mar 2020 01:26:23 -0000
From: Yonggang Luo <1866577@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: luoyonggang
X-Launchpad-Bug-Reporter: Yonggang Luo (luoyonggang)
X-Launchpad-Bug-Modifier: Yonggang Luo (luoyonggang)
Message-Id: <158371718383.12217.15072587639340612485.malonedeb@wampee.canonical.com>
Subject: [Bug 1866577] [NEW] powerpc-none-eabi-gdb.exe GDB 9.1 with QEMU 4.2
 gdb-stub comes with Reply contains invalid hex digit 79
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: c26ccef4a12f977af828d1db9b953e61fef601d3
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
Reply-To: Bug 1866577 <1866577@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I am using powerpc-none-eabi-gdb with qemu 4.2, but it comes with =

the following error:

undefinedC:\CI-Tools\msys64\powerpc-none-eabi\usr\local\bin\powerpc-
none-eabi-gdb.exe: warning: Couldn't determine a path for the index
cache directory.

```Not implemented stop reason (assuming exception): undefined```
The target architecture is assumed to be powerpc:603

```
Reply contains invalid hex digit 79
```

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1866577

Title:
  powerpc-none-eabi-gdb.exe GDB 9.1 with QEMU 4.2 gdb-stub comes with
  Reply contains invalid hex digit 79

Status in QEMU:
  New

Bug description:
  I am using powerpc-none-eabi-gdb with qemu 4.2, but it comes with =

  the following error:

  undefinedC:\CI-Tools\msys64\powerpc-none-eabi\usr\local\bin\powerpc-
  none-eabi-gdb.exe: warning: Couldn't determine a path for the index
  cache directory.

  ```Not implemented stop reason (assuming exception): undefined```
  The target architecture is assumed to be powerpc:603

  ```
  Reply contains invalid hex digit 79
  ```

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1866577/+subscriptions


Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEB8C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:16:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F39320678
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 16:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F39320678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipE0m-00073j-3m
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 11:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ipDv6-0001FC-Pi
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ipDv5-0001NJ-Fs
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:10:56 -0500
Received: from indium.canonical.com ([91.189.90.7]:38962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ipDv5-0001MJ-9Z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 11:10:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ipDv3-0006Y6-NC
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 16:10:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AE0E82E80C9
 for <qemu-devel@nongnu.org>; Wed,  8 Jan 2020 16:10:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jan 2020 15:57:17 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1858814@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided;
 assignee=philmd@redhat.com; 
X-Launchpad-Bug-Tags: edk2
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <157849903743.2804.3996411796742068143.malonedeb@soybean.canonical.com>
Subject: [Bug 1858814] [NEW] 'make -C roms efi' does not update edk2 submodules
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="bceb5ef013b87ef7aafe0755545ceb689ca7ac60";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: f9a67bf92897eae9a6a3a8d4918cc9e7b3f8043f
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
Reply-To: Bug 1858814 <1858814@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

On a fresh clone, 'make -C roms efi' fails because submodule is not
initialized [1]:

/builds/philmd/qemu/roms/edk2/CryptoPkg/Library/OpensslLib/OpensslLibCrypto=
.inf(-1): error 000E: File/directory not found in workspace
/builds/philmd/qemu/roms/edk2/CryptoPkg/Library/OpensslLib/openssl/e_os.h
- Failed -

Laszlo suggested [2] it is possibly a regression from commit f3e330e3c319:
"roms/Makefile.edk2: don't pull in submodules when building from tarball"

[1] https://gitlab.com/philmd/qemu/-/jobs/395644357#L436
[2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg668929.html

** Affects: qemu
     Importance: Undecided
     Assignee: Philippe Mathieu-Daud=C3=A9 (philmd)
         Status: New


** Tags: edk2

** Changed in: qemu
     Assignee: (unassigned) =3D> Philippe Mathieu-Daud=C3=A9 (philmd)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1858814

Title:
  'make -C roms efi' does not update edk2 submodules

Status in QEMU:
  New

Bug description:
  On a fresh clone, 'make -C roms efi' fails because submodule is not
  initialized [1]:

  /builds/philmd/qemu/roms/edk2/CryptoPkg/Library/OpensslLib/OpensslLibCryp=
to.inf(-1): error 000E: File/directory not found in workspace
  /builds/philmd/qemu/roms/edk2/CryptoPkg/Library/OpensslLib/openssl/e_os.h
  - Failed -

  Laszlo suggested [2] it is possibly a regression from commit f3e330e3c319:
  "roms/Makefile.edk2: don't pull in submodules when building from tarball"

  [1] https://gitlab.com/philmd/qemu/-/jobs/395644357#L436
  [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg668929.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1858814/+subscriptions


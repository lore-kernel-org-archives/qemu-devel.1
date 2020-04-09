Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAD9C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4601A20753
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 17:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4601A20753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rkmorris.us
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMbBP-0004oZ-Au
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 13:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jMbAk-0004P6-19
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:41:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1jMbAi-0005nX-VZ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:41:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:52878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1jMbAi-0005my-QP
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 13:41:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jMbAh-0000A4-NE
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 17:40:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AE97E2E8030
 for <qemu-devel@nongnu.org>; Thu,  9 Apr 2020 17:40:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Apr 2020 17:31:40 -0000
From: Russell Morris <ubuntu@rkmorris.us>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 6-u3untu-h chewi
X-Launchpad-Bug-Reporter: Russell Morris (6-u3untu-h)
X-Launchpad-Bug-Modifier: Russell Morris (6-u3untu-h)
References: <158621521246.22866.8297146941622716788.malonedeb@wampee.canonical.com>
Message-Id: <158645350065.5216.5686824253154041092.malone@chaenomeles.canonical.com>
Subject: [Bug 1871250] Re: Failed to create HAX VM
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="2e26c9bbd21cdca248baaea29aeffb920afcc32a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: ec6a9ae81ac0669f2626cb1c4c01fe975a677f46
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
Reply-To: Bug 1871250 <1871250@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NP, will do. Thanks again for the help!

** Changed in: qemu
       Status: New =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1871250

Title:
  Failed to create HAX VM

Status in QEMU:
  Fix Committed

Bug description:
  Hi,

  I'm running the latest (master) of QEMU, though the version doesn't
  seem to matter - I also checked back to v4.2.0, exactly the same
  issue. And this isn't about the VM (guest), if I even just try to run,

  > "c:\Program Files\qemu\qemu-system-x86_64.exe" -accel hax

  Basically, just get a window to open, with acceleration enabled ... I get,
  Open the vm device error:/dev/hax_vm/vm00, ec:3
  Failed to open vm 0
  Failed to create HAX VM
  No accelerator found.

  But I checked - I have installed Intel HAXM, and verified it's running,
  > sc query intelhaxm
  SERVICE_NAME: intelhaxm
          TYPE               : 1  KERNEL_DRIVER
          STATE              : 4  RUNNING
                                  (STOPPABLE, NOT_PAUSABLE, IGNORES_SHUTDOW=
N)
          WIN32_EXIT_CODE    : 0  (0x0)
          SERVICE_EXIT_CODE  : 0  (0x0)
          CHECKPOINT         : 0x0
          WAIT_HINT          : 0x0

  Just remove the accelerator (-accel hax), and I get a window - so this
  is related to QEMU being able to contact / use the accelerator.

  Help!?!?

  Thanks!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1871250/+subscriptions


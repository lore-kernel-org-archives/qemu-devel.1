Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B675C4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2092A2082F
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 18:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2092A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEHIJ-0002Xc-3p
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 14:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iEHFn-0001M6-Fw
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iEHFm-0001Na-Bp
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:15:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:55870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iEHFm-0001Lc-4J
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 14:15:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iEHFk-0002bV-JX
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 18:15:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 885B72E80CB
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 18:15:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Sep 2019 18:05:59 -0000
From: Chris Schneider <1845580@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell shift838 th-huth
X-Launchpad-Bug-Reporter: Chris Schneider (shift838)
X-Launchpad-Bug-Modifier: Chris Schneider (shift838)
References: <156954986411.15692.14551657231977154875.malonedeb@gac.canonical.com>
Message-Id: <156969395943.16216.14813397855832852254.malone@chaenomeles.canonical.com>
Subject: [Bug 1845580] Re: issue with QEMU on Raspberry Pi failing to access
 CDROM
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19065";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 1f43537d302c5db3e60c7b12c1c1d279913ec9d6
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
Reply-To: Bug 1845580 <1845580@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I compiled 4.1.0 on the Raspberry, everything seemed to compile.

I have verified with qemu-system-i386 --version displays 4.1.0

Using the below basic command line:

qemu-system-i386 -hda c.hda -cdrom FD12CD.iso -boot order=3Dd

now when I try to execute the qemu I get only below as it just seems to
hang:


WARNING: Image format was not specified for 'c.hda' and probing guessed raw.
         Automatically detecting the format is dangerous for raw images, wr=
ite operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
VNC server running on ::1:5901

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1845580

Title:
  issue with QEMU on Raspberry Pi failing to access CDROM

Status in QEMU:
  New

Bug description:
  I am trying to access the CDROM (iso) from QEMU using FreeDOS and I
  get an error when doing a directory for:

  i can boot from the iso but if i exit to access the files from the
  CDROM ISO i get the attached error.

  I believe there is an issue with the QEMU for the Raspberry Pi.

  I am using a Raspberry Pi3 with the latest full Raspbian Buster load

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1845580/+subscriptions


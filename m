Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91461C28CBC
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5612137B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5612137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9dx-0001iM-Bl
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jU9Tb-0001w8-RX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1jU9R7-0000S4-Lp
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:43:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:33672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jU9R7-0000RS-4l
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:41:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jU9R5-0006D1-VL
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:41:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E12092E8105
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 13:41:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2020 13:33:07 -0000
From: Laurent Vivier <Laurent@vivier.eu>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ccstevens laurent-vivier
X-Launchpad-Bug-Reporter: Chris Stevens (ccstevens)
X-Launchpad-Bug-Modifier: Laurent Vivier (laurent-vivier)
References: <149809152821.28527.1538400923657139906.malonedeb@wampee.canonical.com>
Message-Id: <158825358718.4400.16769945910892749637.malone@chaenomeles.canonical.com>
Subject: [Bug 1699628] Re: Direct Sound Audio does not stop
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="fbdff7602bd10fb883bf7e2ddcc7fd5a16f60398";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 893f47f17616c731e169ae3a12c3d652e778cb4a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:35:36
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Reply-To: Bug 1699628 <1699628@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixed here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D4ba664cb0aab


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1699628

Title:
  Direct Sound Audio does not stop

Status in QEMU:
  Fix Released

Bug description:
  The Bug:
  DirectSound Audio does not stop because dsound_ctl_out does not end up ca=
lling IDirectSoundBuffer_Stop. This is due to a bug in dsound_get_status_ou=
t where the status flags returned from IDirectSoundBuffer_GetStatus are com=
pared with DSERR_BUFFERLOST (an error code) rather than DSBSTATUS_BUFFERLOS=
T (a status flag). The status is actually (DSBSTATUS_LOOPING | DSBSTATUS_PL=
AYING) and one of those flags happens to be set in the DSERR_BUFFERLOST val=
ue. As a result, dsound_get_status_out returns -1 and dsound_ctl_out exits =
before calling IDirectSoundBuffer_Stop.

  The Fix:
  A simple replacement of DSERR_BUFFERLOST with DSBSTATUS_BUFFERLOST in dso=
und_get_status_out. =

  Should be: "if (*statusp & DSBSTATUS_BUFFERLOST) {"

  Version Information:
  I was able to produce this bug in Qemu 2.9.0 and with the latest source p=
ulled from git://git.qemu-project.org/qemu.git (commit 8dfaf23ae1). I was a=
ble to verify my suggested fix with the latest source.

  Guest OS:
  Discovered running Minoca OS v0.4 (www.github.com/minoca/os). Images at h=
ttps://www.minocacorp.com/download/nightlies/latest-x86. The Qemu test imag=
es I tried (http://wiki.qemu.org/Testing/System_Images) didn't have an easy=
 sound setup (was looking for 'aplay' or similar).

  Qemu Command Line:
  ./qemu-system-x86_64.exe -m 512 -hda pc.img -smp 4 -usbdevice keyboard -d=
evice intel-hda -device hda-duplex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1699628/+subscriptions


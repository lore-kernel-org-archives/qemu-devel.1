Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0F9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAC2820708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 23:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC2820708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tum.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJF0-0004Te-WD
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 18:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1ixHwS-00019b-GW
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1ixHwR-00046v-1Y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:05:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:35572)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1ixHwQ-00045S-ST
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 17:05:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1ixHwP-0006rE-F9
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 22:05:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6AE622E80C0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 22:05:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jan 2020 21:59:21 -0000
From: Noah Bergbauer <noah.bergbauer@tum.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: noah-bergbauer
X-Launchpad-Bug-Reporter: Noah Bergbauer (noah-bergbauer)
X-Launchpad-Bug-Modifier: Noah Bergbauer (noah-bergbauer)
Message-Id: <158042156192.19296.13362308580628501069.malonedeb@gac.canonical.com>
Subject: [Bug 1861458] [NEW] Clock drift issue with -soundhw hda
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0a62c17273454a1313f81a74a2198ec30b44c7b6";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: b77550c681cfc6d388ecf16cda8ce5f67b8f5446
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Thu, 30 Jan 2020 18:27:55 -0500
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
Reply-To: Bug 1861458 <1861458@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Here's the scenario: I'm working on code for loopback audio recording
(i.e. recording what you're hearing) using WASAPI on Windows. As I
usually develop on Linux, I'm using qemu to test this on a Windows 10
VM. The heart of WASAPI audio recording is the
IAudioCaptureClient::GetBuffer function (https://docs.microsoft.com/en-
us/windows/win32/api/audioclient/nf-audioclient-iaudiocaptureclient-
getbuffer). Among other things, this function produces a timestamp for
when the audio buffer it returned is supposed to be played.

When the audio device in question is the qemu hda device, this timestamp
is wrong.

There is a clock drift error (I measured it to be about 0.1%, i.e. 1ms
drift every second =3D a full second after 16 minutes) that causes the
audio clock to advance faster than the system clock. Paradoxically, this
does not affect audio playback through qemu at all, no delay there. Only
the timestamps returned to recording applications are completely bogus.

Unfortunately I'm not intimately familiar with the inner workings of
Intel HD Audio. All I can tell you is that this timestamp is supposedly
obtained directly from the hardware (which would be qemu in this case),
which is also why e.g. chromium implements a workaround for buggy
hardware that returns incorrect timestamps.

Here are the relevant parts of my command line (version 4.2.0):
-enable-kvm -machine pc-q35-3.1,kernel-irqchip=3Don -cpu host,kvm=3Doff,hv_=
time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff,hv_vendor_id=3DNvidiaFuckU -=
rtc base=3Dlocaltime -nodefaults -soundhw hda

Just wanted to let you know about this because it took me three days of
utter confusion and frustration to figure this out.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1861458

Title:
  Clock drift issue with -soundhw hda

Status in QEMU:
  New

Bug description:
  Here's the scenario: I'm working on code for loopback audio recording
  (i.e. recording what you're hearing) using WASAPI on Windows. As I
  usually develop on Linux, I'm using qemu to test this on a Windows 10
  VM. The heart of WASAPI audio recording is the
  IAudioCaptureClient::GetBuffer function (https://docs.microsoft.com
  /en-us/windows/win32/api/audioclient/nf-audioclient-
  iaudiocaptureclient-getbuffer). Among other things, this function
  produces a timestamp for when the audio buffer it returned is supposed
  to be played.

  When the audio device in question is the qemu hda device, this
  timestamp is wrong.

  There is a clock drift error (I measured it to be about 0.1%, i.e. 1ms
  drift every second =3D a full second after 16 minutes) that causes the
  audio clock to advance faster than the system clock. Paradoxically,
  this does not affect audio playback through qemu at all, no delay
  there. Only the timestamps returned to recording applications are
  completely bogus.

  Unfortunately I'm not intimately familiar with the inner workings of
  Intel HD Audio. All I can tell you is that this timestamp is
  supposedly obtained directly from the hardware (which would be qemu in
  this case), which is also why e.g. chromium implements a workaround
  for buggy hardware that returns incorrect timestamps.

  Here are the relevant parts of my command line (version 4.2.0):
  -enable-kvm -machine pc-q35-3.1,kernel-irqchip=3Don -cpu host,kvm=3Doff,h=
v_time,hv_relaxed,hv_vapic,hv_spinlocks=3D0x1fff,hv_vendor_id=3DNvidiaFuckU=
 -rtc base=3Dlocaltime -nodefaults -soundhw hda

  Just wanted to let you know about this because it took me three days
  of utter confusion and frustration to figure this out.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1861458/+subscriptions


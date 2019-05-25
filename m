Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BA8C282CE
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 04:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13FA420863
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 04:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13FA420863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36119 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUOMZ-0008NC-EA
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 00:32:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hUOJn-0006Qk-CR
	for qemu-devel@nongnu.org; Sat, 25 May 2019 00:30:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hUOJl-0000Wg-N6
	for qemu-devel@nongnu.org; Sat, 25 May 2019 00:30:03 -0400
Received: from indium.canonical.com ([91.189.90.7]:55846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hUOJl-0000WC-Hk
	for qemu-devel@nongnu.org; Sat, 25 May 2019 00:30:01 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hUOJk-0003kC-Az
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 04:30:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5203F2E8083
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 04:30:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 May 2019 04:17:25 -0000
From: Launchpad Bug Tracker <1313816@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Expired; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: janitor masm-e mjt+launchpad-tls th-huth
X-Launchpad-Bug-Reporter: Yuuki Harano (masm-e)
X-Launchpad-Bug-Modifier: Launchpad Janitor (janitor)
References: <20140428163716.4368.51327.malonedeb@soybean.canonical.com>
Message-Id: <155875784563.26936.7412141756909063029.malone@loganberry.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: e484a4c94dc320e66e4c213567e54e3a5d68d28c
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1313816] Re: qemu should close sound device when
 no more needs.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1313816 <1313816@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[Expired for QEMU because there has been no activity for 60 days.]

** Changed in: qemu
       Status: Incomplete =3D> Expired

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1313816

Title:
  qemu should close sound device when no more needs.

Status in QEMU:
  Expired

Bug description:
  I use alsa directly or via pulseaudio on qemu.
  And I use xmms2 as well as qemu.

  When I use alsa, one of xmms2 or qemu can play sound.
  When I use pulseaudio with qemu and pulseaudio -k, and pulseaudio --start,
  qemu can't play sound.

  I think that:
  - qemu should open sound device when needs.
  - qemu should close sound device when no more needs.

  One of xmms2 or qemu can play sound, but both of them rarely play sound
  at the same time.
  qemu occurs error on pulseaudio -k, but once close and open the device,
  the error will be recovered, I hope.

  Host: slackware64 14.1, linux kernel 3.14.2
  Qemu: 2.0.0
  QEMU_AUDIO_DRV=3Dpa /usr/local/bin/qemu-system-x86_64 -enable-kvm -hda /d=
osc/win8_x64.img -soundhw hda -boot c -m 2G -cpu host -usb -usbdevice table=
t -display sdl -rtc base=3Dlocaltime
  Guest: Windows 8.1 x64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1313816/+subscriptions


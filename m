Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40ADC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 514A3218D2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514A3218D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJAjf-0000cl-Cy
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 01:46:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAiq-0008UN-Ki
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAip-0003uw-6x
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:45:32 -0400
Received: from indium.canonical.com ([91.189.90.7]:38564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAio-0003sv-Vr
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:45:31 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAio-0004Is-1C
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:45:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0224D2E800F
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:45:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:32:17 -0000
From: Thomas Huth <1603785@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell th-huth thomas-lindroth
X-Launchpad-Bug-Reporter: Thomas (thomas-lindroth)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20160717150709.16272.95916.malonedeb@gac.canonical.com>
Message-Id: <155608393791.14488.3038748270397396831.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 9aeec5d4266ca26f68d04707464409a81d791c05
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1603785] Re: trace_usb_port_attach prints junk
 data
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
Reply-To: Bug 1603785 <1603785@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424053217.K0bzklUj6rbxaYphaeyY80zhSjQwrs6z4uVdcsNV61c@z>

Patch has been included here:
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D5189e30b146ab39f9d

** Changed in: qemu
       Status: In Progress =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1603785

Title:
  trace_usb_port_attach prints junk data

Status in QEMU:
  Fix Released

Bug description:
  Running qemu with tracing (-D ~/qemu_trace -d trace:\*) will result in
  a trace file with unprintable characters.

  example: usb_port_attach bus 0, port 1, devspeed <90>l<DB>.<D8>U,
  portspeed full+high

  The problem is in hw/usb/bus.c usb_mask_to_str. If speedmask doesn't
  match any of the defined speed nothing is written to *dest and
  uninitialized data is printed to the log.

  This happens with a real usb device that is forwarded into the
  machine.

  My qemu version is 2.6.0 but it looks like the problem exists in
  latest git also.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1603785/+subscriptions


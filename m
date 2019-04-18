Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DF0C10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 05:46:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0A921479
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 05:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0A921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36211 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGzsN-0006Dz-6J
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 01:46:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGzrb-0005pv-3j
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 01:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGzrZ-0002cl-UW
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 01:45:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:58050)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGzrZ-0002bM-JT
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 01:45:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGzrX-0004MM-QB
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:45:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C05932E80C8
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 05:45:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2019 05:35:23 -0000
From: Thomas Huth <639651@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug: distribution=debian; sourcepackage=qemu; component=main;
	status=Incomplete; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: windows
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: hramrach jes-sorensen th-huth
X-Launchpad-Bug-Reporter: Michal Suchanek (hramrach)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20100915151259.29737.65112.malonedeb@potassium.ubuntu.com>
Message-Id:
 <155556572518.14092.6096361737110370770.launchpad@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d4e1d30bf67e3e2c0c4f6adbf88b52cf0cca022b
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 639651] Re: DRIVER_IRQL_NOT_LESS_OR_EQUAL booting
 WIndows XP with Synaptics driver installed
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
Reply-To: Bug 639651 <639651@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418053523.LXAqF0PQ99j33RAzA8qXi5SBQ8xr7oIM7_klUI1nPGA@z>

** Changed in: qemu (Debian)
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/639651

Title:
  DRIVER_IRQL_NOT_LESS_OR_EQUAL booting WIndows XP with Synaptics driver
  installed

Status in QEMU:
  Incomplete
Status in qemu package in Debian:
  Incomplete

Bug description:
  Positng the issue here since I did not get any reply on the ML.

  I was trying to update some windows XP (SP3) images in kvm.

  It worked fine several times but last time I added mass storage
  drivers to sysprep and now on the second boot after reseal (the first
  is mini-setup) I get a BSOD with message
  DRIVER_IRQL_NOT_LESS_OR_EQUAL. =


  It turns out that the error is unrelated to storage drivers. It is
  triggered by Synaptics driver installing for the PS2 mouse in kvm
  (which does not happen in VirtualBox or on real hardware).

  The image is originally created on hardware with MP acpi (not
  virtualization).

  qemu-kvm                  0.12.5+dfsg-2

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/639651/+subscriptions


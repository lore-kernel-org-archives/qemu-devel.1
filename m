Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09A0C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A967920854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A967920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQpn-0000QH-PL
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iKQoY-0008Cm-6U
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iKQoW-0006Z4-Ku
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:40:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:38490)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iKQoV-0006YE-KS
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 13:40:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iKQoT-00049H-CH
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 17:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 57A142E8073
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 17:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Oct 2019 17:33:32 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: chardev
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd pmaydell
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <157115912269.6241.2879996455235466128.malonedeb@gac.canonical.com>
Message-Id: <157116081289.22310.16365337092715457705.malone@wampee.canonical.com>
Subject: [Bug 1848231] Re: serial/parallel character devices created for the
 none-machine
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="44557a7d51630548e7d0aa4259446ccd7e1731bd";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 6a97a21af521f6091fb1e6e12f831051238679ae
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
Reply-To: Bug 1848231 <1848231@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

You can start 'none' without "-serial null". Examples:

qemu-system-x86_64 -machine none
qemu-system-x86_64 -machine none -monitor stdio
qemu-system-x86_64 -machine none -nographic
qemu-system-x86_64 -machine none -monitor stdio -display none

Your command line "qemu-system-x86_64 -machine none -nographic -monitor
stdio" fails because "-nographic" says "please create a serial port
using stdio" but "-monitor stdio" tries to use stdio for something else.
You get the same message for any machine (eg "pc"), not just "none". If
what you wanted was "just don't create the graphical display" that's
"-display none" -- "-nographic" is a collection of things including both
'no display' and also 'default to creating a serial device to stdio' and
'default to creating a monitor muxed with that serial'.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1848231

Title:
  serial/parallel character devices created for the none-machine

Status in QEMU:
  Invalid

Bug description:
  The none-machine can not be started unless using "-serial null":

  qemu-system-x86_64 -machine none -nographic -monitor stdio
  QEMU 3.1.1 monitor - type 'help' for more information
  (qemu) qemu-system-x86_64: cannot use stdio by multiple character devices
  qemu-system-x86_64: could not connect serial device to character backend =
'stdio'
  $

  $ qemu-system-mips -machine none -nographic -serial null -monitor stdio
  QEMU 4.1.50 monitor - type 'help' for more information
  (qemu) info chardev
  parallel0: filename=3Dnull
  compat_monitor0: filename=3Dstdio
  serial0: filename=3Dnull
  (qemu)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1848231/+subscriptions


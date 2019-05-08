Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70401C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426AA204EC
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 13:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426AA204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37135 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOMYC-000567-Aw
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 09:24:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOMV8-00034H-V4
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOMV7-0007gu-2z
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:20:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:39176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hOMV6-0007ay-R6
	for qemu-devel@nongnu.org; Wed, 08 May 2019 09:20:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hOMV4-0007gO-1j
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 13:20:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 089802E807C
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 13:20:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 May 2019 13:08:55 -0000
From: Daniel Berrange <1828207@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: berrange rawlik
X-Launchpad-Bug-Reporter: Druta Pavel (rawlik)
X-Launchpad-Bug-Modifier: Daniel Berrange (berrange)
References: <155731026034.22594.3160504765111033354.malonedeb@chaenomeles.canonical.com>
Message-Id: <155732093601.13635.15801388089086899054.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18958";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 7c99dbd9191883b7e100859573d6b5e121526515
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1828207] Re: Request to add something like "Auth
 failed from IP" log report for built-in VNC server
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
Reply-To: Bug 1828207 <1828207@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Note that any use of the built-in VNC-auth scheme is always considered a
security flaw. It should essentially never be used, especially not on
any public internet facing service, even if fail2ban were able to be
used.

A secure VNC server should use the VeNCrypt extension which enables TLS,
with optional client certificate validation as an auth mechanism.  Once
you have TLS enabled, you can also then enable the SASL auth mechanism
to further authenticate clients using Kerberos or PAM, or other SASL
plugins.

That's not to say we shouldn't emit a log message, suitable for
consuming from fail2ban, as remote clients can still trigger a CPU
denial of service by repeatedly connecting even if they ultimately
always fail authentication.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1828207

Title:
  Request to add something like "Auth failed from IP" log report for
  built-in VNC server

Status in QEMU:
  New

Bug description:
  In environment with needs of public accessible VNC ports there is no logs=
 or other registered events about authentication failures to analyze and/or=
 integrate it to automated services like fail2ban ans so on.
  Thus the built-in VNC service is vulnerable to brutforce attacks and in c=
ombination with weak built-in VNC-auth scheme can be a security vulnerabili=
ty.

  Adding a simple log record like "QEMU VNC Authentication failed
  192.168.0.5:5902 - 123.45.67.89:7898" will permit to quickly integrate
  it to fail2ban system.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1828207/+subscriptions


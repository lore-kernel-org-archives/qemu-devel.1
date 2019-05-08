Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31455C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF7921019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF7921019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36681 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOM9q-0007uE-A4
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 08:58:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOJlb-0002cE-MD
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hOJla-0001WR-IX
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:25:39 -0400
Received: from indium.canonical.com ([91.189.90.7]:51464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hOJla-0001Vk-CI
	for qemu-devel@nongnu.org; Wed, 08 May 2019 06:25:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hOJlZ-0001vZ-7T
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 10:25:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 362BD2E8041
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 10:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 May 2019 10:11:00 -0000
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rawlik
X-Launchpad-Bug-Reporter: Druta Pavel (rawlik)
X-Launchpad-Bug-Modifier: Druta Pavel (rawlik)
Message-Id: <155731026034.22594.3160504765111033354.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18958";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: bf05120d8206c35a1e510357aee1038f847a7104
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
X-Mailman-Approved-At: Wed, 08 May 2019 08:57:13 -0400
Subject: [Qemu-devel] [Bug 1828207] [NEW] Request to add something like
 "Auth failed from IP" log report for built-in VNC server
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
From: Druta Pavel via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Bug 1828207 <1828207@bugs.launchpad.net>
Cc: Druta Pavel <rawlik@list.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

In environment with needs of public accessible VNC ports there is no logs o=
r other registered events about authentication failures to analyze and/or i=
ntegrate it to automated services like fail2ban ans so on.
Thus the built-in VNC service is vulnerable to brutforce attacks and in com=
bination with weak built-in VNC-auth scheme can be a security vulnerability.

Adding a simple log record like "QEMU VNC Authentication failed
192.168.0.5:5902 - 123.45.67.89:7898" will permit to quickly integrate
it to fail2ban system.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: feature-request

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


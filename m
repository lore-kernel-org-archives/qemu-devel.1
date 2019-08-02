Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7968C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 11:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F21B206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 11:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F21B206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htW0f-0007dY-IR
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 07:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56286)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1htW07-0007Dh-Vd
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1htW06-0001Tq-T1
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:45:35 -0400
Received: from indium.canonical.com ([91.189.90.7]:55938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1htW06-0001TM-Nd
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 07:45:34 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1htW05-0006Zp-0P
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 11:45:33 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E2AE42E80D1
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 11:45:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Aug 2019 11:38:51 -0000
From: =?utf-8?b?5ZGo5paH6Z2S?= <1838763@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ausername
X-Launchpad-Bug-Reporter: =?utf-8?b?5ZGo5paH6Z2SIChhdXNlcm5hbWUp?=
X-Launchpad-Bug-Modifier: =?utf-8?b?5ZGo5paH6Z2SIChhdXNlcm5hbWUp?=
Message-Id: <156474593196.25727.15962542236379825575.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19014";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 4979844219c9a0de7911c2db4dc554d4103fe8d4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838763] [NEW] Bugs in SSH module (ssh.c)
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
Reply-To: Bug 1838763 <1838763@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I installed gcc-8&libssh* on my Ubuntu 18.04 arm64.When I was compiling
any version of qemu like 3.1.0 4.0.0or 4.1.0 with SSH support,the GCC
went wrong.It said some vars undeclared
like'SSH_KNOWN_HOSTS_OTHER','SSH_KNOWN_HOST_UNKNOWN',etc.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838763

Title:
  Bugs in SSH module (ssh.c)

Status in QEMU:
  New

Bug description:
  I installed gcc-8&libssh* on my Ubuntu 18.04 arm64.When I was
  compiling any version of qemu like 3.1.0 4.0.0or 4.1.0 with SSH
  support,the GCC went wrong.It said some vars undeclared
  like'SSH_KNOWN_HOSTS_OTHER','SSH_KNOWN_HOST_UNKNOWN',etc.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838763/+subscriptions


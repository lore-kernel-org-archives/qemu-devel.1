Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CD6C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2614F2173B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2614F2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqf0D-0006A5-Bw
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38667)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hqezu-0005F4-N7
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:45:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hqezt-0001Ny-FV
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:45:34 -0400
Received: from indium.canonical.com ([91.189.90.7]:45454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hqezt-0001LZ-9l
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:45:33 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hqezr-0001IQ-Uh
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 14:45:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id C92152E80CC
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 14:45:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jul 2019 14:36:57 -0000
From: elmarco <marcandre.lureau@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: crobinso marcandre-lureau
X-Launchpad-Bug-Reporter: Cole Robinson (crobinso)
X-Launchpad-Bug-Modifier: elmarco (marcandre-lureau)
References: <156406441263.18058.18411127090440261548.malonedeb@gac.canonical.com>
Message-Id: <156406541803.17681.2502459833725209168.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: fd036c3443f26b4e31f70c254fa8891d50e98d47
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1837909] Re: test-char fails if host has no
 network interfaces
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
Reply-To: Bug 1837909 <1837909@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should be addressed by:
https://patchew.org/QEMU/20190713143311.17620-1-marcandre.lureau@redhat.com/

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1837909

Title:
  test-char fails if host has no network interfaces

Status in QEMU:
  New

Bug description:
  # ./tests/test-char =

  # random seed: R02S8602535bf831a74bca571d8c416d8161
  1..34
  # Start of char tests
  ...
  ok 12 /char/websocket
  # Start of stdio tests
  # End of stdio tests
  # Start of socket tests
  # Start of server tests
  # Start of mainloop tests
  Unexpected error in inet_parse_connect_saddr() at util/qemu-sockets.c:421:
  # =

  # address resolution failed for 127.0.0.1:42275: Name or service not known
  # =


  Aborted (core dumped)

  =

  # ip a
  1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group=
 default qlen 1000
      link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
      inet 127.0.0.1/8 scope host lo
         valid_lft forever preferred_lft forever
      inet6 ::1/128 scope host =

         valid_lft forever preferred_lft forever

  =

  This seems to be related to use of AI_ADDRCONFIG in qemu-sockets.c inet_p=
arse_connect_saddr, dropping it fixes the test. 'man getaddrinfo' makes it =
sound like AI_ADDRCONFIG requires the host to have a non-loopback ipv4 or i=
pv6 address available

  This host setup may seem niche, but it is what the 'mock' RPM build
  tool has by default. In Fedora we run the test suite during the RPM
  build, so the failing test causes a bit of pain for certain workflows

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1837909/+subscriptions


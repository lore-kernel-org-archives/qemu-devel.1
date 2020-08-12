Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDA1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:36:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0CB20771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 16:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0CB20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5tjm-00052k-GB
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 12:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5tj7-0004BM-85
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:35:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:32826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k5tj5-0003Pb-67
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 12:35:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k5tj3-0003Le-3j
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 16:35:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 0996C2E808D
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 16:35:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2020 16:23:55 -0000
From: "Darrin M. Gorski" <1213196@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Wishlist; assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 5qk3gg6cp81roqqbfsitohb98stjiq5g darringorski
X-Launchpad-Bug-Reporter: Nathaniel Filardo (5qk3gg6cp81roqqbfsitohb98stjiq5g)
X-Launchpad-Bug-Modifier: Darrin M. Gorski (darringorski)
References: <20130816180742.32647.79496.malonedeb@chaenomeles.canonical.com>
Message-Id: <159724943552.25840.5872721575738967478.malone@gac.canonical.com>
Subject: [Bug 1213196] Re: -serial tcp should hang up when DTR goes low
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 74d1efbf0dc79e295db5892c346f787842e26bf9
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:10:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1213196 <1213196@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In addition to allowing low DTR to drop the socket connection, and
allowing low DTR to reject a socket connection, the DCD modem bit also
be implemented - DCD should follow the state of the TCP socket: a
connected socket should pull DCD high, and a disconnected socket should
pull DCD low. From what Ive seen in the source, it looks like a serial
IOCTL functioned needs to be added to chardev/char-socket.c to allow the
MSR bits to be tracked against the state of the socket.  DCD should be
very easy to implement this way, but I hadn't thought about DTR.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1213196

Title:
  -serial tcp should hang up when DTR goes low

Status in QEMU:
  New

Bug description:
  In keeping with the spirit of serial modem control signals, de-
  asserting DTR should cause the TCP connection to break; asserting DTR
  should cause QEMU to initiate a new connection or for it to accept
  another (in server mode; this may involve waiting for one to arrive,
  too).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1213196/+subscriptions


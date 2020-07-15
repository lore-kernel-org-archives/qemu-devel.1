Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359A5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 04:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FAB206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 04:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FAB206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvYcB-0001U5-4Z
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 00:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jvYbA-00013r-LS
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 00:00:48 -0400
Received: from indium.canonical.com ([91.189.90.7]:46692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jvYb8-0003ED-Ik
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 00:00:48 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jvYb6-000771-H8
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 04:00:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7C1912E80E7
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 04:00:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2020 03:51:04 -0000
From: Ralph G <1887604@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: feature-request
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: superflip
X-Launchpad-Bug-Reporter: Ralph G (superflip)
X-Launchpad-Bug-Modifier: Ralph G (superflip)
Message-Id: <159478506417.12547.6442940817184262205.malonedeb@soybean.canonical.com>
Subject: [Bug 1887604] [NEW] Forward host UNIX socket to guest TCP port
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="4809fcb62f445aaa3ae919f7f6c3cc7d156ea57a";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 52af868b8fd8810b190601724dd7b6e15b1c8db1
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 00:00:44
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
Reply-To: Bug 1887604 <1887604@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hello. I've been racking my brain trying to work out if this is
possible.

I would like to be able to forward to a guest TCP port, via a host UNIX
socket to avoid opening a TCP port on the host. For example:

qemu-system-i386 [...] -nic user,hostfwd=3Dunix:/path/to/socket-:22

and then connect to the VM like:

ssh -o "ProxyCommand socat - unix-connect:/path/to/socket" user@0.0.0.0

QEMU, as versatile as it is, doesn't appreciate my intuited syntax
"hostfwd=3Dunix:...". It is also unhappy with:

qemu-system-i386 [...] \
    -chardev socket,id=3Dfoo,path=3D/path/to/socket,server,nowait \
    -nic user,hostfwd=3Dchardev:foo-:22

And:

qemu-system-i386 [...] \
    -nic user \
    -chardev socket,id=3Dfoo,path=3D/path/to/socket,server,nowait \
    -chardev socket,id=3Dfoo,host=3D10.0.2.15,port=3D22

I already found out how to connect in the opposite direction, **from**
guest TCP to host UNIX, via guestfwd -> cmd -> socat. So I feel like
there ought to be a way.

If this is not yet a feature I would like to request it, and if it is,
please tell me how!

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: feature-request

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1887604

Title:
  Forward host UNIX socket to guest TCP port

Status in QEMU:
  New

Bug description:
  Hello. I've been racking my brain trying to work out if this is
  possible.

  I would like to be able to forward to a guest TCP port, via a host
  UNIX socket to avoid opening a TCP port on the host. For example:

  qemu-system-i386 [...] -nic user,hostfwd=3Dunix:/path/to/socket-:22

  and then connect to the VM like:

  ssh -o "ProxyCommand socat - unix-connect:/path/to/socket"
  user@0.0.0.0

  QEMU, as versatile as it is, doesn't appreciate my intuited syntax
  "hostfwd=3Dunix:...". It is also unhappy with:

  qemu-system-i386 [...] \
      -chardev socket,id=3Dfoo,path=3D/path/to/socket,server,nowait \
      -nic user,hostfwd=3Dchardev:foo-:22

  And:

  qemu-system-i386 [...] \
      -nic user \
      -chardev socket,id=3Dfoo,path=3D/path/to/socket,server,nowait \
      -chardev socket,id=3Dfoo,host=3D10.0.2.15,port=3D22

  I already found out how to connect in the opposite direction, **from**
  guest TCP to host UNIX, via guestfwd -> cmd -> socat. So I feel like
  there ought to be a way.

  If this is not yet a feature I would like to request it, and if it is,
  please tell me how!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1887604/+subscriptions


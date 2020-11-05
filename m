Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC5C4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E48A206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E48A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafd7-00056i-48
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kafUb-0001lO-5i
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:57 -0500
Received: from indium.canonical.com ([91.189.90.7]:35732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kafUX-0003c8-6W
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:39:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kafUU-0002GY-Gc
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 13:39:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 746BF2E8132
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 13:39:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2020 13:28:33 -0000
From: Peter Maydell <1619896@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: arm linux-user teamspeak
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell tobias-quintern
X-Launchpad-Bug-Reporter: Tobias Quintern (tobias-quintern)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <20160903112421.26727.12298.malonedeb@gac.canonical.com>
Message-Id: <160458291351.19044.14007748975638921267.malone@soybean.canonical.com>
Subject: [Bug 1619896] Re: linux-user missing cmsg IP_PKTINFO support
 ("Unsupported ancillary data: 0/8")
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: cb05e293022ea9eba8b33d0df03042f52e851c2f
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 04:11:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1619896 <1619896@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cmsg level/type 0/8 is SOL_IP / IP_PKTINFO. QEMU's handling of
sendmsg/recvmsg control messages needs specific support for each type of
message, and we currently do not have any support for most of them.

NB: given the description of the way client 1 at least is successful,
the guest program may be successfully coping with the missing support,
in which case the other failures would be somewhere else. It would be
worth retrying with a recent version of QEMU if you still care about
this guest program.


** Summary changed:

- Unsupported ancillary data: 0/8
+ linux-user missing cmsg IP_PKTINFO support ("Unsupported ancillary data: =
0/8")

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1619896

Title:
  linux-user missing cmsg IP_PKTINFO support ("Unsupported ancillary
  data: 0/8")

Status in QEMU:
  Confirmed

Bug description:
  Hello,

  I have the following issue when launching the Teamspeak Server x86
  binary on an arm host.

  Host:
   Linux 4.6.2 (vanilla)
   Ubuntu 14.04.5 LTS
   HW: Cubietruck board, armv7l

  =

  Used SW: Release archive qemu-2.7.0.tar.bz2 and git commit 1dc33ed90bf1fe=
1c2014dffa0d9e863c520d953a
  Configure options:
    ../configure --target-list=3Di386-linux-user =

  I attached the output of the configure script as configure.log

  Testcase:

  1. Download and extract TeamSpeak 3 Server 3.0.13.3 (x86)
    Souce: http://dl.4players.de/ts/releases/3.0.13.3/teamspeak3-server_lin=
ux_x86-3.0.13.3.tar.bz2

  2. Modifiy ts3server_minimal_runscript.sh for ease of use
    - ./ts3server $@
    + /usr/local/bin/qemu-i386 ./ts3server $@

  3. Execute ./ts3server_minimal_runscript.sh

  Wait for 6 Minutes until teamspeak server started. QEMU saturates the
  cpu while Teamspeak is precomputing a puzzle. (Whatever that means)

  After that Teamspeak settles with the following output:
    2016-09-03 10:50:59.555582|INFO    |Query         |   |listening on 0.0=
.0.0:10011, :::10011

  The Qemu process is now idling with ~2% cpu load. This is actually the
  first time for me that QEMU is able to successfully launch the
  Teamspeak server. Kudos!

  4. Connect client 1

  TS Clients can connect, but the following line is printed pretty often:
    Unsupported ancillary data: 0/8

  The line seems to come from qemu (linux-user/syscall.c)

  =

  5. Connect client 2
  When a second client is connected the audio transmission is successful fo=
r a few seconds, but the server drops the connection after that and refuses=
 to take new connections.

  Please let me know, if you need more information. I'll gladly provide
  strace or valgrind logs.

  Best regards,
  Tobias

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1619896/+subscriptions


Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D48C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC8E5206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8E5206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k53pU-00035c-1x
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k53ou-0002bM-8k
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:10:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:55018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k53oS-0006ob-Fo
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:10:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k53oQ-0000HK-6o
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 09:09:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2DA522E8041
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 09:09:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2020 08:56:41 -0000
From: Nadav Har'El <1407808@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nyh th-huth
X-Launchpad-Bug-Reporter: Nadav Har'El (nyh)
X-Launchpad-Bug-Modifier: Nadav Har'El (nyh)
References: <20150105215424.22410.18753.malonedeb@gac.canonical.com>
Message-Id: <159704980159.22566.12383430543465802428.malone@chaenomeles.canonical.com>
Subject: [Bug 1407808] Re: virtual console gives strange response to ANSI DSR
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="6a138c03da9cc3e2e03f6dd3bbb4a615b0be6ec2";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 511b0a3595a3eb66b9bb3093fe812f6113e2bc3a
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 04:45:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Bug 1407808 <1407808@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bug still very much exists (I tested qemu 4.2.1):
If you don't use "-serial stdio" (or its newer variants), by default Qemu o=
pens a new black "console" to run the application. It is not clear to me ex=
actly which terminal this console is supposed to emulate, but it does seem =
to support most ANSI escape sequences I tried. However, it supports the ANS=
I "DSR" (Device Status Report) escape sequence, ESC [ 6 n (see https://en.w=
ikipedia.org/wiki/ANSI_escape_code), incorrectly, just as I reported in the=
 original issue. This is still true today.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1407808

Title:
  virtual console gives strange response to ANSI DSR

Status in QEMU:
  Incomplete

Bug description:
  With "-serial vc" (which is the default), qemu make strange responses
  to the ANSI DSR escape sequence (\033[6n) which can confuse guests.

  Terminal emulators supporting the ANSI escape sequences usually
  support the "Device Status Report" escape sequence, \033[6n, to which
  as a response the terminal injects as input the response \033[n;mR,
  containing the current cursor position. An application running in the
  guest can use this escape sequence to, for example, figure out the
  size of the terminal it is running under, which can be useful as the
  guest has no other standard way to figure out a "size" for the serial
  port.

  Unfortunately, it seems that qemu when run with "-serial vc" (which
  appears to be the default), when qemu gets the \033[6n escape sequence
  on the serial port, it just responds with a single \033, and that's
  it! This can confuse an application, could concievably assume that a
  terminal either supports this escape sequence and injects the correct
  response (\033[n;mR), or doesn't support it and injects absolutely
  nothing as input - but not something in between.

  This caused a problem on one shell implementation on OSv that tried to
  figure out the terminal's size, and had to work around this unexpected
  behavior (see https://github.com/cloudius-
  systems/osv/commit/b79223584be40459861d1c12e1cb67e3e49e2a12).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1407808/+subscriptions


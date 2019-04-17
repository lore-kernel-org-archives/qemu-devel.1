Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3756C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B20206B6
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B20206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57341 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGods-00063a-RQ
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 13:46:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGoci-0005KY-2S
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hGocf-0006H7-KK
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:45:27 -0400
Received: from indium.canonical.com ([91.189.90.7]:41588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hGoce-0006FZ-Ap
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:45:25 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hGocc-0004mt-0p
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 17:45:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F008A2E80C8
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 17:45:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Apr 2019 17:35:12 -0000
From: Thomas Huth <1484990@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug: distribution=ubuntu; sourcepackage=qemu; component=main;
	status=Fix Released; importance=Undecided; assignee=None; 
X-Launchpad-Bug-Tags: qemu-18.04
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: bigon janitor paelzer th-huth
X-Launchpad-Bug-Reporter: Laurent Bigonville (bigon)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <20150814145418.19376.19961.malonedeb@wampee.canonical.com>
Message-Id:
 <155552251289.13347.7563768602427723832.malone@wampee.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 13168f8b85a4f9b8d628e33c1e3580b77efb9a27
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1484990] Re: fsfreeze-hook script should also
 ignored dpkg generated files
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
Reply-To: Bug 1484990 <1484990@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417173512.2STTVxHgl82GaycDuarF-ucPsU-ktRiZ9L7YYsIdZcc@z>

Fix had been included here (in QEMU v3.1 already):
https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D7294e600eb814fd2

** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1484990

Title:
  fsfreeze-hook script should also ignored dpkg generated files

Status in QEMU:
  Fix Released
Status in qemu package in Ubuntu:
  Fix Released

Bug description:
  Hello,

  In the fsfreeze-hook script, the following code check if some of the
  files should be ignored:

  =

  # Check whether file $1 is a backup or rpm-generated file and should be i=
gnored
  is_ignored_file() {
      case "$1" in
          *~ | *.bak | *.orig | *.rpmnew | *.rpmorig | *.rpmsave | *.sample)
              return 0 ;;
      esac
      return 1
  }

  The functions should probably also skip dpkg generated files.

  I've found a list of the different extensions in the systemd source
  tree:
  https://github.com/systemd/systemd/blob/master/src/basic/util.c#L1871

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1484990/+subscriptions


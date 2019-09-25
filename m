Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBEBC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC642082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:17:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC642082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2Uh-0001vF-Cp
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iD2Sz-0001Ku-4R
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iD2Sy-0007Pu-0x
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:16:05 -0400
Received: from indium.canonical.com ([91.189.90.7]:47584)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iD2Sx-0007PG-Rr
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:16:03 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iD2Sv-00074S-Gx
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:16:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 5B5982E80CB
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:16:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Sep 2019 08:07:28 -0000
From: Thomas Huth <1824704@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Incomplete; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: drjs5x kraxel-redhat th-huth
X-Launchpad-Bug-Reporter: mustafa (drjs5x)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <155524844990.21262.8108456842078597088.malonedeb@chaenomeles.canonical.com>
Message-Id: <156939884851.13736.11653485004392079773.malone@gac.canonical.com>
Subject: [Bug 1824704] Re: -k tr not working after v20171217! turkish keyboard
 dont working
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a25e414cba1760de083af0fc6456161aab436ab4
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
Reply-To: Bug 1824704 <1824704@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

What does v20171217 refer to? A pre-built binary? Windows? Linux? Mac
OS? ... sorry, but you have to be a little bit more specific.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1824704

Title:
  -k tr not working after v20171217! turkish keyboard dont working

Status in QEMU:
  Incomplete

Bug description:
  hi qemu

  -k tr not working after v20171217! turkish keyboard dont working

  last working without proplem at v20171217!

  after this version  tr keyboard proplem.
  freedos  , winpe  ,  linux images   all dont working tr  turkish keyboard.

  example   press key " =C3=A7 "  show " , "
  example 2 press key " . "  show " =C3=A7 "

  tr keyboard work  always "en-us" kbd.
  :((((((((

  please fix this critical bug.

  Sincerely

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1824704/+subscriptions


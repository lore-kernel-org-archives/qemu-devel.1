Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70BEC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD71420795
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 10:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD71420795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIUKX-0008Cq-RX
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 06:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIUJV-0007H3-S6
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:05:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:40518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIUJS-0002Dk-7h
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 06:05:21 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kIUJQ-00065L-11
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 10:05:16 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id DC99D2E80EA
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 10:05:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2020 09:55:26 -0000
From: kjonca <1618301@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: mouse ps2
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: 3u-mail kjonca
X-Launchpad-Bug-Reporter: nivekuil (3u-mail)
X-Launchpad-Bug-Modifier: kjonca (kjonca)
References: <20160830031518.12252.40741.malonedeb@chaenomeles.canonical.com>
Message-Id: <160025012731.930.721921473911481005.launchpad@chaenomeles.canonical.com>
Subject: [Bug 1618301] Re: qemu-input: Mouse stops working in Windows guest
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 31f799e241f1553b1d17310c75c1ecebc72123df
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 05:50:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1618301 <1618301@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

** Tags added: mouse ps2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1618301

Title:
  qemu-input: Mouse stops working in Windows guest

Status in QEMU:
  New

Bug description:
  ROCCAT Kone XTD mouse will randomly stop working in the guest until
  it's restarted.  Windows Event Viewer shows an error in i8042prt, with
  the message "Could not set the mouse resolution". The XML log:

  - <Event xmlns=3D"http://schemas.microsoft.com/win/2004/08/events/event">
  - <System>
    <Provider Name=3D"i8042prt" /> =

    <EventID Qualifiers=3D"49157">23</EventID> =

    <Level>2</Level> =

    <Task>0</Task> =

    <Keywords>0x80000000000000</Keywords> =

    <TimeCreated SystemTime=3D"2016-08-30T02:52:00.354536300Z" /> =

    <EventRecordID>5708</EventRecordID> =

    <Channel>System</Channel> =

    <Computer>cronus</Computer> =

    <Security /> =

    </System>
  - <EventData>
    <Data /> =

    <Binary>000008000100000000000000170005C03205000000000000000000000000000=
000000000000000000000000000000000</Binary> =

    </EventData>
    </Event>

  Host is running Linux 4.7.2 with QEMU 2.6.1.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1618301/+subscriptions


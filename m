Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4EDC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A712089F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 05:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A712089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJAU1-0008Vz-Fn
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 01:30:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAPl-0005Y0-RM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJAPi-00058k-9a
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:35728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJAPg-0004wT-6Z
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 01:25:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJAPc-0002Gy-Bo
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:25:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4DB0B2E80CD
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 05:25:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 05:19:13 -0000
From: Thomas Huth <1811499@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
	assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: dcb314 pmaydell zhangckid
X-Launchpad-Bug-Reporter: dcb (dcb314)
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <154728291472.21076.10443354877272687540.malonedeb@soybean.canonical.com>
Message-Id:
 <155608315455.14412.14329702719793406651.launchpad@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 55018cd3976d000fb20ec9779b3099eec9237001
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1811499] Re: qemu/net/colo-compare.c:288:
 possible pointless code duplication ?
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
Reply-To: Bug 1811499 <1811499@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424051913.nCwiME9CM50XN9A7rxvzHRuLH1H6TWCDlDUpHVDyJ3s@z>

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811499

Title:
  qemu/net/colo-compare.c:288: possible pointless code duplication ?

Status in QEMU:
  Fix Released

Bug description:
  qemu/net/colo-compare.c:288] -> [qemu/net/colo-compare.c:296]: (style)
  The if condition is the same as the previous if condition

  Source code is

      if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D spkt->=
seq_end) {
          if (colo_compare_packet_payload(ppkt, spkt,
                                          ppkt->header_size, spkt->header_s=
ize,
                                          ppkt->payload_size)) {
              *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRI=
MARY;
              return true;
          }
      }
      if (ppkt->tcp_seq =3D=3D spkt->tcp_seq && ppkt->seq_end =3D=3D spkt->=
seq_end) {
          if (colo_compare_packet_payload(ppkt, spkt,
                                          ppkt->header_size, spkt->header_s=
ize,
                                          ppkt->payload_size)) {
              *mark =3D COLO_COMPARE_FREE_SECONDARY | COLO_COMPARE_FREE_PRI=
MARY;
              return true;
          }
      }

  Maybe the second block was supposed to be different ?

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811499/+subscriptions


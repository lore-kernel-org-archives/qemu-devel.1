Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88015C2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:27:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7209208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7209208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEjm-0008C0-PA
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIEX2-0000BW-2x
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:14:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:41862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kIEKE-0001NK-BE
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:01:06 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kIEKB-0006SU-Dk
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 17:00:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1F06C2E8082
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 17:00:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2020 16:50:08 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1895703@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: buildsys tcg
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <160018860889.17103.9156462398304890013.malonedeb@soybean.canonical.com>
Subject: [Bug 1895703] [NEW] performance degradation in tcg since Meson switch
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="83bdf6c8a3a5f87722c8927e54838522f3e57504"; Instance="production"
X-Launchpad-Hash: 2343c86e8878db7786e3b520f1f35dae45cebba0
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 09:50:55
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
Reply-To: Bug 1895703 <1895703@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The buildsys conversion to Meson (1d806cef0e3..7fd51e68c34)
introduced a degradation in performance in some TCG targets:

--------------------------------------------------------
Test Program: matmult_double
--------------------------------------------------------
Target              Instructions     Previous    Latest
                                     1d806cef   7fd51e68
----------  --------------------  ----------  ----------
alpha              3 233 957 639       -----     +7.472%
m68k               3 919 110 506       -----    +18.433%
--------------------------------------------------------

Original report from Ahmed Karaman with further testing done
by Aleksandar Markovic:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg740279.html

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: buildsys tcg

** Tags added: buildsys tcg

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1895703

Title:
  performance degradation in tcg since Meson switch

Status in QEMU:
  New

Bug description:
  The buildsys conversion to Meson (1d806cef0e3..7fd51e68c34)
  introduced a degradation in performance in some TCG targets:

  --------------------------------------------------------
  Test Program: matmult_double
  --------------------------------------------------------
  Target              Instructions     Previous    Latest
                                       1d806cef   7fd51e68
  ----------  --------------------  ----------  ----------
  alpha              3 233 957 639       -----     +7.472%
  m68k               3 919 110 506       -----    +18.433%
  --------------------------------------------------------

  Original report from Ahmed Karaman with further testing done
  by Aleksandar Markovic:
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg740279.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1895703/+subscriptions


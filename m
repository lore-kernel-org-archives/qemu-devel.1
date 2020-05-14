Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DDEC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3761A20728
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 15:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3761A20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZFch-00061L-Ci
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 11:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jZFLv-0002hl-HR
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:00:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:37706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jZFLu-0006Di-En
 for qemu-devel@nongnu.org; Thu, 14 May 2020 11:00:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jZFLt-0000DE-6g
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 15:00:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 309C72E8023
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 15:00:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2020 14:50:47 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1878627@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <158946784791.31573.15508045306154621472.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1878627] [NEW] audio/mixeng build failure using Clang 10
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="0385b538081bc4718df6fb844a3afc89729c94ce";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 38cdd50bcce7c0f414c31aca8c2181ae138cd62b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:00:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1878627 <1878627@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When building with Clang 10 on Fedora 32, we get:

    CC      audio/mixeng.o
  audio/mixeng.c:274:34: error: implicit conversion from 'unsigned int' to =
'float' changes value from 4294967295 to 4294967296 [-Werror,-Wimplicit-int=
-float-conversion]
  static const float float_scale =3D UINT_MAX / 2.f;
                                   ^~~~~~~~ ~
  /usr/lib64/clang/10.0.0/include/limits.h:56:37: note: expanded from macro=
 'UINT_MAX'
  #define UINT_MAX  (__INT_MAX__  *2U +1U)
                     ~~~~~~~~~~~~~~~~~^~~

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878627

Title:
  audio/mixeng build failure using Clang 10

Status in QEMU:
  New

Bug description:
  When building with Clang 10 on Fedora 32, we get:

      CC      audio/mixeng.o
    audio/mixeng.c:274:34: error: implicit conversion from 'unsigned int' t=
o 'float' changes value from 4294967295 to 4294967296 [-Werror,-Wimplicit-i=
nt-float-conversion]
    static const float float_scale =3D UINT_MAX / 2.f;
                                     ^~~~~~~~ ~
    /usr/lib64/clang/10.0.0/include/limits.h:56:37: note: expanded from mac=
ro 'UINT_MAX'
    #define UINT_MAX  (__INT_MAX__  *2U +1U)
                       ~~~~~~~~~~~~~~~~~^~~

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878627/+subscriptions


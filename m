Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE39C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E58A206F1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E58A206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlIJS-0005cl-Co
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 16:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlIIu-0005Cu-I9
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 16:35:32 -0400
Received: from indium.canonical.com ([91.189.90.7]:54726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jlIIs-0008NH-Ix
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 16:35:32 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jlIIq-0003M3-Au
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 20:35:28 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 1FF072E8113
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 20:35:28 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2020 20:27:45 -0000
From: Evan Nemerson <1883784@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: ppc64le
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: nemequ
X-Launchpad-Bug-Reporter: Evan Nemerson (nemequ)
X-Launchpad-Bug-Modifier: Evan Nemerson (nemequ)
Message-Id: <159233926606.29237.7012634601262116409.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1883784] [NEW] [ppc64le] qemu behavior differs from ppc64le
 hardware
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="b190cebbf563f89e480a8b57f641753c8196bda0";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 681f0831e4a18632cce94318e0cbc71a128533a5
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 16:35:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Reply-To: Bug 1883784 <1883784@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

I have some code which passes my test suite on PPC64LE hardware when
compiled with GCC 10, but the saem binary fails with both qemu-ppc64le
4.2 (on Fedora 32) and qemu-ppc64le-static 5.0.0 (Debian testing).

I'm not getting any errors about illegal instructions or anything, like
that; the results are just silently different on qemu.

I've generated a reduced test case, which is attached along with the
binaries (both are the same code, one is just statically linked).  They
should execute successufully on PPC64LE hardware, but on qemu they hit a
__builtin_abort (because the computed value doesn't match the expected
value).

Without being familiar with PPC assembly I'm not sure what else I can
do, but if there is anything please let me know.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: ppc64le

** Attachment added: "test case"
   https://bugs.launchpad.net/bugs/1883784/+attachment/5384531/+files/mm_cv=
tpd_ps.tar.bz2

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1883784

Title:
  [ppc64le] qemu behavior differs from ppc64le hardware

Status in QEMU:
  New

Bug description:
  I have some code which passes my test suite on PPC64LE hardware when
  compiled with GCC 10, but the saem binary fails with both qemu-ppc64le
  4.2 (on Fedora 32) and qemu-ppc64le-static 5.0.0 (Debian testing).

  I'm not getting any errors about illegal instructions or anything,
  like that; the results are just silently different on qemu.

  I've generated a reduced test case, which is attached along with the
  binaries (both are the same code, one is just statically linked).
  They should execute successufully on PPC64LE hardware, but on qemu
  they hit a __builtin_abort (because the computed value doesn't match
  the expected value).

  Without being familiar with PPC assembly I'm not sure what else I can
  do, but if there is anything please let me know.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1883784/+subscriptions


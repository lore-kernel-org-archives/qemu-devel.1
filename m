Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EEDC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BEFF20774
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 13:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEFF20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqGit-0003EY-Fv
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 09:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jqGen-0004lO-QU
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:50:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:32932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jqGek-000059-UV
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 09:50:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jqGei-0006wA-GM
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 13:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 738B32E810B
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 13:50:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2020 13:42:05 -0000
From: Aleksandar Markovic <1885718@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: aleksandar-markovic dcb314 philmd
X-Launchpad-Bug-Reporter: dcb (dcb314)
X-Launchpad-Bug-Modifier: Aleksandar Markovic (aleksandar-markovic)
X-Launchpad-Bug-Duplicate: 1856706
References: <159352052121.16126.109202599760167358.malonedeb@soybean.canonical.com>
Message-Id: <159352452547.32236.15474828227615959296.malone@chaenomeles.canonical.com>
Subject: [Bug 1885718] Re: qemu/target/mips/op_helper.c:943:5:
 style:inconclusive: Found duplicate branches for 'if' and 'else'
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 633d4f57cb26ff732ca52b96847534e0f271fe86
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 08:40:48
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
Reply-To: Bug 1885718 <1885718@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

*** This bug is a duplicate of bug 1856706 ***
    https://bugs.launchpad.net/bugs/1856706

Thank you for reporting this!

Believe it or not, this has been a know issue to us for a while. We
contacted the original contributor, and he says he can't recall what he
actually meant when he wrote the segment. We left it as is until he
remembers. However, this seems not likely to happen, and probably we
will issue a fix soon. In any case, it is good that you reported it,
many thanks!

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1885718

Title:
  qemu/target/mips/op_helper.c:943:5: style:inconclusive: Found
  duplicate branches for 'if' and 'else'

Status in QEMU:
  New

Bug description:
  Source code is

      if (other_tc =3D=3D other->current_tc) {
          tccause =3D other->CP0_Cause;
      } else {
          tccause =3D other->CP0_Cause;
      }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1885718/+subscriptions


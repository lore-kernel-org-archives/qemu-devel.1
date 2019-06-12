Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD57C31E44
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 083C62054F
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 01:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083C62054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56192 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hasT1-00016y-BJ
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 21:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hasOQ-0004YM-IC
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hasBC-00012s-Lj
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:36:02 -0400
Received: from indium.canonical.com ([91.189.90.7]:59954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hasBA-0000xs-3v
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 21:35:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hasAl-0006hz-Ef
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 01:35:31 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 69CD32E806F
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 01:35:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Jun 2019 01:22:33 -0000
From: "Sonicadvance1@gmail.com" <Sonicadvance1@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sonicadvance1
X-Launchpad-Bug-Reporter: Sonicadvance1@gmail.com (sonicadvance1)
X-Launchpad-Bug-Modifier: Sonicadvance1@gmail.com (sonicadvance1)
Message-Id: <156030255368.16736.8122800429162874738.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18978";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: dc09e5ce6f04e5738d885028a740702c4b04edfd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1832422] [NEW] SSE CMP ops with 8bit immediate
 throw sigill with oversized byte
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
Reply-To: Bug 1832422 <1832422@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

The SSE comparison ops that use an 8bit immediate as a comparison type
selector throws a sigill when the immediate is oversized.

Test op that I found this on is here `66 0f c2 c0 d1          cmppd  xmm0,x=
mm0,0xd1`
According to the x86-64 documentation only bits [2:0] are used for these op=
s (and [4:0] for the AVX variant)
Currently qemu just checks if the value is >=3D8 and will throw a sigill in=
 that case. It instead needs to mask.

I have a small patch that fixes the issue for the SSE variant.

** Affects: qemu
     Importance: Undecided
         Status: New

** Patch added: "Fixes the bug"
   https://bugs.launchpad.net/bugs/1832422/+attachment/5270247/+files/compa=
re_ops.diff

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1832422

Title:
  SSE CMP ops with 8bit immediate throw sigill with oversized byte

Status in QEMU:
  New

Bug description:
  The SSE comparison ops that use an 8bit immediate as a comparison type
  selector throws a sigill when the immediate is oversized.

  Test op that I found this on is here `66 0f c2 c0 d1          cmppd  xmm0=
,xmm0,0xd1`
  According to the x86-64 documentation only bits [2:0] are used for these =
ops (and [4:0] for the AVX variant)
  Currently qemu just checks if the value is >=3D8 and will throw a sigill =
in that case. It instead needs to mask.

  I have a small patch that fixes the issue for the SSE variant.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1832422/+subscriptions


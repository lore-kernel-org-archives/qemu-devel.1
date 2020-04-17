Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54348C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 05:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20509221E9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 05:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BAovK896"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20509221E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPJDJ-0001tH-B0
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 01:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1jPJBy-0000gi-VY
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 01:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1jPJBx-0007SD-JU
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 01:05:30 -0400
Received: from ozlabs.org ([203.11.71.1]:34671)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1jPJBv-0007RE-Ln; Fri, 17 Apr 2020 01:05:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 493PDM0jHnz9sSk; Fri, 17 Apr 2020 15:05:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1587099923;
 bh=2OnDImsdpiCMfNcjIUi9npBTgcF2FbYCrCsFvsZlETs=;
 h=From:To:Cc:Subject:Date:From;
 b=BAovK896jvn+zc5VGunltTaoScvQooLsPzfpJxtklBC1TqgZjOrg5/FcaStLD7PAt
 KQvyGB+jf3lDKrALlYVvFNJIHTS+2c8VAVumIFRQ+qK8R1951qWbGMs5jnqO3qT+oA
 LsCM8TmeR5wedGmPukpXbBfHzFYiu+t4TNEoBfF8=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 0/3] ppc-for-5.0 queue 20200417
Date: Fri, 17 Apr 2020 15:05:11 +1000
Message-Id: <20200417050514.235060-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org, groug@kaod.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 20038cd7a8412feeb49c01f6ede89e36c89954=
72:

  Update version for v5.0.0-rc3 release (2020-04-15 20:51:54 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200417

for you to fetch changes up to 5ed195065cc6895f61b9d59bfa0a0536ed5ed51e:

  target/ppc: Fix mtmsr(d) L=3D1 variant that loses interrupts (2020-04-1=
7 10:39:03 +1000)

----------------------------------------------------------------
ppc patch queue for 2020-04-17

Here are a few late bugfixes for qemu-5.0 in the ppc target code.
Unless some really nasty last minute bug shows up, I expect this to be
the last ppc pull request for qemu-5.0.

----------------------------------------------------------------
Ganesh Goudar (1):
      target/ppc: Fix wrong interpretation of the disposition flag.

Nicholas Piggin (1):
      target/ppc: Fix mtmsr(d) L=3D1 variant that loses interrupts

Richard Henderson (1):
      linux-user/ppc: Fix padding in mcontext_t for ppc64

 linux-user/ppc/signal.c | 69 +++++++++++++++++++++----------------------=
------
 target/ppc/kvm.c        |  4 +--
 target/ppc/translate.c  | 46 +++++++++++++++++++--------------
 3 files changed, 58 insertions(+), 61 deletions(-)


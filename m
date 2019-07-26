Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7917AC41514
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C3F22BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C3F22BEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr48C-0004XO-Cc
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39508)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hr47v-0003i6-8Q
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hr47t-00058L-9T
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:35:30 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46989)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hr47t-00056P-0V
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:35:29 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mz9hF-1icpJj2ccN-00wFqo; Fri, 26 Jul 2019 19:35:12 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 19:35:01 +0200
Message-Id: <20190726173502.17172-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:stEgywvLq2Pm/VxPQE3BljAUuzOn+zTyRfiCFZDzdDMVZXGpqGy
 pvOhDExdZ03HTOLRjQ+MM1Vpd8+0bSr9ksvUz/5r/V4PtnCtkE3dCeSIhe0X7DzOtXS9bpy
 gLay3zU2WpXdE7exkXe5772jRysMHMAyu03M0HsEWuilLrbiYaQqnDvpiQJTJK/84Wbr3RO
 En7eaG19+EaeZn7ZnBh1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2pXHH5eivjQ=:8gaZ6IsG1GE8mXrkKpF1JM
 TjofvxByIF/BtCp4zg1EZWKmm1buvqO+cviybuSWW2rPtEWK5FKDMw+bqWFGQ3GmbUr539lBH
 tAD7BJifnPUuP/Clqw2fn2F+RiCIGuiqsMHmGOL0ZtFliMafXSVkPsk42X4/ND5gn8sfcH5KM
 gCC1QqlArgQxAJ59A+29DAPAtHngr0IaaYHrETLZUrq63LPtHznFfdTh9wt14RcQ4abeMbMbO
 CJ/4+fB8QOo68JXVhrRxD1nejkVVSe+xcEr/PYBnmuTiGw35zbGHYD3mHgumS2VdRzWtcnYmB
 KzOGYhEkm8RAQiKyEQCHT27CMgLIUTgwEANmy2Egvsy0sGhfGgHvNvd3ADWLXkw00Nab2EQzw
 +DZ0luwexFZoEEwdOk/85YaUNIaF+ObpTvaRaffqz9vJ/7UfaKDG4c5GfYaVtvStQHywZ+goh
 SBsqUVUeCYalp5c6coxRQnKjHrzz/1XW8a4ihf9vdqPIyaPTe6u563bj/tl0lfmiT/YCnS1MX
 69FTzDd7Wb9RdKjEvEj84XpGJSQ/ml8ms6Fd4Ew/Z0fM4H0qezdlhyDGzX8m1vyRGpQH8l9Jf
 9iUBJyGPNXZsvCFqXsqxwg5JyuGlHn3H1pZHFCv5OKymYHRV7tgN3F5n5Nupc+/gecPFqZj+y
 eRavM6GQ9uNjjbEf3WnzhLpH2qqgGKS40/wUBrkO/dnLCK+rHyHkf1teXsC0NYWqufExMGPap
 FxJq8Hbjs8248HQOlTOoaWxXXQFUnecnjvBG6Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 0/1] Linux user for 4.1 patches
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit fff3159900d2b95613a9cb75fc3703e67a674729:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20190726' into staging (2019-07-26 16:23:07 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request

for you to fetch changes up to 5bfce0b74fbd5d53089bb866919d685c47edad9e:

  linux-user: Make sigaltstack stacks per-thread (2019-07-26 19:24:33 +0200)

----------------------------------------------------------------
Fix multi-threaded go runtime crash

----------------------------------------------------------------

Peter Maydell (1):
  linux-user: Make sigaltstack stacks per-thread

 linux-user/hppa/signal.c   |  3 ++-
 linux-user/main.c          |  5 +++++
 linux-user/qemu.h          |  2 ++
 linux-user/signal-common.h |  1 -
 linux-user/signal.c        | 35 +++++++++++++++++++----------------
 5 files changed, 28 insertions(+), 18 deletions(-)

-- 
2.21.0



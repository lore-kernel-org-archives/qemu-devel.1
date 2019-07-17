Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F93C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FDC62173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDC62173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnlKz-0003Mg-Jf
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:55:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47934)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hnlKj-0002cZ-9B
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hnlKi-0000VY-CO
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:55:05 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60161)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hnlKi-0000Ts-2j
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:55:04 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhUDj-1iQeaM33Zb-00eZlb; Wed, 17 Jul 2019 16:54:38 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 16:54:15 +0200
Message-Id: <20190717145418.23883-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iJUMQWmn/IU+W3uizwrVdTgIfbJhN6jkXX8hV9D2L4xOianp89o
 SLMFuJ/2YI4n9xbB3ITeyywN8SZRZwB9eqqqbPC/7rE9um0v4L2BRhrud1638dHRvwxqyGX
 2SAIU6lqw6CnLInnuHDAgeGHMKRaDVqJVSRYowDSKJOxAlnMG7aNGaOFjGoTzXu0O0KunWz
 WCNVZk50OM8O+z/YfpO0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wKO8LhpXoEM=:saoikWuItXgJWSku06K+PJ
 X98vXRpeRU7OAIejHOhjf1Nnvb/Hhnqhgftoymjp0SgsPOn/IxgPofhz704nMuOQqZwbTwKYN
 ID9UgmQ3hfR+R9e0hSQZDslANNWzvl8RT9IZd9Ib1epAZePwL12Szp/ybDdYxZbUC8/pyeqwQ
 2T2VgC6r5KNFJXCOsyybuAF8uhehaChXy2XAeP5HWwPxZC5uW20CfqXkYrOKurMKdpWd/HAre
 z9Qtk/0RJrrQ6PzRqYoSUji22cK0F7elNhfo6UJJit/79WmI9Bmk3o2i4sl48W1f6l45i4/z8
 zGK7RE38QzpRQrJSXmTCS1jUKJdCE4NuaHmIlvVBQMEx1sQyepzNfd3UbD9GuJ03ufo1YmHB5
 s87ZB3iAU3ddg6YLJi7JZsTWq+KhDXSndPEQxDcq9FmyaXQH1HiRFI1UoNFvT6lbtk2UzKL9R
 BKZuCoW5qj6O4vMxhojuUDAXLfJPB9SBjxsBWQaaUzrnZWE6Eh5W3BMtpoRaLiDAdssoyaroi
 4uiuK4A1yboWCEwu3WXzoHJ9l72aR0k4kxxPIaJY90vxQwmCHqn/fgX/Kf5Hm0zGqojZseOP1
 rqagUPFXpzrikSl51G4WpsZTEJDzoCwcSdbj7OW2smFsrNP8iT7MdWhHTNbUZcRPNgkNp8tM8
 MWjmJ6OeWrlyNqVk28NLsxRetGC9c0BGG+RN6ZeyKnwEai68SsQyinFMTTC5EH9jOdu1wnhzc
 mVjlD/WnpBqEKuTN9yXn8qg7PeWKkFcHLboM+PySf45KH3pop9At7W3Q5Q4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL 0/3] Linux user for 4.1 patches
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a1a4d49f60d2b899620ee2be4ebb991c4a90a026:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/pflash-next-20190716' into staging (2019-07-16 17:02:44 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.1-pull-request

for you to fetch changes up to ad0bcf5d59f120d546be7a2c3590afc66eea0b01:

  linux-user: check valid address in access_ok() (2019-07-17 09:02:51 +0200)

----------------------------------------------------------------
fix access_ok() to allow to run LTP on AARCH64,
fix SIOCGSTAMP with 5.2 kernel headers,
fix structure target_ucontext for MIPS

----------------------------------------------------------------

Aleksandar Markovic (1):
  linux-user: Fix structure target_ucontext for MIPS

Daniel P. Berrangé (1):
  linux-user: fix to handle variably sized SIOCGSTAMP with new kernels

Rémi Denis-Courmont (1):
  linux-user: check valid address in access_ok()

 include/exec/cpu_ldst.h    |   4 ++
 linux-user/ioctls.h        |  11 ++-
 linux-user/mips/signal.c   |   5 +-
 linux-user/qemu.h          |   4 +-
 linux-user/syscall.c       | 140 +++++++++++++++++++++++++++++--------
 linux-user/syscall_defs.h  |  30 +++++++-
 linux-user/syscall_types.h |   6 --
 7 files changed, 158 insertions(+), 42 deletions(-)

-- 
2.21.0



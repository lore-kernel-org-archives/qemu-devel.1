Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD273C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7893421849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 08:07:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7893421849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoNvN-0007Wt-1S
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 04:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44574)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hoNul-0005F2-Lp
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hoNuk-0004an-Mh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:06:51 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56359)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hoNuk-0004ZR-EC
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 04:06:50 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MaHOX-1htUY107M5-00WDxt; Fri, 19 Jul 2019 10:06:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 10:06:07 +0200
Message-Id: <20190719080610.1607-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XQL9R2KuY6oW5tyo/jS10QVwixwYQtRO/1srz6YTH0lgagkTDg4
 yeCngXn3qvS3xKv10/GTpbwxIdcKKRLEyUS9RlN4l1tZ2TB7XTlLUgkqXa7hDdz+fL6TE8Y
 VWKxrunBPkmxaiDI/qPQN1wAcmpf5f2e6Sihq1AciEGLjM7RpPadwhXyy4pX6xAHIgCsOJZ
 czo6rdUf+zAzX+ookJzFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nZ4q4vsL4+4=:iFpIvblrH8hniGKpaKZcUG
 mRUXZdA7kthoWRZsmcBdqaPpVRcKinbmFMBMHHz084erb13hKosvW49oIC9n8qSSXzFmVUXsH
 I7CCFQClGMvDLCRJH80nPYdrwKjPHtpULhhBRq2DflvsGaB0SRb7gqjW7MKcDj6Ds8038Q/bH
 ZwP9gzWZGWIdRugAQ87t6DVy2L5JdwgM2j12eAt7L2WysnBCkuIehHCr0K5DG2+EiWU08w0ko
 aTqRcfaIj9KpLptR/3dAQeB490UKak991rrYHJD8n+JFdEQ+qZicL/Lyh7LeOZe2yxLOqPzZb
 YZVk7WawjhKP/IHOT9TcQBHOiihfRrV/QvSclGdLSa9DpkURDjn4wyl1HeiRVDe4zD/Kez5Ak
 sbLxQGW5LAiTU5zJlPKVRhirsr/c1wIqcbSILYWwZ92h12q3abf2bhJCEMqe+zP7P2U9hbj3X
 CLMIN8bSvVhZTSVMOKrX9VmKzEcDDf5AUFcgRCpT5ExNOWPJZeM/YCVzBfRROYNafGWCj4K5K
 2hMkhKLwpcieIqoq1mU3F0z6bTg4rSG0pl0sNVuAkZ4DNRmxIPOo2DMcdX8d66dSdJVBx9WQ+
 Km8Q3DVEI8uzUsV/CkNpn96W5sl0w1b4XmOFDR+t70BE8HxhaENIHFahnSzR2XYiI27fydtRd
 KyaQhYWny9R57VyLX3HQl7YbE0MfDfDRUfhWCVIgvxPZZwQUJ7S6riBkj5LQbntHiEeiS2MKQ
 0VGCQBsoxI8cnQE+dDH3pPTUvSk9IeeAFuVVFiPpkwy7Yi6xsFC1I3zKVfY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PULL v2 0/3] Linux user for 4.1 patches
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

for you to fetch changes up to 6d5d5dde9adb5acb32e6b8e3dfbf47fff0f308d2:

  linux-user: fix to handle variably sized SIOCGSTAMP with new kernels (2019-07-19 09:33:55 +0200)

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
 linux-user/ioctls.h        |  21 +++++-
 linux-user/mips/signal.c   |   5 +-
 linux-user/qemu.h          |   4 +-
 linux-user/syscall.c       | 140 +++++++++++++++++++++++++++++--------
 linux-user/syscall_defs.h  |  30 +++++++-
 linux-user/syscall_types.h |   6 --
 7 files changed, 168 insertions(+), 42 deletions(-)

-- 
2.21.0



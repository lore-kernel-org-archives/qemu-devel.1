Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492EFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A472067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 12:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A472067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSJ5Z-0000hr-Gf
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 08:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpy-0007mv-EV; Tue, 13 Oct 2020 07:51:26 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51917)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kSIpw-00050A-8s; Tue, 13 Oct 2020 07:51:26 -0400
Received: from localhost.localdomain ([82.252.141.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNtny-1kqYsw1Nnc-00OIj1; Tue, 13 Oct 2020 13:51:10 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/14] meson.build: drop duplicate 'sparc64' entry
Date: Tue, 13 Oct 2020 13:50:52 +0200
Message-Id: <20201013115052.133355-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201013115052.133355-1-laurent@vivier.eu>
References: <20201013115052.133355-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jBEdeiOklT/eZ0CDQWnCxpX1YMzRpDwu1r6q/zXsIQOBnj9OvJM
 zwLPhUCWGKS0rctwvfBDXpJC5up12co8CEaqRyyhrg9kbR06UvlekKPPggAeaQo6771gGnR
 DqM/pQzh/s0ssyW3ksG3tJIq1u3T1U+W+9JbePER3t9G2CY1O7LvovqTVOmuJV1IMe3RA0M
 bzngrhJksfIEMkQzAaZfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xOQSOvg/1Mo=:vGbXTggR2dxCf1UicioCo5
 WSKiyHy9ZxDWEnNRixS+9wVpStI0jrwzIZuqJmlXGPlU9MndbxyoMEtC13sNsjJr6uiVmIqN4
 v4B2sG9wCzLpkizhorZZ2kiOek1Mhf7UZV/d7wGvZ0qcxE23l0J22MggG6hykebd62wePlkKl
 r4XFhYfEtvqNckpMQnzH+T/uJRnvleDkph+656ZD+3hfNHH4x5vdsKiYvLHq3la8rCWABvcpU
 SXjcScBo5FUdlQ/s7wnLyiwwWYeGct+KKQ8V74H/KobrsTRAzTLqS1PRSYKCNnJ0oC0aQtxVD
 yPnl5wLIyEWMeCLmId0QiaL1EVJcjggid3uKOnDbH+Em8xqJ5B92A6MJc+TW0ASpHdHlNwmb4
 CMfmPBHIoF9qAlCGbEE82UguiGvGlDGsKUaRuIVtBIueS2H2Bvd9W4ONtfj9tK/QQS4Xp9q4F
 bpbvJqLtHh4Oy4HuUBmiGDS0IXs20BSr9v8RZ2EsfJjhuCrirXtFXRi9fNBcdF72w6IPEsVV1
 briL9//wdorT7K/cmh8iPTpLhN60HDBHKAdCCZaHftg7zALQE0JVCTUtzQQSkJfHLxSG8jHrC
 f/9tuBKMxs9e9WKMmAP283sUQFdMfoK2Zf4JWMmU8Fj+XK9OTSz4qFy1ZzyIqC6+degjmCREX
 w3GW07ELHzjJvOX4gRBsDEdEZlVV44ZdY1zhu/iNcrH81ax0HKttDASyvZR3edyHm/z7n07NT
 JY/2Z5u6JyFTGQvuFegRHrh3LND3e2km6yzJtQugqpxSu21trLnUofYotmoQEe6Zau6niTZyv
 63chwLv2mueDxv1wb3Bh+N5Ho6shAoVzejDSemg/uLjUoYCsUPLRVMv6HTu48hEosrfsPg9
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 07:50:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Sergei Trofimovich <slyfox@gentoo.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sergei Trofimovich <slyfox@gentoo.org>

CC: Laurent Vivier <laurent@vivier.eu>
CC: qemu-trivial@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
Message-Id: <20201012175719.2573367-1-slyfox@gentoo.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 17c89c87c626..392d326f4563 100644
--- a/meson.build
+++ b/meson.build
@@ -41,7 +41,7 @@ have_block = have_system or have_tools
 python = import('python').find_installation()
 
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
-supported_cpus = ['ppc', 'ppc64', 's390x', 'sparc64', 'riscv32', 'riscv64', 'x86', 'x86_64',
+supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
   'arm', 'aarch64', 'mips', 'mips64', 'sparc', 'sparc64']
 
 cpu = host_machine.cpu_family()
-- 
2.26.2



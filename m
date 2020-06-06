Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32442C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E04206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 13:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E04206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhYpw-0000Lz-9e
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 09:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYge-0007Pj-SO
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:37 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhYgc-0007gO-9c
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 09:16:36 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MI5Dj-1jmF710Zdv-00FDvN; Sat, 06 Jun 2020 15:16:24 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 19/19] stubs: Restrict ui/win32-kbd-hook to system-mode
Date: Sat,  6 Jun 2020 15:16:07 +0200
Message-Id: <20200606131607.1250819-20-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200606131607.1250819-1-laurent@vivier.eu>
References: <20200606131607.1250819-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wS+S35qY8gAcCYHVFOnRAhwEyvY3OgapuvLcioHH5CMpcAPmO6c
 OPGSXQjm4YliLtbUdSyzudVAfn1W7VGOJp8PwG9Q+gDgmbKtCSZTj2yQf+4og7zofbsefpR
 clJxHSxmrh9sNkL1EICF9fl35EDVARtetQ/4mMPpg4QUx0lWxjMuG+Pqk1VgrfTo8NHK4UD
 iFR8UW+6OLcuLlfP4aOfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L1o09oNNyvY=:oLy2d2WnWPw8Qaj6puCw56
 y4HlfnndiaQlgqjtFmMJIhbboKIogADapKFK6mgGZjO78HYkmvZIpz5tI6HsEcTjbGMKX4kiy
 an+KOno0iomszg/9Diajy4yuhWa949Pa79E9wLUyn+9/DGzMet1DtdZ12sMxKsCoFI5pWjikp
 k7zR0XJMHobv5UC/Cr+bTcrYjfAO1lLe8lz6YyMT631xrDKvnNeZRi/ZhLGqnfPWl/c3LcbMG
 WPNE4nlQ4BNlrB7LgU+dtqsxWXWF3ja9hLrHdhGMJDCT2SRtDjSxkrw1ZdY28cH5PqCHzUSI4
 PlWzPM+d6TzQBzGuwcSc3/f0NVEQihI30Qyf+37A+mzO5+JhPlAkWB0vc5bQNIIlx2/ep7cpJ
 m4fhdmYLQ8DLzmpcKR2zYleIopnkVNPlaHem3niyAzZ6mC/OLCpOdjkjA8QizFmP1iecGWVPG
 KXZhJFXiJZ6cHeLUbJHngHRop/qcFCOh5dB1g64AbqB0sHGe7g4CaBSfo+tt3G9Q7IM/oCllh
 cxezu7fnnLravbkA+wHTjGWOMezv/UncteRfPKLNSApnFrqrFIK8pRC/TBF2QeSgZmJ9H2av4
 8b8bO0wNl3t4XWfXS8aZAW8cRSKq34cVy7fQ5KOyrf5VJhd/VeMF1Zhm51C3Dcwy1LzqzSnPD
 hEd283UgyybpElIx/SGXcYAiMHLu5cyIQ6/t/PpNfsMm1sIQ182UFd3maByKtwmDBu0KFDGn5
 UjKlgfzpjcG5BK0sN721wxWFbZ5m1r4i3syvaweHWU1hd49W1/lxRQrnAz3FJvz0ZevMXHhRq
 jq6hRjW8F1gLpCUnNqrV2VDOT2P4PEj6bdgkUBeIJGF3zg35DFm2MTD29PJwFFhMbu8onWy
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 09:16:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In Makefile.objs, the ui/ directory is restricted to system-mode:

 43 ifeq ($(CONFIG_SOFTMMU),y)
 ...
 65 common-obj-y += ui/
 66 common-obj-m += ui/
 ...
 82 endif # CONFIG_SOFTMMU

Restrict the ui/ stub added in commit 2df9f5718df to only build
it for system-mode emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200522172510.25784-14-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 stubs/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index f54125de317d..c1e43ac68f87 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -23,7 +23,7 @@ stub-obj-y += sysbus.o
 stub-obj-y += tpm.o
 stub-obj-y += trace-control.o
 stub-obj-y += vmstate.o
-stub-obj-y += win32-kbd-hook.o
+stub-obj-$(CONFIG_SOFTMMU) += win32-kbd-hook.o
 
 #######################################################################
 # code used by both qemu system emulation and qemu-img
-- 
2.26.2



Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D84BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1F1206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1F1206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0Wq-0001lk-7O
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Us-0007nS-ED; Wed, 10 Jun 2020 09:10:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:41229)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Ur-0003fl-53; Wed, 10 Jun 2020 09:10:25 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MAORn-1jdFrC2iR1-00Bq4H; Wed, 10 Jun 2020 15:10:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 12/16] target/unicore32: Remove unused headers
Date: Wed, 10 Jun 2020 15:10:07 +0200
Message-Id: <20200610131011.1941209-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KV/GpuEv2bzha1VAakez780Yu3jaoa0j//7HSGHhHonv2vRVczK
 sz1U3qYeCvrI0s1eRnk9X9UGWmlWfHZMhgo9e3Nk9UO3NDAMWL+ix2j2apjlrGHVpsnRb6F
 9K70HzuymOvaNJyrz1sVOswnnOLzFU/WFoMs5j6DaSMCVhGT8DRtyIMoUBrzKGnem+hUPVF
 75gzg2poGKe10xSXiCqwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7HBki9U8hgI=:CcuABUDAoiqp8IezzFCLT+
 cy8HqOJ2NKfm1y0xebgmfbbFi3oybTtVKNMQqmzyg9+cuMmDqg9Ke2Ob2ouHPtseQBrQTCQ4O
 2Yy1LRFU5krjEMGzQbQhC06PsIu67qv1bbWn+GwVwZFpQvXKrCqzwuKpxvjzpswGHDpqA3CfB
 0lGrlIklD6rQueQmgHRQySiMkSXrlJn2sZzCE00meJ82HyCoZ7tYNzuOCIQpS4GfWYJATo87y
 f5W9HPXoSThOJIKZy02+tPXuzB+PZDmk1Kh5DpuOXppCfxtBASCbLe/UK2HvjCkFKY/tbmmtj
 RZii2BuaQp4KEmQ+/Q8H1YpWka1+9XaAzny26Y5Apjz6xu9GCOx466/C781Urfu8jQB+uLkkF
 GKQ0fJZcdybyO/Kaw3h649f8A6XikIHxqqcsHQm88d7QuTWN9u1tGP+HQcm2wdXDyEvSDxbOs
 YcYfsoumTUWK6CxSgemXcukZrFd3WKfBmEyPH4JQtFFBlNkaLJU32E95sjpeJ6ma0g9RTY3fD
 Bq8mbKJ+YNKovRzOBZkMDd9yluAuwTKqj/6KYdtAvpHS+JwpMdp1VGYevxfcpzpq+XngmrTk/
 T5k2Vi+RMztikNl0FIC2hz4vYQLAGJU7jD4AXJlev3xo5vSVwbfmLXYlSl6vVy9S4OJvp9J1O
 +NG6DSnYEJ7vhmY6sbPJvpplNDJvDOdWoD8WcEykiq27VLh2LRKZX+ek5nL/Kr7MIMm1Jrg6q
 BvfAO999dmgRLak9sxIPu/HCoBMHOh+3pe7CDyI/AKJBeYNAr5pJQrem6gQRNR0rS3O68a9pw
 q4utcaYgisNw9T3v1TsGbAmHgQmF6PWr+AEy8gFDSNbn0hay4iWSMjajwWSFtT5z9bZCL2m
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 08:14:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200603123754.19059-2-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/unicore32/helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/unicore32/helper.c b/target/unicore32/helper.c
index 7d538e2144dd..53292ae311c1 100644
--- a/target/unicore32/helper.c
+++ b/target/unicore32/helper.c
@@ -12,9 +12,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "exec/gdbstub.h"
 #include "exec/helper-proto.h"
-#include "qemu/host-utils.h"
 #ifndef CONFIG_USER_ONLY
 #include "ui/console.h"
 #endif
-- 
2.26.2


